Received: from eggs.gnu.org ([2001:4830:134:3::10]:58926)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dsWPH-00051q-51
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 11:50:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dsWPE-0000qo-P9
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 11:50:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41996)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dsWPE-0000q9-Ft
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 11:50:20 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5762F7E420
	for <qemu-devel@nongnu.org>; Thu, 14 Sep 2017 15:50:19 +0000 (UTC)
Date: Thu, 14 Sep 2017 16:50:12 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170914155012.GD11763@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170908114407.25906-1-otubo@redhat.com>
	<20170908114407.25906-3-otubo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170908114407.25906-3-otubo@redhat.com>
Subject: Re: [Qemu-devel] [PATCHv6 2/5] seccomp: add obsolete argument to
 command line
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Otubo <otubo@redhat.com>
Cc: qemu-devel@nongnu.org, thuth@redhat.com

On Fri, Sep 08, 2017 at 01:44:04PM +0200, Eduardo Otubo wrote:
> This patch introduces the argument [,obsolete=allow] to the `-sandbox on'
> option. It allows Qemu to run safely on old system that still relies on
> old system calls.
> 
> Signed-off-by: Eduardo Otubo <otubo@redhat.com>
> ---
>  include/sysemu/seccomp.h |  3 ++-
>  qemu-options.hx          | 12 ++++++++++--
>  qemu-seccomp.c           | 19 ++++++++++++++++++-
>  vl.c                     | 23 ++++++++++++++++++++++-
>  4 files changed, 52 insertions(+), 5 deletions(-)
> 
> diff --git a/include/sysemu/seccomp.h b/include/sysemu/seccomp.h
> index 23b9c3c789..215138a372 100644
> --- a/include/sysemu/seccomp.h
> +++ b/include/sysemu/seccomp.h
> @@ -16,8 +16,9 @@
>  #define QEMU_SECCOMP_H
>  
>  #define QEMU_SECCOMP_SET_DEFAULT     (1 << 0)
> +#define QEMU_SECCOMP_SET_OBSOLETE    (1 << 1)
>  
>  #include <seccomp.h>
>  
> -int seccomp_start(void);
> +int seccomp_start(uint32_t seccomp_opts);
>  #endif
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 9f6e2adfff..72150c6b84 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -4017,13 +4017,21 @@ Old param mode (ARM only).
>  ETEXI
>  
>  DEF("sandbox", HAS_ARG, QEMU_OPTION_sandbox, \
> -    "-sandbox <arg>  Enable seccomp mode 2 system call filter (default 'off').\n",
> +    "-sandbox on[,obsolete=allow|deny]\n" \
> +    "                Enable seccomp mode 2 system call filter (default 'off').\n" \
> +    "                use 'obsolete' to allow obsolete system calls that are provided\n" \
> +    "                    by the kernel, but typically no longer used by modern\n" \
> +    "                    C library implementations.\n",
>      QEMU_ARCH_ALL)
>  STEXI
> -@item -sandbox @var{arg}
> +@item -sandbox @var{arg}[,obsolete=@var{string}]
>  @findex -sandbox
>  Enable Seccomp mode 2 system call filter. 'on' will enable syscall filtering and 'off' will
>  disable it.  The default is 'off'.
> +@table @option
> +@item obsolete=@var{string}
> +Enable Obsolete system calls
> +@end table
>  ETEXI
>  
>  DEF("readconfig", HAS_ARG, QEMU_OPTION_readconfig,
> diff --git a/qemu-seccomp.c b/qemu-seccomp.c
> index f66613fc71..8a5fbd2ff1 100644
> --- a/qemu-seccomp.c
> +++ b/qemu-seccomp.c
> @@ -55,9 +55,22 @@ static const struct QemuSeccompSyscall blacklist[] = {
>      { SCMP_SYS(tuxcall),                QEMU_SECCOMP_SET_DEFAULT },
>      { SCMP_SYS(ulimit),                 QEMU_SECCOMP_SET_DEFAULT },
>      { SCMP_SYS(vserver),                QEMU_SECCOMP_SET_DEFAULT },
> +    /* obsolete */
> +    { SCMP_SYS(readdir),                QEMU_SECCOMP_SET_OBSOLETE },
> +    { SCMP_SYS(_sysctl),                QEMU_SECCOMP_SET_OBSOLETE },
> +    { SCMP_SYS(bdflush),                QEMU_SECCOMP_SET_OBSOLETE },
> +    { SCMP_SYS(create_module),          QEMU_SECCOMP_SET_OBSOLETE },
> +    { SCMP_SYS(get_kernel_syms),        QEMU_SECCOMP_SET_OBSOLETE },
> +    { SCMP_SYS(query_module),           QEMU_SECCOMP_SET_OBSOLETE },
> +    { SCMP_SYS(sgetmask),               QEMU_SECCOMP_SET_OBSOLETE },
> +    { SCMP_SYS(ssetmask),               QEMU_SECCOMP_SET_OBSOLETE },
> +    { SCMP_SYS(sysfs),                  QEMU_SECCOMP_SET_OBSOLETE },
> +    { SCMP_SYS(uselib),                 QEMU_SECCOMP_SET_OBSOLETE },
> +    { SCMP_SYS(ustat),                  QEMU_SECCOMP_SET_OBSOLETE },
>  };
>  
> -int seccomp_start(void)
> +
> +int seccomp_start(uint32_t seccomp_opts)
>  {
>      int rc = 0;
>      unsigned int i = 0;
> @@ -70,6 +83,10 @@ int seccomp_start(void)
>      }
>  
>      for (i = 0; i < ARRAY_SIZE(blacklist); i++) {
> +        if (!(seccomp_opts & blacklist[i].set)) {
> +            continue;
> +        }
> +
>          rc = seccomp_rule_add(ctx, SCMP_ACT_KILL, blacklist[i].num, 0);
>          if (rc < 0) {
>              goto seccomp_return;
> diff --git a/vl.c b/vl.c
> index 76e0b3a946..62b71dd529 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -271,6 +271,10 @@ static QemuOptsList qemu_sandbox_opts = {
>              .name = "enable",
>              .type = QEMU_OPT_BOOL,
>          },
> +        {
> +            .name = "obsolete",
> +            .type = QEMU_OPT_STRING,
> +        },
>          { /* end of list */ }
>      },
>  };
> @@ -1034,7 +1038,24 @@ static int parse_sandbox(void *opaque, QemuOpts *opts, Error **errp)
>  {
>      if (qemu_opt_get_bool(opts, "enable", false)) {
>  #ifdef CONFIG_SECCOMP
> -        if (seccomp_start() < 0) {
> +        uint32_t seccomp_opts = QEMU_SECCOMP_SET_DEFAULT
> +                | QEMU_SECCOMP_SET_OBSOLETE;
> +        const char *value = NULL;
> +
> +        value = qemu_opt_get(opts, "obsolete");
> +        if (value) {
> +            if (g_str_equal(value, "allow")) {
> +                seccomp_opts &= ~QEMU_SECCOMP_SET_OBSOLETE;
> +            } else if (g_str_equal(value, "deny")) {
> +                /* this is the default option, this if is here
> +                 * to provide a little bit of consistency for
> +                 * the command line */
> +            } else {
> +                error_report("invalid argument for obsolete");

Needs a 'return -1;'

> +            }
> +        }
> +
> +        if (seccomp_start(seccomp_opts) < 0) {
>              error_report("failed to install seccomp syscall filter "
>                           "in the kernel");
>              return -1;

If that bug is fixed

Reviewed-by: Daniel P. Berrange <berrange@redhat.com>


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
