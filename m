Received: from eggs.gnu.org ([2001:4830:134:3::10]:48290)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cX62G-000279-PA
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 07:53:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cX62D-0003zl-Nu
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 07:53:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49608)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1cX62D-0003xw-F1
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 07:53:45 -0500
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <1483601042-6435-1-git-send-email-jitendra.kolhe@hpe.com>
	(Jitendra Kolhe's message of "Thu, 5 Jan 2017 12:54:02 +0530")
References: <1483601042-6435-1-git-send-email-jitendra.kolhe@hpe.com>
Reply-To: quintela@redhat.com
Date: Fri, 27 Jan 2017 13:53:34 +0100
Message-ID: <87mvec3bqp.fsf@emacs.mitica>
MIME-Version: 1.0
Content-Type: text/plain
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
To: Jitendra Kolhe <jitendra.kolhe@hpe.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, peter.maydell@linaro.org, armbru@redhat.com, renganathan.meenakshisundaram@hpe.com, mohan_parthasarathy@hpe.com, pbonzini@redhat.com

Jitendra Kolhe <jitendra.kolhe@hpe.com> wrote:
> Using "-mem-prealloc" option for a very large guest leads to huge guest
> start-up and migration time. This is because with "-mem-prealloc" option
> qemu tries to map every guest page (create address translations), and
> make sure the pages are available during runtime. virsh/libvirt by
> default, seems to use "-mem-prealloc" option in case the guest is
> configured to use huge pages. The patch tries to map all guest pages
> simultaneously by spawning multiple threads. Given the problem is more
> prominent for large guests, the patch limits the changes to the guests
> of at-least 64GB of memory size. Currently limiting the change to QEMU
> library functions on POSIX compliant host only, as we are not sure if
> the problem exists on win32. Below are some stats with "-mem-prealloc"
> option for guest configured to use huge pages.
>
> ------------------------------------------------------------------------
> Idle Guest      | Start-up time | Migration time
> ------------------------------------------------------------------------
> Guest stats with 2M HugePage usage - single threaded (existing code)
> ------------------------------------------------------------------------
> 64 Core - 4TB   | 54m11.796s    | 75m43.843s
                    ^^^^^^^^^^

> 64 Core - 1TB   | 8m56.576s     | 14m29.049s
> 64 Core - 256GB | 2m11.245s     | 3m26.598s
> ------------------------------------------------------------------------
> Guest stats with 2M HugePage usage - map guest pages using 8 threads
> ------------------------------------------------------------------------
> 64 Core - 4TB   | 5m1.027s      | 34m10.565s
> 64 Core - 1TB   | 1m10.366s     | 8m28.188s
> 64 Core - 256GB | 0m19.040s     | 2m10.148s
> -----------------------------------------------------------------------
> Guest stats with 2M HugePage usage - map guest pages using 16 threads
> -----------------------------------------------------------------------
> 64 Core - 4TB   | 1m58.970s     | 31m43.400s
                    ^^^^^^^^^

Impressive, not everyday one get an speedup of 20 O:-)


> +static void *do_touch_pages(void *arg)
> +{
> +    PageRange *range = (PageRange *)arg;
> +    char *start_addr = range->addr;
> +    uint64_t numpages = range->numpages;
> +    uint64_t hpagesize = range->hpagesize;
> +    uint64_t i = 0;
> +
> +    for (i = 0; i < numpages; i++) {
> +        memset(start_addr + (hpagesize * i), 0, 1);

I would use the range->addr and similar here directly, but it is just a
question of taste.

> -        /* MAP_POPULATE silently ignores failures */
> -        for (i = 0; i < numpages; i++) {
> -            memset(area + (hpagesize * i), 0, 1);
> +        /* touch pages simultaneously for memory >= 64G */
> +        if (memory < (1ULL << 36)) {

64GB guest already took quite a bit of time, I think I would put it
always as min(num_vcpus, 16).  So, we always execute the multiple theard
codepath?

But very nice, thanks.

Later, Juan.
