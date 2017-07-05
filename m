Received: from eggs.gnu.org ([2001:4830:134:3::10]:36644)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1dSnZy-0005li-IL
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 12:55:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1dSnZu-0002Wx-FO
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 12:55:06 -0400
Received: from mail-it0-x241.google.com ([2607:f8b0:4001:c0b::241]:35361)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1dSnZu-0002WC-At
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 12:55:02 -0400
Received: by mail-it0-x241.google.com with SMTP id v193so14717077itc.2
	for <qemu-devel@nongnu.org>; Wed, 05 Jul 2017 09:55:00 -0700 (PDT)
In-Reply-To: <mailman.82700.1499272965.22738.qemu-devel@nongnu.org>
References: <mailman.82700.1499272965.22738.qemu-devel@nongnu.org>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <827A3300-6D8E-488C-94CD-917738990CAD@gmail.com>
Content-Transfer-Encoding: 7bit
From: G 3 <programmingkidx@gmail.com>
Date: Wed, 5 Jul 2017 12:54:53 -0400
Subject: Re: [Qemu-devel] qemu_system_reset_request() broken w.r.t BQL
 locking regime
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Benn?e <alex.bennee@linaro.org>
Cc: "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, "rth@twiddle.net Henderson" <rth@twiddle.net>, Peter Maydell <peter.maydell@linaro.org>, =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <f4bug@amsat.org>, maciej.borzecki@open-rnd.pl


On Jul 5, 2017, at 12:42 PM, qemu-devel-request@nongnu.org wrote:
>
> Hi,
>
> An interesting bug was reported on #qemu today. It was bisected to
> 8d04fb55 (drop global lock for TCG) and only occurred when QEMU was  
> run
> with taskset -c 0. Originally the fingers where pointed at mttcg  
> but it
> occurs in both single and multi-threaded modes.
>
> I think the problem is qemu_system_reset_request() is certainly racy
> when resetting a running CPU. AFAICT:
>
>   - Guest resets board, writing to some hw address (e.g.
>     arm_sysctl_write)
>   - This triggers qemu_system_reset_request 
> (SHUTDOWN_CAUSE_GUEST_RESET)
>   - We exit iowrite and drop the BQL
>   - vl.c schedules qemu_system_reset- 
> >qemu_devices_reset...arm_cpu_reset
>   - we start writing new values to CPU env while still in TCG code
>   - CHAOS!
>
> The general solution for this is to ensure these sort of tasks are  
> done
> with safe work in the CPUs context when we know nothing else is  
> running.
> It seems this is probably best done by modifying
> qemu_system_reset_request to queue work up on current_cpu and  
> execute it
> as safe work - I don't think the vl.c thread should ever be messing
> about with calling cpu_reset directly.

Maybe vl.c should be changed so it registers a request to reset the  
emulator instead.

So instead of cpu_reset()

we do

request_cpu_reset()

>
> Looking at the calls most of these are made by device code but I  
> see KVM
> also does it. I just wanted to check this was a reasonable approach  
> and
> wouldn't upset anything else.
>
> Any thoughts?

I think the problem with the QEMU monitor command "stop" (which  
causes the emulator to crash) is related to this issue as well.
