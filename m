Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53088C2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 13:46:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D15E2072C
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 13:46:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X9NmUYf8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D15E2072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42540 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuzI9-0005ib-BV
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 08:46:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37041)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iuzGt-0004dZ-8U
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 08:45:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iuzGr-0002VU-R0
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 08:45:15 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:39597
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1iuzGr-0002U5-Na
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 08:45:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579873513;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LRNoohjl+q/gi015jicWp1LxYjqP0NPbbX/wUs1JD6U=;
 b=X9NmUYf8e2WfILP6IYVQN6Dkm+c9R1Ctr34/wWhd2EOEdNgtJgdSHvQHsgIF2jbrLOBEX+
 ZaaZy4RRU4G3yNrVAkFMUZBuXScm2wSSH8yaHeIM9DL3SkK+Cdj98hoK4qUrGZgeyoHkOp
 6rtlOkc057l71XGWJnq7cJvX5NpWdtw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-175-jCQBPnHoMVeN8FOezPS5jQ-1; Fri, 24 Jan 2020 08:45:11 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 264431005514;
 Fri, 24 Jan 2020 13:45:10 +0000 (UTC)
Received: from dhcp-200-226.str.redhat.com (dhcp-200-226.str.redhat.com
 [10.33.200.226])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 957C185F13;
 Fri, 24 Jan 2020 13:45:06 +0000 (UTC)
Date: Fri, 24 Jan 2020 14:45:04 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH] iscsi: Don't access non-existent
 scsi_lba_status_descriptor
Message-ID: <20200124134504.GE4732@dhcp-200-226.str.redhat.com>
References: <20200123170544.30117-1-kwolf@redhat.com>
 <dd893da2-2c1a-ff9f-a176-dfda1cc229c4@redhat.com>
MIME-Version: 1.0
In-Reply-To: <dd893da2-2c1a-ff9f-a176-dfda1cc229c4@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: jCQBPnHoMVeN8FOezPS5jQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: qemu-block@nongnu.org, pl@kamp.de, qemu-devel@nongnu.org, mreitz@redhat.com,
 ronniesahlberg@gmail.com, felipe@nutanix.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 23.01.2020 um 21:37 hat John Snow geschrieben:
> On 1/23/20 12:05 PM, Kevin Wolf wrote:
> > In iscsi_co_block_status(), we may have received num_descriptors =3D=3D=
 0
> > from the iscsi server. Therefore, we can't unconditionally access
> > lbas->descriptors[0]. Add the missing check.
> >=20
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >  block/iscsi.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/block/iscsi.c b/block/iscsi.c
> > index cbd57294ab..c8feaa2f0e 100644
> > --- a/block/iscsi.c
> > +++ b/block/iscsi.c
> > @@ -753,7 +753,7 @@ retry:
> >      }
> > =20
> >      lbas =3D scsi_datain_unmarshall(iTask.task);
> > -    if (lbas =3D=3D NULL) {
> > +    if (lbas =3D=3D NULL || lbas->num_descriptors =3D=3D 0) {
> >          ret =3D -EIO;
> >          goto out_unlock;
> >      }
> >=20
>=20
> Naive question: Does the specification allow for such a response? Is
> this inherently an error?

Even if iscsi allowed it, it would be a useless response, because it
means that you didn't get the block status of any block.

bdrv_co_block_status() may only return *pnum =3D=3D 0 at EOF, so I don't
think we have any other option than returning an error. (We could retry,
but if a target returns a useless response once, why should we trust it
do behave better the second time?)

> Anyway, this is better than accessing junk memory, so:
>=20
> Reviewed-by: John Snow <jsnow@redhat.com>

Thanks!

Kevin


