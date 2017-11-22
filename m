Received: from eggs.gnu.org ([2001:4830:134:3::10]:47570)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eHWLB-0002a9-JD
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 09:49:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eHWL8-0006rQ-Go
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 09:49:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38526)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1eHWL8-0006qv-BR
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 09:49:26 -0500
Date: Wed, 22 Nov 2017 16:49:15 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20171122164101-mutt-send-email-mst@kernel.org>
References: <1510865080-32027-1-git-send-email-changpeng.liu@intel.com>
	<1510865080-32027-2-git-send-email-changpeng.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1510865080-32027-2-git-send-email-changpeng.liu@intel.com>
Subject: Re: [Qemu-devel] [PATCH v5 1/4] vhost-user: add new vhost user
 messages to support virtio config space
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Changpeng Liu <changpeng.liu@intel.com>
Cc: qemu-devel@nongnu.org, stefanha@gmail.com, pbonzini@redhat.com, marcandre.lureau@redhat.com, felipe@nutanix.com, james.r.harris@intel.com

On Fri, Nov 17, 2017 at 04:44:37AM +0800, Changpeng Liu wrote:
> Add VHOST_USER_GET_CONFIG/VHOST_USER_SET_CONFIG messages which can be
> used for live migration of vhost user devices, also vhost user devices
> can benefit from the messages to get/set virtio config space from/to the
> I/O target. For the purpose to support virtio config space change,
> VHOST_USER_SET_CONFIG_FD message is added as the event notifier
> in case virtio config space change in the I/O target.
> 
> Signed-off-by: Changpeng Liu <changpeng.liu@intel.com>
> ---
>  docs/interop/vhost-user.txt       | 39 ++++++++++++++++
>  hw/virtio/vhost-user.c            | 98 +++++++++++++++++++++++++++++++++++++++
>  hw/virtio/vhost.c                 | 63 +++++++++++++++++++++++++
>  include/hw/virtio/vhost-backend.h |  8 ++++
>  include/hw/virtio/vhost.h         | 16 +++++++
>  5 files changed, 224 insertions(+)
> 
> diff --git a/docs/interop/vhost-user.txt b/docs/interop/vhost-user.txt
> index 954771d..1b98388 100644
> --- a/docs/interop/vhost-user.txt
> +++ b/docs/interop/vhost-user.txt
> @@ -116,6 +116,16 @@ Depending on the request type, payload can be:
>      - 3: IOTLB invalidate
>      - 4: IOTLB access fail
>  
> + * Virtio device config space
> +   ---------------------------
> +   | offset | size | payload |
> +   ---------------------------
> +
> +   Offset: a 32-bit offset of virtio device's configuration space
> +   Size: a 32-bit size of configuration space that master wanted to change

I guess only legal values here are 1-256? But also see below. Also, we
already know the structure size.

> +   Payload: a 256-bytes array holding the contents of the virtio
> +       device's configuration space
> +

Why not *size* bytes? These are not performance critical but still,
why waste cycles.

>  In QEMU the vhost-user message is implemented with the following struct:
>  
>  typedef struct VhostUserMsg {

Virtio spec says:
	For device configuration access, the driver MUST use 8-bit wide accesses for 8-bit wide fields, 16-bit wide
	and aligned accesses for 16-bit wide fields and 32-bit wide and aligned accesses for 32-bit and 64-bit wide
	fields. For 64-bit fields, the driver MAY access each of the high and low 32-bit parts of the field independently.

So if these commands mirror guest accesses, they are always 1,2,4 or 8 bytes,
and aligned.


-- 
MST
