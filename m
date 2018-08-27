Received: from eggs.gnu.org ([2001:4830:134:3::10]:38763)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1fuMwQ-0002wX-E0
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 15:12:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1fuMwN-00006K-2D
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 15:12:46 -0400
Received: from hera.aquilenet.fr ([185.233.100.1]:40550)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1fuMwM-0008Ry-Mx
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 15:12:42 -0400
Date: Mon, 27 Aug 2018 21:12:38 +0200
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20180827191238.2hus5w64iqbxys66@var.youpi.perso.aquilenet.fr>
References: <1535381652-19870-1-git-send-email-thuth@redhat.com>
	<1535381652-19870-5-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1535381652-19870-5-git-send-email-thuth@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 4/4] net: Remove the deprecated -tftp,
 -bootp, -redir and -smb options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>, libvir-list@redhat.com, Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>

Thomas Huth, le lun. 27 ao=C3=BBt 2018 16:54:12 +0200, a ecrit:
> These options likely do not work as expected as soon as the user
> tries to use more than one network interface at once. The parameters
> have been marked as deprecated since QEMU v2.6, so users had plenty
> of time to move their scripts to the new syntax. Time to remove the
> old parameters now.
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

> ---
>  include/net/net.h    |   3 --
>  include/net/slirp.h  |   4 --
>  net/slirp.c          | 132 +++++++++++--------------------------------=
--------
>  os-posix.c           |   8 ----
>  qemu-deprecated.texi |  34 -------------
>  qemu-options.hx      |  15 ------
>  vl.c                 |  18 -------
>  7 files changed, 29 insertions(+), 185 deletions(-)
>=20
> diff --git a/include/net/net.h b/include/net/net.h
> index 1425960..7936d53 100644
> --- a/include/net/net.h
> +++ b/include/net/net.h
> @@ -201,9 +201,6 @@ extern NICInfo nd_table[MAX_NICS];
>  extern const char *host_net_devices[];
> =20
>  /* from net.c */
> -extern const char *legacy_tftp_prefix;
> -extern const char *legacy_bootp_filename;
> -
>  int net_client_parse(QemuOptsList *opts_list, const char *str);
>  int net_init_clients(Error **errp);
>  void net_check_clients(void);
> diff --git a/include/net/slirp.h b/include/net/slirp.h
> index 4d63d74..bad3e1e 100644
> --- a/include/net/slirp.h
> +++ b/include/net/slirp.h
> @@ -30,10 +30,6 @@
>  void hmp_hostfwd_add(Monitor *mon, const QDict *qdict);
>  void hmp_hostfwd_remove(Monitor *mon, const QDict *qdict);
> =20
> -int net_slirp_redir(const char *redir_str);
> -
> -int net_slirp_smb(const char *exported_dir);
> -
>  void hmp_info_usernet(Monitor *mon, const QDict *qdict);
> =20
>  #endif
> diff --git a/net/slirp.c b/net/slirp.c
> index 1e14318..c18060f 100644
> --- a/net/slirp.c
> +++ b/net/slirp.c
> @@ -67,13 +67,11 @@ static int get_str_sep(char *buf, int buf_size, con=
st char **pp, int sep)
>  /* slirp network adapter */
> =20
>  #define SLIRP_CFG_HOSTFWD 1
> -#define SLIRP_CFG_LEGACY  2
> =20
>  struct slirp_config_str {
>      struct slirp_config_str *next;
>      int flags;
>      char str[1024];
> -    int legacy_format;
>  };
> =20
>  typedef struct SlirpState {
> @@ -87,19 +85,13 @@ typedef struct SlirpState {
>  } SlirpState;
> =20
>  static struct slirp_config_str *slirp_configs;
> -const char *legacy_tftp_prefix;
> -const char *legacy_bootp_filename;
>  static QTAILQ_HEAD(slirp_stacks, SlirpState) slirp_stacks =3D
>      QTAILQ_HEAD_INITIALIZER(slirp_stacks);
> =20
> -static int slirp_hostfwd(SlirpState *s, const char *redir_str,
> -                         int legacy_format, Error **errp);
> -static int slirp_guestfwd(SlirpState *s, const char *config_str,
> -                          int legacy_format, Error **errp);
> +static int slirp_hostfwd(SlirpState *s, const char *redir_str, Error *=
*errp);
> +static int slirp_guestfwd(SlirpState *s, const char *config_str, Error=
 **errp);
> =20
>  #ifndef _WIN32
> -static const char *legacy_smb_export;
> -
>  static int slirp_smb(SlirpState *s, const char *exported_dir,
>                       struct in_addr vserver_addr, Error **errp);
>  static void slirp_smb_cleanup(SlirpState *s);
> @@ -196,13 +188,6 @@ static int net_slirp_init(NetClientState *peer, co=
nst char *model,
>          return -1;
>      }
> =20
> -    if (!tftp_export) {
> -        tftp_export =3D legacy_tftp_prefix;
> -    }
> -    if (!bootfile) {
> -        bootfile =3D legacy_bootp_filename;
> -    }
> -
>      if (vnetwork) {
>          if (get_str_sep(buf, sizeof(buf), &vnetwork, '/') < 0) {
>              if (!inet_aton(vnetwork, &net)) {
> @@ -382,21 +367,16 @@ static int net_slirp_init(NetClientState *peer, c=
onst char *model,
> =20
>      for (config =3D slirp_configs; config; config =3D config->next) {
>          if (config->flags & SLIRP_CFG_HOSTFWD) {
> -            if (slirp_hostfwd(s, config->str,
> -                              config->flags & SLIRP_CFG_LEGACY, errp) =
< 0) {
> +            if (slirp_hostfwd(s, config->str, errp) < 0) {
>                  goto error;
>              }
>          } else {
> -            if (slirp_guestfwd(s, config->str,
> -                               config->flags & SLIRP_CFG_LEGACY, errp)=
 < 0) {
> +            if (slirp_guestfwd(s, config->str, errp) < 0) {
>                  goto error;
>              }
>          }
>      }
>  #ifndef _WIN32
> -    if (!smb_export) {
> -        smb_export =3D legacy_smb_export;
> -    }
>      if (smb_export) {
>          if (slirp_smb(s, smb_export, smbsrv, errp) < 0) {
>              goto error;
> @@ -506,8 +486,7 @@ void hmp_hostfwd_remove(Monitor *mon, const QDict *=
qdict)
>      monitor_printf(mon, "invalid format\n");
>  }
> =20
> -static int slirp_hostfwd(SlirpState *s, const char *redir_str,
> -                         int legacy_format, Error **errp)
> +static int slirp_hostfwd(SlirpState *s, const char *redir_str, Error *=
*errp)
>  {
>      struct in_addr host_addr =3D { .s_addr =3D INADDR_ANY };
>      struct in_addr guest_addr =3D { .s_addr =3D 0 };
> @@ -532,18 +511,16 @@ static int slirp_hostfwd(SlirpState *s, const cha=
r *redir_str,
>          goto fail_syntax;
>      }
> =20
> -    if (!legacy_format) {
> -        if (get_str_sep(buf, sizeof(buf), &p, ':') < 0) {
> -            fail_reason =3D "Missing : separator";
> -            goto fail_syntax;
> -        }
> -        if (buf[0] !=3D '\0' && !inet_aton(buf, &host_addr)) {
> -            fail_reason =3D "Bad host address";
> -            goto fail_syntax;
> -        }
> +    if (get_str_sep(buf, sizeof(buf), &p, ':') < 0) {
> +        fail_reason =3D "Missing : separator";
> +        goto fail_syntax;
> +    }
> +    if (buf[0] !=3D '\0' && !inet_aton(buf, &host_addr)) {
> +        fail_reason =3D "Bad host address";
> +        goto fail_syntax;
>      }
> =20
> -    if (get_str_sep(buf, sizeof(buf), &p, legacy_format ? ':' : '-') <=
 0) {
> +    if (get_str_sep(buf, sizeof(buf), &p, '-') < 0) {
>          fail_reason =3D "Bad host port separator";
>          goto fail_syntax;
>      }
> @@ -602,35 +579,13 @@ void hmp_hostfwd_add(Monitor *mon, const QDict *q=
dict)
>      }
>      if (s) {
>          Error *err =3D NULL;
> -        if (slirp_hostfwd(s, redir_str, 0, &err) < 0) {
> +        if (slirp_hostfwd(s, redir_str, &err) < 0) {
>              error_report_err(err);
>          }
>      }
> =20
>  }
> =20
> -int net_slirp_redir(const char *redir_str)
> -{
> -    struct slirp_config_str *config;
> -    Error *err =3D NULL;
> -    int res;
> -
> -    if (QTAILQ_EMPTY(&slirp_stacks)) {
> -        config =3D g_malloc(sizeof(*config));
> -        pstrcpy(config->str, sizeof(config->str), redir_str);
> -        config->flags =3D SLIRP_CFG_HOSTFWD | SLIRP_CFG_LEGACY;
> -        config->next =3D slirp_configs;
> -        slirp_configs =3D config;
> -        return 0;
> -    }
> -
> -    res =3D slirp_hostfwd(QTAILQ_FIRST(&slirp_stacks), redir_str, 1, &=
err);
> -    if (res < 0) {
> -        error_report_err(err);
> -    }
> -    return res;
> -}
> -
>  #ifndef _WIN32
> =20
>  /* automatic user mode samba server configuration */
> @@ -746,28 +701,6 @@ static int slirp_smb(SlirpState* s, const char *ex=
ported_dir,
>      return 0;
>  }
> =20
> -/* automatic user mode samba server configuration (legacy interface) *=
/
> -int net_slirp_smb(const char *exported_dir)
> -{
> -    struct in_addr vserver_addr =3D { .s_addr =3D 0 };
> -
> -    if (legacy_smb_export) {
> -        fprintf(stderr, "-smb given twice\n");
> -        return -1;
> -    }
> -    legacy_smb_export =3D exported_dir;
> -    if (!QTAILQ_EMPTY(&slirp_stacks)) {
> -        Error *err =3D NULL;
> -        int res =3D slirp_smb(QTAILQ_FIRST(&slirp_stacks), exported_di=
r,
> -                            vserver_addr, &err);
> -        if (res < 0) {
> -            error_report_err(err);
> -        }
> -        return res;
> -    }
> -    return 0;
> -}
> -
>  #endif /* !defined(_WIN32) */
> =20
>  struct GuestFwd {
> @@ -789,8 +722,7 @@ static void guestfwd_read(void *opaque, const uint8=
_t *buf, int size)
>      slirp_socket_recv(fwd->slirp, fwd->server, fwd->port, buf, size);
>  }
> =20
> -static int slirp_guestfwd(SlirpState *s, const char *config_str,
> -                          int legacy_format, Error **errp)
> +static int slirp_guestfwd(SlirpState *s, const char *config_str, Error=
 **errp)
>  {
>      struct in_addr server =3D { .s_addr =3D 0 };
>      struct GuestFwd *fwd;
> @@ -800,26 +732,20 @@ static int slirp_guestfwd(SlirpState *s, const ch=
ar *config_str,
>      int port;
> =20
>      p =3D config_str;
> -    if (legacy_format) {
> -        if (get_str_sep(buf, sizeof(buf), &p, ':') < 0) {
> -            goto fail_syntax;
> -        }
> -    } else {
> -        if (get_str_sep(buf, sizeof(buf), &p, ':') < 0) {
> -            goto fail_syntax;
> -        }
> -        if (strcmp(buf, "tcp") && buf[0] !=3D '\0') {
> -            goto fail_syntax;
> -        }
> -        if (get_str_sep(buf, sizeof(buf), &p, ':') < 0) {
> -            goto fail_syntax;
> -        }
> -        if (buf[0] !=3D '\0' && !inet_aton(buf, &server)) {
> -            goto fail_syntax;
> -        }
> -        if (get_str_sep(buf, sizeof(buf), &p, '-') < 0) {
> -            goto fail_syntax;
> -        }
> +    if (get_str_sep(buf, sizeof(buf), &p, ':') < 0) {
> +        goto fail_syntax;
> +    }
> +    if (strcmp(buf, "tcp") && buf[0] !=3D '\0') {
> +        goto fail_syntax;
> +    }
> +    if (get_str_sep(buf, sizeof(buf), &p, ':') < 0) {
> +        goto fail_syntax;
> +    }
> +    if (buf[0] !=3D '\0' && !inet_aton(buf, &server)) {
> +        goto fail_syntax;
> +    }
> +    if (get_str_sep(buf, sizeof(buf), &p, '-') < 0) {
> +        goto fail_syntax;
>      }
>      port =3D strtol(buf, &end, 10);
>      if (*end !=3D '\0' || port < 1 || port > 65535) {
> diff --git a/os-posix.c b/os-posix.c
> index 9ce6f74..8f39447 100644
> --- a/os-posix.c
> +++ b/os-posix.c
> @@ -168,14 +168,6 @@ static bool os_parse_runas_uid_gid(const char *opt=
arg)
>  int os_parse_cmd_args(int index, const char *optarg)
>  {
>      switch (index) {
> -#ifdef CONFIG_SLIRP
> -    case QEMU_OPTION_smb:
> -        error_report("The -smb option is deprecated. "
> -                     "Please use '-netdev user,smb=3D...' instead.");
> -        if (net_slirp_smb(optarg) < 0)
> -            exit(1);
> -        break;
> -#endif
>      case QEMU_OPTION_runas:
>          user_pwd =3D getpwnam(optarg);
>          if (user_pwd) {
> diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
> index ca52e83..8a2e399 100644
> --- a/qemu-deprecated.texi
> +++ b/qemu-deprecated.texi
> @@ -40,40 +40,6 @@ which is the default.
>  The ``-no-kvm'' argument is now a synonym for setting
>  ``-machine accel=3Dtcg''.
> =20
> -@subsection -tftp (since 2.6.0)
> -
> -The ``-tftp /some/dir'' argument is replaced by either
> -``-netdev user,id=3Dx,tftp=3D/some/dir '' (for pluggable NICs, accompa=
nied
> -with ``-device ...,netdev=3Dx''), or ``-nic user,tftp=3D/some/dir''
> -(for embedded NICs). The new syntax allows different settings to be
> -provided per NIC.
> -
> -@subsection -bootp (since 2.6.0)
> -
> -The ``-bootp /some/file'' argument is replaced by either
> -``-netdev user,id=3Dx,bootp=3D/some/file '' (for pluggable NICs, accom=
panied
> -with ``-device ...,netdev=3Dx''), or ``-nic user,bootp=3D/some/file''
> -(for embedded NICs). The new syntax allows different settings to be
> -provided per NIC.
> -
> -@subsection -redir (since 2.6.0)
> -
> -The ``-redir [tcp|udp]:hostport:[guestaddr]:guestport'' argument is
> -replaced by either
> -``-netdev user,id=3Dx,hostfwd=3D[tcp|udp]:[hostaddr]:hostport-[guestad=
dr]:guestport''
> -(for pluggable NICs, accompanied with ``-device ...,netdev=3Dx'') or
> -``-nic user,hostfwd=3D[tcp|udp]:[hostaddr]:hostport-[guestaddr]:guestp=
ort''
> -(for embedded NICs). The new syntax allows different settings to be
> -provided per NIC.
> -
> -@subsection -smb (since 2.6.0)
> -
> -The ``-smb /some/dir'' argument is replaced by either
> -``-netdev user,id=3Dx,smb=3D/some/dir '' (for pluggable NICs, accompan=
ied
> -with ``-device ...,netdev=3Dx''), or ``-nic user,smb=3D/some/dir''
> -(for embedded NICs). The new syntax allows different settings to be
> -provided per NIC.
> -
>  @subsection -usbdevice (since 2.10.0)
> =20
>  The ``-usbdevice DEV'' argument is now a synonym for setting
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 7ca539a..a642ad2 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -1813,16 +1813,6 @@ STEXI
>  @table @option
>  ETEXI
> =20
> -HXCOMM Legacy slirp options (now moved to -net user):
> -#ifdef CONFIG_SLIRP
> -DEF("tftp", HAS_ARG, QEMU_OPTION_tftp, "", QEMU_ARCH_ALL)
> -DEF("bootp", HAS_ARG, QEMU_OPTION_bootp, "", QEMU_ARCH_ALL)
> -DEF("redir", HAS_ARG, QEMU_OPTION_redir, "", QEMU_ARCH_ALL)
> -#ifndef _WIN32
> -DEF("smb", HAS_ARG, QEMU_OPTION_smb, "", QEMU_ARCH_ALL)
> -#endif
> -#endif
> -
>  DEF("netdev", HAS_ARG, QEMU_OPTION_netdev,
>  #ifdef CONFIG_SLIRP
>      "-netdev user,id=3Dstr[,ipv4[=3Don|off]][,net=3Daddr[/mask]][,host=
=3Daddr]\n"
> @@ -2150,11 +2140,6 @@ qemu-system-i386 -nic  'user,id=3Dn1,guestfwd=3D=
tcp:10.0.2.100:1234-cmd:netcat 10.10
> =20
>  @end table
> =20
> -Note: Legacy stand-alone options -tftp, -bootp, -smb and -redir are st=
ill
> -processed and applied to -net user. Mixing them with the new configura=
tion
> -syntax gives undefined results. Their use for new applications is disc=
ouraged
> -as they will be removed from future versions.
> -
>  @item -netdev tap,id=3D@var{id}[,fd=3D@var{h}][,ifname=3D@var{name}][,=
script=3D@var{file}][,downscript=3D@var{dfile}][,br=3D@var{bridge}][,help=
er=3D@var{helper}]
>  Configure a host TAP network backend with ID @var{id}.
> =20
> diff --git a/vl.c b/vl.c
> index cfeee0d..1b8ff85 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -3168,24 +3168,6 @@ int main(int argc, char **argv, char **envp)
>                  }
>                  break;
>  #endif
> -#ifdef CONFIG_SLIRP
> -            case QEMU_OPTION_tftp:
> -                error_report("The -tftp option is deprecated. "
> -                             "Please use '-netdev user,tftp=3D...' ins=
tead.");
> -                legacy_tftp_prefix =3D optarg;
> -                break;
> -            case QEMU_OPTION_bootp:
> -                error_report("The -bootp option is deprecated. "
> -                             "Please use '-netdev user,bootfile=3D...'=
 instead.");
> -                legacy_bootp_filename =3D optarg;
> -                break;
> -            case QEMU_OPTION_redir:
> -                error_report("The -redir option is deprecated. "
> -                             "Please use '-netdev user,hostfwd=3D...' =
instead.");
> -                if (net_slirp_redir(optarg) < 0)
> -                    exit(1);
> -                break;
> -#endif
>              case QEMU_OPTION_bt:
>                  add_device_config(DEV_BT, optarg);
>                  break;
> --=20
> 1.8.3.1
>=20

--=20
Samuel
"c'est pas nous qui sommes =C3=A0 la rue, c'est la rue qui est =C3=A0 nou=
s"
