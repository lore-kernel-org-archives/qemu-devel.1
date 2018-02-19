Received: from eggs.gnu.org ([2001:4830:134:3::10]:37564)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1enpei-0008GE-3j
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 12:55:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1enpee-0006hl-Fd
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 12:55:12 -0500
References: <1518818879-18608-1-git-send-email-walling@linux.vnet.ibm.com>
	<1518818879-18608-5-git-send-email-walling@linux.vnet.ibm.com>
	<3528cfd5-c1e4-1252-5ea4-ed9b255afd91@redhat.com>
	<564c2c0c-7264-bdf9-b034-e87622137914@linux.vnet.ibm.com>
	<6e9e7a07-db5e-1130-bad7-83953cfea7c8@redhat.com>
	<06328b8c-4aa2-e791-9bcc-f83c2ac49964@linux.vnet.ibm.com>
	<26604847-20b0-3d62-8967-d520b599aaa8@linux.vnet.ibm.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b6895416-521b-d428-4e8e-166f5b5388ba@redhat.com>
Date: Mon, 19 Feb 2018 11:54:49 -0600
MIME-Version: 1.0
In-Reply-To: <26604847-20b0-3d62-8967-d520b599aaa8@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v7 04/12] s390-ccw: update libc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Collin L. Walling" <walling@linux.vnet.ibm.com>, Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: frankja@linux.vnet.ibm.com, cohuck@redhat.com, david@redhat.com, alifm@linux.vnet.ibm.com, mihajlov@linux.vnet.ibm.com, borntraeger@de.ibm.com

On 02/19/2018 11:17 AM, Collin L. Walling wrote:

> How is this for a compromise?
>=20
>  =C2=A0=C2=A0=C2=A0 - start num_idx at 1, provide comment as for why
>  =C2=A0=C2=A0=C2=A0 - change while loop comment to explain we are "coun=
ting the=20
> _indices_ _of_ _num_"
>  =C2=A0=C2=A0=C2=A0 - str[num_idx] is assigned \0, and we also decremen=
t num_idx in one=20
> line
>  =C2=A0=C2=A0=C2=A0 - in conversion loop, post decrement num_idx as it =
is used
>=20
> char *uitoa(int num, char *str, int len)
> {
>  =C2=A0 int num_idx =3D 1; /* account for NULL */

The single-byte character is named NUL (while NULL refers to the 8- or=20
4-byte pointer value).

>  =C2=A0 int tmp =3D num;
>=20
>  =C2=A0 assert(str !=3D NULL, "uitoa: no space allocated to store strin=
g");
>=20
>  =C2=A0 /* Count indices of num */
>  =C2=A0 while ((tmp /=3D 10) !=3D 0)
>  =C2=A0=C2=A0=C2=A0 num_idx++;
>=20
>  =C2=A0 /* Check if we have enough space for num and null */

and again

>  =C2=A0 assert(len > num_idx, "uitoa: array too small for conversion");
>=20
>  =C2=A0 str[num_idx--] =3D '\0';
>=20
>  =C2=A0 /* Convert int to string */
>  =C2=A0 while (num_idx >=3D 0) {
>  =C2=A0=C2=A0=C2=A0 str[num_idx--] =3D num % 10 + '0';
>  =C2=A0=C2=A0=C2=A0 num /=3D 10;
>  =C2=A0 }
>=20
>  =C2=A0 return str;

Otherwise, it seems readable to me.

> }
>=20
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
