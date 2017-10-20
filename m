Received: from eggs.gnu.org ([2001:4830:134:3::10]:55654)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1e5Vcn-0005Rj-HJ
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 07:38:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1e5Vci-0002LW-J5
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 07:38:01 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43446
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1e5Vci-0002LI-D4
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 07:37:56 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9KBTDQE094329
	for <qemu-devel@nongnu.org>; Fri, 20 Oct 2017 07:37:50 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2dqdf59sed-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 20 Oct 2017 07:37:50 -0400
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Fri, 20 Oct 2017 12:37:48 +0100
References: <20171020102517.28385-1-borntraeger@de.ibm.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Fri, 20 Oct 2017 13:37:44 +0200
MIME-Version: 1.0
In-Reply-To: <20171020102517.28385-1-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Message-Id: <b04cf5cc-cfb4-1f36-1a8b-99a34933a75c@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] s390-ccw: print carriage return with new
 lines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, Bjoern Walk <bwalk@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, "Jason J . Herne" <jjherne@linux.vnet.ibm.com>, "Collin L. Walling" <walling@linux.vnet.ibm.com>, Richard Henderson <rth@twiddle.net>



On 10/20/2017 12:25 PM, Christian Borntraeger wrote:
> From: "Collin L. Walling" <walling@linux.vnet.ibm.com>
>=20
> The sclp console in the s390 bios writes raw data,
> leading console emulators (such as virsh console) to
> treat a new line ('\n') as just a new line instead
> of as a Unix line feed. Because of this, output
> appears in a "stair case" pattern.
>=20
> Let's print \r\n on every occurrence of a new line
> in the string passed to write to amend this issue.
>=20
> This is in sync with the guest Linux code in
> drivers/s390/char/sclp_vt220.c which also does a line feed
> conversion  in the console part of the driver.=20
>=20
> This fixes the s390-ccw and s390-netboot output like
> $ virsh start test --console
> Domain test started
> Connected to domain test
> Escape character is ^]
> Network boot starting...
>                           Using MAC address: 02:01:02:03:04:05
>                                                                 Request=
ing information via DHCP:  010
>=20

The check for buffer overflow was not there previously, or?

Maybe integrate that in the commit message too.

> Signed-off-by: Collin L. Walling <walling@linux.vnet.ibm.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  pc-bios/s390-ccw/s390-ccw.h |  3 +++
>  pc-bios/s390-ccw/sclp.c     | 17 ++++++++++++++---
>  2 files changed, 17 insertions(+), 3 deletions(-)
>=20
> diff --git a/pc-bios/s390-ccw/s390-ccw.h b/pc-bios/s390-ccw/s390-ccw.h
> index 25d4d21..a8bd204 100644
> --- a/pc-bios/s390-ccw/s390-ccw.h
> +++ b/pc-bios/s390-ccw/s390-ccw.h
> @@ -33,6 +33,9 @@ typedef unsigned long long __u64;
>  #ifndef EBUSY
>  #define EBUSY   2
>  #endif
> +#ifndef EFBIG
> +#define EFBIG   3
> +#endif
>  #ifndef NULL
>  #define NULL    0
>  #endif
> diff --git a/pc-bios/s390-ccw/sclp.c b/pc-bios/s390-ccw/sclp.c
> index b1fc8ff..4795259 100644
> --- a/pc-bios/s390-ccw/sclp.c
> +++ b/pc-bios/s390-ccw/sclp.c
> @@ -76,17 +76,28 @@ static int _strlen(const char *str)
>  long write(int fd, const void *str, size_t len)
>  {
>      WriteEventData *sccb =3D (void *)_sccb;
> +    const char *p;
> +    size_t data_len =3D 0;
>=20
>      if (fd !=3D 1 && fd !=3D 2) {
>          return -EIO;
>      }
>=20
> -    sccb->h.length =3D sizeof(WriteEventData) + len;
> +    for (p =3D str; *p; ++p) {
> +        if (data_len > SCCB_DATA_LEN - 1) {
> +            return -EFBIG;
> +        }

We could also do a partial write or do more that one
sclp_service_call calls.

I don't think EFBIG is entirely correct here. From the man page:
"""
       EFBIG  An attempt was made to write a file that exceeds the implem=
enta-
              tion-defined maximum file size or the process=E2=80=99s fil=
e size limit,
              or to write at a position past the maximum allowed offset.
"""

That's not what we have here IMHO.

> +        if (*p =3D=3D '\n') {
> +            sccb->data[data_len++] =3D '\r';
> +        }
> +        sccb->data[data_len++] =3D *p;
> +    }
> +
> +    sccb->h.length =3D sizeof(WriteEventData) + data_len;
>      sccb->h.function_code =3D SCLP_FC_NORMAL_WRITE;
> -    sccb->ebh.length =3D sizeof(EventBufferHeader) + len;
> +    sccb->ebh.length =3D sizeof(EventBufferHeader) + data_len;
>      sccb->ebh.type =3D SCLP_EVENT_ASCII_CONSOLE_DATA;
>      sccb->ebh.flags =3D 0;
> -    memcpy(sccb->data, str, len);
>=20
>      sclp_service_call(SCLP_CMD_WRITE_EVENT_DATA, sccb);
>=20

Otherwise LGTM

Halil
