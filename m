Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0290C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 19:35:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 976252067D
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 19:35:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 976252067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40540 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jv4Ek-00019D-RW
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 15:35:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46470)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jv4Dx-0008LQ-7m
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 15:34:49 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:51473)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jv4Du-0008Na-Me
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 15:34:48 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue107 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MGygv-1k92KF0FjH-00E9Va; Mon, 13 Jul 2020 21:34:44 +0200
Subject: Re: [PATCH v2 2/2] linux-user: fix print_syscall_err() when syscall
 returned value is negative
To: qemu-devel@nongnu.org
References: <20200708152435.706070-1-laurent@vivier.eu>
 <20200708152435.706070-3-laurent@vivier.eu>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <1da0cfa0-9642-e162-695e-f826031f0a5d@vivier.eu>
Date: Mon, 13 Jul 2020 21:34:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200708152435.706070-3-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:jOFSLCihG+HWJjbdt9MgdIrAHoEDoqvCjQ4n2QmpD4PXO+xiWnS
 o3cZ2dty4zguwZMcsQ9Ghp4hYMp+KwP4Q3VfHyvDRJTZGn1gafZlRtoftz1tmwIC+Bu33+U
 P/Gv9O+hrL5I9nU9ZRh0g6OhvgwkKIFMx8pM4cCfVDi3+R45b0W8M8eZnSsEV3Iiz8w4lyR
 UOE25gdyPsa/p/ivpQxVQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jACRj5CSGM0=:amFmR84gs2qGCizM1m9eAY
 miY8s+i858YveiECRKYWsKbSckeHcO63wz1ar48xiSc/rjgH/peBlCZhn4i46PLOtOKT42DHP
 Hc8p9HfMLFy9BH9/eNz+biTvKI4vlfzDv17/H2/Ijb+JBQpdewgwq92JZmQ9Gt6mSxTOFXhRa
 Dmln9PR826PArKaekEbhEoGqaIUEw/VnboRIT0/gByiy88G6ty1nL86ObOhjAZApU/oeQwn2A
 O4vUNd/sY2kfrXL3FyGBCTRFwmhcjuTPaElwF0O6FJK7u/KD7ivbg18ONOhVpA6z9NkQJfxs+
 eyMHoaQsvHUeE0BM0Hh+pWXaHT0ApQN2Nhn2g43wc0XO4GSEl9PqHkMqWeBSs312mNgNZe3gn
 1/woX4odpZYRzEh7+acCGFbvaHGYiaeI66xOGs4rYAcX2V7vYcCLuBl+VTqnH4XTa/Wc5c8z8
 zqSO7aiI0F+T6NBJhbI3Co//wadj12NVsChsuCLEnr19FDrgzQu1Jh6c4w69+2ojWZDkMsWGW
 L14GAsBmF1qJe5DFyYXVhC5onfKUIecff6/ENYVcre37mTGCHLf2QChpzNUefLc76WprrhogN
 yV9e+VdnBQmPk4tNFC1vTvaLhMolezIzluu6OIOlMhLsCrhUUeHRHV8CDVhYNhqcgoCc0VbOe
 4oCtQNE//kPLypIDhXKeDFM8YZtPTYoQS0PVpPNq0M2v6/9nvIOrkQDiAsN+jXD7F/VKkVmE0
 HRJFPkIL+q1Czv+fVtrFXdJNdLjdeJiuF1LfMpzRcmMANfqQBzBIwXVTEcucZLfrkkEarMpub
 GsXoPgXL0KXlqwjp5ZkYO3YS6aZsawhfN9BbOvF9zcYgg2sn7pu8RvWVroSO9RdLAb6NaCM
