Received: from eggs.gnu.org ([2001:4830:134:3::10]:37591)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dqFp8-0001mZ-7H
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 05:43:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dqFp3-0006xh-9N
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 05:43:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39128)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dqFp3-0006vj-0p
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 05:43:37 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EBBCF4E341
	for <qemu-devel@nongnu.org>; Fri,  8 Sep 2017 09:43:31 +0000 (UTC)
References: <20170908091027.9104-1-otubo@redhat.com>
	<20170908091027.9104-2-otubo@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <ac10832b-06bc-a797-b472-a11ff2d74cdc@redhat.com>
Date: Fri, 8 Sep 2017 11:43:27 +0200
MIME-Version: 1.0
In-Reply-To: <20170908091027.9104-2-otubo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCHv5 1/5] seccomp: changing from whitelist to
 blacklist
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Otubo <otubo@redhat.com>, qemu-devel@nongnu.org

On 08.09.2017 11:10, Eduardo Otubo wrote:
> This patch changes the default behavior of the seccomp filter from
> whitelist to blacklist. By default now all system calls are allowed and
> a small black list of definitely forbidden ones was created.
> 
> Signed-off-by: Eduardo Otubo <otubo@redhat.com>
> ---
>  include/sysemu/seccomp.h |   2 +
>  qemu-seccomp.c           | 264 ++++++-----------------------------------------
>  vl.c                     |   1 -
>  3 files changed, 35 insertions(+), 232 deletions(-)
> 
> diff --git a/include/sysemu/seccomp.h b/include/sysemu/seccomp.h
> index cfc06008cb..23b9c3c789 100644
> --- a/include/sysemu/seccomp.h
> +++ b/include/sysemu/seccomp.h
> @@ -15,6 +15,8 @@
>  #ifndef QEMU_SECCOMP_H
>  #define QEMU_SECCOMP_H
>  
> +#define QEMU_SECCOMP_SET_DEFAULT     (1 << 0)
> +
>  #include <seccomp.h>
>  
>  int seccomp_start(void);
> diff --git a/qemu-seccomp.c b/qemu-seccomp.c
> index df75d9c471..bc9a1f77ff 100644
> --- a/qemu-seccomp.c
> +++ b/qemu-seccomp.c
> @@ -28,232 +28,34 @@
>  
>  struct QemuSeccompSyscall {
>      int32_t num;
> -    uint8_t priority;
> +    int type;

What's this "type" field good for? I failed to spot the place in the
sources where you are using it...? Anyway, some comments here right
after the struct members would be useful.

 Thomas

> +    uint8_t set;
>  };
>  
> -static const struct QemuSeccompSyscall seccomp_whitelist[] = {
> -    { SCMP_SYS(timer_settime), 255 },
[...]
> -    { SCMP_SYS(memfd_create), 240 },
> -#ifdef HAVE_CACHEFLUSH
> -    { SCMP_SYS(cacheflush), 240 },
> -#endif
> -    { SCMP_SYS(sysinfo), 240 },
> +static const struct QemuSeccompSyscall blacklist[] = {
> +    /* default set of syscalls to blacklist */
> +    { SCMP_SYS(reboot),                 1, QEMU_SECCOMP_SET_DEFAULT },
> +    { SCMP_SYS(swapon),                 1, QEMU_SECCOMP_SET_DEFAULT },
> +    { SCMP_SYS(swapoff),                1, QEMU_SECCOMP_SET_DEFAULT },
> +    { SCMP_SYS(syslog),                 1, QEMU_SECCOMP_SET_DEFAULT },
> +    { SCMP_SYS(mount),                  1, QEMU_SECCOMP_SET_DEFAULT },
> +    { SCMP_SYS(umount),                 1, QEMU_SECCOMP_SET_DEFAULT },
> +    { SCMP_SYS(kexec_load),             1, QEMU_SECCOMP_SET_DEFAULT },
> +    { SCMP_SYS(afs_syscall),            1, QEMU_SECCOMP_SET_DEFAULT },
> +    { SCMP_SYS(break),                  1, QEMU_SECCOMP_SET_DEFAULT },
> +    { SCMP_SYS(ftime),                  1, QEMU_SECCOMP_SET_DEFAULT },
> +    { SCMP_SYS(getpmsg),                1, QEMU_SECCOMP_SET_DEFAULT },
> +    { SCMP_SYS(gtty),                   1, QEMU_SECCOMP_SET_DEFAULT },
> +    { SCMP_SYS(lock),                   1, QEMU_SECCOMP_SET_DEFAULT },
> +    { SCMP_SYS(mpx),                    1, QEMU_SECCOMP_SET_DEFAULT },
> +    { SCMP_SYS(prof),                   1, QEMU_SECCOMP_SET_DEFAULT },
> +    { SCMP_SYS(profil),                 1, QEMU_SECCOMP_SET_DEFAULT },
> +    { SCMP_SYS(putpmsg),                1, QEMU_SECCOMP_SET_DEFAULT },
> +    { SCMP_SYS(security),               1, QEMU_SECCOMP_SET_DEFAULT },
> +    { SCMP_SYS(stty),                   1, QEMU_SECCOMP_SET_DEFAULT },
> +    { SCMP_SYS(tuxcall),                1, QEMU_SECCOMP_SET_DEFAULT },
> +    { SCMP_SYS(ulimit),                 1, QEMU_SECCOMP_SET_DEFAULT },
> +    { SCMP_SYS(vserver),                1, QEMU_SECCOMP_SET_DEFAULT },
>  };
>  
>  int seccomp_start(void)
> @@ -262,19 +64,19 @@ int seccomp_start(void)
>      unsigned int i = 0;
>      scmp_filter_ctx ctx;
>  
> -    ctx = seccomp_init(SCMP_ACT_KILL);
> +    ctx = seccomp_init(SCMP_ACT_ALLOW);
>      if (ctx == NULL) {
>          rc = -1;
>          goto seccomp_return;
>      }
>  
> -    for (i = 0; i < ARRAY_SIZE(seccomp_whitelist); i++) {
> -        rc = seccomp_rule_add(ctx, SCMP_ACT_ALLOW, seccomp_whitelist[i].num, 0);
> -        if (rc < 0) {
> -            goto seccomp_return;
> +    for (i = 0; i < ARRAY_SIZE(blacklist); i++) {
> +        switch (blacklist[i].set) {
> +        default:
> +            break;
>          }
> -        rc = seccomp_syscall_priority(ctx, seccomp_whitelist[i].num,
> -                                      seccomp_whitelist[i].priority);
> +
> +        rc = seccomp_rule_add(ctx, SCMP_ACT_KILL, blacklist[i].num, 0);
>          if (rc < 0) {
>              goto seccomp_return;
>          }
> diff --git a/vl.c b/vl.c
> index fb1f05b937..76e0b3a946 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -1032,7 +1032,6 @@ static int bt_parse(const char *opt)
>  
>  static int parse_sandbox(void *opaque, QemuOpts *opts, Error **errp)
>  {
> -    /* FIXME: change this to true for 1.3 */
>      if (qemu_opt_get_bool(opts, "enable", false)) {
>  #ifdef CONFIG_SECCOMP
>          if (seccomp_start() < 0) {
> 
