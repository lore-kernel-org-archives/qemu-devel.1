Received: from eggs.gnu.org ([2001:4830:134:3::10]:46945)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fd6dZ-00033g-Gy
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 00:21:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fd6dW-0005Zj-3R
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 00:21:57 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180710160013.26559-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <66872d46-25b1-aa14-407d-359bae14815b@amsat.org>
Date: Wed, 11 Jul 2018 01:21:42 -0300
MIME-Version: 1.0
In-Reply-To: <20180710160013.26559-1-peter.maydell@linaro.org>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="7iXd5OUCR8EljSz8HAUISLZPLVDjWCakp"
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 0/6] accel/tcg: Support
 execution from MMIO and small MMU regions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, KONRAD Frederic <frederic.konrad@adacore.com>, "Emilio G . Cota" <cota@braap.org>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Aleksandar Markovic <aleksandar.markovic@rt-rk.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7iXd5OUCR8EljSz8HAUISLZPLVDjWCakp
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: patches@linaro.org, KONRAD Frederic <frederic.konrad@adacore.com>,
 "Emilio G . Cota" <cota@braap.org>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?=
 <clg@kaod.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>,
 Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Message-ID: <66872d46-25b1-aa14-407d-359bae14815b@amsat.org>
Subject: Re: [Qemu-arm] [PATCH 0/6] accel/tcg: Support execution from MMIO and
 small MMU regions
References: <20180710160013.26559-1-peter.maydell@linaro.org>
In-Reply-To: <20180710160013.26559-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Peter,

On 07/10/2018 01:00 PM, Peter Maydell wrote:
> This series adds support to TCG for executing from MMIO regions
> and small MMU regions. The basic principle is that if get_page_addr_cod=
e()
> finds that the region is not backed by a full page of RAM then it
> returns -1, and tb_gen_code() then generates a non-cached TB
> containing a single instruction. Execution from these regions
> thus performs the instruction fetch every time, ensuring that we
> get the read-from-MMIO and check-small-MMU-region permissions
> checks right.
>=20
> This means that the code path for "generate bus fault for failing
> to load an instruction" no longer goes through get_page_addr_code(),
> but instead via each target's translate code and its calls to
> the cpu_ld*_code() or similar functions. Patch 1 makes sure we
> can distinguish insn fetches from data loads when generating the
> bus fault exceptions. (Aside: I have assumed that all cpu_ld*_code()
> loads should trigger iside faults rather than dside. Hopefully this
> is true...)
>=20
> Patches 2 and 3 make trivial fixes to various callers of
> get_page_addr_code(); patch 4 does the work of generating our
> single-insn TBs. Patch 5 can then remove all the code that
> (mis)handles MMIO regions from get_page_addr_code(). Finally
> patch 6 drops the target/arm workarounds for not having support
> for executing from small MPU regions.
>=20
> Note for the Xilinx folks: this patchset makes the mmio-exec
> testcase for running from the SPI flash pass. Cedric: you might
> like to test the aspeed image you had that relies on execution
> from an MMIO region too.

I applied and quickly tested your series on a MIPS SoC I'm working on
which has a tiny SRAM:

(qemu) info mtree
address-space: memory
  0000000000000000-ffffffffffffffff (prio 0, i/o): system
    0000000000000000-00000000000007ff (prio 0, ram): sram
    0000000010000000-00000000107fffff (prio 0, i/o): pflash
    0000000014000000-0000000014ffffff (prio 0, ram): dram
    000000001fc00000-000000001fc0ffff (prio 0, rom): srom

The firmware copies the ISR in this SRAM area, sadly it didn't work as
expected:

qemu-system-mips: Bad ram pointer 0x4a4
Aborted (core dumped)
(gdb) bt
#0  0x00007f5f34d84e7b in __GI_raise (sig=3Dsig@entry=3D6) at
=2E./sysdeps/unix/sysv/linux/raise.c:51
#1  0x00007f5f34d86231 in __GI_abort () at abort.c:79
#2  0x000055f4527a2074 in qemu_ram_addr_from_host_nofail (ptr=3D0x4a4) at=

