Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EE65C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 19:23:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B4172065E
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 19:23:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nsLPn2XX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B4172065E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jz3IG-0000KW-CS
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 15:23:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36572)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jz3Hf-0008CR-70
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 15:23:07 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:45214)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jz3Hd-0001Pt-JD
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 15:23:06 -0400
Received: by mail-wr1-x442.google.com with SMTP id z18so5687061wrm.12
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2020 12:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=4+JW6DsLIDKiJyQ3lJleFJbrLCX8nVpqLZYAu0vMMGk=;
 b=nsLPn2XXx7a2viIDMwqnSuNAACvQiSM2W+r+kQ6XsjTUtenqjz3CkW4VizAxJGLUZe
 AWRCazKjXKamw2KpmFoj3uLKzBW7YrG2nNxYYj8Kv2DC4NkYghQZ/JHx5R6XweDFK9se
 VN8vO1LZWbGhUbteRnTaIqDQtjcvpd2cYvSBOfPG0elqWtQYc4jzhJo6HXOylHvCeM+V
 LGYAjEYWTmVdjFH6loxJEjRImhd8g9/nXNGLV4D3rFwExF/lD5lKU+eCg62gbfhJbyIl
 dDsohjWBeJZDSEW2jmRNeAmxVzB+aofgdumI7VzupSmdiEecUyInBjbAootJsuUwIeoL
 Qtzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=4+JW6DsLIDKiJyQ3lJleFJbrLCX8nVpqLZYAu0vMMGk=;
 b=jypioDvgxKb+WmKc0rmOuPL0A+YuNkvSa8macAnK1AiaZEDDr7ZGnQHVnzCkdqKF7Q
 BNMg/weJpu/vgeHHyKellkFRag9G1idFVDb38W9R4dbnlMoLJ67dmApx+F0GQ3umRLiQ
 wAKLBaLqvwYZjNS5PPNjmVDDbrur3QZB+hq4vsX3jS38BaSWPY3r0ag/nVXZZh2n+W31
 WjtuXHZtI3zYsBZnyLwJKxoA0nygETm9MewN7Ymp6M85vUs2udU+t6wcrn4fQ22ienBr
 Uz0/g+XcQ4JlrzxV8lvQrmuWhv5+aTxGQoby0Ozl7N+BqdNPBP/lzT9SHTxdk1xEz+jJ
 i/Zw==
X-Gm-Message-State: AOAM532VHrr0inQO5dOxLY58el2HCZ+q5fYMQrf5Wh+Pwr6OMop7s4rq
 iLg8Bi+1Mb5ZKq8gIYIUkJY+Ag==
X-Google-Smtp-Source: ABdhPJzrg1IkZcV9+TN5WVcP3TlDvIJzlVwoNrn8i8/mxWCI2WgzmZNPTpgfrmm9XJ4FQ78DzikiMg==
X-Received: by 2002:adf:cd12:: with SMTP id w18mr10042329wrm.352.1595618583185; 
 Fri, 24 Jul 2020 12:23:03 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id k4sm2416350wrd.72.2020.07.24.12.23.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2020 12:23:01 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 123501FF7E;
 Fri, 24 Jul 2020 20:23:01 +0100 (BST)
References: <20200720154028.477457-1-richard.henderson@linaro.org>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH for-5.1?] target/i386: Save cc_op before loop insns
In-reply-to: <20200720154028.477457-1-richard.henderson@linaro.org>
Date: Fri, 24 Jul 2020 20:23:01 +0100
Message-ID: <87mu3osooa.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: pbonzini@redhat.com, ehabkost@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> We forgot to update cc_op before these branch insns,
> which lead to losing track of the current eflags.
>
> Buglink: https://bugs.launchpad.net/qemu/+bug/1888165
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/i386/translate.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/target/i386/translate.c b/target/i386/translate.c
> index a1d31f09c1..caea6f5fb1 100644
> --- a/target/i386/translate.c
> +++ b/target/i386/translate.c
> @@ -7148,6 +7148,7 @@ static target_ulong disas_insn(DisasContext *s,
> CPUState *cpu)

At first I thought that was too broad to go in disas_insn and then I
realised it was one of those mega functions....

>              l1 =3D gen_new_label();
>              l2 =3D gen_new_label();
>              l3 =3D gen_new_label();
> +            gen_update_cc_op(s);


Seems legit:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
<snip>

--=20
Alex Benn=C3=A9e

