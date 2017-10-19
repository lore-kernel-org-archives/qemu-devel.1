Received: from eggs.gnu.org ([2001:4830:134:3::10]:34022)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1e5Acd-0007cL-PI
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 09:12:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1e5AcZ-0001WD-ME
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 09:12:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60240)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1e5AcZ-0001U6-DV
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 09:12:23 -0400
Date: Thu, 19 Oct 2017 16:12:20 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20171019160405-mutt-send-email-mst@kernel.org>
References: <cover.1505998455.git.tgolembi@redhat.com>
	<b13f11c03ed394bd8ad367dc90996ed134ea98da.1505998455.git.tgolembi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b13f11c03ed394bd8ad367dc90996ed134ea98da.1505998455.git.tgolembi@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/1] virtio_balloon: include buffers and
 cached memory statistics
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?B?VG9tw6HFoSBHb2xlbWJpb3Zza8O9?= <tgolembi@redhat.com>
Cc: linux-mm@kvack.org, virtualization@lists.linux-foundation.org, qemu-devel@nongnu.org, kvm@vger.kernel.org, virtio-dev@lists.oasis-open.org, Wei Wang <wei.w.wang@intel.com>, Shaohua Li <shli@fb.com>, Huang Ying <ying.huang@intel.com>, Jason Wang <jasowang@redhat.com>

On Thu, Sep 21, 2017 at 02:55:41PM +0200, Tom=C3=A1=C5=A1 Golembiovsk=C3=BD=
 wrote:
> Add a new fields, VIRTIO_BALLOON_S_BUFFERS and VIRTIO_BALLOON_S_CACHED,
> to virtio_balloon memory statistics protocol. The values correspond to
> 'Buffers' and 'Cached' in /proc/meminfo.
>=20
> To be able to compute the value of 'Cached' memory it is necessary to
> export total_swapcache_pages() to modules.
>=20
> Signed-off-by: Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com>

Does 'Buffers' actually make sense? It's a temporary storage -
wouldn't it be significantly out of date by the time
host receives it?

> ---
>  drivers/virtio/virtio_balloon.c     | 11 +++++++++++
>  include/uapi/linux/virtio_balloon.h |  4 +++-
>  mm/swap_state.c                     |  1 +
>  3 files changed, 15 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_ba=
lloon.c
> index f0b3a0b9d42f..c2558ec47a62 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -244,12 +244,19 @@ static unsigned int update_balloon_stats(struct v=
irtio_balloon *vb)
>  	struct sysinfo i;
>  	unsigned int idx =3D 0;
>  	long available;
> +	long cached;
> =20
>  	all_vm_events(events);
>  	si_meminfo(&i);
> =20
>  	available =3D si_mem_available();
> =20
> +	cached =3D global_node_page_state(NR_FILE_PAGES) -
> +			total_swapcache_pages() - i.bufferram;
> +	if (cached < 0)
> +		cached =3D 0;
> +
> +
>  #ifdef CONFIG_VM_EVENT_COUNTERS
>  	update_stat(vb, idx++, VIRTIO_BALLOON_S_SWAP_IN,
>  				pages_to_bytes(events[PSWPIN]));
> @@ -264,6 +271,10 @@ static unsigned int update_balloon_stats(struct vi=
rtio_balloon *vb)
>  				pages_to_bytes(i.totalram));
>  	update_stat(vb, idx++, VIRTIO_BALLOON_S_AVAIL,
>  				pages_to_bytes(available));
> +	update_stat(vb, idx++, VIRTIO_BALLOON_S_BUFFERS,
> +				pages_to_bytes(i.bufferram));
> +	update_stat(vb, idx++, VIRTIO_BALLOON_S_CACHED,
> +				pages_to_bytes(cached));
> =20
>  	return idx;
>  }
> diff --git a/include/uapi/linux/virtio_balloon.h b/include/uapi/linux/v=
irtio_balloon.h
> index 343d7ddefe04..d5dc8a56a497 100644
> --- a/include/uapi/linux/virtio_balloon.h
> +++ b/include/uapi/linux/virtio_balloon.h
> @@ -52,7 +52,9 @@ struct virtio_balloon_config {
>  #define VIRTIO_BALLOON_S_MEMFREE  4   /* Total amount of free memory *=
/
>  #define VIRTIO_BALLOON_S_MEMTOT   5   /* Total amount of memory */
>  #define VIRTIO_BALLOON_S_AVAIL    6   /* Available memory as in /proc =
*/
> -#define VIRTIO_BALLOON_S_NR       7
> +#define VIRTIO_BALLOON_S_BUFFERS  7   /* Buffers memory as in /proc */
> +#define VIRTIO_BALLOON_S_CACHED   8   /* Cached memory as in /proc */
> +#define VIRTIO_BALLOON_S_NR       9
> =20
>  /*
>   * Memory statistics structure.
> diff --git a/mm/swap_state.c b/mm/swap_state.c
> index 71ce2d1ccbf7..f3a4ff7d6c52 100644
> --- a/mm/swap_state.c
> +++ b/mm/swap_state.c
> @@ -95,6 +95,7 @@ unsigned long total_swapcache_pages(void)
>  	rcu_read_unlock();
>  	return ret;
>  }
> +EXPORT_SYMBOL_GPL(total_swapcache_pages);
> =20
>  static atomic_t swapin_readahead_hits =3D ATOMIC_INIT(4);

Need an ack from MM crowd on that.

> --=20
> 2.14.1
