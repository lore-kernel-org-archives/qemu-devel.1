Received: from eggs.gnu.org ([2001:4830:134:3::10]:39178)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <felipe@nutanix.com>) id 1ctLra-0003zo-Pm
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 18:14:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <felipe@nutanix.com>) id 1ctLrX-0001sU-Lt
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 18:14:46 -0400
Received: from mail-sn1nam01on0106.outbound.protection.outlook.com
	([104.47.32.106]:13280
	helo=NAM01-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <felipe@nutanix.com>) id 1ctLrX-0001pW-3O
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 18:14:43 -0400
From: Felipe Franciosi <felipe@nutanix.com>
Date: Wed, 29 Mar 2017 22:14:37 +0000
Message-ID: <04DA7E29-9321-40AF-A313-EF6D374BD670@nutanix.com>
References: <1488472983-9108-1-git-send-email-felipe@nutanix.com>
	<20170329124035.GC21803@redhat.com>
In-Reply-To: <20170329124035.GC21803@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0422F016D4E14D41AFAB24DEFB2383DC@namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v4 0/3] Introduce vhost-user-scsi and
 sample application
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Marc-Andre Lureau <marcandre.lureau@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "yuanhan.liu@linux.intel.com" <yuanhan.liu@linux.intel.com>, Jason Wang <jasowang@redhat.com>


> On 29 Mar 2017, at 13:40, Michael S. Tsirkin <mst@redhat.com> wrote:
>=20
> On Thu, Mar 02, 2017 at 08:43:00AM -0800, Felipe Franciosi wrote:
>> Based on various discussions on the 2016 KVM Forum, I'm sending over a
>> vhost-user-scsi implementation for your consideration.
>>=20
>> This patchset introduces a new vhost-user SCSI device. While heavily
>> based on vhost-scsi, it is implemented using vhost's userspace
>> counterpart. The device has been coded and tested to work with live
>> migration.
>>=20
>> As part of this work, a new vhost-scsi-common device was created and
>> the existing vhost-scsi device moved underneath it. The new
>> vhost-user-scsi device is also placed underneath it.
>>=20
>> A sample application based on the newly introduced libvhost-user is
>> also included. It makes use of libiscsi for simplicity.
>>=20
>> For convenience, I'm maintaining an up-to-date version of these
>> patches (including some necessary fixes for libvhost-user) on:
>>=20
>> https://github.com/franciozzy/qemu/tree/vus-upstream-v4
>>=20
>> See the individual patches for build and use instructions.
>>=20
>> Signed-off-by: Felipe Franciosi <felipe@nutanix.com>
>=20
> Cc Yuanhan who was interested in this topic.

Thanks for looping this in, mst.

The latest is v5 which has a libvhost-user fix for the build:
http://lists.nongnu.org/archive/html/qemu-devel/2017-03/msg00417.html

F.

>=20
>> v3 -> v4:
>> - Drop configure switches and build vus by default.
>> - Add sample application to .gitignore.
>> - Removed a whitespace error.
>> - Rebase on master.
>>=20
>> v2 -> v3:
>> - Rebase after vhost notifier fixes by Paolo.
>> - Exposed F_HOTPLUG and F_CHANGE on vhost-user-scsi.
>>=20
>> v1 -> v2:
>> - Introduce new vhost-scsi-common device type.
>> - Move vhost-scsi device underneath vhost-scsi-common.
>> - Move sample application from tests/ to contrib/.
>> - Make sample application use the glib event loop.
>> - Minor fixes.
>>=20
>> Felipe Franciosi (3):
>>  vhost-scsi: create a vhost-scsi-common abstraction
>>  vus: Introduce vhost-user-scsi host device
>>  vus: Introduce a vhost-user-scsi sample application
>>=20
>> .gitignore                                |   1 +
>> Makefile                                  |   3 +
>> Makefile.objs                             |   4 +
>> configure                                 |   1 +
>> contrib/vhost-user-scsi/Makefile.objs     |   1 +
>> contrib/vhost-user-scsi/vhost-user-scsi.c | 886 ++++++++++++++++++++++++=
++++++
>> default-configs/pci.mak                   |   1 +
>> hw/scsi/Makefile.objs                     |   3 +-
>> hw/scsi/vhost-scsi-common.c               | 143 +++++
>> hw/scsi/vhost-scsi.c                      | 194 ++-----
>> hw/scsi/vhost-user-scsi.c                 | 215 ++++++++
>> hw/virtio/virtio-pci.c                    |  54 ++
>> hw/virtio/virtio-pci.h                    |  11 +
>> include/hw/virtio/vhost-scsi-common.h     |  48 ++
>> include/hw/virtio/vhost-scsi.h            |  11 +-
>> include/hw/virtio/vhost-user-scsi.h       |  35 ++
>> include/hw/virtio/virtio-scsi.h           |   5 +
>> 17 files changed, 1468 insertions(+), 148 deletions(-)
>> create mode 100644 contrib/vhost-user-scsi/Makefile.objs
>> create mode 100644 contrib/vhost-user-scsi/vhost-user-scsi.c
>> create mode 100644 hw/scsi/vhost-scsi-common.c
>> create mode 100644 hw/scsi/vhost-user-scsi.c
>> create mode 100644 include/hw/virtio/vhost-scsi-common.h
>> create mode 100644 include/hw/virtio/vhost-user-scsi.h
>>=20
>> --=20
>> 1.9.4
