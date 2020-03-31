Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DA28C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 14:45:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6436B2078B
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 14:45:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GjPR3ddV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6436B2078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39260 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJI9G-0007O3-GP
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 10:45:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53421)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jJI8G-0006b9-1c
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 10:44:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jJI8E-0004jG-Oi
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 10:44:47 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59382
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jJI8E-0004ix-Ko
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 10:44:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585665886;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lDTqBUMhaVKng5Y7OJaMsvUxUQJJFMv/g9IDIF1r5lg=;
 b=GjPR3ddVBlPtP4Ff7XwNdqsVi20UL0vy6Ff1QSApk0184qG4rWHdbBZSP+TIfnNXfeDe0Y
 w097k4QynuFiWkwoZj6djd4ISMAkssym1DfUhRtUuDpKNEkO5AiI4Z3trksnORzK2DUSvm
 3K56CbrWTBCQeJ1P7u4cGupvktva62s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-113-pCIVw1BRPV67QYmmAB347A-1; Tue, 31 Mar 2020 10:44:40 -0400
X-MC-Unique: pCIVw1BRPV67QYmmAB347A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E4BD81005514;
 Tue, 31 Mar 2020 14:44:38 +0000 (UTC)
Received: from [10.3.113.246] (ovpn-113-246.phx2.redhat.com [10.3.113.246])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0AA0598A29;
 Tue, 31 Mar 2020 14:44:37 +0000 (UTC)
Subject: Re: [PATCH] configure: warn if not using a separate build directory
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
References: <20200331103758.370644-1-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <042a22e2-5be5-ba57-1c35-8f210d9718fd@redhat.com>
Date: Tue, 31 Mar 2020 09:44:37 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200331103758.370644-1-berrange@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Liviu Ionescu <ilg@livius.net>, Markus Armbruster <armbru@redhat.com>,
 Stefan Hajnoczi <stefanha@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Michal_Such=c3=a1nek?= <msuchanek@suse.de>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/31/20 5:37 AM, Daniel P. Berrang=C3=A9 wrote:
> Running configure directly from the source directory is a build
> configuration that will go away in future. It is also not currently
> covered by any automated testing. Display a deprecation warning if
> the user attempts to use an in-srcdir build setup, so that they are
> aware that they're building QEMU in an undesirable manner.
>=20
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>   configure | 30 ++++++++++++++++++++++++++++++
>   1 file changed, 30 insertions(+)
>=20

It sounds like you already have a v2 coming up to address Phillipe's=20
comments, but I'd be happy to see this concept make it into v5.0.

> diff --git a/configure b/configure
> index e225a1e3ff..1ab7492ab5 100755
> --- a/configure
> +++ b/configure
> @@ -3,6 +3,19 @@
>   # qemu configure script (c) 2003 Fabrice Bellard
>   #
>  =20
> +BUILDDIR=3D$(pwd)

Why fork out to 'pwd', when we can rely on $PWD for the same answer?=20
Note that both $(pwd) and $PWD $BUILDDIR always give an absolute (but no=20
necessarily canonical) path, which means...

> +SRCDIR=3D$(dirname "$0")
> +
> +ABS_BUILDDIR=3D$(realpath $BUILDDIR)

...calling this ABS_BUILDDIR is a misnomer (it was already absolute).=20
What it is really doing is chasing through symlinks to result in a=20
canonical name, particularly since unless you have absolute names, using=20
only string comparison to see if two filenames are equivalent will have=20
false negatives (/tmp vs. /tmp/., for example).

> +ABS_SRCDIR=3D$(realpath $SRCDIR)

Not robust if there are spaces in the directory names.  Safer would be
ABS_BUILDDIR=3D$(realpath -- "$BUILDDIR")
and similarly for ABS_SRCDIR.

> +
> +in_srcdir=3Dno
> +if [ "$ABS_SRCDIR" =3D=3D "$ABS_BUILDDIR" ]

Bashism. You MUST spell this '=3D', not '=3D=3D', since configure is run un=
der=20
/bin/sh which might be dash which does not understand =3D=3D.

> +then
> +    in_srcdir=3Dyes
> +fi
> +
> +
>   # Unset some variables known to interfere with behavior of common tools=
,
>   # just as autoconf does.
>   CLICOLOR_FORCE=3D GREP_OPTIONS=3D
> @@ -6799,6 +6812,23 @@ if test "$supported_os" =3D "no"; then
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
> +    echo
> +    echo "  $ mkdir build"
> +    echo "  $ cd build"
> +    echo "  $ ../configure"
> +    echo "  $ make"
> +    echo
> +fi

You know, it WOULD be possible to further enhance this to actually=20
create 'build' as well as a shim GNUmakefile that would auto-forward on=20
to building directly in build, so that you maintain the illusion of an=20
in-place build (other than all the build artifacts now living in a=20
different location), and muscle memory for in-tree 'make' still works;=20
I've posted elsewhere and will repeat here the contents of my GNUmakefile:

# Hack for redirecting while reminding myself to use distinct builddir
ifeq ($(MAKECMDGOALS),)
recurse: all
endif
%: force
=09@echo 'changing directory to build...'
=09@sleep 2
=09@$(MAKE) -C build -f Makefile $(MAKECMDGOALS)
force: ;
.PHONY: force
GNUmakefile: ;


But we could do that as a patch on top of yours.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


