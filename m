Received: from eggs.gnu.org ([2001:4830:134:3::10]:35886)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eNHJd-000197-JG
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 06:59:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eNHJc-0003D8-QQ
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 06:59:41 -0500
References: <49485e7e-f950-58c5-af56-b336b4d4f0e3@linux.vnet.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <506fac7c-e692-7eac-8984-4ce354a21bee@redhat.com>
Date: Fri, 8 Dec 2017 12:59:37 +0100
MIME-Version: 1.0
In-Reply-To: <49485e7e-f950-58c5-af56-b336b4d4f0e3@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Interactive Boot Menu: New Fields in IPLB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Collin L. Walling" <walling@linux.vnet.ibm.com>, qemu-devel <qemu-devel@nongnu.org>, qemu-s390x@nongnu.org
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>, Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>

On 08.12.2017 00:56, Collin L. Walling wrote:
> Hello,
>=20
> I'd like to bring up a formal discussion regarding the utilization of=20
> reserved space
> in the IPL Parameter Blocks for s390x guests. Particularly the followin=
g:
>=20
>   * How should we approach "claiming" bytes so that we do not obstruct
>     future development?
>   * What would be "the best" location to store these new fields?
>=20
> I've posted some relevant information regarding this feature below.
>=20
>=20
>  =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 --- The Fields We Need To Store ---
>=20
> Currently, we're utilizing 3 bytes out of a 77 byte reserved field in=20
> the IPLB for
> CCW and SCSI. We do this because need a way to pass the Qemu command=20
> line options
> for a boot menu (on/off and timeout) to the s390-ccw bios. We require=20
> only two
> fields in the IPLB, totaling 3 bytes:
>=20
>  =C2=A0* uint8_t boot_menu_flag
>  =C2=A0=C2=A0=C2=A0=C2=A0 o determines if we should show the menu or no=
t
>=20
>  =C2=A0* uint16_t boot_menu_timeout
>  =C2=A0=C2=A0=C2=A0=C2=A0 o stored as milliseconds
>  =C2=A0=C2=A0=C2=A0=C2=A0 o A max value of approx 65,000 gives us 65 se=
conds -- should be=20

1. Why on earth milliseconds. I'd rather have it remain open for 5
minutes than 1ms. 1s should really be a sufficient granularity.

2. Why not combine everything in one field?

0x00000000 -> Don't show
0x00000001 -> Show, wait 1s
...
0xffff0000 .. 0xfffffffe -> Reserved
0xffffffff -> Show, wait forever

We could add another special value for "use defaults from zipl"

--=20

Thanks,

David / dhildenb
