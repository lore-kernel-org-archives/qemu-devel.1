Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC049C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 09:08:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8066C20658
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 09:08:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8066C20658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35990 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDljn-0001go-1R
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 05:08:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52843)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jDlLA-0000pH-4C
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 04:43:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jDlL8-0003Kj-Db
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 04:43:15 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:39407)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1jDlL8-0002zu-2C
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 04:43:14 -0400
Received: from [192.168.100.1] ([82.252.135.106]) by mrelayeu.kundenserver.de
 (mreue107 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1Mjjvp-1jbEar1CAN-00lC4g; Mon, 16 Mar 2020 09:42:46 +0100
Subject: Re: [PULL 132/136] mem-prealloc: optimize large guest startup
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
 <1582632454-16491-30-git-send-email-pbonzini@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <7dc67896-eb79-c25c-6be6-a6b7012c9649@vivier.eu>
Date: Mon, 16 Mar 2020 09:42:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1582632454-16491-30-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:u25BlfgkpLUnID/ClDliut/J8ZPmi+nctcmExcvZL0dmBBX4qGt
 d8YT0Krg6j/7/iRQY+sQXU4RQF6RmGjxMmv6M4M6CxBm5njbBMvJLi9+j6JSBP7xxvx+l/G
 xQ5h98wIsgEbx4azXKYehRXPgY8xaueTOIWKUW1kNSq55iDpy8xpP9P+24eKsbF0mw3uUCA
 CP3tBaokXoz3tgYjZGNZA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:kcRiqgk1znw=:hUDxpFMbSIJzqWj0VMFhk3
 sDEXx1Sh2S6lMAjSQcfxjBZEJBzdvaiyIBELHbEr+NgYR2IRozpqy5RXwg3UGfotujcYh1pDN
 mkgTSWAHPq8boPbHpzZRJSDkgEy4PyzpRo+9/eAPaGzbK155vG4G7NHysxQnp4p0Gb9QXEb5v
 g4ufJzm/524JBNPlvxTi9giqX00v3Tj1Ifyxn7qajKjL+CXR+ynrItBd4EkR366vLp3760FbW
 le1ihavNjdENR6uLQXKTjXXRpD+1FUWPJhhIjw49OvLVWxmFuQnds52t66r9eUyjAYvdo75H0
 y5KbpUtvBHB81V071Zz8ldwaO8gzjMvvoFrOi9f6SVpgnfiZLBqo3jeRc7I6RZP+2hC5zQXH/
 SHWM8sYx/3q3gsLB0WdMRdZiiAN+zpSxR2YeChncNOi0O+FMz6Y3rjZjBhXFPp4lQyjYbyBhY
 tr2WfFybBt/+2Gvcm+5jL0SHNE8nLMVqD1YZfIuHlZzonhOtm6d7IxOV8yoJaI2HBmmZMD98U
 sjl5xtbFNRLFb/ySoO0Nc24kkAR11qDhEKlX5dX4GQcGMLi7yduCOoI/nNlmHG3hkU/Dpj7wr
 3vUZhp4qxq609eOk/CmKrmdLQeHzWXHnJy3NH5sh3/OuSqguz5NzuuR+lNw7+8iEzi7PwHM59
 sxtE3RQtoiegbD1CVpvxEalKYShwK3JjpfksfEg+yXlf/k7/YyxKhEvitc7aYqZKqApboQPIA
 wfnAuw9mYnZqKqarGPgdMga3N56ZAmG2d+nxN4VJzeix3AOGNdgNql/zCCNLfBHMwWfkPd4gs
 LLmidTwyeek0jxQZGScktsjm9gVebnvw9/IS1r6602/517i2L24mgcKERsFZm3ecIHPuKSv
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.13
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
Cc: bauerchen <bauerchen@tencent.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

a bug has been reported in launchpad for this patch:

[Regression]Powerpc kvm guest unable to start with hugepage backed
            memory
https://bugs.launchpad.net/qemu/+bug/1866962

Thanks,
Laurent

Le 25/02/2020 à 13:07, Paolo Bonzini a écrit :
> From: bauerchen <bauerchen@tencent.com>
> 
> [desc]:
>     Large memory VM starts slowly when using -mem-prealloc, and
>     there are some areas to optimize in current method;
> 
>     1、mmap will be used to alloc threads stack during create page
>     clearing threads, and it will attempt mm->mmap_sem for write
>     lock, but clearing threads have hold read lock, this competition
>     will cause threads createion very slow;
> 
>     2、methods of calcuating pages for per threads is not well;if we use
>     64 threads to split 160 hugepage,63 threads clear 2page,1 thread
>     clear 34 page,so the entire speed is very slow;
> 
>     to solve the first problem,we add a mutex in thread function,and
>     start all threads when all threads finished createion;
>     and the second problem, we spread remainder to other threads,in
>     situation that 160 hugepage and 64 threads, there are 32 threads
>     clear 3 pages,and 32 threads clear 2 pages.
> 
> [test]:
>     320G 84c VM start time can be reduced to 10s
>     680G 84c VM start time can be reduced to 18s
> 
> Signed-off-by: bauerchen <bauerchen@tencent.com>
> Reviewed-by: Pan Rui <ruippan@tencent.com>
> Reviewed-by: Ivan Ren <ivanren@tencent.com>
> [Simplify computation of the number of pages per thread. - Paolo]
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  util/oslib-posix.c | 32 ++++++++++++++++++++++++--------
>  1 file changed, 24 insertions(+), 8 deletions(-)
> 
> diff --git a/util/oslib-posix.c b/util/oslib-posix.c
> index 5a291cc..897e8f3 100644
> --- a/util/oslib-posix.c
> +++ b/util/oslib-posix.c
> @@ -76,6 +76,10 @@ static MemsetThread *memset_thread;
>  static int memset_num_threads;
>  static bool memset_thread_failed;
>  
> +static QemuMutex page_mutex;
> +static QemuCond page_cond;
> +static bool threads_created_flag;
> +
>  int qemu_get_thread_id(void)
>  {
>  #if defined(__linux__)
> @@ -403,6 +407,17 @@ static void *do_touch_pages(void *arg)
>      MemsetThread *memset_args = (MemsetThread *)arg;
>      sigset_t set, oldset;
>  
> +    /*
> +     * On Linux, the page faults from the loop below can cause mmap_sem
> +     * contention with allocation of the thread stacks.  Do not start
> +     * clearing until all threads have been created.
> +     */
> +    qemu_mutex_lock(&page_mutex);
> +    while(!threads_created_flag){
> +        qemu_cond_wait(&page_cond, &page_mutex);
> +    }
> +    qemu_mutex_unlock(&page_mutex);
> +
>      /* unblock SIGBUS */
>      sigemptyset(&set);
>      sigaddset(&set, SIGBUS);
> @@ -451,27 +466,28 @@ static inline int get_memset_num_threads(int smp_cpus)
>  static bool touch_all_pages(char *area, size_t hpagesize, size_t numpages,
>                              int smp_cpus)
>  {
> -    size_t numpages_per_thread;
> -    size_t size_per_thread;
> +    size_t numpages_per_thread, leftover;
>      char *addr = area;
>      int i = 0;
>  
>      memset_thread_failed = false;
> +    threads_created_flag = false;
>      memset_num_threads = get_memset_num_threads(smp_cpus);
>      memset_thread = g_new0(MemsetThread, memset_num_threads);
> -    numpages_per_thread = (numpages / memset_num_threads);
> -    size_per_thread = (hpagesize * numpages_per_thread);
> +    numpages_per_thread = numpages / memset_num_threads;
> +    leftover = numpages % memset_num_threads;
>      for (i = 0; i < memset_num_threads; i++) {
>          memset_thread[i].addr = addr;
> -        memset_thread[i].numpages = (i == (memset_num_threads - 1)) ?
> -                                    numpages : numpages_per_thread;
> +        memset_thread[i].numpages = numpages_per_thread + (i < leftover);
>          memset_thread[i].hpagesize = hpagesize;
>          qemu_thread_create(&memset_thread[i].pgthread, "touch_pages",
>                             do_touch_pages, &memset_thread[i],
>                             QEMU_THREAD_JOINABLE);
> -        addr += size_per_thread;
> -        numpages -= numpages_per_thread;
> +        addr += memset_thread[i].numpages * hpagesize;
>      }
> +    threads_created_flag = true;
> +    qemu_cond_broadcast(&page_cond);
> +
>      for (i = 0; i < memset_num_threads; i++) {
>          qemu_thread_join(&memset_thread[i].pgthread);
>      }
> 


