Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E8A8C5DF60
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 11:50:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EB562245A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 11:50:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bnz1kcGh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EB562245A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52748 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT2mz-0004zJ-2M
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 06:50:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36305)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1iT2l6-00038x-W1
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 06:48:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1iT2l5-0007tE-S6
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 06:48:56 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31123
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1iT2l5-0007si-GE
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 06:48:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573213735;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kgciMlfj8fnJdQImr+Y8qlRoRf2UH8LblkGo6hwSxIc=;
 b=bnz1kcGhzs9S5X0bV6T9szBi2JjO/txo+yZVVGIGNX/DnQtGVorOljboGlnY3xxy/s5cGH
 7a53RVIYjPnoOtmdWGlNdah04ayAXT1MON+m7kx2HVbLhzK368mUgT5c/uty6LROG5VM+1
 I30BzoEwy9zfGDv68zOZhq66F/vnFew=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-103-EkkyRCvcM1axkKoU7lcicA-1; Fri, 08 Nov 2019 06:48:53 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BD4E1800C72;
 Fri,  8 Nov 2019 11:48:52 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.23])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EEC916084E;
 Fri,  8 Nov 2019 11:48:47 +0000 (UTC)
Message-ID: <8f0857a01eec965ac91fb44083227d7b9fe866f1.camel@redhat.com>
Subject: Re: [PATCH v2 02/11] qcrypto-luks: extend the create options for
 upcoming encryption key management
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Date: Fri, 08 Nov 2019 13:48:46 +0200
In-Reply-To: <af4b3495-0b8d-e269-4190-779535526ab4@redhat.com>
References: <20190912223028.18496-1-mlevitsk@redhat.com>
 <20190912223028.18496-3-mlevitsk@redhat.com>
 <e0e85ab0-e84b-0ee8-8467-ff11e803f7cf@redhat.com>
 <5aa3ad22b0adb236f2ff67c183121c2896e0e1da.camel@redhat.com>
 <af4b3495-0b8d-e269-4190-779535526ab4@redhat.com>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: EkkyRCvcM1axkKoU7lcicA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
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
Cc: Kevin Wolf <kwolf@redhat.com>, "Daniel
 P. =?ISO-8859-1?Q?Berrang=E9?=" <berrange@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 2019-11-08 at 11:48 +0100, Max Reitz wrote:
> On 08.11.19 10:28, Maxim Levitsky wrote:
> > On Fri, 2019-10-04 at 19:42 +0200, Max Reitz wrote:
> > > On 13.09.19 00:30, Maxim Levitsky wrote:
> > > > Now you can specify which slot to put the encryption key to
> > > > Plus add 'active' option which will let  user erase the key secret
> > > > instead of adding it.
> > > > Check that active=3Dtrue it when creating.
> > > >=20
> > > > Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> > > > ---
> > > >  block/crypto.c             |  2 ++
> > > >  block/crypto.h             | 16 +++++++++++
> > > >  block/qcow2.c              |  2 ++
> > > >  crypto/block-luks.c        | 26 +++++++++++++++---
> > > >  qapi/crypto.json           | 19 ++++++++++++++
> > > >  tests/qemu-iotests/082.out | 54 ++++++++++++++++++++++++++++++++++=
++++
> > > >  6 files changed, 115 insertions(+), 4 deletions(-)
> > >=20
> > > (Just doing a cursory RFC-style review)
> > >=20
> > > I think we also want to reject unlock-secret if it=E2=80=99s given fo=
r creation;
> >=20
> > Agree, I'll do this in the next version.
> >=20
> > > and I suppose it=E2=80=99d be more important to print which slots are=
 OK than
> > > the slot the user has given.  (It isn=E2=80=99t like we shouldn=E2=80=
=99t print that
> > > slot index, but it=E2=80=99s more likely the user knows that than wha=
t the
> > > limits are.  I think.)
> >=20
> > I don't really understand what you mean here :-(=20
> >=20
> > Since this is qmp interface,
> > I can't really print anything from it, other that error messages.
>=20
> Exactly, I=E2=80=99m referring to the error message.  Right now it=E2=80=
=99s:
>=20
> "Invalid slot %" PRId64 " is specified", luks_opts.slot
>=20
> I think it should be something like:
>=20
> "Invalid slot %" PRId64 " specified, must be between 0 and %u",
> luks_opt.slot, QCRYPTO_BLOCK_LUKS_NUM_KEY_SLOTS - 1

This is a very good idea! implemented now and will
post in the next version.

Best regards,
=09Maxim Levitsky




