Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFB31C2D0A8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 09:27:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D6AF21D95
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 09:27:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NS0CTR+T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D6AF21D95
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55160 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMpRH-0006nD-6y
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 05:27:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49140)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kMpQ1-0005t3-Vz
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 05:26:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:20614)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kMpPy-0003lE-JG
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 05:26:01 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601285156;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=WwjuQ4OzpEp83RgsZCdezz+kZjm9Q3x3hpdoLW159kA=;
 b=NS0CTR+T8UoRbJr3g97WXtgd1Wfxt2Ov2CGiphTPF5GkeSfmI4SgL4r9l5tjoJCsJbnray
 qWPbxFwAvvPrDxeNXznQAnoQuWwP9WjHmWS/idCw1mQKQIMQJaG8QaeuYi4g02CKt6wIxa
 ZbotEHiMxgcdlf2agr0OGQrouyThcg8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-534-KQcF4rF0OoCH3r-jFka36w-1; Mon, 28 Sep 2020 05:25:52 -0400
X-MC-Unique: KQcF4rF0OoCH3r-jFka36w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2170164140;
 Mon, 28 Sep 2020 09:25:51 +0000 (UTC)
Received: from localhost (ovpn-114-195.ams2.redhat.com [10.36.114.195])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C95C15D9CA;
 Mon, 28 Sep 2020 09:25:38 +0000 (UTC)
Date: Mon, 28 Sep 2020 10:25:37 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: maxime.coquelin@redhat.com, jasowang@redhat.com, lulu@redhat.com,
 "Michael S. Tsirkin" <mst@redhat.com>, tiwei.bie@intel.com,
 changpeng.liu@intel.com, raphael.norwitz@nutanix.com,
 Felipe Franciosi <felipe@nutanix.com>, marcandre.lureau@redhat.com,
 kraxel@redhat.com, Nikos Dragazis <ndragazis@arrikto.com>,
 Daniele Buono <dbuono@us.ibm.com>
Subject: Outline for VHOST_USER_PROTOCOL_F_VDPA
Message-ID: <20200928092537.GA44353@stefanha-x1.localdomain>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="C7zPtVaVf+AK4Oqc"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 03:47:08
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.576,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,
Thanks for the positive responses to the initial discussion about
introducing VHOST_USER_PROTOCOL_F_VDPA to use vDPA semantics and bring
the full VIRTIO device model to vhost-user:
https://lists.gnu.org/archive/html/qemu-devel/2020-08/msg05181.html

Below is an inlined version of the more detailed explanation I posted on
my blog yesterday[1]. Email is better for discussion.

If anyone wants to tackle this, please reply so others can stay
up-to-date.

Stefan

[1] http://blog.vmsplice.net/2020/09/on-unifying-vhost-user-and-virtio.html
---
The recent development of a Linux driver framework called VIRTIO Data
Path Acceleration (vDPA) has laid the groundwork for exciting new
vhost-user features. The implications of vDPA have not yet rippled
through the community so I want to share my thoughts on how the
vhost-user protocol can take advantage of new ideas from vDPA.

This post is aimed at developers and assumes familiarity with the
vhost-user protocol and VIRTIO. No knowledge of vDPA is required.

vDPA helps with writing drivers for hardware that supports VIRTIO
offload. Its goal is to enable hybrid hardware/software VIRTIO devices,
but as a nice side-effect it has overcome limitations in the kernel
vhost interface. It turns out that applying ideas from vDPA to the
vhost-user protocol solves the same issues there. In this article I'll
show how extending the vhost-user protocol with vDPA has the following
benefits:

* Allows existing VIRTIO device emulation code to act as a vhost-user
  device backend.
* Removes the need for shim devices in the virtual machine monitor (VMM).
* Replaces undocumented conventions with a well-defined device model.

These things can be done while reusing existing vhost-user and VIRTIO
code. In fact, this is especially good news for existing codebases like
QEMU because they already have a wealth of vhost-user and VIRTIO code
that can now finally be connected together!

Let's look at the advantages of extending vhost-user with vDPA first and
then discuss how to do it.

