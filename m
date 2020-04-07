Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6237C2BA16
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 08:19:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CAE9206F5
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 08:19:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DoYy2fgh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CAE9206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42942 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLjSb-0005cg-LG
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 04:19:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49156)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jLjRt-0004oG-Bk
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 04:19:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jLjRr-0003vn-VL
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 04:19:09 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:27716
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jLjRr-0003vD-Rf
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 04:19:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586247547;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eMiR9a/9beMjjtj4JxsDbSPWGLbJ2vVD5O+Pfpq8M+s=;
 b=DoYy2fgh+YUiThw62MGoo6d2l5KFG9eC23xOkR/+m6B+CzfhHjL1WdIojb9caSthxN6BG+
 fOhx63HL7nWodVrfx+5cR868BOqKZTieQz8aswzTM63QDI0zTz9j49SUQgPDFbONU8KII2
 drNu7bcHk+RVi07MaxnwS7Hx5OJ9Iis=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-508-XCGsNBnUNfiy13oFUpIFGA-1; Tue, 07 Apr 2020 04:19:05 -0400
X-MC-Unique: XCGsNBnUNfiy13oFUpIFGA-1
Received: by mail-ed1-f72.google.com with SMTP id b100so2367979edf.15
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2020 01:19:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=eMiR9a/9beMjjtj4JxsDbSPWGLbJ2vVD5O+Pfpq8M+s=;
 b=lGt54oZ+42Dlbq4XgTY3JAvK8lkf0pii0m+G9iwjVMDI7SLDhMh59ZC3HeJpziSwoe
 WiHI6qDVZoSBNn9sZGiRajUQLvshTn0L6vhJqlrbVUS9tX5ASMiPu64ur1LjEIz1Oj0W
 036oJyIB3OBqHYt4AbGWzp/xMFwh2lWQtTVoslklD3AvVBDZ9Njfnr3zoORTT2Dp0BcL
 lAa72bbA992C9rr5bQjC6QHUDhtCAafuP52wwqy8x6xhWI84T0M7KnpcTKFLH00LNaFj
 jPUt5au7fpridIdFgwq06UYX0WW0kz61uyBkDxZvlmZShp0jzv+3QF2gngFDko0Bm0mF
 ag9g==
X-Gm-Message-State: AGi0PuZ01+AydCwzg/v46FRKH/59bCse0NPneX6f291IjHwNLdCQhFHO
 A5PrpClR8kiy30VbjGPct8sUaCxVCilGUVdHSZpEGAInVsCB5BDjNp0hQ9RHcLOM8KbWWdGSR8d
 lRbL7xA6KUbTDZKE=
X-Received: by 2002:a17:906:54cd:: with SMTP id
 c13mr839756ejp.307.1586247543725; 
 Tue, 07 Apr 2020 01:19:03 -0700 (PDT)
X-Google-Smtp-Source: APiQypLkV+0aWqk/+fmhSCsIOnl3eyry3sFLE28R93ZVDx8Io2mMGbmqsYr2DXfZ4GVgMRGgeBgvTg==
X-Received: by 2002:a17:906:54cd:: with SMTP id
 c13mr839729ejp.307.1586247543382; 
 Tue, 07 Apr 2020 01:19:03 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id nw21sm2429923ejb.54.2020.04.07.01.19.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Apr 2020 01:19:02 -0700 (PDT)
Subject: Re: [PATCH] aspeed: Add boot stub for smp booting
To: Joel Stanley <joel@jms.id.au>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?=
 <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>
References: <20200407072517.671521-1-joel@jms.id.au>
 <CACPK8XfHnE_kEPw++CdLRG9r=xJmLZkuV4WXP7NKTo8mW+dJvA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <16f057db-a4d7-889f-344c-930587fc8bf1@redhat.com>
