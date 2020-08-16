Return-Path: <SRS0=YAkC=B2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9F78C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2020 21:42:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C48E2075D
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2020 21:42:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AuIsU5d5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C48E2075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38218 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7QQU-0000Ny-L3
	for qemu-devel@archiver.kernel.org; Sun, 16 Aug 2020 17:42:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50970)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k7QPx-0008Pv-EC
 for qemu-devel@nongnu.org; Sun, 16 Aug 2020 17:42:17 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:35525)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k7QPv-0001TO-1a
 for qemu-devel@nongnu.org; Sun, 16 Aug 2020 17:42:17 -0400
Received: by mail-wr1-x444.google.com with SMTP id f1so13039834wro.2
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2020 14:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=4kvA6ZQ2dTv7FW/oSqEZ+3vrh2ordrtN2iUe+CCdHP8=;
 b=AuIsU5d5N+P4BQ56udRhvzbNZbEpEfl4DajpyBDIl8J+rM9SiSU59/xBe+ED2SYeZz
 qmUsARiim5ndiwNNBZi7xa3GsXU9nsdE4EPEEPAstXTykCmRkOCmLoJDSTJYOsGN9S4j
 uj+fSjkHGLf9DAdPOW7pGxQ9xeC2zqrxv6LWT2jR6R/I8hpuWg+V/0s0f6Brz5zLby9A
 2tFf+4OKSeMT9EPqx3HISQeHGtcMbg2GBHFWCfWza0g/QB7wum1GGLs+1aze23ATGRwr
 Sxsaizbj1AJFHjh1MQggPiTI+CGyZtH7tYjehBeG7T79VWvH8S3IjWoo0QjuXx2OVewz
 6zig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=4kvA6ZQ2dTv7FW/oSqEZ+3vrh2ordrtN2iUe+CCdHP8=;
 b=UEYa3sHEXmDGlwaOKq00HDmPPkTaR3phkehvWsU3kIMMr68nVNWVcK4xfKxh0RM7b8
 EMUTXS4X/L0E+ePC51Y/ZmZWlk7FYUUfGDw7SX6GBLVCHjGnnj2/wKqVECxyti+K8l0c
 88kXYDcdET/E8rSbIc3TGZdtuXz4f7MH3QMXgCXDXbr6cjsEQ0ppdS2IXg8tWJ07Rg7P
 +Rb7w/q4Kv+3N2BkSpFGKmCA+dfiq+yCij17gXD4QgAO0gkh2MMjFS1GXi4ct5be0cy0
 eKYbtV8Y5QVh93LMF0zRqrw5feh9HkETlm6dWTVegHEq3XVUpNDKCQsFOKJwloPwwQvk
 Zo1w==
X-Gm-Message-State: AOAM533a/J7g6k8zeKafXjEBM5lgamWBwUw4CwwS77MhSQessnrwL9An
 SHS0A1A53l6Fx1gqmw+0zRg=
X-Google-Smtp-Source: ABdhPJzSEQhgzIFXzToTLN2mXGycTb7KvX2qX5gH8oTkx0axZiJHka3ZN5s2BVVStdDtHexrzV/aIA==
X-Received: by 2002:adf:ca03:: with SMTP id o3mr11620987wrh.330.1597614133384; 
 Sun, 16 Aug 2020 14:42:13 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id y16sm28192461wrr.83.2020.08.16.14.42.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 16 Aug 2020 14:42:12 -0700 (PDT)
Subject: Re: [PATCH] fixed proc myself (linux user) for musl
To: =?UTF-8?B?0JDQvdC00YDQtdC5INCQ0LvQsNC00YzQtdCy?=
 <aladjev.andrew@gmail.com>, qemu-devel@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>, Richard Henderson <rth@twiddle.net>
References: <CAMw0szJ-3vzjE7ZBh+J95iYcVW=03zYROtRLbt28o8EfBD5DKg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <e406661a-b581-2e35-ff3a-d9321ba6ee33@amsat.org>
Date: Sun, 16 Aug 2020 23:42:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAMw0szJ-3vzjE7ZBh+J95iYcVW=03zYROtRLbt28o8EfBD5DKg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Andrew,

