Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4745FC34047
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 10:48:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C75721D56
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 10:48:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NCzNnIku"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C75721D56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4Mu5-0003TD-AD
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 05:48:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60009)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1j4Mt1-0002Vh-PM
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 05:47:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1j4Mt0-0003B4-Ks
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 05:47:23 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:45802
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1j4Mt0-0003Au-Hd
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 05:47:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582109242;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=seHMaddBD+MJ8R43KsgxFe0WLxmoMo/ZHzkIpRWdNGM=;
 b=NCzNnIku84oRR4z8e7IMJsSVkD367QSGdujEFvtcg/FbnJx8wVDNvFeFiwu+GQyiUW83wQ
 vTKcy+mhvhLq64MSwLfN4QdinmIZ5Kruvpus45bwhpo2vE6tBwHS59lUDFrgBpl4INyuwy
 J/zYxn8p5/WsW/xxFNTTuFzmlJ2xz/k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-114-Dp_lblWJP82Yy5jHOMwZdw-1; Wed, 19 Feb 2020 05:47:18 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 97F248010CA;
 Wed, 19 Feb 2020 10:47:17 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.28])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6335C1001B09;
 Wed, 19 Feb 2020 10:47:16 +0000 (UTC)
Message-ID: <845cac1792e49a1c6dfab6767cb4f2e99131679d.camel@redhat.com>
Subject: Re: [PATCH v2 0/5] block: Generic file creation fallback
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Date: Wed, 19 Feb 2020 12:47:15 +0200
In-Reply-To: <07edfa0c-25af-e519-eb41-5bcda107438e@redhat.com>
References: <20200122164532.178040-1-mreitz@redhat.com>
 <07edfa0c-25af-e519-eb41-5bcda107438e@redhat.com>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: Dp_lblWJP82Yy5jHOMwZdw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 2020-02-19 at 11:38 +0100, Max Reitz wrote:
> On 22.01.20 17:45, Max Reitz wrote:
> > Hi,
> >=20
> > As version 1, this series adds a fallback path for creating files (on
> > the protocol layer) if the protocol driver does not support file
> > creation, but the file already exists.
> >=20
> >=20
> > Branch: https://github.com/XanClic/qemu.git skip-proto-create-v2
> > Branch: https://git.xanclic.moe/XanClic/qemu.git skip-proto-create-v2
> >=20
> >=20
> > v2:
> > - Drop blk_truncate_for_formatting(): It doesn=E2=80=99t make sense to =
introduce
> >   this function any more after 26536c7fc25917d1bd13781f81fe3ab039643bff
> >   (=E2=80=9Cblock: Do not truncate file node when formatting=E2=80=9D),=
 because we=E2=80=99d
> >   only use it in bdrv_create_file_fallback().
> >   Thus, it makes more sense to create special helper functions
> >   specifically for bdrv_create_file_fallback().
> >=20
> > - Thus, dropped patches 2 and 3.
> >=20
> > - And changed patch 4 to include those helper functions.
> >=20
> > - Rebased, which was a bit of a pain.
>=20
> Thanks for the reviews, added a note to the new test why the second case
> is expected to fail (as requested by Maxim), and applied the series to
> my block branch:
>=20
> https://git.xanclic.moe/XanClic/qemu/commits/branch/block
>=20
> Max
>=20
Thank you too!
Best regards,
=09Maxim Levitsky


