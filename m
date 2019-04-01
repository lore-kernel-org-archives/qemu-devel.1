Received: from eggs.gnu.org ([209.51.188.92]:45283)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1hAxb0-0000El-JF
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 10:07:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1hAxaz-0003x4-Kb
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 10:07:30 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45740
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.ibm.com>) id 1hAxaz-0003wk-FV
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 10:07:29 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x31E1HZ8107799
	for <qemu-devel@nongnu.org>; Mon, 1 Apr 2019 10:07:29 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2rkku59hhp-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 01 Apr 2019 10:07:28 -0400
Received: from localhost
	by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.ibm.com>;
	Mon, 1 Apr 2019 15:07:22 +0100
Date: Mon, 1 Apr 2019 16:07:09 +0200
From: Halil Pasic <pasic@linux.ibm.com>
In-Reply-To: <20190329111104.17223-12-berrange@redhat.com>
References: <20190329111104.17223-1-berrange@redhat.com>
	<20190329111104.17223-12-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Message-Id: <20190401160709.03cddb89@oc2783563651>
Subject: Re: [Qemu-devel] [PATCH 11/14] hw/vfio/ccw: avoid taking address
 members in packed structs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Eric Farman <farman@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Laurent Vivier <laurent@vivier.eu>, Max Filippov <jcmvbkbc@gmail.com>, qemu-s390x@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, Thomas Huth <thuth@redhat.com>, Riku Voipio <riku.voipio@iki.fi>, Christian Borntraeger <borntraeger@de.ibm.com>, Richard Henderson <rth@twiddle.net>

On Fri, 29 Mar 2019 11:11:01 +0000
Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:

> The GCC 9 compiler complains about many places in s390 code
> that take the address of members of the 'struct SCHIB' which
> is marked packed:
>=20
> hw/vfio/ccw.c: In function =E2=80=98vfio_ccw_io_notifier_handler=E2=80=99:
> hw/vfio/ccw.c:133:15: warning: taking address of packed member of =E2=80=
=98struct SCHIB=E2=80=99 may result in an unaligned pointer value \
> [-Waddress-of-packed-member]
>   133 |     SCSW *s =3D &sch->curr_status.scsw;
>       |               ^~~~~~~~~~~~~~~~~~~~~~
> hw/vfio/ccw.c:134:15: warning: taking address of packed member of =E2=80=
=98struct SCHIB=E2=80=99 may result in an unaligned pointer value \
> [-Waddress-of-packed-member]
>   134 |     PMCW *p =3D &sch->curr_status.pmcw;
>       |               ^~~~~~~~~~~~~~~~~~~~~~
>=20
> ...snip many more...
>=20
> Almost all of these are just done for convenience to avoid
> typing out long variable/field names when referencing struct
> members. We can get most of this convenience by taking the
> address of the 'struct SCHIB' instead, avoiding triggering
> the compiler warnings.
>=20
> In a couple of places we copy via a local variable which is
> a technique already applied elsewhere in s390 code for this
> problem.
>=20
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Reviewed-by: Halil Pasic <pasic@linux.ibm.com>

BTW the reason for SCHIB being packed is the padding that
would emerge at the end of the struct (sizeof(SCHIB) =3D=3D 52
and non-packed sizeof(SCHIB) =3D=3D 54). So getting rid of packed
seems to be viable as long as we write guest memory
with the correct size (52 bytes).

Regards,
Halil=20
