Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 294C5C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 03:52:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7DC72072B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 03:52:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UUDL205M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7DC72072B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ih3u6-0007bK-31
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 22:52:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46251)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ih3tV-0007AA-Ru
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 22:51:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ih3tS-0000Z1-8k
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 22:51:31 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:25640
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ih3tR-0000Xh-Fn
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 22:51:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576554688;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g+w0FzAQhrZl8Ajz1Kp/wqnX3gHQatWwO+/JdkIuCAQ=;
 b=UUDL205Mm6YPwJv2UpcUIvhcwSLWHxk2LP860T9s/ZrPpwI6q1WDOvSwWPDcEkHpre58L3
 uuX+u9BTlMyeEfVF/ONI+8yPPli3/ktICzfPdDaEU6b4JXqftYpmdH0b6IpQ7gFgvrR93u
 VEyLFHPuDGWIj3p1tcQI2wek9F8odPo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-245-ZciL-z6pMliqttRXbM8NYw-1; Mon, 16 Dec 2019 22:51:26 -0500
Received: by mail-wm1-f71.google.com with SMTP id t16so382840wmt.4
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 19:51:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=kDlrMdJgm8yQIs92Q7NpuaVYfJi9XM5pf+oHy93XNtk=;
 b=affd5SfYw6hCLBI1WKUPe7/H+7annZJ5OOjGi7z3nOwPMRKNVBmRc1noMmdbI/3jkP
 7ezIPTfJHCJUf+TyOSqPtSc884A1+cAVcabLzpLnbmveUMWhUltkGwuQgrR4BJP2NcMY
 KLaAOByR5b76efLCAXN9AgT9Q8JmyForl55s8hmdksn0aahflmAxC6xWMWGul7q6f/wE
 KJhZRkd7rOJCcQqZY34KqOr7J33fDPKq3Gm/DHV9heQPp3UGOHYreNTzbro8Lgsmj/4C
 qDNYwS6IxDSHsJuGJz6B5duPaHv0J0hCmozD6P12e1K09ehskwRIZ1bx8JBOslwiOYG+
 LZAQ==
X-Gm-Message-State: APjAAAXDzVQRlyBBFFYtqBxVo/7Smh9Nvxnv8ZIqwAyiVs22CP6z0Hw1
 YxNBlceJE4AeaCA5Z/nof4omBPpXEveHyl5on59eaJfCace+m+XoxNDABxZllDkThVXlBn2ZyB4
 A/NUKBRkVgicR78s=
X-Received: by 2002:a1c:67c3:: with SMTP id b186mr2678373wmc.36.1576554685851; 
 Mon, 16 Dec 2019 19:51:25 -0800 (PST)
X-Google-Smtp-Source: APXvYqwm+gNFmETBv2vQY6eLvoGJCr9/r+EBGsLKnd9+TWJ9f33SWVDp0b8r6gTEPM2Am8buXdsGdw==
X-Received: by 2002:a1c:67c3:: with SMTP id b186mr2678357wmc.36.1576554685663; 
 Mon, 16 Dec 2019 19:51:25 -0800 (PST)
Received: from [192.168.1.35] (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id y6sm23784271wrl.17.2019.12.16.19.51.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Dec 2019 19:51:25 -0800 (PST)
Subject: Re: [PATCH v2 01/28] target/xtensa: Use probe_access for itlb_hit_test
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20191216221158.29572-1-richard.henderson@linaro.org>
 <20191216221158.29572-2-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <12e2d8b5-3101-5cf5-9458-196dde68a287@redhat.com>
Date: Tue, 17 Dec 2019 04:51:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191216221158.29572-2-richard.henderson@linaro.org>
Content-Language: en-US
X-MC-Unique: ZciL-z6pMliqttRXbM8NYw-1
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
Cc: Max Filippov <jcmvbkbc@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/16/19 11:11 PM, Richard Henderson wrote:
> We don't actually need the result of the read, only to probe that the
> memory mapping exists.  This is exactly what probe_access does.
>=20
> This is also the only user of any cpu_ld*_code_ra function.
> Removing this allows the interface to be removed shortly.
>=20
> Acked-by: Max Filippov <jcmvbkbc@gmail.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/xtensa/mmu_helper.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/target/xtensa/mmu_helper.c b/target/xtensa/mmu_helper.c
> index f15bff306f..b01ff9399a 100644
> --- a/target/xtensa/mmu_helper.c
> +++ b/target/xtensa/mmu_helper.c
> @@ -63,10 +63,11 @@
>   void HELPER(itlb_hit_test)(CPUXtensaState *env, uint32_t vaddr)
>   {
>       /*
> -     * Attempt the memory load; we don't care about the result but
> +     * Probe the memory; we don't care about the result but
>        * only the side-effects (ie any MMU or other exception)
>        */
> -    cpu_ldub_code_ra(env, vaddr, GETPC());
> +    probe_access(env, vaddr, 1, MMU_INST_FETCH,
> +                 cpu_mmu_index(env, true), GETPC());

TIL probe_access

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

>   }
>  =20
>   void HELPER(wsr_rasid)(CPUXtensaState *env, uint32_t v)
>=20


