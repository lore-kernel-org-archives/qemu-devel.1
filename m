Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0B1EC33C8C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 11:32:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A138D2072E
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 11:32:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="YnrsUegj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A138D2072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioQd0-00031A-IN
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 06:32:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33416)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <deller@gmx.de>) id 1ioQZA-0001vY-Rp
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 06:29:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <deller@gmx.de>) id 1ioQZ9-0007wj-5Q
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 06:29:00 -0500
Received: from mout.gmx.net ([212.227.17.22]:34303)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <deller@gmx.de>) id 1ioQZ8-0007uu-S7
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 06:28:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1578310132;
 bh=4EYg356QN5R2u1xqUE3cRs1u5Fs4X3VhLZDQrx86Qnc=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=YnrsUegjep9ZPVGR9SnHQPEipHBj6UpxZn7JM5nXTLvWAmIQArOwTTGVKAvjKK8TX
 F9HD0ypI/jnf2jB18MYJvFmh30rmcxN0+dXdFgRfPzDxofigDCtiOAgkrC4fxCserZ
 LaGaoD8aaFpIgbXAGXye8loAEkRmtq8Bk4XrbblU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.165.237]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MtOGU-1jiB3407e2-00usJ3; Mon, 06
 Jan 2020 12:28:52 +0100
Subject: Re: [PATCH v2] hppa: allow max ram size upto 4Gb
To: Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
References: <27c3e31d-82ae-e62f-caba-a0a3fbd55e7c@redhat.com>
 <1577987162-150529-1-git-send-email-imammedo@redhat.com>
 <2f226aa4-5f61-6e6d-d6b9-a98685a79e8c@gmx.de>
 <20200103105434.050d28ea@redhat.com>
 <6fa7bcd3-ee67-cc84-fd4e-d3677e3ae51a@redhat.com>
 <20200106114828.6bc96b23@redhat.com>
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
 c2TFWAS8k6RLkk41ZUU8ENX8+qZx/Q==
