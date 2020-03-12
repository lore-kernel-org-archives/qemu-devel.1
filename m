Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A188FC10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 06:29:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8028A20575
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 06:29:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QoHsud+t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8028A20575
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCHLv-0003yg-Ls
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 02:29:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57358)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jCHLL-0003Z1-Mr
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 02:29:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jCHLK-0002ri-L9
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 02:29:19 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36643
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jCHLK-0002qq-HR
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 02:29:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583994558;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i9n5NubjGxEKOWHwsxFCKXhSSqLMBgC3mhH3M43NoPU=;
 b=QoHsud+tK30dN0calaIJIId+JFV87QmbR9eiZnEMMOP3yRqoKi/2nZb6Y7VrL16CCnbDiQ
 26L9bOe0HADa7tohPdqNE1ujRVsFUeezWqT1DjntAMSvH0VAFL5GjK3nTYkiwx43BHddvi
 CzLYvfLbgFBX82Jkbhzjwcfcz70P2jM=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-163-7dgvDAB-O2qUD3G01nbC4w-1; Thu, 12 Mar 2020 02:29:14 -0400
X-MC-Unique: 7dgvDAB-O2qUD3G01nbC4w-1
Received: by mail-qk1-f198.google.com with SMTP id 22so3193886qkc.7
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2020 23:29:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=UFFyDSR7FtJiuuT7AcaoJ7MGpczFKXVyCkW+ZyfiMNY=;
 b=MzKVP/UoOAC5/k32yggSkSM+lwibHP/gFtsrjN4QQiXj3Lg5oXGLOJ1JpEnv21hki9
 syiweyfz+X8ZXUw8zquOdybqbNywRgChxcnscI2anbJnhVG0SJ+1iH8u896OVonZwuw6
 HsMjZXG3AKjjBgrBHBHthHvGQirf6kjdMt2p1T1W10brlq7twT9SAVZgZAxIElIzrjUt
 SSzP2DFhzkCzSnx9aDJqoOs8LHtTKjA5ElC8WjDw93TTiWNEP9qyZjSylpRu+Qc3/QXG
 zcW+MGVMp3eJBVSqOa1Ks1MJQ0UafW1919Oy800sb2KGHrt7JTjS+PZsbC9b2k5zTENu
 /z1A==
X-Gm-Message-State: ANhLgQ0aGWCrQIVP8XNs7KuBpNb1LU6Jh9JNOOswnvy9VKW+xXb27Q1T
 YNnRaiAUlVi9AyZb0YN6VDncRyoS7S9czLoMbyc/phlTwatbYygXkYY4Q6yACJCBy6w8zy93s87
 Os7kX04IMSRFdJOw=
X-Received: by 2002:ae9:f503:: with SMTP id o3mr6000867qkg.402.1583994553444; 
 Wed, 11 Mar 2020 23:29:13 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vs2KekrrGgmJaowfg2mibtUVpqct5x3l8jwfaW/iS3mCcEoRWeLeTmuithr1zPJVf+eyRPlKw==
X-Received: by 2002:ae9:f503:: with SMTP id o3mr6000855qkg.402.1583994553214; 
 Wed, 11 Mar 2020 23:29:13 -0700 (PDT)
Received: from redhat.com (bzq-79-178-2-19.red.bezeqint.net. [79.178.2.19])
 by smtp.gmail.com with ESMTPSA id o16sm26896975qke.35.2020.03.11.23.29.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Mar 2020 23:29:12 -0700 (PDT)
Date: Thu, 12 Mar 2020 02:29:07 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: [PATCH v2 1/2] Use -isystem for linux-headers dir
Message-ID: <20200312022902-mutt-send-email-mst@kernel.org>
References: <20200311232342.1614944-1-ehabkost@redhat.com>
 <20200311232342.1614944-2-ehabkost@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200311232342.1614944-2-ehabkost@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: peter.maydell@linaro.org, jingqi.liu@intel.com, jtomko@redhat.com,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Mar 11, 2020 at 07:23:41PM -0400, Eduardo Habkost wrote:
> glibc and Linux-provided headers are known to generate macro
> redefinition warnings when used together.  For example:
> <linux/mman.h> and <sys/mman.h> duplicate some macro definitions.
>=20
> We normally never see those warnings because GCC suppresses
> warnings generated by system headers.  We carry our own copy of
> Linux header files, though, and this makes those warnings not be
> suppressed when glibc headers are included before Linux headers
> (e.g. if <sys/mman.h> is included before <linux/mman.h>).
>=20
> Use -isystem instead of -I for linux-headers.  This makes the
> compiler treat our linux-headers directory the same way it treats
> system-provided Linux headers, and suppress warnings generated by
> them.
>=20
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

> ---
> Changes v1 -> v2:
> * Use -isystem for $PWD/linux-headers too
>   Reported-by: "Michael S. Tsirkin" <mst@redhat.com>
> ---
>  Makefile.target | 2 +-
>  configure       | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/Makefile.target b/Makefile.target
> index 2d43dc586a..934a9f7431 100644
> --- a/Makefile.target
> +++ b/Makefile.target
> @@ -12,7 +12,7 @@ endif
> =20
>  $(call set-vpath, $(SRC_PATH):$(BUILD_DIR))
>  ifdef CONFIG_LINUX
> -QEMU_CFLAGS +=3D -I../linux-headers
> +QEMU_CFLAGS +=3D -isystem ../linux-headers
>  endif
>  QEMU_CFLAGS +=3D -iquote .. -iquote $(SRC_PATH)/target/$(TARGET_BASE_ARC=
H) -DNEED_CPU_H
> =20
> diff --git a/configure b/configure
> index cbf864bff1..bf5bf70600 100755
> --- a/configure
> +++ b/configure
> @@ -899,7 +899,7 @@ Linux)
>    linux=3D"yes"
>    linux_user=3D"yes"
>    kvm=3D"yes"
> -  QEMU_INCLUDES=3D"-I\$(SRC_PATH)/linux-headers -I$PWD/linux-headers $QE=
MU_INCLUDES"
> +  QEMU_INCLUDES=3D"-isystem \$(SRC_PATH)/linux-headers -isystem $PWD/lin=
ux-headers $QEMU_INCLUDES"
>    supported_os=3D"yes"
>    libudev=3D"yes"
>  ;;
> --=20
> 2.24.1


