Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15944C10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 10:51:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6CEF222D9
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 10:51:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ddn9wqec"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6CEF222D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57358 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBcUI-00006c-4T
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 06:51:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47274)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jBcHR-0001al-Ce
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 06:38:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jBcHQ-0006fw-1d
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 06:38:33 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:40935)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jBcHP-0006e4-P2
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 06:38:31 -0400
Received: by mail-wr1-x441.google.com with SMTP id p2so14348278wrw.7
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2020 03:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=KKkxfeELsCI57+jUUXb7wnduxs7fUd9hVi9x6ujerNw=;
 b=Ddn9wqec1zEgfDK4J1+Q7wyWni7tLSTayw4oVwASZ9OHRJzuXsCjTNZXibLUAkStiQ
 2MWp3MpLCPOrkL82Y7dYYidUsFcctswEv2JXPWGWNhfz8ahDPKS5yqAxHaq2GVFTONiv
 JroCcvvYOQJ9XgTZ+nD/MlsNE0YiRLsl3QNFK2jJL2JcMKc6K+e4Ss2fIvyICJHZLlEZ
 F0KlUQnwO05Yxwk4FHA7apGc68KjX+P1kYkJmrpkGVwRItxbo1jp3ituu5nZ7nninZ+N
 2Mt5GjdVy/80tmP/T8e2bChf4mnK3cWGAVffNc9i/vloMdAtFxAf7schpELmZfc1Fj1z
 31GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=KKkxfeELsCI57+jUUXb7wnduxs7fUd9hVi9x6ujerNw=;
 b=EDVm3sViL4aQHPRF5518nlxTeTctHCnDfxzCJD780LtEU4lAUdU/rBqlBnfRYkXSnG
 X/TuG+88YjkfSElXJIPbmp6YupTkkP774Rgte+kMAEXZyqIPJGUYgceNukqMRjjeTOap
 U6zZqmnEgUB4Ds6tk4qE2hR6UdnSJTmAAy3H0OP++CKKf1GDvFUjsbIsq5EQwTFhGPv1
 OnWngASvNLGtM6JelChdyrwbJkNIXeEldkX2spPulpFIJr2IWBlJ8QDfS7omh/hXO9BM
 XzPiYNdr5KY218uGC+7yJIa+lJHC6jhjf1BvlvIUOhJ9x7XDN3Li39GgvV/l6rIzfsmn
 W60g==
X-Gm-Message-State: ANhLgQ2DqKQQviyDWtK49mOwJRjcZRB8roRMdh3yv4slVFM5c+Ltd0ER
 RA6NTG1gv568RLZOkzte2metlg==
X-Google-Smtp-Source: ADFU+vtSyD0bPHsbCH9pS2hQ0Ah566Uo18GFgKCBRViB46ewsanKFOCqgQg3xVP7nDqfDChi5Derqw==
X-Received: by 2002:a5d:5541:: with SMTP id g1mr16414783wrw.220.1583836709943; 
 Tue, 10 Mar 2020 03:38:29 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id v2sm3170761wme.2.2020.03.10.03.38.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2020 03:38:28 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 57C771FF7E;
 Tue, 10 Mar 2020 10:38:27 +0000 (GMT)
References: <20200310083218.26355-1-kraxel@redhat.com>
 <20200310083218.26355-4-kraxel@redhat.com>
User-agent: mu4e 1.3.9; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH 3/4] tests/vm: update FreeBSD to 12.1
In-reply-to: <20200310083218.26355-4-kraxel@redhat.com>
Date: Tue, 10 Mar 2020 10:38:27 +0000
Message-ID: <87lfo8ijfg.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
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
Cc: Fam Zheng <fam@euphon.net>, Kamil Rytarowski <kamil@netbsd.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Gerd Hoffmann <kraxel@redhat.com> writes:

> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  tests/vm/freebsd | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tests/vm/freebsd b/tests/vm/freebsd
> index 58166766d915..298967fe9cf4 100755
> --- a/tests/vm/freebsd
> +++ b/tests/vm/freebsd
> @@ -24,8 +24,8 @@ class FreeBSDVM(basevm.BaseVM):
>      name =3D "freebsd"
>      arch =3D "x86_64"
>=20=20
> -    link =3D "https://download.freebsd.org/ftp/releases/ISO-IMAGES/12.0/=
FreeBSD-12.0-RELEASE-amd64-disc1.iso.xz"
> -    csum =3D "1d40015bea89d05b8bd13e2ed80c40b522a9ec1abd8e7c8b80954fb485=
fb99db"
> +    link =3D "https://download.freebsd.org/ftp/releases/ISO-IMAGES/12.1/=
FreeBSD-12.1-RELEASE-amd64-disc1.iso.xz"
> +    csum =3D "7394c3f60a1e236e7bd3a05809cf43ae39a3b8e5d42d782004cf2f26b1=
cfcd88"
>      size =3D "20G"
>      pkgs =3D [
>          # build tools

Hmm I'm seeing a failure during running which I had to manually override:

DEBUG:root:ssh_cmd: ssh -t -o StrictHostKeyChecking=3Dno -o
UserKnownHostsFile=3D/dev/null -o ConnectTimeout=3D1 -p 39533 -i
/home/alex.bennee/lsrc/qemu.git/builds/all/vm-test-_dqalech.tmp/id_rsa
-o SendEnv=3Dhttps_proxy -o SendEnv=3Dhttp_proxy -o SendEnv=3Dftp_proxy -o
SendEnv=3Dno_proxy root@127.0.0.1 pkg install -y git pkgconf bzip2
python37 bash gmake gsed flex bison gnutls jpeg-turbo png sdl2 gtk3
libxkbcommon libepoxy mesa-libs zstd

Warning: Permanently added '[127.0.0.1]:39533' (ECDSA) to the list of known=
 hosts.
Bootstrapping pkg from
pkg+http://pkg.FreeBSD.org/FreeBSD:12:amd64/quarterly, please wait...
Verifying signature with trusted certificate
pkg.freebsd.org.2013102301... done
Installing pkg-1.12.0_1...
Newer FreeBSD version for package pkg:
To ignore this error set IGNORE_OSVERSION=3Dyes
- package: 1201000
- running kernel: 1200086
Ignore the mismatch and continue? [Y/n]:
Extracting pkg-1.12.0_1: 100%



--=20
Alex Benn=C3=A9e

