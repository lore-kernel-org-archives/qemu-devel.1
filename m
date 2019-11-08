Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF883C5DF60
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 09:31:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C196214DA
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 09:31:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UskkCVvA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C196214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT0bu-0008Ca-Kj
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 04:31:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36599)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1iT0Zp-0006S4-DX
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 04:29:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1iT0Zn-0005Il-CU
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 04:29:08 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42798
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1iT0Zn-0005IU-7a
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 04:29:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573205346;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/UsEF8249J5UvxR2XrvM5Edk36IdNRKBnLTKQ5iCdfQ=;
 b=UskkCVvAQBguc5fMS5wu/d9n4K4QoH2I9aUL/r6r8I1nIXLezwI6VgPcWuLFrrosl9FSE1
 9PGRVJ5HtlT2qlQvUmszD1R/Eeat3whNsFQgi49EU2zOTrAUB6UNEU9iUerfP+Z1NIhiid
 9vwaJYm3683EOCqWby6iou++zteAUNE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-54-dyvZDusCPxG34VDXlZa8ng-1; Fri, 08 Nov 2019 04:29:05 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1B8A6180496F;
 Fri,  8 Nov 2019 09:29:04 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.23])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0969F1A7E2;
 Fri,  8 Nov 2019 09:28:58 +0000 (UTC)
Message-ID: <5a42c72c4d183bf0183372659e283100ae804c99.camel@redhat.com>
Subject: Re: [PATCH v2 11/11] iotests : add tests for encryption key management
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Date: Fri, 08 Nov 2019 11:28:58 +0200
In-Reply-To: <d66665e3-5eed-eef7-f56f-6392418913bf@redhat.com>
References: <20190912223028.18496-1-mlevitsk@redhat.com>
 <20190912223028.18496-12-mlevitsk@redhat.com>
 <d66665e3-5eed-eef7-f56f-6392418913bf@redhat.com>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: dyvZDusCPxG34VDXlZa8ng-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Kevin Wolf <kwolf@redhat.com>, "Daniel
 P. =?ISO-8859-1?Q?Berrang=E9?=" <berrange@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 2019-10-04 at 21:11 +0200, Max Reitz wrote:
> On 13.09.19 00:30, Maxim Levitsky wrote:
> > Note that currently I add tests 300-302, which are
> > placeholders to ease the rebase. In final version
> > of these patches I will update these.
> >=20
> > Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> > ---
> >  tests/qemu-iotests/300     | 202 +++++++++++++++++++++++++++++
> >  tests/qemu-iotests/300.out |  98 +++++++++++++++
> >  tests/qemu-iotests/301     |  90 +++++++++++++
> >  tests/qemu-iotests/301.out |  30 +++++
> >  tests/qemu-iotests/302     | 252 +++++++++++++++++++++++++++++++++++++
> >  tests/qemu-iotests/302.out |  18 +++
> >  tests/qemu-iotests/303     | 228 +++++++++++++++++++++++++++++++++
> >  tests/qemu-iotests/303.out |  28 +++++
> >  tests/qemu-iotests/group   |   9 ++
> >  9 files changed, 955 insertions(+)
> >  create mode 100755 tests/qemu-iotests/300
> >  create mode 100644 tests/qemu-iotests/300.out
> >  create mode 100755 tests/qemu-iotests/301
> >  create mode 100644 tests/qemu-iotests/301.out
> >  create mode 100644 tests/qemu-iotests/302
> >  create mode 100644 tests/qemu-iotests/302.out
> >  create mode 100644 tests/qemu-iotests/303
> >  create mode 100644 tests/qemu-iotests/303.out
>=20
> [...]
>=20
> > diff --git a/tests/qemu-iotests/303.out b/tests/qemu-iotests/303.out
> > new file mode 100644
> > index 0000000000..1cf3917208
> > --- /dev/null
> > +++ b/tests/qemu-iotests/303.out
> > @@ -0,0 +1,28 @@
> > +qemu-img: Failed to get shared "consistent read" lock
> > +Is another process using the image [/home/mlevitsk/USERSPACE/qemu/buil=
d-luks/tests/qemu-iotests/scratch/test.img]?
>=20
> Ah, this should be filtered.

Ooops, missed this one, thanks!
Fixed now.

>=20
> Max
>=20

Best regards,
=09Maxim Levitsky



