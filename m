Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93763C432C3
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 11:13:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DAD720709
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 11:13:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VUhf5xjy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DAD720709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXkPL-0004v6-Ii
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 06:13:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51453)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iXkOU-0004JC-HZ
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 06:13:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iXkOT-0003tn-42
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 06:13:02 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:22729
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1iXkOT-0003tf-01
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 06:13:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574334780;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pthsFfgXSvZifHZBodIOsz+nkD+ojPRV5LUeuXjTkFY=;
 b=VUhf5xjyLiQTxPOS0fiZJGVyNCdD7xetudDX3/8pKIKjJXM3MxmlKmJLQa+lybUtz+7ys/
 1JtzNRUmA1Itb99NKMUf9r9jywno1SrI0tG4h9gfQ6t2WXfjy1qQhDjNeqAgyilNjDGSFS
 Laq0XXll46A6uqStP2XSSvQlogwPjBU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-16-Tqhhaan-NqOs-Vr87ROnRw-1; Thu, 21 Nov 2019 06:12:58 -0500
X-MC-Unique: Tqhhaan-NqOs-Vr87ROnRw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 093E2477;
 Thu, 21 Nov 2019 11:12:58 +0000 (UTC)
Received: from linux.fritz.box (ovpn-117-225.ams2.redhat.com [10.36.117.225])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 21A8152FC1;
 Thu, 21 Nov 2019 11:12:56 +0000 (UTC)
Date: Thu, 21 Nov 2019 12:12:55 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [RFC 0/4] POC: Generating realistic block errors
Message-ID: <20191121111255.GC6007@linux.fritz.box>
References: <20190919194847.18518-1-tasleson@redhat.com>
 <20190920092226.GH14365@stefanha-x1.localdomain>
 <32a302d7-b85a-991b-4366-2a82e38a9382@redhat.com>
 <0752f1c5-ed79-bda4-ad53-6b2566cc35a2@redhat.com>
 <20191121103012.GE439743@stefanha-x1.localdomain>
MIME-Version: 1.0
In-Reply-To: <20191121103012.GE439743@stefanha-x1.localdomain>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="3siQDZowHQqNOShm"
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
Cc: Tony Asleson <tasleson@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--3siQDZowHQqNOShm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 21.11.2019 um 11:30 hat Stefan Hajnoczi geschrieben:
> On Thu, Nov 14, 2019 at 09:47:48AM -0600, Tony Asleson wrote:
> > On 9/20/19 12:28 PM, Tony Asleson wrote:
> > > On 9/20/19 4:22 AM, Stefan Hajnoczi wrote:
> > >> blkdebug is purely at the QEMU block layer level.  It is not aware o=
f
> > >> storage controller-specific error information or features.  If you w=
ant
> > >> to inject NVMe- or SCSI-specific errors that make no sense in QEMU's
> > >> block layer, then trying to do it in blkdebug becomes a layering
> > >> violation.  This justifies adding a new error injection feature dire=
ctly
> > >> into AHCI, virtio-scsi, NVMe, etc devices.
> > >=20
> > > Good discussion point...
> > >=20
> > > In my opening use case for this POC I'm generically trying to create =
an
> > > unrecoverable media error for a specific sector.  For each of the
> > > different device types it's different on how that error is conveyed a=
nd
> > > the associated data in transfer.
> > >=20
> >=20
> > I would like to get some additional clarification on this point.  Shoul=
d
> > I be investing more time integrating my proposed functionality into
> > blkdebug or other?
> >=20
> > Sorry for the long response time, got sidetracked with other stuff.
>=20
> blkdebug can inject EIO when a specific LBA is accessed.  Is that
> enough for what you want to do?  Then you can reuse and maybe extend
> blkdebug.

And if we need something more device specific, maybe a common core can
be extracted that can be used by both blkdebug and the devices. All of
the logic of managing error injection rules and checking whether
something needs to be done at the current event should be common between
both.

Kevin

--3siQDZowHQqNOShm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJd1nE3AAoJEH8JsnLIjy/Wrm8QALIaMztTWOESt2jjfUsZqO6i
qgH14Xz1oSjXC9TkYMy2LOH2pvDF4aw1l0GKP7BGnHto4PgbgimBJ1l0BP/eBzlk
OYyady8mSyp8OB/GyLo0ouBacuydIVp8wS4QNdO3e8JJCMFuZvYSz1wa7gSWlp2k
8YfC/BG29O91B38FFBCcx5weOE0bJdjT0J4bqgA/KTFHV8dvAjlG3f4jFnTJfmo0
iXYWnii7SQe022sdsCD7boNihz32WSOryarh4LNv5MvBJRkPkWNa1E1aw4boP2IR
m92+lJ7cIZ/ntHwe/WMcnwMZrYE1cqyKTjBs4vX/IT2AezVxlI9Ni/LXKJq6xnPq
CjzsavWIgV0sLvbk2MM4u/303AMF9/pjZX2i2fIOghov9525SHEavlrNV6n0YlkM
Dz7es/r3dVeY3Em2Piw+q02IRzJNeGjWnmzCL9x77pdSWUQbb4Wm3a8nxFDknB2c
6W9f94bgp7M+imJQ8GsXYQBIcBRYwd9et4UWdTe3RVNALVhKXYZAlLkVgdmJlZV7
VB6+JbsH8qDf4Txpt/HYMJQpwRxxyi954f7YaSLxPiayqvB08itW/hf3aA4bJY1m
QwlsOOQDz9M99DZMzHYze0fQ5D5X3tmAS6cqKG9r7naTzPn5i52/eRn+7kNBnKa0
qRT1AvuXzfd45ppKvxM5
=rjmJ
-----END PGP SIGNATURE-----

--3siQDZowHQqNOShm--


