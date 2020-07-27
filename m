Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17F30C433E3
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 20:29:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDA692074F
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 20:29:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDA692074F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k09kH-0005tJ-4j
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 16:29:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57558)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1k09jN-0004Yj-OE
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 16:28:17 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:38381)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1k09jL-0001HO-PC
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 16:28:17 -0400
Received: from [192.168.100.1] ([82.252.135.186]) by mrelayeu.kundenserver.de
 (mreue010 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1M7aqD-1jsA2T1SJR-0081Ij; Mon, 27 Jul 2020 22:28:12 +0200
Subject: Re: [PATCH] linux-user: Fix 'clock_nanosleep()' implementation
To: Filip Bozuta <Filip.Bozuta@syrmia.com>, qemu-devel@nongnu.org
References: <20200727201326.401519-1-Filip.Bozuta@syrmia.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <94beee28-aff8-32dc-4b37-bc98af5646db@vivier.eu>
Date: Mon, 27 Jul 2020 22:28:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200727201326.401519-1-Filip.Bozuta@syrmia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ZRuaR7pdxa0lKKZSPXAV9Wz1cwnvhZPFeQtlr0dt+g/+gfmeZUg
 ymZeFitwvQwJiM+88nc3tPyrKzeKmHcbhwYOey7d13h6q3bpnN8915cJXBflj8/XhQ91t8x
 yvs6e6txzAGpgMdOv2uO7eMqv8DBdBrXfLnbiqguThk7HZnCPaqdyW7cWhzAkzy+8brV+eP
 ylurB0hd3uSLgEQnM4mYw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:lPTN50Zt8jU=:dF0ipAzZ/GWz2A7auUvJEs
 24UlZiuqaMHqdmLh2ktHd3xawiKfJ20mA0lhYw4jwbqkTKhC6NC+9wixfNC+fk5UoM5M+y7Z1
 NhOpTdwQbIpvpD/aWkPkbj0i1bEt5EnsRevtFzggsHyqTBfthRYhgtoERU/I3rLsAaoTRuadX
 ESgGwrKwyIJAjLxN5JiBr7mCjSMB6QJwQjl7dbJTx/Y+8jLVPqCKfUnEktbYS20lB09S8I5wj
 8DBOCyCbWkMYycyhv2NVftriw2rUFARpxghB1BxXDciqyX1kLr+4xR6XEMq16i8Ric0JtIhQq
 2f3QufkPQ7YmCsawAjPoMwlqKy1lpXL1C4EPxw24xKiD6FE0W7peZBgzL25HMJy6nO25mVr/s
 4l9HfpRH8QZCo9j7j1NsvxUrtH/rmtB9xuZo5e0iOwK/SxJLhf/T/1GEChp10WaklpZC9nB9O
 xxe6pDCKOpB0tyIbpdNOg4pBXtPrdg60wiFudvdF63kheqoXl3TTTuD6xYOTbtQ66kSnXJDTx
 z91TU8LCu/uPoV4lNo37Wl77VJLAC6T1NazVnb/fCN1/Q4fuvr/qiee1FUuWmW4yTnluKhRMJ
 beW+3+efXrqRADf9AgYcTcQwsYnh+yImL9YVeLJ0sYClia6cZB3NL+prGga/FfcFELONPUwyr
 eljpHzZ/cuQkQggpsz5g+Yk6qj80ziKWQ/+hefvW1EadLAOaZvFfLFr8bQ7aoDIETceOv8Bqu
 tZiMYQbFI+jvVY7nK3hCgBSUgoLlPUQFGCeVexRb5Gk9vi7sOPFCiy7L6tf+uG0b5c0tYTWSh
 jXEij+P2/zvm7+K4iAmmZy8hEMccSPLB4Oy2h3SezwDmJhcXBdLcfEuN7Lw3nC/2bj4/iUG
Received-SPF: none client-ip=212.227.126.134; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 16:28:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Le 27/07/2020 à 22:13, Filip Bozuta a écrit :
> Implementation of syscall 'clock_nanosleep()' in 'syscall.c' uses
> functions 'target_to_host_timespec()' and 'host_to_target_timespec()'
> to transfer the value of 'struct timespec' between target and host.
> However, the implementation doesn't check whether this conversion
> succeeds and thus can return an unaproppriate error instead of 'EFAULT'
> that is expected. This was confirmed with the modified LTP test suite
> where testcases with bad 'struct timespec' adress for 'clock_nanosleep()'
> were added. This modified LTP suite can be found at:
> https://github.com/bozutaf/ltp
> 
> (Patch with this new test case will be sent to LTP mailing list soon)
> 
> Signed-off-by: Filip Bozuta <Filip.Bozuta@syrmia.com>
> ---
>  linux-user/syscall.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index f5c4f6b95d..9f06dde947 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -11828,7 +11828,9 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>      case TARGET_NR_clock_nanosleep:
>      {
>          struct timespec ts;
> -        target_to_host_timespec(&ts, arg3);
> +        if (target_to_host_timespec(&ts, arg3)) {
> +            return -TARGET_EFAULT;
> +        }
>          ret = get_errno(safe_clock_nanosleep(arg1, arg2,
>                                               &ts, arg4 ? &ts : NULL));
>          /*
> @@ -11836,8 +11838,9 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>           * with error -TARGET_EINTR and if arg4 is not NULL and arg2 is not
>           * TIMER_ABSTIME, it returns the remaining unslept time in arg4.
>           */
> -        if (ret == -TARGET_EINTR && arg4 && arg2 != TIMER_ABSTIME) {
> -            host_to_target_timespec(arg4, &ts);
> +        if (ret == -TARGET_EINTR && arg4 && arg2 != TIMER_ABSTIME &&
> +            host_to_target_timespec(arg4, &ts)) {
> +              return -TARGET_EFAULT;
>          }
>  
>          return ret;
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

