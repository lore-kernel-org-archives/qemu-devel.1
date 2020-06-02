Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF611C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 15:07:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAF65206C3
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 15:07:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PryTijPs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAF65206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42004 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jg8Vp-0005yT-TH
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 11:07:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47704)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1jg8V2-0005Nu-0g
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 11:06:44 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:34166
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1jg8Uz-00044W-RE
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 11:06:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591110400;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=698ATy35VrOA5mkqDF8F3ahK4Iv3lldZWoHR9tJl/QA=;
 b=PryTijPsDeuyHl4gxQmN+kMnJvWqFYBBb2VXkOKhfV6weWjKdPNnHnRmbw+MhFrTlteLcd
 AhpZi9ll1tuNOwKpkOpQVdlavTRiaz0pERuI92FL/rt0m9bK8Rf//iYPVDYI1VsxD3xcdA
 0N5ENuPHBQqZaOkQldzpa7ZENEivXY8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-132-jVYz5yIxNEyt1wyTSCbEqQ-1; Tue, 02 Jun 2020 11:06:38 -0400
X-MC-Unique: jVYz5yIxNEyt1wyTSCbEqQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5B851461;
 Tue,  2 Jun 2020 15:06:36 +0000 (UTC)
Received: from x1.home (ovpn-112-195.phx2.redhat.com [10.3.112.195])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CD8B95C220;
 Tue,  2 Jun 2020 15:06:29 +0000 (UTC)
Date: Tue, 2 Jun 2020 09:06:29 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: John G Johnson <john.g.johnson@oracle.com>
Subject: Re: RFC: use VFIO over a UNIX domain socket to implement device
 offloading
Message-ID: <20200602090629.66f9e3f7@x1.home>
In-Reply-To: <A0E4C51F-B41C-486B-A5CE-3C4C2C9C1A40@oracle.com>
References: <MN2PR02MB62052E54C752229C115EAD898BCF0@MN2PR02MB6205.namprd02.prod.outlook.com>
 <20200401091712.GA221892@stefanha-x1.localdomain>
 <MW2PR02MB372349E25A0842DE045B95F58BD40@MW2PR02MB3723.namprd02.prod.outlook.com>
 <8101D131-3B95-4CF5-8D46-8755593AA97D@oracle.com>
 <A0E4C51F-B41C-486B-A5CE-3C4C2C9C1A40@oracle.com>
Organization: Red Hat
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61;
 envelope-from=alex.williamson@redhat.com; helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/02 03:23:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
 Felipe Franciosi <felipe@nutanix.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Kirti Wankhede <kwankhede@nvidia.com>,
 Kanth Ghatraju <Kanth.Ghatraju@oracle.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>, "Zhang,
 Tina" <tina.zhang@intel.com>, "Liu, Changpeng" <changpeng.liu@intel.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 20 May 2020 17:45:13 -0700
John G Johnson <john.g.johnson@oracle.com> wrote:

> > I'm confused by VFIO_USER_ADD_MEMORY_REGION vs VFIO_USER_IOMMU_MAP_DMA.
> > The former seems intended to provide the server with access to the
> > entire GPA space, while the latter indicates an IOVA to GPA mapping of
> > those regions.  Doesn't this break the basic isolation of a vIOMMU?
> > This essentially says to me "here's all the guest memory, but please
> > only access these regions for which we're providing DMA mappings".
> > That invites abuse.
> >  =20
>=20
> =09The purpose behind separating QEMU into multiple processes is
> to provide an additional layer protection for the infrastructure against
> a malign guest, not for the guest against itself, so preventing a server
> that has been compromised by a guest from accessing all of guest memory
> adds no additional benefit.  We don=E2=80=99t even have an IOMMU in our c=
urrent
> guest model for this reason.

One of the use cases we see a lot with vfio is nested assignment, ie.
we assign a device to a VM where the VM includes a vIOMMU, such that
the guest OS can then assign the device to userspace within the guest.
This is safe to do AND provides isolation within the guest exactly
because the device only has access to memory mapped to the device, not
the entire guest address space.  I don't think it's just the hypervisor
you're trying to protect, we can't assume there are always trusted
drivers managing the device.

>=20
> =09The implementation was stolen from vhost-user, with the exception
> that we push IOTLB translations from client to server like VFIO does, as
> opposed to pulling them from server to client like vhost-user does.

It seems that vhost has numerous hacks forcing it to know whether a
vIOMMU is present as a result of this, vfio has none.
=20
> =09That said, neither the qemu-mp nor MUSER implementation uses an
> IOMMU, so if you prefer another IOMMU model, we can consider it.  We
> could only send the guest memory file descriptors with IOMMU_MAP_DMA
> requests, although that would cost performance since each request would
> require the server to execute an mmap() system call.

It would seem shortsighted to not fully enable a vIOMMU compatible
implementation at this time.

