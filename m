Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88420C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 16:06:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53766206CC
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 16:06:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h2a+7beY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53766206CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41218 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJJPO-0001Mq-AH
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 12:06:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40339)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jJJO8-00005B-EX
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 12:05:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jJJO6-0000VV-ED
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 12:05:15 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:48712
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jJJO6-0000Up-97
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 12:05:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585670713;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8nc+642Iu38kodAsZ3P/GI+L7ljQSFwAnTs0+CWhM/s=;
 b=h2a+7beYojbMIwI5C5N3C6JuCssb148NFh1yuBkkJbETF1EyhXAR6DadDeh5+6DTpu1x5z
 UeZ7JWPHHu4HNh75jV3gX/fOI5OGmGHUL6RabrYYfJAOew0Lzw4481ZocByPfFIB8z5TGj
 jNR4SI7ORacWk5Yuj83qUbldqm8vcZc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-407-gvWk_0XwNxO5ggUVMdAM5w-1; Tue, 31 Mar 2020 12:05:09 -0400
X-MC-Unique: gvWk_0XwNxO5ggUVMdAM5w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 363328017CE;
 Tue, 31 Mar 2020 16:05:08 +0000 (UTC)
Received: from [10.3.113.246] (ovpn-113-246.phx2.redhat.com [10.3.113.246])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2FA8460BE2;
 Tue, 31 Mar 2020 16:05:06 +0000 (UTC)
Subject: Re: [PATCH v2] configure: warn if not using a separate build directory
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
References: <20200331155158.381585-1-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <1450d802-4df8-117b-e58d-da8bf2334010@redhat.com>
Date: Tue, 31 Mar 2020 11:05:06 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200331155158.381585-1-berrange@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@gmail.com>, Markus Armbruster <armbru@redhat.com>,
 Liviu Ionescu <ilg@livius.net>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Michal_Such=c3=a1nek?= <msuchanek@suse.de>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/31/20 10:51 AM, Daniel P. Berrang=C3=A9 wrote:
> Running configure directly from the source directory is a build
> configuration that will go away in future. It is also not currently
> covered by any automated testing. Display a deprecation warning if
> the user attempts to use an in-srcdir build setup, so that they are
> aware that they're building QEMU in an undesirable manner.
>=20
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>=20
> Changed in v2:
>=20
>   - Use existing $source_path variable (Eric)

Phillipe, actually - but this line isn't permanent.

>   - Remove bash-ism in comparison (Eric)
>   - Safe quoting of directory paths (Eric)
>   - Rename variables to reflect that we're applying canonicalization (Eri=
c)
>=20
>   configure | 27 +++++++++++++++++++++++++++
>   1 file changed, 27 insertions(+)
>=20
> diff --git a/configure b/configure
> index e225a1e3ff..5991e0e6e5 100755
> --- a/configure
> +++ b/configure
> @@ -285,6 +285,16 @@ then
>     error_exit "main directory cannot contain spaces nor colons"
>   fi
>  =20
> +canon_build_path=3D$(realpath -- "$PWD")
> +canon_source_path=3D$(realpath -- "$source_path")
> +
> +in_srcdir=3Dno
> +if [ "$canon_build_path" =3D "$canon_source_path" ]
> +then
> +    in_srcdir=3Dyes
> +fi

This part is good.

> +
> +
>   # default parameters
>   cpu=3D""
>   iasl=3D"iasl"
> @@ -6799,6 +6809,23 @@ if test "$supported_os" =3D "no"; then
>       echo "us upstream at qemu-devel@nongnu.org."
>   fi
>  =20
> +if test "$in_srcdir" =3D "yes"; then
> +    echo
> +    echo "WARNING: SUPPORT FOR IN SOURCE DIR BUILDS IS DEPRECATED"
> +    echo
> +    echo "Support for running the 'configure' script directly from the"
> +    echo "source directory is deprecated and will go away in a future"
> +    echo "release. In source dir builds are not covered by automated"
> +    echo "testing and are liable to break without warning. Users are"
> +    echo "strongly recommended to switch to a separate build directory:"

Per Kevin's response, we may want to tweak this wording slightly; maybe:

Support for running the 'configure' script directly from the source=20
directory is deprecated.  In-tree builds are not covered by automated=20
testing and are liable to break without warning.  Future releases may=20
change the default location of built executables for an in-tree build,=20
or drop in-tree build support altogether.  Users are strongly=20
recommended to switch to a separate build directory:

> +    echo
> +    echo "  $ mkdir build"
> +    echo "  $ cd build"
> +    echo "  $ ../configure"
> +    echo "  $ make"
> +    echo
> +fi
> +
>   config_host_mak=3D"config-host.mak"
>  =20
>   echo "# Automatically generated by configure - do not modify" >config-a=
ll-disas.mak
>=20

Whether we keep your wording or switch to somthing based on mine,
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


