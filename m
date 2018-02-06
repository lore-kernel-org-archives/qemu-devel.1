Received: from eggs.gnu.org ([2001:4830:134:3::10]:34057)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eiwWd-0004b4-Fw
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 01:14:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eiwWa-0000b0-Pc
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 01:14:39 -0500
References: <1517864246-11101-1-git-send-email-walling@linux.vnet.ibm.com>
	<1517864246-11101-5-git-send-email-walling@linux.vnet.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <35fce730-9133-fe19-2c54-3b9f8a09ed26@redhat.com>
Date: Tue, 6 Feb 2018 07:14:27 +0100
MIME-Version: 1.0
In-Reply-To: <1517864246-11101-5-git-send-email-walling@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v5 04/12] s390-ccw: update libc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Collin L. Walling" <walling@linux.vnet.ibm.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: frankja@linux.vnet.ibm.com, cohuck@redhat.com, david@redhat.com, alifm@linux.vnet.ibm.com, mihajlov@linux.vnet.ibm.com, borntraeger@de.ibm.com, eblake@redhat.com

On 05.02.2018 21:57, Collin L. Walling wrote:
> Moved:
>   memcmp from bootmap.h to libc.h (renamed from _memcmp)
>   strlen from sclp.c to libc.h (renamed from _strlen)
>=20
> Added C standard functions:
>   isdigit
>=20
> Added non C-standard function:
>   itostr
>   atoui
>=20
> Signed-off-by: Collin L. Walling <walling@linux.vnet.ibm.com>
> Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Reviewed-by: Janosch Frank <frankja@linux.vnet.ibm.com>
> ---
[...]
> +/**
> + * itostr:
> + * @num: an integer (base 10) to be converted.
> + * @str: a pointer to a string to store the conversion.
> + * @len: the length of the passed string.
> + *
> + * Given an integer @num, convert it to a string. The string @str must=
 be
> + * allocated beforehand. The resulting string will be null terminated =
and
> + * returned. This function only handles numbers between 0 and UINT64_M=
AX
> + * inclusive.
> + *
> + * Returns: the string @str of the converted integer @num; NULL if @st=
r
> + * is NULL or if there is not enough space allocated.
> + */
> +char *itostr(uint64_t num, char *str, size_t len)

Nitpicking: You renamed atoi to atoui, so maybe this should now rather
be uitostr or uitoa now?

> +{
> +    size_t num_idx =3D 0;
> +    uint64_t tmp =3D num;
> +
> +    IPL_assert(num >=3D 0, "itostr: cannot convert negative values");

(already mentioned by patchew)

> +    IPL_assert(str !=3D NULL, "itostr: no space allocated to store str=
ing");
> +
> +    /* Get index to ones place */
> +    while ((tmp /=3D 10) !=3D 0) {
> +        num_idx++;
> +    }
> +
> +    /* Check if we have enough space for num and null */
> +    IPL_assert(len >=3D num_idx + 1, "itostr: array too small for conv=
ersion");

Should that rather be "len > num_idx + 1" instead?

> +    str[num_idx + 1] =3D '\0';
> +
> +    /* Convert int to string */
> +    while (num_idx >=3D 0) {
> +        str[num_idx] =3D num % 10 + '0';
> +        num /=3D 10;
> +        num_idx--;
> +    }
> +
> +    return str;
> +}

 Thomas
