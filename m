Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F0D7C8300B
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 12:29:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA1052076D
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 12:29:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cXSdMkBp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA1052076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59412 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU8JW-0004RD-QP
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 08:29:14 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37952)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1jU8Ho-0001TB-Sc
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 08:27:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1jU8A0-0002xH-Vc
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 08:23:49 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:27004
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1jU89z-0002nu-92
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 08:19:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588249160;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UsLizYyKJXCyrRYR0UcI3Uboa04oLMhB5FcouSKwO7Q=;
 b=cXSdMkBp29S7j2y0prT48nVprCZLfa0olNOuVKnb3IGp37x+d3Cvo8uzTwOQBKfDJmIK7l
 ESy1PqVVpUWqTpdXmvf5++QVqY+uocPEzX2Oeh3YeOl7Hij6lXDpwyCb3STXl9LhysHHOP
 Ul+9qql99L/y6eJv9icznlPxjJYrCKU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-250-RxFjNLg_PEOoD9OnvjBHwQ-1; Thu, 30 Apr 2020 08:19:19 -0400
X-MC-Unique: RxFjNLg_PEOoD9OnvjBHwQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C260745F;
 Thu, 30 Apr 2020 12:19:17 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.42])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8DB065D9F5;
 Thu, 30 Apr 2020 12:18:54 +0000 (UTC)
Message-ID: <ae6593445a8329735ef6fc6c8f395c328fe04dc1.camel@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/2] LUKS: better error message when
 creating too large files
From: Maxim Levitsky <mlevitsk@redhat.com>
To: "Daniel P." =?ISO-8859-1?Q?Berrang=E9?= <berrange@redhat.com>
Date: Thu, 30 Apr 2020 15:18:53 +0300
In-Reply-To: <20190722090556.GC23775@redhat.com>
References: <20190721181508.28608-1-mlevitsk@redhat.com>
 <20190721181508.28608-2-mlevitsk@redhat.com>
 <20190722090556.GC23775@redhat.com>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mlevitsk@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/30 01:04:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 2019-07-22 at 10:05 +0100, Daniel P. Berrang=C3=A9 wrote:
> On Sun, Jul 21, 2019 at 09:15:07PM +0300, Maxim Levitsky wrote:
> > Currently if you attampt to create too large file with luks you
> > get the following error message:
> >=20
> > Formatting 'test.luks', fmt=3Dluks size=3D17592186044416 key-secret=3Ds=
ec0
> > qemu-img: test.luks: Could not resize file: File too large
> >=20
> > While for raw format the error message is
> > qemu-img: test.img: The image size is too large for file format 'raw'
> >=20
> >=20
> > The reason for this is that qemu-img checks for errono of the failure,
> > and presents the later error when it is -EFBIG
> >=20
> > However crypto generic code 'swallows' the errno and replaces it
> > with -EIO.
> >=20
> > As an attempt to make it better, we can make luks driver,
> > detect -EFBIG and in this case present a better error message,
> > which is what this patch does
> >=20
> > The new error message is:
> >=20
> > qemu-img: error creating test.luks: The requested file size is too larg=
e
> >=20
> > Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=3D1534898
> > Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> > ---
> >  block/crypto.c | 25 +++++++++++++++++++++----
> >  1 file changed, 21 insertions(+), 4 deletions(-)
>=20
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>


Could someone pick to a maintainer tree, now that freeze is over?


Best regards,
=09Maxim Levitsky
>=20
> Regards,
> Daniel



