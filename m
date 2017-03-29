Received: from eggs.gnu.org ([2001:4830:134:3::10]:57531)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ctCuA-0007hv-Cq
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 08:40:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ctCu6-0001BG-57
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 08:40:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39288)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1ctCu5-0001B5-SV
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 08:40:46 -0400
Date: Wed, 29 Mar 2017 15:40:35 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170329124035.GC21803@redhat.com>
References: <1488472983-9108-1-git-send-email-felipe@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1488472983-9108-1-git-send-email-felipe@nutanix.com>
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
To: Felipe Franciosi <felipe@nutanix.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Marc-Andre Lureau <marcandre.lureau@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, yuanhan.liu@linux.intel.com, Jason Wang <jasowang@redhat.com>

On Thu, Mar 02, 2017 at 08:43:00AM -0800, Felipe Franciosi wrote:
> Based on various discussions on the 2016 KVM Forum, I'm sending over a
> vhost-user-scsi implementation for your consideration.
> 
> This patchset introduces a new vhost-user SCSI device. While heavily
> based on vhost-scsi, it is implemented using vhost's userspace
> counterpart. The device has been coded and tested to work with live
> migration.
> 
> As part of this work, a new vhost-scsi-common device was created and
> the existing vhost-scsi device moved underneath it. The new
> vhost-user-scsi device is also placed underneath it.
> 
> A sample application based on the newly introduced libvhost-user is
> also included. It makes use of libiscsi for simplicity.
> 
> For convenience, I'm maintaining an up-to-date version of these
> patches (including some necessary fixes for libvhost-user) on:
> 
> https://github.com/franciozzy/qemu/tree/vus-upstream-v4
> 
> See the individual patches for build and use instructions.
> 
> Signed-off-by: Felipe Franciosi <felipe@nutanix.com>

Cc Yuanhan who was interested in this topic.

> v3 -> v4:
> - Drop configure switches and build vus by default.
> - Add sample application to .gitignore.
> - Removed a whitespace error.
> - Rebase on master.
> 
> v2 -> v3:
> - Rebase after vhost notifier fixes by Paolo.
> - Exposed F_HOTPLUG and F_CHANGE on vhost-user-scsi.
> 
> v1 -> v2:
> - Introduce new vhost-scsi-common device type.
> - Move vhost-scsi device underneath vhost-scsi-common.
> - Move sample application from tests/ to contrib/.
> - Make sample application use the glib event loop.
> - Minor fixes.
> 
> Felipe Franciosi (3):
>   vhost-scsi: create a vhost-scsi-common abstraction
>   vus: Introduce vhost-user-scsi host device
>   vus: Introduce a vhost-user-scsi sample application
> 
>  .gitignore                                |   1 +
>  Makefile                                  |   3 +
>  Makefile.objs                             |   4 +
>  configure                                 |   1 +
>  contrib/vhost-user-scsi/Makefile.objs     |   1 +
>  contrib/vhost-user-scsi/vhost-user-scsi.c | 886 ++++++++++++++++++++++++++++++
>  default-configs/pci.mak                   |   1 +
>  hw/scsi/Makefile.objs                     |   3 +-
>  hw/scsi/vhost-scsi-common.c               | 143 +++++
>  hw/scsi/vhost-scsi.c                      | 194 ++-----
>  hw/scsi/vhost-user-scsi.c                 | 215 ++++++++
>  hw/virtio/virtio-pci.c                    |  54 ++
>  hw/virtio/virtio-pci.h                    |  11 +
>  include/hw/virtio/vhost-scsi-common.h     |  48 ++
>  include/hw/virtio/vhost-scsi.h            |  11 +-
>  include/hw/virtio/vhost-user-scsi.h       |  35 ++
>  include/hw/virtio/virtio-scsi.h           |   5 +
>  17 files changed, 1468 insertions(+), 148 deletions(-)
>  create mode 100644 contrib/vhost-user-scsi/Makefile.objs
>  create mode 100644 contrib/vhost-user-scsi/vhost-user-scsi.c
>  create mode 100644 hw/scsi/vhost-scsi-common.c
>  create mode 100644 hw/scsi/vhost-user-scsi.c
>  create mode 100644 include/hw/virtio/vhost-scsi-common.h
>  create mode 100644 include/hw/virtio/vhost-user-scsi.h
> 
> -- 
> 1.9.4
