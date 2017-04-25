Received: from eggs.gnu.org ([2001:4830:134:3::10]:48037)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1d2xfI-0004sS-0b
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 06:25:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1d2xfE-0003T3-Np
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 06:25:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39646)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1d2xfE-0003SR-Eg
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 06:25:44 -0400
Date: Tue, 25 Apr 2017 18:25:37 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170425102537.GD31709@pxdev.xzpeter.org>
References: <1492175840-5021-1-git-send-email-a.perevalov@samsung.com>
	<CGME20170414131740eucas1p27eba648b990a93a627265c740e7ff118@eucas1p2.samsung.com>
	<1492175840-5021-5-git-send-email-a.perevalov@samsung.com>
	<20170425082408.GB31709@pxdev.xzpeter.org>
	<234489b0-d33b-9a49-ec17-b1a6823d4eb3@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <234489b0-d33b-9a49-ec17-b1a6823d4eb3@samsung.com>
Subject: Re: [Qemu-devel] [PATCH 4/6] migration: calculate downtime on dst
 side
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Perevalov <a.perevalov@samsung.com>
Cc: dgilbert@redhat.com, qemu-devel@nongnu.org, i.maximets@samsung.com

On Tue, Apr 25, 2017 at 01:10:30PM +0300, Alexey Perevalov wrote:
> On 04/25/2017 11:24 AM, Peter Xu wrote:
> >On Fri, Apr 14, 2017 at 04:17:18PM +0300, Alexey Perevalov wrote:
> >
> >[...]
> >
> >>+/*
> >>+ * This function calculates downtime per cpu and trace it
> >>+ *
> >>+ *  Also it calculates total downtime as an interval's overlap,
> >>+ *  for many vCPU.
> >>+ *
> >>+ *  The approach is following:
> >>+ *  Initially intervals are represented in tree where key is
> >>+ *  pagefault address, and values:
> >>+ *   begin - page fault time
> >>+ *   end   - page load time
> >>+ *   cpus  - bit mask shows affected cpus
> >>+ *
> >>+ *  To calculate overlap on all cpus, intervals converted into
> >>+ *  array of points in time (downtime_points), the size of
> >>+ *  array is 2 * number of nodes in tree of intervals (2 array
> >>+ *  elements per one in element of interval).
> >>+ *  Each element is marked as end (E) or as start (S) of interval.
> >>+ *  The overlap downtime will be calculated for SE, only in case
> >>+ *  there is sequence S(0..N)E(M) for every vCPU.
> >>+ *
> >>+ * As example we have 3 CPU
> >>+ *
> >>+ *      S1        E1           S1               E1
> >>+ * -----***********------------xxx***************------------------------> CPU1
> >>+ *
> >>+ *             S2                E2
> >>+ * ------------****************xxx---------------------------------------> CPU2
> >>+ *
> >>+ *                         S3            E3
> >>+ * ------------------------****xxx********-------------------------------> CPU3
> >>+ *
> >>+ * We have sequence S1,S2,E1,S3,S1,E2,E3,E1
> >>+ * S2,E1 - doesn't match condition due to sequence S1,S2,E1 doesn't include CPU3
> >>+ * S3,S1,E2 - sequenece includes all CPUs, in this case overlap will be S1,E2
> >>+ * Legend of picture is following: * - means downtime per vCPU
> >>+ *                                 x - means overlapped downtime
> >>+ */
> >Not sure whether I get the point in this patch... iiuc we defined the
> >downtime here as the period when all vcpus are halted, right?
> >
> >If so, I have a few questions:
> >
> >- will this algorithm consume lots of memory? since I see we have one
> >   trace object per fault page address
> I don't think, it consumes too much, one DowntimeDuration
> takes (if I'm using bitmap_try_new, in this patch set I used pointer to
> uint64_t array to keep bitmap array,
> but I'm going to use include/qemu/bitmap.h, it works with pointers to long)
> 
> (2* int64 + (ROUND_UP((smp_cpus + BITS_PER_BYTE * sizeof(long) - 1 /
> (BITS_PER_BYTE * sizeof(long)))) * siezof(long)
> so it's about 16 + at least 4 bytes, per page fault,
> Lets assume we migration 256 vCPU and 256 Gb of ram and that ram is based on
> 4Kb pages - it's really bad case
> 16 + ((256 + 8 * 4 - 1) / ( 8 * 4 )) * 4 = 52 bytes
> (256 * 1024 * 1024 * 1024)/(4 * 1024) = 67108864 page faults, but not all of
> these pages will be pagefaulted, due to
> page pre-fetching
> 67108864 * 52 = 3489660928 bytes (3.5 Gb for that operation),
> but I have a doubt, who will use 4Kb pages for 256 Gb, probably
> 2Mb or 1G huge page will be chosen on x86, on ARM or other architecture it
> could be another values.

Hmm, it looks still big though...

> 
> >
> >- do we need to protect the tree to make sure there's no insertion
> >   when doing the calculation?
> I asked the same question when sent RFC patches,
> the answer here is no, we should not, due to right now,
> it's only one socket and one listen thread (maybe in future,
> it will be required, maybe after multi fd patch set),
> and calculation is doing synchronously right after migration complete.

Okay.

> 
> >
> >- if the only thing we want here is the "total downtime", whether
> >   below would work? (assuming N is vcpu numbers)
> >
> >   a. define array cpu_fault_addr[N], to store current faulted address
> >      for each vcpu. When vcpu X is running, cpu_fault_addr[X] should
> >      be 0.
> >
> >   b. when page fault happens on vcpu A, setup cpu_fault_addr[A] with
> >      corresponding fault address.
> at this time need to is fault happens for all another vCPU,
> and if it happens mark current time as total vCPU downtime start.
> 
> >   c. when page copy finished, loop over cpu_fault_addr[] to see
> >      whether that matches any, clear corresponding element if matched.
> so when page copy finished and mark for total vCPU is set,
> yes that interval is a part of total downtime.
> >
> >   Then, we can just measure the period when cpu_fault_addr[] is all
> >   set (by tracing at both b. and c.). Can this work?
> Yes, it works, but it's better to keep time - cpu_fault_time,
> address is not important here, it doesn't matter the reason of pagefault.

We still need the addresses? So that when we do COPY, we can check the
new page address against these stored ones, to know which vcpus to
clear the bit.

> 2 vCPU could fault due to access to one page, ok, it's not a problem, just
> store
> time when it was faulted.
> Looks like it's better algorithm, with lesser complexity,
> thank you a lot.

My pleasure. Thanks,

-- 
Peter Xu
