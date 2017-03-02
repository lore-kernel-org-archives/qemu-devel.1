Received: from eggs.gnu.org ([2001:4830:134:3::10]:49543)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cjHpw-00086L-SQ
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 22:55:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cjHpt-0008HC-RW
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 22:55:28 -0500
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:33038)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cjHpt-0008G7-MX
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 22:55:25 -0500
Received: by mail-qk0-x241.google.com with SMTP id n186so15940487qkb.0
	for <qemu-devel@nongnu.org>; Wed, 01 Mar 2017 19:55:24 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170302005448.21336-1-laurent@vivier.eu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <aaa1d219-6f91-ed6c-179e-61adbcfa2b50@amsat.org>
Date: Thu, 2 Mar 2017 00:55:20 -0300
MIME-Version: 1.0
In-Reply-To: <20170302005448.21336-1-laurent@vivier.eu>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] linux-user: fix inotify
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, Riku Voipio <riku.voipio@iki.fi>
Cc: qemu-devel@nongnu.org

On 03/01/2017 09:54 PM, Laurent Vivier wrote:
> When a fd is opened using inotify_init(), a read provides
> one or more inotify_event structures:
>
>     struct inotify_event {
>         int      wd;
>         uint32_t mask;
>         uint32_t cookie;
>         uint32_t len;
>         char     name[];
>     };
>
> The integer fields must be byte-swapped to the target endianness.
>
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  linux-user/syscall.c | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
>
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index cec8428..c2c4f3a 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -7671,6 +7671,33 @@ static target_timer_t get_timer_id(abi_long arg)
>      return timerid;
>  }
>
> +#if (defined(TARGET_NR_inotify_init) && defined(__NR_inotify_init)) || \
> +    (defined(CONFIG_INOTIFY1) && defined(TARGET_NR_inotify_init1) && \
> +     defined(__NR_inotify_init1))
> +static abi_long host_to_target_data_inotify(void *buf, size_t len)
> +{
> +    struct inotify_event *ev;
> +    int i;
> +    uint32_t name_len;
> +
> +    for (i = 0; i < len; i += sizeof(struct inotify_event) + name_len) {
> +        ev = (struct inotify_event *)((char *)buf + i);
> +        name_len = ev->len;
> +
> +        ev->wd = tswap32(ev->wd);
> +        ev->mask = tswap32(ev->mask);
> +        ev->cookie = tswap32(ev->cookie);
> +        ev->len = tswap32(name_len);
> +    }
> +
> +    return len;
> +}
> +
> +static TargetFdTrans target_inotify_trans = {
> +    .host_to_target_data = host_to_target_data_inotify,
> +};
> +#endif
> +
>  /* do_syscall() should always have a single exit point at the end so
>     that actions, such as logging of syscall results, can be performed.
>     All errnos that do_syscall() returns must be -TARGET_<errcode>. */
> @@ -11694,6 +11721,7 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
>  #if defined(TARGET_NR_inotify_init) && defined(__NR_inotify_init)
>      case TARGET_NR_inotify_init:
>          ret = get_errno(sys_inotify_init());
> +        fd_trans_register(ret, &target_inotify_trans);
>          break;
>  #endif
>  #ifdef CONFIG_INOTIFY1
> @@ -11701,6 +11729,7 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
>      case TARGET_NR_inotify_init1:
>          ret = get_errno(sys_inotify_init1(target_to_host_bitmask(arg1,
>                                            fcntl_flags_tbl)));
> +        fd_trans_register(ret, &target_inotify_trans);
>          break;
>  #endif
>  #endif
>
