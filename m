Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D86E2C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 16:18:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E65E20786
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 16:18:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mo2ARXfT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E65E20786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41364 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJJb6-00017A-RI
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 12:18:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41622)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jJJZ1-0008Cb-Mx
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 12:16:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jJJZ0-0006AS-2M
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 12:16:31 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:44158
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jJJYz-00069r-TG
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 12:16:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585671389;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=89fgwALPDUnWZ2WB4lrT2kfYU4WOz62L3c6Um54WkG8=;
 b=Mo2ARXfTZ1mClm6RO9DwWtvZMXCGnLJEpFKPJ6OMZXGdUD5jY6Nz9WeiuzS0U+bpxpgx2+
 40402u5Wc4/XETTFDcs2oZIaxrVtJbDPzQJgDgifL7mIWmKg/SXF5hnwYAXtthkJhZyiKG
 RoooqlBtD/bnL6ze9otBEWjk00u0+N0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-357-oXmbirg-OH-rgoyr4h3sDQ-1; Tue, 31 Mar 2020 12:16:27 -0400
X-MC-Unique: oXmbirg-OH-rgoyr4h3sDQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 45AC018CA242;
 Tue, 31 Mar 2020 16:16:26 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-69.ams2.redhat.com
 [10.36.112.69])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D53C35E009;
 Tue, 31 Mar 2020 16:16:25 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 62CCC11385E2; Tue, 31 Mar 2020 18:16:24 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH v2] configure: warn if not using a separate build directory
References: <20200331155158.381585-1-berrange@redhat.com>
Date: Tue, 31 Mar 2020 18:16:24 +0200
In-Reply-To: <20200331155158.381585-1-berrange@redhat.com> ("Daniel
 P. =?utf-8?Q?Berrang=C3=A9=22's?= message of "Tue, 31 Mar 2020 16:51:58
 +0100")
Message-ID: <87wo70sdnr.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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
 Liviu Ionescu <ilg@livius.net>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Michal =?utf-8?Q?Such=C3=A1nek?= <msuchanek@suse.de>,
 Philippe =?utf-8?Q?Mathie?= =?utf-8?Q?u-Daud=C3=A9?= <philmd@redhat.com>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> Running configure directly from the source directory is a build
> configuration that will go away in future. It is also not currently
> covered by any automated testing. Display a deprecation warning if
> the user attempts to use an in-srcdir build setup, so that they are
> aware that they're building QEMU in an undesirable manner.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>
> Changed in v2:
>
>  - Use existing $source_path variable (Eric)
>  - Remove bash-ism in comparison (Eric)
>  - Safe quoting of directory paths (Eric)
>  - Rename variables to reflect that we're applying canonicalization (Eric=
)
>
>  configure | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>
> diff --git a/configure b/configure
> index e225a1e3ff..5991e0e6e5 100755
> --- a/configure
> +++ b/configure
> @@ -285,6 +285,16 @@ then
>    error_exit "main directory cannot contain spaces nor colons"
>  fi
> =20
> +canon_build_path=3D$(realpath -- "$PWD")
> +canon_source_path=3D$(realpath -- "$source_path")
> +
> +in_srcdir=3Dno
> +if [ "$canon_build_path" =3D "$canon_source_path" ]
> +then
> +    in_srcdir=3Dyes
> +fi
> +
> +
>  # default parameters
>  cpu=3D""
>  iasl=3D"iasl"
> @@ -6799,6 +6809,23 @@ if test "$supported_os" =3D "no"; then
>      echo "us upstream at qemu-devel@nongnu.org."
>  fi
> =20
> +if test "$in_srcdir" =3D "yes"; then
> +    echo
> +    echo "WARNING: SUPPORT FOR IN SOURCE DIR BUILDS IS DEPRECATED"

I don't like shouted warnings, but it's consistent with what we have.

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
> +
>  config_host_mak=3D"config-host.mak"
> =20
>  echo "# Automatically generated by configure - do not modify" >config-al=
l-disas.mak

Output is suboptimal because we run $source_path/tests/tcg/configure.sh
after emitting warnings, and it's chatty:

    [...]
    plugin support    no
    fuzzing support   no
    gdb               /usr/bin/gdb

    WARNING: SUPPORT FOR IN SOURCE DIR BUILDS IS DEPRECATED

    Support for running the 'configure' script directly from the
    source directory is deprecated and will go away in a future
    release. In source dir builds are not covered by automated
    testing and are liable to break without warning. Users are
    strongly recommended to switch to a separate build directory:

      $ mkdir build
      $ cd build
      $ ../configure
      $ make

--> cross containers  podman

    NOTE: guest cross-compilers enabled: cc cc

Not this patch's fault.

Reviewed-by: Markus Armbruster <armbru@redhat.com>