Message-ID: <8ef57947-dba6-9273-0b1e-7f0c052795da@gmx.de>
Date: Mon, 6 Jan 2020 12:28:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200106114828.6bc96b23@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LJtlKGH/2Zdc4FDA06roHNd5HGgTlEXIrYdQ5Iy+D5cIOn3OEVE
 3hSCfaWPx+/61iVTdg+hEE1IxDCswJTnS8pVKmm0tmVcki03by0PrMZV1aTZXMRw9TSuoDM
 jsx1kZhZlY6Ggt85Zmne5SiSPUoy5jrfItBX/8dgOrl8wehGgsD213sOscjAZYIm2cTxlRn
 WMswJGv/beUC3XhMgDWEg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/FsqGfT44Dg=:J50b8ltTutgoPt17PCOUXm
 owQQ9TD/ghQXXXJDlAu3v21ersHzVZkEmVTGXTmgq0wPlOS0dSMNAnBbPtdqC8JoY45gj5g+i
 rI7XmpRRzCgC03LU44GEB12nndd6m4O1VYTI/ntwGj0JrRD4dPtiqgLfplhopoI6KHlZC9sTv
 1ww2+86bkZR70Za6Zs09qLh0x55CdAC1cXJbsGODOQo9d4fwJvhh3cwKJGTBVmfRA7WUTMp2p
 aHz5LdwxGAV5N0fKy/QiCEDezyIP5TZ56xyirpX7FVAOBKD2QfwrFM41DAXulEEN0t4/XXqnx
 /Wxtk2M5zbDwunu2sL5e4UJ+tqF7M0aMkSSTmORVqa57yqEyddN+AmIT0AZqLRxN+Khr5sAUx
 sXFooLCZGe6zDnFletEAWxlsUZez0jaquFqjTsCy1JsHZwJk4mXYdOhucj+eK+LmpP4u757Zx
 1qU7PsZJJCcWVk7A+jb01gypp6HQb4M9EiSfsTjaX7vB9eN+pvyMgaqJMMVEHR5wVXxxy6cs6
 ForID86QS7WtEvz9UcThir/uDb8LhajAb96I74EQj2Z5CzQICdHe+lHLyVik26zdjcKFtvsFQ
 d8LF5cNzlvQrEhgMurnJ6dYQe538f0HeCh8O8c4TA/Kz1mRJCIQ3TcLlhCEmG5laMKIMRchHY
 VSbUjIkHDYUXHciZnXzXp3otBq16Fmhzc5PFP7SucKOe/5mQj/WsmSgHUXQt/4JFVy+7YpxU3
 cj5VaPoYZ5XCprHz+Qs2MG4UOs1qCQ3IJjwsjy9EoYsZG9zhWEvyvvNfnkO2uAtzpy9Y+oT8z
 jqNgkjvPu8iKQ8ne23gbvsqT9uSKnAqa5rBD1Bw/hfW5K15hkNmLIDWkwXc5uCM5YxfSFDRzm
 AtuKorveVTTgf3SD9LnNqK+sQtNxUjiLQeSU3sjf90RO2Z6CygNswfSXHHtfvKRell2BQckzp
 se3bTffIOn3T4Em9UVcjZ/WwDuZ8E4kbk/OKxDaS5rdaZzze7nVbn8p2KQWDMLr3eOfNwYdy4
 4kXp0UCsS+bkNkZyLM/YHWOOIhSDW/FEECQEg00O1+2KIG83YNZ/M5MEUeLkqNpilQX7w/NUD
 4lZ9/tSgKjI4ZpxAZ4ZDxj0uhlH99N7H0XTgR1Q7iug7aKPjT1fo0nOsIuuW3JrmVjh9T2nMq
 D8L47pMmHpYwOLHeeNxh2LwTBFHIAq9zj/Fnfvnr6m9ZGdKAXDytc5r1NEZ4VQyWvMBIMYK3Y
 KDaSd2uGKq1Lxx6L47fJwOffh0R7MKA2Hg1KI0Q==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.17.22
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Sven Schnelle <svens@stackframe.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 06.01.20 11:48, Igor Mammedov wrote:
> On Sat, 4 Jan 2020 16:00:19 +0100
> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:
>
>> On 1/3/20 10:54 AM, Igor Mammedov wrote:
>>> On Thu, 2 Jan 2020 21:22:12 +0100
>>> Helge Deller <deller@gmx.de> wrote:
>>>
>>>> On 02.01.20 18:46, Igor Mammedov wrote:
>>>>> Previous patch drops silent ram_size fixup and makes
>>>>> QEMU error out with:
>>>>>
>>>>>   "RAM size more than 3840m is not supported"
>>>>>
>>>>> when user specified -m X more than supported value.
>>>>>
>>>>> User shouldn't be bothered with starting QEMU with valid CLI,
>>>>> so for the sake of user convenience allow using -m 4G vs -m 3840M.
>>>>>
>>>>> Requested-by: Helge Deller <deller@gmx.de>
>>>>> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
>>>>> ---
>>>>> v2:
>>>>>    - make main ram -1 prio, so it wouldn't conflict with other regio=
ns
>>>>>      starting from 0xf9000000
>>>>>
>>>>> I dislike it but if you feel it's really necessary feel free to ack =
it.
>>
>> Hard to find the v2 buried in the other series with my email client.
>>
>>>>>
>>>>> should be applied on top of:
>>>>>    "hppa: drop RAM size fixup"
>>>>
>>>> Hello Igor,
>>>> I appreciate that you are trying to make it more cleaner.
>>>> But, can't you merge both of your patches to one patch?
>>>> Right now you have one patch "hppa: drop RAM size fixup", which is
>>>> what I think is wrong. Then you add another one which somehow
>>>> fixes it up again and adds other stuff.
>>> 1st patch bring it in line with other boards adding
>>> proper error check but without changing RAM size.
>>> While 2nd is changing device model (mapped RAM size) and
>>> clearly documents that it's a hack for user convenience,
>>> Hence I'd prefer to keep both separated.
>>>
>>>> Having everything in one single patch makes your full change more
>>>> understandable.
>>>>
>>>> Is it necessary to introduce clamped_ram_size and not continue with
>>>> ram_size (even if you would add it as static local variable)?
>>> it's necessary since ram_size is global which should be kept =3D=3D Ma=
chineState::ram_size.
>>> Later on I plan to remove the former altogether and maybe
>>> MachineState::ram_size aa well, since it could be read with
>>> memory_region_size(MachineState::ram).
>>
>> Why insist on clamping the ram? We recommend to model what the hardware
>> does, and the hardware uses a full DIMM of DRAM, so 4GB, not less.
> I'm not adding 4Gb support here (it's out of scope of this series),
> all this patch does is making pre-existing global ram_size fixup,
> this board only business and naming it clamped_ram_size to match
> its current usage

