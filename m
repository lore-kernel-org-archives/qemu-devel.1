Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02843C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 10:50:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C20C42068E
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 10:50:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h58ZqeCy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C20C42068E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48464 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkmhG-0003Ih-1V
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 06:50:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55496)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jkmgX-0002pw-Qe
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 06:49:49 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:32341)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jkmgV-00017M-Oo
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 06:49:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592218185;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EfybyArIQJIxBW6nhn+dS0O0AlniIc6yWc7CZDG4q6k=;
 b=h58ZqeCylPXsr6u1yqhAIs4aV9PDS1mRpOWUtqFrwaM/6wME8YzQ15/V91JBKG3rHS1it9
 wm2/fI/w42uWV2N+dDh9ZeyxKQTXvkpR/1NqHGIAbM29iuof1VDFLZO1F/1xesmim91/3g
 JPtW8a0ITmGq45+Idfc8GUi9julANKk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-8-iEkpQxYnMJi1qSAE3SOgdQ-1; Mon, 15 Jun 2020 06:49:40 -0400
X-MC-Unique: iEkpQxYnMJi1qSAE3SOgdQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BF5B3106B242;
 Mon, 15 Jun 2020 10:49:38 +0000 (UTC)
Received: from localhost (ovpn-115-9.ams2.redhat.com [10.36.115.9])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A51677CAA7;
 Mon, 15 Jun 2020 10:49:30 +0000 (UTC)
Date: Mon, 15 Jun 2020 11:49:29 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: John G Johnson <john.g.johnson@oracle.com>
Subject: Re: RFC: use VFIO over a UNIX domain socket to implement device
 offloading
Message-ID: <20200615104929.GD1491454@stefanha-x1.localdomain>
References: <MN2PR02MB62052E54C752229C115EAD898BCF0@MN2PR02MB6205.namprd02.prod.outlook.com>
 <20200401091712.GA221892@stefanha-x1.localdomain>
 <MW2PR02MB372349E25A0842DE045B95F58BD40@MW2PR02MB3723.namprd02.prod.outlook.com>
 <8101D131-3B95-4CF5-8D46-8755593AA97D@oracle.com>
 <A0E4C51F-B41C-486B-A5CE-3C4C2C9C1A40@oracle.com>
 <20200602090629.66f9e3f7@x1.home>
 <E78F4C2E-4382-4C98-9606-F1ABD9753699@oracle.com>
MIME-Version: 1.0
In-Reply-To: <E78F4C2E-4382-4C98-9606-F1ABD9753699@oracle.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="k4f25fnPtRuIRUb3"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/15 01:12:36
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
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Kirti Wankhede <kwankhede@nvidia.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Kanth Ghatraju <Kanth.Ghatraju@oracle.com>,
 Felipe Franciosi <felipe@nutanix.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, "Zhang,
 Tina" <tina.zhang@intel.com>, "Liu, Changpeng" <changpeng.liu@intel.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--k4f25fnPtRuIRUb3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 09, 2020 at 11:25:41PM -0700, John G Johnson wrote:
> > On Jun 2, 2020, at 8:06 AM, Alex Williamson <alex.williamson@redhat.com=
> wrote:
> >=20
> > On Wed, 20 May 2020 17:45:13 -0700
> > John G Johnson <john.g.johnson@oracle.com> wrote:
> >=20
> >>> I'm confused by VFIO_USER_ADD_MEMORY_REGION vs VFIO_USER_IOMMU_MAP_DM=
A.
> >>> The former seems intended to provide the server with access to the
> >>> entire GPA space, while the latter indicates an IOVA to GPA mapping o=
f
> >>> those regions.  Doesn't this break the basic isolation of a vIOMMU?
> >>> This essentially says to me "here's all the guest memory, but please
> >>> only access these regions for which we're providing DMA mappings".
> >>> That invites abuse.
> >>>=20
> >>=20
> >> =09The purpose behind separating QEMU into multiple processes is
> >> to provide an additional layer protection for the infrastructure again=
st
> >> a malign guest, not for the guest against itself, so preventing a serv=
er
> >> that has been compromised by a guest from accessing all of guest memor=
y
> >> adds no additional benefit.  We don=E2=80=99t even have an IOMMU in ou=
r current
> >> guest model for this reason.
> >=20
> > One of the use cases we see a lot with vfio is nested assignment, ie.
> > we assign a device to a VM where the VM includes a vIOMMU, such that
> > the guest OS can then assign the device to userspace within the guest.
> > This is safe to do AND provides isolation within the guest exactly
> > because the device only has access to memory mapped to the device, not
> > the entire guest address space.  I don't think it's just the hypervisor
> > you're trying to protect, we can't assume there are always trusted
> > drivers managing the device.
> >=20
>=20
> =09We intend to support an IOMMU.  The question seems to be whether
> it=E2=80=99s implemented in the server or client.  The current proposal h=
as it
> in the server, ala vhost-user, but we are fine with moving it.

It's challenging to implement a fast and secure IOMMU. The simplest
approach is secure but not fast: add protocol messages for
DMA_READ(iova, length) and DMA_WRITE(iova, buffer, length).

An issue with file descriptor passing is that it's hard to revoke access
once the file descriptor has been passed. memfd supports sealing with
fnctl(F_ADD_SEALS) it doesn't revoke mmap(MAP_WRITE) on other processes.

Memory Protection Keys don't seem to be useful here either and their
availability is limited (see pkeys(7)).

One crazy idea is to use KVM as a sandbox for running the device and let
the vIOMMU control the page tables instead of the device (guest). That
way the hardware MMU provides memory translation, but I think this is
impractical because the guest environment is too different from the
Linux userspace environment.

As a starting point adding DMA_READ/DMA_WRITE messages would provide the
functionality and security. Unfortunately it makes DMA expensive and
performance will suffer.

Stefan

--k4f25fnPtRuIRUb3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl7nUjkACgkQnKSrs4Gr
c8iXuwgAj22v7GTE/+fxdunnmikGsDMVTC+M+B60Z05FegrSOtu749Ab281ZONHu
n4U8SnNPshY2t7JvkBF38YwQRVRTH39Zu5avnlV1g96iKx1FGu6XS2RHerHTBOHk
w6/TFaCGwFCC/E2qdOGFkc+eo7jooPYL2HKqGn1P3hBvxMoFjSp2hbrqQjdCtmAP
eXVBrCxqhETdJLs+pU8NUXSaEWy7/9C6gjLTX/LcbfafIetKqcFnBtx9RxUmHU3i
sawv0j9/M9pZUxJpONF4TxRYlvAk5O7ki17nN1li8zmVzB2MufY4Ffn0psVeeZnN
La8Ubu63fM91CqhSlpya4HLTRspqXw==
=R4Dq
-----END PGP SIGNATURE-----

--k4f25fnPtRuIRUb3--