Why extend vhost-user with vDPA?
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
Reusing VIRTIO emulation code for vhost-user backends
-----------------------------------------------------
It is a common misconception that a vhost device is a VIRTIO device.
VIRTIO devices are defined in the VIRTIO specification and consist of a
configuration space, virtqueues, and a device lifecycle that includes
feature negotiation. A vhost device is a subset of the corresponding
VIRTIO device. The exact subset depends on the device type, and some
vhost devices are closer to the full functionality of their
corresponding VIRTIO device than others. The most well-known example is
that vhost-net devices have rx/tx virtqueues and but lack the virtio-net
control virtqueue. Also, the configuration space and device lifecycle
are only partially available to vhost devices.

This difference makes it impossible to use a VIRTIO device as a
vhost-user device and vice versa. There is an impedance mismatch and
missing functionality. That's a shame because existing VIRTIO device
emulation code is mature and duplicating it to provide vhost-user
backends creates additional work.

If there was a way to reuse existing VIRTIO device emulation code it
would be easier to move to a multi-process architecture in QEMU. Want to
run --netdev user,id=3Dnetdev0 --device virtio-net-pci,netdev=3Dnetdev0 in =
a
separate, sandboxed process? Easy, run it as a vhost-user-net device
instead of as virtio-net.

Making VMM device shims optional
--------------------------------
Today each new vhost device type requires a shim device in the VMM. QEMU
has --device vhost-user-blk-pci, --device vhost-user-input-pci, and so
on. Why can't there be a single --device vhost-user device?

This limitation is a consequence of the fact that vhost devices are not
full VIRTIO devices. In fact, a vhost device does not even have a way to
report its device type (net, blk, scsi, etc). Therefore it is impossible
for today's VMMs to offer a generic device. Each vhost device type
requires a shim device.

In some cases a shim device is desirable because it allows the VMM to
handle some aspects of the device instead of passing everything through
to the vhost device backend. But requiring shims by default involves
lots of tedious boilerplate code and prevents new device types from
being used by older VMMs.

Providing a well-defined device model in vhost-user
---------------------------------------------------
Although vhost-user works well for users, it is difficult for developers
to learn and extend. The protocol does not have a well-defined device
model. Each device type has its own undocumented set of protocol
messages that are used. For example, the vhost-user-blk device uses the
configuration space whereas most other device types do not use the
configuration space at all.

Since protocol use is not fully documented in the specification,
developers might resort to reading Linux, QEMU, and DPDK code in order
to figure out how to make their devices work. They typically have to
debug vhost-user protocol messages and adjust their code until it
appears to work. Hopefully the critical bugs are caught before the code
ships. This is problematic because it's hard to produce high-quality
vhost-user implementations.

Although the protocol specification can certainly be cleaned up, the
problem is more fundamental. vhost-user badly needs a well-defined
device model so that protocol usage is clear and uniform for all device
types. The best way to do that is to simply adopt the VIRTIO device
model. The VIRTIO specification already defines the device lifecycle and
details of the device types. By making vhost-user devices full VIRTIO
devices there is no need for additional vhost device specifications. The
vhost-user specification just becomes a transport for the established
VIRTIO device model. Luckily that is effectively what vDPA has done for
kernel vhost ioctls.

How to do this in QEMU
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
The following QEMU changes are needed to implement vhost-user vDPA
support. Below I will focus on vhost-user-net but most of the work is
generic and benefits all device types.
Import vDPA ioctls into vhost-user

vDPA extends the Linux vhost ioctl interface. It uses a subset of vhost
ioctls and adds new vDPA-specific ioctls that are implemented in the
vhost_vdpa.ko kernel module. These new ioctls enable the full VIRTIO
device model, including device IDs, the status register, configuration
space, and so on.

In theory vhost-user could be fixed without vDPA, but it would involve
effectively adding the same set of functionality that vDPA has already
added onto kernel vhost. Reusing the vDPA ioctls allows VMMs to support
both kernel vDPA and vhost-user with minimal code duplication.

This can be done by adding a VHOST_USER_PROTOCOL_F_VDPA feature bit to
the vhost-user protocol. If both the vhost-user frontend and backend
support vDPA then all vDPA messages are available. Otherwise they can
either fall back on legacy vhost-user behavior or drop the connection.

The vhost-user specification could be split into a legacy section and a
modern vDPA-enabled section. The modern protocol will remove vhost-user
messages that are not needed by vDPA, simplifying the protocol for new
developers while allowing existing implementations to support both with
minimal changes.

