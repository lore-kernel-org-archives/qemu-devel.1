Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F9B9FC6195
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 17:39:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F232206C3
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 17:39:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nc6ZLWYC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F232206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT8EW-0006zB-9i
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 12:39:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44473)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lersek@redhat.com>) id 1iT8DT-00069U-01
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 12:38:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lersek@redhat.com>) id 1iT8DQ-000594-DJ
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 12:38:33 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:25677
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lersek@redhat.com>) id 1iT8DQ-00058o-9t
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 12:38:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573234711;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3ygWqRFf3rR76CqLihMOU6WLOgpbxH73V/9PnL4pR1o=;
 b=Nc6ZLWYCJHEIjKBzApEge3ETlMEoMQdX6wdQaMbhHXJxvEUm653P+DMPLgisowSDHyFLvy
 bvB+Pe5fcAhM4doVnICyg3PCkpUM+/ps4tRQdoweWgSIhfAwRixlvIIxehrp6zZXjNxDT8
 hccuEQsUW8XSStY0e1a3UlU0mg+EYmE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-223-WAHBejUANwuRoTl5ia8Uag-1; Fri, 08 Nov 2019 12:38:30 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4E753107ACC4;
 Fri,  8 Nov 2019 17:38:29 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-117-227.ams2.redhat.com
 [10.36.117.227])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AA2C66084E;
 Fri,  8 Nov 2019 17:38:12 +0000 (UTC)
Subject: Re: [PATCH v2 1/2] configure: Only decompress EDK2 blobs for X86/ARM
 targets
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20191108114531.21518-1-philmd@redhat.com>
 <20191108114531.21518-2-philmd@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <288753f3-872e-8eca-1f86-869ae6bf5380@redhat.com>
Date: Fri, 8 Nov 2019 18:38:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20191108114531.21518-2-philmd@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: WAHBejUANwuRoTl5ia8Uag-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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

On 11/08/19 12:45, Philippe Mathieu-Daud=C3=A9 wrote:
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

Impressively surgical & simple.

Reviewed-by: Laszlo Ersek <lersek@redhat.com>

Thank you!
Laszlo


