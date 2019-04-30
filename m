Received: from eggs.gnu.org ([209.51.188.92]:35215)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hLPqU-00027N-Dz
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 06:18:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hLPqT-000353-8X
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 06:18:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42768)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hLPqT-00034Y-2X
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 06:18:41 -0400
Date: Tue, 30 Apr 2019 11:18:33 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190430101833.GC6818@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190427135642.16464-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org, Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>

On Sat, Apr 27, 2019 at 03:56:42PM +0200, Philippe Mathieu-Daud=C3=A9 wro=
te:
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
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  qom/object.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
