Received: from eggs.gnu.org ([2001:4830:134:3::10]:53391)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dTT4a-0008QO-Hm
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 09:13:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dTT4V-0003WM-JS
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 09:13:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37532)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1dTT4V-0003W9-9s
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 09:13:23 -0400
References: <20170706101611.27031-1-marcandre.lureau@redhat.com>
	<20170706101611.27031-3-marcandre.lureau@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <1ee1639b-3fa8-3dff-9957-31d96b8bf962@redhat.com>
Date: Fri, 7 Jul 2017 15:13:11 +0200
MIME-Version: 1.0
In-Reply-To: <20170706101611.27031-3-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 2/7] acpi: add vmcoreinfo device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: imammedo@redhat.com, anderson@redhat.com, berrange@redhat.com, ehabkost@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

Marc-Andr=C3=A9,

sorry about this, but I have another late comment (I shoudl have pointed
this out in v1). Regarding:

On 07/06/17 12:16, Marc-Andr=C3=A9 Lureau wrote:

> +#define VMCOREINFO_OFFSET           40   /* allow space for
> +                                          * OVMF SDT Header Probe Supr=
essor
> +                                          */

and

> +            Method (ADDR, 0, NotSerialized)
> +            {
> +                Local0 =3D Package (0x02) {}
> +                Local0 [Zero] =3D (VCIA + 0x28)
> +                Local0 [One] =3D Zero
> +                Return (Local0)
> +            }

and

> +In order to implement an OVMF "SDT Header Probe Suppressor", the conte=
nts of
> +the vmcoreinfo blob has 40 bytes of padding:
> +
> ++-----------------------------------+
> +| SSDT with OEM Table ID =3D VMCOREIN |
> ++-----------------------------------+
> +| ...                               |       TOP OF PAGE
> +| VCIA dword object ----------------|-----> +-------------------------=
--+
> +| ...                               |       | fw-allocated array for  =
  |
> +| _STA method referring to VCIA     |       | "etc/vmcoreinfo"        =
  |
> +| ...                               |       +-------------------------=
--+
> +| ADDR method referring to VCIA     |       |  0: OVMF SDT Header prob=
e |
> +| ...                               |       |     suppressor          =
  |
> ++-----------------------------------+       | 40: uint32 version field=
  |
> +                                            | 44: info contents       =
  |
> +                                            |     ....                =
  |
> +                                            +-------------------------=
--+
> +                                            END OF PAGE

Please define the VMCOREINFO_OFFSET macro like this:

  #define VMCOREINFO_OFFSET sizeof(AcpiTableHeader)

and then please refresh the documentation as well:
- replace decimal "40" with "36",
- replace 0x28 in the dumped SSDT with 0x24.

Namely, in order to suppress the OVMF ACP Table Header Probe -- "SDT"
simply means "System Description Table" --, it's enough to add
zero-padding that *precisely* covers such a header.

Given that we have a typedef for this header in QEMU, we should use it
in the definition of VMCOREINFO_OFFSET.

Now, the reason why VMGENID uses 40 instead comes from another
requirement: the VMGENID GUID has to be aligned at 8 bytes. (See
requirement "R1a" in "docs/specs/vmgenid.txt".) Therefore the directly
necessary 36 bytes of padding are rounded up to 40. See again
"docs/specs/vmgenid.txt":

----------------------------------+
| SSDT with OEM Table ID =3D VMGENID |
+----------------------------------+
| ...                              |       TOP OF PAGE
| VGIA dword object ---------------|-----> +---------------------------+
| ...                              |       | fw-allocated array for    |
| _STA method referring to VGIA    |       | "etc/vmgenid_guid"        |
| ...                              |       +---------------------------+
| ADDR method referring to VGIA    |       |  0: OVMF SDT Header probe |
| ...                              |       |     suppressor            |
+----------------------------------+       | 36: padding for 8-byte    |
                                           |     alignment             |
                                           | 40: GUID                  |
                                           | 56: padding to page size  |
                                           +---------------------------+
                                           END OF PAGE

At offset 36 of "etc/vmgenid_guid", it says "padding for 8-byte alignment=
".

For VMCOREINFO, you don't need this extra alignment to 8 bytes, before
the "version" field is listed. So please make the VMCOREINFO_OFFSET
reflect what's actually necessary.

The rest of the code doesn't have to be modified (including your
experimental guest kernel driver); changing VMCOREINFO_OFFSET will
update all necessary locations automatically, including the generated
AML. Only the docs have to be synced manually.

... In fact, there *is* yet another location to update: the test case. I
suggest to include "hw/acpi/vmcoreinfo.h" in "tests/vmcoreinfo-test.c",
rather than open-code VMCOREINFO_OFFSET there. ... Oh wait: in the test
case you don't even use VMCOREINFO_OFFSET for anything. So just delete
the macro definition from that patch.

Thank you (and sorry about the churn),
Laszlo
