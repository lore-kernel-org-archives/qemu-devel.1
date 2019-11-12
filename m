Return-Path: <SRS0=1YIe=ZE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A643C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 08:51:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24AD9204FD
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 08:51:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D3e7Ngpb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24AD9204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60220 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iURts-0003rW-9Z
	for qemu-devel@archiver.kernel.org; Tue, 12 Nov 2019 03:51:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42756)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sgarzare@redhat.com>) id 1iURt9-0003DJ-QP
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 03:51:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sgarzare@redhat.com>) id 1iURt7-0007Tu-VC
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 03:51:02 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:50423
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1iURt7-0007Ru-On
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 03:51:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573548660;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5/RvMuKipRpPpiNkOqI72IfHT9GibEFu55jXd29JQOY=;
 b=D3e7Ngpb9Oa3WDscHF2Yh2lCM8Yp83sLZpjFnTt2AfE7sD9HsFTf9d0exnCmxvAJibzeBh
 e2dKYK+93JYh585Lin6Fkjx00KSHnfA6lmCieKfUCKAtrMMCBkgkVUMS1i+nLnuA/E1Bia
 3lbEdhOat9RhA/LZUCWIq2AmI9jm8J0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-260-PMyPdvSIP6GrmopwjJ_crA-1; Tue, 12 Nov 2019 03:50:59 -0500
Received: by mail-wm1-f72.google.com with SMTP id 2so1139964wmd.3
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2019 00:50:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=JXq5q5nipawCI6hrIPeaH4pQMRhVGB8dTJVEqmrsRYE=;
 b=p2iXy3sNEZ5OBL2Gulejwvv/o33mYM+kBISLUbwTPcd0rJypcWnF//6IjFnKPgTy8z
 cWjJjEMcMh1ii9NaZnx530m3O25nENnSfrxiURmx5oVOYlR+zjACLHcAiP12XV6NAXQq
 xAJ1tIDCoaGDFP2TYrUesRWzVAmGhYWp/2FWdHV6db5/hCpfbyn+eCFoHTTfpcZgpWNO
 qN7JLUT9YluOYFRUAyneu/BIi3Y89ZCQCT0TCVju7VkMJgBPZVXTbKcZRTOqdIyb0I6P
 VQhjAQxaA6sEc92b+mYg9dBnfLaH/deVSS2li36RFVxpr8mZvyNejA+XAL0TdY4wikMf
 OQ1Q==
X-Gm-Message-State: APjAAAUitjrP5cW8VfPhOFz3NoJPVNprlQ2rZE/znfMq2r4HW1I2LjTO
 89Mi71zyl8lizjFTdDd7O5ABdI4WkGeGG3SheCOsLyIi8yq8bV/Px9EAckAh2TpqknBYhgOT91p
 ZNCXmQQ8OpHMztuo=
X-Received: by 2002:adf:edc5:: with SMTP id v5mr1644056wro.322.1573548658315; 
 Tue, 12 Nov 2019 00:50:58 -0800 (PST)
X-Google-Smtp-Source: APXvYqxS1IVHMm1VruqXL8hXZMOrISjiUfKhM3IH0wzeKV2tZkk1z6S1mIn/QCoZ7tlL2NCF5jBKaQ==
X-Received: by 2002:adf:edc5:: with SMTP id v5mr1644031wro.322.1573548658011; 
 Tue, 12 Nov 2019 00:50:58 -0800 (PST)
Received: from steredhat (a-nu5-32.tin.it. [212.216.181.31])
 by smtp.gmail.com with ESMTPSA id u18sm11182611wrp.14.2019.11.12.00.50.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Nov 2019 00:50:57 -0800 (PST)
Date: Tue, 12 Nov 2019 09:50:55 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH qemu] scripts: Detect git worktrees for get_maintainer.pl
 --git
Message-ID: <20191112085055.2ghx2g2kshtfl6hv@steredhat>
References: <20191112034532.69079-1-aik@ozlabs.ru>
MIME-Version: 1.0
In-Reply-To: <20191112034532.69079-1-aik@ozlabs.ru>
X-MC-Unique: PMyPdvSIP6GrmopwjJ_crA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Nov 12, 2019 at 02:45:32PM +1100, Alexey Kardashevskiy wrote:
> Recent git versions support worktrees where .git is not a directory but
> a file with a path to the .git repository; however the get_maintainer.pl
> script only recognises the .git directory, let's fix it.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
>  scripts/get_maintainer.pl | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20

Tested-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks,
Stefano


> diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
> index 71415e3c7061..27991eb1cfb4 100755
> --- a/scripts/get_maintainer.pl
> +++ b/scripts/get_maintainer.pl
> @@ -81,7 +81,7 @@ my %VCS_cmds;
> =20
>  my %VCS_cmds_git =3D (
>      "execute_cmd" =3D> \&git_execute_cmd,
> -    "available" =3D> '(which("git") ne "") && (-d ".git")',
> +    "available" =3D> '(which("git") ne "") && (-e ".git")',
>      "find_signers_cmd" =3D>
>  =09"git log --no-color --follow --since=3D\$email_git_since " .
>  =09    '--format=3D"GitCommit: %H%n' .
> --=20
> 2.17.1
>=20
>=20

--=20


