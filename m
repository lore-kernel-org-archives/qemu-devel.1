Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98A25C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 11:42:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6365E20838
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 11:42:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q/dTB/Co"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6365E20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJFHi-0006HW-FN
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 07:42:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58235)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1jJFGt-0005Nw-0G
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 07:41:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1jJFGr-0001lt-0s
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 07:41:30 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:26705
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1jJFGq-0001kk-M3
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 07:41:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585654886;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ySWe8cW2A7J0S/pCvWvveCGlRR5byTdhZPqB9PQDrio=;
 b=Q/dTB/Coql1ITkS/0bOhU3nbJf+Z7zyGe+uj/6i+CvgWpyOE78ddwoqG6EHYapR7VDLBav
 v4Ia69HUK9V35M/sWdX7bDLrJmztZ9jcVLdaIWztTTqg0UgR5lTOrpWVMy7yRJVYqK4q3R
 3OfPeJbo73ZS7TWTq/cEWQBB9gQ9xfE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-216-tLG5CEYAOdijaR8kCkprhg-1; Tue, 31 Mar 2020 07:41:11 -0400
X-MC-Unique: tLG5CEYAOdijaR8kCkprhg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2DC4A801E70;
 Tue, 31 Mar 2020 11:41:10 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.48])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1F30A5DA66;
 Tue, 31 Mar 2020 11:41:06 +0000 (UTC)
Date: Tue, 31 Mar 2020 12:41:03 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH] configure: warn if not using a separate build directory
Message-ID: <20200331114103.GE353752@redhat.com>
References: <20200331103758.370644-1-berrange@redhat.com>
 <9b81074d-b9c8-8392-19a2-2f377224b66f@redhat.com>
MIME-Version: 1.0
In-Reply-To: <9b81074d-b9c8-8392-19a2-2f377224b66f@redhat.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Liviu Ionescu <ilg@livius.net>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Mar 31, 2020 at 01:11:45PM +0200, Philippe Mathieu-Daud=C3=A9 wrote=
:
> On 3/31/20 12:37 PM, Daniel P. Berrang=C3=A9 wrote:
> > Running configure directly from the source directory is a build
> > configuration that will go away in future. It is also not currently
> > covered by any automated testing. Display a deprecation warning if
> > the user attempts to use an in-srcdir build setup, so that they are
> > aware that they're building QEMU in an undesirable manner.
> >=20
> > Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> > ---
> >   configure | 30 ++++++++++++++++++++++++++++++
> >   1 file changed, 30 insertions(+)
> >=20
> > diff --git a/configure b/configure
> > index e225a1e3ff..1ab7492ab5 100755
> > --- a/configure
> > +++ b/configure
> > @@ -3,6 +3,19 @@
> >   # qemu configure script (c) 2003 Fabrice Bellard
> >   #
> > +BUILDDIR=3D$(pwd)
> > +SRCDIR=3D$(dirname "$0")
>=20
> This duplicates $source_path.
> Maybe you can rename it $source_path and remove the $source_path assignme=
nt
> later.

Sure, could do that..

>=20
> > +
> > +ABS_BUILDDIR=3D$(realpath $BUILDDIR)
> > +ABS_SRCDIR=3D$(realpath $SRCDIR)
> > +
> > +in_srcdir=3Dno
> > +if [ "$ABS_SRCDIR" =3D=3D "$ABS_BUILDDIR" ]
> > +then
> > +    in_srcdir=3Dyes
> > +fi
> > +
> > +
> >   # Unset some variables known to interfere with behavior of common too=
ls,
> >   # just as autoconf does.
> >   CLICOLOR_FORCE=3D GREP_OPTIONS=3D
> > @@ -6799,6 +6812,23 @@ if test "$supported_os" =3D "no"; then
> >       echo "us upstream at qemu-devel@nongnu.org."
> >   fi
> > +if test "$in_srcdir" =3D "yes"; then
> > +    echo
> > +    echo "WARNING: SUPPORT FOR IN SOURCE DIR BUILDS IS DEPRECATED"
> > +    echo
> > +    echo "Support for running the 'configure' script directly from the=
"
> > +    echo "source directory is deprecated and will go away in a future"
> > +    echo "release. In source dir builds are not covered by automated"
> > +    echo "testing and are liable to break without warning. Users are"
> > +    echo "strongly recommended to switch to a separate build directory=
:"
> > +    echo
> > +    echo "  $ mkdir build"
> > +    echo "  $ cd build"
> > +    echo "  $ ../configure"
> > +    echo "  $ make"
> > +    echo
> > +fi
>=20
> I'd move it at the very end of the file, to be the last thing displayed.

You can't see it from the diff, but immediately before here are a bunch
of other big warnings for users, so I figured it was a good idea to keep
them all together.

> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>=20
> > +
> >   config_host_mak=3D"config-host.mak"
> >   echo "# Automatically generated by configure - do not modify" >config=
-all-disas.mak
> >=20
>=20

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


