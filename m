Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA6D0C2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 09:23:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E8D522400
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 09:23:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AnROhhVI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E8D522400
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36994 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZsWu-00036u-1j
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 04:23:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60640)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1kZsVu-0002ax-Qe; Tue, 03 Nov 2020 04:22:02 -0500
Received: from mail-ej1-x644.google.com ([2a00:1450:4864:20::644]:32836)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1kZsVp-0003FV-Ca; Tue, 03 Nov 2020 04:22:02 -0500
Received: by mail-ej1-x644.google.com with SMTP id 7so23125641ejm.0;
 Tue, 03 Nov 2020 01:21:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=VZGdbd6PfgqXysXvFRLP0E425CHntjnZXgWfm24fL20=;
 b=AnROhhVIpRbRxbBdNyp2Sa3JNc7EpbAIN5fr/FQFODse2vvrDZOuZt9VRVv7lZqUHK
 EpmiRXUZgep7PNRd5gHbd+QE+wjeofHpGqbRUoLrnL995iKRbKt2I+TwQZnYTSLEfYwv
 J6h8Lx+2L4/dLOgDok0ti/cP3nsnd6zTzZ0KaG4tQJ089L/Wmeo2hnUeJj+J8I2Bpo0a
 Z9k/yUL9MCvQq1Cg7YC2rmz02jEQrDMUMLYumvmLAOlgqE0X6JthfSkZXIeUK3TBxcws
 Z3U2oCK850eYGIZYij56jigmJT/fENZEeVHLYpRjVqbp8XWX2YnwQ5bGh6uXPHZpz4Kq
 i/Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=VZGdbd6PfgqXysXvFRLP0E425CHntjnZXgWfm24fL20=;
 b=oNEX7R6p99CqxsQHSLJ28yA4++jqNeDTOcJpwtsUPwp8diZwKQa+f6I88c3tl6uLar
 4HpHZRHvugqshdaQEBn82fgpGAqLZAKUfQf9wCvcr6Oj7hGaY375yHHpN3OqqU/7T5DL
 rgqYl3QmC/0PiLsvkw/Q0PC1QJGXBn0BIpEwsTAgZdD2dTKk15hqbx9JlL0ApgUxew5V
 GwaNbN0anTFCIzQTzGsFPMblP+bmIrp65+S5kpxeZDtXbaoU99LwIGfnxOuwz+GBBrJk
 pNN8nsCAuWk1W/2xxJo1ZjQ9yYBEWFH3f9clg9OW/Ieb3pyw5aGUExpcMyTqeGEMcYX1
 xOQg==
X-Gm-Message-State: AOAM531eUmoFU6B5JlY18sjGRyUygdGXzTB1276HD4tufsrU0inUkRs5
 rUw21P8dYPli3D//pLtrhjbQHdZE5EG7fuYwoCQ=
X-Google-Smtp-Source: ABdhPJycVQ8+SLiEekkGveLsyb3z0+N2W80JhbqbIsaYvIcAVSl7Ro9cimtgHU5tyZeey0JW6VBphQXMJVetNdoYH0s=
X-Received: by 2002:a17:907:119e:: with SMTP id
 uz30mr18801418ejb.125.1604395314766; 
 Tue, 03 Nov 2020 01:21:54 -0800 (PST)
MIME-Version: 1.0
References: <20201103015228.2250547-1-kuhn.chenqun@huawei.com>
 <20201103015228.2250547-2-kuhn.chenqun@huawei.com>
In-Reply-To: <20201103015228.2250547-2-kuhn.chenqun@huawei.com>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Tue, 3 Nov 2020 01:21:43 -0800
Message-ID: <CAMo8BfK5wDgvzWFsC0WHyztUCiGR0dGnJgJiAVt5aG7nt8PsDw@mail.gmail.com>
Subject: Re: [PATCH 1/6] target/xtensa: fix uninitialized variable warning
To: Chen Qun <kuhn.chenqun@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::644;
 envelope-from=jcmvbkbc@gmail.com; helo=mail-ej1-x644.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_LOCAL_NOVOWEL=0.5, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.374,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>,
 Euler Robot <euler.robot@huawei.com>, qemu-devel <qemu-devel@nongnu.org>,
 ganqixin@huawei.com, zhang.zhanghailiang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Nov 2, 2020 at 5:52 PM Chen Qun <kuhn.chenqun@huawei.com> wrote:
>
> The compiler cannot determine whether the return values of the xtensa_ope=
rand_is_register(isa, opc, opnd)
>  and xtensa_operand_is_visible(isa, opc, opnd) functions are the same.

It doesn't have to because 1) they definitely are not the same, but
2) it doesn't matter.

> So,it assumes that 'rf' is not assigned, but it's used.

The assumption is wrong. rf is used under the 'if (register_file)'
condition and register_file is initialized to NULL and then set
to something non-NULL based on the value of rf here:

958             if (xtensa_operand_is_register(isa, opc, opnd)) {
959                 rf =3D xtensa_operand_regfile(isa, opc, opnd);
960                 register_file =3D dc->config->regfile[rf];

> The compiler showed warning:
> target/xtensa/translate.c: In function =E2=80=98disas_xtensa_insn=E2=80=
=99:
> target/xtensa/translate.c:985:43: warning: =E2=80=98rf=E2=80=99 may be us=
ed uninitialized in this function [-Wmaybe-uninitialized]
>   985 |                     arg[vopnd].num_bits =3D xtensa_regfile_num_bi=
ts(isa, rf);
>       |                                           ^~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~
>
> Add a default value for 'rf' to prevented the warning.

I don't see it doing default build with gcc 8.3. But then I don't see
-Wmaybe-uninitialized in the compiler command line either.

> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Chen Qun <kuhn.chenqun@huawei.com>
> ---
> Cc: Max Filippov <jcmvbkbc@gmail.com>
> ---
>  target/xtensa/translate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
> index 944a157747..eea851bbe7 100644
> --- a/target/xtensa/translate.c
> +++ b/target/xtensa/translate.c
> @@ -953,7 +953,7 @@ static void disas_xtensa_insn(CPUXtensaState *env, Di=
sasContext *dc)
>
>          for (opnd =3D vopnd =3D 0; opnd < opnds; ++opnd) {
>              void **register_file =3D NULL;
> -            xtensa_regfile rf;
> +            xtensa_regfile rf =3D -1;

Please use XTENSA_UNDEFINED instead if you still think this
is worth changing.

--=20
Thanks.
-- Max

