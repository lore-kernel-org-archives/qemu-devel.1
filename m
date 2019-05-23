Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB9E0C282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 13:34:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A772F20863
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 13:34:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A772F20863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36372 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTnrw-00047S-SQ
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 09:34:52 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34114)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1hTnea-0000Ev-Ks
	for qemu-devel@nongnu.org; Thu, 23 May 2019 09:21:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1hTneZ-0004TO-Ei
	for qemu-devel@nongnu.org; Thu, 23 May 2019 09:21:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40850)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1hTneZ-0004KV-8D
	for qemu-devel@nongnu.org; Thu, 23 May 2019 09:21:03 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8E82B30821BF
	for <qemu-devel@nongnu.org>; Thu, 23 May 2019 13:20:43 +0000 (UTC)
Received: from localhost (ovpn-112-51.ams2.redhat.com [10.36.112.51])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 7C80F5B681;
	Thu, 23 May 2019 13:20:36 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 23 May 2019 15:20:27 +0200
Message-Id: <20190523132035.20559-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.47]);
	Thu, 23 May 2019 13:20:43 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v8 0/8] Add vhost-user-gpu
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

vhost-user allows to drive a virtio device in a seperate
process. After vhost-user-net, we have seen
vhost-user-{scsi,blk,crypto,input} added more recently.

This series, initially proposed ~3 years ago, time flies
(https://lists.gnu.org/archive/html/qemu-devel/2016-06/msg01905.html)
contributes with vhost-user-gpu.

You may start a vhost-user-gpu with virgl rendering in a separate
process like this:

$ ./vhost-user-gpu --virgl -s vgpu.sock &
$ qemu...
  -chardev socket,id=3Dchr,path=3Dvgpu.sock
  -device vhost-user-vga,chardev=3Dchr

v8:
 - document protocol bitmaps format, with pixman format
 - rebased, fixing a few conflicts

v7:
 - add "framed" replies to the vhost-user-gpu protocol
 - use GBM library instead of drm-vendor APIs
 - added "virtio-gpu: add a pixman helper header"

v6:
 - do not install vhost-user-input
 - install vhost-user-gpu and json file following the spec
 - fix the build when drm-intel-devel missing
 - rebase (& resend without already applied patches)

v5:
 - remove user-creatable version of vhost-user-backend
 - remove optinal management of sub-process in vhost-user-backend
 - removed daemonize/pid code
 - drop introduction of new input & gpu messages for PCI config space
   handling, instead use VHOST_USER_PROTOCOL_F_CONFIG
 - plain mem & udmabuf fallback for 2d rendering
 - rebased, kconfig-ify, rst-ify

Marc-Andr=C3=A9 Lureau (8):
  vhost-user: add vhost_user_gpu_set_socket()
  virtio-gpu: add bswap helpers header
  virtio-gpu: add a pixman helper header
  util: compile drm.o on Linux
  contrib: add vhost-user-gpu
  virtio-gpu: split virtio-gpu, introduce virtio-gpu-base
  virtio-gpu: split virtio-gpu-pci & virtio-vga
  hw/display: add vhost-user-vga & gpu-pci

 configure                                  |   17 +
 contrib/libvhost-user/libvhost-user.h      |    1 +
 contrib/vhost-user-gpu/virgl.h             |   25 +
 contrib/vhost-user-gpu/vugbm.h             |   67 ++
 contrib/vhost-user-gpu/vugpu.h             |  177 +++
 hw/display/virtio-vga.h                    |   32 +
 include/hw/virtio/vhost-backend.h          |    2 +
 include/hw/virtio/virtio-gpu-bswap.h       |   61 +
 include/hw/virtio/virtio-gpu-pci.h         |   40 +
 include/hw/virtio/virtio-gpu-pixman.h      |   45 +
 include/hw/virtio/virtio-gpu.h             |   92 +-
 contrib/libvhost-user/libvhost-user.c      |    1 +
 contrib/vhost-user-gpu/main.c              | 1185 ++++++++++++++++++++
 contrib/vhost-user-gpu/virgl.c             |  579 ++++++++++
 contrib/vhost-user-gpu/vugbm.c             |  331 ++++++
 hw/display/vhost-user-gpu-pci.c            |   51 +
 hw/display/vhost-user-gpu.c                |  607 ++++++++++
 hw/display/vhost-user-vga.c                |   52 +
 hw/display/virtio-gpu-3d.c                 |   49 +-
 hw/display/virtio-gpu-base.c               |  268 +++++
 hw/display/virtio-gpu-pci.c                |   55 +-
 hw/display/virtio-gpu.c                    |  444 ++------
 hw/display/virtio-vga.c                    |  138 +--
 hw/virtio/vhost-user.c                     |   11 +
 vl.c                                       |    1 +
 MAINTAINERS                                |   10 +-
 Makefile                                   |   24 +-
 Makefile.objs                              |    1 +
 contrib/vhost-user-gpu/50-qemu-gpu.json.in |    5 +
 contrib/vhost-user-gpu/Makefile.objs       |   10 +
 docs/interop/index.rst                     |    1 +
 docs/interop/vhost-user-gpu.rst            |  242 ++++
 docs/interop/vhost-user.rst                |    9 +
 hw/display/Kconfig                         |   10 +
 hw/display/Makefile.objs                   |    5 +-
 rules.mak                                  |    9 +-
 util/Makefile.objs                         |    2 +-
 37 files changed, 4175 insertions(+), 484 deletions(-)
 create mode 100644 contrib/vhost-user-gpu/virgl.h
 create mode 100644 contrib/vhost-user-gpu/vugbm.h
 create mode 100644 contrib/vhost-user-gpu/vugpu.h
 create mode 100644 hw/display/virtio-vga.h
 create mode 100644 include/hw/virtio/virtio-gpu-bswap.h
 create mode 100644 include/hw/virtio/virtio-gpu-pci.h
 create mode 100644 include/hw/virtio/virtio-gpu-pixman.h
 create mode 100644 contrib/vhost-user-gpu/main.c
 create mode 100644 contrib/vhost-user-gpu/virgl.c
 create mode 100644 contrib/vhost-user-gpu/vugbm.c
 create mode 100644 hw/display/vhost-user-gpu-pci.c
 create mode 100644 hw/display/vhost-user-gpu.c
 create mode 100644 hw/display/vhost-user-vga.c
 create mode 100644 hw/display/virtio-gpu-base.c
 create mode 100644 contrib/vhost-user-gpu/50-qemu-gpu.json.in
 create mode 100644 contrib/vhost-user-gpu/Makefile.objs
 create mode 100644 docs/interop/vhost-user-gpu.rst

--=20
2.22.0.rc1.1.g079e7d2849.dirty


