Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA473C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 14:57:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B286C20675
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 14:57:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dfZDEUDQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B286C20675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39576 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJIKl-0000Ig-TQ
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 10:57:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56278)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1jJIJq-0007AQ-ND
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 10:56:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1jJIJo-0004ZZ-PS
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 10:56:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48328
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1jJIJo-0004Yw-LG
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 10:56:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585666603;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HMBaGt1boVUMe4+5sOFGgsGSg3D34oRCzsilXzJ4NBA=;
 b=dfZDEUDQxY2Tn+D2XqWMRkU7O2iOSoow1fO72bbKstIG2OixLuQQnfmpV7g/QGPzszqLNY
 caxAOfqKMw/cQ06Od2Q54TxwcjQ+0z2kN2E9u3dI6YKIvyFPmAoLK5ROVvulYU8v569Kq3
 8+fk/KDLlKUCLL7mO990NbxiAuXYhzE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-360-Vgo-KHp6P4idczrnsVjgtg-1; Tue, 31 Mar 2020 10:56:25 -0400
X-MC-Unique: Vgo-KHp6P4idczrnsVjgtg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7D97D1083E92;
 Tue, 31 Mar 2020 14:56:19 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.48])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 688851001B2D;
 Tue, 31 Mar 2020 14:56:12 +0000 (UTC)
Date: Tue, 31 Mar 2020 15:56:09 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH] configure: warn if not using a separate build directory
Message-ID: <20200331145609.GK353752@redhat.com>
References: <20200331103758.370644-1-berrange@redhat.com>
 <042a22e2-5be5-ba57-1c35-8f210d9718fd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <042a22e2-5be5-ba57-1c35-8f210d9718fd@redhat.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Liviu Ionescu <ilg@livius.net>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Mar 31, 2020 at 09:44:37AM -0500, Eric Blake wrote:
> On 3/31/20 5:37 AM, Daniel P. Berrang=C3=A9 wrote:
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
>=20
> It sounds like you already have a v2 coming up to address Phillipe's
> comments, but I'd be happy to see this concept make it into v5.0.
>=20
> > diff --git a/configure b/configure
> > index e225a1e3ff..1ab7492ab5 100755
> > --- a/configure
> > +++ b/configure
> > @@ -3,6 +3,19 @@
> >   # qemu configure script (c) 2003 Fabrice Bellard
> >   #
> > +BUILDDIR=3D$(pwd)
>=20
> Why fork out to 'pwd', when we can rely on $PWD for the same answer? Note
> that both $(pwd) and $PWD $BUILDDIR always give an absolute (but no
> necessarily canonical) path, which means...
>=20
> > +SRCDIR=3D$(dirname "$0")
> > +
> > +ABS_BUILDDIR=3D$(realpath $BUILDDIR)
>=20
> ...calling this ABS_BUILDDIR is a misnomer (it was already absolute). Wha=
t
> it is really doing is chasing through symlinks to result in a canonical
> name, particularly since unless you have absolute names, using only strin=
g
> comparison to see if two filenames are equivalent will have false negativ=
es
> (/tmp vs. /tmp/., for example).
>=20
> > +ABS_SRCDIR=3D$(realpath $SRCDIR)
>=20
> Not robust if there are spaces in the directory names.  Safer would be
> ABS_BUILDDIR=3D$(realpath -- "$BUILDDIR")
> and similarly for ABS_SRCDIR.
>=20
> > +
> > +in_srcdir=3Dno
> > +if [ "$ABS_SRCDIR" =3D=3D "$ABS_BUILDDIR" ]
>=20
> Bashism. You MUST spell this '=3D', not '=3D=3D', since configure is run =
under
> /bin/sh which might be dash which does not understand =3D=3D.

Ok, will address all of the above.

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
> You know, it WOULD be possible to further enhance this to actually create
> 'build' as well as a shim GNUmakefile that would auto-forward on to build=
ing
> directly in build, so that you maintain the illusion of an in-place build
> (other than all the build artifacts now living in a different location), =
and
> muscle memory for in-tree 'make' still works; I've posted elsewhere and w=
ill
> repeat here the contents of my GNUmakefile:

I wanted to focus strictly on the part that we have agreement on, namely
the deprecation. Any functional changes should be completely separate
to avoid holding up the merge of the warning message patch.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


