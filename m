Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1A67C2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 17:50:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0DD6206F0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 17:50:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PoASAQnb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0DD6206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwrTu-0003O0-V4
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 12:50:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37302)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1iwrTB-0002rz-DT
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 12:49:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1iwrTA-0005lR-Cg
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 12:49:41 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30281
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1iwrTA-0005lC-9f
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 12:49:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580320180;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c1Ic+oHwyh30POhr92tzckwig+2k1LDEQpsQgUoaOnk=;
 b=PoASAQnbUQUEOAbQH+14Di8Yz3asDgYyUIVNg/qtf9MZZfQttsXWw+EQA+QNN/rsgahgLa
 wqtQzLzaxppY04bRv39Csrio8SsR25/RaYo71e32PJam40AI/zQZRbFsUjmIaEfC83sDRj
 ebhTluAR+JNeGye7sCYvPB6/3ZtLeXw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-10-77AoBHRMPbe8pOVQMxVaQA-1; Wed, 29 Jan 2020 12:49:36 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5BABF13E2;
 Wed, 29 Jan 2020 17:49:35 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.103])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 957B860BF3;
 Wed, 29 Jan 2020 17:49:30 +0000 (UTC)
Message-ID: <4e5776937a0098a7a2e025c990a241644f92ae52.camel@redhat.com>
Subject: Re: [PATCH 01/13] qcrypto: add generic infrastructure for crypto
 options amendment
From: Maxim Levitsky <mlevitsk@redhat.com>
To: "Daniel P." =?ISO-8859-1?Q?Berrang=E9?= <berrange@redhat.com>
Date: Wed, 29 Jan 2020 19:49:29 +0200
In-Reply-To: <20200128165934.GT1446339@redhat.com>
References: <20200114193350.10830-1-mlevitsk@redhat.com>
 <20200114193350.10830-2-mlevitsk@redhat.com>
 <20200128165934.GT1446339@redhat.com>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: 77AoBHRMPbe8pOVQMxVaQA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 2020-01-28 at 16:59 +0000, Daniel P. Berrang=C3=A9 wrote:
> On Tue, Jan 14, 2020 at 09:33:38PM +0200, Maxim Levitsky wrote:
> > This will be used first to implement luks keyslot management.
> >=20
> > block_crypto_amend_opts_init will be used to convert
> > qemu-img cmdline to QCryptoBlockAmendOptions
> >=20
> > Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> > ---
> >  block/crypto.c         | 17 +++++++++++++++++
> >  block/crypto.h         |  3 +++
> >  crypto/block.c         | 31 +++++++++++++++++++++++++++++++
> >  crypto/blockpriv.h     |  8 ++++++++
> >  include/crypto/block.h | 22 ++++++++++++++++++++++
> >  qapi/crypto.json       | 16 ++++++++++++++++
> >  6 files changed, 97 insertions(+)
>=20
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>=20
>=20
> > diff --git a/qapi/crypto.json b/qapi/crypto.json
> > index b2a4cff683..9faebd03d4 100644
> > --- a/qapi/crypto.json
> > +++ b/qapi/crypto.json
> > @@ -309,3 +309,19 @@
> >    'base': 'QCryptoBlockInfoBase',
> >    'discriminator': 'format',
> >    'data': { 'luks': 'QCryptoBlockInfoLUKS' } }
> > +
> > +
> > +
> > +##
> > +# @QCryptoBlockAmendOptions:
> > +#
> > +# The options that are available for all encryption formats
> > +# when initializing a new volume
>=20
> minor point, the comment needs updating

Done.
Thanks for the review!

Best regards,
=09Maxim Levitsky

>=20
> > +#
> > +# Since: 5.0
> > +##
> > +{ 'union': 'QCryptoBlockAmendOptions',
> > +  'base': 'QCryptoBlockOptionsBase',
> > +  'discriminator': 'format',
> > +  'data': {
> > +            } }
>=20
> Regards,
> Daniel



