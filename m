Return-Path: <SRS0=Kewn=DL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D6E5C4363C
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2020 23:32:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2037206C3
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2020 23:32:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FV+IWSTM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2037206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39262 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPDUW-0004YO-Kv
	for qemu-devel@archiver.kernel.org; Sun, 04 Oct 2020 19:32:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35268)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsoffer@redhat.com>)
 id 1kPDTT-000458-L5
 for qemu-devel@nongnu.org; Sun, 04 Oct 2020 19:31:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26999)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <nsoffer@redhat.com>)
 id 1kPDTR-0001wi-Ay
 for qemu-devel@nongnu.org; Sun, 04 Oct 2020 19:31:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601854283;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l4RcQQJWx2zS8/1ahbSl+mtd1WL3GRlTUQGx7zjjBx4=;
 b=FV+IWSTM2S2POhbdBJ0EJ2vtsXcLX8Ma6rFsA+fisx8CNUgRETFA19Dz+wN0XADDH3Cctj
 gyWEkgyNqNXk2q6ZEihRseeJQQJaO8GaQERoRt4qU1Sm2h0cMdLAq++6v6RuyqZPgBwCfA
 SYm5M9IXYMqcFqGIO2991pMhJEIkYns=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-135-fsPhXk54M3aON6rO7RUd4g-1; Sun, 04 Oct 2020 19:31:21 -0400
X-MC-Unique: fsPhXk54M3aON6rO7RUd4g-1
Received: by mail-oo1-f72.google.com with SMTP id r3so4328461ooq.2
 for <qemu-devel@nongnu.org>; Sun, 04 Oct 2020 16:31:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=l4RcQQJWx2zS8/1ahbSl+mtd1WL3GRlTUQGx7zjjBx4=;
 b=pKDiReQas6vRGh5eIY0elhh119cW7ZArcOFQp8abqnG2cKL6U24ISHSWICsUAvawve
 KgvSIA0fbIZ6CYA/yFdmBxQu+Uj3YfSyzaci+Jh8aPxj+ddd6Qp+5v7n+o9VwiqCH0az
 2lfmJuvrmpVevDjNfmwMgHfdSzljV7cXDrQ+qHRYzrTf8NOTvP84FPCQhMSb+Xs/dIVM
 Z0d8MPLQbTArxub7e7SYekXmec39EPHq6EkFGdBHhaLVVSwi6uIZi1gTURfdjAYWkOuD
 LpQbNmK8uCboJyXtGHfzh5b7pa5wYRJAxpmTxxx+vawxSTxwDM4xLAQifClkeD0WgHIT
 0sVQ==
X-Gm-Message-State: AOAM533XBlUImF2GnCEZRuf5pvCDV9sYijwZp/3wqeuFM8fORLMBWABC
 vrvljmb07OdStZ4KPWgSKN5mUabnqbV8yIoyzdsdk5XmHuQ0YLyF2iF8PpzLSm+7E5QDi8kLI5B
 1C9t8UkbSKbnbecXaciTMLOjMMjZz30E=
X-Received: by 2002:a9d:4cd:: with SMTP id 71mr8876419otm.276.1601854280424;
 Sun, 04 Oct 2020 16:31:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzEGHCxZSD3ttAk0ZV1tHQGYUKsZ2Xv2dacSBu90RRXjCEERn+CbUe/YviNor+B1d2KtnlO13Ni3hSsMV2pPw8=
X-Received: by 2002:a9d:4cd:: with SMTP id 71mr8876399otm.276.1601854280133;
 Sun, 04 Oct 2020 16:31:20 -0700 (PDT)
MIME-Version: 1.0
References: <20201004180443.2035359-1-f4bug@amsat.org>
 <20201004180443.2035359-14-f4bug@amsat.org>
In-Reply-To: <20201004180443.2035359-14-f4bug@amsat.org>
From: Nir Soffer <nsoffer@redhat.com>
Date: Mon, 5 Oct 2020 02:31:03 +0300
Message-ID: <CAMRbyysHTUT33FKt+eSoq8V73LOuvveA=W6yxO=J9U6Cu2w3Nw@mail.gmail.com>
Subject: Re: [RFC PATCH 13/21] contrib/gitdm: Add more entries to the Red Hat
 domain
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=nsoffer@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=216.205.24.124; envelope-from=nsoffer@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/04 19:31:23
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.745,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Frediano Ziglio <fziglio@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Nir Soffer <nirsof@gmail.com>,
 Frediano Ziglio <freddy77@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Oct 4, 2020 at 9:05 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org=
> wrote:
>
> Cc: Frediano Ziglio <freddy77@gmail.com>
> Cc: Frediano Ziglio <fziglio@redhat.com>
> Cc: Nir Soffer <nirsof@gmail.com>
> Cc: Nir Soffer <nsoffer@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
> To the developers Cc'ed: If you agree with your entry, please
> reply with a Reviewed-by/Acked-by tag. If you disagree or doesn't
> care, please either reply with Nack-by or ignore this patch.
> I'll repost in 2 weeks as formal patch (not RFC) with only the
> entries acked by their author.
> ---
>  contrib/gitdm/group-map-redhat | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/contrib/gitdm/group-map-redhat b/contrib/gitdm/group-map-red=
hat
> index d15db2d35e..0419e82795 100644
> --- a/contrib/gitdm/group-map-redhat
> +++ b/contrib/gitdm/group-map-redhat
> @@ -6,3 +6,5 @@ david@gibson.dropbear.id.au
>  laurent@vivier.eu
>  pjp@fedoraproject.org
>  armbru@pond.sub.org
> +freddy77@gmail.com
> +nirsof@gmail.com

Acked-by Nir Soffer <nirsof@gmail.com>

> --
> 2.26.2
>


