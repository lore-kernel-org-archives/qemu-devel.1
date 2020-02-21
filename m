Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8462C35656
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 15:30:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 764892073A
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 15:30:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="axcKzau1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 764892073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59738 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j5AFo-0008GW-GQ
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 10:30:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36062)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1j5AEs-0007Kc-FH
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 10:29:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1j5AEr-0001v6-4R
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 10:29:13 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:52051
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1j5AEr-0001uU-0t
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 10:29:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582298951;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5oGiI9Ez6zBo1YbY2paGvIgRUjI17CEfivu6Tunwdj4=;
 b=axcKzau1ujxDKFBVpAHSuzW9EeHRd28sCN+Qou9vAfrgrErujcNbUQeMZC2Vxm0eXlxFww
 vNmP8OCWVx05zcVcHJaiFqpfGxjEEM0nbFjB3SlKhmKfQTGrVoeXpeMl7uKnL5eIAcyjSV
 Cgc4L7omIiosTle6iqLbNr34XsGmnwo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-172-6g36JQMhMBKUbRsy3X4KnQ-1; Fri, 21 Feb 2020 10:29:07 -0500
X-MC-Unique: 6g36JQMhMBKUbRsy3X4KnQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C5DFA801E66;
 Fri, 21 Feb 2020 15:29:06 +0000 (UTC)
Received: from localhost (ovpn-117-223.ams2.redhat.com [10.36.117.223])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A924627096;
 Fri, 21 Feb 2020 15:29:03 +0000 (UTC)
Date: Fri, 21 Feb 2020 15:29:02 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 5/5] aio-posix: make AioHandler dispatch O(1) with epoll
Message-ID: <20200221152902.GC1511783@stefanha-x1.localdomain>
References: <20200214171712.541358-1-stefanha@redhat.com>
 <20200214171712.541358-6-stefanha@redhat.com>
 <38c8e61b-377b-07bd-f55b-a1a773b72701@redhat.com>
 <20200221125948.GI1484511@stefanha-x1.localdomain>
 <425318ef-0b19-983b-b2ea-93754c48cb8d@redhat.com>
 <20200221144708.GD1501077@stefanha-x1.localdomain>
 <607d1b80-f66f-6519-b3e5-af48e1a65900@redhat.com>
MIME-Version: 1.0
In-Reply-To: <607d1b80-f66f-6519-b3e5-af48e1a65900@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="QRj9sO5tAVLaXnSD"
Content-Disposition: inline
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@gmail.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--QRj9sO5tAVLaXnSD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2020 at 04:04:10PM +0100, Paolo Bonzini wrote:
> On 21/02/20 15:47, Stefan Hajnoczi wrote:
> >>>       QLIST_SAFE_REMOVE(node, node_ready); /* remove from nested pare=
nt's list */
> >>>       ^---- would cause corruption if node->node_ready was stale!
> >>>
> >>> Would you like me to add a comment?
> >> No, it's okay.
> > Are you happy with this series?
>=20
> Yes.  Let's keep the Q*_REMOVE cleanup on the todo list.  I'd keep
> Q*_SAFE_REMOVE, but clear the pointer unconditionally in Q*_REMOVE so
> that we can have something like Q*_IN_LIST too.

QLIST_IS_INSERTED() is part of this patch series, although I can rename
it to Q*_IN_LIST() and cover all linked list variants. :)

> > Shall I include it in my next pull request or do you want to merge it?
>=20
> No, it's yours.

Thanks!

Stefan

--QRj9sO5tAVLaXnSD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl5P9z4ACgkQnKSrs4Gr
c8gAhAf8DYlnsM35zMCy3OSEpf+J1340nHCjwekImTvtNf8vVnZd+65vZZW9qH4C
NktEZkpOck0uKa0E+jAVnfxAfHVGgZsG1oqONWe+2Pb0G3vk1n5PAccLJ/ZCYikC
algWnLhl+Of3BOCj4ryJ6vqOAUfvcLmnNEBkzdvvPO680wZ5jULN/nYLnJlDg1+e
OiM4fpTDwZBR/LHslHujebmoxN2NdIZcNb8U+9DPFvUFV4tBAYCiTcEIFe7YgfUs
PrMm73xocHzrjI1wPabhu99nTs20mL66iD690KLnBi4fmLcOBa+loOnDUKYT1tN0
8sBNrbEfw3DG7gvnKFIK2XuXvNJY5w==
=37zH
-----END PGP SIGNATURE-----

--QRj9sO5tAVLaXnSD--


