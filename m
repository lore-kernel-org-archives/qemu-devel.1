Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77DE3C433E4
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 20:05:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48E4520729
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 20:05:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48E4520729
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57094 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k09Nf-0001Bq-I3
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 16:05:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52756)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1k09Me-0000Px-78
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 16:04:48 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:37757)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1k09Mc-0006Pj-Iu
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 16:04:47 -0400
Received: from [192.168.100.1] ([82.252.135.186]) by mrelayeu.kundenserver.de
 (mreue107 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MsZeX-1ko8Lg3ZcZ-00txST; Mon, 27 Jul 2020 22:04:44 +0200
Subject: Re: [PATCH] linux-user: Fix syscall rt_sigtimedwait() implementation
To: Filip Bozuta <Filip.Bozuta@syrmia.com>, qemu-devel@nongnu.org
References: <20200724181651.167819-1-Filip.Bozuta@syrmia.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <0fb358d3-5570-964d-f088-5ca7b1facdb9@vivier.eu>
Date: Mon, 27 Jul 2020 22:04:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200724181651.167819-1-Filip.Bozuta@syrmia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:vusUhGfTo7NVHnPCZAZV78if2KIOL3AYdMKIhMnqiSuBC4mqWJx
 rG1EwQhYWHeSE+4vMgQdNCDQZ8Sob1Epsf8ZI33qVfwE+hIyWEB2StwEFG70NcluuqHrsbh
 e2O7SpOVydMdxpaUOZZM6u+NnFF9Hfm2G+HJj9EfyD2ZubkqYpUSlPhZg//nTBqeIpBnnij
 yCkWasetJyqs1vhDLN7wQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:++hU27+sBxM=:2E2WSYO/PvtIb83GPuUGvt
 O3PN+yTlk0iz2o7eEFQYMHt6mpxAUlDltTGv6nxABA1V+Ma7uw+XEbDCrUGFdAU370V6gQXPU
 2Qrp8a2jxq6q8T4HXxVyG/6htfahKygg5kdwd65IgbFAKPwnOE+4u0BmAvNqLzaGejwGCj9VX
 akaiU/uiH5MyaSMPS2hbcaSa3aceM4bajjIS9enznUc6cVC+jya3YHGtlr8i/1LSoTKscYlwu
 huyBrOdRgISUWP8Y3hbUj4Q2ORH46pOPTtqbPx7C9Rz9KlutKgLsSIKUMCJXM/2tb2T5MAecT
 fnMsGWnXIaWNCYxHQnDpuxwH6Mv8RyS5h+8Wh+6dzUhIHYSlWJ8KfoDzV/WlnkD7F6FEt0OZV
 Dd6jvjuecStqMLeWLVAnYNeyf5kQINI3NkYWofyFryvZreZDInxnszrNmU9NkSktH1zixapFj
 0rF66uIRI1Psg9sZ9zFbVsRwAUUd03Zz84KlVDdrAIzyBP14Rr/GvWotYyMbxTb7KTus7PWDg
 op1KJtiTKgMhZ+fpgX6DzTWxo3Teuc80izsY5eLRtMhiQZwbQi53vj6ZA4G3TdLFbSDJWRosn
 T5XyoKF98da7kfxhuYOeKpIFLaw+sCHKPQp2mg04IERD/ertypWoZTLLNErTYxnYXopGw0NCO
 2WeYErbrYhCWHQV567H7fTLKbi+l+WzlixyhZ6fLHBvkQmsIPaYkhRTOG8OVFHlFcQT2S7Enf
 qUcP1q26F64Hu3s8uD28X60R3v93oQjaFkekU7x/XQeTm3kJtPs7+RND+Vtv+AEkHMZDlNVYx
 BoQh8bDYnLhXIonkqg+UAAzc/w3NaC3+HozAtGFiIlJCmOK+A3vjry4NIBVrcFbxQeFad0I
Received-SPF: none client-ip=217.72.192.74; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 16:04:45
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

Le 24/07/2020 à 20:16, Filip Bozuta a écrit :
> Implementation of 'rt_sigtimedwait()' in 'syscall.c' uses the
> function 'target_to_host_timespec()' to transfer the value of
> 'struct timespec' from target to host. However, the implementation
> doesn't check whether this conversion succeeds and thus can cause
> an unaproppriate error instead of the 'EFAULT (Bad address)' which
> is supposed to be set if the conversion from target to host fails.
> 
> This was confirmed with the LTP test for rt_sigtimedwait:
> "/testcases/kernel/syscalls/rt_sigtimedwait/rt_sigtimedwait01.c"
> which causes an unapropriate error in test case "test_bad_adress3"
> which is run with a bad adress for the 'struct timespec' argument:
> 
> FAIL: test_bad_address3 (349): Unexpected failure: EAGAIN/EWOULDBLOCK (11)
> 
> The test fails with an unexptected errno 'EAGAIN/EWOULDBLOCK' instead
> of the expected EFAULT.
> 
> After the changes from this patch, the test case is executed successfully
> along with the other LTP test cases for 'rt_sigtimedwait()':
> 
> PASS: test_bad_address3 (349): Test passed
> 
> Signed-off-by: Filip Bozuta <Filip.Bozuta@syrmia.com>
> ---
>  linux-user/syscall.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 1211e759c2..72735682cb 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -8868,7 +8868,9 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>              unlock_user(p, arg1, 0);
>              if (arg3) {
>                  puts = &uts;
> -                target_to_host_timespec(puts, arg3);
> +                if (target_to_host_timespec(puts, arg3)) {
> +                    return -TARGET_EFAULT;
> +                }
>              } else {
>                  puts = NULL;
>              }
> 

Applied to my linux-user-for-5.1 branch.

Thanks,
Laurent

