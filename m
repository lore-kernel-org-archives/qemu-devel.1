Received: from eggs.gnu.org ([209.51.188.92]:36936)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gqa3b-0007fF-Oj
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 03:56:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gqa3a-0003TJ-U2
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 03:56:47 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:53330)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1gqa3V-0003PR-Le
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 03:56:43 -0500
Received: by mail-wm1-x343.google.com with SMTP id d15so12245342wmb.3
	for <qemu-devel@nongnu.org>; Mon, 04 Feb 2019 00:56:39 -0800 (PST)
MIME-Version: 1.0
References: <20190203142225.32268-1-samuel.thibault@ens-lyon.org>
In-Reply-To: <20190203142225.32268-1-samuel.thibault@ens-lyon.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 4 Feb 2019 09:56:26 +0100
Message-ID: <CAJ+F1CL=MvmuvWstSnz_Bns6r1Q+g3DMYjT+NcTJnKNAiv1dzQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] slirp: Move g_spawn_async_with_fds_qemu
 compatibility to slirp/
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Thibault <samuel.thibault@ens-lyon.org>
Cc: QEMU <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>

Hi

On Sun, Feb 3, 2019 at 3:34 PM Samuel Thibault
<samuel.thibault@ens-lyon.org> wrote:
>
> Only slirp actually needs it, and will need it along in libslirp.
>
> Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  include/glib-compat.h | 57 -------------------------------------------
>  slirp/misc.c          | 57 +++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 57 insertions(+), 57 deletions(-)
>
> diff --git a/include/glib-compat.h b/include/glib-compat.h
> index 8a078c5288..1291628e09 100644
> --- a/include/glib-compat.h
> +++ b/include/glib-compat.h
> @@ -83,63 +83,6 @@ static inline gboolean g_strv_contains_qemu(const gcha=
r *const *strv,
>  }
>  #define g_strv_contains(a, b) g_strv_contains_qemu(a, b)
>
> -#if !GLIB_CHECK_VERSION(2, 58, 0)
> -typedef struct QemuGSpawnFds {
> -    GSpawnChildSetupFunc child_setup;
> -    gpointer user_data;
> -    gint stdin_fd;
> -    gint stdout_fd;
> -    gint stderr_fd;
> -} QemuGSpawnFds;
> -
> -static inline void
> -qemu_gspawn_fds_setup(gpointer user_data)
> -{
> -    QemuGSpawnFds *q =3D (QemuGSpawnFds *)user_data;
> -
> -    dup2(q->stdin_fd, 0);
> -    dup2(q->stdout_fd, 1);
> -    dup2(q->stderr_fd, 2);
> -    q->child_setup(q->user_data);
> -}
> -#endif
> -
> -static inline gboolean
> -g_spawn_async_with_fds_qemu(const gchar *working_directory,
> -                            gchar **argv,
> -                            gchar **envp,
> -                            GSpawnFlags flags,
> -                            GSpawnChildSetupFunc child_setup,
> -                            gpointer user_data,
> -                            GPid *child_pid,
> -                            gint stdin_fd,
> -                            gint stdout_fd,
> -                            gint stderr_fd,
> -                            GError **error)
> -{
> -#if GLIB_CHECK_VERSION(2, 58, 0)
> -    return g_spawn_async_with_fds(working_directory, argv, envp, flags,
> -                                  child_setup, user_data,
> -                                  child_pid, stdin_fd, stdout_fd, stderr=
_fd,
> -                                  error);
> -#else
> -    QemuGSpawnFds setup =3D {
> -        .child_setup =3D child_setup,
> -        .user_data =3D user_data,
> -        .stdin_fd =3D stdin_fd,
> -        .stdout_fd =3D stdout_fd,
> -        .stderr_fd =3D stderr_fd,
> -    };
> -
> -    return g_spawn_async(working_directory, argv, envp, flags,
> -                         qemu_gspawn_fds_setup, &setup,
> -                         child_pid, error);
> -#endif
> -}
> -
> -#define g_spawn_async_with_fds(wd, argv, env, f, c, d, p, ifd, ofd, efd,=
 err) \
> -    g_spawn_async_with_fds_qemu(wd, argv, env, f, c, d, p, ifd, ofd, efd=
, err)
> -
>  #if defined(_WIN32) && !GLIB_CHECK_VERSION(2, 50, 0)
>  /*
>   * g_poll has a problem on Windows when using
> diff --git a/slirp/misc.c b/slirp/misc.c
> index edb0d187d7..18b25f93ac 100644
> --- a/slirp/misc.c
> +++ b/slirp/misc.c
> @@ -120,6 +120,63 @@ fork_exec_child_setup(gpointer data)
>  #endif
>  }
>
> +#if !GLIB_CHECK_VERSION(2, 58, 0)
> +typedef struct SlirpGSpawnFds {
> +    GSpawnChildSetupFunc child_setup;
> +    gpointer user_data;
> +    gint stdin_fd;
> +    gint stdout_fd;
> +    gint stderr_fd;
> +} SlirpGSpawnFds;
> +
> +static inline void
> +slirp_gspawn_fds_setup(gpointer user_data)
> +{
> +    SlirpGSpawnFds *q =3D (SlirpGSpawnFds *)user_data;
> +
> +    dup2(q->stdin_fd, 0);
> +    dup2(q->stdout_fd, 1);
> +    dup2(q->stderr_fd, 2);
> +    q->child_setup(q->user_data);
> +}
> +#endif
> +
> +static inline gboolean
> +g_spawn_async_with_fds_slirp(const gchar *working_directory,
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
> +    return g_spawn_async_with_fds(working_directory, argv, envp, flags,
> +                                  child_setup, user_data,
> +                                  child_pid, stdin_fd, stdout_fd, stderr=
_fd,
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
> +                         slirp_gspawn_fds_setup, &setup,
> +                         child_pid, error);
> +#endif
> +}
> +
> +#define g_spawn_async_with_fds(wd, argv, env, f, c, d, p, ifd, ofd, efd,=
 err) \
> +    g_spawn_async_with_fds_slirp(wd, argv, env, f, c, d, p, ifd, ofd, ef=
d, err)
> +
>  int
>  fork_exec(struct socket *so, const char *ex)
>  {
> --
> 2.20.1
>
>


--=20
Marc-Andr=C3=A9 Lureau
