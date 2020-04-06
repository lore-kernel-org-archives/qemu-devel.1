Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C051FC2BA19
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 09:24:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88CE520644
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 09:24:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ry/Zvir+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88CE520644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56699 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLNzn-00088A-PG
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 05:24:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41281)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1jLNsE-0004hl-02
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 05:16:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1jLNsB-0006Xv-5a
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 05:16:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27634
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1jLNsB-0006X7-16
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 05:16:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586164608;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Gq7YWLjq5eX5E8Nx5BIaB0j4PUge91Tq/2My6a2X1go=;
 b=Ry/Zvir+eU+4/4LPgTocEfKxwMHbUx3CL1IEFb4+ZkEHbOlPQf8RwomK6J7GLEEEv5sG8E
 A69mHjhThb4a7qWNQoXc0sZs0sf2yv/UaZaVNZMNbwUmZot/kSYQ9LNNVIr80ia53fTj6r
 +Kyefemhbs0Mc74K+XdLoGWIPNNNOLM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-237-fkjEJ6ZIMgmqxAk4rSEYuw-1; Mon, 06 Apr 2020 05:16:31 -0400
X-MC-Unique: fkjEJ6ZIMgmqxAk4rSEYuw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E5CAF801E67;
 Mon,  6 Apr 2020 09:16:29 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.46])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DB788101D480;
 Mon,  6 Apr 2020 09:16:21 +0000 (UTC)
Date: Mon, 6 Apr 2020 10:16:18 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v4 for-5.0] configure: warn if not using a separate build
 directory
Message-ID: <20200406091618.GG794362@redhat.com>
References: <20200403135306.665493-1-berrange@redhat.com>
 <CAFEAcA_CSiw4ojYHVD6S73O-iRuXt6gTS=3VdAO545q8ye0+Ww@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_CSiw4ojYHVD6S73O-iRuXt6gTS=3VdAO545q8ye0+Ww@mail.gmail.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 Liviu Ionescu <ilg@livius.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Apr 05, 2020 at 03:38:55PM +0100, Peter Maydell wrote:
> On Fri, 3 Apr 2020 at 14:53, Daniel P. Berrang=C3=A9 <berrange@redhat.com=
> wrote:
> >
> > Running configure directly from the source directory is a build
> > configuration that will go away in future. It is also not currently
> > covered by any automated testing. Display a deprecation warning if
> > the user attempts to use an in-srcdir build setup, so that they are
> > aware that they're building QEMU in an undesirable manner.
> >
> > Reviewed-by: Eric Blake <eblake@redhat.com>
> > Reviewed-by: Markus Armbruster <armbru@redhat.com>
> > Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> > Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> > Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> > ---
>=20
> > +if test "$in_srcdir" =3D "yes"; then
> > +    echo
> > +    echo "WARNING: SUPPORT FOR BUILDING IN THE SOURCE DIR IS DEPRECATE=
D"
> > +    echo
> > +    echo "Support for running the 'configure' script directly from the=
"
> > +    echo "source directory is deprecated. In-tree builds are not cover=
ed"
> > +    echo "by automated testing and thus may not correctly build QEMU."
> > +    echo "Users are recommended to use a separate build directory:"
> > +    echo
> > +    echo "  $ mkdir build"
> > +    echo "  $ cd build"
> > +    echo "  $ ../configure"
> > +    echo "  $ make"
> > +    echo
> > +fi
>=20
> So here's my stab at some text here; I'm aiming at nudging users
> towards out-of-tree builds if they were simply not thinking about
> it, but not actively marking them as 'deprecated', since it sounded
> to me like we were planning to keep at least the basic
> 'configure+make+make install' sequence of commands working.
>=20
> echo "NOTE: we recommend against building in the source directory"
> echo
> echo "You've run the 'configure' script directly from the source"
> echo "directory. This will work, but we recommend using a separate"
> echo "build directory, especially if you plan to work with the QEMU"
> echo "sources rather than just building it once. You can switch to"
> echo "a separate build directory like this:"

I'm fine with that text too.

I'll submit another version of the patch with that incorporated


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


