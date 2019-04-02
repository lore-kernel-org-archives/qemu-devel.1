Received: from eggs.gnu.org ([209.51.188.92]:56502)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hBLqA-0003Cz-Iu
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 12:00:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hBLq9-0004Qn-KR
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 12:00:46 -0400
Date: Tue, 2 Apr 2019 18:00:33 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190402180033.77510387.cohuck@redhat.com>
In-Reply-To: <20190329111104.17223-12-berrange@redhat.com>
References: <20190329111104.17223-1-berrange@redhat.com>
	<20190329111104.17223-12-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Richard Henderson <rth@twiddle.net>, Halil Pasic <pasic@linux.ibm.com>, David Hildenbrand <david@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>, Eric Farman <farman@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Gerd Hoffmann <kraxel@redhat.com>, Riku Voipio <riku.voipio@iki.fi>, Alex Williamson <alex.williamson@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Thomas Huth <thuth@redhat.com>, Laurent Vivier <laurent@vivier.eu>

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
> ---
>  hw/vfio/ccw.c | 42 ++++++++++++++++++++++--------------------
>  1 file changed, 22 insertions(+), 20 deletions(-)

I'm currently in the process of queuing this and the other three s390x
fixes, but I'm inclined to do so for 4.1 (it feels a bit late in the
cycle for 4.0.)

Other opinions?
