Received: from eggs.gnu.org ([2001:4830:134:3::10]:35189)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fVQ0g-00074x-Ui
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 19:26:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fVQ0f-0004Ri-Ar
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 19:26:02 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:36998)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1fVQ0f-0004QD-07
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 19:26:01 -0400
Received: by mail-wm0-x244.google.com with SMTP id r125-v6so3401912wmg.2
	for <qemu-devel@nongnu.org>; Tue, 19 Jun 2018 16:26:00 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180619193806.17419-5-danielhb413@gmail.com>
References: <20180619193806.17419-1-danielhb413@gmail.com>
	<20180619193806.17419-5-danielhb413@gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 20 Jun 2018 01:25:59 +0200
Message-ID: <CAJ+F1C+4FW+wXTeF3i4gydYvjZs=1R+wDzvhMnEnKB8mUmNkRw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 4/6] qga: removing switch statements,
 adding run_process_child
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: QEMU <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

Hi

On Tue, Jun 19, 2018 at 9:38 PM, Daniel Henrique Barboza
<danielhb413@gmail.com> wrote:
> This is a cleanup of the resulting code after detaching
> pmutils and Linux sys state file logic:
>
> - remove the SUSPEND_MODE_* macros and use an enumeration
> instead. At the same time, drop the switch statements
> at the start of each function and use the enumeration
> index to get the right binary/argument;
>
> - create a new function called run_process_child(). This
> function creates a child process and executes a (shell)
> command, returning the command return code. This is a common

What about using g_spawn_sync() instead?

