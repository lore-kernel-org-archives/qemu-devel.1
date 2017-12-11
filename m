Received: from eggs.gnu.org ([2001:4830:134:3::10]:47827)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1eOW0l-0004Vj-4B
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 16:53:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1eOW0j-0000j4-UL
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 16:53:19 -0500
Received: from hera.aquilenet.fr ([2a0c:e300::1]:39086)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1eOW0j-0000dw-Ht
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 16:53:17 -0500
Date: Mon, 11 Dec 2017 22:53:13 +0100
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20171211215313.vjjgnlxffp5oznmm@var.youpi.perso.aquilenet.fr>
References: <1512669755-8409-1-git-send-email-thuth@redhat.com>
	<1512669755-8409-2-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1512669755-8409-2-git-send-email-thuth@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.12 1/2] net: Remove the legacy "-net
 channel" parameter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>

Thomas Huth, on jeu. 07 d=C3=A9c. 2017 19:02:34 +0100, wrote:
> It has never been documented, so hardly anybody knows about this
> parameter, and it is marked as deprecated since QEMU v2.6.
> Time to let it go now.
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

> ---
>  include/net/slirp.h |  2 --
>  net/net.c           |  7 -------
>  net/slirp.c         | 34 ----------------------------------
>  qemu-doc.texi       |  5 -----
>  4 files changed, 48 deletions(-)
>=20
> diff --git a/include/net/slirp.h b/include/net/slirp.h
> index 64b795c..0c98e46 100644
> --- a/include/net/slirp.h
> +++ b/include/net/slirp.h
> @@ -36,8 +36,6 @@ void hmp_hostfwd_remove(Monitor *mon, const QDict *qd=
ict);
> =20
>  int net_slirp_redir(const char *redir_str);
> =20
> -int net_slirp_parse_legacy(QemuOptsList *opts_list, const char *optarg=
, int *ret);
> -
>  int net_slirp_smb(const char *exported_dir);
> =20
>  void hmp_info_usernet(Monitor *mon, const QDict *qdict);
> diff --git a/net/net.c b/net/net.c
> index 39ef546..7425857 100644
> --- a/net/net.c
> +++ b/net/net.c
> @@ -1565,13 +1565,6 @@ int net_init_clients(void)
> =20
>  int net_client_parse(QemuOptsList *opts_list, const char *optarg)
>  {
> -#if defined(CONFIG_SLIRP)
> -    int ret;
> -    if (net_slirp_parse_legacy(opts_list, optarg, &ret)) {
> -        return ret;
> -    }
> -#endif
> -
>      if (!qemu_opts_parse_noisily(opts_list, optarg, true)) {
>          return -1;
>      }
> diff --git a/net/slirp.c b/net/slirp.c
> index 318a26e..cb8ca23 100644
> --- a/net/slirp.c
> +++ b/net/slirp.c
> @@ -956,37 +956,3 @@ int net_init_slirp(const Netdev *netdev, const cha=
r *name,
> =20
>      return ret;
>  }
> -
> -int net_slirp_parse_legacy(QemuOptsList *opts_list, const char *optarg=
, int *ret)
> -{
> -    if (strcmp(opts_list->name, "net") !=3D 0 ||
> -        strncmp(optarg, "channel,", strlen("channel,")) !=3D 0) {
> -        return 0;
> -    }
> -
> -    error_report("The '-net channel' option is deprecated. "
> -                 "Please use '-netdev user,guestfwd=3D...' instead.");
> -
> -    /* handle legacy -net channel,port:chr */
> -    optarg +=3D strlen("channel,");
> -
> -    if (QTAILQ_EMPTY(&slirp_stacks)) {
> -        struct slirp_config_str *config;
> -
> -        config =3D g_malloc(sizeof(*config));
> -        pstrcpy(config->str, sizeof(config->str), optarg);
> -        config->flags =3D SLIRP_CFG_LEGACY;
> -        config->next =3D slirp_configs;
> -        slirp_configs =3D config;
> -        *ret =3D 0;
> -    } else {
> -        Error *err =3D NULL;
> -        *ret =3D slirp_guestfwd(QTAILQ_FIRST(&slirp_stacks), optarg, 1=
, &err);
> -        if (*ret < 0) {
> -            error_report_err(err);
> -        }
> -    }
> -
> -    return 1;
> -}
> -
> diff --git a/qemu-doc.texi b/qemu-doc.texi
> index db2351c..982cab5 100644
> --- a/qemu-doc.texi
> +++ b/qemu-doc.texi
> @@ -2459,11 +2459,6 @@ The ``-smb /some/dir'' argument is now a synonym=
 for setting
>  the ``-netdev user,smb=3D/some/dir'' argument instead. The new
>  syntax allows different settings to be provided per NIC.
> =20
> -@subsection -net channel (since 2.6.0)
> -
> -The ``--net channel,ARGS'' argument is now a synonym for setting
> -the ``-netdev user,guestfwd=3DARGS'' argument instead.
> -
>  @subsection -net vlan (since 2.9.0)
> =20
>  The ``-net vlan=3DNN'' argument is partially replaced with the
> --=20
> 1.8.3.1
>=20

--=20
Samuel
R: Parce que =C3=A7a renverse b=C3=AAtement l'ordre naturel de lecture!
Q: Mais pourquoi citer en fin d'article est-il si effroyable?
R: Citer en fin d'article
Q: Quelle est la chose la plus d=C3=A9sagr=C3=A9able sur les groupes de n=
ews?
