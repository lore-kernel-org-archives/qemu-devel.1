Received: from eggs.gnu.org ([2001:4830:134:3::10]:35153)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dwaOu-0003Ik-H9
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 16:54:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dwaOq-0003yO-J2
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 16:54:48 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44494)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1dwaOq-0003xs-A9
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 16:54:44 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8PKsUIN080805
	for <qemu-devel@nongnu.org>; Mon, 25 Sep 2017 16:54:40 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2d74amqcmg-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 25 Sep 2017 16:54:40 -0400
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 25 Sep 2017 14:54:39 -0600
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <1505933586-11296-1-git-send-email-felipe@nutanix.com>
References: <1505933586-11296-1-git-send-email-felipe@nutanix.com>
Date: Mon, 25 Sep 2017 15:52:29 -0500
Message-Id: <150637274906.26688.14507547849782225161@sif>
Subject: Re: [Qemu-devel] [PATCH] virtio/vhost: reset dev->log after syncing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, Felipe Franciosi <felipe@nutanix.com>, Jason Wang <jasowang@redhat.com>, Marc-Andre Lureau <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org

Quoting Felipe Franciosi (2017-09-20 13:53:06)
> vhost_log_put() is called to decomission the dirty log between qemu and
> a vhost device when stopping the device. Such a call can happen from
> migration_completion().
> =

> Present code sets dev->log_size to zero too early in vhost_log_put(),
> causing the sync check to always return false. As a consequence, the
> last pass on the dirty bitmap never happens at the end of migration.
> =

> If a vhost device was busy (writing to guest memory) until the last
> moments before vhost_virtqueue_stop(), this error will result in guest
> memory corruption (at least) following migrations.
> =

> Signed-off-by: Felipe Franciosi <felipe@nutanix.com>

FYI: this patch has been tagged for stable 2.10.1, but is not yet
upstream. Patch freeze for 2.10.1 is September 27th.

> ---
>  hw/virtio/vhost.c |    5 +++--
>  1 files changed, 3 insertions(+), 2 deletions(-)
> =

> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index 5fd69f0..ddc42f0 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -375,8 +375,6 @@ static void vhost_log_put(struct vhost_dev *dev, bool=
 sync)
>      if (!log) {
>          return;
>      }
> -    dev->log =3D NULL;
> -    dev->log_size =3D 0;
> =

>      --log->refcnt;
>      if (log->refcnt =3D=3D 0) {
> @@ -396,6 +394,9 @@ static void vhost_log_put(struct vhost_dev *dev, bool=
 sync)
> =

>          g_free(log);
>      }
> +
> +    dev->log =3D NULL;
> +    dev->log_size =3D 0;
>  }
> =

>  static bool vhost_dev_log_is_shared(struct vhost_dev *dev)
> -- =

> 1.7.1
> =

>=20
