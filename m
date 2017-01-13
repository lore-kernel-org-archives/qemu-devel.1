Received: from eggs.gnu.org ([2001:4830:134:3::10]:48266)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1cS6Ky-0001dR-JU
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 13:12:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1cS6Kt-0008D3-FC
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 13:12:28 -0500
Received: from mail-ua0-f178.google.com ([209.85.217.178]:32816)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <lprosek@redhat.com>) id 1cS6Kt-0008Cc-Ak
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 13:12:23 -0500
Received: by mail-ua0-f178.google.com with SMTP id i68so42439680uad.0
	for <qemu-devel@nongnu.org>; Fri, 13 Jan 2017 10:12:23 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <0343b5cd-f2b9-b439-7652-44ab5f05f0c4@redhat.com>
References: <1484305370-6220-1-git-send-email-lprosek@redhat.com>
	<0343b5cd-f2b9-b439-7652-44ab5f05f0c4@redhat.com>
From: Ladi Prosek <lprosek@redhat.com>
Date: Fri, 13 Jan 2017 19:12:21 +0100
Message-ID: <CABdb734ESPhd=354YHCs2AV_jiCj=NwiR-AU0TcWuv0XMDcCaQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH] ahci: advertise HOST_CAP_64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel <qemu-devel@nongnu.org>

On Fri, Jan 13, 2017 at 6:23 PM, John Snow <jsnow@redhat.com> wrote:
> On 01/13/2017 06:02 AM, Ladi Prosek wrote:
>> The AHCI emulation code supports 64-bit addressing and should advertise this
>> fact in the Host Capabilities register. Both Linux and Windows drivers test
>> this bit to decide if the upper 32 bits of various registers may be written
>> to, and at least some versions of Windows have a bug where DMA is attempted
>> with an address above 4GB but, in the absence of HOST_CAP_64, the upper 32
>> bits are left unititialized which leads to a memory corruption.
>>
>> Signed-off-by: Ladi Prosek <lprosek@redhat.com>
>> ---
>>  hw/ide/ahci.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
>> index 3c19bda..6a17acf 100644
>> --- a/hw/ide/ahci.c
>> +++ b/hw/ide/ahci.c
>> @@ -488,7 +488,7 @@ static void ahci_reg_init(AHCIState *s)
>>      s->control_regs.cap = (s->ports - 1) |
>>                            (AHCI_NUM_COMMAND_SLOTS << 8) |
>>                            (AHCI_SUPPORTED_SPEED_GEN1 << AHCI_SUPPORTED_SPEED) |
>> -                          HOST_CAP_NCQ | HOST_CAP_AHCI;
>> +                          HOST_CAP_NCQ | HOST_CAP_AHCI | HOST_CAP_64;
>>
>>      s->control_regs.impl = (1 << s->ports) - 1;
>>
>>
>
> Was this tested? What was the use case that prompted this patch, and do
> you have a public bugzilla to point to?

Sorry, I thought you were aware. Here's the BZ with details:
https://bugzilla.redhat.com/show_bug.cgi?id=1411105

In short, Windows guests run into issues in certain virtual HW
configurations if the bit is not set. I have tested the patch and
verified that it fixes the failing cases.

> It looks correct via the spec, thank you for finding this oversight. It
> looks like everywhere this bit would make a difference we already do the
> correct thing for having this bit set.
>
> From what I can gather from the spec, it looks as if even 32bit guests
> must ensure that the upper 32bit registers are cleared, so I think we're
> all set here.
>
> Reviewed-by: John Snow <jsnow@redhat.com>
