Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DAC0FA372A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 11:58:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAD6F2082C
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 11:58:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rZytt+Hd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAD6F2082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL4Pt-0001R0-1z
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 07:58:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50461)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iL4PA-00010U-1T
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 07:57:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iL4P8-0006HE-Bx
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 07:57:19 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:36359)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iL4P7-0006Gr-Or
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 07:57:18 -0400
Received: by mail-ot1-x341.google.com with SMTP id 67so1633933oto.3
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 04:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=zIAvEvJnJARZAm+fFGiE5GBmrEcwikfV06GnqKZ4tVs=;
 b=rZytt+Hd/A6N/fA6Vi12xKmUwXkT4S4OIf36nPid28LTdFcpjr645onE8Yj6p6Hr5M
 hwwTu5XXIAHFlLOTVHo7ih9x86dUbow1uDZhworm6TFJp42DOGUF4zYYY7BTQgkFzuiA
 202EPNBNP8MeM6Cc8W/2TtQubypEDZzb9a01FfMTbY81/FhO9Hq+ZNFsEo+pnoTNENmg
 vygXMAHRA3Vu4GcfZD2svLq9KoSq3OJJajXJwGzfpaKBnz2ZIlk1b4nB3OUCZywCRTU0
 mC/YDxjSUA1sSE3KY6WF4ZHa5VxNzIQEBM+geo52SXCyn4CzvkYzw0Zt1yOHhdiugNLg
 SCOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=zIAvEvJnJARZAm+fFGiE5GBmrEcwikfV06GnqKZ4tVs=;
 b=O6uQqj7PddDYLwk3+pSuEMGTaFjF9frVIeOUkU0F7A6jLwYossc2iaXvmRKC1EOdQ0
 oFsCozQMpjDlLCIfNZejIYHiHxKNmPL1ofQaAVpIdTqam+sNzTO/wYlr4UkHb2zEjVV5
 GAtXUjiPA9OzUy060ZazvO9MURmPdo321uxM7uUpYlGVJWqdpS6i1PShsV0OoSRAPpiC
 f79CWQO2jQUxnbyg+ux21xAhTenlat0a/qEVJ8w0o0GTOeahxAKB9wsGD2CGzeNNPoI0
 rXhOaCgqQ0cWH+mAfSdZ5e2uIKVTYZu9jFkGd1eRFzB6fvBe8NDEI6EyVrOntNPsKEgk
 XFjQ==
X-Gm-Message-State: APjAAAUYJ2ogmOtFdGzWucLzmC9p8+Pj053cXMJx42Cf3YbOzoScazFg
 qcXUByt5Jfsb/6vCILuHC6WSV/KnbgTMj5s3+2kNUg==
X-Google-Smtp-Source: APXvYqx0TKqUHwz6zKwfZvtZgS+pk1d6qQqlYVAnh1kxSVYjGAKmgeQ2/O7K5lTcKvdo0ylpkepltnitUxe1TTD9NWI=
X-Received: by 2002:a9d:708e:: with SMTP id l14mr2697955otj.135.1571313436432; 
 Thu, 17 Oct 2019 04:57:16 -0700 (PDT)
MIME-Version: 1.0
References: <20191010113356.5017-1-david@redhat.com>
 <20191010113356.5017-20-david@redhat.com>
In-Reply-To: <20191010113356.5017-20-david@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 17 Oct 2019 12:57:04 +0100
Message-ID: <CAFEAcA-Z94EAN_dt06nH97SbyMc3Jg6uj_xn-zTTMjUrvNrUDw@mail.gmail.com>
Subject: Re: [PULL 19/31] target/s390x: Return exception from
 mmu_translate_real
To: David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
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
Cc: Thomas Huth <thuth@redhat.com>, qemu-s390x <qemu-s390x@nongnu.org>,
 Cornelia Huck <cohuck@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 10 Oct 2019 at 12:35, David Hildenbrand <david@redhat.com> wrote:
>
> From: Richard Henderson <richard.henderson@linaro.org>
>
> Do not raise the exception directly within mmu_translate_real,
> but pass it back so that caller may do so.
>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> Message-Id: <20191001171614.8405-8-richard.henderson@linaro.org>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Hi; Coverity complains about dead code in this patch:



> --- a/target/s390x/mmu_helper.c
> +++ b/target/s390x/mmu_helper.c
> @@ -554,14 +554,11 @@ void s390_cpu_virt_mem_handle_exc(S390CPU *cpu, uintptr_t ra)
>   * @param rw     0 = read, 1 = write, 2 = code fetch
>   * @param addr   the translated address is stored to this pointer
>   * @param flags  the PAGE_READ/WRITE/EXEC flags are stored to this pointer
> - * @return       0 if the translation was successful, < 0 if a fault occurred
> + * @return       0 = success, != 0, the exception to raise
>   */
>  int mmu_translate_real(CPUS390XState *env, target_ulong raddr, int rw,
> -                       target_ulong *addr, int *flags)
> +                       target_ulong *addr, int *flags, uint64_t *tec)
>  {
> -    /* Code accesses have an undefined ilc, let's use 2 bytes. */
> -    uint64_t tec = (raddr & TARGET_PAGE_MASK) |
> -                   (rw == MMU_DATA_STORE ? FS_WRITE : FS_READ);
>      const bool lowprot_enabled = env->cregs[0] & CR0_LOWPROT;
>
>      *flags = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
> @@ -570,9 +567,10 @@ int mmu_translate_real(CPUS390XState *env, target_ulong raddr, int rw,
>          *flags |= PAGE_WRITE_INV;
>          if (is_low_address(raddr) && rw == MMU_DATA_STORE) {
>              /* LAP sets bit 56 */
> -            tec |= 0x80;
> -            trigger_access_exception(env, PGM_PROTECTION, ILEN_AUTO, tec);
> -            return -EACCES;
> +            *tec = (raddr & TARGET_PAGE_MASK)
> +                 | (rw == MMU_DATA_STORE ? FS_WRITE : FS_READ)

We're inside a condition which includes 'rw == MMU_DATA_STORE',
so checking it again here is unnecessary, and the 'false'
part of this ?: conditional is dead-code.

> +                 | 0x80;
> +            return PGM_PROTECTION;
>          }
>      }

thanks
-- PMM