> operation in the pmutils functions and will be used in the
> systemd implementation as well, so this function will avoid
> code repetition.
>
> There are more places inside commands-posix.c where this new
> run_process_child function can also be used, but one step
> at a time.
>
> Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
> ---
>  qga/commands-posix.c | 190 +++++++++++++++++--------------------------
>  1 file changed, 76 insertions(+), 114 deletions(-)
>
> diff --git a/qga/commands-posix.c b/qga/commands-posix.c
> index a2870f9ab9..d5e3805ce9 100644
> --- a/qga/commands-posix.c
> +++ b/qga/commands-posix.c
> @@ -1438,152 +1438,122 @@ qmp_guest_fstrim(bool has_minimum, int64_t mini=
mum, Error **errp)
>  #define LINUX_SYS_STATE_FILE "/sys/power/state"
>  #define SUSPEND_SUPPORTED 0
>  #define SUSPEND_NOT_SUPPORTED 1
> -#define SUSPEND_MODE_DISK 1
> -#define SUSPEND_MODE_RAM 2
> -#define SUSPEND_MODE_HYBRID 3
>
> -static bool pmutils_supports_mode(int suspend_mode, Error **errp)
> +typedef enum {
> +    SUSPEND_MODE_DISK =3D 0,
> +    SUSPEND_MODE_RAM =3D 1,
> +    SUSPEND_MODE_HYBRID =3D 2,
> +} SuspendMode;
> +
> +static int run_process_child(const char *command[], Error **errp)
>  {
>      Error *local_err =3D NULL;
> -    const char *pmutils_arg;
> -    const char *pmutils_bin =3D "pm-is-supported";
> -    char *pmutils_path;
> +    char *cmd_path =3D g_find_program_in_path(command[0]);
>      pid_t pid;
> -    int status;
> -    bool ret =3D false;
> -
> -    switch (suspend_mode) {
> -
> -    case SUSPEND_MODE_DISK:
> -        pmutils_arg =3D "--hibernate";
> -        break;
> -    case SUSPEND_MODE_RAM:
> -        pmutils_arg =3D "--suspend";
> -        break;
> -    case SUSPEND_MODE_HYBRID:
> -        pmutils_arg =3D "--suspend-hybrid";
> -        break;
> -    default:
> -        return ret;
> -    }
> +    int status, ret =3D -1;
>
> -    pmutils_path =3D g_find_program_in_path(pmutils_bin);
> -    if (!pmutils_path) {
> +    if (!cmd_path) {
>          return ret;
>      }
>
>      pid =3D fork();
>      if (!pid) {
>          setsid();
> -        execle(pmutils_path, pmutils_bin, pmutils_arg, NULL, environ);
>          /*
> -         * If we get here execle() has failed.
> +         * execve receives a char* const argv[] as second arg but we're
> +         * receiving a const char*[]. Since execve does not change the
> +         * array contents it's tolerable to cast here.
>           */
> -        _exit(SUSPEND_NOT_SUPPORTED);
> +        execve(cmd_path, (char* const*)command, environ);
> +        _exit(errno);
>      } else if (pid < 0) {
>          error_setg_errno(errp, errno, "failed to create child process");
> +        ret =3D EXIT_FAILURE;
>          goto out;
>      }
>
>      ga_wait_child(pid, &status, &local_err);
>      if (local_err) {
>          error_propagate(errp, local_err);
> +        ret =3D EXIT_FAILURE;
>          goto out;
>      }
>
> -    switch (WEXITSTATUS(status)) {
> -    case SUSPEND_SUPPORTED:
> -        ret =3D true;
> -        goto out;
> -    case SUSPEND_NOT_SUPPORTED:
> -        goto out;
> -    default:
> -        error_setg(errp,
> -                   "the helper program '%s' returned an unexpected exit =
status"
> -                   " code (%d)", pmutils_path, WEXITSTATUS(status));
> -        goto out;
> -    }
> +    ret =3D WEXITSTATUS(status);
>
>  out:
> -    g_free(pmutils_path);
> +    g_free(cmd_path);
>      return ret;
>  }
>
> -static void pmutils_suspend(int suspend_mode, Error **errp)
> +static bool pmutils_supports_mode(SuspendMode mode, Error **errp)
>  {
>      Error *local_err =3D NULL;
> -    const char *pmutils_bin;
> -    char *pmutils_path;
> -    pid_t pid;
> +    const char *pmutils_args[3] =3D {"--hibernate", "--suspend",
> +                                   "--suspend-hybrid"};
> +    const char *cmd[3] =3D {"pm-is-supported", pmutils_args[mode], NULL}=
;
>      int status;
>
> -    switch (suspend_mode) {
> -
> -    case SUSPEND_MODE_DISK:
> -        pmutils_bin =3D "pm-hibernate";
> -        break;
> -    case SUSPEND_MODE_RAM:
> -        pmutils_bin =3D "pm-suspend";
> -        break;
> -    case SUSPEND_MODE_HYBRID:
> -        pmutils_bin =3D "pm-suspend-hybrid";
> -        break;
> -    default:
> -        error_setg(errp, "unknown guest suspend mode");
> -        return;
> -    }
> +    status =3D run_process_child(cmd, &local_err);
>
> -    pmutils_path =3D g_find_program_in_path(pmutils_bin);
> -    if (!pmutils_path) {
> -        error_setg(errp, "the helper program '%s' was not found", pmutil=
s_bin);
> -        return;
> +    if (status =3D=3D SUSPEND_SUPPORTED) {
> +        return true;
>      }
>
> -    pid =3D fork();
> -    if (!pid) {
> -        setsid();
> -        execle(pmutils_path, pmutils_bin, NULL, environ);
> -        /*
> -         * If we get here execle() has failed.
> -         */
> -        _exit(EXIT_FAILURE);
> -    } else if (pid < 0) {
> -        error_setg_errno(errp, errno, "failed to create child process");
> -        goto out;
> +    if (status =3D=3D -1) {
> +        return false;
>      }
>
> -    ga_wait_child(pid, &status, &local_err);
>      if (local_err) {
>          error_propagate(errp, local_err);
> -        goto out;
> +    } else {
> +        error_setg(errp,
> +                   "the helper program '%s' returned an unexpected exit"
> +                   " status code (%d)", "pm-is-supported", status);
>      }
>
> -    if (WEXITSTATUS(status)) {
> -        error_setg(errp,
> -                   "the helper program '%s' returned an unexpected exit =
status"
> -                   " code (%d)", pmutils_path, WEXITSTATUS(status));
> +    return false;
> +}
> +
> +static void pmutils_suspend(SuspendMode mode, Error **errp)
> +{
> +    Error *local_err =3D NULL;
> +    const char *pmutils_binaries[3] =3D {"pm-hibernate", "pm-suspend",
> +                                       "pm-suspend-hybrid"};
> +    const char *cmd[2] =3D {pmutils_binaries[mode], NULL};
> +    int status;
> +
> +    status =3D run_process_child(cmd, &local_err);
> +
> +    if (status =3D=3D 0) {
> +        return;
>      }
>
> -out:
> -    g_free(pmutils_path);
> +    if (status =3D=3D -1) {
> +        error_setg(errp, "the helper program '%s' was not found",
> +                    pmutils_binaries[mode]);
> +        return;
> +    }
> +
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +    } else {
> +        error_setg(errp,
> +                   "the helper program '%s' returned an unexpected exit"
> +                   " status code (%d)", pmutils_binaries[mode], status);
> +    }
>  }
>
> -static bool linux_sys_state_supports_mode(int suspend_mode, Error **errp=
)
> +static bool linux_sys_state_supports_mode(SuspendMode mode, Error **errp=
)
>  {
> -    const char *sysfile_str;
> +    const char *sysfile_strs[3] =3D {"disk", "mem", NULL};
> +    const char *sysfile_str =3D sysfile_strs[mode];
>      char buf[32]; /* hopefully big enough */
>      int fd;
>      ssize_t ret;
>
> -    switch (suspend_mode) {
> -
> -    case SUSPEND_MODE_DISK:
> -        sysfile_str =3D "disk";
> -        break;
> -    case SUSPEND_MODE_RAM:
> -        sysfile_str =3D "mem";
> -        break;
> -    default:
> +    if (!sysfile_str) {
> +        error_setg(errp, "unknown guest suspend mode");
>          return false;
>      }
>
> @@ -1604,22 +1574,15 @@ static bool linux_sys_state_supports_mode(int sus=
pend_mode, Error **errp)
>      return false;
>  }
>
> -static void linux_sys_state_suspend(int suspend_mode, Error **errp)
> +static void linux_sys_state_suspend(SuspendMode mode, Error **errp)
>  {
>      Error *local_err =3D NULL;
> -    const char *sysfile_str;
> +    const char *sysfile_strs[3] =3D {"disk", "mem", NULL};
> +    const char *sysfile_str =3D sysfile_strs[mode];
>      pid_t pid;
>      int status;
>
> -    switch (suspend_mode) {
> -
> -    case SUSPEND_MODE_DISK:
> -        sysfile_str =3D "disk";
> -        break;
> -    case SUSPEND_MODE_RAM:
> -        sysfile_str =3D "mem";
> -        break;
> -    default:
> +    if (!sysfile_str) {
>          error_setg(errp, "unknown guest suspend mode");
>          return;
>      }
> @@ -1661,12 +1624,12 @@ static void linux_sys_state_suspend(int suspend_m=
ode, Error **errp)
>
>  }
>
> -static void bios_supports_mode(int suspend_mode, Error **errp)
> +static void bios_supports_mode(SuspendMode mode, Error **errp)
>  {
>      Error *local_err =3D NULL;
>      bool ret;
>
> -    ret =3D pmutils_supports_mode(suspend_mode, &local_err);
> +    ret =3D pmutils_supports_mode(mode, &local_err);
>      if (ret) {
>          return;
>      }
> @@ -1674,32 +1637,31 @@ static void bios_supports_mode(int suspend_mode, =
Error **errp)
>          error_propagate(errp, local_err);
>          return;
>      }
> -    ret =3D linux_sys_state_supports_mode(suspend_mode, errp);
> +    ret =3D linux_sys_state_supports_mode(mode, &local_err);
>      if (!ret) {
>          error_setg(errp,
>                     "the requested suspend mode is not supported by the g=
uest");
> -        return;
>      }
>  }
>
> -static void guest_suspend(int suspend_mode, Error **errp)
> +static void guest_suspend(SuspendMode mode, Error **errp)
>  {
>      Error *local_err =3D NULL;
>
> -    bios_supports_mode(suspend_mode, &local_err);
> +    bios_supports_mode(mode, &local_err);
>      if (local_err) {
>          error_propagate(errp, local_err);
>          return;
>      }
>
> -    pmutils_suspend(suspend_mode, &local_err);
> +    pmutils_suspend(mode, &local_err);
>      if (!local_err) {
>          return;
>      }
>
>      local_err =3D NULL;
>
> -    linux_sys_state_suspend(suspend_mode, &local_err);
> +    linux_sys_state_suspend(mode, &local_err);
>      if (local_err) {
>          error_propagate(errp, local_err);
>      }
> --
> 2.17.1
>
>



--=20
Marc-Andr=C3=A9 Lureau
