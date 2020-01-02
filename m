Return-Path: <SRS0=Q/S9=2X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67B38C2D0DC
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2020 15:49:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1752822525
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2020 15:49:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UUbE9+wA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1752822525
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42278 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1in2jN-0002bN-4Q
	for qemu-devel@archiver.kernel.org; Thu, 02 Jan 2020 10:49:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52872)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1in2ik-00027B-1z
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 10:49:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1in2ii-0001CI-7b
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 10:49:09 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:54688
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1in2ii-0001BU-3u
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 10:49:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577980146;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RA78k3UtEro1H4o5zR7wuPxkvdrBYSgc9dudd272EAE=;
 b=UUbE9+wAx8BC+ECT3HjngTzJz5q/jMSg/YZNjb70xpC7FtepzpnenQKzAFmPvx8IqYm5Pq
 qPohH9Db4ZleKLmjnapdPy0S+iDx440Np1a41wsMTumfcB/kV1ugc26PM0BBtCqDvvFkTs
 HmtBHi5gSERQe5HEDtl7Uife/ijKHDY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-275-WSe9d7fNN9Ki0xwKv_jFUg-1; Thu, 02 Jan 2020 10:49:03 -0500
Received: by mail-wm1-f71.google.com with SMTP id p2so869362wma.3
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2020 07:49:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=oAuRxuPTLna4HhQ7WNS0Pfs5pExtdpazlt1mHZcPnGE=;
 b=M8Unotkjca5DvOaq2To7nY4w38CArX6lN7nHtmDxxmoj5SjHBj9mFxpRhDPIMA/cxP
 ZxvgTzz9zn7RMPTQJsyP3oyIds3ZbZZVDcRCkjEH2BpRIqK5RCSIzquwk1PmAfTAPqwd
 tReEw/9Bt8O5Nn/OltdmTpRJSJwGUTAUWN2MoXqlMTuZNDNE/MmEbgPiOZYpr6UGc6PG
 1v95bRnK4+XYeXUmHRYX6SkmlgGNsbIUi6jF3SbX34pB12oR7sx1z6Y7jH+qodkP+gT0
 yJuq/1SuR5ftwCwfa5WFpoNspyU2/UWiw2FRXua4OjfO6vBwcnw7m0HBTQjgYGmuL01s
 umuw==
X-Gm-Message-State: APjAAAV3M2PtV3Jtt4t871XLLpgw9iV8OBOnzZu1eF1t7rPu0SM+Ur2u
 m0YdtfGLFOi+Tx5XGrZWs0oGeq0WI01FFMvi0ueA9wS1GW0XrpW3YM1WDxwxy1fG/YTWBU8Rmri
 mgc7iPABRwlVqiOI=
X-Received: by 2002:a1c:4907:: with SMTP id w7mr14596231wma.106.1577980142363; 
 Thu, 02 Jan 2020 07:49:02 -0800 (PST)
X-Google-Smtp-Source: APXvYqy+BfnPY38TqSfGUC8IJBcy1gkb71Y5sjn8/aFSZp3xMlIM+xj1UObh09ERGmbzFlaaxv9FfA==
X-Received: by 2002:a1c:4907:: with SMTP id w7mr14596217wma.106.1577980142107; 
 Thu, 02 Jan 2020 07:49:02 -0800 (PST)
Received: from [192.168.50.32] (243.red-88-26-246.staticip.rima-tde.net.
 [88.26.246.243])
 by smtp.gmail.com with ESMTPSA id t1sm8880617wma.43.2020.01.02.07.49.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jan 2020 07:49:01 -0800 (PST)
Subject: Re: [PATCH 43/86] hppa: drop RAM size fixup
To: Igor Mammedov <imammedo@redhat.com>
References: <1577797450-88458-1-git-send-email-imammedo@redhat.com>
 <1577797450-88458-44-git-send-email-imammedo@redhat.com>
 <bc7bac60-0d20-d0e3-b9ac-2c9ff62c2c15@redhat.com>
 <8cb7bd0f-7841-7e60-8de6-708515b81b00@gmx.de>
 <7cc361d0-300f-a8a1-3650-9358e815c070@redhat.com>
 <20200102151223.73e1448b@redhat.com>
 <a3017f38-b32b-de32-9896-b287253d0fa2@redhat.com>
 <20200102160827.790b8ed2@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <f073e703-5caf-e63c-ef1b-04fa7ab51716@redhat.com>
