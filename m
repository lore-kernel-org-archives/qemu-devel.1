Return-Path: <SRS0=SBSl=35=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01B05C35250
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Feb 2020 16:42:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5F3920715
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Feb 2020 16:42:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MWn6HD1h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5F3920715
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52692 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j0pem-00080h-Qn
	for qemu-devel@archiver.kernel.org; Sun, 09 Feb 2020 11:42:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58380)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j0peB-0007bz-5p
 for qemu-devel@nongnu.org; Sun, 09 Feb 2020 11:41:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j0pe9-0000KN-Ut
 for qemu-devel@nongnu.org; Sun, 09 Feb 2020 11:41:26 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:54797)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j0pe9-0000Ih-Oq
 for qemu-devel@nongnu.org; Sun, 09 Feb 2020 11:41:25 -0500
Received: by mail-wm1-x341.google.com with SMTP id g1so7277352wmh.4
 for <qemu-devel@nongnu.org>; Sun, 09 Feb 2020 08:41:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:references:from:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=SEjjWUUzDCtv9GFPxgTHLa3RORg10PiOMquIp8Khuo4=;
 b=MWn6HD1hUNTAHDXncEaoRiX0PjeUJFptSTVoh5YEcqILHFgFsGe9ADHL0YqQ7nYl6K
 1MwdVqpdV/UXwAaBwFDD9+5H9/tuXpYEmqeyv9J3dh7LoJRU91x5hJbmdolXaHXH1HpI
 9BrZKqL8hvdplfGOBayer2LRCU+H9SO8RNcfYZMlxaeRahLpwYtzQ8+6uBV4UHddx+JQ
 pdSKsOQHXYKJQW855cl5/nOq5+g2vT1dS3IQjxHJvN38Asr5lSAjdDyKKfMRt1Yg+H0q
 61UT4hVb/i3CZLFOglkGGBgvnnQKLJTMQy2oLfWRkJrg+mKzvA5q8ZKzS15LyBcrkLYJ
 UjsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=SEjjWUUzDCtv9GFPxgTHLa3RORg10PiOMquIp8Khuo4=;
 b=EG64KCBgDCwIecb/dbmMO3IyROWWa1aQqu2kTCZQxzoQjA7BMt+njGfvfwV0VWLGFG
 2bgG/V65Z5wrrdbjoyLtPRS3iO8nlioPZufMkyIL816yskXWviIDzKFi+83SNgwTMN8U
 wKbqW5Z3q0YMAzWWib8u55izs8Sslu8DClVbKQVx2SKJTUq+Ab4nN8qe+s7RRN/nlz1A
 pfMnw5rio1ZTvJQw67ojqOBsZ+js3QBPX9f/pRNFnRRF3+Pei3HzscmHbvBowGBtYyq2
 zIqZdo734oRsdBBCcIVpbnArrvSvK83YiPWJFv4bFF/4m3xAtbVBSJ7EB3Q9qmVAxPXf
 W03g==
X-Gm-Message-State: APjAAAVP01bf7CPp9cq1QF/j1ICB2gGKgst8u67XdQ7QJzDsK1NXNnY7
 Sok3OuR+8v9RjErfc4F575xHVfYi
X-Google-Smtp-Source: APXvYqw8uM1g0gE5UsOAOPTaGm5xcHXrfgC8VEt3UYhw5kWIJrx8em3VEwz/3Vz6GaF8/VBe+T1pWg==
X-Received: by 2002:a05:600c:2406:: with SMTP id
 6mr10369715wmp.30.1581266483996; 
 Sun, 09 Feb 2020 08:41:23 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id o15sm12590013wra.83.2020.02.09.08.41.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 09 Feb 2020 08:41:22 -0800 (PST)
