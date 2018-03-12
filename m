Received: from eggs.gnu.org ([2001:4830:134:3::10]:44117)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1evOo1-0005wj-W0
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 10:52:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1evOnx-00078J-Tx
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 10:52:06 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:35348)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1evOnx-000737-Ja
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 10:52:01 -0400
Received: by mail-wm0-x244.google.com with SMTP id x7so16680482wmc.0
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 07:52:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180308195811.24894-17-dgilbert@redhat.com>
References: <20180308195811.24894-1-dgilbert@redhat.com>
	<20180308195811.24894-17-dgilbert@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 12 Mar 2018 15:51:59 +0100
Message-ID: <CAJ+F1CLNKtgthomuJbWn0YgVpKT=KQ2HEeTEXBHrqst=i+JSAA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 16/29] vhost+postcopy: Stash RAMBlock
 and offset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>, Maxime Coquelin <maxime.coquelin@redhat.com>, Peter Xu <peterx@redhat.com>, Juan Quintela <quintela@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>

On Thu, Mar 8, 2018 at 8:57 PM, Dr. David Alan Gilbert (git)
<dgilbert@redhat.com> wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> Stash the RAMBlock and offset for later use looking up
> addresses.
>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  hw/virtio/trace-events |  1 +
>  hw/virtio/vhost-user.c | 34 ++++++++++++++++++++++++++++++++++
>  2 files changed, 35 insertions(+)
>
> diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
> index 05d18ada77..d7e9e1084b 100644
> --- a/hw/virtio/trace-events
> +++ b/hw/virtio/trace-events
> @@ -9,6 +9,7 @@ vhost_section(const char *name, int r) "%s:%d"
>  # hw/virtio/vhost-user.c
>  vhost_user_postcopy_listen(void) ""
>  vhost_user_set_mem_table_postcopy(uint64_t client_addr, uint64_t qhva, i=
nt reply_i, int region_i) "client:0x%"PRIx64" for hva: 0x%"PRIx64" reply %d=
 region %d"
> +vhost_user_set_mem_table_withfd(int index, const char *name, uint64_t me=
mory_size, uint64_t guest_phys_addr, uint64_t userspace_addr, uint64_t offs=
et) "%d:%s: size:0x%"PRIx64" GPA:0x%"PRIx64" QVA/userspace:0x%"PRIx64" RB o=
ffset:0x%"PRIx64
>
>  # hw/virtio/virtio.c
>  virtqueue_alloc_element(void *elem, size_t sz, unsigned in_num, unsigned=
 out_num) "elem %p size %zd in_num %u out_num %u"
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index 6875f729e8..fd65616961 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -175,6 +175,15 @@ struct vhost_user {
>      NotifierWithReturn postcopy_notifier;
>      struct PostCopyFD  postcopy_fd;
>      uint64_t           postcopy_client_bases[VHOST_MEMORY_MAX_NREGIONS];
> +    /* Length of the region_rb and region_rb_offset arrays */
> +    size_t             region_rb_len;
> +    /* RAMBlock associated with a given region */
> +    RAMBlock         **region_rb;
> +    /* The offset from the start of the RAMBlock to the start of the
> +     * vhost region.
> +     */
> +    ram_addr_t        *region_rb_offset;
> +
>      /* True once we've entered postcopy_listen */
>      bool               postcopy_listen;
>  };
> @@ -362,6 +371,17 @@ static int vhost_user_set_mem_table_postcopy(struct =
vhost_dev *dev,
>          msg.hdr.flags |=3D VHOST_USER_NEED_REPLY_MASK;
>      }
>
> +    if (u->region_rb_len < dev->mem->nregions) {
> +        u->region_rb =3D g_renew(RAMBlock*, u->region_rb, dev->mem->nreg=
ions);
> +        u->region_rb_offset =3D g_renew(ram_addr_t, u->region_rb_offset,
> +                                      dev->mem->nregions);
> +        memset(&(u->region_rb[u->region_rb_len]), '\0',
> +               sizeof(RAMBlock *) * (dev->mem->nregions - u->region_rb_l=
en));
> +        memset(&(u->region_rb_offset[u->region_rb_len]), '\0',
> +               sizeof(ram_addr_t) * (dev->mem->nregions - u->region_rb_l=
en));
> +        u->region_rb_len =3D dev->mem->nregions;
> +    }
> +
>      for (i =3D 0; i < dev->mem->nregions; ++i) {
>          struct vhost_memory_region *reg =3D dev->mem->regions + i;
>          ram_addr_t offset;
> @@ -372,6 +392,12 @@ static int vhost_user_set_mem_table_postcopy(struct =
vhost_dev *dev,
>                                       &offset);
>          fd =3D memory_region_get_fd(mr);
>          if (fd > 0) {
> +            trace_vhost_user_set_mem_table_withfd(fd_num, mr->name,
> +                                                  reg->memory_size,
> +                                                  reg->guest_phys_addr,
> +                                                  reg->userspace_addr, o=
ffset);
> +            u->region_rb_offset[i] =3D offset;
> +            u->region_rb[i] =3D mr->ram_block;
>              msg.payload.memory.regions[fd_num].userspace_addr =3D
>                  reg->userspace_addr;
>              msg.payload.memory.regions[fd_num].memory_size  =3D reg->mem=
ory_size;
> @@ -380,6 +406,9 @@ static int vhost_user_set_mem_table_postcopy(struct v=
host_dev *dev,
>              msg.payload.memory.regions[fd_num].mmap_offset =3D offset;
>              assert(fd_num < VHOST_MEMORY_MAX_NREGIONS);
>              fds[fd_num++] =3D fd;
> +        } else {
> +            u->region_rb_offset[i] =3D 0;
> +            u->region_rb[i] =3D NULL;
>          }
>      }
>
> @@ -1148,6 +1177,11 @@ static int vhost_user_cleanup(struct vhost_dev *de=
v)
>          close(u->slave_fd);
>          u->slave_fd =3D -1;
>      }
> +    g_free(u->region_rb);
> +    u->region_rb =3D NULL;
> +    g_free(u->region_rb_offset);
> +    u->region_rb_offset =3D NULL;
> +    u->region_rb_len =3D 0;
>      g_free(u);
>      dev->opaque =3D 0;
>
> --
> 2.14.3
>
>



--=20
Marc-Andr=C3=A9 Lureau
