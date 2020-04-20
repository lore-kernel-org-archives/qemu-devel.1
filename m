Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D07F2C3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 06:49:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DD302080C
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 06:49:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LZbTr2ip"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DD302080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58404 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQQEq-0001TQ-Ks
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 02:49:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39628 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jQQDs-0000pR-9t
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 02:48:04 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jQQDr-0004Cx-UE
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 02:48:04 -0400
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543]:39497)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jQQDq-00046a-8v; Mon, 20 Apr 2020 02:48:02 -0400
Received: by mail-ed1-x543.google.com with SMTP id k22so2144741eds.6;
 Sun, 19 Apr 2020 23:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Y+elNH9UOqsLoxVoBcJ1OsX/EFngxxl6oFsmcqeECEs=;
 b=LZbTr2ip8DIvBjvk72+37eOITUkmmatZOQ+Eo4qS36ZfYu6fDsayrsL2umHpMu4TuR
 P6OtxhF9pvWlgK2a8mPobEa1CYRrg5imlWKE/tObSDU6TyGZuvtMzVK9w3L+N49WKH1H
 nvEpCiZM9I0pKB1oXRfgbwbvbHdllY3GoJaEiudwswythgsk1PRnrAgppH0HzR7wMm4I
 TER6ZJ+eCkd0GVqpq25BrTNXH/Egz5N6XL6gTPI2h12E1Jrmdq+wjuk3GR3soiy1XNtd
 TjWmjgzu/EMW6U4i0ksm6Kq0Yrme1Z9lep0A5icVh5YFJlM5RMchsZag69elIPyo0KP6
 qQFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=Y+elNH9UOqsLoxVoBcJ1OsX/EFngxxl6oFsmcqeECEs=;
 b=KjM5CfaxiP+6u7ap2jswOCXoFTS49etZx4kTRykaQz4QhjMUm+eKKOUDos8rCsz0ya
 n0600rrCRRqSW2CZpJLPSDTkalcIDNLNV/hJP46U91FZ4qUQXDUQmGH26qtIMEl4m2mW
 eQxt+U/moNrkOA8+QUaSoi1gNhUEhxHr7f8u8bkfj5QWIIsH+hELkoeBZjxH49GQ/2Eg
 Hyz9wXcKBv5BOlck8TJsgq/U0mYeSaM60mBR7/vqsxVcT4Y2qP4EodFMUyBknIrf7J2l
 9Op2EyasQp0u2a2WFxlR0iGAdezor8RSWWqmtpR25AJQ5/EGv2EoSyPVviYkK3Lt3HKi
 U15Q==
X-Gm-Message-State: AGi0PuY/2VKbSk5k1PkA3Rh1txmWpnvrqk4S1aDJo0EA9F79AxqWwJHD
 4akhLw2h9pi6pgbMEEs1Ung=
X-Google-Smtp-Source: APiQypLHkzIZ6RSALA3FeJx2HSx1aoEEN/C/kgwzEFGHFtn7Ziq33lOarS5l8587xQuHwNOCqhyYwQ==
X-Received: by 2002:a50:8a03:: with SMTP id i3mr12894910edi.121.1587365279762; 
 Sun, 19 Apr 2020 23:47:59 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id f13sm23922ejd.2.2020.04.19.23.47.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 19 Apr 2020 23:47:58 -0700 (PDT)
Subject: Re: [PATCH v1 2/3] hw/arm: xlnx-zcu102: Move arm_boot_info into
 XlnxZCU102
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-devel@nongnu.org
References: <20200419162727.19148-1-edgar.iglesias@gmail.com>
 <20200419162727.19148-3-edgar.iglesias@gmail.com>
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
Message-ID: <0f4e47cd-d362-c79e-0522-7e6077c6640d@amsat.org>
Date: Mon, 20 Apr 2020 08:47:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200419162727.19148-3-edgar.iglesias@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::543;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ed1-x543.google.com
X-detected-operating-system: by eggs1p.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::543
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
Cc: figlesia@xilinx.com, peter.maydell@linaro.org, sstabellini@kernel.org,
 edgar.iglesias@xilinx.com, sai.pavan.boddu@xilinx.com,
 frasse.iglesias@gmail.com, alistair@alistair23.me,
 richard.henderson@linaro.org, frederic.konrad@adacore.com, qemu-arm@nongnu.org,
 philmd@redhat.com, luc.michel@greensocs.com, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/19/20 6:27 PM, Edgar E. Iglesias wrote:
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
> 
> Move arm_boot_info into XlnxZCU102.
> 
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
> ---
>  hw/arm/xlnx-zcu102.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/arm/xlnx-zcu102.c b/hw/arm/xlnx-zcu102.c
> index bd645ad818..4eb117c755 100644
> --- a/hw/arm/xlnx-zcu102.c
> +++ b/hw/arm/xlnx-zcu102.c
> @@ -31,13 +31,14 @@ typedef struct XlnxZCU102 {
>  
>      bool secure;
>      bool virt;
> +
> +    struct arm_boot_info binfo;
>  } XlnxZCU102;
>  
>  #define TYPE_ZCU102_MACHINE   MACHINE_TYPE_NAME("xlnx-zcu102")
>  #define ZCU102_MACHINE(obj) \
>      OBJECT_CHECK(XlnxZCU102, (obj), TYPE_ZCU102_MACHINE)
>  
> -static struct arm_boot_info xlnx_zcu102_binfo;
>  
>  static bool zcu102_get_secure(Object *obj, Error **errp)
>  {
> @@ -166,9 +167,9 @@ static void xlnx_zcu102_init(MachineState *machine)
>  
>      /* TODO create and connect IDE devices for ide_drive_get() */
>  
> -    xlnx_zcu102_binfo.ram_size = ram_size;
> -    xlnx_zcu102_binfo.loader_start = 0;
> -    arm_load_kernel(s->soc.boot_cpu_ptr, machine, &xlnx_zcu102_binfo);
> +    s->binfo.ram_size = ram_size;
> +    s->binfo.loader_start = 0;
> +    arm_load_kernel(s->soc.boot_cpu_ptr, machine, &s->binfo);
>  }
>  
>  static void xlnx_zcu102_machine_instance_init(Object *obj)
> 

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

