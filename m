Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69DA6C54FD0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 09:21:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E18EB20656
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 09:21:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O+q2i8XE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E18EB20656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jSzxP-0001pn-Rz
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 05:21:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59762)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jSzwg-0001GA-3V
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 05:20:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jSzwf-0006zK-IT
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 05:20:57 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:37445)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jSzwf-0006yd-5i
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 05:20:57 -0400
Received: by mail-wr1-x441.google.com with SMTP id k1so19677257wrx.4
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2020 02:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=h9gPIvg/cbjU8nzOKMB07hvh34O0JoW+0lGv6FfMUvo=;
 b=O+q2i8XEiVvICWK52dCkVCWnht3XpOWliGwJhiSZHzt+kAJukUb2cQ9ybjvBJAr/gx
 t0v8aWHx/zH1nSjyVA3WfQKkhhTeqUpoAS6m0eJbqigvKKFi36BZQcbeJkzBgPDGjXzu
 codYS/MeoY1YvLiasQtleYbMjL9+zTadNw0sSwcTExTdeBGouSM6tqPNihbj+711obyS
 DjWh2pZP/8X+IJqp2imacTGH13Q4K2LAiQjpwQL1l1pVqGRTmoEkvr53FpRaKrB4SX6c
 WA94KBAKHM2CWA0/mchbmdhsz5hsz6TTEGs/6CMv7cpSoWE+s/TlFKQwEXyCjP/qe8YR
 oEsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=h9gPIvg/cbjU8nzOKMB07hvh34O0JoW+0lGv6FfMUvo=;
 b=qHkk4wo/NdojAzTbXKmRwefz/iAkwVk73FCWw3iaUIwW2AuhYpJXO0kVsKfph8rx5I
 wG2mqc/6UIA86rO5E8gEsbyETUn9HqTNmZ7HmhN0u0Q+jBZVBUQcqoqafTFpMjBKJffn
 ncQLrpzMgbpJjVR+CZlVvSAzOXyOC/9B8NIMVCRh/oAGLyugoD37gwbLVD3EjUkBMdCK
 SfPq/JrQ5u/kQD9hcqVdQzCpISAMjD/GNmpNaekqc6v3LNNzcmOBZchI6DRL8JF+jOlt
 a6TEi/j24owGg7dMJsNpvrlGUi2sVB4V+h4u7R9SS8VkA2sdbxls433MwAvB5ypAezXU
 QkCA==
X-Gm-Message-State: AGi0PuYebSzl5fNEqDA8IRTdj5OmaPQgfQTrxNL+wchC5mj+2Na9Ps6S
 xEi9n5DeK2vV+7Tvb8FaXoI=
X-Google-Smtp-Source: APiQypIDKkbB7y+etZESC0cix6ghxnmD8uKL/J1HD6otKRrAbjORMmPW0rDOSb9rVS5O0xNX4Mpzmg==
X-Received: by 2002:adf:fa03:: with SMTP id m3mr26467779wrr.68.1587979255632; 
 Mon, 27 Apr 2020 02:20:55 -0700 (PDT)
Received: from [192.168.1.39] (137.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.137])
 by smtp.gmail.com with ESMTPSA id 74sm21134765wrk.30.2020.04.27.02.20.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Apr 2020 02:20:55 -0700 (PDT)
Subject: Re: [PATCH 07/11] mips/malta: Fix create_cps() error handling
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200424192027.11404-1-armbru@redhat.com>
 <20200424192027.11404-8-armbru@redhat.com>
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
Message-ID: <75dc4fbc-2b39-c8ef-8030-370672621c2f@amsat.org>
Date: Mon, 27 Apr 2020 11:20:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200424192027.11404-8-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::441
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
Cc: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/24/20 9:20 PM, Markus Armbruster wrote:
> The Error ** argument must be NULL, &error_abort, &error_fatal, or a
> pointer to a variable containing NULL.  Passing an argument of the
> latter kind twice without clearing it in between is wrong: if the
> first call sets an error, it no longer points to NULL for the second
> 
> create_cps() is wrong that way.  The last calls treats an error as
> fatal.  Do that for the prior ones, too.
> 
> Fixes: bff384a4fbd5d0e86939092e74e766ef0f5f592c
> Cc: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
> Cc: "Philippe Mathieu-Daudé" <philmd@redhat.com>
> Cc: Aurelien Jarno <aurelien@aurel32.net>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  hw/mips/mips_malta.c | 15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)
> 
> diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
> index e4c4de1b4e..17bf41616b 100644
> --- a/hw/mips/mips_malta.c
> +++ b/hw/mips/mips_malta.c
> @@ -1185,17 +1185,14 @@ static void create_cpu_without_cps(MachineState *ms,
>  static void create_cps(MachineState *ms, MaltaState *s,
>                         qemu_irq *cbus_irq, qemu_irq *i8259_irq)
>  {
> -    Error *err = NULL;
> -
>      sysbus_init_child_obj(OBJECT(s), "cps", OBJECT(&s->cps), sizeof(s->cps),
>                            TYPE_MIPS_CPS);
> -    object_property_set_str(OBJECT(&s->cps), ms->cpu_type, "cpu-type", &err);
> -    object_property_set_int(OBJECT(&s->cps), ms->smp.cpus, "num-vp", &err);
> -    object_property_set_bool(OBJECT(&s->cps), true, "realized", &err);
> -    if (err != NULL) {
> -        error_report("%s", error_get_pretty(err));

In https://www.mail-archive.com/qemu-devel@nongnu.org/msg695645.html I
also remove "qemu/error-report.h" which is not needed once you remove
this call.

> -        exit(1);
> -    }
> +    object_property_set_str(OBJECT(&s->cps), ms->cpu_type, "cpu-type",
> +                            &error_fatal);
> +    object_property_set_int(OBJECT(&s->cps), ms->smp.cpus, "num-vp",
> +                            &error_fatal);
> +    object_property_set_bool(OBJECT(&s->cps), true, "realized",
> +                             &error_fatal);
>  
>      sysbus_mmio_map_overlap(SYS_BUS_DEVICE(&s->cps), 0, 0, 1);
>  
> 

