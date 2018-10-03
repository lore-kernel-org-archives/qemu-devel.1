Received: from eggs.gnu.org ([2001:4830:134:3::10]:33318)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1g7eCI-0002fS-Ab
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 06:16:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1g7eCF-00029y-3O
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 06:16:02 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53581)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1g7eCE-00029W-SL
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 06:15:59 -0400
Received: by mail-wm1-f65.google.com with SMTP id b19-v6so5134828wme.3
	for <qemu-devel@nongnu.org>; Wed, 03 Oct 2018 03:15:58 -0700 (PDT)
References: <20181003091344.24496-1-d.csapak@proxmox.com>
	<20181003091344.24496-2-d.csapak@proxmox.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <f48452ab-c028-8fe0-6a4d-442f54c6d450@redhat.com>
Date: Wed, 3 Oct 2018 12:15:56 +0200
MIME-Version: 1.0
In-Reply-To: <20181003091344.24496-2-d.csapak@proxmox.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/1] vl.c: call optional script when exiting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dominik Csapak <d.csapak@proxmox.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com

On 03/10/2018 11:13, Dominik Csapak wrote:
> some users might want to call a script when qemu exits, without listening
> to a qmp monitor for events when running with --daemonize
> 
> this can be used for things like external cleanups
> 
> Signed-off-by: Dominik Csapak <d.csapak@proxmox.com>
> ---
>  qemu-options.hx | 18 ++++++++++++++++++
>  vl.c            | 45 +++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 63 insertions(+)
> 
> diff --git a/qemu-options.hx b/qemu-options.hx
> index f139459e80..03dcccee7f 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -3421,6 +3421,24 @@ This allows for instance switching to monitor to commit changes to the
>  disk image.
>  ETEXI
>  
> +DEF("exit-script", HAS_ARG, QEMU_OPTION_exit_script, \
> +    "-exit-script    <file>\n"
> +    "                      Execute the script in file on exit.\n"
> +    "                      The arguments are:\n"
> +    "                       - the shutdown reason,\n"
> +    "                       - if it was really a reset (if -no-reboot was set)\n"
> +    "                       - the name of the guest",
> +    QEMU_ARCH_ALL)
> +STEXI
> +@item -exit-script @var{file}
> +@findex -exit-script
> +Execute the script $var{file} on exit.
> +The arguments are:
> + - the shutdown reason
> + - if it was really a reset (if -no-reboot was set)
> + - the name of the guest
> +ETEXI
> +
>  DEF("loadvm", HAS_ARG, QEMU_OPTION_loadvm, \
>      "-loadvm [tag|id]\n" \
>      "                start right away with a saved state (loadvm in monitor)\n",
> diff --git a/vl.c b/vl.c
> index cc55fe04a2..818381cd76 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -1522,6 +1522,9 @@ void vm_state_notify(int running, RunState state)
>      }
>  }
>  
> +static ShutdownCause shutdown_reason;
> +static bool shutdown_was_reset;
> +
>  static ShutdownCause reset_requested;
>  static ShutdownCause shutdown_requested;
>  static int shutdown_signal;
> @@ -1681,6 +1684,7 @@ void qemu_system_guest_panicked(GuestPanicInformation *info)
>  void qemu_system_reset_request(ShutdownCause reason)
>  {
>      if (no_reboot && reason != SHUTDOWN_CAUSE_SUBSYSTEM_RESET) {
> +        shutdown_was_reset = true;
>          shutdown_requested = reason;
>      } else {
>          reset_requested = reason;
> @@ -1811,6 +1815,7 @@ static bool main_loop_should_exit(void)
>          if (no_shutdown) {
>              vm_stop(RUN_STATE_SHUTDOWN);
>          } else {
> +            shutdown_reason = request;
>              return true;
>          }
>      }
> @@ -2899,6 +2904,7 @@ int main(int argc, char **argv, char **envp)
>      Error *err = NULL;
>      bool list_data_dirs = false;
>      char *dir, **dirs;
> +    const char *exit_script = NULL;
>      typedef struct BlockdevOptions_queue {
>          BlockdevOptions *bdo;
>          Location loc;
> @@ -3587,6 +3593,9 @@ int main(int argc, char **argv, char **envp)
>              case QEMU_OPTION_no_shutdown:
>                  no_shutdown = 1;
>                  break;
> +            case QEMU_OPTION_exit_script:
> +                exit_script = optarg;
> +                break;
>              case QEMU_OPTION_show_cursor:
>                  cursor_hide = 0;
>                  break;
> @@ -4577,5 +4586,41 @@ int main(int argc, char **argv, char **envp)
>      migration_object_finalize();
>      /* TODO: unref root container, check all devices are ok */
>  
> +    if (exit_script) {
> +        int pid, status;
> +        char *args[5];
> +
> +        /* try to launch network script */

Not "network" anymore ;)

> +        pid = fork();
> +        if (pid < 0) {
> +            error_report("could not launch exit script '%s'", exit_script);
> +            exit(1);
> +        }
> +        if (pid == 0) {
> +            int open_max = sysconf(_SC_OPEN_MAX), i;
> +
> +            for (i = 3; i < open_max; i++) {
> +                close(i);
> +            }
> +            args[0] = (char *)exit_script;
> +            args[1] = g_strdup_printf("%d", shutdown_reason);
> +            args[2] = g_strdup_printf("%d", shutdown_was_reset);
> +            args[3] = qemu_get_vm_name();
> +            args[4] = NULL;
> +            execv(exit_script, args);
> +            _exit(1);
> +        } else {
> +            while (waitpid(pid, &status, 0) != pid) {
> +                /* loop */
> +            }
> +
> +            if (!WIFEXITED(status) || WEXITSTATUS(status) != 0) {
> +                error_report("exit script '%s' failed with status %d",
> +                             exit_script, status);
> +                exit(1);
> +            }
> +        }
> +    }
> +
>      return 0;
>  }
> 
