Received: from eggs.gnu.org ([2001:4830:134:3::10]:48518)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hare@suse.de>) id 1cTm2O-0005jQ-Vo
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 03:56:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hare@suse.de>) id 1cTm2N-00028I-Qo
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 03:56:13 -0500
Received: from mx2.suse.de ([195.135.220.15]:48480)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <hare@suse.de>) id 1cTm2N-00027e-Hg
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 03:56:11 -0500
References: <1484633936-25344-1-git-send-email-caoj.fnst@cn.fujitsu.com>
	<1484633936-25344-4-git-send-email-caoj.fnst@cn.fujitsu.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <b0d116b8-e8fc-72d9-2638-f5f5e18c2ceb@suse.de>
Date: Wed, 18 Jan 2017 09:56:08 +0100
MIME-Version: 1.0
In-Reply-To: <1484633936-25344-4-git-send-email-caoj.fnst@cn.fujitsu.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v9 03/11] pci: Convert msix_init() to Error
 and fix callers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cao jin <caoj.fnst@cn.fujitsu.com>, qemu-devel@nongnu.org
Cc: Jiri Pirko <jiri@resnulli.us>, Gerd Hoffmann <kraxel@redhat.com>, Dmitry Fleytman <dmitry@daynix.com>, Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Markus Armbruster <armbru@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>

On 01/17/2017 07:18 AM, Cao jin wrote:
> msix_init() reports errors with error_report(), which is wrong when
> it's used in realize().  The same issue was fixed for msi_init() in
> commit 1108b2f. In order to make the API change as small as possible,
> leave the return value check to later patch.
>=20
> For some devices(like e1000e, vmxnet3, nvme) who won't fail because of
> msix_init's failure, suppress the error report by passing NULL error
> object.
>=20
> Bonus: add comment for msix_init.
>=20
> CC: Jiri Pirko <jiri@resnulli.us>
> CC: Gerd Hoffmann <kraxel@redhat.com>
> CC: Dmitry Fleytman <dmitry@daynix.com>
> CC: Jason Wang <jasowang@redhat.com>
> CC: Michael S. Tsirkin <mst@redhat.com>
> CC: Hannes Reinecke <hare@suse.de>
> CC: Paolo Bonzini <pbonzini@redhat.com>
> CC: Alex Williamson <alex.williamson@redhat.com>
> CC: Markus Armbruster <armbru@redhat.com>
> CC: Marcel Apfelbaum <marcel@redhat.com>
> Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>
> ---
>  hw/block/nvme.c        |  2 +-
>  hw/misc/ivshmem.c      |  8 ++++----
>  hw/net/e1000e.c        |  2 +-
>  hw/net/rocker/rocker.c |  4 +++-
>  hw/net/vmxnet3.c       |  2 +-
>  hw/pci/msix.c          | 36 +++++++++++++++++++++++++++++++-----
>  hw/scsi/megasas.c      |  4 +++-
>  hw/usb/hcd-xhci.c      |  4 ++--
>  hw/vfio/pci.c          |  8 ++++++--
>  hw/virtio/virtio-pci.c |  4 ++--
>  include/hw/pci/msix.h  |  5 +++--
>  11 files changed, 57 insertions(+), 22 deletions(-)
>=20
For megasas: Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
--=20
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N=FCrnberg
GF: F. Imend=F6rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N=FCrnberg)
