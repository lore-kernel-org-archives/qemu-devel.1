Received: from eggs.gnu.org ([209.51.188.92]:43765)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hLzq4-0001Nm-49
	for qemu-devel@nongnu.org; Wed, 01 May 2019 20:44:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hLzpz-0002Wy-L7
	for qemu-devel@nongnu.org; Wed, 01 May 2019 20:44:37 -0400
Date: Thu, 2 May 2019 10:44:20 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190502004420.GD13618@umbus.fritz.box>
References: <20190501053522.10967-1-sjitindarsingh@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="OaZoDhBhXzo6bW1J"
Content-Disposition: inline
In-Reply-To: <20190501053522.10967-1-sjitindarsingh@gmail.com>
Subject: Re: [Qemu-devel] [PATCH 1/2] monitor: Add dump-stack command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com, armbru@redhat.com, qemu-ppc@nongnu.org


--OaZoDhBhXzo6bW1J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 01, 2019 at 03:35:21PM +1000, Suraj Jitindar Singh wrote:
> Add a monitor command "dump-stack" to be used to dump the stack for the
> current cpu.

So, you can already get guest backtraces by using the gdbstub
functionality.  I can see some benefit in allowing this more easily
through hmp, but whether it's worth the code size, I'm less certain.

>=20
> Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
> ---
>  hmp-commands.hx   | 13 +++++++++++++
>  hmp.h             |  1 +
>  include/qom/cpu.h | 10 ++++++++++
>  monitor.c         | 12 ++++++++++++
>  qom/cpu.c         | 10 ++++++++++
>  5 files changed, 46 insertions(+)
>=20
> diff --git a/hmp-commands.hx b/hmp-commands.hx
> index 9b4035965c..965ccdea28 100644
> --- a/hmp-commands.hx
> +++ b/hmp-commands.hx
> @@ -862,6 +862,19 @@ ETEXI
>      },
> =20
>  STEXI
> +@item dump-stack
> +@findex dump-stack
> +dump stack of the cpu
> +ETEXI
> +    {
> +        .name           =3D "dump-stack",
> +        .args_type      =3D "",
> +        .params         =3D "",
> +        .help           =3D "dump stack",
> +        .cmd            =3D hmp_dumpstack,
> +    },
> +
> +STEXI
>  @item pmemsave @var{addr} @var{size} @var{file}
>  @findex pmemsave
>  save to disk physical memory dump starting at @var{addr} of size @var{si=
ze}.
> diff --git a/hmp.h b/hmp.h
> index 43617f2646..e6edf1215c 100644
> --- a/hmp.h
> +++ b/hmp.h
> @@ -51,6 +51,7 @@ void hmp_announce_self(Monitor *mon, const QDict *qdict=
);
>  void hmp_cpu(Monitor *mon, const QDict *qdict);
>  void hmp_memsave(Monitor *mon, const QDict *qdict);
>  void hmp_pmemsave(Monitor *mon, const QDict *qdict);
> +void hmp_dumpstack(Monitor *mon, const QDict *qdict);
>  void hmp_ringbuf_write(Monitor *mon, const QDict *qdict);
>  void hmp_ringbuf_read(Monitor *mon, const QDict *qdict);
>  void hmp_cont(Monitor *mon, const QDict *qdict);
> diff --git a/include/qom/cpu.h b/include/qom/cpu.h
> index 08abcbd3fe..f2e83e9918 100644
> --- a/include/qom/cpu.h
> +++ b/include/qom/cpu.h
> @@ -181,6 +181,7 @@ typedef struct CPUClass {
>      int (*memory_rw_debug)(CPUState *cpu, vaddr addr,
>                             uint8_t *buf, int len, bool is_write);
>      void (*dump_state)(CPUState *cpu, FILE *, int flags);
> +    void (*dump_stack)(CPUState *cpu, FILE *f);
>      GuestPanicInformation* (*get_crash_info)(CPUState *cpu);
>      void (*dump_statistics)(CPUState *cpu, int flags);
>      int64_t (*get_arch_id)(CPUState *cpu);
> @@ -568,6 +569,15 @@ enum CPUDumpFlags {
>  void cpu_dump_state(CPUState *cpu, FILE *f, int flags);
> =20
>  /**
> + * cpu_dump_stack:
> + * @cpu: The CPU whose stack is to be dumped.
> + * @f: If non-null, dump to this stream, else to current print sink.
> + *
> + * Dumps CPU stack.
> + */
> +void cpu_dump_stack(CPUState *cpu, FILE *f);
> +
> +/**
>   * cpu_dump_statistics:
>   * @cpu: The CPU whose state is to be dumped.
>   * @flags: Flags what to dump.
> diff --git a/monitor.c b/monitor.c
> index 9b5f10b475..dbec2e4376 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -1299,6 +1299,18 @@ static void hmp_info_registers(Monitor *mon, const=
 QDict *qdict)
>      }
>  }
> =20
> +void hmp_dumpstack(Monitor *mon, const QDict *qdict)
> +{
> +    CPUState *cs =3D mon_get_cpu();
> +
> +    if (!cs) {
> +        monitor_printf(mon, "No CPU available\n");
> +        return;
> +    }
> +
> +    cpu_dump_stack(cs, NULL);
> +}
> +
>  #ifdef CONFIG_TCG
>  static void hmp_info_jit(Monitor *mon, const QDict *qdict)
>  {
> diff --git a/qom/cpu.c b/qom/cpu.c
> index 3c5493c96c..0dc10004f4 100644
> --- a/qom/cpu.c
> +++ b/qom/cpu.c
> @@ -230,6 +230,16 @@ void cpu_dump_state(CPUState *cpu, FILE *f, int flag=
s)
>      }
>  }
> =20
> +void cpu_dump_stack(CPUState *cpu, FILE *f)
> +{
> +    CPUClass *cc =3D CPU_GET_CLASS(cpu);
> +
> +    if (cc->dump_stack) {
> +        cpu_synchronize_state(cpu);
> +        cc->dump_stack(cpu, f);
> +    }
> +}
> +
>  void cpu_dump_statistics(CPUState *cpu, int flags)
>  {
>      CPUClass *cc =3D CPU_GET_CLASS(cpu);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--OaZoDhBhXzo6bW1J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlzKPWQACgkQbDjKyiDZ
s5IkLg/9GyxlE5aFYtX3kdgpIF/uizBO5vkD3eqUIWSqlQ/GKE3IY+LQT/rqedJf
dtu00yNFNBbev9PZVyjtXbBrxPva6m8GpP7TlRo7TDkVVhb+St+X+L7ybhAjKbz0
UC9fBw6oC8cUsqbp4FhLcTe/apEbEOhgXI0GPUYoBWnkTseX+lnh6vweU6EnOAWV
oBPFDeZ2OKjibkljptkFpSnNl3h61HVhP6iKl3r9vH5KfDbTkBM1qsJd741Yl3Qn
KmujU7zfeDKAhFoK9HYKCQlrFtYGjm3CmABSOrlk6jGMUHmK+W7Q5sncV+DK/wT1
9C4SAXTvJj686KG+BfO0KilTpd62z1/Y2MjlZIrOvZjGcOMxzqvJNTtuELdpB4nQ
NXqGd9dFsMQfdq2lc5OJcl2AMNgGI/AQrMCSMiYmSw5agLswdjo2hd84LnYUSCa3
lzGc01dvT2iF3D5UesGSYMZ4WvTtBmlsqQ8LVESsvRXhdpk+wHc2iNgT3Had5Pgc
J3kpEsy/YLQxWFzBqgwnkzCnwuheg9xOWdh11GP5rGmPbj9Plq5tmgX7fLc7PFEx
jP6pH6BAWtWtXja4I3y9h4cclji3yeLCdx/hXISTairajZEdJAy1OqDCEzFuZ7cR
xCBureNtyWWxvy3Nb+H5gzP3cwvJ1S6dykHuJigz/IYnjtxV0as=
=na/l
-----END PGP SIGNATURE-----

--OaZoDhBhXzo6bW1J--
