Return-Path: <SRS0=2P1T=2A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AB14C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 19:27:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6690D207FF
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 19:27:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d38HIw3H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6690D207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35116 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iel9w-0002mx-Kc
	for qemu-devel@archiver.kernel.org; Tue, 10 Dec 2019 14:27:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55358)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1iel99-0002Iu-Ri
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 14:26:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1iel98-0004mt-Fl
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 14:26:11 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28876
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1iel98-0004me-BF
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 14:26:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576005969;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=99NYkZEeR1hl7tpQA49CCDCC0unaCuS/lT+v3iZ+TGg=;
 b=d38HIw3HLKEdIvA8clzcqqqe3JPcYiP0okAtntYIaIX98yV9X/3p9PLx1ahqdwnAvRq75v
 3eED7x0fq/ys3HQvL0LkkOffEjebGNhUj11vjzfUrOtguh0DG0v1MqXiXKMOj1tW+jFMFZ
 +2cUqadeBilZh2b6wqvfzDc4281FHzM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-357-ciRzRw0VO_-eck3LCj_pXA-1; Tue, 10 Dec 2019 14:26:08 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 01FA1801E74;
 Tue, 10 Dec 2019 19:26:07 +0000 (UTC)
Received: from localhost (ovpn-116-90.gru2.redhat.com [10.97.116.90])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4DEC15C57C;
 Tue, 10 Dec 2019 19:26:06 +0000 (UTC)
Date: Tue, 10 Dec 2019 16:26:04 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Cleber Rosa <crosa@redhat.com>
Subject: Re: [PATCH 2/2] analyze-migration.py: replace numpy with python 3.2
Message-ID: <20191210192604.GR498046@habkost.net>
References: <20191127101038.327080-1-marcandre.lureau@redhat.com>
 <20191127101038.327080-3-marcandre.lureau@redhat.com>
 <20191206142723.GA5020@dhcp-17-72.bos.redhat.com>
 <20191210025857.GQ498046@habkost.net>
 <CAJ+F1CL_0ytd2O4m1FcqQbFSLh3S5v=fLY=FyUZa4zg47uCOQA@mail.gmail.com>
 <20191210174909.GA4230@dhcp-17-72.bos.redhat.com>
 <20191210175728.GA21398@dhcp-17-72.bos.redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191210175728.GA21398@dhcp-17-72.bos.redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: ciRzRw0VO_-eck3LCj_pXA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=iso-8859-1
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
Cc: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>,
 QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Dec 10, 2019 at 12:57:28PM -0500, Cleber Rosa wrote:
> On Tue, Dec 10, 2019 at 12:49:11PM -0500, Cleber Rosa wrote:
> > On Tue, Dec 10, 2019 at 02:14:18PM +0400, Marc-Andr=E9 Lureau wrote:
> > > Hi
> > >=20
> > > On Tue, Dec 10, 2019 at 6:59 AM Eduardo Habkost <ehabkost@redhat.com>=
 wrote:
> > > >
> > > > On Fri, Dec 06, 2019 at 09:27:23AM -0500, Cleber Rosa wrote:
> > > > > On Wed, Nov 27, 2019 at 02:10:38PM +0400, Marc-Andr=E9 Lureau wro=
te:
> > > > > > Use int.from_bytes() from python 3.2 instead.
> > > > > >
> > > > > > Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com=
>
> > > > > > ---
> > > > > >  scripts/analyze-migration.py | 35 +++++++++++++++++++---------=
-------
> > > > > >  1 file changed, 19 insertions(+), 16 deletions(-)
> > > > > >
> > > > > > diff --git a/scripts/analyze-migration.py b/scripts/analyze-mig=
ration.py
> > > > > > index 2b835d9b70..96a31d3974 100755
> > > > > > --- a/scripts/analyze-migration.py
> > > > > > +++ b/scripts/analyze-migration.py
> > > > > > @@ -1,4 +1,4 @@
> > > > > > -#!/usr/bin/env python
> > > > > > +#!/usr/bin/env python3
> > > > [...]
> > > > >
> > > > > Marc-Andr=E9, I couldn't yet pinpoint the reason yet, but this pa=
tch
> > > > > changes the parsing of bool fields.  This is a diff between the o=
utput
> > > > > pre/post this patch on the same images:
> > > > >
> > > > > $ diff -u out_x8664_pre out_x8664_post
> > > > > --- out_x8664_pre       2019-12-06 09:14:16.128943264 -0500
> > > > > +++ out_x8664_post      2019-12-06 09:23:35.861378600 -0500
> > > > > @@ -3039,7 +3039,7 @@
> > > > >              "mac_reg[RADV]": "0x00000000",
> > > > >              "mac_reg[TADV]": "0x00000000",
> > > > >              "mac_reg[ITR]": "0x00000000",
> > > > > -            "mit_irq_level": true
> > > > > +            "mit_irq_level": false
> > > > >          },
> > > > >          "e1000/full_mac_state": {
> > > > >              "mac_reg": [
> > > > > @@ -36010,10 +36010,10 @@
> > > > >              ],
> > > > >              "smb_auxctl": "0x02",
> > > > >              "smb_blkdata": "0x00",
> > > > > -            "i2c_enable": true,
> > > > > +            "i2c_enable": false,
> > > > >              "op_done": true,
> > > > > -            "in_i2c_block_read": true,
> > > > > -            "start_transaction_on_status_read": true
> > > > > +            "in_i2c_block_read": false,
> > > > > +            "start_transaction_on_status_read": false
> > > > >          },
> > > > >          "ar.tmr.timer": "ff ff ff ff ff ff ff ff",
> > > > >          "ar.tmr.overflow_time": "0x0000000000000000",
> > > > >
> > > > > This true/false flipping is consistent across various images (tri=
ed on
> > > > > images generated on a few other targets).
> > > >
> > > > It looks like moving to python3 accidentally fixes a bug.
> > > >
> > > > This is VMSDFieldBool.read:
> > > >
> > > >     def read(self):
> > > >         super(VMSDFieldBool, self).read()
> > > >         if self.data[0] =3D=3D 0:
> > > >             self.data =3D False
> > > >         else:
> > > >             self.data =3D True
> > > >         return self.data
> > > >
> > > > On python2, MigrationFile.readvar() returned a string, so the
> > > > (self.data[0] =3D=3D 0) check was never true.  This means all boole=
an
> > > > fields were always initialized to True.
> > > >
> > > > On python3, MigrationFile.readvar() returns a bytearray, so the
> > > > (self.data[0] =3D=3D 0) check now works as expected.
> > >=20
> > > Ah! nice surprise. Do you mind updating the commit message on commit?
> > > Or should I resend?
> > >=20
> > > thanks
> > >=20
> > > --=20
> > > Marc-Andr=E9 Lureau
> > >=20
> >=20
> > Yep, I'm queueing this with an updated commit message.
> >=20
> > Eduardo, does your comment imply a "Reviewed-by"?

Sure!

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>


> >=20
> > Cheers,
> > - Cleber.
>=20
> Eduardo,
>=20
> I only noticed now that you queued patch 1/2.  Do you want me to queue
> that one instead?  Or do you wanto to queue both on this series?

If you are planning a new pull request soon, feel free to queue
both, and also to pull all patches from my python-next branch so
it is included in a single pull request.  Thanks!

--=20
Eduardo


