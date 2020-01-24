Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C795C2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 18:40:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE18E2072C
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 18:40:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AgFSbAUl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE18E2072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46396 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iv3se-0004pU-VZ
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 13:40:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43929)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iv3rn-0003xw-VN
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 13:39:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iv3rm-0001Dt-7B
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 13:39:39 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32546
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iv3rm-0001Di-3n
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 13:39:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579891177;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RVaRsDdKAhg9TJX8xRD/3Hq1wN1/mEKeOvQMLrCeBAY=;
 b=AgFSbAUlYGq73lnntKlNbmSBIKhtOdCDCoBOEsEn3y8LM1rmAMeLrKz/35XT689ylE/6le
 u1DWfTUSY1hweh9uIpHdVyKiH9EtMTOxK83jVBJeJP1safiHAkRbFJqZVhP5rFRobEG74C
 pn+yZJfAzHPQxmm1oibVp0ZNd4MO7eA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-5-4P4fyUecPi68ZRAkMiJvzQ-1; Fri, 24 Jan 2020 13:39:30 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D417C13E1
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2020 18:39:29 +0000 (UTC)
Received: from work-vm (ovpn-117-253.ams2.redhat.com [10.36.117.253])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E09F019C4F;
 Fri, 24 Jan 2020 18:39:27 +0000 (UTC)
Date: Fri, 24 Jan 2020 18:39:25 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Subject: Re: [PATCH v3 20/21] configure: Enable test and libs for zstd
Message-ID: <20200124183925.GZ2970@work-vm>
References: <20200123115831.36842-1-quintela@redhat.com>
 <20200123115831.36842-21-quintela@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200123115831.36842-21-quintela@redhat.com>
User-Agent: Mutt/1.13.0 (2019-11-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: 4P4fyUecPi68ZRAkMiJvzQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Juan Quintela (quintela@redhat.com) wrote:
> Signed-off-by: Juan Quintela <quintela@redhat.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  configure | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
>=20
> diff --git a/configure b/configure
> index 557e4382ea..56ddfd7f8a 100755
> --- a/configure
> +++ b/configure
> @@ -448,6 +448,7 @@ lzo=3D""
>  snappy=3D""
>  bzip2=3D""
>  lzfse=3D""
> +zstd=3D""
>  guest_agent=3D""
>  guest_agent_with_vss=3D"no"
>  guest_agent_ntddscsi=3D"no"
> @@ -1343,6 +1344,10 @@ for opt do
>    ;;
>    --disable-lzfse) lzfse=3D"no"
>    ;;
> +  --disable-zstd) zstd=3D"no"
> +  ;;
> +  --enable-zstd) zstd=3D"yes"
> +  ;;
>    --enable-guest-agent) guest_agent=3D"yes"
>    ;;
>    --disable-guest-agent) guest_agent=3D"no"
> @@ -1795,6 +1800,8 @@ disabled with --disable-FEATURE, default is enabled=
 if available:
>                    (for reading bzip2-compressed dmg images)
>    lzfse           support of lzfse compression library
>                    (for reading lzfse-compressed dmg images)
> +  zstd            support for zstd compression library
> +                  (for migration compression)
>    seccomp         seccomp support
>    coroutine-pool  coroutine freelist (better performance)
>    glusterfs       GlusterFS backend
> @@ -2408,6 +2415,24 @@ EOF
>      fi
>  fi
> =20
> +##########################################
> +# zstd check
> +
> +if test "$zstd" !=3D "no" ; then
> +    if $pkg_config --exist libzstd ; then
> +        zstd_cflags=3D"$($pkg_config --cflags libzstd)"
> +        zstd_libs=3D"$($pkg_config --libs libzstd)"
> +        LIBS=3D"$zstd_libs $LIBS"
> +        QEMU_CFLAGS=3D"$QEMU_CFLAGS $zstd_cflags"
> +        zstd=3D"yes"
> +    else
> +        if test "$zstd" =3D "yes" ; then
> +            feature_not_found "libzstd" "Install libzstd devel"
> +        fi
> +        zstd=3D"no"
> +    fi
> +fi
> +
>  ##########################################
>  # libseccomp check
> =20
> @@ -6555,6 +6580,7 @@ echo "lzo support       $lzo"
>  echo "snappy support    $snappy"
>  echo "bzip2 support     $bzip2"
>  echo "lzfse support     $lzfse"
> +echo "zstd support      $zstd"
>  echo "NUMA host support $numa"
>  echo "libxml2           $libxml2"
>  echo "tcmalloc support  $tcmalloc"
> @@ -7114,6 +7140,10 @@ if test "$lzfse" =3D "yes" ; then
>    echo "LZFSE_LIBS=3D-llzfse" >> $config_host_mak
>  fi
> =20
> +if test "$zstd" =3D "yes" ; then
> +  echo "CONFIG_ZSTD=3Dy" >> $config_host_mak
> +fi
> +
>  if test "$libiscsi" =3D "yes" ; then
>    echo "CONFIG_LIBISCSI=3Dm" >> $config_host_mak
>    echo "LIBISCSI_CFLAGS=3D$libiscsi_cflags" >> $config_host_mak
> --=20
> 2.24.1
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


