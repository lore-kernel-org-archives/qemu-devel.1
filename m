Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D5B4C35DF5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 09:25:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17F0421556
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 09:25:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g0oTs3q3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17F0421556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51038 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6WTG-0001Dy-7r
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 04:25:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53162)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j6WSe-0000eh-Sx
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 04:25:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j6WSd-0007w2-70
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 04:25:04 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:44407
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j6WSd-0007tl-2M
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 04:25:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582622691;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eEvgdVnxbmhSHNCMWFxbayF6iIENchcd1UGoikkmvhk=;
 b=g0oTs3q34CM5Cfzlgw8/lsr6q6Yuj+1WjrMI+6w5Q2PuU626PDafIZHyOdQoyuVp2D3ClC
 T7uoFfxO2nJlQr3iKlKD72xMKftfCVkQKZ1xJps0xC1BHbs/0/2BHYu2kRoBrz9RI3FuAN
 JfBTE124qKlyIKdsSp8MAYrYaypDZ2I=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-331-r25jja_YMN2dSmtD6VejXQ-1; Tue, 25 Feb 2020 04:24:49 -0500
X-MC-Unique: r25jja_YMN2dSmtD6VejXQ-1
Received: by mail-ed1-f72.google.com with SMTP id ck15so8640589edb.6
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 01:24:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=eEvgdVnxbmhSHNCMWFxbayF6iIENchcd1UGoikkmvhk=;
 b=OAs5MGv97SYiLSrbWAMeNR7PqGWUJ7xnfTnv7I4GwVgkGkc43ic72vq9K+YzZ99z7F
 LqK0d7H15zODehTkfFQ6fewI2E1rudX7ZBoOzawyM9XxKHgaaAFwgQqckRyqF3xp61eH
 NpuiZAX86WL09ZsNhcU6ePiBQw6i+6celqCzTBfGK6tExS2Ky7FLLhpsPiXN+YMVr7PM
 NGMeZ//b8wiCOlFVUk3UF3ZqvuolUu3qN8xABzvPjvWh09O7hKJ3DJqbOZs4YWi8/bM8
 Hp97w9zqgg5JkKpIGIdafxhXbZ2n9HCbtPH2DbbK0jqGv4b1ImunhX/SqsTEc/9M6u43
 63tQ==
X-Gm-Message-State: APjAAAVqNIuuBe/szduHRrqgUh9Gr5iSfZq7VGfbu2BcEe3JLFpbzYSv
 Y9I5V/Jekm106wqbbalmABejaZrucb+VKqCEIK1v3kDPsmGgnbS/Oa8CfpoFG3zL4fPbOEIfTyY
 cCiXBc8enawA1rQE=
X-Received: by 2002:a17:906:5f89:: with SMTP id
 a9mr50970090eju.267.1582622688060; 
 Tue, 25 Feb 2020 01:24:48 -0800 (PST)
X-Google-Smtp-Source: APXvYqxyRiMdSIFxw2U/Ni/4WlDHfqOK5c7sCI0YZN4lKfzcG3CY5ytOE+Pqg81AbMkFaogGkM68pw==
X-Received: by 2002:a17:906:5f89:: with SMTP id
 a9mr50970065eju.267.1582622687784; 
 Tue, 25 Feb 2020 01:24:47 -0800 (PST)
