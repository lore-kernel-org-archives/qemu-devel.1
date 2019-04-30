Received: from eggs.gnu.org ([209.51.188.92]:35819)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hLXx5-00038Q-7Q
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 14:58:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hLXmQ-0005oe-Ue
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 14:47:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34312)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hLXmQ-0005oH-Mj
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 14:47:02 -0400
References: <20190429134757.13570-1-marcandre.lureau@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <fa741bc2-4239-2dc9-ff8b-ca4ea9f5d416@redhat.com>
Date: Tue, 30 Apr 2019 20:46:51 +0200
MIME-Version: 1.0
In-Reply-To: <20190429134757.13570-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] vl: fix -sandbox parsing crash when
 seccomp support is disabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: david@gibson.dropbear.id.au, otubo@redhat.com

On 29/04/19 15:47, Marc-Andr=C3=A9 Lureau wrote:
> $ ./x86_64-softmmu/qemu-system-x86_64 -sandbox off
> qemu-system-x86_64: -sandbox off: There is no option group 'sandbox'
> Segmentation fault
>=20
> Commit 5780760f5e ("seccomp: check TSYNC host capability") wrapped one
> use of the sandbox option group to produce a sensible error, it didn't
> do the same for another call to qemu_opts_parse_noisily():
>=20
> (gdb) bt
>     at util/qemu-option.c:829
>  #0  0x00000000105b36d8 in opts_parse (list=3D0x0, params=3D0x3ffffffff=
ab5 "off", permit_abbrev=3Dtrue, defaults=3Dfalse, errp=3D0x3ffffffff080)
>      at util/qemu-option.c:829
>  #1  0x00000000105b3b74 in qemu_opts_parse_noisily (list=3D<optimized o=
ut>, params=3D<optimized out>, permit_abbrev=3D<optimized out>) at util/q=
emu-option.c:890
>  #2  0x0000000010024964 in main (argc=3D<optimized out>, argv=3D<optimi=
zed out>, envp=3D<optimized out>) at vl.c:3589
>=20
> Fixes: 5780760f5ea6163939a5dabe7427318b4f07d1a2
> Cc: david@gibson.dropbear.id.au
> Cc: otubo@redhat.com
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  vl.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
>=20
> diff --git a/vl.c b/vl.c
> index 4019a4387d..5fc4994d3c 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -3866,17 +3866,19 @@ int main(int argc, char **argv, char **envp)
>                  qtest_log =3D optarg;
>                  break;
>              case QEMU_OPTION_sandbox:
> -#ifdef CONFIG_SECCOMP
> -                opts =3D qemu_opts_parse_noisily(qemu_find_opts("sandb=
ox"),
> -                                               optarg, true);
> +                olist =3D qemu_find_opts("sandbox");
> +                if (!olist) {
> +#ifndef CONFIG_SECCOMP
> +                    error_report("-sandbox support is not enabled "
> +                                 "in this QEMU binary");
> +#endif
> +                    exit(1);
> +                }
> +
> +                opts =3D qemu_opts_parse_noisily(olist, optarg, true);
>                  if (!opts) {
>                      exit(1);
>                  }
> -#else
> -                error_report("-sandbox support is not enabled "
> -                             "in this QEMU binary");
> -                exit(1);
> -#endif
>                  break;
>              case QEMU_OPTION_add_fd:
>  #ifndef _WIN32
>=20

Queued, thanks.

Paolo
