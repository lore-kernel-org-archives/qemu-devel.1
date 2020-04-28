Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F40F3C83004
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 18:47:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0D3B20575
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 18:47:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gL0WPx10"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0D3B20575
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTVGh-0001VK-RO
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 14:47:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52676)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jTVEg-0007CI-Do
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 14:46:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jTVER-0005lZ-Ca
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 14:45:38 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:49097
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jTVEQ-0005kt-Qk
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 14:45:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588099521;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Uodua9Ai08PhFUIrlZHvAPZzKJUZqMDa7BcJyY3DfM4=;
 b=gL0WPx104NDM1eHzV5hZlLJgiyua6KSiEJ2+Jjop7IZ/x5v15dCuFanwHkO7Ma7NksEVrF
 3Rxq7lGCbJrPZ18dWK08Izv810JvJjVqP7Uv5cqLEZEWp68qrjudHYhlV5L5CqRep8IR2N
 L3jow9sA5yI15POxfUbfXtj6NRNpENM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-328--TMcEAk9MFaDQo4t_6oGww-1; Tue, 28 Apr 2020 14:45:19 -0400
X-MC-Unique: -TMcEAk9MFaDQo4t_6oGww-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3EFFE800D24;
 Tue, 28 Apr 2020 18:45:18 +0000 (UTC)
Received: from linux.fritz.box (ovpn-114-37.ams2.redhat.com [10.36.114.37])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6931B5C1BD;
 Tue, 28 Apr 2020 18:45:16 +0000 (UTC)
Date: Tue, 28 Apr 2020 20:45:14 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v7 04/10] qcow2: Support BDRV_REQ_ZERO_WRITE for truncate
Message-ID: <20200428184514.GP5789@linux.fritz.box>
References: <20200424125448.63318-1-kwolf@redhat.com>
 <20200424125448.63318-5-kwolf@redhat.com>
 <6e1df4f4-366f-2612-fd18-ba916fd1a622@redhat.com>
MIME-Version: 1.0
In-Reply-To: <6e1df4f4-366f-2612-fd18-ba916fd1a622@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/28 02:06:42
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
Cc: vsementsov@virtuozzo.com,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com,
 berto@igalia.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 28.04.2020 um 18:28 hat Eric Blake geschrieben:
> On 4/24/20 7:54 AM, Kevin Wolf wrote:
> > If BDRV_REQ_ZERO_WRITE is set and we're extending the image, calling
> > qcow2_cluster_zeroize() with flags=3D0 does the right thing: It doesn't
> > undo any previous preallocation, but just adds the zero flag to all
> > relevant L2 entries. If an external data file is in use, a write_zeroes
> > request to the data file is made instead.
> >=20
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >   block/qcow2-cluster.c |  2 +-
> >   block/qcow2.c         | 34 ++++++++++++++++++++++++++++++++++
> >   2 files changed, 35 insertions(+), 1 deletion(-)
> >=20
>=20
> > +++ b/block/qcow2.c
> > @@ -1726,6 +1726,7 @@ static int coroutine_fn qcow2_do_open(BlockDriver=
State *bs, QDict *options,
> >       bs->supported_zero_flags =3D header.version >=3D 3 ?
> >                                  BDRV_REQ_MAY_UNMAP | BDRV_REQ_NO_FALLB=
ACK : 0;
> > +    bs->supported_truncate_flags =3D BDRV_REQ_ZERO_WRITE;
>=20
> Is this really what we want for encrypted files, or would it be better as=
:
>=20
>     if (bs->encrypted) {
>         bs->supported_truncate_flags =3D 0;
>     } else {
>         bs->supported_truncate_flags =3D BDRV_REQ_ZERO_WRITE;
>     }
>=20
> At the qcow2 level, we can guarantee a read of 0 even for an encrypted
> image, but is that really what we want?  Is setting the qcow2 zero flag o=
n
> the cluster done at the decrypted level (at which point we may be leaking
> information about guest contents via anyone that can read the qcow2
> metadata) or at the encrypted level (at which point it's useless
> information, because knowing the underlying file reads as zero still
> decrypts into garbage)?

The zero flag means that the guest reads zeros, even with encrypted
files. I'm not sure if it's worse than exposing the information which
clusters are allocated and which are unallocated, which we have always
been doing and which is hard to avoid without encrypting all the
metadata, too. But it does reveal some information.

If we think that exposing zero flags is worse than exposing the
allocation status, I would still not use your solution above. In that
case, the full fix would be returning -ENOTSUP from
.bdrv_co_pwrite_zeroes() to cover all other callers, too.

If we think that allocation status and zero flags are of comparable
importance, then we need to fix either both or nothing. Hiding all of
this information probably means encrypting at least the L2 tables and
potentially all of the metadata apart from the header. This would
obviously require an incompatible feature flag (and some effort to
implement it).

Kevin


