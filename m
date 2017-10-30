Received: from eggs.gnu.org ([2001:4830:134:3::10]:43415)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1e95JK-0002vz-AT
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 04:20:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1e95JG-0006Vj-BR
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 04:20:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55938)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1e95JG-0006Tg-2F
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 04:20:38 -0400
Date: Mon, 30 Oct 2017 09:20:29 +0100
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20171030082029.GY2993@localhost.localdomain>
References: <20171030040056.11780-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20171030040056.11780-1-f4bug@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH] vl: only display available accelerators
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, qemu-devel@nongnu.org, "Emilio G . Cota" <cota@braap.org>, Eric Blake <eblake@redhat.com>, Richard Henderson <rth@twiddle.net>

On Mon, Oct 30, 2017 at 01:00:56AM -0300, Philippe Mathieu-Daud=E9 wrote:
> examples configuring with '--enable-kvm --disable-tcg'
>=20
> - before
>=20
>   $ qemu-system-x86_64 -accel help
>   Possible accelerators: kvm, xen, hax, tcg
>=20
>   $ qemu-system-x86_64 -accel tcg
>   qemu-system-x86_64: -machine accel=3Dtcg: No accelerator found
>=20
>   # qemu-system-x86_64 -accel hax
>   qemu-system-x86_64: -machine accel=3Dhax: No accelerator found
>=20
>   # qemu-system-x86_64 -accel xen
>   xencall: error: Could not obtain handle on privileged command interfa=
ce: No such file or directory
>   xen be core: xen be core: can't open xen interface
>   can't open xen interface
>   qemu-system-x86_64: failed to initialize Xen: Operation not permitted
>=20
> - after
>=20
>   $ qemu-system-x86_64 -accel help
>   Possible accelerators: kvm
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> ---
> RFC because:
>     - I don't think this is the nicest way, too much #ifdef'fery in mai=
n()

I suggest using object_class_get_list(TYPE_ACCEL, false).


>     - I'm not sure the correct use of CONFIG_KVM_IS_POSSIBLE
>     - shouldn't CONFIG_XEN/CONFIG_HAX be as poisoned as CONFIG_KVM?
>=20
>  vl.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
>=20
> diff --git a/vl.c b/vl.c
> index ec299099ff..13fce86a6e 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -3883,7 +3883,20 @@ int main(int argc, char **argv, char **envp)
>                                                       optarg, true);
>                  optarg =3D qemu_opt_get(accel_opts, "accel");
>                  if (!optarg || is_help_option(optarg)) {
> -                    error_printf("Possible accelerators: kvm, xen, hax=
, tcg\n");
> +                    error_printf("Possible accelerators: ");
> +#ifdef CONFIG_KVM_IS_POSSIBLE
> +                    error_printf("kvm ");
> +#endif
> +#ifdef CONFIG_XEN
> +                    error_printf("xen ");
> +#endif
> +#ifdef CONFIG_HAX
> +                    error_printf("hax ");
> +#endif
> +#ifdef CONFIG_TCG
> +                    error_printf("tcg ");
> +#endif
> +                    error_printf("\n");
>                      exit(0);
>                  }
>                  opts =3D qemu_opts_create(qemu_find_opts("machine"), N=
ULL,
> --=20
> 2.15.0.rc2
>=20

--=20
Eduardo
