Received: from eggs.gnu.org ([2001:4830:134:3::10]:52054)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fxW7k-0003ym-79
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 07:37:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fxW7h-0000k4-2d
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 07:37:28 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49080 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fxW7g-0000hq-RP
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 07:37:24 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20180905082919.6986-1-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Wed, 5 Sep 2018 12:29:19 +0400")
References: <20180905082919.6986-1-marcandre.lureau@redhat.com>
Reply-To: quintela@redhat.com
Date: Wed, 05 Sep 2018 13:37:11 +0200
Message-ID: <87va7k9nvc.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] memory: size can be different from ptr_size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, imammedo@redhat.com, dgilbert@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Alex Williamson <alex.williamson@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> wrote:
> memory_region_init_ram*_ptr() take only the size of the MemoryRegion,
> and allocate a RAMBlock with the same size. However, it may be
> convenient to expose a smaller MemoryRegion (for ex: a few bytes) than
> the RAMBlock (which must be a multiple of TARGET_PAGE_SIZE).
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  include/exec/memory.h  |  8 ++++++--
>  exec.c                 |  3 +++
>  hw/display/g364fb.c    |  2 +-
>  hw/vfio/common.c       |  3 ++-
>  hw/virtio/vhost-user.c |  2 +-
>  memory.c               | 10 ++++++----
>  6 files changed, 19 insertions(+), 9 deletions(-)
>
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index eb4f2fb249..03f257829b 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -700,6 +700,7 @@ void memory_region_init_ram_from_fd(MemoryRegion *mr,
>   *        must be unique within any device
>   * @size: size of the region.
>   * @ptr: memory to be mapped; must contain at least @size bytes.
                                                       ^^^^^

this comment gets wrong with your patches

> + * @ptr_size: size of @ptr buffer

> diff --git a/exec.c b/exec.c
> index 6826c8337d..fcea614e79 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -2361,6 +2361,9 @@ RAMBlock *qemu_ram_alloc_internal(ram_addr_t size, =
ram_addr_t max_size,
>  RAMBlock *qemu_ram_alloc_from_ptr(ram_addr_t size, void *host,
>                                     MemoryRegion *mr, Error **errp)
>  {
> +    assert(size >=3D TARGET_PAGE_SIZE);
> +    assert(size % TARGET_PAGE_SIZE =3D=3D 0);
> +
>      return qemu_ram_alloc_internal(size, size, NULL, host, false,
>                                     false, mr, errp);
>  }

ok with this bit.

But how about to change instead to:

void memory_region_init_ram_ptr(MemoryRegion *mr,
                                Object *owner,
                                const char *name,
                                uint64_t size,
                                void *ptr)
{
    uint64_t real_size =3D ROUND_UP_TARGET_PAGE_SIZE(size);
    memory_region_init(mr, owner, name, real_size);
    mr->ram =3D true;
    mr->terminates =3D true;
    mr->destructor =3D memory_region_destructor_ram;
    mr->dirty_log_mask =3D tcg_enabled() ? (1 << DIRTY_MEMORY_CODE) : 0;

    /* qemu_ram_alloc_from_ptr cannot fail with ptr !=3D NULL.  */
    assert(ptr !=3D NULL);
    mr->ram_block =3D qemu_ram_alloc_from_ptr(size, ptr, mr, &error_fatal);
}

For a suitable ROUND_UP_TARGET_PAGE_SIZE() macro.  You get the idea.

And memory_region_device_ram_ptr() don't even need a change.
We need to adjust the comments, but it looks like an easier patch to me, no?

> diff --git a/hw/display/g364fb.c b/hw/display/g364fb.c
> index fbc2b2422d..f4f5643761 100644
> --- a/hw/display/g364fb.c
> +++ b/hw/display/g364fb.c
> @@ -475,7 +475,7 @@ static void g364fb_init(DeviceState *dev, G364State *=
s)
>=20=20
>      memory_region_init_io(&s->mem_ctrl, NULL, &g364fb_ctrl_ops, s, "ctrl=
", 0x180000);
>      memory_region_init_ram_ptr(&s->mem_vram, NULL, "vram",
> -                               s->vram_size, s->vram);
> +                               s->vram_size, s->vram, s->vram_size);

Having to change all the devices that use the function with exactly the
same parameter looks weird to me.

What do you think?

Later, Juan.