Cc'ing the maintainer & Richard.

./scripts/get_maintainer.pl -f linux-user/main.c
Laurent Vivier <laurent@vivier.eu> (maintainer:Linux user)

On 8/16/20 9:58 PM, Андрей Аладьев wrote:
> From: Andrew Aladjev <aladjev.andrew@gmail.com
> <mailto:aladjev.andrew@gmail.com>>
> Date: Sun, 16 Aug 2020 22:50:13 +0300
> Subject: [PATCH] fixed proc myself (linux user) for musl

Your patch has double subject headers...

This link might be helpful:
https://wiki.qemu.org/Contribute/SubmitAPatch#Use_git_format-patch

> Buglink: https://bugs.gentoo.org/587230
> Signed-off-by: Andrew Aladjev <aladjev.andrew@gmail.com
> <mailto:aladjev.andrew@gmail.com>>

Hmmm did you paste the output of git-format-patch in your
email client?

> ---
>  linux-user/Makefile.objs  |  5 +-
>  linux-user/elfload.c      |  7 ++-
>  linux-user/exit.c         |  7 ++-
>  linux-user/main.c         |  2 +-
>  linux-user/qemu.h         |  1 +
>  linux-user/syscall.c      | 85 +++++++++++++---------------------
>  linux-user/syscall_proc.c | 96 +++++++++++++++++++++++++++++++++++++++
>  linux-user/syscall_proc.h |  8 ++++
>  8 files changed, 150 insertions(+), 61 deletions(-)
>  create mode 100644 linux-user/syscall_proc.c
>  create mode 100644 linux-user/syscall_proc.h
> 
> diff --git a/linux-user/Makefile.objs b/linux-user/Makefile.objs
> index 1940910a73..ad84380738 100644
> --- a/linux-user/Makefile.objs
> +++ b/linux-user/Makefile.objs
> @@ -1,7 +1,8 @@
>  obj-y = main.o syscall.o strace.o mmap.o signal.o \
>   elfload.o linuxload.o uaccess.o uname.o \
> - safe-syscall.o $(TARGET_ABI_DIR)/signal.o \
> -        $(TARGET_ABI_DIR)/cpu_loop.o exit.o fd-trans.o
> + safe-syscall.o syscall_proc.o \
> + $(TARGET_ABI_DIR)/cpu_loop.o $(TARGET_ABI_DIR)/signal.o \
> + exit.o fd-trans.o
>  
>  obj-$(TARGET_HAS_BFLT) += flatload.o
>  obj-$(TARGET_I386) += vm86.o
> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
> index 619c054cc4..201db61d91 100644
> --- a/linux-user/elfload.c
> +++ b/linux-user/elfload.c
> @@ -2319,7 +2319,10 @@ exit_errmsg:
>     buffer is sufficiently aligned to present no problems to the host
>     in accessing data at aligned offsets within the buffer.
>  
> -   On return: INFO values will be filled in, as necessary or available.  */
> +   On return: INFO values will be filled in, as necessary or available.
> +
> +   WARNING: this function won't close "image_fd".
> +*/
>  
>  static void load_elf_image(const char *image_name, int image_fd,
>                             struct image_info *info, char **pinterp_name,
> @@ -2576,7 +2579,6 @@ static void load_elf_image(const char *image_name,
> int image_fd,
>  
>      mmap_unlock();
>  
> -    close(image_fd);
>      return;
>  
>   exit_read:
> @@ -2610,6 +2612,7 @@ static void load_elf_interp(const char *filename,
> struct image_info *info,
>      }
>  
>      load_elf_image(filename, fd, info, NULL, bprm_buf);
> +    close(fd);
>      return;
>  
>   exit_perror:
> diff --git a/linux-user/exit.c b/linux-user/exit.c
> index 1594015444..f0626fc432 100644
> --- a/linux-user/exit.c
> +++ b/linux-user/exit.c
> @@ -28,12 +28,15 @@ extern void __gcov_dump(void);
>  
>  void preexit_cleanup(CPUArchState *env, int code)
>  {
> +    close(execfd);
> +
>  #ifdef CONFIG_GPROF
>          _mcleanup();
>  #endif
>  #ifdef CONFIG_GCOV
>          __gcov_dump();
>  #endif
> -        gdb_exit(env, code);
> -        qemu_plugin_atexit_cb();
> +
> +    gdb_exit(env, code);
> +    qemu_plugin_atexit_cb();
>  }
> diff --git a/linux-user/main.c b/linux-user/main.c
> index 22578b1633..9cc6c1e6da 100644
> --- a/linux-user/main.c
> +++ b/linux-user/main.c
> @@ -48,6 +48,7 @@
>  #include "crypto/init.h"
>  
>  char *exec_path;
> +int execfd;
>  
>  int singlestep;
>  static const char *argv0;
> @@ -628,7 +629,6 @@ int main(int argc, char **argv, char **envp)
>      int target_argc;
>      int i;
>      int ret;
> -    int execfd;
>      int log_mask;
>      unsigned long max_reserved_va;
>  
> diff --git a/linux-user/qemu.h b/linux-user/qemu.h
> index 792c74290f..d822f2b9df 100644
> --- a/linux-user/qemu.h
> +++ b/linux-user/qemu.h
> @@ -156,6 +156,7 @@ typedef struct TaskState {
>  } __attribute__((aligned(16))) TaskState;
>  
>  extern char *exec_path;
> +extern int execfd;
>  void init_task_state(TaskState *ts);
>  void task_settid(TaskState *);
>  void stop_all_tasks(void);
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 05f03919ff..483a735c1a 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -122,6 +122,7 @@
>  #include "qapi/error.h"
>  #include "fd-trans.h"
>  #include "tcg/tcg.h"
> +#include "syscall_proc.h"
>  
>  #ifndef CLONE_IO
>  #define CLONE_IO                0x80000000      /* Clone io context */
> @@ -1104,7 +1105,7 @@ static inline rlim_t target_to_host_rlim(abi_ulong
> target_rlim)
>  {
>      abi_ulong target_rlim_swap;
>      rlim_t result;
> -    
> +
>      target_rlim_swap = tswapal(target_rlim);
>      if (target_rlim_swap == TARGET_RLIM_INFINITY)
>          return RLIM_INFINITY;
> @@ -1112,7 +1113,7 @@ static inline rlim_t target_to_host_rlim(abi_ulong
> target_rlim)
>      result = target_rlim_swap;
>      if (target_rlim_swap != (rlim_t)result)
>          return RLIM_INFINITY;
> -    
> +
>      return result;
>  }
>  #endif
> @@ -1122,13 +1123,13 @@ static inline abi_ulong
> host_to_target_rlim(rlim_t rlim)
>  {
>      abi_ulong target_rlim_swap;
>      abi_ulong result;
> -    
> +
>      if (rlim == RLIM_INFINITY || rlim != (abi_long)rlim)
>          target_rlim_swap = TARGET_RLIM_INFINITY;
>      else
>          target_rlim_swap = rlim;
>      result = tswapal(target_rlim_swap);
> -    
> +
>      return result;
>  }
>  #endif
> @@ -1615,9 +1616,9 @@ static inline abi_long target_to_host_cmsg(struct
> msghdr *msgh,
>      abi_ulong target_cmsg_addr;
>      struct target_cmsghdr *target_cmsg, *target_cmsg_start;
>      socklen_t space = 0;
> -    
> +
>      msg_controllen = tswapal(target_msgh->msg_controllen);
> -    if (msg_controllen < sizeof (struct target_cmsghdr))
> +    if (msg_controllen < sizeof (struct target_cmsghdr))
>          goto the_end;
>      target_cmsg_addr = tswapal(target_msgh->msg_control);
>      target_cmsg = lock_user(VERIFY_READ, target_cmsg_addr,
> msg_controllen, 1);
> @@ -1703,7 +1704,7 @@ static inline abi_long host_to_target_cmsg(struct
> target_msghdr *target_msgh,
>      socklen_t space = 0;
>  
>      msg_controllen = tswapal(target_msgh->msg_controllen);
> -    if (msg_controllen < sizeof (struct target_cmsghdr))
> +    if (msg_controllen < sizeof (struct target_cmsghdr))
>          goto the_end;
>      target_cmsg_addr = tswapal(target_msgh->msg_control);
>      target_cmsg = lock_user(VERIFY_WRITE, target_cmsg_addr,
> msg_controllen, 0);
> @@ -5750,7 +5751,7 @@ abi_long do_set_thread_area(CPUX86State *env,
> abi_ulong ptr)
>      }
>      unlock_user_struct(target_ldt_info, ptr, 1);
>  
> -    if (ldt_info.entry_number < TARGET_GDT_ENTRY_TLS_MIN ||
> +    if (ldt_info.entry_number < TARGET_GDT_ENTRY_TLS_MIN ||
>          ldt_info.entry_number > TARGET_GDT_ENTRY_TLS_MAX)
>             return -TARGET_EINVAL;
>      seg_32bit = ldt_info.flags & 1;
> @@ -5828,7 +5829,7 @@ static abi_long do_get_thread_area(CPUX86State
> *env, abi_ulong ptr)
>      lp = (uint32_t *)(gdt_table + idx);
>      entry_1 = tswap32(lp[0]);
>      entry_2 = tswap32(lp[1]);
> -    
> +
>      read_exec_only = ((entry_2 >> 9) & 1) ^ 1;
>      contents = (entry_2 >> 10) & 3;
>      seg_not_present = ((entry_2 >> 15) & 1) ^ 1;
> @@ -5844,8 +5845,8 @@ static abi_long do_get_thread_area(CPUX86State
> *env, abi_ulong ptr)
>          (read_exec_only << 3) | (limit_in_pages << 4) |
>          (seg_not_present << 5) | (useable << 6) | (lm << 7);
>      limit = (entry_1 & 0xffff) | (entry_2  & 0xf0000);
> -    base_addr = (entry_1 >> 16) |
> -        (entry_2 & 0xff000000) |
> +    base_addr = (entry_1 >> 16) |
> +        (entry_2 & 0xff000000) |
>          ((entry_2 & 0xff) << 16);
>      target_ldt_info->base_addr = tswapal(base_addr);
>      target_ldt_info->limit = tswap32(limit);
> @@ -7353,38 +7354,6 @@ static int open_self_auxv(void *cpu_env, int fd)
>      return 0;
>  }
>  
> -static int is_proc_myself(const char *filename, const char *entry)
> -{
> -    if (!strncmp(filename, "/proc/", strlen("/proc/"))) {
> -        filename += strlen("/proc/");
> -        if (!strncmp(filename, "self/", strlen("self/"))) {
> -            filename += strlen("self/");
> -        } else if (*filename >= '1' && *filename <= '9') {
> -            char myself[80];
> -            snprintf(myself, sizeof(myself), "%d/", getpid());
> -            if (!strncmp(filename, myself, strlen(myself))) {
> -                filename += strlen(myself);
> -            } else {
> -                return 0;
> -            }
> -        } else {
> -            return 0;
> -        }
> -        if (!strcmp(filename, entry)) {
> -            return 1;
> -        }
> -    }
> -    return 0;
> -}
> -
> -#if defined(HOST_WORDS_BIGENDIAN) != defined(TARGET_WORDS_BIGENDIAN) || \
> -    defined(TARGET_SPARC) || defined(TARGET_M68K)
> -static int is_proc(const char *filename, const char *entry)
> -{
> -    return strcmp(filename, entry) == 0;
> -}
> -#endif
> -
>  #if defined(HOST_WORDS_BIGENDIAN) != defined(TARGET_WORDS_BIGENDIAN)
>  static int open_net_route(void *cpu_env, int fd)
>  {
> @@ -7460,20 +7429,19 @@ static int do_openat(void *cpu_env, int dirfd,
> const char *pathname, int flags,
>          { "auxv", open_self_auxv, is_proc_myself },
>          { "cmdline", open_self_cmdline, is_proc_myself },
>  #if defined(HOST_WORDS_BIGENDIAN) != defined(TARGET_WORDS_BIGENDIAN)
> -        { "/proc/net/route", open_net_route, is_proc },
> +        { "net/route", open_net_route, is_proc },
>  #endif
>  #if defined(TARGET_SPARC)
> -        { "/proc/cpuinfo", open_cpuinfo, is_proc },
> +        { "cpuinfo", open_cpuinfo, is_proc },
>  #endif
>  #if defined(TARGET_M68K)
> -        { "/proc/hardware", open_hardware, is_proc },
> +        { "hardware", open_hardware, is_proc },
>  #endif
>          { NULL, NULL, NULL }
>      };
>  
> -    if (is_proc_myself(pathname, "exe")) {
> -        int execfd = qemu_getauxval(AT_EXECFD);
> -        return execfd ? execfd : safe_openat(dirfd, exec_path, flags,
> mode);
> +    if (is_proc_myself_exe(pathname)) {
> +        return execfd;
>      }
>  
>      for (fake_open = fakes; fake_open->filename; fake_open++) {
> @@ -7728,8 +7696,17 @@ static abi_long do_syscall1(void *cpu_env, int
> num, abi_long arg1,
>          return ret;
>  #endif
>      case TARGET_NR_close:
> -        fd_trans_unregister(arg1);
> -        return get_errno(close(arg1));
> +        {
> +            int fd = arg1;
> +            if (fd == execfd) {
> +                // We don't need to close execfd.
> +                // It will be closed on qemu exit.
> +                return 0;
> +            }
> +
> +            fd_trans_unregister(fd);
> +            return get_errno(close(fd));
> +        }
>  
>      case TARGET_NR_brk:
>          return do_brk(arg1);
> @@ -9031,7 +9008,7 @@ static abi_long do_syscall1(void *cpu_env, int
> num, abi_long arg1,
>              } else if (!arg3) {
>                  /* Short circuit this for the magic exe check. */
>                  ret = -TARGET_EINVAL;
> -            } else if (is_proc_myself((const char *)p, "exe")) {
> +            } else if (is_proc_myself_exe((const char *)p)) {
>                  char real[PATH_MAX], *temp;
>                  temp = realpath(exec_path, real);
>                  /* Return value is # of bytes that we wrote to the
> buffer. */
> @@ -9060,7 +9037,7 @@ static abi_long do_syscall1(void *cpu_env, int
> num, abi_long arg1,
>              p2 = lock_user(VERIFY_WRITE, arg3, arg4, 0);
>              if (!p || !p2) {
>                  ret = -TARGET_EFAULT;
> -            } else if (is_proc_myself((const char *)p, "exe")) {
> +            } else if (is_proc_myself_exe((const char *)p)) {
>                  char real[PATH_MAX], *temp;
>                  temp = realpath(exec_path, real);
>                  ret = temp == NULL ? get_errno(-1) : strlen(real) ;
> @@ -10847,7 +10824,7 @@ static abi_long do_syscall1(void *cpu_env, int
> num, abi_long arg1,
>          return get_errno(fchown(arg1, low2highuid(arg2),
> low2highgid(arg3)));
>  #if defined(TARGET_NR_fchownat)
>      case TARGET_NR_fchownat:
> -        if (!(p = lock_user_string(arg2)))
> +        if (!(p = lock_user_string(arg2)))
>              return -TARGET_EFAULT;
>          ret = get_errno(fchownat(arg1, p, low2highuid(arg3),
>                                   low2highgid(arg4), arg5));
> diff --git a/linux-user/syscall_proc.c b/linux-user/syscall_proc.c
> new file mode 100644
> index 0000000000..e85ca99c16
> --- /dev/null
> +++ b/linux-user/syscall_proc.c
> @@ -0,0 +1,96 @@
> +#include "qemu/osdep.h"
> +#include "elf.h"
> +
> +#include "syscall_proc.h"
> +#include "qemu.h"
> +
> +#define PROC "/proc/"
> +#define SELF "self/"
> +
> +#define STARTS_WITH(path, CONSTANT) \
> +  strlen(path) >= strlen(CONSTANT) && strncmp(path, CONSTANT,
> strlen(CONSTANT)) == 0
> +
> +static inline char *scope_to_proc(const char *path)
> +{
> +    if (STARTS_WITH(path, PROC)) {
> +        return (char *)path + strlen(PROC);
> +    }
> +
> +    return NULL;
> +}
> +
> +static inline char *scope_to_proc_myself(const char *path)
> +{
> +    char *scope_path = scope_to_proc(path);
> +    if (scope_path == NULL) {
> +        return NULL;
> +    }
> +
> +    if (STARTS_WITH(scope_path, SELF)) {
> +        return scope_path + strlen(SELF);
> +    }
> +
> +    if (strlen(scope_path) >= 1 && *scope_path >= '1' && *scope_path <=
> '9') {
> +        char pid_path[80];
> +        snprintf(pid_path, sizeof(pid_path), "%d/", getpid());
> +        if (STARTS_WITH(scope_path, pid_path)) {
> +            return scope_path + strlen(pid_path);
> +        }
> +    }
> +
> +    return NULL;
> +}
> +
> +int is_proc(const char *path, const char *entry)
> +{
> +    char *scope_path = scope_to_proc(path);
> +    if (scope_path == NULL) {
> +        return 0;
> +    }
> +
> +    return strcmp(scope_path, entry) == 0;
> +}
> +
> +int is_proc_myself(const char *path, const char *entry)
> +{
> +    char *scope_path = scope_to_proc_myself(path);
> +    if (scope_path == NULL) {
> +        return 0;
> +    }
> +
> +    return strcmp(scope_path, entry) == 0;
> +}
> +
> +int is_proc_myself_exe(const char *path)
> +{
> +    char *scope_path = scope_to_proc_myself(path);
> +    if (scope_path == NULL) {
> +        return 0;
> +    }
> +
> +    // Kernel creates "fd/#{number}" link after opening "exe" link.
> +    // Both "exe" and "fd/#{number}" can be used by application.
> +
> +    // Kernel can provide infinite amount of fd numbers.
> +    // Qemu is going to always return single global execfd.
> +
> +    // So we need to check "exe" and "fd/#{execfd}" only.

QEMU coding style is /* this */ (here you'd use a multi-block comment),
see:
https://wiki.qemu.org/Contribute/SubmitAPatch#Use_the_QEMU_coding_style

Regards,

Phil.

> +
> +    if (strcmp(scope_path, "exe") == 0) {
> +        return 1;
> +    }
> +
> +    if (STARTS_WITH(scope_path, "fd/")) {
> +        scope_path += strlen("fd/");
> +
> +        if (strlen(scope_path) >= 1 && *scope_path >= '1' &&
> *scope_path <= '9') {
> +            char execfd_path[80];
> +            snprintf(execfd_path, sizeof(execfd_path), "%d", execfd);
> +            if (strcmp(scope_path, execfd_path) == 0) {
> +                return 1;
> +            }
> +        }
> +    }
> +
> +    return 0;
> +}
> diff --git a/linux-user/syscall_proc.h b/linux-user/syscall_proc.h
> new file mode 100644
> index 0000000000..f0e59c0e96
> --- /dev/null
> +++ b/linux-user/syscall_proc.h
> @@ -0,0 +1,8 @@
> +#ifndef SYSCALL_PROC_H
> +#define SYSCALL_PROC_H
> +
> +int is_proc(const char *path, const char *entry);
> +int is_proc_myself(const char *path, const char *entry);
> +int is_proc_myself_exe(const char *path);
> +
> +#endif
> -- 
> 2.26.2
> 