Subject: Re: [PATCH v4 53/80] mips/mips_jazz: use memdev for RAM
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <1580483390-131164-1-git-send-email-imammedo@redhat.com>
 <1580483390-131164-54-git-send-email-imammedo@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Autocrypt: addr=f4bug@amsat.org; keydata=
 mQINBDU8rLoBEADb5b5dyglKgWF9uDbIjFXU4gDtcwiga9wJ/wX6xdhBqU8tlQ4BroH7AeRl
 u4zXP0QnBDAG7EetxlQzcfYbPmxFISWjckDBFvDbFsojrZmwF2/LkFSzlvKiN5KLghzzJhLO
 HhjGlF8deEZz/d/G8qzO9mIw8GIBS8uuWh6SIcG/qq7+y+2+aifaj92EdwU79apZepT/U3vN
 YrfcAuo1Ycy7/u0hJ7rlaFUn2Fu5KIgV2O++hHYtCCQfdPBg/+ujTL+U+sCDawCyq+9M5+LJ
 ojCzP9rViLZDd/gS6jX8T48hhidtbtsFRj/e9QpdZgDZfowRMVsRx+TB9yzjFdMO0YaYybXp
 dg/wCUepX5xmDBrle6cZ8VEe00+UQCAU1TY5Hs7QFfBbjgR3k9pgJzVXNUKcJ9DYQP0OBH9P
 ZbZvM0Ut2Bk6bLBO5iCVDOco0alrPkX7iJul2QWBy3Iy9j02GnA5jZ1Xtjr9kpCqQT+sRXso
 Vpm5TPGWaWljIeLWy/qL8drX1eyJzwTB3A36Ck4r3YmjMjfmvltSZB1uAdo1elHTlFEULpU/
 HiwvvqXQ9koB15U154VCuguvx/Qnboz8GFb9Uw8VyawzVxYVNME7xw7CQF8FYxzj6eI7rBf2
 Dj/II6wxWPgDEy3oUzuNOxTB7sT3b/Ym76yOJzWX5BylXQIJ5wARAQABtDFQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoRjRCVUcpIDxmNGJ1Z0BhbXNhdC5vcmc+iQJVBBMBCAA/AhsPBgsJ
 CAcDAgYVCAIJCgsEFgIDAQIeAQIXgBYhBPqr514SkXIh3P1rsuPjLCzercDeBQJd660aBQks
 klzgAAoJEOPjLCzercDe2iMP+gMG2dUf+qHz2uG8nTBGMjgK0aEJrKVPodFA+iedQ5Kp3BMo
 jrTg3/DG1HMYdcvQu/NFLYwamUfUasyor1k+3dB23hY09O4xOsYJBWdilkBGsJTKErUmkUO2
 3J/kawosvYtJJSHUpw3N6mwz/iWnjkT8BPp7fFXSujV63aZWZINueTbK7Y8skFHI0zpype9s
 loU8xc4JBrieGccy3n4E/kogGrTG5jcMTNHZ106DsQkhFnjhWETp6g9xOKrzZQbETeRBOe4P
 sRsY9YSG2Sj+ZqmZePvO8LyzGRjYU7T6Z80S1xV0lH6KTMvq7vvz5rd92f3pL4YrXq+e//HZ
 JsiLen8LH/FRhTsWRgBtNYkOsd5F9NvfJtSM0qbX32cSXMAStDVnS4U+H2vCVCWnfNug2TdY
 7v4NtdpaCi4CBBa3ZtqYVOU05IoLnlx0miKTBMqmI05kpgX98pi2QUPJBYi/+yNu3fjjcuS9
 K5WmpNFTNi6yiBbNjJA5E2qUKbIT/RwQFQvhrxBUcRCuK4x/5uOZrysjFvhtR8YGm08h+8vS
 n0JCnJD5aBhiVdkohEFAz7e5YNrAg6kOA5IVRHB44lTBOatLqz7ntwdGD0rteKuHaUuXpTYy
 CRqCVAKqFJtxhvJvaX0vLS1Z2dwtDwhjfIdgPiKEGOgCNGH7R8l+aaM4OPOd
Message-ID: <09243f48-76bb-2c8a-52b6-d7c1375cdb55@amsat.org>
Date: Sun, 9 Feb 2020 17:41:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1580483390-131164-54-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/31/20 4:09 PM, Igor Mammedov wrote:
> memory_region_allocate_system_memory() API is going away, so
> replace it with memdev allocated MemoryRegion. The later is
> initialized by generic code, so board only needs to opt in
> to memdev scheme by providing
>   MachineClass::default_ram_id
> and using MachineState::ram instead of manually initializing
> RAM memory region.

FYI Jazz can not have more than 256MB of DRAM.

> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  hw/mips/mips_jazz.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/mips/mips_jazz.c b/hw/mips/mips_jazz.c
> index 66fd4d8..85d49cf 100644
> --- a/hw/mips/mips_jazz.c
> +++ b/hw/mips/mips_jazz.c
> @@ -159,7 +159,6 @@ static void mips_jazz_init(MachineState *machine,
>      ISABus *isa_bus;
>      ISADevice *pit;
>      DriveInfo *fds[MAX_FD];
> -    MemoryRegion *ram = g_new(MemoryRegion, 1);
>      MemoryRegion *bios = g_new(MemoryRegion, 1);
>      MemoryRegion *bios2 = g_new(MemoryRegion, 1);
>      SysBusESPState *sysbus_esp;
> @@ -191,9 +190,7 @@ static void mips_jazz_init(MachineState *machine,
>      cc->do_transaction_failed = mips_jazz_do_transaction_failed;
>  
>      /* allocate RAM */
> -    memory_region_allocate_system_memory(ram, NULL, "mips_jazz.ram",
> -                                         machine->ram_size);
> -    memory_region_add_subregion(address_space, 0, ram);
> +    memory_region_add_subregion(address_space, 0, machine->ram);
>  
>      memory_region_init_ram(bios, NULL, "mips_jazz.bios", MAGNUM_BIOS_SIZE,
>                             &error_fatal);
> @@ -393,6 +390,7 @@ static void mips_magnum_class_init(ObjectClass *oc, void *data)
>      mc->init = mips_magnum_init;
>      mc->block_default_type = IF_SCSI;
>      mc->default_cpu_type = MIPS_CPU_TYPE_NAME("R4000");
> +    mc->default_ram_id = "mips_jazz.ram";
>  }
>  
>  static const TypeInfo mips_magnum_type = {
> @@ -409,6 +407,7 @@ static void mips_pica61_class_init(ObjectClass *oc, void *data)
>      mc->init = mips_pica61_init;
>      mc->block_default_type = IF_SCSI;
>      mc->default_cpu_type = MIPS_CPU_TYPE_NAME("R4000");
> +    mc->default_ram_id = "mips_jazz.ram";
>  }
>  
>  static const TypeInfo mips_pica61_type = {
> 

