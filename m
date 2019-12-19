Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54826C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 09:26:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A5E12465E
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 09:26:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A5E12465E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37672 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihs4R-0007ka-9w
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 04:26:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58733)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1ihs3q-0007Il-B0
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 04:25:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1ihs3o-0002DK-WD
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 04:25:34 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:43487)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1ihs3o-00024x-L7
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 04:25:32 -0500
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue106 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MHFsE-1iUitF31kW-00DJ19; Thu, 19 Dec 2019 10:25:05 +0100
Subject: Re: [PATCH] linux-user:Fix align mistake when mmap guest space
To: Xinyu Li <precinct@mail.ustc.edu.cn>, qemu-devel@nongnu.org
References: <20191213022919.5934-1-precinct@mail.ustc.edu.cn>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 mQINBFYFJhkBEAC2me7w2+RizYOKZM+vZCx69GTewOwqzHrrHSG07MUAxJ6AY29/+HYf6EY2
 WoeuLWDmXE7A3oJoIsRecD6BXHTb0OYS20lS608anr3B0xn5g0BX7es9Mw+hV/pL+63EOCVm
 SUVTEQwbGQN62guOKnJJJfphbbv82glIC/Ei4Ky8BwZkUuXd7d5NFJKC9/GDrbWdj75cDNQx
 UZ9XXbXEKY9MHX83Uy7JFoiFDMOVHn55HnncflUncO0zDzY7CxFeQFwYRbsCXOUL9yBtqLer
 Ky8/yjBskIlNrp0uQSt9LMoMsdSjYLYhvk1StsNPg74+s4u0Q6z45+l8RAsgLw5OLtTa+ePM
 JyS7OIGNYxAX6eZk1+91a6tnqfyPcMbduxyBaYXn94HUG162BeuyBkbNoIDkB7pCByed1A7q
 q9/FbuTDwgVGVLYthYSfTtN0Y60OgNkWCMtFwKxRaXt1WFA5ceqinN/XkgA+vf2Ch72zBkJL
 RBIhfOPFv5f2Hkkj0MvsUXpOWaOjatiu0fpPo6Hw14UEpywke1zN4NKubApQOlNKZZC4hu6/
 8pv2t4HRi7s0K88jQYBRPObjrN5+owtI51xMaYzvPitHQ2053LmgsOdN9EKOqZeHAYG2SmRW
 LOxYWKX14YkZI5j/TXfKlTpwSMvXho+efN4kgFvFmP6WT+tPnwARAQABtCJMYXVyZW50IFZp
 dmllciA8bGF1cmVudEB2aXZpZXIuZXU+iQI4BBMBAgAiBQJWBTDeAhsDBgsJCAcDAgYVCAIJ
 CgsEFgIDAQIeAQIXgAAKCRDzDDi9Py++PCEdD/oD8LD5UWxhQrMQCsUgLlXCSM7sxGLkwmmF
 ozqSSljEGRhffxZvO35wMFcdX9Z0QOabVoFTKrT04YmvbjsErh/dP5zeM/4EhUByeOS7s6Yl
 HubMXVQTkak9Wa9Eq6irYC6L41QNzz/oTwNEqL1weV1+XC3TNnht9B76lIaELyrJvRfgsp9M
 rE+PzGPo5h7QHWdL/Cmu8yOtPLa8Y6l/ywEJ040IoiAUfzRoaJs2csMXf0eU6gVBhCJ4bs91
 jtWTXhkzdl4tdV+NOwj3j0ukPy+RjqeL2Ej+bomnPTOW8nAZ32dapmu7Fj7VApuQO/BSIHyO
 NkowMMjB46yohEepJaJZkcgseaus0x960c4ua/SUm/Nm6vioRsxyUmWd2nG0m089pp8LPopq
 WfAk1l4GciiMepp1Cxn7cnn1kmG6fhzedXZ/8FzsKjvx/aVeZwoEmucA42uGJ3Vk9TiVdZes
 lqMITkHqDIpHjC79xzlWkXOsDbA2UY/P18AtgJEZQPXbcrRBtdSifCuXdDfHvI+3exIdTpvj
 BfbgZAar8x+lcsQBugvktlQWPfAXZu4Shobi3/mDYMEDOE92dnNRD2ChNXg2IuvAL4OW40wh
 gXlkHC1ZgToNGoYVvGcZFug1NI+vCeCFchX+L3bXyLMg3rAfWMFPAZLzn42plIDMsBs+x2yP
 +bkCDQRWBSYZARAAvFJBFuX9A6eayxUPFaEczlMbGXugs0mazbOYGlyaWsiyfyc3PStHLFPj
 rSTaeJpPCjBJErwpZUN4BbpkBpaJiMuVO6egrC8Xy8/cnJakHPR2JPEvmj7Gm/L9DphTcE15
 92rxXLesWzGBbuYxKsj8LEnrrvLyi3kNW6B5LY3Id+ZmU8YTQ2zLuGV5tLiWKKxc6s3eMXNq
 wrJTCzdVd6ThXrmUfAHbcFXOycUyf9vD+s+WKpcZzCXwKgm7x1LKsJx3UhuzT8ier1L363RW
 ZaJBZ9CTPiu8R5NCSn9V+BnrP3wlFbtLqXp6imGhazT9nJF86b5BVKpF8Vl3F0/Y+UZ4gUwL
 d9cmDKBcmQU/JaRUSWvvolNu1IewZZu3rFSVgcpdaj7F/1aC0t5vLdx9KQRyEAKvEOtCmP4m
 38kU/6r33t3JuTJnkigda4+Sfu5kYGsogeYG6dNyjX5wpK5GJIJikEhdkwcLM+BUOOTi+I9u
 tX03BGSZo7FW/J7S9y0l5a8nooDs2gBRGmUgYKqQJHCDQyYut+hmcr+BGpUn9/pp2FTWijrP
 inb/Pc96YDQLQA1q2AeAFv3Rx3XoBTGl0RCY4KZ02c0kX/dm3eKfMX40XMegzlXCrqtzUk+N
 8LeipEsnOoAQcEONAWWo1HcgUIgCjhJhBEF0AcELOQzitbJGG5UAEQEAAYkCHwQYAQIACQUC
 VgUmGQIbDAAKCRDzDDi9Py++PCD3D/9VCtydWDdOyMTJvEMRQGbx0GacqpydMEWbE3kUW0ha
 US5jz5gyJZHKR3wuf1En/3z+CEAEfP1M3xNGjZvpaKZXrgWaVWfXtGLoWAVTfE231NMQKGoB
 w2Dzx5ivIqxikXB6AanBSVpRpoaHWb06tPNxDL6SVV9lZpUn03DSR6gZEZvyPheNWkvz7bE6
 FcqszV/PNvwm0C5Ju7NlJA8PBAQjkIorGnvN/vonbVh5GsRbhYPOc/JVwNNr63P76rZL8Gk/
 hb3xtcIEi5CCzab45+URG/lzc6OV2nTj9Lg0SNcRhFZ2ILE3txrmI+aXmAu26+EkxLLfqCVT
 ohb2SffQha5KgGlOSBXustQSGH0yzzZVZb+HZPEvx6d/HjQ+t9sO1bCpEgPdZjyMuuMp9N1H
 ctbwGdQM2Qb5zgXO+8ZSzwC+6rHHIdtcB8PH2j+Nd88dVGYlWFKZ36ELeZxD7iJflsE8E8yg
 OpKgu3nD0ahBDqANU/ZmNNarBJEwvM2vfusmNnWm3QMIwxNuJghRyuFfx694Im1js0ZY3LEU
 JGSHFG4ZynA+ZFUPA6Xf0wHeJOxGKCGIyeKORsteIqgnkINW9fnKJw2pgk8qHkwVc3Vu+wGS
 ZiJK0xFusPQehjWTHn9WjMG1zvQ5TQQHxau/2FkP45+nRPco6vVFQe8JmgtRF8WFJA==
