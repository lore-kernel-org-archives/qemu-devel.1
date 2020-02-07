Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C126C2BA83
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 16:18:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11F8221775
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 16:18:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jG78r+wW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11F8221775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60092 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j06LF-0007wN-6j
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 11:18:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53034)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1j06KY-0007Mh-9a
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 11:18:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1j06KW-0007fu-48
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 11:18:09 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33850
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1j06KW-0007br-01
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 11:18:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581092287;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mij8wcIf0lTGgCOdX5mwNbRzUonBWn8T0argFI8k9Zk=;
 b=jG78r+wWLTELUx20wIaEI3AbVuKIdu5Q2yaQgAxwk7k/7WURf9/zEtxxxvZYxir8Kl6aMB
 FnO6e27eUlS5tNPQL+0Kz4QAgrH2A1q2rqQZWT7mjnNBS/+L2gWuOhwibv6NNY8zg+o3Mu
 jZ7GBYZTHc14ExdV97ryZX6xHXGYIXk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-41-kXlyiztENsagM3AGm7GC_Q-1; Fri, 07 Feb 2020 11:17:48 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2D2F4800D55;
 Fri,  7 Feb 2020 16:17:47 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-136.ams2.redhat.com
 [10.36.116.136])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 38D8E5C28C;
 Fri,  7 Feb 2020 16:17:42 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id BD42711386A7; Fri,  7 Feb 2020 17:17:40 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 02/29] configure: Check that sphinx-build is using Python 3
References: <20200206173040.17337-1-peter.maydell@linaro.org>
 <20200206173040.17337-3-peter.maydell@linaro.org>
Date: Fri, 07 Feb 2020 17:17:40 +0100
In-Reply-To: <20200206173040.17337-3-peter.maydell@linaro.org> (Peter
 Maydell's message of "Thu, 6 Feb 2020 17:30:13 +0000")
Message-ID: <875zgipe1n.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: kXlyiztENsagM3AGm7GC_Q-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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
Cc: John Snow <jsnow@redhat.com>,
 "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> writes:

> Currently configure's has_sphinx_build() check simply runs a dummy
> sphinx-build and either passes or fails.  This means that "no
> sphinx-build at all" and "sphinx-build exists but is too old" are
> both reported the same way.
>
> Further, we want to assume that all the Python we write is running
> with at least Python 3.5; configure checks that for our scripts, but
> Sphinx extensions run with whatever Python version sphinx-build
> itself is using.
>
> Add a check to our conf.py which makes sphinx-build fail if it would
> be running our extensions with an old Python, and handle this
> in configure so we can report failure helpfully to the user.
> This will mean that configure --enable-docs will fail like this
> if the sphinx-build provided is not suitable:
>
> Warning: sphinx-build exists but it is either too old or uses too old a P=
ython version
>
> ERROR: User requested feature docs
>        configure was not able to find it.
>        Install texinfo, Perl/perl-podlators and a Python 3 version of pyt=
hon-sphinx
>
> (As usual, the default is to simply not build the docs, as we would
> if sphinx-build wasn't present at all.)
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Reviewed-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
> ---
>  configure    | 12 ++++++++++--
>  docs/conf.py | 10 ++++++++++
>  2 files changed, 20 insertions(+), 2 deletions(-)
>
> diff --git a/configure b/configure
> index 0aceb8e50db..2c5cad13edd 100755
> --- a/configure
> +++ b/configure

Any particular reason for having $sphinx_build default to the
indeterminate version sphinx-build rather than sphinx-build-3?

It's here:

   pkg_config=3Dquery_pkg_config
   sdl2_config=3D"${SDL2_CONFIG-${cross_prefix}sdl2-config}"
   sphinx_build=3Dsphinx-build

   # If the user hasn't specified ARFLAGS, default to 'rv', just as make do=
es.
   ARFLAGS=3D"${ARFLAGS-rv}"

> @@ -4808,11 +4808,19 @@ has_sphinx_build() {
> =20
>  # Check if tools are available to build documentation.
>  if test "$docs" !=3D "no" ; then
> -  if has makeinfo && has pod2man && has_sphinx_build; then
> +  if has_sphinx_build; then
> +    sphinx_ok=3Dyes
> +  else
> +    sphinx_ok=3Dno
> +  fi
> +  if has makeinfo && has pod2man && test "$sphinx_ok" =3D "yes"; then
>      docs=3Dyes
>    else
>      if test "$docs" =3D "yes" ; then
> -      feature_not_found "docs" "Install texinfo, Perl/perl-podlators and=
 python-sphinx"
> +      if has $sphinx_build && test "$sphinx_ok" !=3D "yes"; then
> +        echo "Warning: $sphinx_build exists but it is either too old or =
uses too old a Python version" >&2
> +      fi
> +      feature_not_found "docs" "Install texinfo, Perl/perl-podlators and=
 a Python 3 version of python-sphinx"
>      fi
>      docs=3Dno
>    fi
> diff --git a/docs/conf.py b/docs/conf.py
> index ee7faa6b4e7..7588bf192ee 100644
> --- a/docs/conf.py
> +++ b/docs/conf.py
> @@ -28,6 +28,16 @@
> =20
>  import os
>  import sys
> +import sphinx
> +from sphinx.errors import VersionRequirementError
> +
> +# Make Sphinx fail cleanly if using an old Python, rather than obscurely
> +# failing because some code in one of our extensions doesn't work there.
> +# Unfortunately this doesn't display very neatly (there's an unavoidable
> +# Python backtrace) but at least the information gets printed...
> +if sys.version_info < (3,5):
> +    raise VersionRequirementError(
> +        "QEMU requires a Sphinx that uses Python 3.5 or better\n")
> =20
>  # The per-manual conf.py will set qemu_docdir for a single-manual build;
>  # otherwise set it here if this is an entire-manual-set build.


