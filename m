Received: from eggs.gnu.org ([2001:4830:134:3::10]:36803)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gEyhd-0006fR-Kk
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 11:34:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gEybR-0006gD-PS
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 11:28:20 -0400
Date: Tue, 23 Oct 2018 16:07:30 +0100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181023150730.GC12127@umbus.hotspot.internet-for-guests.com>
References: <20181018200422.4358-1-ehabkost@redhat.com>
	<20181018200422.4358-5-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ABTtc+pdwF7KHXCz"
Content-Disposition: inline
In-Reply-To: <20181018200422.4358-5-ehabkost@redhat.com>
Subject: Re: [Qemu-devel] [PULL 04/45] numa: Fix QMP command set-numa-node
 error handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@suse.de>, Rob Herring <robh@kernel.org>, libvir-list@redhat.com, Richard Henderson <rth@twiddle.net>, Eric Blake <eblake@redhat.com>, Igor Mammedov <imammedo@redhat.com>, qemu-arm@nongnu.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Markus Armbruster <armbru@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Michael Walle <michael@walle.cc>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>, Alistair Francis <alistair@alistair23.me>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, qemu-ppc@nongnu.org, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>


--ABTtc+pdwF7KHXCz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 18, 2018 at 05:03:41PM -0300, Eduardo Habkost wrote:
> From: Markus Armbruster <armbru@redhat.com>
>=20
> Calling error_report() in a function that takes an Error ** argument
> is suspicious.  parse_numa_node() does that, and then exit()s.  It
> also passes &error_fatal to machine_set_cpu_numa_node().  Both wrong.
> Attempting to configure numa when the machine doesn't support it kills
> the VM:
>=20
>     $ qemu-system-x86_64 -nodefaults -S -display none -M none -preconfig =
-qmp stdio
>     {"QMP": {"version": {"qemu": {"micro": 50, "minor": 0, "major": 3}, "=
package": "v3.0.0-837-gc5e4e49258"}, "capabilities": []}}
>     {"execute": "qmp_capabilities"}
>     {"return": {}}
>     {"execute": "set-numa-node", "arguments": {"type": "node"}}
>     NUMA is not supported by this machine-type
>     $ echo $?
>     1
>=20
> Messed up when commit 64c2a8f6d3f and 7c88e65d9e9 (v2.10.0) added
> incorrect error handling right next to correct examples.  Latent bug
> until commit f3be67812c2 (v3.0.0) made it accessible via QMP.  Fairly
> harmless in practice, because it's limited to RUN_STATE_PRECONFIG.
> The fix is obvious: replace error_report(); exit() by error_setg();
> return.
>=20
> This affects parse_numa_node()'s other caller
> numa_complete_configuration(): since it ignores errors, the "NUMA is
> not supported by this machine-type" is now ignored, too.  But that
> error is as unexpected there as any other.  Change it to abort on
> error instead.
>=20
> Fixes: f3be67812c226162f86ce92634bd913714445420
> Cc: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Message-Id: <20181008173125.19678-15-armbru@redhat.com>
> Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  numa.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>=20
> diff --git a/numa.c b/numa.c
> index 81542d4ebb..1d7c49ad43 100644
> --- a/numa.c
> +++ b/numa.c
> @@ -60,6 +60,7 @@ NodeInfo numa_info[MAX_NODES];
>  static void parse_numa_node(MachineState *ms, NumaNodeOptions *node,
>                              Error **errp)
>  {
> +    Error *err =3D NULL;
>      uint16_t nodenr;
>      uint16List *cpus =3D NULL;
>      MachineClass *mc =3D MACHINE_GET_CLASS(ms);
> @@ -82,8 +83,8 @@ static void parse_numa_node(MachineState *ms, NumaNodeO=
ptions *node,
>      }
> =20
>      if (!mc->cpu_index_to_instance_props || !mc->get_default_cpu_node_id=
) {
> -        error_report("NUMA is not supported by this machine-type");
> -        exit(1);
> +        error_setg(errp, "NUMA is not supported by this machine-type");
> +        return;
>      }
>      for (cpus =3D node->cpus; cpus; cpus =3D cpus->next) {
>          CpuInstanceProperties props;
> @@ -97,7 +98,11 @@ static void parse_numa_node(MachineState *ms, NumaNode=
Options *node,
>          props =3D mc->cpu_index_to_instance_props(ms, cpus->value);
>          props.node_id =3D nodenr;
>          props.has_node_id =3D true;
> -        machine_set_cpu_numa_node(ms, &props, &error_fatal);
> +        machine_set_cpu_numa_node(ms, &props, &err);
> +        if (err) {
> +            error_propagate(errp, err);
> +            return;
> +        }
>      }
> =20
>      if (node->has_mem && node->has_memdev) {
> @@ -367,7 +372,7 @@ void numa_complete_configuration(MachineState *ms)
>      if (ms->ram_slots > 0 && nb_numa_nodes =3D=3D 0 &&
>          mc->auto_enable_numa_with_memhp) {
>              NumaNodeOptions node =3D { };
> -            parse_numa_node(ms, &node, NULL);
> +            parse_numa_node(ms, &node, &error_abort);
>      }
> =20
>      assert(max_numa_nodeid <=3D MAX_NODES);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ABTtc+pdwF7KHXCz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIyBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlvPOTEACgkQbDjKyiDZ
s5Kkfg/1F7EiKb6PzQLitWENFPMhvZYtuMoM8Qzjjm/c7n/Gyq9u3u46R46966sz
WBpeS2iZUEHV9omRjt+lvvLSkfLXakVHg0FJUNEahJfkI7FfTtNKMcOYOwIdMBod
8rce7miZBDkMbiLpG2/1WSb94vdAgV4JDvp5362AIdDyALJoe7LgIIruYKIdiUgw
36llXm4ttdJcUAcAAU4H81Q6jGYWvE/YsU3fFWjfQn0mcBt7R0oWEFR1rrD8LnMa
IN+TG62MZA+ENbYtbiLIQAMZP+TsMHbufLKeipHAm3P0yi9SXUQYIIfbg8ckXfn9
4p3xR1QQbUUonczrGvU00Zu+V9Ywv/xEYmHtKRYEKRxed90dF7uz8fjP6vG1Hgzz
NEyEMsa2qMwcXH8yT887pxl7Negb2TszYpSRCD0iqzkpLe4ceVT1eDEMeXkWqJec
WJETZjY/O+GiqCS3OQ/C69XJPsVY3PIqr9ypgBccatMj781RT1UZXZWWz78ikQCh
ww4rPpDL/iVujaRUnKAHXsh5zXrq9WkI39GXUw/pAxXgEJOw13+1eztgyJGB6FR8
M1hQR7K/+DrLueTh/k+j6ug1BDHuO7DI5i7SxhcJu1Hsi9y1iMIaPQ1/C+FhdAjz
G079KAhmc3NuQ4g7TeefI5NiJch9pZEiDK6ga3UvDH4sJ8xwaw==
=mhXp
-----END PGP SIGNATURE-----

--ABTtc+pdwF7KHXCz--