One detail is that vDPA does not use the memory table mechanism for
sharing memory. Instead it relies on the richer IOMMU message family
that is optional in vhost-user today. This approach can be adopted in
vhost-user too, making the IOMMU code path standard for all
implementations and dropping the memory table mechanism.

Add vhost-user vDPA to the vhost code
-------------------------------------
QEMU's hw/virtio/vhost*.c code supports kernel vhost, vhost-user, and
kernel vDPA. A vhost-user vDPA mode must be added to implement the new
protocol. It can be implemented as a combination of the vhost-user and
kernel vDPA code already in QEMU. Most likely the existing vhost-user
code can simply be extended to enable vDPA support if the backend
supports it.

Only small changes to hw/net/virtio-net.c and net/vhost-user.c are
needed to use vhost-user vDPA with net devices. At that point QEMU can
connect to a vhost-user-net device backend and use vDPA extensions.

Add a vhost-user vDPA VIRTIO transport
--------------------------------------
Next a vhost-user-net device backend can be put together using QEMU's
virtio-net emulation. A translation layer is needed between the
vhost-user protocol and the VirtIODevice type in QEMU. This can be done
by implementing a new VIRTIO transport alongside the existing pci, mmio,
and ccw transports. The transport processes vhost-user protocol messages
from the UNIX domain socket and invokes VIRTIO device emulation code
inside QEMU. It acts as a VIRTIO bus so that virtio-net-device,
virtio-blk-device, and other device types can be plugged in.

This piece is the most involved but the vhost-user protocol
communication part was already implemented in the virtio-vhost-user
prototype that I worked on previously. Most of the communication code
can be reused and the remainder is implementing the VirtioBusClass
interface.

To summarize, a new transport acts as the vhost-user device backend and
invokes QEMU VirtIODevice methods in response to vhost-user protocol
messages. The syntax would be something like --device
virtio-net-device,id=3Dvirtio-net0 --device
vhost-user-backend,device=3Dvirtio-net0,addr.type=3Dunix,addr.path=3D/tmp/v=
host-user-net.sock.

Where this converges with multi-process QEMU
--------------------------------------------
At this point QEMU can run ad-hoc vhost-user backends using existing
VIRTIO device models. It is possible to go further by creating a
qemu-dev launcher executable that implements the vhost-user spec's
"Backend program conventions". This way a minimal device emulator
executable hosts the device instead of a full system emulator.

The requirements for this are similar to the multi-process QEMU effort,
which aims to run QEMU devices as separate processes. One of the main
open questions is how to design build system and Kconfig support for
building minimal device emulator executables.

In the case of vhost-user-net the qemu-dev-vhost-user-net executable
would contain virtio-net-device, vhost-user-backend, any netdevs the
user wishes to include, a QMP monitor, and a vhost-user backend
command-line interface.

Where does this leave us? QEMU's existing VIRTIO device models can be
used as vhost-user devices and run in a separate processes from the VMM.
It's a great way of reusing code and having the flexibility to deploy it
in the way that makes most sense for the intended use case.

Conclusion
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
The vhost-user protocol can be simplified by adopting the vhost vDPA
ioctls that have recently been introduced in Linux. This turns
vhost-user into a VIRTIO transport and vhost-user devices become full
VIRTIO devices. Existing VIRTIO device emulation code can then be reused
in vhost-user device backends.

--C7zPtVaVf+AK4Oqc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl9xrBEACgkQnKSrs4Gr
c8gV/AgAn6EvrmCnBFMAd8UyQzb4b5FYeVD/+kaoh5JnUWMRtj3RGJGZjVrzPu5D
61qcEsqUUlj/EFNB5xBxQkgo9Pm8p5fbv4DBQgpBwRbLl1j+gLQxtXt53qNeKR9G
ijxCDTKRyGgYcg076Z/B0ryhf5tEUw6SemfDxtYLBjYoML0xT+uCgJt+bkDHnMdx
K43GELcUnu0wqpAysPhj5rOWHCbTmiO81jBmURxSbowyuqzoX3DicI342TcmZdZW
yE98+86qFXJvFP8ZWoUf5JrWY2wF6A9ZJA6jYWOl1G3sJA3enIE7/v9iJ2rtiUm6
lXOreKe4oiDWUC4kcjOrugeAbuEIQQ==
=6Bg9
-----END PGP SIGNATURE-----

--C7zPtVaVf+AK4Oqc--


