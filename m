Received: from eggs.gnu.org ([209.51.188.92]:35613)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gkTdU-0008Ox-8F
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 07:52:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gkTdQ-0004Wm-8G
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 07:52:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34168)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gkTdG-0003yu-Ot
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 07:52:24 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id ED6D274F12
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 12:52:12 +0000 (UTC)
References: <1547576349-13337-1-git-send-email-pbonzini@redhat.com>
	<1547576349-13337-5-git-send-email-pbonzini@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <54cda442-8e0b-076a-d2bf-b8f1fbf9370c@redhat.com>
Date: Fri, 18 Jan 2019 13:52:10 +0100
MIME-Version: 1.0
In-Reply-To: <1547576349-13337-5-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 4/5] tests/libqos: embed allocators instead
 of malloc-ing them separately
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: lvivier@redhat.com

On 2019-01-15 19:19, Paolo Bonzini wrote:
> qgraph will embed these objects instead of allocating them in a separat=
e
> object.  Expose a new API "generic_alloc_init" and "generic_alloc_destr=
oy"
> for that, and rename the existing API with s/init/new/ and s/uninit/fre=
e/.
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
[...]
> diff --git a/tests/libqos/malloc.c b/tests/libqos/malloc.c
> index f7bae47..d44ae27 100644
> --- a/tests/libqos/malloc.c
> +++ b/tests/libqos/malloc.c
> @@ -15,24 +15,12 @@
>  #include "qemu-common.h"
>  #include "qemu/host-utils.h"
> =20
> -typedef QTAILQ_HEAD(MemList, MemBlock) MemList;
> -
>  typedef struct MemBlock {
>      QTAILQ_ENTRY(MemBlock) MLIST_ENTNAME;
>      uint64_t size;
>      uint64_t addr;
>  } MemBlock;
> =20
> -struct QGuestAllocator {
> -    QAllocOpts opts;
> -    uint64_t start;
> -    uint64_t end;
> -    uint32_t page_size;
> -
> -    MemList *used;
> -    MemList *free;
> -};
> -
>  #define DEFAULT_PAGE_SIZE 4096
> =20
>  static void mlist_delete(MemList *list, MemBlock *node)
> @@ -225,7 +213,7 @@ static void mlist_free(QGuestAllocator *s, uint64_t=
 addr)
>   * Mostly for valgrind happiness, but it does offer
>   * a chokepoint for debugging guest memory leaks, too.
>   */
> -void alloc_uninit(QGuestAllocator *allocator)
> +void alloc_destroy(QGuestAllocator *allocator)
>  {
>      MemBlock *node;
>      MemBlock *tmp;
> @@ -261,7 +249,6 @@ void alloc_uninit(QGuestAllocator *allocator)
> =20
>      g_free(allocator->used);
>      g_free(allocator->free);
> -    g_free(allocator);
>  }
> =20
>  uint64_t guest_alloc(QGuestAllocator *allocator, size_t size)
> @@ -297,9 +284,10 @@ void guest_free(QGuestAllocator *allocator, uint64=
_t addr)
>      }
>  }
> =20
> -QGuestAllocator *alloc_init(uint64_t start, uint64_t end)
> +void alloc_init(QGuestAllocator *s, QAllocOpts opts,

As far as I can see, you never use the "opts" parameter in this function
anymore. Should you keep the "s->opts =3D opts" line below? Or remove thi=
s
parameter completely?

> +                uint64_t start, uint64_t end,
> +                size_t page_size)
>  {
> -    QGuestAllocator *s =3D g_malloc0(sizeof(*s));
>      MemBlock *node;
> =20
>      s->start =3D start;
> @@ -313,26 +301,7 @@ QGuestAllocator *alloc_init(uint64_t start, uint64=
_t end)
>      node =3D mlist_new(s->start, s->end - s->start);
>      QTAILQ_INSERT_HEAD(s->free, node, MLIST_ENTNAME);
> =20
> -    s->page_size =3D DEFAULT_PAGE_SIZE;
> -
> -    return s;
> -}
> -
> -QGuestAllocator *alloc_init_flags(QAllocOpts opts,
> -                                  uint64_t start, uint64_t end)
> -{
> -    QGuestAllocator *s =3D alloc_init(start, end);
> -    s->opts =3D opts;

i.e. keep this line ^ ?

> -    return s;
> -}
> -
> -void alloc_set_page_size(QGuestAllocator *allocator, size_t page_size)
> -{
> -    /* Can't alter the page_size for an allocator in-use */
> -    g_assert(QTAILQ_EMPTY(allocator->used));
> -
> -    g_assert(is_power_of_2(page_size));
> -    allocator->page_size =3D page_size;
> +    s->page_size =3D page_size;
>  }

 Thomas
