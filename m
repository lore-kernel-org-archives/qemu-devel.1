Received: from eggs.gnu.org ([2001:4830:134:3::10]:33824)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cnl8j-0007Dk-D4
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 08:01:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cnl8g-0005LV-9E
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 08:01:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50122)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1cnl8g-0005KN-0f
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 08:01:18 -0400
References: <20170314113209.12025-1-eduardo.otubo@profitbricks.com>
	<20170314113209.12025-3-eduardo.otubo@profitbricks.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <c11b8647-2134-70c9-5ca9-50898eefd005@redhat.com>
Date: Tue, 14 Mar 2017 13:01:11 +0100
MIME-Version: 1.0
In-Reply-To: <20170314113209.12025-3-eduardo.otubo@profitbricks.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/5] seccomp: add obsolete argument to
 command line
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Otubo <eduardo.otubo@profitbricks.com>, qemu-devel@nongnu.org

On 14.03.2017 12:32, Eduardo Otubo wrote:
> This patch introduces the argument [,obsolete=allow] to the `-sandbox on'
> option. It allows Qemu to run safely on old system that still relies on
> old system calls.
> 
> Signed-off-by: Eduardo Otubo <eduardo.otubo@profitbricks.com>
> ---
>  include/sysemu/seccomp.h |  4 +++-
>  qemu-options.hx          |  9 +++++++--
>  qemu-seccomp.c           | 47 ++++++++++++++++++++++++++++++++++++++++++++++-
>  vl.c                     | 16 +++++++++++++++-
>  4 files changed, 71 insertions(+), 5 deletions(-)
> 
> diff --git a/include/sysemu/seccomp.h b/include/sysemu/seccomp.h
> index cfc06008cb..7a7bde246b 100644
> --- a/include/sysemu/seccomp.h
> +++ b/include/sysemu/seccomp.h
> @@ -15,7 +15,9 @@
>  #ifndef QEMU_SECCOMP_H
>  #define QEMU_SECCOMP_H
>  
> +#define OBSOLETE    0x0001
> +
>  #include <seccomp.h>
>  
> -int seccomp_start(void);
> +int seccomp_start(uint8_t seccomp_opts);
>  #endif
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 8dd8ee34a6..1403d0c85f 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -3732,13 +3732,18 @@ Old param mode (ARM only).
>  ETEXI
>  
>  DEF("sandbox", HAS_ARG, QEMU_OPTION_sandbox, \
> -    "-sandbox <arg>  Enable seccomp mode 2 system call filter (default 'off').\n",
> +    "-sandbox on[,obsolete=allow]  Enable seccomp mode 2 system call filter (default 'off').\n" \
> +    "                              obsolete: Allow obsolete system calls",
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
> index f8877b07b5..5ef36890da 100644
> --- a/qemu-seccomp.c
> +++ b/qemu-seccomp.c
> @@ -31,6 +31,35 @@ struct QemuSeccompSyscall {
>      uint8_t priority;
>  };
>  
> +static const struct QemuSeccompSyscall obsolete[] = {
> +    { SCMP_SYS(readdir), 255 },
> +    { SCMP_SYS(_sysctl), 255 },
> +    { SCMP_SYS(afs_syscall), 255 },
> +    { SCMP_SYS(bdflush), 255 },
> +    { SCMP_SYS(break), 255 },
> +    { SCMP_SYS(create_module), 255 },
> +    { SCMP_SYS(ftime), 255 },
> +    { SCMP_SYS(get_kernel_syms), 255 },
> +    { SCMP_SYS(getpmsg), 255 },
> +    { SCMP_SYS(gtty), 255 },
> +    { SCMP_SYS(lock), 255 },
> +    { SCMP_SYS(mpx), 255 },
> +    { SCMP_SYS(prof), 255 },
> +    { SCMP_SYS(profil), 255 },
> +    { SCMP_SYS(putpmsg), 255 },
> +    { SCMP_SYS(query_module), 255 },
> +    { SCMP_SYS(security), 255 },
> +    { SCMP_SYS(sgetmask), 255 },
> +    { SCMP_SYS(ssetmask), 255 },
> +    { SCMP_SYS(stty), 255 },
> +    { SCMP_SYS(sysfs), 255 },
> +    { SCMP_SYS(tuxcall), 255 },
> +    { SCMP_SYS(ulimit), 255 },
> +    { SCMP_SYS(uselib), 255 },
> +    { SCMP_SYS(ustat), 255 },
> +    { SCMP_SYS(vserver), 255 },
> +};
> +
>  static const struct QemuSeccompSyscall blacklist[] = {
>      { SCMP_SYS(reboot), 255 },
>      { SCMP_SYS(swapon), 255 },
> @@ -56,7 +85,20 @@ static const struct QemuSeccompSyscall blacklist[] = {
>      { SCMP_SYS(vserver), 255 },
>  };
>  
> -int seccomp_start(void)
> +static int is_obsolete(int syscall)
> +{
> +    unsigned int i = 0;
> +
> +    for (i = 0; i < ARRAY_SIZE(obsolete); i++) {
> +        if (syscall == obsolete[i].num) {
> +            return 1;
> +        }
> +    }
> +
> +    return 0;
> +}
> +
> +int seccomp_start(uint8_t seccomp_opts)
>  {
>      int rc = 0;
>      unsigned int i = 0;
> @@ -69,6 +111,9 @@ int seccomp_start(void)
>      }
>  
>      for (i = 0; i < ARRAY_SIZE(blacklist); i++) {
> +        if ((seccomp_opts & OBSOLETE) && is_obsolete(blacklist[i].num)) {
> +            continue;
> +        }
>          rc = seccomp_rule_add(ctx, SCMP_ACT_KILL, blacklist[i].num, 0);
>          if (rc < 0) {
>              goto seccomp_return;
> diff --git a/vl.c b/vl.c
> index 1a95500ac7..7b08b3383b 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -269,6 +269,10 @@ static QemuOptsList qemu_sandbox_opts = {
>              .name = "enable",
>              .type = QEMU_OPT_BOOL,
>          },
> +        {
> +            .name = "obsolete",
> +            .type = QEMU_OPT_STRING,
> +        },

Since this is basically a boolean switch, could you maybe rather use
"QEMU_OPT_BOOL" here, too (and also in the following patches)? I think
it is also easier for the users to memorize "obsolete=on" instead of
yet-another-parameter-syntax like "obsolete=allow".

 Thomas
