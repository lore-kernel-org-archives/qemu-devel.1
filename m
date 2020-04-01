Return-Path: <SRS0=uFRu=5R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3219CC43331
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 09:18:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E47A620784
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 09:18:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ie4YLohr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E47A620784
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56738 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJZWC-0006iF-4F
	for qemu-devel@archiver.kernel.org; Wed, 01 Apr 2020 05:18:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54762)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1jJZV4-0006E1-Tg
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 05:17:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1jJZV3-0006HR-12
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 05:17:30 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32569
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1jJZV2-0006Fc-Qs
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 05:17:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585732647;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MbitAU16/e4WUpcuLx8UZVBb0xJZjcws0JbUk4zrVEQ=;
 b=ie4YLohrMLgQ0jJCApVnx0U1wxmL7Ca0ifh7XaRGw45pgJdiaVvBEFX5wyLiXmyMFmFBhO
 xJhOa4o6tJlFKDPq7+Jf5UFWtr7ZsaQckYoi1NL8VxqVueRfSCsRvns/e1rX0hlnkq79/n
 POruaXXqK4Dn8A4LHR3qHFALviZvWZM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-381-7lkfZ3NbPY2WSwgcdOQkyg-1; Wed, 01 Apr 2020 05:17:24 -0400
X-MC-Unique: 7lkfZ3NbPY2WSwgcdOQkyg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AD0F5100550D;
 Wed,  1 Apr 2020 09:17:22 +0000 (UTC)
Received: from localhost (ovpn-114-230.ams2.redhat.com [10.36.114.230])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 991591001B07;
 Wed,  1 Apr 2020 09:17:13 +0000 (UTC)
Date: Wed, 1 Apr 2020 10:17:12 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Thanos Makatos <thanos.makatos@nutanix.com>
Subject: Re: RFC: use VFIO over a UNIX domain socket to implement device
 offloading
Message-ID: <20200401091712.GA221892@stefanha-x1.localdomain>
References: <MN2PR02MB62052E54C752229C115EAD898BCF0@MN2PR02MB6205.namprd02.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <MN2PR02MB62052E54C752229C115EAD898BCF0@MN2PR02MB6205.namprd02.prod.outlook.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="3V7upXqbjpZ4EhLz"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
 Elena Ufimtseva <elena.ufimtseva@oracle.com>, john.g.johnson@oracle.com,
 Jag Raman <jag.raman@oracle.com>, "Harris, James R" <james.r.harris@intel.com>,
 Swapnil Ingle <swapnil.ingle@nutanix.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Kirti Wankhede <kwankhede@nvidia.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Kanth Ghatraju <Kanth.Ghatraju@oracle.com>,
 Felipe Franciosi <felipe@nutanix.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, "Zhang,
 Tina" <tina.zhang@intel.com>, "Liu, Changpeng" <changpeng.liu@intel.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 26, 2020 at 09:47:38AM +0000, Thanos Makatos wrote:
> Build MUSER with vfio-over-socket:
>=20
>         git clone --single-branch --branch vfio-over-socket git@github.co=
m:tmakatos/muser.git
>         cd muser/
>         git submodule update --init
>         make
>=20
> Run device emulation, e.g.
>=20
>         ./build/dbg/samples/gpio-pci-idio-16 -s <N>
>=20
> Where <N> is an available IOMMU group, essentially the device ID, which m=
ust not
> previously exist in /dev/vfio/.
>=20
> Run QEMU using the vfio wrapper library and specifying the MUSER device:
>=20
>         LD_PRELOAD=3Dmuser/build/dbg/libvfio/libvfio.so qemu-system-x86_6=
4 \
>                 ... \
>                 -device vfio-pci,sysfsdev=3D/dev/vfio/<N> \
>                 -object memory-backend-file,id=3Dram-node0,prealloc=3Dyes=
,mem-path=3Dmem,share=3Dyes,size=3D1073741824 \
>                 -numa node,nodeid=3D0,cpus=3D0,memdev=3Dram-node0
>=20
> Bear in mind that since this is just a PoC lots of things can break, e.g.=
 some
> system call not intercepted etc.

Cool, I had a quick look at libvfio and how the transport integrates
into libmuser.  The integration on the libmuser side is nice and small.

It seems likely that there will be several different implementations of
the vfio-over-socket device side (server):
1. libmuser
2. A Rust equivalent to libmuser
3. Maybe a native QEMU implementation for multi-process QEMU (I think JJ
   has been investigating this?)

In order to interoperate we'll need to maintain a protocol
specification.  Mayb You and JJ could put that together and CC the vfio,
rust-vmm, and QEMU communities for discussion?

It should cover the UNIX domain socket connection semantics (does a
listen socket only accept 1 connection at a time?  What happens when the
client disconnects?  What happens when the server disconnects?), how
VFIO structs are exchanged, any vfio-over-socket specific protocol
messages, etc.  Basically everything needed to write an implementation
(although it's not necessary to copy the VFIO struct definitions from
the kernel headers into the spec or even document their semantics if
they are identical to kernel VFIO).

The next step beyond the LD_PRELOAD library is a native vfio-over-socket
client implementation in QEMU.  There is a prototype here:
https://github.com/elmarco/qemu/blob/wip/vfio-user/hw/vfio/libvfio-user.c

If there are any volunteers for working on that then this would be a
good time to discuss it.

Finally, has anyone looked at CrosVM's out-of-process device model?  I
wonder if it has any features we should consider...

Looks like a great start to vfio-over-socket!

Stefan

--3V7upXqbjpZ4EhLz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl6EXBgACgkQnKSrs4Gr
c8hs6gf+N20c7mjNKJWMsG8wa+DiExCWtvp0CS1kzbjLyRViH0CvCw7+mXE5py4r
TP/tpK3SH8isMw1h/PPRmxsxEjhNhQlzArAAwnn4XV+bgzooBx4iI3R6y14EFJGX
fL66EYM1L1ACCyo/vzEpE9sZ5pO2fL/9jwsar1D68B/r3IeqeimOM9jBjp81s+Vh
lA2Bpwt8oOj6lx8gbBfJ+ycMFrB/6gn2Bwp4jJ3/GePgW7ms6zwfQC7a7pF6jj+w
+IS6/li15RGVMxXU/1U/ILK06d06SU7o8FVOTQGV8EKR2YOzJQgvD0Uv8mJ4fC+8
BcwguP1MNl1ZbBYz/txFcwXKQ8SQjQ==
=txJN
-----END PGP SIGNATURE-----

--3V7upXqbjpZ4EhLz--


