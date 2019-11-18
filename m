Return-Path: <SRS0=QE2o=ZK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B40D2C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 18:24:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83E1F222AA
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 18:24:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iypXxij0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83E1F222AA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38070 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWlhG-0002Z5-L7
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 13:24:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38040)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1iWlgI-0001gk-92
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 13:23:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1iWlgG-0001or-Dz
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 13:23:21 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:32645
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1iWlgG-0001oH-7U
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 13:23:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574101399;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F2SXrF7aecbny3PmToLo1GC76VqVpdf27JCFprJuCcg=;
 b=iypXxij0uU/mKINV7jFhIsHUe429Qw7rjBvWMGums+Jzeiq2gPvNdqjUfJN98IxiFcgyxX
 6RFg1x82/alPWCBQJatiAXTUgU7gSv7dH5wdy4oQqY9E3hsMlq9kuTjBfbr00oWgAAL4qm
 Gm+7gUFu/QPFDBf4tArEm+D/QrJXebM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-361-M1KFjM3xPx-RzbGIHxa-6w-1; Mon, 18 Nov 2019 13:23:16 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5C9081800D7D;
 Mon, 18 Nov 2019 18:23:14 +0000 (UTC)
Received: from gondolin (ovpn-117-194.ams2.redhat.com [10.36.117.194])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D7DE81B078;
 Mon, 18 Nov 2019 18:23:12 +0000 (UTC)
Date: Mon, 18 Nov 2019 19:23:10 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Eric Farman <farman@linux.ibm.com>
Subject: Re: [RFC PATCH v1 2/8] vfio-ccw: Don't inject an I/O interrupt if
 the subchannel is not enabled
Message-ID: <20191118192310.6af29cd1.cohuck@redhat.com>
In-Reply-To: <20191115033437.37926-3-farman@linux.ibm.com>
References: <20191115033437.37926-1-farman@linux.ibm.com>
 <20191115033437.37926-3-farman@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: M1KFjM3xPx-RzbGIHxa-6w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 Jared Rossi <jrossi@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 15 Nov 2019 04:34:31 +0100
Eric Farman <farman@linux.ibm.com> wrote:

> From: Farhan Ali <alifm@linux.ibm.com>
>=20
> According to PoPs, when the SCHIB.PMCW bit 8 is 0 status presented by
> the device is not made available to the program. So don't inject an
> interrupt in the guest if the guest OS has not enabled the
> subchannel.

Have you managed to trigger this state in real life?

>=20
> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
> Signed-off-by: Eric Farman <farman@linux.ibm.com>
> ---
>=20
> Notes:
>     v0->v1: [EF]
>      - Update commit message, as the bit in question is bit 8 not 15
>=20
>  hw/vfio/ccw.c | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
> index 0919ddbeb8..0590a6f512 100644
> --- a/hw/vfio/ccw.c
> +++ b/hw/vfio/ccw.c
> @@ -230,6 +230,11 @@ static void vfio_ccw_io_notifier_handler(void *opaqu=
e)
>          return;
>      }
> =20
> +    /* Virtual subchannel is not enabled */
> +    if (!(schib->pmcw.flags & PMCW_FLAGS_MASK_ENA)) {

How can that happen? We should not be able to disable the subchannel
while it is in active use, should we? I fear I'm missing something
here...

> +        return;
> +    }
> +
>      size =3D pread(vcdev->vdev.fd, region, vcdev->io_region_size,
>                   vcdev->io_region_offset);
>      if (size =3D=3D -1) {


