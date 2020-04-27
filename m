Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E097C55199
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 09:18:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A32F20656
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 09:18:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R658BW7m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A32F20656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33174 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jSzu0-00070N-DG
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 05:18:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58884)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jSzt3-0006AA-7K
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 05:17:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jSzt1-00055K-UN
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 05:17:13 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:50581)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jSzt1-00054i-HL
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 05:17:11 -0400
Received: by mail-wm1-x341.google.com with SMTP id x25so18708235wmc.0
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2020 02:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Wszc89ZIemuCG9vRIPyBLEUU/smFSvpiVxNA6oFQXOA=;
 b=R658BW7mbdsbH1r41UKR+sSVbymF3FGH9GJcknupqM0M1gOex8xXr2Q/gKcrSc3m4D
 rrYnO7nJ5hRSDzoyBbrdcpbDGanfAqL5HMTUbPd8Hh05EWvAuE8nbizBBwBJTdzNl3ma
 Abgl4S14NbO6YBpiyC68BWlMpLXYrFkFC7/Aprim3trmAk8k4j7jQE20+NKJi+vdx7D6
 FVraSD2R8u4YSpKBNCYhLz7Zk5uUsZrPfu9WR5jpsMzt+WamZVsSfLaYHHs2gYhabjAM
 GLNpU0w5cPQFX7krlNHIlndj39rR642DOLsaCRu5xV0clAWtw4KN7yGpBCl0quaSl1cX
 d7Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=Wszc89ZIemuCG9vRIPyBLEUU/smFSvpiVxNA6oFQXOA=;
 b=RoViXmSwSuH/rj+TJIrRFuTZaSdM7I3RYBBw+Q37KjoZ7xdmyZJ+uIn5AUxvCjzJws
 Zp17s+ZGzWKKWNNjRthozwheig//bD2H8qEx/Vi+baMk0f1q8pjoOBW3a2/0DCtGcSXH
 VZ+0XN6bMMCdIaVOJU6RiE4reo0D4DbmET9NeomZoTfUNr2xTtt2RDVFSB3HXPhiisHT
 KiHyvI8WB276D8Wdf+bPaByG5Ilf6dFwy18GA9Bon0NrLNKvNZQngi+tacqcUYIIuh0x
 Ad0aPpz+rAnTouXJ0xbJYJqeYapAqyhAnjepcbJg3biLom99XoWkjJ+c94FkZJQNw/1o
 HHBA==
X-Gm-Message-State: AGi0PuYs/y99G6m55913VlXPYb94K2FPMyizY2oTOK5OwgEclTSvdHow
 Xs8i47fyuTHWyyiuULJ7Bac=
X-Google-Smtp-Source: APiQypLf5kUZuq1qOMxklbSpmKG5O7SghZZ4GW4ljUFyi110NwZhelZN+ovq3VQAGuJLs/4dhDgTXQ==
X-Received: by 2002:a1c:98c3:: with SMTP id
 a186mr25070347wme.178.1587979028205; 
 Mon, 27 Apr 2020 02:17:08 -0700 (PDT)
Received: from [192.168.1.39] (137.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.137])
 by smtp.gmail.com with ESMTPSA id l4sm20715812wrv.60.2020.04.27.02.17.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Apr 2020 02:17:07 -0700 (PDT)
Subject: Re: [PATCH 10/11] arm/sabrelite: Consistently use &error_fatal in
 sabrelite_init()
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200424192027.11404-1-armbru@redhat.com>
 <20200424192027.11404-11-armbru@redhat.com>
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
Message-ID: <51d79dca-a352-ce14-1f51-9f10e36f4ea3@amsat.org>
Date: Mon, 27 Apr 2020 11:17:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200424192027.11404-11-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jean-Christophe Dubois <jcd@tribudubois.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/24/20 9:20 PM, Markus Armbruster wrote:
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Jean-Christophe Dubois <jcd@tribudubois.net>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  hw/arm/sabrelite.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/hw/arm/sabrelite.c b/hw/arm/sabrelite.c
> index e31694bb92..04f4b96591 100644
> --- a/hw/arm/sabrelite.c
> +++ b/hw/arm/sabrelite.c
> @@ -41,7 +41,6 @@ static void sabrelite_reset_secondary(ARMCPU *cpu,
>  static void sabrelite_init(MachineState *machine)
>  {
>      FslIMX6State *s;
> -    Error *err = NULL;
>  
>      /* Check the amount of memory is compatible with the SOC */
>      if (machine->ram_size > FSL_IMX6_MMDC_SIZE) {
> @@ -52,11 +51,7 @@ static void sabrelite_init(MachineState *machine)
>  
>      s = FSL_IMX6(object_new(TYPE_FSL_IMX6));
>      object_property_add_child(OBJECT(machine), "soc", OBJECT(s), &error_fatal);
> -    object_property_set_bool(OBJECT(s), true, "realized", &err);
> -    if (err != NULL) {
> -        error_report("%s", error_get_pretty(err));
> -        exit(1);
> -    }
> +    object_property_set_bool(OBJECT(s), true, "realized", &error_fatal);
>  
>      memory_region_add_subregion(get_system_memory(), FSL_IMX6_MMDC_ADDR,
>                                  machine->ram);
> 

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

