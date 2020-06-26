Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3E45C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 13:31:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83EC020679
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 13:31:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OMYhCEJ5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83EC020679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33920 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jooS4-0004dt-RF
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 09:31:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60580)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jooRC-0003qg-Ri
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 09:30:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48044
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jooRA-0005wM-Bo
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 09:30:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593178234;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oCcGnXN1ptlCvQV/dQ5PjNS8CFbc9h8dCCce7+HNYBA=;
 b=OMYhCEJ5Xp5bhEQhbK/bquIxovunc1ZpmQoy0E4dJmdIyftphfLWwA/16mGqWALUgEjY5x
 1bq5b2ia+b075JieQLrUoARbqp2RZYWG4yLEufZfkHzq7Tk5ogeu2i/GCmoxXt5Wu1GKVu
 tS+2d+oY1qQyaeENOyoAXZsTKRNX1UY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-3-RjpYk_hfM3mSgb0DERYiIg-1; Fri, 26 Jun 2020 09:30:30 -0400
X-MC-Unique: RjpYk_hfM3mSgb0DERYiIg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7CE7A107B275;
 Fri, 26 Jun 2020 13:30:28 +0000 (UTC)
Received: from localhost (ovpn-114-181.ams2.redhat.com [10.36.114.181])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5542A1010428;
 Fri, 26 Jun 2020 13:30:22 +0000 (UTC)
Date: Fri, 26 Jun 2020 14:30:20 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: John G Johnson <john.g.johnson@oracle.com>
Subject: Re: RFC: use VFIO over a UNIX domain socket to implement device
 offloading
Message-ID: <20200626133020.GZ281902@stefanha-x1.localdomain>
References: <20200401091712.GA221892@stefanha-x1.localdomain>
 <MW2PR02MB372349E25A0842DE045B95F58BD40@MW2PR02MB3723.namprd02.prod.outlook.com>
 <8101D131-3B95-4CF5-8D46-8755593AA97D@oracle.com>
 <A0E4C51F-B41C-486B-A5CE-3C4C2C9C1A40@oracle.com>
 <20200602090629.66f9e3f7@x1.home>
 <E78F4C2E-4382-4C98-9606-F1ABD9753699@oracle.com>
 <20200615104929.GD1491454@stefanha-x1.localdomain>
 <DE330A27-2343-459F-9EA0-D3C5F20EE87D@oracle.com>
 <20200623122715.GF36568@stefanha-x1.localdomain>
 <7B305CB0-0D5F-4FF8-ACDC-828AF37687B1@oracle.com>
MIME-Version: 1.0
In-Reply-To: <7B305CB0-0D5F-4FF8-ACDC-828AF37687B1@oracle.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="csehs8AeUiGwWnbr"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/26 01:49:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: "Walker, Benjamin" <benjamin.walker@intel.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>, Jag Raman <jag.raman@oracle.com>,
 Swapnil Ingle <swapnil.ingle@nutanix.com>, "Harris,
 James R" <james.r.harris@intel.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Stefan Hajnoczi <stefanha@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Kirti Wankhede <kwankhede@nvidia.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Kanth Ghatraju <Kanth.Ghatraju@oracle.com>,
 Felipe Franciosi <felipe@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>, "Zhang,
 Tina" <tina.zhang@intel.com>, "Liu, Changpeng" <changpeng.liu@intel.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--csehs8AeUiGwWnbr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 25, 2020 at 08:54:25PM -0700, John G Johnson wrote:
>=20
>=20
> > On Jun 23, 2020, at 5:27 AM, Stefan Hajnoczi <stefanha@gmail.com> wrote=
:
> >=20
> > On Thu, Jun 18, 2020 at 02:38:04PM -0700, John G Johnson wrote:
> >>> On Jun 15, 2020, at 3:49 AM, Stefan Hajnoczi <stefanha@redhat.com> wr=
ote:
> >>> An issue with file descriptor passing is that it's hard to revoke acc=
ess
> >>> once the file descriptor has been passed. memfd supports sealing with
> >>> fnctl(F_ADD_SEALS) it doesn't revoke mmap(MAP_WRITE) on other process=
es.
> >>>=20
> >>> Memory Protection Keys don't seem to be useful here either and their
> >>> availability is limited (see pkeys(7)).
> >>>=20
> >>> One crazy idea is to use KVM as a sandbox for running the device and =
let
> >>> the vIOMMU control the page tables instead of the device (guest). Tha=
t
> >>> way the hardware MMU provides memory translation, but I think this is
> >>> impractical because the guest environment is too different from the
> >>> Linux userspace environment.
> >>>=20
> >>> As a starting point adding DMA_READ/DMA_WRITE messages would provide =
the
> >>> functionality and security. Unfortunately it makes DMA expensive and
> >>> performance will suffer.
> >>>=20
> >>=20
> >> =09Are you advocating for only using VFIO_USER_DMA_READ/WRITE and
> >> not passing FDs at all?  The performance penalty would be large for th=
e
> >> cases where the client and server are equally trusted.  Or are you
> >> advocating for an option where the slower methods are used for cases
> >> where the server is less trusted?
> >=20
> > I think the enforcing IOMMU should be optional (due to the performance
> > overhead) but part of the spec from the start.
> >=20
>=20
>=20
> =09With this in mind, we will collapse the current memory region
> messages (VFIO_USER_ADD_MEMORY_REGION and VFIO_USER_SUB_MEMORY_REGION)
> and the IOMMU messages (VFIO_USER_IOMMU_MAP and VFIO_USER_IOMMU_UNMAP)
> into new messages (VFIO_USER_DMA_MAP and VFIO_USER_DMA_UNMAP).  Their
> contents will be the same as the memory region messages.
>=20
> =09On a system without an IOMMU, the new messages will be used to
> export the system physical address space as DMA addresses.  On a system
> with an IOMMU they will be used to export the valid device DMA ranges
> programmed into the IOMMU by the guest.  This behavior matches how the
> existing QEMU VFIO object programs the host IOMMU.  The server will not
> be aware of whether the client is using an IOMMU.
>
> =09In the QEMU VFIO implementation, will will add a =E2=80=98secure-dma=
=E2=80=99
> option that suppresses exporting mmap()able FDs to the server.  All
> DMA will use the slow path to be validated by the client before accessing
> guest memory.
>=20
> =09Is this acceptable to you (and Alex, of course)?

Sounds good to me.

Stefan

--csehs8AeUiGwWnbr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl71+GwACgkQnKSrs4Gr
c8ilewgAuiE/WCTdlOKCFrTFsknoJ2zGWUBCl2i/6jdSawwwLuX/Ywv7srinL6aT
x2MORnWEXh4CKqtaxGz9SsKJmFeuhObH4i4HrwViKn7htJkD2+USgclK/KmmkTz0
Ufy7SvCYQaALDkV55gsIRfX4uX5eaLw2d8SpyGjTUfJ6sxCi8VZqr34b/WE3dWNJ
dfSoad7wYRBqUjEGWejX4zT+t+2UOq701YVvpzFWpyEFKe873PwTFvtB4oXrhhWk
TpZTrKY6Pz/jcODeOUDTrdWi/leQPSBuJSrstwLgx5dMrgZOm95XqvlpdBTl0Mu9
tgl3+UakXkqdEh03GtWlb6d6deEG6A==
=BphJ
-----END PGP SIGNATURE-----

--csehs8AeUiGwWnbr--


