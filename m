Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4509CC2BA17
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 15:46:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D93B248CC
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 15:46:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C37XJgyx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D93B248CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLTxU-0007U8-4C
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 11:46:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45441)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1jLTwr-000749-QF
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 11:46:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1jLTwq-0007tu-8i
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 11:46:05 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:45284
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1jLTwq-0007qu-4r
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 11:46:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586187963;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+Rh0SbBem7u7FqErpwsqnMH3QshZTZg6uS5Ejl0HMLk=;
 b=C37XJgyxf8mQPzKbH2Nn7DpnaY5sLWpa595egzwyDv5YAWAwlZ77EcpvpfzdBGJnFU0/WG
 OR9GFl391M08j8QLULsxa+4HNieg3CApCX+0RlgYNt/amT+ZpZ4z/CslPSXyYoTrlz8dSh
 afkqGP51u0xgQT33d1HOMEbMSDQgXSs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-321-PXQGU_x2Pa6_5pEtpIfkdg-1; Mon, 06 Apr 2020 11:45:44 -0400
X-MC-Unique: PXQGU_x2Pa6_5pEtpIfkdg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1C13F18B9FCC;
 Mon,  6 Apr 2020 15:45:43 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.46])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2AEF99DD60;
 Mon,  6 Apr 2020 15:45:38 +0000 (UTC)
Date: Mon, 6 Apr 2020 16:45:36 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v5 for-5.0] configure: warn if not using a separate build
 directory
Message-ID: <20200406154536.GU794362@redhat.com>
References: <20200406153326.806024-1-berrange@redhat.com>
 <72daed8e-020f-c5b0-4ef8-6f9d3f105434@redhat.com>
MIME-Version: 1.0
In-Reply-To: <72daed8e-020f-c5b0-4ef8-6f9d3f105434@redhat.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Liviu Ionescu <ilg@livius.net>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Stefan Hajnoczi <stefanha@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Apr 06, 2020 at 10:38:45AM -0500, Eric Blake wrote:
> On 4/6/20 10:33 AM, Daniel P. Berrang=C3=A9 wrote:
> > Running configure directly from the source directory is a build
> > configuration that will go away in future. It is also not currently
> > covered by any automated testing. Display a deprecation warning if
>=20
> Calling it a deprecation warning may be overkill now that we've toned dow=
n
> the language.
>=20
> > the user attempts to use an in-srcdir build setup, so that they are
> > aware that they're building QEMU in an undesirable manner.
> >=20
> > Reviewed-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
> > Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> > Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> > ---
> >=20
>=20
> > +if test "$in_srcdir" =3D "yes"; then
> > +    echo
> > +    echo "NOTE: we recommend against building in the source directory"
> > +    echo
> > +    echo "You've run the 'configure' script directly from the source"
> > +    echo "directory. This will work, but we recommend using a separate=
"
> > +    echo "build directory, especially if you plan to work with the QEM=
U"
> > +    echo "sources rather than just building it once. You can switch to=
"
> > +    echo "a separate build directory like this:"
> > +    echo
> > +    echo "  $ mkdir build"
>=20
> As I pointed out on v4, this is missing a step.  Since this is just a
> warning and not fatal, './configure' completed and polluted the in-tree
> directories to the point that following these instructions will fail unle=
ss
> they start with 'make distclean' prior to the other steps.

Hmm, I was thinking this wasn't needed because we would assume this  was
a fresh checkout, but I had forgot that this very run of configure will
have polluted it.

>=20
> > +    echo "  $ cd build"
> > +    echo "  $ ../configure"
> > +    echo "  $ make"
> > +    echo
> > +fi
> > +
> >   config_host_mak=3D"config-host.mak"
> >   echo "# Automatically generated by configure - do not modify" >config=
-all-disas.mak
> >=20
>=20
> --=20
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3226
> Virtualization:  qemu.org | libvirt.org
>=20
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


