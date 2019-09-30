Return-Path: <SRS0=LaQQ=XZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B67DEC388F4
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 21:03:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77A01224FE
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 21:03:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="z7T0RJGk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77A01224FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57302 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iF2pO-00088e-Cy
	for qemu-devel@archiver.kernel.org; Mon, 30 Sep 2019 17:03:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49142)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iF2nN-0007BI-Kt
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 17:01:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iF2nJ-0007eJ-BE
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 17:01:23 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:36106)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iF2nA-0007aC-JB
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 17:01:14 -0400
Received: by mail-pf1-x442.google.com with SMTP id y22so6290640pfr.3
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2019 14:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:from:to:cc:references:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=eMKIe/CdULIYaWCBaKK5OYB2eUpmobezOgnOGlLgHdU=;
 b=z7T0RJGkyV1djct6zgtoyD0N8OKwyrS2K945rdKxRGdDfEPncKq3BtxMyd9rPicnpP
 WvXsdAsoe4YWgpVnzg1Uh63X/oevaBHxlm36sixZC3/xz0pjKquRAyPDZj6vqCFdxSXm
 rOKwcrbpbwJHTL+8q2yh6oNGvj1J/4nD89kKSRlNxDKD/HnOYS3F559Ds5qESJofAVEg
 CKEZ+aEvcE+Cf1o92L9HFpUnNozmvtbtV09B8AOEU/ibRuFbs/Eo0UawOvNwvDtccxHQ
 8wpJd/hM6BH+Vf4daZC20hXc7viZPYHB9LQWgyUfBuQv3N3sBEIni02JJpkBv/uz0z7L
 PXKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=eMKIe/CdULIYaWCBaKK5OYB2eUpmobezOgnOGlLgHdU=;
 b=Q5fcC0wQ5iHB6V35I1QQAHiSQskvwXyp/NCpBnOvb2pKz21fQA8mPGnzDZ0A0BuJYA
 cV7jCD8puuT8ZZbKLSODscGh/YNnjBVgVHzmjQ7n/ezH2wql/XuOyyI20o3jepsuKuQK
 VfLtqAdBZ7UbCBog8IZEM2YSTOD7i+D/kn5R0ViK8PeLlMnz4LPCVQkg7LbJbWLpSjwE
 goO7o8ga/P19rs+GygdOWgH7TfMpBBbUpyzk26T9eq8fIFykkBS+RLQqq3X3fiNou6v1
 p9NoXmdEcjdxswN2TkeRwrPGnFv9ABIJUUgGBBQjOXS7MNA+FkUaU0wn4qdMdjEeVk+P
 ISeg==
X-Gm-Message-State: APjAAAUnBwonmujtYsFODt4kkOEmc3G1pOBVB85lxMSEogbaKRwEd8Rb
 eg1FQ29gJ/NRUvfcttvnw28VOA==
X-Google-Smtp-Source: APXvYqyeOloQkK/FQLPnq003Y3KuPoIeUpr3cBvnGVV8T6GivMmYGfUbSiSwmUR0T6OepC5kYqHCbQ==
X-Received: by 2002:a17:90a:220e:: with SMTP id
 c14mr1328066pje.6.1569877267313; 
 Mon, 30 Sep 2019 14:01:07 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id k95sm436110pje.10.2019.09.30.14.01.06
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 30 Sep 2019 14:01:06 -0700 (PDT)
Subject: Re: [PATCH] user-exec: Do not filter the signal on si_code
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
References: <20190930192931.20509-1-richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <ec1ace6c-49db-e769-e43e-6b0e059d6705@linaro.org>
Date: Mon, 30 Sep 2019 14:01:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190930192931.20509-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, laurent@vivier.eu,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/30/19 12:29 PM, Richard Henderson wrote:
> This is a workaround for a ppc64le host kernel bug.
> 
> For the test case linux-test, we have an instruction trace
> 
> IN: sig_alarm
> ...
> 
> IN:
> 0x400080ed28:  380000ac  li       r0, 0xac
> 0x400080ed2c:  44000002  sc
> 
> IN: __libc_nanosleep
> 0x1003bb4c:  7c0802a6  mflr     r0
> 0x1003bb50:  f8010010  std      r0, 0x10(r1)
> 
> Our signal return trampoline has, rightly, changed the guest
> stack page read-only.  Which, rightly, faults on the store of
> a return address into a stack frame.
> 
> Checking the host /proc/pid/maps, we see the expected state:
> 
> 4000800000-4000810000 r--p 00000000 00:00 0
> 
> However, the host kernel has supplied si_code == SEGV_MAPERR,
> which is obviously incorrect.
> 
> By dropping this check, we may have an extra walk of the page
> tables, but this should be inexpensive.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> 
> FWIW, filed as
> 
>   https://bugzilla.redhat.com/show_bug.cgi?id=1757189
> 
> out of habit and then
> 
>   https://bugs.centos.org/view.php?id=16499
> 
> when I remembered that the system is running Centos not RHEL.
> 
> ---
>  accel/tcg/user-exec.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
> index 71c4bf6477..31ef091a70 100644
> --- a/accel/tcg/user-exec.c
> +++ b/accel/tcg/user-exec.c
> @@ -143,9 +143,12 @@ static inline int handle_cpu_signal(uintptr_t pc, siginfo_t *info,
>       * for some other kind of fault that should really be passed to the
>       * guest, we'd end up in an infinite loop of retrying the faulting
>       * access.
> +     *
> +     * XXX: At least one host kernel, ppc64le w/Centos 7 4.14.0-115.6.1,
> +     * incorrectly reports SEGV_MAPERR for a STDX write to a read-only page.
> +     * Therefore, do not test info->si_code.
>       */
> -    if (is_write && info->si_signo == SIGSEGV && info->si_code == SEGV_ACCERR &&
> -        h2g_valid(address)) {
> +    if (is_write && info->si_signo == SIGSEGV && h2g_valid(address)) {

Ho hum.  This change is in conflict with Peter's long comment; I should have
read the context more thoroughly.  There is an even longer comment with the
patch description: 9c4bbee9e3b83544257e82566342c29e15a88637

The SEGV_ACCERR check here is to prevent a loop by which page_unprotect races
with itself and, from Peter's analysis,

>      * ...but when B gets the mmap lock it finds that the page is already
>        PAGE_WRITE, and so it exits page_unprotect() via the "not due to
>        protected translation" code path, and wrongly delivers the signal
>        to the guest rather than just retrying the access

This bug was fixed in the referenced patch.  But then continues:

>     Since this would cause an infinite loop if we ever called
>     page_unprotect() for some other kind of fault than "write failed due
>     to bad access permissions", tighten the condition in
>     handle_cpu_signal() to check the signal number and si_code, and add a
>     comment so that if somebody does ever find themselves debugging an
>     infinite loop of faults they have some clue about why.
>     
>     (The trick for identifying the correct setting for
>     current_tb_invalidated for thread B (needed to handle the precise-SMC
>     case) is due to Richard Henderson.  Paolo Bonzini suggested just
>     relying on si_code rather than trying anything more complicated.)

It is disappointing about the kernel bug.  But since this affects Centos 7,
which is what *all* of the gcc compile farm ppc64 machines use, I think we need
to work around it somehow.

Should we simply add SEGV_MAPERR to the set of allowed si_code, to directly
work around the bug?  If we got that code from a kernel without the bug, then
page_find should fail to find an entry, and we should then indicate that the
signal should be passed to the guest.

Thoughts?


r~

