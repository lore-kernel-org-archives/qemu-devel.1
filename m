Received: from eggs.gnu.org ([2001:4830:134:3::10]:36513)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eQv8A-0007G4-Fs
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 08:06:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eQv87-0004A0-87
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 08:06:54 -0500
References: <1513030760-26245-1-git-send-email-walling@linux.vnet.ibm.com>
	<1513030760-26245-2-git-send-email-walling@linux.vnet.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <a6920dc1-f2be-cdd9-ba6e-a341a9e93343@redhat.com>
Date: Mon, 18 Dec 2017 14:06:39 +0100
MIME-Version: 1.0
In-Reply-To: <1513030760-26245-2-git-send-email-walling@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/5] s390-ccw: update libc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Collin L. Walling" <walling@linux.vnet.ibm.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, frankja@linux.vnet.ibm.com, cohuck@redhat.com, david@redhat.com

On 11.12.2017 23:19, Collin L. Walling wrote:
> Moved:
>   memcmp from bootmap.h to libc.h (renamed from _memcmp)
>   strlen from sclp.c to libc.h (renamed from _strlen)
>=20
> Added C standard functions:
>   isdigit
>   atoi
>=20
> Added non-C standard function:
>   itostr
>=20
> Signed-off-by: Collin L. Walling <walling@linux.vnet.ibm.com>
> Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Reviewed-by: Janosch Frank <frankja@linux.vnet.ibm.com>
> ---
>  pc-bios/s390-ccw/Makefile  |  2 +-
>  pc-bios/s390-ccw/bootmap.c |  4 +--
>  pc-bios/s390-ccw/bootmap.h | 16 +---------
>  pc-bios/s390-ccw/libc.c    | 75 ++++++++++++++++++++++++++++++++++++++=
++++++++
>  pc-bios/s390-ccw/libc.h    | 31 +++++++++++++++++++
>  pc-bios/s390-ccw/main.c    | 17 +----------
>  pc-bios/s390-ccw/sclp.c    | 10 +------
>  7 files changed, 112 insertions(+), 43 deletions(-)
>  create mode 100644 pc-bios/s390-ccw/libc.c
[...]
> +
> +/**
> + * itostr:
> + * @num: the integer to be converted.
> + * @str: a pointer to a string to store the conversion.
> + * @len: the length of the passed string.
> + *
> + * Given an integer @num, convert it to a string. The string @str must=
 be
> + * allocated beforehand. The resulting string will be null terminated =
and
> + * returned.
> + *
> + * Returns: the string @str of the converted integer @num.
> + */
> +char *itostr(int num, char *str, size_t len)
> +{
> +    long num_len =3D 1;
> +    int tmp =3D num;
> +    int i;
> +
> +    /* Count length of num */
> +    while ((tmp /=3D 10) > 0) {
> +        num_len++;
> +    }
> +
> +    /* Check if we have enough space for num and null */
> +    if (len < num_len) {
> +        return 0;
> +    }

I'm afraid, but I think you've got an off-by-one bug in this code.

In patch 5, you're using this function like this:

    char tmp[4];

    sclp_print(itostr(entries, tmp, sizeof(tmp)));

That means if entries is >=3D 1000 for example, num_len is 4 ...

> +    /* Convert int to string */
> +    for (i =3D num_len - 1; i >=3D 0; i--) {
> +        str[i] =3D num % 10 + '0';
> +        num /=3D 10;
> +    }
> +
> +    str[num_len] =3D '\0';

... and then you run into a buffer overflow here.

> +    return str;
> +}

Maybe it would also make more sense to panic() instead of "return 0"
since you don't check the return value in patch 5 ?

 Thomas
