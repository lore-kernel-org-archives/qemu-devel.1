Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51804C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 08:36:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DA1B206E2
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 08:36:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iAcAoP26"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DA1B206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32802 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jA8Sr-0004C5-AZ
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 03:36:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:32827)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sgarzare@redhat.com>) id 1jA8S0-0003DI-D8
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 03:35:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sgarzare@redhat.com>) id 1jA8Ry-0006Br-Tu
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 03:35:20 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41089
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1jA8Ry-00065k-Lc
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 03:35:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583483717;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XWv3fus2L7H2323rMlCgsZpBwmTa/a2TdmhRV0Z03mc=;
 b=iAcAoP26OBBdoyjX4AzTMAzzCCI4o3+cOOwTn0wIJScdij/iTCqVTLWUsIFhP6qRbYecUg
 t37RT1KHUmyfxfSwfTzL/X20zOIoRSdiNi81uaOHP57R3R9hHTr4c/F8V5O0vP1Gs9z5oP
 lOeBKBOkZ6BewwIAVaz+1OL3cuqADrM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-242-4y-sWxxANvWulXMd6LSJlg-1; Fri, 06 Mar 2020 03:35:13 -0500
X-MC-Unique: 4y-sWxxANvWulXMd6LSJlg-1
Received: by mail-wm1-f69.google.com with SMTP id i16so591921wmd.9
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2020 00:35:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=RKachxydLyto2q4Ymb4IfwUkM5Jy4dcvVP49rY8s//M=;
 b=uRAzXVmxbc4nAeqd+gPuUFe4xEqJIfYf8J3FwsugE08JZgI2OXVvsRcUugoYZ4oVF0
 rkmMU+/CpZFTge6nFHTZJkSJJvo/RNQ53BUMTUvUJGSMzXo9LuxaxOMIYWGg/SaLabDs
 ngELeRQUSOROdEJm686YHNL7Z0WxYIi/gc/CB39Perx+LkmzAbI4SQcAbyhW3GR97ImE
 E0tMIIqfJmZRjMQwRCMkrgiM14afpHjwFKEhyhQcTTK9dcn/yb14UliE3nnAcBFy8uEb
 RdctXolEmVm0BtFLfukHcVuKev683xlvElXghfT3JKUTrgyDPtzIxXaP7vxZWXnqRTS8
 l+WA==
X-Gm-Message-State: ANhLgQ32p9C2QdiUiEsS2ZxOPLEf5+uPOTSPplAZ8Jk8IbHy+meMLkRp
 FnCq1ioJ9d7QcYgkLJK/Od0EGDqMtAHkmUgPcOz1hn7QlFIDwrisZpe3+WydHJ82KlVtlybZXYT
 8hOqS3mYC5xxNlO4=
X-Received: by 2002:a1c:1d84:: with SMTP id d126mr2663668wmd.187.1583483712442; 
 Fri, 06 Mar 2020 00:35:12 -0800 (PST)
X-Google-Smtp-Source: ADFU+vuP32RN2TFNB1cPcOUALI9ZCfi1sCzQ1Ftp9XjEiX3n466cl1Daxrp+ntpWxlrwY53j25U7Ag==
X-Received: by 2002:a1c:1d84:: with SMTP id d126mr2663643wmd.187.1583483712228; 
 Fri, 06 Mar 2020 00:35:12 -0800 (PST)
Received: from steredhat (host34-204-dynamic.43-79-r.retail.telecomitalia.it.
 [79.43.204.34])
 by smtp.gmail.com with ESMTPSA id z10sm12739769wmk.31.2020.03.06.00.35.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2020 00:35:11 -0800 (PST)
Date: Fri, 6 Mar 2020 09:35:09 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH] tests/docker: Install tools to cross-debug and build
 Linux kernels
Message-ID: <20200306083509.dijhmlnbxjlol5yg@steredhat>
References: <20200212202738.12986-1-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200212202738.12986-1-philmd@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Fam Zheng <fam@euphon.net>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Feb 12, 2020 at 09:27:38PM +0100, Philippe Mathieu-Daud=E9 wrote:
> From: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
>=20
> We often run Linux kernels to test QEMU. We sometimes need
> to build them manually to use non-default features. We only
> miss the tiny 'bc' tool.
>=20
> The ncurses library is helpful to run 'make menuconfig'.
>=20
> Finally, gdb-multiarch allow us to debug a TCG guest when its
> architecture is different than the host.
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> ---
>  tests/docker/dockerfiles/debian10.docker | 3 +++
>  tests/docker/dockerfiles/debian9.docker  | 3 +++
>  2 files changed, 6 insertions(+)

Make sense to add these packages:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks,
Stefano

>=20
> diff --git a/tests/docker/dockerfiles/debian10.docker b/tests/docker/dock=
erfiles/debian10.docker
> index 5de79ae552..2fcdc406e8 100644
> --- a/tests/docker/dockerfiles/debian10.docker
> +++ b/tests/docker/dockerfiles/debian10.docker
> @@ -17,14 +17,17 @@ RUN apt update && \
>      DEBIAN_FRONTEND=3Dnoninteractive apt install -yy eatmydata && \
>      DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
>      apt install -y --no-install-recommends \
> +        bc \
>          bison \
>          build-essential \
>          ca-certificates \
>          clang \
>          dbus \
>          flex \
> +        gdb-multiarch \
>          gettext \
>          git \
> +        libncurses5-dev \
>          pkg-config \
>          psmisc \
>          python3 \
> diff --git a/tests/docker/dockerfiles/debian9.docker b/tests/docker/docke=
rfiles/debian9.docker
> index 8cbd742bb5..92edbbf0f4 100644
> --- a/tests/docker/dockerfiles/debian9.docker
> +++ b/tests/docker/dockerfiles/debian9.docker
> @@ -17,13 +17,16 @@ RUN apt update && \
>      DEBIAN_FRONTEND=3Dnoninteractive apt install -yy eatmydata && \
>      DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
>      apt install -y --no-install-recommends \
> +        bc \
>          bison \
>          build-essential \
>          ca-certificates \
>          clang \
>          flex \
> +        gdb-multiarch \
>          gettext \
>          git \
> +        libncurses5-dev \
>          pkg-config \
>          psmisc \
>          python3 \
> --=20
> 2.21.1
>=20
>=20


