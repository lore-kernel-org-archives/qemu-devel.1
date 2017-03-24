Received: from eggs.gnu.org ([2001:4830:134:3::10]:60852)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1crIAc-0000Fi-4T
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 01:53:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1crIAa-0001vJ-Nx
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 01:53:54 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:60557)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1crIAZ-0001rf-QZ
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 01:53:52 -0400
Date: Fri, 24 Mar 2017 13:26:46 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170324022646.GN19078@umbus.fritz.box>
References: <20170323100455.26821-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="R92lf0Oi2sxyK3LA"
Content-Disposition: inline
In-Reply-To: <20170323100455.26821-1-marcandre.lureau@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] spapr: fix buffer-overflow
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, agraf@suse.de


--R92lf0Oi2sxyK3LA
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 23, 2017 at 02:04:55PM +0400, Marc-Andr=E9 Lureau wrote:
> Running postcopy-test with ASAN produces the following error:
>=20
> QTEST_QEMU_BINARY=3Dppc64-softmmu/qemu-system-ppc64  tests/postcopy-test
> ...
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =3D=3D23641=3D=3DERROR: AddressSanitizer: heap-buffer-overflow on address=
 0x7f1556600000 at pc 0x55b8e9d28208 bp 0x7f1555f4d3c0 sp 0x7f1555f4d3b0
> READ of size 8 at 0x7f1556600000 thread T6
>     #0 0x55b8e9d28207 in htab_save_first_pass /home/elmarco/src/qq/hw/ppc=
/spapr.c:1528
>     #1 0x55b8e9d2939c in htab_save_iterate /home/elmarco/src/qq/hw/ppc/sp=
apr.c:1665
>     #2 0x55b8e9beae3a in qemu_savevm_state_iterate /home/elmarco/src/qq/m=
igration/savevm.c:1044
>     #3 0x55b8ea677733 in migration_thread /home/elmarco/src/qq/migration/=
migration.c:1976
>     #4 0x7f15845f46c9 in start_thread (/lib64/libpthread.so.0+0x76c9)
>     #5 0x7f157d9d0f7e in clone (/lib64/libc.so.6+0x107f7e)
>=20
> 0x7f1556600000 is located 0 bytes to the right of 2097152-byte region [0x=
7f1556400000,0x7f1556600000)
> allocated by thread T0 here:
>     #0 0x7f159bb76980 in posix_memalign (/lib64/libasan.so.3+0xc7980)
>     #1 0x55b8eab185b2 in qemu_try_memalign /home/elmarco/src/qq/util/osli=
b-posix.c:106
>     #2 0x55b8eab186c8 in qemu_memalign /home/elmarco/src/qq/util/oslib-po=
six.c:122
>     #3 0x55b8e9d268a8 in spapr_reallocate_hpt /home/elmarco/src/qq/hw/ppc=
/spapr.c:1214
>     #4 0x55b8e9d26e04 in ppc_spapr_reset /home/elmarco/src/qq/hw/ppc/spap=
r.c:1261
>     #5 0x55b8ea12e913 in qemu_system_reset /home/elmarco/src/qq/vl.c:1697
>     #6 0x55b8ea13fa40 in main /home/elmarco/src/qq/vl.c:4679
>     #7 0x7f157d8e9400 in __libc_start_main (/lib64/libc.so.6+0x20400)
>=20
> Thread T6 created by T0 here:
>     #0 0x7f159bae0488 in __interceptor_pthread_create (/lib64/libasan.so.=
3+0x31488)
>     #1 0x55b8eab1d9cb in qemu_thread_create /home/elmarco/src/qq/util/qem=
u-thread-posix.c:465
>     #2 0x55b8ea67874c in migrate_fd_connect /home/elmarco/src/qq/migratio=
n/migration.c:2096
>     #3 0x55b8ea66cbb0 in migration_channel_connect /home/elmarco/src/qq/m=
igration/migration.c:500
>     #4 0x55b8ea678f38 in socket_outgoing_migration /home/elmarco/src/qq/m=
igration/socket.c:87
>     #5 0x55b8eaa5a03a in qio_task_complete /home/elmarco/src/qq/io/task.c=
:142
>     #6 0x55b8eaa599cc in gio_task_thread_result /home/elmarco/src/qq/io/t=
ask.c:88
>     #7 0x7f15823e38e6  (/lib64/libglib-2.0.so.0+0x468e6)
> SUMMARY: AddressSanitizer: heap-buffer-overflow /home/elmarco/src/qq/hw/p=
pc/spapr.c:1528 in htab_save_first_pass
>=20
> index seems to be wrongly incremented, unless I miss something that
> would be worth a comment.
>=20
> Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>

Oh my.  That's an impressively embarrassing bug.  As well as the
overrun itself, we're marking the wrong HPTEs clean.  I'm kind of
surprised we haven't seen this bite already.  Anyway, I've applied to
ppc-for-2.9, and I'll send a pull request ASAP.

> ---
>  hw/ppc/spapr.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 6ee566d658..63439811d5 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1524,16 +1524,16 @@ static void htab_save_first_pass(QEMUFile *f, sPA=
PRMachineState *spapr,
>          /* Consume invalid HPTEs */
>          while ((index < htabslots)
>                 && !HPTE_VALID(HPTE(spapr->htab, index))) {
> -            index++;
>              CLEAN_HPTE(HPTE(spapr->htab, index));
> +            index++;
>          }
> =20
>          /* Consume valid HPTEs */
>          chunkstart =3D index;
>          while ((index < htabslots) && (index - chunkstart < USHRT_MAX)
>                 && HPTE_VALID(HPTE(spapr->htab, index))) {
> -            index++;
>              CLEAN_HPTE(HPTE(spapr->htab, index));
> +            index++;
>          }
> =20
>          if (index > chunkstart) {

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--R92lf0Oi2sxyK3LA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY1IPkAAoJEGw4ysog2bOS7eAP/j+3YDJVwrJee8LbcKWBx80g
33QnN099NIWicifGBatw5iwDniXQvGCGINTAF5Zb3VpSJkXwFaPdTTxDrAxWeCj4
cT2Qg/Hqt/W/LkIAEuzR3jdvJwQyqUKiI45QeU5OGXyplCO59LEuFG25vDoUu4ay
t7/mWShfd3Yn3AtFSG6BtXsjFfCtQwrF4id69VvgB/l5po+muyuzPY4s3c9JnkHL
57CupQ1skaNHL//NGsG5g+k+DPerMcaOaqvnjO0HdvZhzU9ZpjltHOden4u8wqvQ
5ZnXO+2V05xkJ4IANObavWmJJXR1b1MVQq5C6kjwS13RyuJ+ouD+MvS8/LoSka8t
h1q4j2HgsT8651XtRSTT88qAuxAVHcOOq5JA7GqZCmVYnm3t+EOAfrJpod6CqNET
QhdYpX3y99LSra3nqIsEtisqFqgdKSskrR/zvVxmqXhzG3+1rUgH5nOv1PMwA2Z8
KbVZwnU/Ei68Jf+f7Na2ZQHSWV85YuDNn9lULLdHStxR1vPxunMvqWFgIuSeLVSV
S1SGYKP67FaHPO4hkaJSTA4s7lnhEvqP+wOU3ccg668P+Gd9ScUikd/JtuKlh5HP
UlCir66LpHVos0BdXTCHizJgHu0YBYYQzeyLwozaoZTQJHnEZ5mhFtfo1BhbGoDF
h4y6AgJqZ6HEoG7olIM2
=tYJA
-----END PGP SIGNATURE-----

--R92lf0Oi2sxyK3LA--
