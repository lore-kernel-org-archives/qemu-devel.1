Received: from eggs.gnu.org ([209.51.188.92]:55814)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1hG6SQ-0006kw-8y
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 14:35:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1hG6SO-0006Ze-Cy
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 14:35:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36676)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1hG6SN-0006Vb-QW
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 14:35:52 -0400
References: <839EC771-5973-4B05-BC76-D6CC5EE63A43@gmail.com>
	<20190415095400.GD29134@stefanha-x1.localdomain>
	<97D57A26-6DB4-45AA-BC68-27BBEDEEBE74@gmail.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <ca6e7733-9ed7-a332-887b-ac04bb28f54f@redhat.com>
Date: Mon, 15 Apr 2019 14:35:41 -0400
MIME-Version: 1.0
In-Reply-To: <97D57A26-6DB4-45AA-BC68-27BBEDEEBE74@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Booting from a Bootcamp partition
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Programmingkid <programmingkidx@gmail.com>, Stefan Hajnoczi <stefanha@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>



On 4/15/19 6:23 AM, Programmingkid wrote:
> 
>> On Apr 15, 2019, at 5:54 AM, Stefan Hajnoczi <stefanha@gmail.com> wrote:
>>
>> On Sun, Apr 14, 2019 at 07:33:17PM -0400, Programmingkid wrote:
>>> Hi I was wondering if anyone has been able to boot from a bootcamp partition inside of QEMU. I know this partition can be used in QEMU but my own attempts at booting Windows 7 on my bootcamp partition did not work. I always see "A disk read error occurred". Has anyone else been successful at this? 
>>
>> Hi,
>> It's difficult to help without more information:
>> 1. What is your QEMU command-line?
> 
> sudo qemu-system-x86_64 -name "Windows 7" -hda "/dev/disk0s4" -boot "c" -m 3000 
> 
>> 2. What is the partition table on the disk?
> 
> The bootcamp partition is this: /dev/disk0s4
> 

(Are you trying to boot a partition as an entire block device ...?)

>> General problems with booting Windows are usually caused by a guest
>> configuration that doesn't match the hardware configuration that Windows
>> was installed under.  Can you check that the AHCI bus address of the
>> disk and partition numbering matches what Windows expected?
> 
> How would someone do this?
> 
>> It may also be useful to enable tracing (see docs/devel/tracing.txt) to
>> see what the ahci_* trace event log says.  I have CCed John Snow, one of
>> the few people who can read this log :).
> 
> I'm guessing you believe the problem is the partition can't be read in QEMU. I know for sure it can. I attached this partition to another QEMU VM and was able to see it on the Desktop. 
>

Well, we don't know what the problem is. From the command line above it
looks like it'd be using the legacy IDE emulation instead of the newer
SATA emulation, though. I'd wager that the Windows boot loader here is
not expecting to use IDE.

"disk read error" could mean a lot of things from the POV of a guest,
but having disk emulation tracing would show us what the guest is trying
to do, at least.

> My guess is the computer is using an EFI firmware and QEMU uses the traditional BIOS firmware (SeaBIOS).  So I think trying UEFI in QEMU might work.
> 

Try using -M q35 which will engage SATA and AHCI emulation, and try
using UEFI, yes.