Message-ID: <698f1386-b706-16ff-60b2-779247f68ba5@vivier.eu>
Date: Thu, 19 Dec 2019 10:24:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191213022919.5934-1-precinct@mail.ustc.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:VjSysxu1gI6dkypq4VtTkJwIrRN/DDFhPTyE3ac9thPniSSC5b5
 bDfcYPrZEzhp6NKSNBrRfdFxMgoJq9qg8QxFOESkHIVnK88udpX1cBwy/ldMevilyWIdUfu
 CobohLVzqi9AU1dqsUBcHoqSiv38wPAOHYpH96knRKc6J8rBVi9YeCva0tXfasOlYTspTZM
 WISci7niEZ09w044WB0zw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:N1HWqyXlg4A=:MMXWhWdvWRzF0azTRbQnWt
 M6Ue+xt+oyLjrI077LFcejg20UZb2QnyptcX/8sr141yfEH/BEUNxfKelfBL0aUbuEwhSmp3Z
 orxYVjEp6JNI1AzhL5g9KEweUce7PbkoaUVtHOIRWtcmG+fmuagxPOMpP0EXGkB0FQ563IkQ+
 rlEP5lgAfv81iYMgD7m1QbQ5k8D/4O8uAu/f7sfmSsAxGtaaU0i2RziyTugwXV9MOlkK4GjLb
 lsAX7cmqMF2qubY9yb7jAguEtss+WooFSGWUBzjFAZnOqOCBLCrL7xvbmcg3LX10cWfnfgTRa
 NdtqDk951NWCXlMdwUVbd1bAoFHpXS3JqyuXCOCs+oe1AJdqHGvD82EQtFnhYjjzhTmFw+KlI
 fa+JE//smerdOFVk06EXJ1YbjnFrC4R3pJww8OCT3WOelBjxzzYDlx2cxbkfHtSekaSwC7Xkd
 UOb+kDx5XUh5cz0MpO7j4R2hxofNZWt/jzK5RsgIG5LJ/uUkvYbHvPe+clGZTnIyqRDwf1Gm0
 35dIrD+gfxVqzfcLx0a9/UlQr+OTXF8QMtJiLA8E2NnndRvEBlWIJIV1/Twsf8+Jo2Ouwl7GE
 mjU4mtsuUpvSuOdVZyZ0931IuYYAeZhXTs0dUZ4awtZ0VSXp7bSQk5P2idiBfrhtzaLnoynok
 0lGi2ZXcm31gMdRWJSF6fKx0GhlFobk6QVbgPX8Mvbz4E7/r7y5qAnbflSkKItcJ1GVMcgI8f
 1U8ExT0iqijWE91J9mZieoLOZ5R3bNIGSjddbdy9mO1wECOaywKSrKlSkAI0k9aGIFbhGxgRR
 VTvCa3m74d+GBu1UQszF/YpTr2ZVvfg4FYnB87PKbkiZw6lH/bgD9CQW3ohacx2SHRr5DWl6N
 C02+rOYlO08ia4lqLcWg==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: riku.voipio@iki.fi
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 13/12/2019 à 03:29, Xinyu Li a écrit :
> In init_guest_space, we need to mmap guest space. If the return address
> of first mmap is not aligned with align, which was set to MAX(SHMLBA,
> qemu_host_page_size), we need unmap and a new mmap(space is larger than
> first size). The new size is named real_size, which is aligned_size +
> qemu_host_page_size. alugned_size is the guest space size. And add a
> qemu_host_page_size to avoid memory error when we align real_start
> manually (ROUND_UP(real_start, align)). But when SHMLBA >
> qemu_host_page_size, the added size will smaller than the size to align,
> which can make a mistake(in a mips machine, it appears). So change
> real_size from aligned_size +qemu_host_page_size
> to aligned_size + align will solve it.
> 
> Signed-off-by: Xinyu Li <precinct@mail.ustc.edu.cn>
> ---
>  linux-user/elfload.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
> index f6693e5760..312ded0779 100644
> --- a/linux-user/elfload.c
> +++ b/linux-user/elfload.c
> @@ -2189,7 +2189,7 @@ unsigned long init_guest_space(unsigned long host_start,
>               * to where we need to put the commpage.
>               */
>              munmap((void *)real_start, host_size);
> -            real_size = aligned_size + qemu_host_page_size;
> +            real_size = aligned_size + align;
>              real_start = (unsigned long)
>                  mmap((void *)real_start, real_size, PROT_NONE, flags, -1, 0);
>              if (real_start == (unsigned long)-1) {
> 

Applied to my linux-user branch.

Thanks,
Laurent


