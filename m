Received: from eggs.gnu.org ([209.51.188.92]:50406)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hMd1s-00020w-2k
	for qemu-devel@nongnu.org; Fri, 03 May 2019 14:35:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hMd1r-0003z1-05
	for qemu-devel@nongnu.org; Fri, 03 May 2019 14:35:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52064)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hMd1q-0003yU-Qb
	for qemu-devel@nongnu.org; Fri, 03 May 2019 14:35:26 -0400
Date: Fri, 3 May 2019 15:35:21 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20190503183521.GT28722@habkost.net>
References: <20190427135642.16464-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190427135642.16464-1-philmd@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] qom/object: Display more helpful message
 when an object type is missing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Cc: qemu-devel@nongnu.org, Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>, Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>

On Sat, Apr 27, 2019 at 03:56:42PM +0200, Philippe Mathieu-Daud=E9 wrote:
> When writing a new board, adding device which uses other devices
> (container) or simply refactoring, one can discover the hard way
> his machine misses some devices. In the case of containers, the
> error is not obvious:
>=20
>   $ qemu-system-microblaze -M xlnx-zynqmp-pmu
>   **
>   ERROR:/source/qemu/qom/object.c:454:object_initialize_with_type: asse=
rtion failed: (type !=3D NULL)
>   Aborted (core dumped)
>=20
> And we have to look at the coredump to figure the error:
>=20
>   (gdb) bt
>   #1  0x00007f84773cf895 in abort () at /lib64/libc.so.6
>   #2  0x00007f847961fb53 in  () at /lib64/libglib-2.0.so.0
>   #3  0x00007f847967a4de in g_assertion_message_expr () at /lib64/libgl=
ib-2.0.so.0
>   #4  0x000055c4bcac6c11 in object_initialize_with_type (data=3Ddata@en=
try=3D0x55c4bdf239e0, size=3Dsize@entry=3D2464, type=3D<optimized out>) a=
t /source/qemu/qom/object.c:454
>   #5  0x000055c4bcac6e6d in object_initialize (data=3Ddata@entry=3D0x55=
c4bdf239e0, size=3Dsize@entry=3D2464, typename=3Dtypename@entry=3D0x55c4b=
cc7c643 "xlnx.zynqmp_ipi") at /source/qemu/qom/object.c:474
>   #6  0x000055c4bc9ea474 in xlnx_zynqmp_pmu_init (machine=3D0x55c4bdd46=
000) at /source/qemu/hw/microblaze/xlnx-zynqmp-pmu.c:176
>   #7  0x000055c4bca3b6cb in machine_run_board_init (machine=3D0x55c4bdd=
46000) at /source/qemu/hw/core/machine.c:1030
>   #8  0x000055c4bc95f6d2 in main (argc=3D<optimized out>, argv=3D<optim=
ized out>, envp=3D<optimized out>) at /source/qemu/vl.c:4479
>=20
> Since the caller knows the type name requested, we can simply display i=
t
> to ease development.
>=20
> With this patch applied we get:
>=20
>   $ qemu-system-microblaze -M xlnx-zynqmp-pmu
>   qemu-system-microblaze: missing object type 'xlnx.zynqmp_ipi'
>   Aborted (core dumped)
>=20
> Since the assert(type) check in object_initialize_with_type() is
> now impossible, remove it.
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

Queued, thanks!

--=20
Eduardo
