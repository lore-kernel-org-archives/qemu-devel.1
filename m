Received: from eggs.gnu.org ([2001:4830:134:3::10]:54651)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1cYY5Q-0004D3-82
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 08:03:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1cYY5L-0005gQ-IU
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 08:03:04 -0500
Received: from mail-vk0-f45.google.com ([209.85.213.45]:33028)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <lprosek@redhat.com>) id 1cYY5L-0005fu-Dt
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 08:02:59 -0500
Received: by mail-vk0-f45.google.com with SMTP id k127so235879252vke.0
	for <qemu-devel@nongnu.org>; Tue, 31 Jan 2017 05:02:58 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <d837afc4-86ec-4343-2293-00658ea8c93e@redhat.com>
References: <1484305370-6220-1-git-send-email-lprosek@redhat.com>
	<0343b5cd-f2b9-b439-7652-44ab5f05f0c4@redhat.com>
	<CABdb734ESPhd=354YHCs2AV_jiCj=NwiR-AU0TcWuv0XMDcCaQ@mail.gmail.com>
	<9d544d44-f41f-e691-ee73-54f9383a13e3@redhat.com>
	<CABdb735JeFpoXqE1A-V1ih7F3Tbg3KFgs69_ijeyeYf_bo+jBw@mail.gmail.com>
	<74186249-fee1-9917-2bf4-50aa240eb114@redhat.com>
	<CABdb736fzG4u6-tS_LeGAmsWMuao1pP2Z83qYazQQkeFrSxwoA@mail.gmail.com>
	<d837afc4-86ec-4343-2293-00658ea8c93e@redhat.com>
From: Ladi Prosek <lprosek@redhat.com>
Date: Tue, 31 Jan 2017 14:02:57 +0100
Message-ID: <CABdb7359YbhNUvHzLGBZDxseyS5XsCBx0tLO2m=AntaV=32G+g@mail.gmail.com>
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
Cc: qemu-block@nongnu.org, qemu-devel <qemu-devel@nongnu.org>, qemu-stable <qemu-stable@nongnu.org>

On Tue, Jan 31, 2017 at 1:56 PM, John Snow <jsnow@redhat.com> wrote:
>
>
> On 01/16/2017 02:49 AM, Ladi Prosek wrote:
>> On Fri, Jan 13, 2017 at 8:15 PM, John Snow <jsnow@redhat.com> wrote:
>>>
>>>
>>> On 01/13/2017 02:01 PM, Ladi Prosek wrote:
>>>> On Fri, Jan 13, 2017 at 7:31 PM, John Snow <jsnow@redhat.com> wrote:
>>>>>
>>>>>
>>>>> On 01/13/2017 01:12 PM, Ladi Prosek wrote:
>>>>>> On Fri, Jan 13, 2017 at 6:23 PM, John Snow <jsnow@redhat.com> wrote:
>>>>>>> On 01/13/2017 06:02 AM, Ladi Prosek wrote:
>>>>>>>> The AHCI emulation code supports 64-bit addressing and should advertise this
>>>>>>>> fact in the Host Capabilities register. Both Linux and Windows drivers test
>>>>>>>> this bit to decide if the upper 32 bits of various registers may be written
>>>>>>>> to, and at least some versions of Windows have a bug where DMA is attempted
>>>>>>>> with an address above 4GB but, in the absence of HOST_CAP_64, the upper 32
>>>>>>>> bits are left unititialized which leads to a memory corruption.
>>>>>>>>
>>>>>>>> Signed-off-by: Ladi Prosek <lprosek@redhat.com>
>>>>>>>> ---
>>>>>>>>  hw/ide/ahci.c | 2 +-
>>>>>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>>>
>>>>>>>> diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
>>>>>>>> index 3c19bda..6a17acf 100644
>>>>>>>> --- a/hw/ide/ahci.c
>>>>>>>> +++ b/hw/ide/ahci.c
>>>>>>>> @@ -488,7 +488,7 @@ static void ahci_reg_init(AHCIState *s)
>>>>>>>>      s->control_regs.cap = (s->ports - 1) |
>>>>>>>>                            (AHCI_NUM_COMMAND_SLOTS << 8) |
>>>>>>>>                            (AHCI_SUPPORTED_SPEED_GEN1 << AHCI_SUPPORTED_SPEED) |
>>>>>>>> -                          HOST_CAP_NCQ | HOST_CAP_AHCI;
>>>>>>>> +                          HOST_CAP_NCQ | HOST_CAP_AHCI | HOST_CAP_64;
>>>>>>>>
>>>>>>>>      s->control_regs.impl = (1 << s->ports) - 1;
>>>>>>>>
>>>>>>>>
>>>>>>>
>>>>>>> Was this tested? What was the use case that prompted this patch, and do
>>>>>>> you have a public bugzilla to point to?
>>>>>>
>>>>>> Sorry, I thought you were aware. Here's the BZ with details:
>>>>>> https://bugzilla.redhat.com/show_bug.cgi?id=1411105
>>>>>>
>>>>>
>>>>> It's for the public record :)
>>>>>
>>>>> I'm going to amend your commit message, OK?
>>>>>
>>>>> https://github.com/jnsnow/qemu/commit/f037be92fc0c4580b846134e0355a69d0eccd0d9
>>>>
>>>> Minor nit: the OS we know for sure is affected is Windows Server 2008,
>>>> without the "R2". Thanks!
>>>>
>>>
>>> I misunderstood. It looked like the initial report was for "SP2," though
>>> I see you saying that the R2 version actually worked okay, but by
>>> coincidence.
>>>
>>> I didn't think there *was* an "SP2," for Windows Server, so I
>>> interpreted that to mean R2.
>>>
>>> So this only manifests with vanilla 2008?
>>
>> We know it manifests on 2008 SP2, which is very different from 2008
>> R2. 2008 is the server variant of Vista, 2008 R2 is the server variant
>> of Win7 (yay for marketing names!)
>>
>> I believe that 2008 SP2 32-bit is the only OS where it's been confirmed so far.
>>
>
> Thanks for clearing that up for me, I re-edited the commit message
> upstream. If it looks OK, I'll likely merge this when I get back home
> after FOSDEM.

Looks good, thanks!

> --js