Date: Tue, 7 Apr 2020 10:19:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CACPK8XfHnE_kEPw++CdLRG9r=xJmLZkuV4WXP7NKTo8mW+dJvA@mail.gmail.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Andrew Jeffery <andrew@aj.id.au>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 4/7/20 9:38 AM, Joel Stanley wrote:
> On Tue, 7 Apr 2020 at 07:25, Joel Stanley <joel@jms.id.au> wrote:
>>
>> This is a boot stub that is similar to the code u-boot runs, allowing
>> the kernel to boot the secondary CPU.
>>
>> u-boot works as follows:
>>
>>   1. Initialises the SMP mailbox area in the SCU at 0x1e6e2180 with default values
>>
>>   2. Copies a stub named 'mailbox_insn' from flash to the SCU, just above the
>>      mailbox area
>>
>>   3. Sets AST_SMP_MBOX_FIELD_READY to a magic value to indicate the
>>      secondary can begin execution from the stub
>>
>>   4. The stub waits until the AST_SMP_MBOX_FIELD_GOSIGN register is set to
>>      a magic value
>>
>>   5. Jumps to the address in AST_SMP_MBOX_FIELD_ENTRY, starting Linux
>>
>> Linux indicates it is ready by writing the address of its entrypoint
>> function to AST_SMP_MBOX_FIELD_ENTRY and the 'go' magic number to
>> AST_SMP_MBOX_FIELD_GOSIGN. The secondary CPU sees this at step 4 and
>> breaks out of it's loop.
>>
>> To be compatible, a fixed qemu stub is loaded into the mailbox area. As
>> qemu can ensure the stub is loaded before execution starts, we do not
>> need to emulate the AST_SMP_MBOX_FIELD_READY behaviour of u-boot. The
>> secondary CPU's program counter points to the beginning of the stub,
>> allowing qemu to start secondaries at step four.
>>
>> Reboot behaviour is preserved by resetting AST_SMP_MBOX_FIELD_GOSIGN
>> when the secondaries are reset.
>>
>> This is only configured when the system is booted with -kernel and qemu
>> does not execute u-boot first.
>>
>> Signed-off-by: Joel Stanley <joel@jms.id.au>
>> ---
>>   hw/arm/aspeed.c | 65 +++++++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 65 insertions(+)
>>
>> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
>> index a6a2102a93cb..bc4386cc6174 100644
>> --- a/hw/arm/aspeed.c
>> +++ b/hw/arm/aspeed.c
>> @@ -116,6 +116,58 @@ static const MemoryRegionOps max_ram_ops = {
>>       .endianness = DEVICE_NATIVE_ENDIAN,
>>   };
>>
>> +#define AST_SMP_MAILBOX_BASE            0x1e6e2180
>> +#define AST_SMP_MBOX_FIELD_ENTRY        (AST_SMP_MAILBOX_BASE + 0x0)
>> +#define AST_SMP_MBOX_FIELD_GOSIGN       (AST_SMP_MAILBOX_BASE + 0x4)
>> +#define AST_SMP_MBOX_FIELD_READY        (AST_SMP_MAILBOX_BASE + 0x8)
>> +#define AST_SMP_MBOX_FIELD_POLLINSN     (AST_SMP_MAILBOX_BASE + 0xc)
>> +#define AST_SMP_MBOX_CODE               (AST_SMP_MAILBOX_BASE + 0x10)
>> +#define AST_SMP_MBOX_GOSIGN             0xabbaab00
>> +
>> +static void aspeed_write_smpboot(ARMCPU *cpu,
>> +                                 const struct arm_boot_info *info)
>> +{
>> +    static const uint32_t poll_mailbox_ready[] = {
>> +        /*
>> +         * r2 = per-cpu go sign value
>> +         * r1 = AST_SMP_MBOX_FIELD_ENTRY
>> +         * r0 = AST_SMP_MBOX_FIELD_GOSIGN
>> +         */
>> +        0xee100fb0,  /* mrc     p15, 0, r0, c0, c0, 5 */
>> +        0xe21000ff,  /* ands    r0, r0, #255          */
>> +        0xe59f201c,  /* ldr     r2, [pc, #28]         */
>> +        0xe1822000,  /* orr     r2, r2, r0            */
>> +
>> +        0xe59f1018,  /* ldr     r1, [pc, #24]         */
>> +        0xe59f0018,  /* ldr     r0, [pc, #24]         */
>> +
>> +        0xe320f002,  /* wfe                           */
>> +        0xe5904000,  /* ldr     r4, [r0]              */
>> +        0xe1520004,  /* cmp     r2, r4                */
>> +        0x1afffffb,  /* bne     <wfe>                 */
>> +        0xe591f000,  /* ldr     pc, [r1]              */
>> +        AST_SMP_MBOX_GOSIGN,
>> +        AST_SMP_MBOX_FIELD_ENTRY,
>> +        AST_SMP_MBOX_FIELD_GOSIGN,
>> +    };
>> +
>> +    rom_add_blob_fixed("aspeed.smpboot", poll_mailbox_ready,
>> +                       sizeof(poll_mailbox_ready),
>> +                       info->smp_loader_start);
>> +}
>> +
>> +static void aspeed_reset_secondary(ARMCPU *cpu,
>> +                                   const struct arm_boot_info *info)
>> +{
>> +    AddressSpace *as = arm_boot_address_space(cpu, info);
>> +    CPUState *cs = CPU(cpu);
>> +
>> +    /* info->smp_bootreg_addr */
>> +    address_space_stl_notdirty(as, AST_SMP_MBOX_FIELD_GOSIGN, 0,
>> +                               MEMTXATTRS_UNSPECIFIED, NULL);
>> +    cpu_set_pc(cs, info->smp_loader_start);
>> +}
>> +
>>   #define FIRMWARE_ADDR 0x0
>>
>>   static void write_boot_rom(DriveInfo *dinfo, hwaddr addr, size_t rom_size,
>> @@ -270,6 +322,19 @@ static void aspeed_machine_init(MachineState *machine)
>>           }
>>       }
>>
>> +    if (machine->kernel_filename) {
> 
> I just realised this shouldn't be executed on non-ast2600 platforms.
> We could test for the number of CPUs like this:
> 
> if (machine->kernel_filename && aspeed_board_binfo.nb_cpus > 1) {

   if (!strcmp(amc->soc_name, "ast2600")) { ?

> 
>> +        /* With no u-boot we must set up a boot stub for the secondary CPU */
>> +        MemoryRegion *smpboot = g_new(MemoryRegion, 1);
>> +        memory_region_init_ram(smpboot, OBJECT(bmc), "aspeed.smpboot",
>> +                               0x80, &error_abort);
>> +        memory_region_add_subregion(get_system_memory(),
>> +                                    AST_SMP_MAILBOX_BASE, smpboot);
>> +
>> +        aspeed_board_binfo.write_secondary_boot = aspeed_write_smpboot;
>> +        aspeed_board_binfo.secondary_cpu_reset_hook = aspeed_reset_secondary;
>> +        aspeed_board_binfo.smp_loader_start = AST_SMP_MBOX_CODE;
>> +    }
>> +
>>       aspeed_board_binfo.ram_size = ram_size;
>>       aspeed_board_binfo.loader_start = sc->memmap[ASPEED_SDRAM];
>>       aspeed_board_binfo.nb_cpus = bmc->soc.num_cpus;
>> --
>> 2.25.1
>>
> 


