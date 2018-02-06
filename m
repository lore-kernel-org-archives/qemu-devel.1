Received: from eggs.gnu.org ([2001:4830:134:3::10]:52200)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <w.bumiller@proxmox.com>) id 1ej0u5-0000vk-J1
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 05:55:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <w.bumiller@proxmox.com>) id 1ej0u1-0002EC-Mm
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 05:55:09 -0500
Received: from proxmox-new.maurer-it.com ([212.186.127.180]:19909)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <w.bumiller@proxmox.com>)
	id 1ej0u1-0002Ad-DP
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 05:55:05 -0500
Date: Tue, 6 Feb 2018 11:54:51 +0100
From: Wolfgang Bumiller <w.bumiller@proxmox.com>
Message-ID: <20180206105451.grddvo3fvk25gz5z@olga.proxmox.com>
References: <20180202111022.rtnvwmjs4r4jzttq@olga.proxmox.com>
	<20180205153140.GD28241@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180205153140.GD28241@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] rate limiting issues
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org

On Mon, Feb 05, 2018 at 03:31:40PM +0000, Stefan Hajnoczi wrote:
> On Fri, Feb 02, 2018 at 12:10:22PM +0100, Wolfgang Bumiller wrote:
(...)
> > Explanation:
> > The ratelimiting code in include/qemu/ratelimit.h currently uses slices with
> > quotas. Finishing up the quota for one slice means it'll wait for the end of
> > this _and_ the next slice before resetting the accounting and start over.
> > If that first slice was exceeded by only a tiny bit, we effectively spend every
> > second slice waiting around. before starting over.
(...)
> > typedef struct {
> >     int64_t last_time;
> >     uint64_t speed;
> >     int64_t allowed;
> > } RateLimit;
> > 
> > static inline int64_t ratelimit_calculate_delay(RateLimit *limit, uint64_t n)
> > {
(... wrong code)
> > }
> 
> This does not implement a rate limit, at least not in the way that users
> expect:
> 
> Imagine there is no activity for 24 hours.  We accumulate a huge number
> of allowed units and can exceed the rate limit for some time.

Indeed, I forgot that blockjobs can be paused, which affects both
versions.
So we need slices, but do they need to be aligned? Changing the current
code to not try align the waiting period with where a slice would start
also seems to work better...

---8<---
>From e50097e88a04eae0d1d40bed5fb940dc4baa835d Mon Sep 17 00:00:00 2001
From: Wolfgang Bumiller <w.bumiller@proxmox.com>
Date: Tue, 6 Feb 2018 11:34:34 +0100
Subject: [PATCH] ratelimit: don't align wait time with slices

It is possible for rate limited writes to keep overshooting a slice's
quota by a tiny amount causing the slice-aligned waiting period to
effectively halve the rate.

Signed-off-by: Wolfgang Bumiller <w.bumiller@proxmox.com>
---
 include/qemu/ratelimit.h | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/include/qemu/ratelimit.h b/include/qemu/ratelimit.h
index 8da1232574..01a5d535ec 100644
--- a/include/qemu/ratelimit.h
+++ b/include/qemu/ratelimit.h
@@ -35,7 +35,7 @@ typedef struct {
 static inline int64_t ratelimit_calculate_delay(RateLimit *limit, uint64_t n)
 {
     int64_t now = qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
-    uint64_t delay_slices;
+    double delay_slices;
 
     assert(limit->slice_quota && limit->slice_ns);
 
@@ -54,12 +54,11 @@ static inline int64_t ratelimit_calculate_delay(RateLimit *limit, uint64_t n)
         return 0;
     }
 
-    /* Quota exceeded. Calculate the next time slice we may start
-     * sending data again. */
-    delay_slices = (limit->dispatched + limit->slice_quota - 1) /
-        limit->slice_quota;
+    /* Quota exceeded. Wait based on the excess amount and then start a new
+     * slice. */
+    delay_slices = (double)limit->dispatched / limit->slice_quota;
     limit->slice_end_time = limit->slice_start_time +
-        delay_slices * limit->slice_ns;
+        (uint64_t)(delay_slices * limit->slice_ns);
     return limit->slice_end_time - now;
 }
 
-- 
2.11.0
