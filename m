Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72CACC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 11:54:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3438022D07
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 11:54:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pVwzo/mT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3438022D07
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41664 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3dEA-0002Lf-R5
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 06:34:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36542)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k3dDZ-0001rD-G2; Thu, 06 Aug 2020 06:33:49 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:47090)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k3dDX-0005sc-L6; Thu, 06 Aug 2020 06:33:49 -0400
Received: by mail-wr1-x442.google.com with SMTP id f12so7649343wru.13;
 Thu, 06 Aug 2020 03:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=2ngCmUgzTkVnHJM+hkMCLWY0argmW1kgruJykM0JrLg=;
 b=pVwzo/mTwuzEkVr83CKB58Xz8hwOMlqn5DaBRWkwdZN6PtWdKw3ZZBiXf9+mHcipyo
 1GcZlwmKbzr0DsC0E/qu4EvlOeilVhAOdFTdOBzX6jOya3I+DQgJqpCN2lC9sN0HrfS5
 itZUd9OCXVKcEIi7o+8iwJoRR3NDcsZw9iFOPEJXBqNUgU0H0I3uDUb3f/12+lsr4lAV
 ZWYYMxA+d/oiA/GJO5cgkYawDJCPOtvXwe/zq4BmeoftYqU3FGmGEfFOISRAsVb86dkq
 fs2kqZ5otDGtZXEV2EODfX3GnFACY4v+vmZL8Uo6axyVXDGC1TrXQnHSvkzxnjctou/s
 d3gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=2ngCmUgzTkVnHJM+hkMCLWY0argmW1kgruJykM0JrLg=;
 b=ahNSQtSe4E2bUcb6z7IL8Qdujx/hef92xAcMAW4GwPUEY+5/Av/pzzLGVwK6tGilVH
 2GagTZ5KCqd4mdh+v7CLCDzpE7UVm4M8iUhnVW/jySqywvt5MjbKoVtq8PtlBFVXzcE0
 sTBDaouYAKAkRnWx2FrNxsj6ipVJclFQbkW57IU//Gg+39Z/p8zOyQAUMAvoN2dKReW5
 mv7gGGp47nFOH/tjZ9pfpIcX7wcnIuQiRcO51M89Yyk/VsYAUy3shu0n2yV34MAx4qh5
 /zfawnsQCucCh5FKeOtqvQVvjN61PJe+xAmcYpUcGZVo3hTNvCrKHi6jKYfvGKMIyZi3
 9JuA==
X-Gm-Message-State: AOAM532H7z3SheGFk6rEplD13aseTPUjlWSMw+a5ubTXVvsktbvALx7n
 SdcfPmd2E334WDbXV75o6sw=
X-Google-Smtp-Source: ABdhPJxSVNoOzN9t9TGo1L1VtEbAtF0Wm21qRsWzKpPXDsxrT6uNRHcV0wBsNMjQfhPPdvrHUjSOfA==
X-Received: by 2002:adf:bc07:: with SMTP id s7mr7355913wrg.254.1596710025339; 
 Thu, 06 Aug 2020 03:33:45 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id b77sm4912952wmb.3.2020.08.06.03.33.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Aug 2020 03:33:44 -0700 (PDT)
Subject: Re: [PATCH-for-5.2 7/7] hw/block/fdc: Add ASCII art schema of QOM
 relations
To: Kevin Wolf <kwolf@redhat.com>
References: <20200806080824.21567-1-f4bug@amsat.org>
 <20200806080824.21567-8-f4bug@amsat.org>
 <20200806085706.GB17753@linux.fritz.box>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <71fc8f3f-97fb-a1de-a85c-fa6ef4b420bb@amsat.org>
Date: Thu, 6 Aug 2020 12:33:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200806085706.GB17753@linux.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
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
Cc: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/6/20 10:57 AM, Kevin Wolf wrote:
> Am 06.08.2020 um 10:08 hat Philippe Mathieu-DaudÃƒÆ’Ã‚Â© geschrieben:
>> Without knowing the QEMU history, it is hard to relate QEMU objects
>> with the hardware datasheet.
>>
>> For example, one naively expects:
>>
>> * a floppy disk is plugged / unplugged on the bus
>>
>>   Wrong! QEMU floppy disks always sit on the bus. The block drives
>>   are plugged / unplugged on the disks, and the disks magically
>>   re-adapt their proprieties to match the block drive.
> 
> This is because what sits on the bus is not a floppy disk, but a floppy
> drive. FloppyDrive is also what the type is called.
> 
> The disk is represented by the BlockDriverState (the actual image file)
> that is inserted in the BlockBackend (which is logically part of the
> drive).
> 
>> * a floppy controller has a fixed number of disks pluggable on the bus
>>
>>   Wrong! QEMU floppy controllers have as much slots as the number of
>>   floppy drive provided when a machine is created. Then the ACPI table
>>   are generated and the number of slots can not be modified. So if you
>>   expect a dual slot controller being created with slot A and B, if
>>   the machine is created with a single drive attached, the controller
>>   will only have slot A created, and you will never be able to plug
>>   drive B without risking a mismatch in the ACPI tables.
> 
> Hm... I guess hotplugging floppy drives might actually have worked,
> though I have never tried it on real hardware. I'm pretty sure it wasn't
> an official feature, though, and ACPI tables certainly won't magically
> change if you do this because (apart from polling, I guess) software has
> no way to detect that you tinkered with the floppy cable. :-)
> 
>> * a floppy controller supporting 4 disks uses 2 buses
>>
>>   Wrong! QEMU uses a single bus to plug the 4 disks.
> 
> But we don't even emulate floppy controllers that can have more than two
> floppy drives:
> 
>     $ x86_64-softmmu/qemu-system-x86_64 -device floppy -device floppy -device floppy
>     qemu-system-x86_64: -device floppy: Can't create floppy unit 2, bus supports only 2 units

