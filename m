Received: from eggs.gnu.org ([2001:4830:134:3::10]:55257)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gOsMv-0004AF-P2
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 17:50:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gOsMs-0003Fr-Kj
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 17:50:13 -0500
Received: from hera.aquilenet.fr ([185.233.100.1]:56496)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1gOsMs-0003C7-1c
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 17:50:10 -0500
Date: Mon, 19 Nov 2018 23:50:07 +0100
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20181119225007.7qlbjv4fro2ftqmc@function>
References: <20181114123643.24091-1-marcandre.lureau@redhat.com>
	<20181114123643.24091-3-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181114123643.24091-3-marcandre.lureau@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-3.2 02/41] glib-compat: add
 g_spawn_async_with_fds() fallback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, rjones@redhat.com, stefanha@redhat.com, renzo@cs.unibo.it

Marc-Andr=C3=A9 Lureau, le mer. 14 nov. 2018 16:36:04 +0400, a ecrit:
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

include/glib-compat.h maintainers, may I keep this in my slirp tree, to
be pushed to master when appropriate?

Samuel

> ---
>  include/glib-compat.h | 56 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 56 insertions(+)
>=20
> diff --git a/include/glib-compat.h b/include/glib-compat.h
> index fdf95a255d..8a078c5288 100644
> --- a/include/glib-compat.h
> +++ b/include/glib-compat.h
> @@ -83,6 +83,62 @@ static inline gboolean g_strv_contains_qemu(const gc=
har *const *strv,
>  }
>  #define g_strv_contains(a, b) g_strv_contains_qemu(a, b)
> =20
> +#if !GLIB_CHECK_VERSION(2, 58, 0)
> +typedef struct QemuGSpawnFds {
> +    GSpawnChildSetupFunc child_setup;
> +    gpointer user_data;
> +    gint stdin_fd;
> +    gint stdout_fd;
> +    gint stderr_fd;
> +} QemuGSpawnFds;
> +
> +static inline void
> +qemu_gspawn_fds_setup(gpointer user_data)
> +{
> +    QemuGSpawnFds *q =3D (QemuGSpawnFds *)user_data;
> +
> +    dup2(q->stdin_fd, 0);
> +    dup2(q->stdout_fd, 1);
> +    dup2(q->stderr_fd, 2);
> +    q->child_setup(q->user_data);
> +}
> +#endif
> +
> +static inline gboolean
> +g_spawn_async_with_fds_qemu(const gchar *working_directory,
> +                            gchar **argv,
> +                            gchar **envp,
> +                            GSpawnFlags flags,
> +                            GSpawnChildSetupFunc child_setup,
> +                            gpointer user_data,
> +                            GPid *child_pid,
> +                            gint stdin_fd,
> +                            gint stdout_fd,
> +                            gint stderr_fd,
> +                            GError **error)
> +{
> +#if GLIB_CHECK_VERSION(2, 58, 0)
> +    return g_spawn_async_with_fds(working_directory, argv, envp, flags=
,
> +                                  child_setup, user_data,
> +                                  child_pid, stdin_fd, stdout_fd, stde=
rr_fd,
> +                                  error);
> +#else
> +    QemuGSpawnFds setup =3D {
> +        .child_setup =3D child_setup,
> +        .user_data =3D user_data,
> +        .stdin_fd =3D stdin_fd,
> +        .stdout_fd =3D stdout_fd,
> +        .stderr_fd =3D stderr_fd,
> +    };
> +
> +    return g_spawn_async(working_directory, argv, envp, flags,
> +                         qemu_gspawn_fds_setup, &setup,
> +                         child_pid, error);
> +#endif
> +}
> +
> +#define g_spawn_async_with_fds(wd, argv, env, f, c, d, p, ifd, ofd, ef=
d, err) \
> +    g_spawn_async_with_fds_qemu(wd, argv, env, f, c, d, p, ifd, ofd, e=
fd, err)
> =20
>  #if defined(_WIN32) && !GLIB_CHECK_VERSION(2, 50, 0)
>  /*
> --=20
> 2.19.1.708.g4ede3d42df
>=20

--=20
Samuel
  bien s=C3=BBr que =C3=A7a convient mieux =C3=A0 tout le monde
  enfin, dans la mesure o=C3=B9 tout le monde c'est comme moi
 -+- le consensus, c'est facile -+-
