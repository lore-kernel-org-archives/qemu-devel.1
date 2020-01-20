Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1409C2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 13:30:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BEBB22314
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 13:30:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ChjWLaVL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BEBB22314
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itX8C-0004th-1k
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 08:30:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33417)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1itX6h-0003MQ-TM
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 08:28:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1itX6g-0000xT-38
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 08:28:43 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:52926
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1itX6f-0000wR-V6
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 08:28:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579526919;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AAJe4kqtmrU/IdZE33ODVm6VXbqbz9DBAEUr7vS1iXM=;
 b=ChjWLaVLf4F/c35s07pVndk4oGDKnM4aCzmu709V2dKoeDlbUrPZYKtDxbLYBWOHKfdF1s
 1P+ZTuLopHQriVREIZAtcynX1VvWhL/29R/eoiic5X/2+cS6V+ZlKuOKOS9VZXixhaFdbu
 TysBanaIoczU5aMA4CjsB76hhAcjS4A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-330-kz3J-HB1P-e1oHQUDyIb-Q-1; Mon, 20 Jan 2020 08:28:36 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B55A4107ACC5;
 Mon, 20 Jan 2020 13:28:35 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.43])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2C88710027A9;
 Mon, 20 Jan 2020 13:28:29 +0000 (UTC)
Date: Mon, 20 Jan 2020 13:28:27 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH 040/104] virtiofsd: Pass write iov's all the way through
Message-ID: <20200120132827.GN2827@work-vm>
References: <20191212163904.159893-1-dgilbert@redhat.com>
 <20191212163904.159893-41-dgilbert@redhat.com>
 <5E240E69.2030803@cn.fujitsu.com>
 <df029231-7b99-818f-f89d-07f23675b22a@redhat.com>
MIME-Version: 1.0
In-Reply-To: <df029231-7b99-818f-f89d-07f23675b22a@redhat.com>
User-Agent: Mutt/1.13.0 (2019-11-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: kz3J-HB1P-e1oHQUDyIb-Q-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: vgoyal@redhat.com, Xiao Yang <yangx.jy@cn.fujitsu.com>, stefanha@redhat.com,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Philippe Mathieu-Daud=E9 (philmd@redhat.com) wrote:
> On 1/19/20 9:08 AM, Xiao Yang wrote:
> > On 2019/12/13 0:38, Dr. David Alan Gilbert (git) wrote:
> > > From: "Dr. David Alan Gilbert"<dgilbert@redhat.com>
> > >=20
> > > Pass the write iov pointing to guest RAM all the way through rather
> > > than copying the data.
> > >=20
> > > Signed-off-by: Dr. David Alan Gilbert<dgilbert@redhat.com>
> > > ---
> > > =A0 tools/virtiofsd/fuse_virtio.c | 79 ++++++++++++++++++++++++++++++=
++---
> > > =A0 1 file changed, 73 insertions(+), 6 deletions(-)
> > >=20
> [...]
> > Hi,
> >=20
> > Tested the patch and got the correct data written by guest, so it looks
> > fine to me.
> > Reviewed-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
>=20
> So also:
> Tested-by: Xiao Yang <yangx.jy@cn.fujitsu.com>

I'd take that but only if that's directly on a Xiao Yang's mail.

> >=20
> > Best Regards,
> > Xiao Yang
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


