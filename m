Received: from eggs.gnu.org ([2001:4830:134:3::10]:55771)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1g7yut-0001PK-BS
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 04:23:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1g7yjx-0004XN-BF
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 04:12:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57870)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1g7yjs-0004QT-Lz
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 04:12:06 -0400
References: <20181003091344.24496-1-d.csapak@proxmox.com>
	<20181003091344.24496-2-d.csapak@proxmox.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <27e32199-a81f-f693-351e-6c5dda5bf308@redhat.com>
Date: Thu, 4 Oct 2018 10:11:58 +0200
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

On 2018-10-03 11:13, Dominik Csapak wrote:
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
[...]
> @@ -4577,5 +4586,41 @@ int main(int argc, char **argv, char **envp)
>      migration_object_finalize();
>      /* TODO: unref root container, check all devices are ok */
>  
> +    if (exit_script) {
> +        int pid, status;
> +        char *args[5];
> +
> +        /* try to launch network script */
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

Our main() function is already huge, so please put this into a separate
function instead (or even better, refactor the launch_script function as
you've mentioned it in the cover letter).

 Thanks,
  Thomas
