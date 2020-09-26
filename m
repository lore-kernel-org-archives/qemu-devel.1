Return-Path: <SRS0=cZnO=DD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 026E3C2D0A8
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2020 10:21:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59C25238E2
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2020 10:21:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59C25238E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57956 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kM7Ko-0003VR-9E
	for qemu-devel@archiver.kernel.org; Sat, 26 Sep 2020 06:21:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51084)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kM7K6-0002yg-W8
 for qemu-devel@nongnu.org; Sat, 26 Sep 2020 06:20:59 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:35717)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kM7K5-0007Hj-0v
 for qemu-devel@nongnu.org; Sat, 26 Sep 2020 06:20:58 -0400
Received: from [192.168.100.1] ([82.252.129.222]) by mrelayeu.kundenserver.de
 (mreue009 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1N63NQ-1kXLj739OS-016QBm; Sat, 26 Sep 2020 12:20:49 +0200
Subject: Re: [PATCH v2] Fix stack smashing when handling PR_GET_PDEATHSIG
To: Stephen Long <steplong@quicinc.com>, qemu-devel@nongnu.org
References: <20200507130302.3684-1-steplong@quicinc.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <47ea45b6-458f-ef21-689d-cd1051045a59@vivier.eu>
Date: Sat, 26 Sep 2020 12:20:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200507130302.3684-1-steplong@quicinc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:1fNlQN70Wr8k7V8Z8Zbics5FtmSc6aH5YuYZevaCWxyBgJtWHM0
 OjszCR/0jTR+QoI3dbisns17/AemCfYWCbkusrMVwd26qmccXsflOMRZPPWNgAGLGO+j6OM
 rdInzjgewBkWEqzjFqL33rrIwFiFJ713qGyzXAEqFtZcfVMTsdVlefCmm8QxsuWa69FfmYP
 P6J1po/3/hBiOyuY1Lojg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:uxvNg5D3dFU=:GUV+5J8PUCCDOTpKnKIB0f
 Jw6PipPERbqUt0NhbyB9KIh8ewZmxxoXirq04/hbuRO4Rz7/fRsJWVvVBHThdwN46epUuHDJg
 taaTLK7sJjadJsgLvtwuOiObSL/hOJGohvXNXcUXniGzsi31Pla7pYU/ZRhII3jZ04PvkEz4n
 5Z8zahshFZ/4Xzz0YMxoTsQq2y2PVdV6NutM5G0O2COEEDqwxH0b09lXt3pyy3nTJYLNK6v77
 nUBb8qhM5/Vker6+Jt7O5UaS5eBLW+aHgkQb2SrSTHwVB8fyQ+Hf+omsqwqjQe11qLP4IhXH2
 bM9mtCxR8jug7BYEclVS4f8fGwkkjnZon4xz0JdljsYqpwvqEb1K5AaH9XjU4njlWhaDXsRHu
 ItrIFZsGAybc22+Nvk7CNIbN6CmdM3F166ElXIrE8tU9OE49eLkYU9eb8gLIleXGPmIHSD1ON
 8bUdGq2Ap0o9zRgBCbhVS0K3FqoqxOw7hqXKd8COWobB05qNhp+T7AEmJLbqFVcVHKzW5rqNF
 ZPHfOiGlK9fX/7v8pt2/ZoKjuKdCusZsgYG3Z/DjACGz5Vfi2+snrYgVTR4I4RC+FypGs9FFB
 UL8Tn2scpcWBKK2KoXv8/dqSps7x4vfCweMrOW9sDw6d+kZ7uK+L8FzmEBsZ+z/4/oQzO/wKG
 5SRdKkgEwM0cIhmWvmPw/0t1cUezVaG2b0+9iXbhQjgeLgBWypAUuXv6+2gjpUlvVg0eSAczK
 5TIyEcS0Wgo+zC1JQuSZFv8HBp+vGnR5KhqP753nFc0+rCiJXxfjT24OxrangGCj69zNmmrm8
 /of4u7ngtQhHCM8Y9eYCkW7UD7dWy/4R4O3kanXWjvDlXCdrl0xK+95oB6jHtIZaqxwAY12
Received-SPF: none client-ip=212.227.126.131; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/26 06:20:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.238,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: riku.voipio@iki.fi, apazos@quicinc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 07/05/2020 à 15:03, Stephen Long a écrit :
> The bug was triggered by the following code on aarch64-linux-user:
> 
> #include <signal.h>
> #include <sys/prctl.h>
> 
> int main(void)
> {
>   int PDeathSig = 0;
>   if (prctl(PR_GET_PDEATHSIG, &PDeathSig) == 0 && PDeathSig == SIGKILL)
>     prctl(PR_GET_PDEATHSIG, 0);
>   return (PDeathSig == SIGKILL);
> }
> 
> Signed-off-by: Stephen Long <steplong@quicinc.com>
> Signed-off-by: Ana Pazos <apazos@quicinc.com>
> ---
> 
> I fixed the incorrect subject line. PR_GETDEATHSIG should be PR_GET_PDEATHSIG.
> Is there a test folder where I can include the code that triggered the bug?
> Also, I thought "int" can be 2 bytes on some machines.
> 
>  linux-user/syscall.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 05f03919ff..91f91147ba 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -10256,7 +10256,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>              int deathsig;
>              ret = get_errno(prctl(arg1, &deathsig, arg3, arg4, arg5));
>              if (!is_error(ret) && arg2
> -                && put_user_ual(deathsig, arg2)) {
> +                && put_user_s32(deathsig, arg2)) {
>                  return -TARGET_EFAULT;
>              }
>              return ret;
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