accel/tcg/cputlb.c:751
#3  0x000055f4527a2887 in get_page_addr_code (env=3D0x55f454d06728,
addr=3D2415932580) at accel/tcg/cputlb.c:966
#4  0x000055f4527bd206 in tb_htable_lookup (cpu=3D0x55f454cfe478,
pc=3D2415932580, cs_base=3D0, flags=3D268435472, cf_mask=3D0) at
accel/tcg/cpu-exec.c:334
#5  0x000055f4527b7b31 in tb_lookup__cpu_state (cpu=3D0x55f454cfe478,
pc=3D0x7f5f17cf7f98, cs_base=3D0x7f5f17cf7f9c, flags=3D0x7f5f17cf7f94,
cf_mask=3D0) at include/exec/tb-lookup.h:39
#6  0x000055f4527b7e29 in helper_lookup_tb_ptr (env=3D0x55f454d06728) at
accel/tcg/tcg-runtime.c:154
#7  0x00007f5f2494da2d in code_gen_buffer ()
#8  0x000055f4527bcd33 in cpu_tb_exec (cpu=3D0x55f454cfe478,
itb=3D0x7f5f2494d880 <code_gen_buffer+129107>) at accel/tcg/cpu-exec.c:17=
1
#9  0x000055f4527bda6a in cpu_loop_exec_tb (cpu=3D0x55f454cfe478,
tb=3D0x7f5f2494d880 <code_gen_buffer+129107>, last_tb=3D0x7f5f17cf8538,
tb_exit=3D0x7f5f17cf8534) at accel/tcg/cpu-exec.c:615
#10 0x000055f4527bdd57 in cpu_exec (cpu=3D0x55f454cfe478) at
accel/tcg/cpu-exec.c:725
#11 0x000055f452770575 in tcg_cpu_exec (cpu=3D0x55f454cfe478) at cpus.c:1=
363
#12 0x000055f4527707cb in qemu_tcg_rr_cpu_thread_fn (arg=3D0x55f454cfe478=
)
at cpus.c:1463
#13 0x000055f452c58a4b in qemu_thread_start (args=3D0x55f454d2afc0) at
util/qemu-thread-posix.c:504
#14 0x00007f5f351115aa in start_thread (arg=3D0x7f5f17cfb700) at
pthread_create.c:463
#15 0x00007f5f34e46cbf in clone () at
=2E./sysdeps/unix/sysv/linux/x86_64/clone.S:95

This firmware works using the "avoid subpages" trick, allocating 4K for
the SRAM (TARGET_PAGE_SIZE).

I didn't look further, maybe I need to figure out how to add a
"target/mips: Allow execution from small regions" too.

Regards,

Phil.

> The diffstat is pretty satisfying for a patchset that adds
> a feature, but it actually undersells it: this code renders the
> hw/misc/mmio_interface.c and the mmio_ptr related code in memory.c
> and the xilinx-spips device all obsolete, so there are another
> couple of hundred lines of code to be deleted there. I opted not
> to include that in this patchset, for ease of review.
>=20
> NB: I tested this with icount, but there are potentially
> some weird things that could happen with interactions between
> icount's io-recompile and execution from an MMIO device
> that returns different instructions each time it's read.


--7iXd5OUCR8EljSz8HAUISLZPLVDjWCakp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+qvnXhKRciHc/Wuy4+MsLN6twN4FAltFhdYACgkQ4+MsLN6t
wN5ONhAAk5ZiI69ZoC6eB5OEoRR2A02+w00ZpQ8ZlwvDv8GcMoPq8Kr9WQP6tGit
smt3jwVf1F4tzAgqK8z4Nrmvi+zyxV3Drwls0vVgStfPaCzeQLwMNhxEZJoyOQsB
pIEU2i82ULjIQvZGfRqYBwBTzTsluDAdeoUH4z9k9cNBKgbDCXJ90O8xZZ7X5EMH
iKmjyUG3e8bg8ua+gj7IGpmRGgv6VitLEgsFGgmw6nh7ShDnjoeBeZj97g0Dwq3l
u7c3timszy8QHNeFaJroPxfYwXWNoZeewYGmYbsYJly+fhxqN9D+1JEebm5Yaju5
uYpeSr59O6ql4/Fzgw1IO7QqkD4Ohkz9nYoz2DTnyjcNAhkjCAXM0cQ06uT9LQ0n
DV6pPri25BQKoDJQjqLJaVoHbw8b/oNtVOnR6YwfigsBNIVdNOwg9iX6k46+44Uh
RmPj3/It2F36E9OOrPoslkSquHw3qmE6L/qFSN5EhoNP9p2DjJUUxtRVUB9x1BDX
Lv4YMHLgbmF/X5fNwiFss/yB2snj7VHaMx4Lqb6TV7zteQmeO+XktqPNAp9F0FtO
gWGUdVxhnZLoFjOgSgbOKheObDDqOMz0jnsEWbG3KjR+mJpLmsDYPYke/0R5g0av
iQ+K0iUoq0kmkPilQR9q66353GgWxN/zKb9mi5XQMzVrNjvce/s=
=F60/
-----END PGP SIGNATURE-----

--7iXd5OUCR8EljSz8HAUISLZPLVDjWCakp--
