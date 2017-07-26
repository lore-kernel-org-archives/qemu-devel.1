Received: from eggs.gnu.org ([2001:4830:134:3::10]:45623)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1daWAT-00077N-4r
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 19:56:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1daWAR-0003fg-U3
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 19:56:41 -0400
Date: Thu, 27 Jul 2017 01:56:30 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
Message-ID: <20170726235630.7yca74jlrjfap2hc@aurel32.net>
References: <20170721041952.45950-1-aik@ozlabs.ru>
	<b3ed544c-a576-7a74-b7b0-8067873cf11e@amsat.org>
	<c7cc6429-fe77-2b47-d08b-f4266524407e@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <c7cc6429-fe77-2b47-d08b-f4266524407e@ozlabs.ru>
Subject: Re: [Qemu-devel] [PATCH qemu] Revert "elf-loader: warn about
 invalid endianness"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: Philippe =?iso-8859-15?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, Paul Burton <paul.burton@imgtec.com>, Alistair Francis <alistair.francis@xilinx.com>, Yongbok Kim <yongbok.kim@imgtec.com>

On 2017-07-21 17:30, Alexey Kardashevskiy wrote:
> On 21/07/17 16:48, Philippe Mathieu-Daud=E9 wrote:
> > Hi Alexey,
> >=20
> > On 07/21/2017 01:19 AM, Alexey Kardashevskiy wrote:
> >> This reverts c8e1158cf611 "elf-loader: warn about invalid endianness"
> >> as it produces a useless message every time an LE kernel image is
> >> passed via -kernel on a ppc64-pseries machine. The pseries machine
> >> already checks for ELF_LOAD_WRONG_ENDIAN and tries with big_endian=3D0.
> >>
> >> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> >> ---
> >>   hw/core/loader.c | 1 -
> >>   1 file changed, 1 deletion(-)
> >>
> >> diff --git a/hw/core/loader.c b/hw/core/loader.c
> >> index c17ace0a2e..e5e8cbb638 100644
> >> --- a/hw/core/loader.c
> >> +++ b/hw/core/loader.c
> >> @@ -480,7 +480,6 @@ int load_elf_ram(const char *filename,
> >>       }
> >>         if (target_data_order !=3D e_ident[EI_DATA]) {
> >> -        fprintf(stderr, "%s: wrong endianness\n", filename);
> >>           ret =3D ELF_LOAD_WRONG_ENDIAN;
> >>           goto fail;
> >>       }
> >>
> >=20
> > I submitted this patch because I spent some time debugging while QEMU w=
as
> > failing silently using a MIPS kernel image which used to work, after
> > realizing I was in an incorrect build_dir using qemu-system-mipsel to l=
oad
> > a big endian image and felt stupid [1]. This dumb error can happen to o=
ther
> > people so I added this warning here.
>=20
> Been there too. This is why we try loading images twice in pseries.

Indeed. For a better understanding of the issue, it should be noted that
the pseries platform can dynamically change its endianness at runtime
and thus can load both little and big endian kernel. This is done by
calling load_elf twice with both endianness. Therefore the fact that the
endianness *does not* match is not an issue in that case.

> > I was not aware of the ELF_LOAD_WRONG_ENDIAN related code, and at least=
 the
> > MIPS arch is not using it.
> > As I can see in MAINTAINERS, sPAPR is "Supported" meaning "Someone is
> > actually paid to look after this", while there is no such paid person f=
or
> > the MIPS part.
> > It seems each arch had a different way to load images and hw/core/loade=
r.c
> > was an effort to merge common code but mostly "Supported" arch are usin=
g it.
>=20
> afaict MIPS calls load_elf() in 4 places, each checks for the return value
> and already prints the message, how come that that message is not enough?
> What would probably make sense here is if MIPS also printed the return co=
de
> from load_elf() but in any case it is easily visible from gdb.

It display an error message, but this message doesn't display why the
ELF kernel failed to be loaded.
=20
> > While your revert does fixes your sPAPR warning issue, looking at the
> > problem roots I think the correct fix is to improve the MIPS port and
> > eventually the less loved archs to unify the loader.c calls and avoid s=
uch
> > problems.
> > I don't object reverting this patch for 2.10 and improve the loader.c u=
sage
> > during 2.11 cycle, I only wonder if this is another corporate/hobbyist>=
 conflict of interest with corporate crushing on hobbyist instead of
>=20
> Come on mate...

I would not call it a conflict, but it's definitely a corporte/hobbyist
issue. The corporate people designed a nice load_elf_strerror function
to report error and the hobbyist people failed to use it.

Anyway I have just sent a simple patch series improving the MIPS error
reporting. That should make everybody happy.

--=20
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
