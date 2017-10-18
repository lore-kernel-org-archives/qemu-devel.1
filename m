Received: from eggs.gnu.org ([2001:4830:134:3::10]:54452)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e4gKw-0001Xx-7a
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 00:52:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e4gKv-0007rz-3r
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 00:52:10 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:43057)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1e4gKu-0007pb-GH
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 00:52:09 -0400
Date: Wed, 18 Oct 2017 14:27:32 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171018032732.GO2776@umbus.fritz.box>
References: <1508170976-96869-1-git-send-email-imammedo@redhat.com>
	<1508170976-96869-3-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3mUD2hqWbnBptYHy"
Content-Disposition: inline
In-Reply-To: <1508170976-96869-3-git-send-email-imammedo@redhat.com>
Subject: Re: [Qemu-devel] [RFC 2/6] numa: split out NumaOptions parsing into
 parse_NumaOptions()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, eblake@redhat.com, armbru@redhat.com, ehabkost@redhat.com, pkrempa@redhat.com, peter.maydell@linaro.org, pbonzini@redhat.com, cohuck@redhat.com


--3mUD2hqWbnBptYHy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 16, 2017 at 06:22:52PM +0200, Igor Mammedov wrote:
> it will allow to reuse parse_NumaOptions() for parsing
> configuration commands received via QMP interface
>=20
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Revieed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  include/sysemu/numa.h |  1 +
>  numa.c                | 48 +++++++++++++++++++++++++++++----------------=
---
>  2 files changed, 30 insertions(+), 19 deletions(-)
>=20
> diff --git a/include/sysemu/numa.h b/include/sysemu/numa.h
> index c19e456..aad4230 100644
> --- a/include/sysemu/numa.h
> +++ b/include/sysemu/numa.h
> @@ -30,6 +30,7 @@ struct NumaNodeMem {
>  };
> =20
>  extern NodeInfo numa_info[MAX_NODES];
> +int parse_numa(void *opaque, QemuOpts *opts, Error **errp);
>  void parse_numa_opts(MachineState *ms);
>  void numa_complete_configuration(MachineState *ms);
>  void query_numa_node_mem(NumaNodeMem node_mem[]);
> diff --git a/numa.c b/numa.c
> index 18af4ff..d8e7dc0 100644
> --- a/numa.c
> +++ b/numa.c
> @@ -254,28 +254,11 @@ static void parse_numa_distance(NumaDistOptions *di=
st, Error **errp)
>      have_numa_distance =3D true;
>  }
> =20
> -static int parse_numa(void *opaque, QemuOpts *opts, Error **errp)
> +static
> +void parse_NumaOptions(MachineState *ms, NumaOptions *object, Error **er=
rp)
>  {
> -    NumaOptions *object =3D NULL;
> -    MachineState *ms =3D opaque;
>      Error *err =3D NULL;
> =20
> -    {
> -        Visitor *v =3D opts_visitor_new(opts);
> -        visit_type_NumaOptions(v, NULL, &object, &err);
> -        visit_free(v);
> -    }
> -
> -    if (err) {
> -        goto end;
> -    }
> -
> -    /* Fix up legacy suffix-less format */
> -    if ((object->type =3D=3D NUMA_OPTIONS_TYPE_NODE) && object->u.node.h=
as_mem) {
> -        const char *mem_str =3D qemu_opt_get(opts, "mem");
> -        qemu_strtosz_MiB(mem_str, NULL, &object->u.node.mem);
> -    }
> -
>      switch (object->type) {
>      case NUMA_OPTIONS_TYPE_NODE:
>          parse_numa_node(ms, &object->u.node, &err);
> @@ -310,6 +293,33 @@ static int parse_numa(void *opaque, QemuOpts *opts, =
Error **errp)
>      }
> =20
>  end:
> +    if (err) {
> +        error_propagate(errp, err);
> +    }
> +}
> +
> +int parse_numa(void *opaque, QemuOpts *opts, Error **errp)
> +{
> +    NumaOptions *object =3D NULL;
> +    MachineState *ms =3D MACHINE(opaque);
> +    Error *err =3D NULL;
> +    Visitor *v =3D opts_visitor_new(opts);
> +
> +    visit_type_NumaOptions(v, NULL, &object, &err);
> +    visit_free(v);
> +    if (err) {
> +        goto end;
> +    }
> +
> +    /* Fix up legacy suffix-less format */
> +    if ((object->type =3D=3D NUMA_OPTIONS_TYPE_NODE) && object->u.node.h=
as_mem) {
> +        const char *mem_str =3D qemu_opt_get(opts, "mem");
> +        qemu_strtosz_MiB(mem_str, NULL, &object->u.node.mem);
> +    }
> +
> +    parse_NumaOptions(ms, object, &err);
> +
> +end:
>      qapi_free_NumaOptions(object);
>      if (err) {
>          error_report_err(err);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--3mUD2hqWbnBptYHy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnmyiMACgkQbDjKyiDZ
s5KGRg/9HuUypmZZhRpGCK3VaWPl5/NzKPEioHKcDPXtQoPUhBt1F7NzDzhWtTXH
OS8zNdCASoggvrp90dDBBDz9blcvtrZ32lJFQ0hT2jxapEYzZbMeRT6HuqoXXv+L
Myoi+VaHRAnItXDwvcu/lxZkA2J/TisOh931wTGVUAtWaPC43hkcBiHuRitp69wa
OW0HionpGsiNsRjXG3dACMppPK+o5TWqeium4DAtYJfVNWsA0Tk6zF0mTGZpajmK
XkMNdGS/01E6MiiHCUk/d0ZwHl2xJSQtHiIHDTJLs4vD0ealadm8G81K/50+UgCv
E6M9xfyQ/vSgk5ZEzKiHXnaWWIiPqDMkAXtL0XMTYfg0xDhWduuL2Cs/+s0LhvCc
5lDmx5OvkkLIEl81/fc6CyPNTfrnqIv4YMLrP66GLtwGfNTFmucztRbsYc9WUP0s
S+bBsiX9Lh+vnVTSzSvMwfRq+F0m+wn2hDIGB0BEdAQXX4RsvnMuGUDqugkdKdW8
Qyog0oLqVf/swxSCWC8QIzCQO4B6f/1GCJKBQAnt3dxKW2dmzPGs3A90nFLuw3tF
QsEiRFjjoHGFkbF9MXr3QqpBJ3XRii18XE71Mvi4SyxKBxtwmrDeaNfG47bEsCCr
RvPJxGKb+kGKpEdJ9StO/m/S5XSd27o10eC2P2x4/gLTRyMxClE=
=CkiQ
-----END PGP SIGNATURE-----

--3mUD2hqWbnBptYHy--