Received-SPF: none client-ip=212.227.17.24; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 15:21:31
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
Cc: Filip Bozuta <Filip.Bozuta@syrmia.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 08/07/2020 à 17:24, Laurent Vivier a écrit :
> print_syscall_err() relies on the sign of the returned value to know
> if it is an errno value or not.
> 
> But in some cases the returned value can have the most signicant bit
> set without being an errno.
> 
> This patch restores previous behaviour that was also checking if
> we can decode the errno to validate it.
> 
> This patch fixes this kind of problem (qemu-m68k):
> 
>   root@sid:/# QEMU_STRACE= ls
>   3 brk(NULL) = -1 errno=21473607683 uname(0x407fff8a) = 0
> 
> to become:
> 
>   root@sid:/# QEMU_STRACE= ls
>   3 brk(NULL) = 0x8001e000
>   3 uname(0xffffdf8a) = 0
> 
> Fixes: c84be71f6854 ("linux-user: Extend strace support to enable argument printing after syscall execution")
> Cc: Filip.Bozuta@syrmia.com
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>  linux-user/strace.c | 36 +++++++++++++-----------------------
>  1 file changed, 13 insertions(+), 23 deletions(-)
> 
> diff --git a/linux-user/strace.c b/linux-user/strace.c
> index b42664bbd180..17f2554643f0 100644
> --- a/linux-user/strace.c
> +++ b/linux-user/strace.c
> @@ -724,19 +724,20 @@ print_ipc(const struct syscallname *name,
>   * Variants for the return value output function
>   */
>  
> -static void
> +static bool
>  print_syscall_err(abi_long ret)
>  {
> -    const char *errstr = NULL;
> +    const char *errstr;
>  
>      qemu_log(" = ");
>      if (ret < 0) {
> -        qemu_log("-1 errno=%d", (int)-ret);
>          errstr = target_strerror(-ret);
>          if (errstr) {
> -            qemu_log(" (%s)", errstr);
> +            qemu_log("-1 errno=%d (%s)", (int)-ret, errstr);
> +            return true;
>          }
>      }
> +    return false;
>  }
>  
>  static void
> @@ -744,11 +745,10 @@ print_syscall_ret_addr(const struct syscallname *name, abi_long ret,
>                         abi_long arg0, abi_long arg1, abi_long arg2,
>                         abi_long arg3, abi_long arg4, abi_long arg5)
>  {
> -    print_syscall_err(ret);
> -
> -    if (ret >= 0) {
> -        qemu_log("0x" TARGET_ABI_FMT_lx "\n", ret);
> +    if (!print_syscall_err(ret)) {
> +        qemu_log("0x" TARGET_ABI_FMT_lx, ret);
>      }
> +    qemu_log("\n");
>  }
>  
>  #if 0 /* currently unused */
> @@ -765,9 +765,7 @@ print_syscall_ret_newselect(const struct syscallname *name, abi_long ret,
>                              abi_long arg0, abi_long arg1, abi_long arg2,
>                              abi_long arg3, abi_long arg4, abi_long arg5)
>  {
> -    print_syscall_err(ret);
> -
> -    if (ret >= 0) {
> +    if (!print_syscall_err(ret)) {
>          qemu_log(" = 0x" TARGET_ABI_FMT_lx " (", ret);
>          print_fdset(arg0, arg1);
>          qemu_log(",");
> @@ -796,9 +794,7 @@ print_syscall_ret_adjtimex(const struct syscallname *name, abi_long ret,
>                             abi_long arg0, abi_long arg1, abi_long arg2,
>                             abi_long arg3, abi_long arg4, abi_long arg5)
>  {
> -    print_syscall_err(ret);
> -
> -    if (ret >= 0) {
> +    if (!print_syscall_err(ret)) {
>          qemu_log(TARGET_ABI_FMT_ld, ret);
>          switch (ret) {
>          case TARGET_TIME_OK:
> @@ -833,9 +829,7 @@ print_syscall_ret_listxattr(const struct syscallname *name, abi_long ret,
>                              abi_long arg0, abi_long arg1, abi_long arg2,
>                              abi_long arg3, abi_long arg4, abi_long arg5)
>  {
> -    print_syscall_err(ret);
> -
> -    if (ret >= 0) {
> +    if (!print_syscall_err(ret)) {
>          qemu_log(TARGET_ABI_FMT_ld, ret);
>          qemu_log(" (list = ");
>          if (arg1 != 0) {
> @@ -866,9 +860,7 @@ print_syscall_ret_ioctl(const struct syscallname *name, abi_long ret,
>                          abi_long arg0, abi_long arg1, abi_long arg2,
>                          abi_long arg3, abi_long arg4, abi_long arg5)
>  {
> -    print_syscall_err(ret);
> -
> -    if (ret >= 0) {
> +    if (!print_syscall_err(ret)) {
>          qemu_log(TARGET_ABI_FMT_ld, ret);
>  
>          const IOCTLEntry *ie;
> @@ -3189,9 +3181,7 @@ print_syscall_ret(int num, abi_long ret,
>                                    arg1, arg2, arg3,
>                                    arg4, arg5, arg6);
>              } else {
> -                print_syscall_err(ret);
> -
> -                if (ret >= 0) {
> +                if (!print_syscall_err(ret)) {
>                      qemu_log(TARGET_ABI_FMT_ld, ret);
>                  }
>                  qemu_log("\n");
> 

Applied to my linux-user-for-5.1 branch.

Richard: I agree with your comment but I'd like to fix the regression
before the hard freeze. Filip is currently working on some improvements
in strace functions that will allow to have access to env variable. So
we will be able to have a target-specific test as you suggested.

Thanks,
Laurent

