Received: from eggs.gnu.org ([2001:4830:134:3::10]:34400)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jitendra.kolhe@hpe.com>) id 1cZDoK-0002pn-Hl
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 04:36:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jitendra.kolhe@hpe.com>) id 1cZDoF-0003jd-MF
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 04:36:12 -0500
Received: from g4t3427.houston.hpe.com ([15.241.140.73]:8535)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jitendra.kolhe@hpe.com>)
	id 1cZDoF-0003g5-HB
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 04:36:07 -0500
References: <1483601042-6435-1-git-send-email-jitendra.kolhe@hpe.com>
	<20170127132650.GA31231@redhat.com>
From: Jitendra Kolhe <jitendra.kolhe@hpe.com>
Message-ID: <67bd733e-5974-327b-25f4-c83b8e379313@hpe.com>
Date: Thu, 2 Feb 2017 15:05:54 +0530
MIME-Version: 1.0
In-Reply-To: <20170127132650.GA31231@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC] mem-prealloc: Reduce large guest
 start-up and migration time.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "kwolf@redhat.com" <kwolf@redhat.com>, "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "armbru@redhat.com" <armbru@redhat.com>, "MeenakshiSundaram, Renganathan" <renganathan.meenakshisundaram@hpe.com>, "Parthasarathy, Mohan (HPE Servers)" <mohan_parthasarathy@hpe.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>

On 1/27/2017 6:56 PM, Daniel P. Berrange wrote:
> On Thu, Jan 05, 2017 at 12:54:02PM +0530, Jitendra Kolhe wrote:
>> Using "-mem-prealloc" option for a very large guest leads to huge guest
>> start-up and migration time. This is because with "-mem-prealloc" option
>> qemu tries to map every guest page (create address translations), and
>> make sure the pages are available during runtime. virsh/libvirt by
>> default, seems to use "-mem-prealloc" option in case the guest is
>> configured to use huge pages. The patch tries to map all guest pages
>> simultaneously by spawning multiple threads. Given the problem is more
>> prominent for large guests, the patch limits the changes to the guests
>> of at-least 64GB of memory size. Currently limiting the change to QEMU
>> library functions on POSIX compliant host only, as we are not sure if
>> the problem exists on win32. Below are some stats with "-mem-prealloc"
>> option for guest configured to use huge pages.
>>
>> ------------------------------------------------------------------------
>> Idle Guest      | Start-up time | Migration time
>> ------------------------------------------------------------------------
>> Guest stats with 2M HugePage usage - single threaded (existing code)
>> ------------------------------------------------------------------------
>> 64 Core - 4TB   | 54m11.796s    | 75m43.843s
>> 64 Core - 1TB   | 8m56.576s     | 14m29.049s
>> 64 Core - 256GB | 2m11.245s     | 3m26.598s
>> ------------------------------------------------------------------------
>> Guest stats with 2M HugePage usage - map guest pages using 8 threads
>> ------------------------------------------------------------------------
>> 64 Core - 4TB   | 5m1.027s      | 34m10.565s
>> 64 Core - 1TB   | 1m10.366s     | 8m28.188s
>> 64 Core - 256GB | 0m19.040s     | 2m10.148s
>> -----------------------------------------------------------------------
>> Guest stats with 2M HugePage usage - map guest pages using 16 threads
>> -----------------------------------------------------------------------
>> 64 Core - 4TB   | 1m58.970s     | 31m43.400s
>> 64 Core - 1TB   | 0m39.885s     | 7m55.289s
>> 64 Core - 256GB | 0m11.960s     | 2m0.135s
>> -----------------------------------------------------------------------
> 
> For comparison, what is performance like if you replace memset() in
> the current code with a call to mlock().
> 

It doesn't look like we get much benefit by replacing memset() for loop, 
with a single instance of mlock(). Here are some numbers from my system.

#hugepages    | memset 	    | memset      | memset 	| mlock (entire range)
(2M size)     | (1 thread)  | (8 threads) | (16 threads)| (1 thread)
--------------|-------------|-------------|-------------|--------------------
1048576 (2TB) |	1790661 ms  | 105577 ms   | 37331 ms    | 1789580 ms
524288 (1TB)  |	 895119 ms  | 52795 ms	  | 18686 ms	| 894199 ms
131072 (256G) |	 173081 ms  | 9337 ms	  | 4667 ms	| 172506 ms
-----------------------------------------------------------------------------

> IIUC, huge pages are non-swappable once allocated, so it feels like
> we ought to be able to just call mlock() to preallocate them with
> no downside, rather than spawning many threads to memset() them.
> 

yes, for me too it looks like mlock() should do the job in case of
hugepages.

> Of course you'd still need the memset() trick if qemu was given
> non-hugepages in combination with --mem-prealloc, as you don't
> want to lock normal pages into ram permanently.
> 

given above numbers, I think we can stick to memset() implementation for
both hugepage and non-hugepage cases?

Thanks,
- Jitendra

> Regards,
> Daniel
> 