Ok.

> (along with explicitly documenting the deviation from
> other boards why it was requested to keep fixup 'for user convenience'
> instead of going for correct and simpler error message telling
> how much RAM user could specify on CLI).

No, here you are wrong.
This machine, same as all 32-bit x86 based machines, expect users
to insert memory modules of e.g. 1GB, 2GB and so on.
And ROM memory and other regions overlap the RAM in some regions
if required.
So, it's not "user convenience", but it's correct behaviour of the
code to simply allow 4GB and then don't blend in the memory which can't
be accessed.
Giving a error message that "you can only insert 3841MB" would be WRONG.

>> What are the new problem introduced by using 4GB? I only see advantages
>> doing so. This doesn't break your series. This doesn't break the CLI.
>> Am I missing something?
>
> Well, board was fixing up global ram_size and then used it to
>  - pass clamped value to guest via register
>  - pass it to load load_image_targphys()
>  - perform various checks
>  - affects reset sequence

... which is all OK, because it mimics the real hardware.

> This patch keeps all of that in the same state
> (I'd suspect changing above points, would break guest)

Yep (unless I change the SeaBIOS ROM code).

Anyway, I'm tired to discuss this.
Your patch isn't wrong by itself, I just think it's changing unnecessary
too much code and uses wrong wording for the commit message.
But just apply it as long as it doesn't break anything.

Helge

> If you have an alternative patch that enables to use full 4Gb,
> I'd include on respin as far as it doesn't change user supplied
> global ram_size && ms->ram_size && uses generic ms->ram &&
> preferably on top of
>  "[PATCH 44/86] hppa: use memdev for RAM"
> so it would be easier to drop it if there would opposition to it
> without affecting series.
>
>>>>> ---
>>>>>   hw/hppa/machine.c | 21 +++++++++++----------
>>>>>   1 file changed, 11 insertions(+), 10 deletions(-)
>>>>>
>>>>> diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
>>>>> index ebbf44f..0302983 100644
>>>>> --- a/hw/hppa/machine.c
>>>>> +++ b/hw/hppa/machine.c
>>>>> @@ -54,6 +54,7 @@ static uint64_t cpu_hppa_to_phys(void *opaque, uin=
t64_t addr)
>>>>>
>>>>>   static HPPACPU *cpu[HPPA_MAX_CPUS];
>>>>>   static uint64_t firmware_entry;
>>>>> +static ram_addr_t clamped_ram_size;
>>>>>
>>>>>   static void machine_hppa_init(MachineState *machine)
>>>>>   {
>>>>> @@ -74,8 +75,6 @@ static void machine_hppa_init(MachineState *machin=
e)
>>>>>       long i;
>>>>>       unsigned int smp_cpus =3D machine->smp.cpus;
>>>>>
>>>>> -    ram_size =3D machine->ram_size;
>>>>> -
>>>>>       /* Create CPUs.  */
>>>>>       for (i =3D 0; i < smp_cpus; i++) {
>>>>>           char *name =3D g_strdup_printf("cpu%ld-io-eir", i);
>>>>> @@ -90,12 +89,14 @@ static void machine_hppa_init(MachineState *mach=
ine)
>>>>>       }
>>>>>
>>>>>       /* Limit main memory. */
>>>>> -    if (ram_size > FIRMWARE_START) {
>>>>> -        error_report("RAM size more than %d is not supported", FIRM=
WARE_START);
>>>>> +    if (machine->ram_size > 4 * GiB) {
>>>>> +        error_report("RAM size more than 4Gb is not supported");
>>>>>           exit(EXIT_FAILURE);
>>>>>       }
>>>>> +    clamped_ram_size =3D machine->ram_size > FIRMWARE_START ?
>>>>> +        FIRMWARE_START : machine->ram_size;
>>>>>
>>>>> -    memory_region_add_subregion(addr_space, 0, machine->ram);
>>>>> +    memory_region_add_subregion_overlap(addr_space, 0, machine->ram=
, -1);
>>>>>
>>>>>       /* Init Dino (PCI host bus chip).  */
>>>>>       pci_bus =3D dino_init(addr_space, &rtc_irq, &serial_irq);
>>>>> @@ -151,7 +152,7 @@ static void machine_hppa_init(MachineState *mach=
ine)
>>>>>       qemu_log_mask(CPU_LOG_PAGE, "Firmware loaded at 0x%08" PRIx64
>>>>>                     "-0x%08" PRIx64 ", entry at 0x%08" PRIx64 ".\n",
>>>>>                     firmware_low, firmware_high, firmware_entry);
>>>>> -    if (firmware_low < ram_size || firmware_high >=3D FIRMWARE_END)=
 {
>>>>> +    if (firmware_low < clamped_ram_size || firmware_high >=3D FIRMW=
ARE_END) {
>>>>>           error_report("Firmware overlaps with memory or IO space");
>>>>>           exit(1);
>>>>>       }
>>>>> @@ -204,7 +205,7 @@ static void machine_hppa_init(MachineState *mach=
ine)
>>>>>                  (1) Due to sign-extension problems and PDC,
>>>>>                  put the initrd no higher than 1G.
>>>>>                  (2) Reserve 64k for stack.  */
>>>>> -            initrd_base =3D MIN(ram_size, 1 * GiB);
>>>>> +            initrd_base =3D MIN(clamped_ram_size, 1 * GiB);
>>>>>               initrd_base =3D initrd_base - 64 * KiB;
>>>>>               initrd_base =3D (initrd_base - initrd_size) & TARGET_P=
AGE_MASK;
>>>>>
>>>>> @@ -232,7 +233,7 @@ static void machine_hppa_init(MachineState *mach=
ine)
>>>>>        * various parameters in registers. After firmware initializat=
ion,
>>>>>        * firmware will start the Linux kernel with ramdisk and cmdli=
ne.
>>>>>        */
>>>>> -    cpu[0]->env.gr[26] =3D ram_size;
>>>>> +    cpu[0]->env.gr[26] =3D clamped_ram_size;
>>
>> Helge, is this the code using this register?
>>
>> https://github.com/hdeller/seabios-hppa/blob/parisc-qemu-5.0/src/parisc=
/head.S#L139
>>
>>>>>       cpu[0]->env.gr[25] =3D kernel_entry;
>>>>>
>>>>>       /* tell firmware how many SMP CPUs to present in inventory tab=
le */
>>>>> @@ -255,11 +256,11 @@ static void hppa_machine_reset(MachineState *m=
s)
>>>>>       }
>>>>>
>>>>>       /* already initialized by machine_hppa_init()? */
>>>>> -    if (cpu[0]->env.gr[26] =3D=3D ram_size) {
>>>>> +    if (cpu[0]->env.gr[26] =3D=3D clamped_ram_size) {
>>>>>           return;
>>>>>       }
>>>>>
>>>>> -    cpu[0]->env.gr[26] =3D ram_size;
>>>>> +    cpu[0]->env.gr[26] =3D clamped_ram_size;
>>>>>       cpu[0]->env.gr[25] =3D 0; /* no firmware boot menu */
>>>>>       cpu[0]->env.gr[24] =3D 'c';
>>>>>       /* gr22/gr23 unused, no initrd while reboot. */
>>>>>
>>>>
>>>
>>
>


