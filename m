Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B0B1C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 19:27:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 586AE206E2
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 19:27:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BhyUQg2Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 586AE206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgCZR-0003nX-Iq
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 15:27:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59770)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jgCYR-0002PY-9M
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 15:26:31 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:52532)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jgCYQ-0004mY-6W
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 15:26:31 -0400
Received: by mail-wm1-x341.google.com with SMTP id r9so4033589wmh.2
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2020 12:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=BUz08mOTMK/RI8WM+T3/lxGD8VrI4cXhjKsACMNSXL8=;
 b=BhyUQg2Zm8AK0w1GEkNkmZIiRmlPABoY0RL+Um9PwG47zd9E3xunQMVd0Qf9Xep0mW
 B/DI4EHv2chA7yN+8TvZj6i6nK5ShyKEIOuSVmZpj+f+OSrjVw1S5MWoERQdK7QltnJg
 Fwa4q5hsNF9Q94R0ifP+0IDV+ReTjHllQ39wUDUMiV15nD79eLXLim9Qx7NxaBQKXlj1
 gWFSeEugRH4R8ri604rWzdYOBt/Z6SULZf37EjbulGtoM+5lGWtrwSUswvrO5L7aRfJP
 K9Ck3P50qb88RGqWhDjVtZ5ZeDxHKFI1NIIARU+AmwtOf2YA7rU4ah+nR1OfG7ogziN2
 Ef0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=BUz08mOTMK/RI8WM+T3/lxGD8VrI4cXhjKsACMNSXL8=;
 b=qyMpsINqWJAFUl0J5DIYOwGDSBvcm+c1j2TebpCLnqmkdZBB+KpFtH3YGzvGWAfjjo
 X21/ELyhjBx05//PnwFXKU1FZ96fJ6+jN0Pam2sqv7VZcmy+gdpNyStL4nFhjsvDvVqE
 x9E6BAkIcUnydv5VsGona0Q20vnp5FDO9dDBF58P3oWYPBeOwOFswSf0bxBHX4Fhfuwr
 wUbSfWLRiLEzpCPY33C5FMWJLMjYgB9RsAoExEHf8PSf1wrsLtHBI7SKscD15171k6rh
 L2ilEvvd0LMGdvl38GVBAT+KpfdGQutlbcYC9vbK9YJh9mwtjGm7zk/Hz2cHGI2SITIU
 bC8A==
X-Gm-Message-State: AOAM530QIDH1REwd2PJXF2n2wxEt8bSvalcMod0mWYIeJ47zbXgkOIjf
 YD9S86lETuZSzFhpMxyR/ccfHg==
X-Google-Smtp-Source: ABdhPJxh9451GsRVGhE9C0InVokF25o1p+xly8lbidSGOYac+l2g0Ecjt7H3m0l2GlPb2jmLu1oIYA==
X-Received: by 2002:a1c:2082:: with SMTP id g124mr5709345wmg.21.1591125988741; 
 Tue, 02 Jun 2020 12:26:28 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id p7sm5323795wro.26.2020.06.02.12.26.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2020 12:26:27 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D88101FF7E;
 Tue,  2 Jun 2020 20:26:26 +0100 (BST)
References: <20200529132341.755-1-robert.foley@linaro.org>
 <20200529132341.755-5-robert.foley@linaro.org>
User-agent: mu4e 1.5.1; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Robert Foley <robert.foley@linaro.org>
Subject: Re: [PATCH v1 05/12] qht: call qemu_spin_destroy for head buckets
In-reply-to: <20200529132341.755-5-robert.foley@linaro.org>
Date: Tue, 02 Jun 2020 20:26:26 +0100
Message-ID: <875zc96zh9.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: peter.puhov@linaro.org, cota@braap.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Robert Foley <robert.foley@linaro.org> writes:

> From: "Emilio G. Cota" <cota@braap.org>
>
> Signed-off-by: Robert Foley <robert.foley@linaro.org>
> ---
>  util/qht.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/util/qht.c b/util/qht.c
> index aa51be3c52..67e5d5b916 100644
> --- a/util/qht.c
> +++ b/util/qht.c
> @@ -348,6 +348,7 @@ static inline void qht_chain_destroy(const struct qht=
_bucket *head)
>      struct qht_bucket *curr =3D head->next;
>      struct qht_bucket *prev;
>=20=20
> +    qemu_spin_destroy(&head->lock);
>      while (curr) {
>          prev =3D curr;
>          curr =3D curr->next;

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>


--=20
Alex Benn=C3=A9e

