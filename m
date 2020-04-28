Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 167CEC83000
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 07:58:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE7AB2053B
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 07:58:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ij1xZWAo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE7AB2053B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45500 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTL8b-0007eP-VV
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 03:58:42 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45744)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jTL5d-0006A8-5f
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 03:57:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jTL1a-0002Ku-6w
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 03:55:36 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:36147)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jTKwb-0007e7-I2; Tue, 28 Apr 2020 03:46:17 -0400
Received: by mail-wr1-x443.google.com with SMTP id d15so21803105wrx.3;
 Tue, 28 Apr 2020 00:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=IiCmi3gnLXnh9qqh5SktG6taFgc0wMvCmCpUJaLx16Q=;
 b=ij1xZWAoThDbPF82cYrzoVl2fWa1BCrpruAPyHehHVau+19zxuC7890n77NUx2OAfV
 c9ZVY7wVT5MHljQIAQ6ymi1jjRiklJ2WBKqTc0K467AQLmHl40+B1z07p01dwcqfMUbt
 nVgIhbbbrDldObkGX5wfVCqpoEIfht7ATF4zPtin3X3g7cuOz2eB2L3IvZCxLy93hdrP
 s20abzu3OCAFx+ZtwuXPVpneX7HTBSugORfxk6DHcKIaHfOMd53Zi7WuApjlAbVzIJ0a
 fPYX32paKHq0TNoDMS+LUdFxU5mdm4QKjPBBoFIbVvp+QNUwAXAKDcbe/2tqy5tQBfig
 /y0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=IiCmi3gnLXnh9qqh5SktG6taFgc0wMvCmCpUJaLx16Q=;
 b=am61547DW4OywH+NuFS5mN79MlJu/olhS9344Ihd1kpSWKOz7DlqE2CCNPKhjhfnpu
 APIwtFiKON63vRArwPfggg/RuBnxu2BTcMfYmd+H6wEewhfdWtN7U08b7mv0cFxSVsWw
 gGjgPkkTODgPc26L0LiZ9rqmjWBsQw7/k6JkLF8zaLC09fg+VE/OftWFMxp3yRJqdSev
 fmBDfpJMcEX7cJ0v68np7MFCPrQIhyp1eK7sxP8nH+rseXtI29nj64qLNRHS+rxGLdiP
 cX6lI3XZG13orjsuJi5aZ2uNvCADezCatKz4sFk1uVXh+ibNXeYXCctDjQV/aKv2Mqsi
 4IMw==
X-Gm-Message-State: AGi0Pua7WWqIE9nqdNZoNUXwABDtQv5MgqKlTVNRm7Bi2AmdV1kU9yJE
 yMIr/shFH1GXtIRmjY0Kvxg=
X-Google-Smtp-Source: APiQypJapOMYClJ2UWMZtR/iiZfUOWzUZ/0TLevhro7UmG/lZFF04wLQve1R8rHLGiOMS0RIxquczQ==
X-Received: by 2002:adf:f884:: with SMTP id u4mr31105349wrp.171.1588059975401; 
 Tue, 28 Apr 2020 00:46:15 -0700 (PDT)
Received: from [192.168.1.39] (137.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.137])
 by smtp.gmail.com with ESMTPSA id f8sm24315068wrm.14.2020.04.28.00.46.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Apr 2020 00:46:14 -0700 (PDT)
Subject: Re: [PATCH v1 02/11] hw/arm: versal: Move misplaced comment
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-devel@nongnu.org
References: <20200427181649.26851-1-edgar.iglesias@gmail.com>
 <20200427181649.26851-3-edgar.iglesias@gmail.com>
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
Message-ID: <96c06a2f-bda9-b74b-5f2b-818f32e2a790@amsat.org>
Date: Tue, 28 Apr 2020 09:46:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200427181649.26851-3-edgar.iglesias@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::443
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
 philmd@redhat.com, luc.michel@greensocs.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/27/20 8:16 PM, Edgar E. Iglesias wrote:
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
> 
> Move misplaced comment.
> 
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
> ---
>  hw/arm/xlnx-versal.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
> index c73b2fe755..cc696e44c0 100644
> --- a/hw/arm/xlnx-versal.c
> +++ b/hw/arm/xlnx-versal.c
> @@ -36,7 +36,6 @@ static void versal_create_apu_cpus(Versal *s)
>  
>          obj = object_new(XLNX_VERSAL_ACPU_TYPE);
>          if (!obj) {
> -            /* Secondary CPUs start in PSCI powered-down state */
>              error_report("Unable to create apu.cpu[%d] of type %s",
>                           i, XLNX_VERSAL_ACPU_TYPE);
>              exit(EXIT_FAILURE);
> @@ -49,6 +48,7 @@ static void versal_create_apu_cpus(Versal *s)
>          object_property_set_int(obj, s->cfg.psci_conduit,
>                                  "psci-conduit", &error_abort);
>          if (i) {
> +            /* Secondary CPUs start in PSCI powered-down state */
>              object_property_set_bool(obj, true,
>                                       "start-powered-off", &error_abort);
>          }
> 

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

