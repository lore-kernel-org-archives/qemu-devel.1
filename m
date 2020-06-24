Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06F7CC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 08:47:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C70DE2088E
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 08:47:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EKQRdFIQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C70DE2088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48946 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jo14X-0002KL-Vv
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 04:47:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48816)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dinechin@redhat.com>)
 id 1jo0vN-0002fk-LH
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 04:38:29 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26111
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dinechin@redhat.com>)
 id 1jo0vL-0002bx-Uo
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 04:38:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592987907;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vB0+TGMPvFpsPFAl/NhmlTbqS5r69JrqhbMCAxJyx7I=;
 b=EKQRdFIQJt6STghHlV+83rDfq/bYPdVL0bx2+odV0+Duq9f7QBlA5EW/Wk6NYCCpbUC70b
 lp4EsytI69xG+TUhchdmrTE9YfTHZU6cq0j6VK+0HlFb9pKn12oQ7iizaMApZZ9XgB7i+1
 HeXXBcabWvoFxYiVKAcIprvWL1Okf0g=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-163-CF6ou7qaPm6uObT894tmiQ-1; Wed, 24 Jun 2020 04:38:25 -0400
X-MC-Unique: CF6ou7qaPm6uObT894tmiQ-1
Received: by mail-wm1-f69.google.com with SMTP id c66so2050186wma.8
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2020 01:38:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=hIFhjT6uyZvlAAekKGA251eEdikZuCrpA9NtomezBN0=;
 b=lGUf91lQr2CuL6jdF8p2nkQSE2B4fwXO8LYZ2mskqsJ8P4CGn2vHRpJwligSosDhMw
 2UpaBsKqXq3mbmQE/eWyyiC7iJ62Q9hTsdl5iwEHQQrZSlulh9dGOsxpV5pHwjSO5C8J
 7bZQZ1rZV9s7Nsqp8tf83K/66vonfpXhRIUzlfUwqR7LEno2tIq0KIGZWwTVdSmNb2kz
 AP8b4wH55AtaaMteOLda5wWnW+ymOEXlJzubLLjXRAoK7CTaC9nxgSLVTor/2m0mBTdO
 R62CLTw6bMY5i8IfWyBROZeiQIh/3ZxpKIcQJICE2EKCy3N6DKMwn3JF19Nav6hz551F
 rK0g==
X-Gm-Message-State: AOAM530tAunDgxFBxB9hlK291hUtmJH6ptCGQA8x5Dc8C1frGOhalb0B
 QBBwv9UKu3u6a9OsHJ23f9X/HzTWkvH7wcImy5WSpI7h0fSCeS6TPDs97mSOq/RmwAI5mD19ILK
 JmfbE4ArfOihrtbM=
X-Received: by 2002:adf:e4d0:: with SMTP id v16mr17041841wrm.193.1592987904315; 
 Wed, 24 Jun 2020 01:38:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwqu5YLR4WmNogiz7GRuotM+N0WgB8Bn92lXTIRcdpURNx5VTGFwz+cjZ+UKL5TJCRuU5MfjA==
X-Received: by 2002:adf:e4d0:: with SMTP id v16mr17041808wrm.193.1592987904042; 
 Wed, 24 Jun 2020 01:38:24 -0700 (PDT)
Received: from ?IPv6:2a01:e0a:466:71c0:918b:168e:d1a7:f3b9?
 ([2a01:e0a:466:71c0:918b:168e:d1a7:f3b9])
 by smtp.gmail.com with ESMTPSA id p17sm6897836wma.47.2020.06.24.01.38.22
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 24 Jun 2020 01:38:23 -0700 (PDT)
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH] trivial: Remove extra character in configure help
From: Christophe de Dinechin <dinechin@redhat.com>
In-Reply-To: <20200624083337.912846-1-dinechin@redhat.com>
Date: Wed, 24 Jun 2020 10:38:21 +0200
Message-Id: <CC0192CB-4A6A-467C-B8A6-E4C418C79A52@redhat.com>
References: <20200624083337.912846-1-dinechin@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>,
 Laurent Vivier <laurent@vivier.eu>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=dinechin@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/24 02:33:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: qemu-trivial@nongnu.org, GitLab via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Please ignore. The =3DB appears intentional, even if it offsets the whole h=
elp text.

Maybe replace with =3DL to indicate a list is expected?

> On 24 Jun 2020, at 10:33, Christophe de Dinechin <dinechin@redhat.com> wr=
ote:
>=20
> Signed-off-by: Christophe de Dinechin <dinechin@redhat.com>
> ---
> configure | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/configure b/configure
> index ba88fd1824..c7a6a5adfe 100755
> --- a/configure
> +++ b/configure
> @@ -1787,7 +1787,7 @@ Advanced options (experts only):
>   --block-drv-ro-whitelist=3DL
>                            set block driver read-only whitelist
>                            (affects only QEMU, not qemu-img)
> -  --enable-trace-backends=3DB Set trace backend
> +  --enable-trace-backends=3D Set trace backend
>                            Available backends: $trace_backend_list
>   --with-trace-file=3DNAME   Full PATH,NAME of file to store traces
>                            Default:trace-<pid>
> --=20
> 2.26.2
>=20
>=20