Date: Thu, 2 Jan 2020 16:49:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200102160827.790b8ed2@redhat.com>
Content-Language: en-US
X-MC-Unique: WSe9d7fNN9Ki0xwKv_jFUg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Helge Deller <deller@gmx.de>, qemu-devel@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/2/20 4:08 PM, Igor Mammedov wrote:
> On Thu, 2 Jan 2020 15:17:14 +0100
> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:
>=20
>> On 1/2/20 3:12 PM, Igor Mammedov wrote:
>>> On Thu, 2 Jan 2020 13:06:33 +0100
>>> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:
>>>   =20
>>>> On 1/2/20 12:31 PM, Helge Deller wrote:
>>>>> On 31.12.19 16:44, Philippe Mathieu-Daud=C3=A9 wrote:
>>>>>> On 12/31/19 2:03 PM, Igor Mammedov wrote:
>>>>>>> If user provided non-sense RAM size, board will complain and
>>>>>>> continue running with max RAM size supported.
>>>>>>> Also RAM is going to be allocated by generic code, so it won't be
>>>>>>> possible for board to fix things up for user.
>>>>>>>
>>>>>>> Make it error message and exit to force user fix CLI,
>>>>>>> instead of accepting non-sense CLI values.
>>>>>>>
>>>>>>> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
>>>>>>> ---
>>>>>>>    =C2=A0 hw/hppa/machine.c | 3 ++-
>>>>>>>    =C2=A0 1 file changed, 2 insertions(+), 1 deletion(-)
>>>>>>>
>>>>>>> diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
>>>>>>> index 5d0de26..25f5afc 100644
>>>>>>> --- a/hw/hppa/machine.c
>>>>>>> +++ b/hw/hppa/machine.c
>>>>>>> @@ -92,7 +92,8 @@ static void machine_hppa_init(MachineState *machi=
ne)
>>>>>>>    =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Limit main memory. */
>>>>>>>    =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ram_size > FIRMWARE_START) {
>>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 machine->ram_size =3D r=
am_size =3D FIRMWARE_START;
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_report("RAM size =
more than %d is not supported", FIRMWARE_START);
>>>>>>> +        exit(EXIT_FAILURE);
>>>>>>
>>>>>> $ qemu-system-hppa -m 3841m
>>>>>> qemu-system-hppa: invalid accelerator kvm
>>>>>> qemu-system-hppa: falling back to tcg
>>>>>> qemu-system-hppa: RAM size more than -268435456 is not supported
>>>>>>
>>>>>> Instead of using qemu_strtosz_MiB on FIRMWARE_START or unsigned form=
at, we can simply use "RAM size more than 3840m is not supported". Is that =
OK with you?
>>>>>
>>>>> I don't really like that change.
>>>>>
>>>>> We currently only emulate a 32-bit system, and for those 4GB is the m=
aximum.
>>>>> So, if I start my machine with "qemu-system-hppa -m 4G", the current =
code
>>>>> then automatically uses the maximum possible of 3841MB (which is limi=
ted by
>>>>> firmware start address).
>>>>> I don't expect users to know the excact 3841MB number.
>>>>> Even on a phyiscal machine you can only add DIMMs of sizes 2GB, 3GB o=
r 4GB,
>>>>> but not "3841MB".
>>>>
>>>> Thanks for the explanation. This deserves a comment in the source file
>>>> IMHO (and displaying a warning to the user that the behavior is change=
d).
>>>>
>>>> I understand the CPU can't access this DRAM area because the ROM is
>>>> mapped there. What about other devices, can they do DMA access to it?
>>>>
>>>> Igor: If this complicates your series too much, I think we can directl=
y
>>>> allocate up-to 4GiB and not worry about the 256MiB lost.
>>>
>>> Do you mean
>>> s/"RAM size more than %d is not supported"/"RAM size more than 4Gb is n=
ot supported"/
>>
>> Works for me! You can keep my R-b with this change, thanks.
>=20
> Well, it's not that simple.
> Do we map whole 4G in address space, if yes then we have to "unbreak"
> firmware mapping and use overlap mapping or do we map only portion of it?
> Both would make code more confusing and all for the sake of user convenie=
nce
> so they won't have to change their CLI?

I was thinking about this patch:

-- >8 --
diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index 5d0de26140..fa0b6a9536 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -91,15 +91,16 @@ static void machine_hppa_init(MachineState *machine)
      }

      /* Limit main memory. */
-    if (ram_size > FIRMWARE_START) {
-        machine->ram_size =3D ram_size =3D FIRMWARE_START;
+    if (ram_size > 4 * GiB) {
+        error_report("Can not model more than 4GB of RAM");
+        exit(EXIT_FAILURE);
      }

      /* Main memory region. */
      ram_region =3D g_new(MemoryRegion, 1);
      memory_region_allocate_system_memory(ram_region, OBJECT(machine),
                                           "ram", ram_size);
-    memory_region_add_subregion(addr_space, 0, ram_region);
+    memory_region_add_subregion_overlap(addr_space, 0, ram_region, -1);

      /* Init Dino (PCI host bus chip).  */
      pci_bus =3D dino_init(addr_space, &rtc_irq, &serial_irq);
---

$ hppa-softmmu/qemu-system-hppa -m 3840m -S -monitor stdio
QEMU 4.2.50 monitor - type 'help' for more information
(qemu) info mtree
address-space: memory
   0000000000000000-ffffffffffffffff (prio 0, i/o): system
     0000000000000000-00000000efffffff (prio -1, ram): ram
     00000000f0000000-00000000f07fffff (prio 0, ram): firmware
     00000000f9000000-00000000f90007ff (prio 0, i/o): isa-io
       00000000f9000020-00000000f9000021 (prio 0, i/o): pic
       00000000f9000070-00000000f9000071 (prio 0, i/o): rtc
         00000000f9000070-00000000f9000070 (prio 0, i/o): rtc-index
       00000000f90000a0-00000000f90000a1 (prio 0, i/o): pic
       00000000f90004d0-00000000f90004d0 (prio 0, i/o): elcr
       00000000f90004d1-00000000f90004d1 (prio 0, i/o): elcr
     00000000fff80000-00000000fff80fff (prio 0, i/o): dino
       00000000fff80064-00000000fff80067 (prio 0, i/o): pci-conf-idx
       00000000fff80068-00000000fff8006b (prio 0, i/o): pci-conf-data
     00000000fff83800-00000000fff83807 (prio 0, i/o): serial
     00000000fffb0000-00000000fffb0003 (prio 0, i/o): cpu0-io-eir