> > Also regarding VFIO_USER_ADD_MEMORY_REGION, it's not clear to me how
> > "an array of file descriptors will be sent as part of the message
> > meta-data" works.  Also consider s/SUB/DEL/.  Why is the Device ID in
> > the table specified as 0?  How does a client learn their Device ID?
> >  =20
>=20
> =09SCM_RIGHTS message controls allow sendmsg() to send an array of
> file descriptors over a UNIX domain socket.
>=20
> =09We=E2=80=99re only supporting one device per socket in this protocol
> version, so the device ID will always be 0.  This may change in a future
> revision, so we included the field in the header to avoid a major version
> change if device multiplexing is added later.
>=20
>=20
> > VFIO_USER_DEVICE_GET_REGION_INFO (or anything else making use of a
> > capability chain), the cap_offset and next pointers within the chain
> > need to specify what their offset is relative to (ie. the start of the
> > packet, the start of the vfio compatible data structure, etc).  I
> > assume the latter for client compatibility.
> >  =20
>=20
> =09Yes.  We will attempt to make the language clearer.
>=20
>=20
> > Also on REGION_INFO, offset is specified as "the base offset to be
> > given to the mmap() call for regions with the MMAP attribute".  Base
> > offset from what?  Is the mmap performed on the socket fd?  Do we not
> > allow read/write, we need to use VFIO_USER_MMIO_READ/WRITE instead?
> > Why do we specify "MMIO" in those operations versus simply "REGION"?
> > Are we arbitrarily excluding support for I/O port regions or device
> > specific regions?  If these commands replace direct read and write to
> > an fd offset, how is PCI config space handled?
> >  =20
>=20
> =09The base offset refers to the sparse areas, where the sparse area
> offset is added to the base region offset.  We will try to make the text
> clearer here as well.
>=20
> =09MMIO was added to distinguish these operations from DMA operations.
> I can see how this can cause confusion when the region refers to a port r=
ange,
> so we can change the name to REGION_READ/WRITE.=20
>=20
>=20
> > VFIO_USER_MMIO_READ specifies the count field is zero and the reply
> > will include the count specifying the amount of data read.  How does
> > the client specify how much data to read?  Via message size?
> >  =20
>=20
> =09This is a bug in the doc.  As you said, the read field should
> be the amount of data to be read.
> =09
>=20
> > VFIO_USER_DMA_READ/WRITE, is the address a GPA or IOVA?  IMO the device
> > should only ever have access via IOVA, which implies a DMA mapping
> > exists for the device.  Can you provide an example of why we need these
> > commands since there seems little point to this interface if a device
> > cannot directly interact with VM memory.
> >  =20
>=20
> =09It is a GPA.  The device emulation code would only handle the DMA
> addresses the guest programmed it with; the server infrastructure knows
> whether an IOMMU exists, and whether the DMA address needs translation to
> GPA or not.

I'll re-iterate, a device should only ever issue DMAs in terms of IOVA.
This is how vfio works.

> > The IOMMU commands should be unnecessary, a vIOMMU should be
> > transparent to the server by virtue that the device only knows about
> > IOVA mappings accessible to the device.  Requiring the client to expose
> > all memory to the server implies that the server must always be trusted=
.
> >  =20
>=20
> =09The client and server are equally trusted; the guest is the untrusted
> entity.

And therefore the driver is untrusted and opening the client/sever
window to expose all of guest memory presents a larger attack surface.

> > Interrupt info format, s/type/index/, s/vector/subindex/
> >  =20
>=20
> =09ok
>=20
>=20
> > In addition to the unused ioctls, the entire concept of groups and
> > containers are not found in this specification.  To some degree that
> > makes sense and even mdevs and typically SR-IOV VFs have a 1:1 device
> > to group relationship.  However, the container is very much involved in
> > the development of migration support, where it's the container that
> > provides dirty bitmaps.  Since we're doing map and unmap without that
> > container concept here, perhaps we'd equally apply those APIs to this
> > same socket.  Thanks, =20
>=20
> =09Groups and containers are host IOMMU concepts, and we don=E2=80=99t
> interact with the host here.  The kernel VFIO driver doesn=E2=80=99t even=
 need
> to exist for VFIO over socket.  I think it=E2=80=99s fine to assume a 1-1
> correspondence between containers, groups, and a VFIO over socket device.

Obviously the kernel driver and host IOMMU are out of the picture here.
The point I was trying to make is that we're building interfaces to
support migration around concepts that don't exist in this model, so
it's not clear how we'd map, for example, dirty page tracking on the
container interface to this API.  This seems more akin to the no-iommu
model of vfio, which is a hack where we allow userspace to have access
to a device using the vfio API, but they're on their own for DMA.  We
don't support that model in QEMU, and without those conceptual
equivalencies, I wonder how much we'll be able to leverage existing
QEMU code or co-develop and support future features.  IOW, is this
really just "a vfio-like device model over unix socket" rather than
"vfio over unix socket"?  Thanks,

Alex


