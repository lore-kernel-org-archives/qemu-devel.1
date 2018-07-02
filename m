Received: from eggs.gnu.org ([2001:4830:134:3::10]:35472)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fa2Gb-0004L2-Fi
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 13:05:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fa2GX-0000kJ-GG
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 13:05:33 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41804 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fa2GX-0000jc-AF
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 13:05:29 -0400
Date: Mon, 2 Jul 2018 18:05:24 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180702170524.GE6438@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <153055056654.212317.4697363278304826913.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <153055056654.212317.4697363278304826913.stgit@bahia.lan>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] i386: fix '-cpu ?' output for host cpu type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Richard Henderson <rth@twiddle.net>

On Mon, Jul 02, 2018 at 06:56:06PM +0200, Greg Kurz wrote:
> Since commit d6dcc5583e7, '-cpu ?' shows the description of the
> X86_CPU_TYPE_NAME("max") for the host CPU model:
>=20
> Enables all features supported by the accelerator in the current host
>=20
> instead of the expected:
>=20
> KVM processor with all supported host features
>=20
> or
>=20
> HVF processor with all supported host features
>=20
> This is caused by the early use of kvm_enabled() and hvf_enabled() in
> a class_init function. Since the accelerator isn't configured yet, both
> helpers return false unconditionally.
>=20
> A QEMU binary will only be compiled with one of these accelerators, not
> both. The appropriate description can thus be decided at build time.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  target/i386/cpu.c |   14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>=20
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 1e6a7d0a7504..e5da60b28973 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -2838,13 +2838,13 @@ static void host_x86_cpu_class_init(ObjectClass=
 *oc, void *data)

Sigh, yet another case of relying on runtime state during class_init impl=
s.

>      xcc->host_cpuid_required =3D true;
>      xcc->ordering =3D 8;
> =20
> -    if (kvm_enabled()) {
> -        xcc->model_description =3D
> -            "KVM processor with all supported host features ";
> -    } else if (hvf_enabled()) {
> -        xcc->model_description =3D
> -            "HVF processor with all supported host features ";
> -    }
> +#if defined(CONFIG_KVM)
> +    xcc->model_description =3D
> +        "KVM processor with all supported host features ";
> +#elif defined(CONFIG_HVF)
> +    xcc->model_description =3D
> +        "HVF processor with all supported host features ";
> +#endif
>  }
> =20
>  static const TypeInfo host_x86_cpu_type_info =3D {

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
