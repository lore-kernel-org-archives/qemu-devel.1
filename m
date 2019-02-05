Received: from eggs.gnu.org ([209.51.188.92]:37568)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gqy8t-0003Nn-6x
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 05:39:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gqy8r-0001zk-U3
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 05:39:50 -0500
Date: Tue, 5 Feb 2019 11:32:19 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190205113219.0c1311e0.cohuck@redhat.com>
In-Reply-To: <20190204211204.27321-3-philmd@redhat.com>
References: <20190204211204.27321-1-philmd@redhat.com>
	<20190204211204.27321-3-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 2/3] util/cutils: Move ctype macros to
 "cutils.h"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org, qemu-riscv@nongnu.org, Stefano Garzarella <sgarzare@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Halil Pasic <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Richard Henderson <rth@twiddle.net>, David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Michael Clark <mjc@sifive.com>, Palmer Dabbelt <palmer@sifive.com>, Alistair Francis <Alistair.Francis@wdc.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Gerd Hoffmann <kraxel@redhat.com>, "open list:S390 Virtio-ccw" <qemu-s390x@nongnu.org>, qemu-ppc@nongnu.org

On Mon,  4 Feb 2019 22:12:03 +0100
Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:

> Introduced in cd390083ad1, these macros don't need to be in
> a generic header.
> Add documentation to justify their use.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> ---
> v2: Fixed checkpatch warnings (tabs)
> ---
>  hw/core/bus.c              |  2 +-
>  hw/core/qdev-properties.c  |  1 +
>  hw/s390x/s390-virtio-ccw.c |  1 +
>  hw/scsi/scsi-generic.c     |  2 +-
>  include/qemu-common.h      | 16 ----------------
>  include/qemu/cutils.h      | 25 +++++++++++++++++++++++++
>  qapi/qapi-util.c           |  2 +-
>  qobject/json-parser.c      |  1 -
>  target/ppc/monitor.c       |  1 +
>  target/riscv/cpu.c         |  1 +
>  ui/keymaps.c               |  1 +
>  util/id.c                  |  2 +-
>  util/readline.c            |  1 -
>  13 files changed, 34 insertions(+), 22 deletions(-)

> diff --git a/include/qemu/cutils.h b/include/qemu/cutils.h
> index 9ee40470e3..644f2d75bd 100644
> --- a/include/qemu/cutils.h
> +++ b/include/qemu/cutils.h
> @@ -3,6 +3,31 @@
> =20
>  #include "qemu/fprintf-fn.h"
> =20
> +/**
> + * unsigned ctype macros:
> + *
> + * The standards require that the argument for these functions
> + * is either EOF or a value that is representable in the type
> + * unsigned char. If the argument is of type char, it must be
> + * cast to unsigned char. This is what these macros do,
> + * avoiding 'signed to unsigned' conversion warnings.

I'd add

"Note that these macros are intended for use with char arguments only,
they cannot handle EOF."

> + */
> +#define qemu_isalnum(c)     isalnum((unsigned char)(c))
> +#define qemu_isalpha(c)     isalpha((unsigned char)(c))
> +#define qemu_iscntrl(c)     iscntrl((unsigned char)(c))
> +#define qemu_isdigit(c)     isdigit((unsigned char)(c))
> +#define qemu_isgraph(c)     isgraph((unsigned char)(c))
> +#define qemu_islower(c)     islower((unsigned char)(c))
> +#define qemu_isprint(c)     isprint((unsigned char)(c))
> +#define qemu_ispunct(c)     ispunct((unsigned char)(c))
> +#define qemu_isspace(c)     isspace((unsigned char)(c))
> +#define qemu_isupper(c)     isupper((unsigned char)(c))
> +#define qemu_isxdigit(c)    isxdigit((unsigned char)(c))
> +#define qemu_tolower(c)     tolower((unsigned char)(c))
> +#define qemu_toupper(c)     toupper((unsigned char)(c))
> +#define qemu_isascii(c)     isascii((unsigned char)(c))
> +#define qemu_toascii(c)     toascii((unsigned char)(c))
> +
>  /**
>   * pstrcpy:
>   * @buf: buffer to copy string into

With that added,

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
