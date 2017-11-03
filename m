Received: from eggs.gnu.org ([2001:4830:134:3::10]:57855)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1eAa89-0008SO-H0
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 07:27:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1eAa86-00009I-BG
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 07:27:21 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:48293)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tgolembi@redhat.com>) id 1eAa86-00008c-2H
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 07:27:18 -0400
Received: by mail-wm0-f66.google.com with SMTP id p75so824196wmg.3
	for <qemu-devel@nongnu.org>; Fri, 03 Nov 2017 04:27:17 -0700 (PDT)
Date: Fri, 3 Nov 2017 12:27:14 +0100
From: =?UTF-8?B?VG9tw6HFoSBHb2xlbWJpb3Zza8O9?= <tgolembi@redhat.com>
Message-ID: <20171103122714.1e2da10d@fiorina>
In-Reply-To: <20171031180315-mutt-send-email-mst@kernel.org>
References: <cover.1505998455.git.tgolembi@redhat.com>
	<b13f11c03ed394bd8ad367dc90996ed134ea98da.1505998455.git.tgolembi@redhat.com>
	<20171019160405-mutt-send-email-mst@kernel.org>
	<20171022200557.02558e37@fiorina> <20171031132019.76197945@fiorina>
	<20171031180315-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
To: Martin Sivak <msivak@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, linux-mm@kvack.org, virtualization@lists.linux-foundation.org, qemu-devel@nongnu.org, kvm@vger.kernel.org, virtio-dev@lists.oasis-open.org, Wei Wang <wei.w.wang@intel.com>, Shaohua Li <shli@fb.com>, Huang Ying <ying.huang@intel.com>, Jason Wang <jasowang@redhat.com>, Gal Hammer <ghammer@redhat.com>, Amnon Ilan <ailan@redhat.com>, riel@redhat.com

On Tue, 31 Oct 2017 18:15:48 +0200
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Tue, Oct 31, 2017 at 01:20:19PM +0100, Tom=C3=A1=C5=A1 Golembiovsk=C3=
=BD wrote:
> > ping
> >=20
> > +Gil, +Amnon... could you maybe aid in reviewing the patch, please?
> >=20
> >=20
> >     Tomas
> >=20
> > On Sun, 22 Oct 2017 20:05:57 +0200
> > Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com> wrote:
> >=20
> > > On Thu, 19 Oct 2017 16:12:20 +0300
> > > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > >=20
> > > > On Thu, Sep 21, 2017 at 02:55:41PM +0200, Tom=C3=A1=C5=A1 Golembiov=
sk=C3=BD wrote: =20
> > > > > Add a new fields, VIRTIO_BALLOON_S_BUFFERS and VIRTIO_BALLOON_S_C=
ACHED,
> > > > > to virtio_balloon memory statistics protocol. The values correspo=
nd to
> > > > > 'Buffers' and 'Cached' in /proc/meminfo.
> > > > >=20
> > > > > To be able to compute the value of 'Cached' memory it is necessar=
y to
> > > > > export total_swapcache_pages() to modules.
> > > > >=20
> > > > > Signed-off-by: Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat=
.com> =20
> > > >=20
> > > > Does 'Buffers' actually make sense? It's a temporary storage -
> > > > wouldn't it be significantly out of date by the time
> > > > host receives it? =20
> > >=20
> > > That would be best answered by somebody from kernel. But my personal
> > > opinion is that it would not be out of date. The amount of memory
> > > dedicated to Buffers does not seem to fluctuate too much.
> > >=20
> > >     Tomas
> > >=20
>=20
> I would be inclined to say, just report
> global_node_page_state(NR_FILE_PAGES).
> Maybe subtract buffer ram.
>=20
> It's not clear host cares about the distinction,
> it's all memory that can shrink in response to
> memory pressure such as inflating the balloon.

So in procfs terms we'd be sending sum Cached+SwapCahced.
Martin, would that be good enough?

I wonder whether it would still make sense to send Buffers as a separate
value though. Maybe we should forget about having some granularity here
and just report all the disk caches as one value.

    Tomas

