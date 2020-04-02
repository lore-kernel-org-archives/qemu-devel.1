Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04F31C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 10:20:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBB9F206F8
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 10:20:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FHhPbbq6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBB9F206F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36438 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJwxm-0008Qg-Rr
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 06:20:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36964)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1jJwx3-00081B-EJ
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 06:19:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1jJwx1-0007pq-Ez
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 06:19:56 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:44695
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1jJwx1-0007pK-8I
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 06:19:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585822794;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2pk3cqeH/CBB4KbuZIr9+0E6SBnjhx32aYNvUxwYYCM=;
 b=FHhPbbq6D6m7iGAxqggKNV0PA+2jrbKBG3i42br4nHegpgVu5Dk2V6OLTTtFgAlwvyUEpF
 FzqGpAYsr6bVQzvem9UcWWysAuzFjJRfQzPgFmfBOsod17XgxaK86lYzX4nfimsGzq3DdV
 Jot3Js9THipVj9LAuIF7i+W1PjYge8M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-160-oBDWE0o5M5CCiNRbJ0F65w-1; Thu, 02 Apr 2020 06:19:50 -0400
X-MC-Unique: oBDWE0o5M5CCiNRbJ0F65w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DEDA610CE798;
 Thu,  2 Apr 2020 10:19:47 +0000 (UTC)
Received: from localhost (ovpn-113-134.ams2.redhat.com [10.36.113.134])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 07BAB5DA76;
 Thu,  2 Apr 2020 10:19:43 +0000 (UTC)
Date: Thu, 2 Apr 2020 11:19:42 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>
Subject: Re: RFC: use VFIO over a UNIX domain socket to implement device
 offloading
Message-ID: <20200402101942.GF28280@stefanha-x1.localdomain>
References: <MN2PR02MB62052E54C752229C115EAD898BCF0@MN2PR02MB6205.namprd02.prod.outlook.com>
 <20200401091712.GA221892@stefanha-x1.localdomain>
 <MN2PR02MB620500A5010B71F1C0D8695E8BC90@MN2PR02MB6205.namprd02.prod.outlook.com>
 <CAJ+F1CLU4kPK1Tw3X7oTAWtUp0Q4Q=wm3-Uj-_2JO09vq0paBg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CLU4kPK1Tw3X7oTAWtUp0Q4Q=wm3-Uj-_2JO09vq0paBg@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="JSkcQAAxhB1h8DcT"
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
Cc: "Walker, Benjamin" <benjamin.walker@intel.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>, Jag Raman <jag.raman@oracle.com>,
 Swapnil Ingle <swapnil.ingle@nutanix.com>, "Harris,
 James R" <james.r.harris@intel.com>,
 "john.g.johnson@oracle.com" <john.g.johnson@oracle.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Kirti Wankhede <kwankhede@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Felipe Franciosi <felipe@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>, "Liu,
 Changpeng" <changpeng.liu@intel.com>, "Zhang, Tina" <tina.zhang@intel.com>,
 Kanth Ghatraju <Kanth.Ghatraju@oracle.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--JSkcQAAxhB1h8DcT
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 01, 2020 at 06:58:20PM +0200, Marc-Andr=E9 Lureau wrote:
> On Wed, Apr 1, 2020 at 5:51 PM Thanos Makatos
> <thanos.makatos@nutanix.com> wrote:
> > > On Thu, Mar 26, 2020 at 09:47:38AM +0000, Thanos Makatos wrote:
> > > > Build MUSER with vfio-over-socket:
> > > >
> > > >         git clone --single-branch --branch vfio-over-socket
> > > git@github.com:tmakatos/muser.git
> > > >         cd muser/
> > > >         git submodule update --init
> > > >         make
> > > >
> > > > Run device emulation, e.g.
> > > >
> > > >         ./build/dbg/samples/gpio-pci-idio-16 -s <N>
> > > >
> > > > Where <N> is an available IOMMU group, essentially the device ID, w=
hich
> > > must not
> > > > previously exist in /dev/vfio/.
> > > >
> > > > Run QEMU using the vfio wrapper library and specifying the MUSER de=
vice:
> > > >
> > > >         LD_PRELOAD=3Dmuser/build/dbg/libvfio/libvfio.so qemu-system=
-x86_64
> > > \
> > > >                 ... \
> > > >                 -device vfio-pci,sysfsdev=3D/dev/vfio/<N> \
> > > >                 -object memory-backend-file,id=3Dram-node0,prealloc=
=3Dyes,mem-
> > > path=3Dmem,share=3Dyes,size=3D1073741824 \
> > > >                 -numa node,nodeid=3D0,cpus=3D0,memdev=3Dram-node0
> > > >
>=20
> fyi, with 5.0 you no longer need -numa!:
>=20
> -object memory-backend-memfd,id=3Dmem,size=3D2G -M memory-backend=3Dmem
>=20
> (hopefully, we will get something even simpler one day)
>=20
> > > > Bear in mind that since this is just a PoC lots of things can break=
, e.g. some
> > > > system call not intercepted etc.
> > >
> > > Cool, I had a quick look at libvfio and how the transport integrates
> > > into libmuser.  The integration on the libmuser side is nice and smal=
l.
> > >
> > > It seems likely that there will be several different implementations =
of
> > > the vfio-over-socket device side (server):
> > > 1. libmuser
> > > 2. A Rust equivalent to libmuser
> > > 3. Maybe a native QEMU implementation for multi-process QEMU (I think=
 JJ
> > >    has been investigating this?)
> > >
> > > In order to interoperate we'll need to maintain a protocol
> > > specification.  Mayb You and JJ could put that together and CC the vf=
io,
> > > rust-vmm, and QEMU communities for discussion?
> >
> > Sure, I can start by drafting a design doc and share it.
>=20
> ok! I am quite amazed you went this far with a ldpreload hack. This
> demonstrates some limits of gpl projects, if it was necessary.
>=20
> I think with this work, and the muser experience, you have a pretty
> good idea of what the protocol could look like. My approach, as I
> remember, was a quite straightforward VFIO over socket translation,
> while trying to see if it could share some aspects with vhost-user,
> such as memory handling etc.
>=20
> To contrast with the work done on qemu-mp series, I'd also prefer we
> focus our work on a vfio-like protocol, before trying to see how qemu
> code and interface could be changed over multiple binaries etc. We
> will start with some limitations, similar to the one that apply to
> VFIO: migration, introspection, managements etc are mostly left out
> for now. (iow, qemu-mp is trying to do too many things simultaneously)

