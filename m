Received: from eggs.gnu.org ([2001:4830:134:3::10]:44556)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1d2vll-0000bb-On
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 04:24:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1d2vlh-0003lp-Mq
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 04:24:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37600)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1d2vlh-0003lT-DB
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 04:24:17 -0400
Date: Tue, 25 Apr 2017 16:24:08 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170425082408.GB31709@pxdev.xzpeter.org>
References: <1492175840-5021-1-git-send-email-a.perevalov@samsung.com>
	<CGME20170414131740eucas1p27eba648b990a93a627265c740e7ff118@eucas1p2.samsung.com>
	<1492175840-5021-5-git-send-email-a.perevalov@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1492175840-5021-5-git-send-email-a.perevalov@samsung.com>
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

On Fri, Apr 14, 2017 at 04:17:18PM +0300, Alexey Perevalov wrote:

[...]

> +/*
> + * This function calculates downtime per cpu and trace it
> + *
> + *  Also it calculates total downtime as an interval's overlap,
> + *  for many vCPU.
> + *
> + *  The approach is following:
> + *  Initially intervals are represented in tree where key is
> + *  pagefault address, and values:
> + *   begin - page fault time
> + *   end   - page load time
> + *   cpus  - bit mask shows affected cpus
> + *
> + *  To calculate overlap on all cpus, intervals converted into
> + *  array of points in time (downtime_points), the size of
> + *  array is 2 * number of nodes in tree of intervals (2 array
> + *  elements per one in element of interval).
> + *  Each element is marked as end (E) or as start (S) of interval.
> + *  The overlap downtime will be calculated for SE, only in case
> + *  there is sequence S(0..N)E(M) for every vCPU.
> + *
> + * As example we have 3 CPU
> + *
> + *      S1        E1           S1               E1
> + * -----***********------------xxx***************------------------------> CPU1
> + *
> + *             S2                E2
> + * ------------****************xxx---------------------------------------> CPU2
> + *
> + *                         S3            E3
> + * ------------------------****xxx********-------------------------------> CPU3
> + *
> + * We have sequence S1,S2,E1,S3,S1,E2,E3,E1
> + * S2,E1 - doesn't match condition due to sequence S1,S2,E1 doesn't include CPU3
> + * S3,S1,E2 - sequenece includes all CPUs, in this case overlap will be S1,E2
> + * Legend of picture is following: * - means downtime per vCPU
> + *                                 x - means overlapped downtime
> + */

Not sure whether I get the point in this patch... iiuc we defined the
downtime here as the period when all vcpus are halted, right?

If so, I have a few questions:

- will this algorithm consume lots of memory? since I see we have one
  trace object per fault page address

- do we need to protect the tree to make sure there's no insertion
  when doing the calculation?

- if the only thing we want here is the "total downtime", whether
  below would work? (assuming N is vcpu numbers)

  a. define array cpu_fault_addr[N], to store current faulted address
     for each vcpu. When vcpu X is running, cpu_fault_addr[X] should
     be 0.

  b. when page fault happens on vcpu A, setup cpu_fault_addr[A] with
     corresponding fault address.

  c. when page copy finished, loop over cpu_fault_addr[] to see
     whether that matches any, clear corresponding element if matched.

  Then, we can just measure the period when cpu_fault_addr[] is all
  set (by tracing at both b. and c.). Can this work?

Thanks,

-- 
Peter Xu