>=20
> This statistic is portable as well I think, most guests have
> storage cache.
>=20
>=20
> > > > > ---
> > > > >  drivers/virtio/virtio_balloon.c     | 11 +++++++++++
> > > > >  include/uapi/linux/virtio_balloon.h |  4 +++-
> > > > >  mm/swap_state.c                     |  1 +
> > > > >  3 files changed, 15 insertions(+), 1 deletion(-)
> > > > >=20
> > > > > diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/vir=
tio_balloon.c
> > > > > index f0b3a0b9d42f..c2558ec47a62 100644
> > > > > --- a/drivers/virtio/virtio_balloon.c
> > > > > +++ b/drivers/virtio/virtio_balloon.c
> > > > > @@ -244,12 +244,19 @@ static unsigned int update_balloon_stats(st=
ruct virtio_balloon *vb)
> > > > >  	struct sysinfo i;
> > > > >  	unsigned int idx =3D 0;
> > > > >  	long available;
> > > > > +	long cached;
> > > > > =20
> > > > >  	all_vm_events(events);
> > > > >  	si_meminfo(&i);
> > > > > =20
> > > > >  	available =3D si_mem_available();
> > > > > =20
> > > > > +	cached =3D global_node_page_state(NR_FILE_PAGES) -
> > > > > +			total_swapcache_pages() - i.bufferram;
> > > > > +	if (cached < 0)
> > > > > +		cached =3D 0;
> > > > > +
> > > > > +
> > > > >  #ifdef CONFIG_VM_EVENT_COUNTERS
> > > > >  	update_stat(vb, idx++, VIRTIO_BALLOON_S_SWAP_IN,
> > > > >  				pages_to_bytes(events[PSWPIN]));
> > > > > @@ -264,6 +271,10 @@ static unsigned int update_balloon_stats(str=
uct virtio_balloon *vb)
> > > > >  				pages_to_bytes(i.totalram));
> > > > >  	update_stat(vb, idx++, VIRTIO_BALLOON_S_AVAIL,
> > > > >  				pages_to_bytes(available));
> > > > > +	update_stat(vb, idx++, VIRTIO_BALLOON_S_BUFFERS,
> > > > > +				pages_to_bytes(i.bufferram));
> > > > > +	update_stat(vb, idx++, VIRTIO_BALLOON_S_CACHED,
> > > > > +				pages_to_bytes(cached));
> > > > > =20
> > > > >  	return idx;
> > > > >  }
> > > > > diff --git a/include/uapi/linux/virtio_balloon.h b/include/uapi/l=
inux/virtio_balloon.h
> > > > > index 343d7ddefe04..d5dc8a56a497 100644
> > > > > --- a/include/uapi/linux/virtio_balloon.h
> > > > > +++ b/include/uapi/linux/virtio_balloon.h
> > > > > @@ -52,7 +52,9 @@ struct virtio_balloon_config {
> > > > >  #define VIRTIO_BALLOON_S_MEMFREE  4   /* Total amount of free me=
mory */
> > > > >  #define VIRTIO_BALLOON_S_MEMTOT   5   /* Total amount of memory =
*/
> > > > >  #define VIRTIO_BALLOON_S_AVAIL    6   /* Available memory as in =
/proc */
> > > > > -#define VIRTIO_BALLOON_S_NR       7
> > > > > +#define VIRTIO_BALLOON_S_BUFFERS  7   /* Buffers memory as in /p=
roc */
> > > > > +#define VIRTIO_BALLOON_S_CACHED   8   /* Cached memory as in /pr=
oc */
> > > > > +#define VIRTIO_BALLOON_S_NR       9
> > > > > =20
> > > > >  /*
> > > > >   * Memory statistics structure.
> > > > > diff --git a/mm/swap_state.c b/mm/swap_state.c
> > > > > index 71ce2d1ccbf7..f3a4ff7d6c52 100644
> > > > > --- a/mm/swap_state.c
> > > > > +++ b/mm/swap_state.c
> > > > > @@ -95,6 +95,7 @@ unsigned long total_swapcache_pages(void)
> > > > >  	rcu_read_unlock();
> > > > >  	return ret;
> > > > >  }
> > > > > +EXPORT_SYMBOL_GPL(total_swapcache_pages);
> > > > > =20
> > > > >  static atomic_t swapin_readahead_hits =3D ATOMIC_INIT(4); =20
> > > >=20
> > > > Need an ack from MM crowd on that.
> > > >  =20
> > > > > --=20
> > > > > 2.14.1 =20
> > >=20
> > >=20
> > > --=20
> > > Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com>
> >=20
> >=20
> > --=20
> > Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com>


--=20
Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com>
