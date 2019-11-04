Return-Path: <SRS0=KlJF=Y4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCC96CA9EB5
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 17:57:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 895B920B7C
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 17:57:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jWhP79Di"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 895B920B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36072 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iRgb7-0003GG-OU
	for qemu-devel@archiver.kernel.org; Mon, 04 Nov 2019 12:57:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37422)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1iRgZA-0001Hq-OU
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 12:55:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1iRgZ8-00051v-PM
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 12:55:00 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:35572
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1iRgZ7-00051R-I7
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 12:54:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572890097;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Cqlt20Il8WW6eeXgRwt499k4JduQVeSXESVFwzxNW40=;
 b=jWhP79DiDjX0y+zXr14wPPUqQ1CFiSyU4z2wl1CWArSm6EDavMDV52IRJ2vJZqqfMRpP3J
 wq7pQSQkKGZTQqcxlO+55lsQpVQruTxP1Pd2rzt6y/jJzE3/qdm6iXR4tlKlPMVtj5mzw+
 tfkTObocXbGdB6TvXNUBEUhGPfOaSa0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-42-2DgAGRniNP2G58qR5v6U6A-1; Mon, 04 Nov 2019 12:54:53 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4A0161005500;
 Mon,  4 Nov 2019 17:54:52 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.61])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9840D60136;
 Mon,  4 Nov 2019 17:54:41 +0000 (UTC)
Message-ID: <91caef5769cc3c60a79592ddb3695c883edd9bc0.camel@redhat.com>
Subject: Re: [PATCH v2 0/2] block/nvme: add support for write zeros and discard
From: Maxim Levitsky <mlevitsk@redhat.com>
To: John Snow <jsnow@redhat.com>, Max Reitz <mreitz@redhat.com>, 
 qemu-devel@nongnu.org
Date: Mon, 04 Nov 2019 19:54:41 +0200
In-Reply-To: <c3c30afc-9e28-fa10-9159-8843e5375d84@redhat.com>
References: <20190913133627.28450-1-mlevitsk@redhat.com>
 <24390891-6aef-f457-7648-71846360a09c@redhat.com>
 <c3c30afc-9e28-fa10-9159-8843e5375d84@redhat.com>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: 2DgAGRniNP2G58qR5v6U6A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-block@nongnu.org, Keith Busch <kbusch@kernel.org>,
 Kevin Wolf <kwolf@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 2019-10-29 at 09:33 -0400, John Snow wrote:
>=20
> On 10/28/19 6:35 AM, Max Reitz wrote:
> > On 13.09.19 15:36, Maxim Levitsky wrote:
> > > This is the second part of the patches I prepared
> > > for this driver back when I worked on mdev-nvme.
> > >=20
> > > V2: addressed review feedback, no major changes
> > >=20
> > > Best regards,
> > > =09Maxim Levitsky
> > >=20
> > > Maxim Levitsky (2):
> > >   block/nvme: add support for write zeros
> > >   block/nvme: add support for discard
> > >=20
> > >  block/nvme.c         | 155 +++++++++++++++++++++++++++++++++++++++++=
+-
> > >  block/trace-events   |   3 +
> > >  include/block/nvme.h |  19 +++++-
> > >  3 files changed, 175 insertions(+), 2 deletions(-)
> >=20
> > Thanks, fixed the indentation in nvme.h in patch 1, and applied to my
> > block branch:
> >=20
> > https://git.xanclic.moe/XanClic/qemu/commits/branch/block
> >=20
> > For the record, I don=E2=80=99t think !!x has benefits over x !=3D 0 an=
d I
> > personally prefer bool y =3D x over any of it. O:-)
> >=20
>=20
> Well, that's even better :) For me, it's about making booleans obvious
> as booleans and that's all.
>=20
> --js
Thanks to all of you!!
Best regards,
=09Maxim Levitsky


