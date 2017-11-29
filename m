Received: from eggs.gnu.org ([2001:4830:134:3::10]:55742)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eJr6h-0001eE-6p
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 20:24:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eJr6d-0003Dv-8T
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 20:24:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36654)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1eJr6d-0003Da-0w
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 20:24:07 -0500
Date: Wed, 29 Nov 2017 03:24:02 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20171129032348-mutt-send-email-mst@kernel.org>
References: <2e8c12f5242bcf755a33ee3a0e9ef94339d1808c.1510487579.git.tgolembi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2e8c12f5242bcf755a33ee3a0e9ef94339d1808c.1510487579.git.tgolembi@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3] virtio_balloon: include disk/file
 caches memory statistics
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?B?VG9tw6HFoSBHb2xlbWJpb3Zza8O9?= <tgolembi@redhat.com>
Cc: linux-mm@kvack.org, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, Huang Ying <ying.huang@intel.com>, Gal Hammer <ghammer@redhat.com>, Jason Wang <jasowang@redhat.com>, Amnon Ilan <ailan@redhat.com>, Wei Wang <wei.w.wang@intel.com>, Shaohua Li <shli@fb.com>, Rik van Riel <riel@redhat.com>

On Sun, Nov 12, 2017 at 01:05:38PM +0100, Tom=C3=A1=C5=A1 Golembiovsk=C3=BD=
 wrote:
> Add a new field VIRTIO_BALLOON_S_CACHES to virtio_balloon memory
> statistics protocol. The value represents all disk/file caches.
>=20
> In this case it corresponds to the sum of values
> Buffers+Cached+SwapCached from /proc/meminfo.
>=20
> Signed-off-by: Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com>


I parked this on vhost branch, part of linux next.

> ---
>  drivers/virtio/virtio_balloon.c     | 4 ++++
>  include/uapi/linux/virtio_balloon.h | 3 ++-
>  2 files changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_ba=
lloon.c
> index f0b3a0b9d42f..d2bd13bbaf9f 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -244,11 +244,13 @@ static unsigned int update_balloon_stats(struct v=
irtio_balloon *vb)
>  	struct sysinfo i;
>  	unsigned int idx =3D 0;
>  	long available;
> +	unsigned long caches;
> =20
>  	all_vm_events(events);
>  	si_meminfo(&i);
> =20
>  	available =3D si_mem_available();
> +	caches =3D global_node_page_state(NR_FILE_PAGES);
> =20
>  #ifdef CONFIG_VM_EVENT_COUNTERS
>  	update_stat(vb, idx++, VIRTIO_BALLOON_S_SWAP_IN,
> @@ -264,6 +266,8 @@ static unsigned int update_balloon_stats(struct vir=
tio_balloon *vb)
>  				pages_to_bytes(i.totalram));
>  	update_stat(vb, idx++, VIRTIO_BALLOON_S_AVAIL,
>  				pages_to_bytes(available));
> +	update_stat(vb, idx++, VIRTIO_BALLOON_S_CACHES,
> +				pages_to_bytes(caches));
> =20
>  	return idx;
>  }
> diff --git a/include/uapi/linux/virtio_balloon.h b/include/uapi/linux/v=
irtio_balloon.h
> index 343d7ddefe04..4e8b8304b793 100644
> --- a/include/uapi/linux/virtio_balloon.h
> +++ b/include/uapi/linux/virtio_balloon.h
> @@ -52,7 +52,8 @@ struct virtio_balloon_config {
>  #define VIRTIO_BALLOON_S_MEMFREE  4   /* Total amount of free memory *=
/
>  #define VIRTIO_BALLOON_S_MEMTOT   5   /* Total amount of memory */
>  #define VIRTIO_BALLOON_S_AVAIL    6   /* Available memory as in /proc =
*/
> -#define VIRTIO_BALLOON_S_NR       7
> +#define VIRTIO_BALLOON_S_CACHES   7   /* Disk caches */
> +#define VIRTIO_BALLOON_S_NR       8
> =20
>  /*
>   * Memory statistics structure.
> --=20
> 2.15.0
