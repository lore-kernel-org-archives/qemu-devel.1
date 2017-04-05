Received: from eggs.gnu.org ([2001:4830:134:3::10]:35337)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cvlJJ-0000lV-TP
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 09:49:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cvlJF-0004FY-2g
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 09:49:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53422)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cvlJE-0004F7-TT
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 09:49:17 -0400
References: <20170405081209.26814-1-pbonzini@redhat.com>
	<10ed2863-e925-a0cc-46a2-52f752f37218@redhat.com>
	<d6c7f116-cc33-053e-17c6-fa277c4c17f7@redhat.com>
	<d54a867b-6d49-ee37-e182-431c1b611c7c@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5283fe25-9b12-eb71-8f55-6e2c30274eee@redhat.com>
Date: Wed, 5 Apr 2017 15:49:12 +0200
MIME-Version: 1.0
In-Reply-To: <d54a867b-6d49-ee37-e182-431c1b611c7c@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.9] tco: do not generate an NMI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org
Cc: Paulo Alcantara <pcacjr@gmail.com>, Paulo Alcantara <pcacjr@zytor.com>



On 05/04/2017 15:35, Laszlo Ersek wrote:
> Yes, I did track it back to SERR#/IOCHK#.
> 
> What wasn't obvious to me why the TCO watchdog couldn't activate SERR#.
> 
> I guess I missed the "SERR#" explanation in Table-2.6 "PCI Interface
> Signals", where it is described as
> 
>   System Error: SERR# can be pulsed active by any PCI device that
>   detects a system error condition. Upon sampling SERR# active, the
>   ICH9 has the ability to generate an NMI, SMI#, or interrupt.
> 
> ... Well, I still don't see why the watchdog cannot activate SERR#. Why
> can't it? :)

Because that's not what SERR# is for? :)  And especially because the
effect of a watchdog timeout is described elsewhere without including
SERR# in the picture.

>> so that the watchdog does reboot the machine), everything works without
>> ugly messages.
>
> Thanks for the explanation. I now wonder why Paulo decided to add the
> NMI in the first place -- was he too confused by the SERR# definition?

Both Paulo and Paolo were confused. :)

>>> (Idea taken from "Documentation/sysctl/kernel.txt", near "nmi_watchdog"
>>> -- "The NMI watchdog is disabled by default if the kernel is running as
>>> a guest in a KVM virtual machine.")
>>
>> The Linux NMI watchdog is something else, it is obtained by programming
>> a hardware performance counter on every processor.  On Linux,
>> performance counters raise NMIs.
> 
> Namely, for whatever reason it was wrong to raise an NMI in a KVM guest
> through those performance counters, the same reason would be enough to
> not raise an NMI through the iTCO_wdt driver either.

I think the reason is not that it's wrong; it's that by default KVM
guests do not have performance counters at all.

Paolo
