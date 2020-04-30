Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76FD2C8300A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 13:09:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E8FE2082E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 13:09:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BieX09cU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E8FE2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40940 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU8w9-0007sV-CD
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 09:09:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43268)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1jU8tB-00063d-8Y
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 09:08:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1jU8qW-000178-SZ
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 09:06:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44024
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1jU8qW-00016o-Eb
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 09:03:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588251799;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f8E8pe4uJFSVCL12YBXfbCIOFNXJWwSkFGUcxoMb0vY=;
 b=BieX09cUAxnFLILhF38cF532sCBd1HTvEDObL/rxWEIuETQkT5Au9Z1vdVrSbWRfpM64tl
 AREiRcX7xnZqtMFBLLo80JzSdCp3SMJFHbjEEeXYBdk4+uNIFHgnu2D0w+QvueaM4Bc5Yo
 dqwlUFuDMNy7jbpTMkUIj+C/E3Q8E7s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-136-JhWeAgEcME2-nVeDX2TtQg-1; Thu, 30 Apr 2020 09:03:16 -0400
X-MC-Unique: JhWeAgEcME2-nVeDX2TtQg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5609F1005510;
 Thu, 30 Apr 2020 13:03:15 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.42])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A0FF42855B;
 Thu, 30 Apr 2020 13:03:08 +0000 (UTC)
Message-ID: <01347fa11dedc2eec731c405468eb12081efdd43.camel@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/2] LUKS: better error message when
 creating too large files
From: Maxim Levitsky <mlevitsk@redhat.com>
To: "Daniel P." =?ISO-8859-1?Q?Berrang=E9?= <berrange@redhat.com>
Date: Thu, 30 Apr 2020 16:03:06 +0300
In-Reply-To: <ae6593445a8329735ef6fc6c8f395c328fe04dc1.camel@redhat.com>
References: <20190721181508.28608-1-mlevitsk@redhat.com>
 <20190721181508.28608-2-mlevitsk@redhat.com>
 <20190722090556.GC23775@redhat.com>
 <ae6593445a8329735ef6fc6c8f395c328fe04dc1.camel@redhat.com>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mlevitsk@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/30 01:24:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 2020-04-30 at 15:18 +0300, Maxim Levitsky wrote:
> On Mon, 2019-07-22 at 10:05 +0100, Daniel P. Berrang=C3=A9 wrote:
> > On Sun, Jul 21, 2019 at 09:15:07PM +0300, Maxim Levitsky wrote:
> > > Currently if you attampt to create too large file with luks you
> > > get the following error message:
> > >=20
> > > Formatting 'test.luks', fmt=3Dluks size=3D17592186044416 key-secret=
=3Dsec0
> > > qemu-img: test.luks: Could not resize file: File too large
> > >=20
> > > While for raw format the error message is
> > > qemu-img: test.img: The image size is too large for file format 'raw'
> > >=20
> > >=20
> > > The reason for this is that qemu-img checks for errono of the failure=
,
> > > and presents the later error when it is -EFBIG
> > >=20
> > > However crypto generic code 'swallows' the errno and replaces it
> > > with -EIO.
> > >=20
> > > As an attempt to make it better, we can make luks driver,
> > > detect -EFBIG and in this case present a better error message,
> > > which is what this patch does
> > >=20
> > > The new error message is:
> > >=20
> > > qemu-img: error creating test.luks: The requested file size is too la=
rge
> > >=20
> > > Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=3D1534898
> > > Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> > > ---
> > >  block/crypto.c | 25 +++++++++++++++++++++----
> > >  1 file changed, 21 insertions(+), 4 deletions(-)
> >=20
> > Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>=20
>=20
> Could someone pick to a maintainer tree, now that freeze is over?
>=20
>=20
> Best regards,
> =09Maxim Levitsky
> >=20
> > Regards,
> > Daniel
>=20
>=20
I replied to an old version, please disregard,
Best regards,
=09Maxim Levitsky