Received: from [192.168.1.35] (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id a24sm896361ejt.40.2020.02.25.01.24.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Feb 2020 01:24:47 -0800 (PST)
Subject: Re: [PATCH] hw/smbios: add options for type 4 max_speed and
 current_speed
To: Heyi Guo <guoheyi@huawei.com>, qemu-devel@nongnu.org
References: <20200225075046.30151-1-guoheyi@huawei.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <4bd58f6e-e522-d920-bc9a-8198147e8856@redhat.com>
Date: Tue, 25 Feb 2020 10:24:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200225075046.30151-1-guoheyi@huawei.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
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
Cc: wanghaibin.wang@huawei.com, "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/25/20 8:50 AM, Heyi Guo wrote:
> Common VM users sometimes care about CPU speed, so we add two new
> options to allow VM vendors to present CPU speed to their users.
> Normally these information can be fetched from host smbios.
> 
> Strictly speaking, the "max speed" and "current speed" in type 4
> are not really for the max speed and current speed of processor, for
> "max speed" identifies a capability of the system, and "current speed"
> identifies the processor's speed at boot (see smbios spec), but some
> applications do not tell the differences.
> 
> Signed-off-by: Heyi Guo <guoheyi@huawei.com>
> 
> ---
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
> ---
>   hw/smbios/smbios.c | 22 +++++++++++++++++++---
>   qemu-options.hx    |  3 ++-
>   2 files changed, 21 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
> index ffd98727ee..1d5439643d 100644
> --- a/hw/smbios/smbios.c
> +++ b/hw/smbios/smbios.c
> @@ -94,6 +94,8 @@ static struct {
>   
>   static struct {
>       const char *sock_pfx, *manufacturer, *version, *serial, *asset, *part;
> +    uint32_t max_speed;
> +    uint32_t current_speed;
>   } type4;
>   
>   static struct {
> @@ -272,6 +274,14 @@ static const QemuOptDesc qemu_smbios_type4_opts[] = {
>           .name = "version",
>           .type = QEMU_OPT_STRING,
>           .help = "version number",
> +    },{
> +        .name = "max_speed",
> +        .type = QEMU_OPT_NUMBER,
> +        .help = "max speed in MHz",
> +    },{
> +        .name = "current_speed",
> +        .type = QEMU_OPT_NUMBER,
> +        .help = "speed at system boot in MHz",
>       },{
>           .name = "serial",
>           .type = QEMU_OPT_STRING,
> @@ -586,9 +596,8 @@ static void smbios_build_type_4_table(MachineState *ms, unsigned instance)
>       SMBIOS_TABLE_SET_STR(4, processor_version_str, type4.version);
>       t->voltage = 0;
>       t->external_clock = cpu_to_le16(0); /* Unknown */
> -    /* SVVP requires max_speed and current_speed to not be unknown. */
> -    t->max_speed = cpu_to_le16(2000); /* 2000 MHz */
> -    t->current_speed = cpu_to_le16(2000); /* 2000 MHz */
> +    t->max_speed = cpu_to_le16(type4.max_speed);
> +    t->current_speed = cpu_to_le16(type4.current_speed);
>       t->status = 0x41; /* Socket populated, CPU enabled */
>       t->processor_upgrade = 0x01; /* Other */
>       t->l1_cache_handle = cpu_to_le16(0xFFFF); /* N/A */
> @@ -1129,6 +1138,13 @@ void smbios_entry_add(QemuOpts *opts, Error **errp)
>               save_opt(&type4.serial, opts, "serial");
>               save_opt(&type4.asset, opts, "asset");
>               save_opt(&type4.part, opts, "part");
> +            /*
> +             * SVVP requires max_speed and current_speed to not be unknown, and
> +             * we set the default value to 2000MHz as we did before.
> +             */
> +            type4.max_speed = qemu_opt_get_number(opts, "max_speed", 2000);
> +            type4.current_speed = qemu_opt_get_number(opts, "current_speed",
> +                                                      2000);

Maybe check speeds are <= UINT16_MAX else set errp?

>               return;
>           case 11:
>               qemu_opts_validate(opts, qemu_smbios_type11_opts, &err);
> diff --git a/qemu-options.hx b/qemu-options.hx
> index ac315c1ac4..bc9ef0fda8 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -2233,6 +2233,7 @@ DEF("smbios", HAS_ARG, QEMU_OPTION_smbios,
>       "                specify SMBIOS type 3 fields\n"
>       "-smbios type=4[,sock_pfx=str][,manufacturer=str][,version=str][,serial=str]\n"
>       "              [,asset=str][,part=str]\n"
> +    "              [,max_speed=%d][,current_speed=%d]\n"
>       "                specify SMBIOS type 4 fields\n"
>       "-smbios type=17[,loc_pfx=str][,bank=str][,manufacturer=str][,serial=str]\n"
>       "               [,asset=str][,part=str][,speed=%d]\n"
> @@ -2255,7 +2256,7 @@ Specify SMBIOS type 2 fields
>   @item -smbios type=3[,manufacturer=@var{str}][,version=@var{str}][,serial=@var{str}][,asset=@var{str}][,sku=@var{str}]
>   Specify SMBIOS type 3 fields
>   
> -@item -smbios type=4[,sock_pfx=@var{str}][,manufacturer=@var{str}][,version=@var{str}][,serial=@var{str}][,asset=@var{str}][,part=@var{str}]
> +@item -smbios type=4[,sock_pfx=@var{str}][,manufacturer=@var{str}][,version=@var{str}][,serial=@var{str}][,asset=@var{str}][,part=@var{str}][,max_speed=@var{%d}][,current_speed=@var{%d}]
>   Specify SMBIOS type 4 fields
>   
>   @item -smbios type=17[,loc_pfx=@var{str}][,bank=@var{str}][,manufacturer=@var{str}][,serial=@var{str}][,asset=@var{str}][,part=@var{str}][,speed=@var{%d}]
> 