This comment is for developers, the warning is for user.

It comes from:

    if (dev->unit >= MAX_FD) {
        error_setg(errp, "Can't create floppy unit %d, bus supports "
                   "only %d units", dev->unit, MAX_FD);
        return;
    }

But you can compile QEMU with MAX_FD=4:

static FDrive *get_drv(FDCtrl *fdctrl, int unit)
{
    switch (unit) {
        case 0: return drv0(fdctrl);
        case 1: return drv1(fdctrl);
#if MAX_FD == 4
        case 2: return drv2(fdctrl);
        case 3: return drv3(fdctrl);
#endif
        default: return NULL;
    }
}

ACPI also handles 4 slots:

static void fdc_isa_build_aml(ISADevice *isadev, Aml *scope)
{
    Aml *dev;
    Aml *crs;
    int i;

#define ACPI_FDE_MAX_FD 4
    uint32_t fde_buf[5] = {
        0, 0, 0, 0,     /* presence of floppy drives #0 - #3 */
        cpu_to_le32(2)  /* tape presence (2 == never present) */
    };

    crs = aml_resource_template();
    aml_append(crs, aml_io(AML_DECODE16, 0x03F2, 0x03F2, 0x00, 0x04));
    aml_append(crs, aml_io(AML_DECODE16, 0x03F7, 0x03F7, 0x00, 0x01));
    aml_append(crs, aml_irq_no_flags(6));
    aml_append(crs,
        aml_dma(AML_COMPATIBILITY, AML_NOTBUSMASTER, AML_TRANSFER8, 2));

    dev = aml_device("FDC0");
    aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0700")));
    aml_append(dev, aml_name_decl("_CRS", crs));

    for (i = 0; i < MIN(MAX_FD, ACPI_FDE_MAX_FD); i++) {
        FloppyDriveType type = isa_fdc_get_drive_type(isadev, i);

        if (type < FLOPPY_DRIVE_TYPE_NONE) {
            fde_buf[i] = cpu_to_le32(1);  /* drive present */
            aml_append(dev, build_fdinfo_aml(i, type));
        }
    }
    aml_append(dev, aml_name_decl("_FDE",
               aml_buffer(sizeof(fde_buf), (uint8_t *)fde_buf)));

    aml_append(scope, dev);
}


> 
> This is checked in floppy_drive_realize(), so it applies to all
> variants of the controller.
> 
> If you want more floppy drives, you have to create a second controller
> (with a different iobase). Though I don't think I actually got this
> working when I tried. I wasn't sure if the problem was the emulation or
> the guest OSes (or SeaBIOS actually for DOS).
> 
>> As all these false assumptions are not obvious (we don't plug a disk,
>> we plug a block drive into a disk, etc...), start documenting the QOM
>> relationships with a simple ASCII schema.
> 
> Maybe be more specific to have: "floppy (drive)" and "blk (disk)".
> Because the ASCII schema is actually true, though you seem to have
> misunderstood what each item in it is supposed to represent.
> 
> Actually "blk (disk)" is not 100% accurate either because the drive
> always has a BlockBackend present. It's really the BlockDriverState
> inserted into the BlockBackend that is the disk.
> 
> In summary, to be honest, I believe since its qdevification, floppy is
> one of the block devices that is modelled the best on the QOM + block
> backend level. Only SCSI might be comparable, but IDE, virtio-blk and
> usb-storage are a mess in comparison.

I'm sorry I didn't want to criticize the model or hurt you, I just want
to note the differences between how the controller is described in the
Intel 82078 datasheet and how the QEMU model works. Maybe I'm wrong
assuming there would be a 1:1 match.

I'll repost with the name updated in the schema and removing my
assumptions from the commit description that appears as simple
critics.

> 
> Kevin
> 
>> Signed-off-by: Philippe Mathieu-DaudÃƒÆ’Ã‚Â© <f4bug@amsat.org>
>> ---
>>  hw/block/fdc.c | 22 ++++++++++++++++++++++
>>  1 file changed, 22 insertions(+)
>>
>> diff --git a/hw/block/fdc.c b/hw/block/fdc.c
>> index 6944b06e4b..b109f37050 100644
>> --- a/hw/block/fdc.c
>> +++ b/hw/block/fdc.c
>> @@ -47,6 +47,28 @@
>>  #include "qemu/module.h"
>>  #include "trace.h"
>>  
>> +/*
>> + * QOM relationship:
>> + * =================
>> + *
>> + *                  +-------------------+
>> + *                  |                   |
>> + * isa/sysbus  <--->|                   |
>> + *                  |                   |
>> + *  irq/dma    <----|        fdc        |
>> + *                  |
>> + *      clk    ---->|                   |        +-+------+-+    +-+------+-+
>> + *                  |                   |        | | blk  | |    | | blk  | |
>> + *                  +--------+----------+        | |      | |    | |      | |
>> + *                           |                   | +------+ |    | +------+ |
>> + *                           |                   |          |    |          |
>> + *                           |                   |  floppy  |    |  floppy  |
>> + *                           |                   +----+-----+    +----+-----+
>> + *                           |   floppy-bus           |               |
>> + *                           +------------------------v---------------v---
>> + *
>> + */
>> +
>>  /********************************************************/
>>  /* debug Floppy devices */
>>  
>> -- 
>> 2.21.3
>>
> 
> 

