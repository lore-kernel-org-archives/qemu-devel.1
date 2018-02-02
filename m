Received: from eggs.gnu.org ([208.118.235.92]:46414)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <w.bumiller@proxmox.com>) id 1eheqF-0001oK-8H
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 12:10:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <w.bumiller@proxmox.com>) id 1ehep9-0007n7-Iy
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 12:09:33 -0500
Received: from proxmox-new.maurer-it.com ([212.186.127.180]:18011)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <w.bumiller@proxmox.com>)
	id 1ehep8-0007bS-Fc
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 12:08:27 -0500
Date: Fri, 2 Feb 2018 12:10:22 +0100
From: Wolfgang Bumiller <w.bumiller@proxmox.com>
Message-ID: <20180202111022.rtnvwmjs4r4jzttq@olga.proxmox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] rate limiting issues
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com

Summary:
Rate limit is effectively halved when the size of written chunks adds up to
exceeding the quota of a slice only slightly. This is surprisingly reliable.

Explanation:
The ratelimiting code in include/qemu/ratelimit.h currently uses slices with
quotas. Finishing up the quota for one slice means it'll wait for the end of
this _and_ the next slice before resetting the accounting and start over.
If that first slice was exceeded by only a tiny bit, we effectively spend every
second slice waiting around. before starting over.

Here if I use a limit of 30000KiB/s I get 30000KiB/s.
Increasing the limit to 30700KiB/s gives me 30700KiB/s.
Increasing it to 30720KiB/s reliably gives me 15000KiB/s.

Making it wait to the end of only the current slice means the excess data is not
counted at all and we may go above the limit (though by at most one write-chunk,
so I'm not sure if that's fine for most of the users, for backup jobs it seems
to be 64k always).

I'd like to fix this and am unsure about which way to go. On the one hand I
think the old code (before f14a39ccb922) may be fixable in a better way by not
resetting the accounting completely but subtracting the amount of data the
wait-period would have added.

At the same time, though, this could be simplified to not using slices but
always comparing the amount of actually written data to the amount of data
which should at most have been written.

Here are two approaches which seem to fix my issues:

--- Old code revised:

typedef struct {
    int64_t next_slice_time;
    uint64_t slice_quota;
    uint64_t slice_ns;
    int64_t dispatched;
} RateLimit;

static inline int64_t ratelimit_calculate_delay(RateLimit *limit, uint64_t n)
{
    int64_t now = qemu_clock_get_ns(QEMU_CLOCK_REALTIME);

    assert(limit->slice_quota && limit->slice_ns);

    if (limit->next_slice_time == 0) { /* first call */
        limit->dispatched = 0;
        limit->next_slice_time = now + limit->slice_ns;
        return 0;
    }

    if (limit->next_slice_time < now) {
        uint64_t passed_slices = DIV_ROUND_UP(now - limit->next_slice_time,
            limit->slice_ns);
        limit->next_slice_time = now + limit->slice_ns;
        limit->dispatched -= passed_slices * limit->slice_quota;
    }
    limit->dispatched += n;
    if (limit->dispatched+n <= limit->slice_quota) {
        return 0;
    }
    return limit->next_slice_time - now;
}

static inline void ratelimit_set_speed(RateLimit *limit, uint64_t speed,
                                       uint64_t slice_ns)
{
    limit->slice_ns = slice_ns;
    limit->slice_quota = MAX(((double)speed * slice_ns) / 1000000000ULL, 1);
}

---

And this is a short slice-less version. I wonder if there's any particular
reason for sticking to slices?

--- Version without slices:

typedef struct {
    int64_t last_time;
    uint64_t speed;
    int64_t allowed;
} RateLimit;

static inline int64_t ratelimit_calculate_delay(RateLimit *limit, uint64_t n)
{
    int64_t delta, now = qemu_clock_get_ns(QEMU_CLOCK_REALTIME);

    if (limit->last_time == 0) { /* first call */
        limit->allowed = -n;
        limit->last_time = now;
        return (n * 1000000000ULL) / limit->speed;
    }

    delta = (now - limit->last_time);
    limit->allowed += (delta * limit->speed)/1000000000ULL - n;
    limit->last_time = now;
    if (limit->allowed < 0) {
        return ((uint64_t)-limit->allowed * 1000000000ULL) / limit->speed;
    }
    return 0;
}

static inline void ratelimit_set_speed(RateLimit *limit, uint64_t speed,
                                       uint64_t slice_ns)
{
    (void)slice_ns; // TODO: remove
    limit->speed = speed;
}

---

Numerical note: a small delta means 'allowed' is incremented by 0, which
should be fine since when we hit the quota, we'll have a longer wait after
which the delta is for sure big enough to produce positive values.
(I tried larger and smaller values (1KiB/s to some MiB/s)).
Alternatively we could set last_time and do the quota increment
conditionally only when the delta is big enough, but I have not found
this to be necessary in my tests.
