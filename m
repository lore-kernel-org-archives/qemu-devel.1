Received: from eggs.gnu.org ([2001:4830:134:3::10]:56573)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ebjYx-0001rO-1b
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 03:59:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ebjYs-0005aZ-4O
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 03:59:15 -0500
References: <1516034665-27606-1-git-send-email-walling@linux.vnet.ibm.com>
	<1516034665-27606-7-git-send-email-walling@linux.vnet.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <18b92a33-e05a-d1d0-4ef5-8080853e93fb@redhat.com>
Date: Wed, 17 Jan 2018 09:58:57 +0100
MIME-Version: 1.0
In-Reply-To: <1516034665-27606-7-git-send-email-walling@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 6/8] s390-ccw: interactive boot menu for
 eckd dasd (print menu)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Collin L. Walling" <walling@linux.vnet.ibm.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, frankja@linux.vnet.ibm.com, cohuck@redhat.com, david@redhat.com, alifm@linux.vnet.ibm.com

On 15.01.2018 17:44, Collin L. Walling wrote:
> Prints the menu data starting from the zIPL menu banner.
>=20
> Signed-off-by: Collin L. Walling <walling@linux.vnet.ibm.com>
> ---
[...]
>  static void run_eckd_boot_script(block_number_t mbr_block_nr,
> diff --git a/pc-bios/s390-ccw/menu.c b/pc-bios/s390-ccw/menu.c
> index e15a7f2..30470b3 100644
> --- a/pc-bios/s390-ccw/menu.c
> +++ b/pc-bios/s390-ccw/menu.c
> @@ -10,10 +10,52 @@
>   */
> =20
>  #include "menu.h"
> +#include "s390-ccw.h"
> =20
>  static uint8_t flags;
>  static uint64_t timeout;
> =20
> +static void zipl_println(const char *data, size_t len)
> +{
> +    char buf[len + 1];
> +
> +    ebcdic_to_ascii(data, buf, len);
> +    buf[len] =3D '\n';
> +    buf[len + 1] =3D '\0';

Buffer overflow by 1. You need to declare "char buf[len + 2]".
Or drop the 0-termination and use write(1, buf, len + 1) instead of
sclp_print().

> +    sclp_print(buf);
> +}

 Thomas
