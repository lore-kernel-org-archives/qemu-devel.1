Received: from eggs.gnu.org ([2001:4830:134:3::10]:54847)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eJe81-0007E7-00
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 06:32:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eJe7x-0000G4-1u
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 06:32:41 -0500
References: <1511816136-30068-1-git-send-email-walling@linux.vnet.ibm.com>
	<1511816136-30068-2-git-send-email-walling@linux.vnet.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <ae2d93c2-0521-2044-d9b4-c60b785fabbd@redhat.com>
Date: Tue, 28 Nov 2017 12:32:32 +0100
MIME-Version: 1.0
In-Reply-To: <1511816136-30068-2-git-send-email-walling@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v1 1/5] s390-ccw: update libc.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Collin L. Walling" <walling@linux.vnet.ibm.com>, borntraeger@de.ibm.com, frankja@linux.vnet.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org

On 27.11.2017 21:55, Collin L. Walling wrote:
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
> Reviewed-by: frankja@linux.vnet.ibm.com
> ---
[...]
> +/* atoi
> + *
> + * Given a string, convert it to an integer. Any
> + * non-numerical value will end the conversion.
> + *
> + * @str - the string to be converted
> + *
> + * @return - an integer converted from the string str
> + */

Looks like you want to use some kind of doc text markup here, but it
does not look like any valid syntax that I know ... may I suggest to use
gtk-doc as this is what most other QEMU developers are using (AFAIK)?

> +static inline int atoi(const char *str)
> +{
> +    int i;
> +    int val =3D 0;
> +
> +    for (i =3D 0; str[i]; i++) {
> +        char c =3D str[i];
> +        if (!isdigit(c)) {
> +            break;
> +        }
> +        val *=3D 10;
> +        val +=3D c - '0';
> +    }
> +
> +    return val;
> +}
> +
> +/* itostr
> + *
> + * Given an integer, convert it to a string. The string must be alloca=
ted
> + * beforehand. The resulting string will be null terminated and return=
ed.
> + *
> + * @str - the integer to be converted
> + * @num - a pointer to a string to store the conversion
> + *
> + * @return - the string of the converted integer
> + */

Smells like a good candidate for hard-to-debug buffer overruns later.
Could you please add a "length" parameter to do some sanity checking of
the destination buffer length, please?

> +static inline char *itostr(int num, char *str)
> +{
> +    int i;
> +    int len =3D 0;
> +    long tens =3D 1;
> +
> +    /* Handle 0 */
> +    if (num =3D=3D 0) {
> +        str[0] =3D '0';
> +        str[1] =3D '\0';
> +        return str;
> +    }
> +
> +    /* Count number of digits */
> +    while (num / tens !=3D 0) {
> +        tens *=3D 10;
> +        len++;
> +    }
> +
> +    /* Convert int -> string */
> +    for (i =3D 0; i < len; i++) {
> +        tens /=3D 10;
> +        str[i] =3D num / tens % 10 + '0';
> +    }
> +
> +    str[i] =3D '\0';
> +
> +    return str;
> +}

Having such a bigger, and likely performance-uncritical function as an
inline function in a header sounds somewhat wrong. Could you maybe move
this (and atoi()) into a proper .c file (libc.c?) instead, please?

 Thanks,
  Thomas