qemu-mp has been cut down significantly in order to make it
non-invasive.  The model is now much cleaner:
1. No monitor command or command-line option forwarding.  The device
   emulation program has its own command-line and monitor that QEMU
   doesn't know about.
2. No per-device proxy objects.  A single RemotePCIDevice is added to
   QEMU.  In the current patch series it only supports the LSI SCSI
   controller but once the socket protocol is changed to
   vfio-over-socket it will be possible to use any PCI device.

We recently agreed on dropping live migration to further reduce the
patch series.  If you have specific suggestions, please post reviews on
the latest patch series.

The RemotePCIDevice and device emulation program infrastructure it puts
in place are intended to be used by vfio-over-socket in the future.  I
see it as complementary to vfio-over-socket rather than as a
replacement.  Elena, Jag, and JJ have been working on it for a long time
and I think we should build on top of it (replacing parts as needed)
rather than propose a new plan that sidelines their work.

> That's the rough ideas/plan I have in mind:
> - draft/define a "vfio over unix" protocol
> - similar to vhost-user, also define some backend conventions
> https://github.com/qemu/qemu/blob/master/docs/interop/vhost-user.rst#back=
end-program-conventions
> - modify qemu vfio code to allow using a socket backend. Ie something
> like "-chardev socket=3Dfoo -device vfio-pci,chardev=3Dfoo"

I think JJ has been working on this already.  Not sure what the status
is.

> - implement some test devices (and outside qemu, in whatever
> language/framework - the more the merrier!)
> - investigate how existing qemu binary could expose some devices over
> "vfio-unix", for ex: "qemu -machine none -chardev socket=3Dfoo,server
> -device pci-serial,vfio=3Dfoo". This would avoid a lot of proxy and code
> churn proposed in qemu-mp.

This is similar to the qemu-mp approach.  I think they found that doing
this in practice requires a RemotePCIBus and a
RemoteInterruptController.  Something along these lines:

  qemu -machine none \
       -chardev socket=3Dfoo,server \
       -device remote-pci-bus,chardev=3Dfoo \
       -device pci-serial # added to the remote-pci-bus

PCI devices you want to instantiate are completely unmodified - no need
to even add a vfio=3D parameter.  They just happen to be on a RemotePCIBus
instead of a regular PCI bus.  That way they can be accessed via
vfio-over-socket and interrupts are also handled remotely.

Stefan

--JSkcQAAxhB1h8DcT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl6FvD4ACgkQnKSrs4Gr
c8iFrAf/Rxobho7vZZ9wPrlczTyoUnLrnCt0157Pw9+p2BL+09b/NKHrLt8zEJu2
9aDwXtzuPLJe/DeuQkr9fwmylBjC1b9tuazKOEwE6fA8kIe6uWhec2IOKQqNCxy9
Bd+tcoCoHCW0t25GDh6EnwUMuu10XVlkEc36LKr7DZagLtb2SEa7dAS7P8Yb4Bb5
KIiCZlQRN5rUnrtVDJvg33gWHQUWXM9ipczOAZsBxsTJx3QCDuTcTd2Fogh+rAbE
RnU3sjMrxAnvXUKF+n8JcY8X1EPtcowNoEpqX9f7tgwyD8BhaH4zotWpQgq7b6vF
U4qcThFq6hSHK1QnAjEKBCtOpW4HRQ==
=17JM
-----END PGP SIGNATURE-----

--JSkcQAAxhB1h8DcT--


