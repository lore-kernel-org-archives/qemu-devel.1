Received: from eggs.gnu.org ([2001:4830:134:3::10]:36335)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gHx62-00008D-MF
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 16:28:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gHx5z-0001Nq-Fs
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 16:28:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44394)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gHx5z-0001N1-9o
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 16:28:07 -0400
Date: Wed, 31 Oct 2018 17:27:57 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20181031202757.GE30771@habkost.net>
References: <20181030150453.9344-1-marcandre.lureau@redhat.com>
	<20181030150453.9344-11-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20181030150453.9344-11-marcandre.lureau@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 10/10] hostmem: use object id for memory
 region name with >= 3.1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Amit Shah <amit@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, dgilbert@redhat.com, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>, Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>

On Tue, Oct 30, 2018 at 07:04:53PM +0400, Marc-Andr=E9 Lureau wrote:
> hostmem-file and hostmem-memfd use the whole object path for the
> memory region name, and hostname-ram uses only the path component (the
> object id, or canonical path basename):
>=20
> qemu -m 1024 -object memory-backend-file,id=3Dmem,size=3D1G,mem-path=3D=
/tmp/foo -numa node,memdev=3Dmem -monitor stdio
> (qemu) info ramblock
>               Block Name    PSize              Offset               Use=
d              Total
>             /objects/mem    4 KiB  0x0000000000000000 0x000000004000000=
0 0x0000000040000000
>=20
> qemu -m 1024 -object memory-backend-memfd,id=3Dmem,size=3D1G -numa node=
,memdev=3Dmem -monitor stdio
> (qemu) info ramblock
>               Block Name    PSize              Offset               Use=
d              Total
>             /objects/mem    4 KiB  0x0000000000000000 0x000000004000000=
0 0x0000000040000000
>=20
> qemu -m 1024 -object memory-backend-ram,id=3Dmem,size=3D1G -numa node,m=
emdev=3Dmem -monitor stdio
> (qemu) info ramblock
>               Block Name    PSize              Offset               Use=
d              Total
>                      mem    4 KiB  0x0000000000000000 0x000000004000000=
0 0x0000000040000000
>=20
> Use the object id for -file and -memfd with >=3D 3.1 for consistency.
> Having a consistent naming allow to migrate to different hostmem
> backends.
>=20
> Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>

I don't want to make you feel like you wasted your time on the
global property system refactor, but:

Maybe it would be simpler to add a
  bool MachineClass::canonical_path_for_ramblock_id
field, instead of refactoring the global property system,
considering that we're past soft freeze?

Sometimes I think the global property system was a mistake, and
that we should avoid spreading it to other subsystems.

--=20
Eduardo
