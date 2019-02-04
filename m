Received: from eggs.gnu.org ([209.51.188.92]:59492)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gqbJ4-0003GR-Q2
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 05:16:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gqbJ3-0004qs-JT
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 05:16:50 -0500
Date: Mon, 4 Feb 2019 10:16:42 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190204101642.GD1905@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190201185358.6972-1-ppandit@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190201185358.6972-1-ppandit@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] ppc: add host-serial and host-model
 machine attributes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: P J P <ppandit@redhat.com>
Cc: Qemu Developers <qemu-devel@nongnu.org>, David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org, Prasad J Pandit <pjp@fedoraproject.org>

On Sat, Feb 02, 2019 at 12:23:58AM +0530, P J P wrote:
> From: Prasad J Pandit <pjp@fedoraproject.org>
>=20
> On ppc hosts, hypervisor shares following system attributes
>=20
>   - /proc/device-tree/system-id
>   - /proc/device-tree/model
>=20
> with a guest. This could lead to information leakage and misuse.[*]
> Add machine attributes to control such system information exposure
> to a guest.
>=20
> [*] https://wiki.openstack.org/wiki/OSSN/OSSN-0028
>=20
> Reported-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Fix-suggested-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>


> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 0942f35bf8..b497fe1701 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1249,11 +1249,34 @@ static void *spapr_build_fdt(sPAPRMachineState =
*spapr,
>       * Add info to guest to indentify which host is it being run on
>       * and what is the uuid of the guest
>       */
> -    if (kvmppc_get_host_model(&buf)) {
> +    if (machine->host_model && !strcmp(machine->host_model, "none")) {
> +        /* -M host-model=3Dnone =3D do not set host-model */
> +    } else if (machine->host_model
> +        && !strcmp(machine->host_model, "passthrough")) {
> +        /* -M host-model=3Dpassthrough */
> +        _FDT(fdt_setprop_string(fdt, 0, "host-model", buf));

buf hasn't been initialized

> +        g_free(buf);
> +    } else if (machine->host_model) {
> +        /* -M host-model=3D<user-string> */
> +        _FDT(fdt_setprop_string(fdt, 0, "host-model", machine->host_mo=
del));
> +    } else if (kvmppc_get_host_model(&buf)) {
> +        /* -M host-model=3Dxxx attribute not supplied */
>          _FDT(fdt_setprop_string(fdt, 0, "host-model", buf));
>          g_free(buf);
>      }

This structure for the conditionals is a bit unreadable IMHO. It would
be better as a nested if

     if (machine->host_model && !g_str_equal(machine->host_model, "none")=
) {
         if (g_str_equal(machine->host_model, "passthrough") {
      	     if (!kvmppc_get_host_model(&buf)) {
	         ... report error...
             }
	    _FDT(fdt_setprop_string(fdt, 0, "host-model", buf));
	    g_free(buf);
	 } else {
	    _FDT(fdt_setprop_string(fdt, 0, "host-model", machine->host_model));
	 }
     }



> -    if (kvmppc_get_host_serial(&buf)) {
> +
> +    if (machine->host_serial && !strcmp(machine->host_serial, "none"))=
 {
> +        /* -M host-serial=3Dnone =3D do not set host-serial */
> +    } else if (machine->host_serial
> +        && !strcmp(machine->host_serial, "passthrough")) {
> +        /* -M host-serial=3Dpassthrough */
> +        _FDT(fdt_setprop_string(fdt, 0, "host-serial", buf));
> +        g_free(buf);
> +    } else if (machine->host_serial) {
> +        /* -M host-serial=3D<user-string> */
> +        _FDT(fdt_setprop_string(fdt, 0, "host-serial", machine->host_s=
erial));
> +    } else if (kvmppc_get_host_serial(&buf)) {
> +        /* -M host-serial=3Dxxx attribute not supplied */
>          _FDT(fdt_setprop_string(fdt, 0, "host-serial", buf));
>          g_free(buf);
>      }

Same comment for this block.


There's missing logic to set host-model=3Dpassthrough for existing machin=
e
types too.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
