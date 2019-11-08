Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91C15FA372C
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 14:06:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5ACAD21848
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 14:06:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="IFGNJASi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5ACAD21848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54854 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT4uF-0000kn-CZ
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 09:06:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33541)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <luc.michel@greensocs.com>) id 1iT4qK-0006v8-Um
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 09:02:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <luc.michel@greensocs.com>) id 1iT4qJ-0001Fv-G2
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 09:02:28 -0500
Received: from beetle.greensocs.com ([5.135.226.135]:57976)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <luc.michel@greensocs.com>)
 id 1iT4qI-0001Fi-U3; Fri, 08 Nov 2019 09:02:27 -0500
Received: from [192.168.61.102] (lfbn-1-8165-82.w90-112.abo.wanadoo.fr
 [90.112.74.82])
 by beetle.greensocs.com (Postfix) with ESMTPSA id 6ECA896EF0;
 Fri,  8 Nov 2019 14:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1573221744;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6lQePlmXitgko6rXMrfwRfb+yoBs76F4W29M7pjYdjU=;
 b=IFGNJASiAHaOYfjJjmg3XEtrIkbuc7dt3wBjCOIQV5KbN8sQ1yLNfOPaFJbb/SrWGhQczI
 hnQ8pAxGWsRkOh9YOKFdU6O+OjYgwPPAucEaUx+x+dw8yOfMryL/3hJgLmDNMVTCptD/Ha
 75BaSmw4oAI7Nsz5xorOVtvqxlB8aS8=
Subject: Re: [PATCH v2 1/2] configure: Only decompress EDK2 blobs for X86/ARM
 targets
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Laszlo Ersek <lersek@redhat.com>
References: <20191108114531.21518-1-philmd@redhat.com>
 <20191108114531.21518-2-philmd@redhat.com>
From: Luc Michel <luc.michel@greensocs.com>
Message-ID: <f2bcc1f7-313c-7ced-23c2-a70bb1ce3646@greensocs.com>
Date: Fri, 8 Nov 2019 15:02:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191108114531.21518-2-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-PH
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1573221744;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6lQePlmXitgko6rXMrfwRfb+yoBs76F4W29M7pjYdjU=;
 b=ZKLRx62US9uy4im6UFnutEY0CaEN6M2trq2QZ7xr31JRi6YFpDKnTKtu/6luqs/5HqX+SE
 e2itgjeyOBR/cFqyxTXKrwL7Gl44dUZAH397XjGbXtJyM7ceQk9Kv61b3zqHbQ9fW4fMjJ
 HPF9LZS9+rEU2qJs7JYSrIQ2RstBO5w=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1573221744; a=rsa-sha256; cv=none;
 b=wHtdVPlLph8fynLpm+m20cgrphDYG5hGSk9ZswJRe4tszQ8CpTAQlnDPmZlv2EeYgPHvfa
 1TzIxPGQVSJ8B25pHwwAiVcN+unJfDQNljniKg3bEEme1W7PvRirWW4lzy2AosXW1KQp5q
 2mcC98/lgi7KsQrbVHwcUjWPw77rLaA=
ARC-Authentication-Results: i=1; ORIGINATING;
 auth=pass smtp.auth=luc smtp.mailfrom=luc.michel@greensocs.com
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 5.135.226.135
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
Cc: qemu-trivial@nongnu.org, Thomas Huth <thuth@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/8/19 12:45 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> The EDK2 firmware blobs only target the X86/ARM architectures.
> Define the DECOMPRESS_EDK2_BLOBS variable and only decompress
> the blobs when the variable exists.
>=20
> Fixes: 536d2173b2b
> Suggested-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
> v2: new
> ---
>  Makefile  |  2 ++
>  configure | 13 +++++++++++++
>  2 files changed, 15 insertions(+)
>=20
> diff --git a/Makefile b/Makefile
> index aa9d1a42aa..3430eca532 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -480,7 +480,9 @@ $(SOFTMMU_ALL_RULES): $(chardev-obj-y)
>  $(SOFTMMU_ALL_RULES): $(crypto-obj-y)
>  $(SOFTMMU_ALL_RULES): $(io-obj-y)
>  $(SOFTMMU_ALL_RULES): config-all-devices.mak
> +ifdef DECOMPRESS_EDK2_BLOBS
>  $(SOFTMMU_ALL_RULES): $(edk2-decompressed)
> +endif
> =20
>  .PHONY: $(TARGET_DIRS_RULES)
>  # The $(TARGET_DIRS_RULES) are of the form SUBDIR/GOAL, so that
> diff --git a/configure b/configure
> index efe165edf9..9b322284c3 100755
> --- a/configure
> +++ b/configure
> @@ -427,6 +427,7 @@ softmmu=3D"yes"
>  linux_user=3D"no"
>  bsd_user=3D"no"
>  blobs=3D"yes"
> +edk2_blobs=3D"no"
>  pkgversion=3D""
>  pie=3D""
>  qom_cast_debug=3D"yes"
> @@ -2146,6 +2147,14 @@ case " $target_list " in
>    ;;
>  esac
> =20
> +for target in $target_list; do
> +  case "$target" in
> +    arm-softmmu | aarch64-softmmu | i386-softmmu | x86_64-softmmu)
> +      edk2_blobs=3D"yes"
> +      ;;
> +  esac
> +done
> +
>  feature_not_found() {
>    feature=3D$1
>    remedy=3D$2
> @@ -7526,6 +7535,10 @@ if test "$libudev" !=3D "no"; then
>      echo "LIBUDEV_LIBS=3D$libudev_libs" >> $config_host_mak
>  fi
> =20
> +if test "$edk2_blobs" =3D "yes" ; then
> +  echo "DECOMPRESS_EDK2_BLOBS=3Dy" >> $config_host_mak
> +fi
> +
>  # use included Linux headers
>  if test "$linux" =3D "yes" ; then
>    mkdir -p linux-headers
>=20

Reviewed-by: Luc Michel <luc.michel@greensocs.com>

