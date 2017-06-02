Received: from eggs.gnu.org ([2001:4830:134:3::10]:53410)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dGqnv-00020F-7z
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 13:56:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dGqns-0005ue-5f
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 13:56:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45102)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dGqnr-0005uS-SE
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 13:56:04 -0400
Date: Fri, 2 Jun 2017 14:55:55 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170602175555.GI4294@thinpad.lan.raisama.net>
References: <20170602141229.15326-1-marcandre.lureau@redhat.com>
	<20170602141229.15326-4-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20170602141229.15326-4-marcandre.lureau@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 3/9] exec: split
 qemu_ram_alloc_from_file()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, imammedo@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>

On Fri, Jun 02, 2017 at 06:12:23PM +0400, Marc-Andr=E9 Lureau wrote:
> Add qemu_ram_alloc_from_fd(), which can be use to allocate ramblock fro=
m
> fd only.
>=20
> Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> ---
>  include/exec/ram_addr.h |  3 +++
>  exec.c                  | 45 ++++++++++++++++++++++++++++++-----------=
----
>  2 files changed, 33 insertions(+), 15 deletions(-)
>=20
> diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
> index 140efa840c..73d1bea8b6 100644
> --- a/include/exec/ram_addr.h
> +++ b/include/exec/ram_addr.h
> @@ -65,6 +65,9 @@ unsigned long last_ram_page(void);
>  RAMBlock *qemu_ram_alloc_from_file(ram_addr_t size, MemoryRegion *mr,
>                                     bool share, const char *mem_path,
>                                     Error **errp);
> +RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
> +                                 bool share, int fd,
> +                                 Error **errp);
>  RAMBlock *qemu_ram_alloc_from_ptr(ram_addr_t size, void *host,
>                                    MemoryRegion *mr, Error **errp);
>  RAMBlock *qemu_ram_alloc(ram_addr_t size, MemoryRegion *mr, Error **er=
rp);
> diff --git a/exec.c b/exec.c
> index 97e01d75f0..8cd3153450 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -1915,14 +1915,12 @@ static void ram_block_add(RAMBlock *new_block, =
Error **errp)
>  }
> =20
>  #ifdef __linux__
> -RAMBlock *qemu_ram_alloc_from_file(ram_addr_t size, MemoryRegion *mr,
> -                                   bool share, const char *mem_path,
> -                                   Error **errp)
> +RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
> +                                 bool share, int fd,
> +                                 Error **errp)
>  {
>      RAMBlock *new_block;
>      Error *local_err =3D NULL;
> -    int fd;
> -    bool created;
>      int64_t file_size;
> =20
>      if (xen_enabled()) {
> @@ -1947,18 +1945,12 @@ RAMBlock *qemu_ram_alloc_from_file(ram_addr_t s=
ize, MemoryRegion *mr,
>          return NULL;
>      }
> =20
> -    fd =3D file_ram_open(mem_path, memory_region_name(mr), &created, e=
rrp);
> -    if (fd < 0) {
> -        return NULL;
> -    }
> -

I like this, because it gets us one step closer to moving the
file creation/opening logic in file_ram_open() to hostmem-file.c.
Then both memfd and hostmem-file could use
memory_region_init_ram_from_fd(), and we won't need
memory_region_init_ram_from_file() anymore.


>      size =3D HOST_PAGE_ALIGN(size);
>      file_size =3D get_file_size(fd);
>      if (file_size > 0 && file_size < size) {
>          error_setg(errp, "backing store %s size 0x%" PRIx64
>                     " does not match 'size' option 0x" RAM_ADDR_FMT,
>                     mem_path, file_size, size);
> -        close(fd);
>          return NULL;
>      }
> =20
> @@ -1969,10 +1961,6 @@ RAMBlock *qemu_ram_alloc_from_file(ram_addr_t si=
ze, MemoryRegion *mr,
>      new_block->flags =3D share ? RAM_SHARED : 0;
>      new_block->host =3D file_ram_alloc(new_block, size, fd, !file_size=
, errp);
>      if (!new_block->host) {
> -        if (created) {
> -            unlink(mem_path);
> -        }
> -        close(fd);
>          g_free(new_block);
>          return NULL;
>      }
> @@ -1984,6 +1972,33 @@ RAMBlock *qemu_ram_alloc_from_file(ram_addr_t si=
ze, MemoryRegion *mr,
>          return NULL;
>      }
>      return new_block;
> +
> +}
> +
> +
> +RAMBlock *qemu_ram_alloc_from_file(ram_addr_t size, MemoryRegion *mr,
> +                                   bool share, const char *mem_path,
> +                                   Error **errp)
> +{
> +    int fd;
> +    bool created;
> +    RAMBlock *block;
> +
> +    fd =3D file_ram_open(mem_path, memory_region_name(mr), &created, e=
rrp);
> +    if (fd < 0) {
> +        return NULL;
> +    }
> +
> +    block =3D qemu_ram_alloc_from_fd(size, mr, share, fd, errp);
> +    if (!block) {
> +        if (created) {
> +            unlink(mem_path);
> +        }
> +        close(fd);
> +        return NULL;
> +    }
> +
> +    return block;
>  }
>  #endif
> =20
> --=20
> 2.13.0.91.g00982b8dd
>=20

--=20
Eduardo
