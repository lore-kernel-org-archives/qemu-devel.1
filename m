Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A6B3C2BA19
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 10:10:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33313206F8
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 10:10:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HQk2tIDq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33313206F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLOiM-0005RA-ET
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 06:10:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48510)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jLOZb-0003tu-Cq
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 06:01:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jLOZa-0001ls-3A
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 06:01:43 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:47074)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jLOZZ-0001ld-VS
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 06:01:42 -0400
Received: by mail-oi1-x241.google.com with SMTP id q204so12498595oia.13
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2020 03:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=OJ8S7AnKW5WZF+go9NXLWgFfIZ41YHnovmvRKzZrJfU=;
 b=HQk2tIDqeL1HlbV8KQXBt3rwNduEWFG8ZyDBItzBoctqHGtFVOVDEt6w1ume6wWeUX
 liu0RtEyb4G+WVXsIkQ5QvhTwjk84qqeNP1EJAJnGCEukuOOMZSzrr5OLr+0u7s+8Tt0
 sNcZ0GGswqeLK1jZExvDEQ5Y8oSr+NNfdWPMObZU0Em2951qy32RRpgCXD6XsvoQLMMN
 t1KLzpMWn+ILsQXu7Ed/HppN4EMChhle/CFCiN/AgZfaf1avtw+uv3qkih1tZKFpEHYc
 LXVeeIOuBqxsNdE20TcAukRTc5zaOKhg/aU4t8FaU/r3IEz59BjtwjguweNWNExb9SLa
 uB8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=OJ8S7AnKW5WZF+go9NXLWgFfIZ41YHnovmvRKzZrJfU=;
 b=sBtuy1seTlEXIBfax+6FS6JhucsJtXRFKB2/cCqVnxHW2STaOwQcmzNcuXV1H1LtoH
 i4fo6EydZGYkuq149FlrCk9Tk0h+v4peWGSFBjHdY4/p64rsPinSCwyM4NTEDeizm6+X
 +5t7k7TqLjbIJhtSe7kg3M6mkKkVKoZ3u1QoH7DUaUWFdE2UeHXFzXm7Qsz3FQaMA4U3
 rXlYWeCGDXLMu+dQDZI1lCfwLl7ODgEvGbCqlJmaXiO74FR3KiBb9yc18LkqWVxpizHi
 eQNOzvTc5MpJhcP4iWc444QNzlm7kA1RH6Kuy1NXdLdStBIY3qJonP4GYhbKwaJbew2j
 8Eng==
X-Gm-Message-State: AGi0PuYAKnIA28nH8RNv6NtaBCq3LX2cKuvgaBRKBijNW0sJcB95lh9K
 FG8QAGVAvHeWTxR0ACe04NPCIFwpIybLvUOo6Xcc0gIKy60=
X-Google-Smtp-Source: APiQypKeljibhpwASjlqIdECMCvjif96mxNpYOUkVAU7H7ygS8nfBuaT09Aa5gO31FgEGn1y+3WqpsUT5CkYtYmXo1o=
X-Received: by 2002:a05:6808:8cb:: with SMTP id
 k11mr11432224oij.48.1586167300962; 
 Mon, 06 Apr 2020 03:01:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200324173630.12221-1-peter.maydell@linaro.org>
In-Reply-To: <20200324173630.12221-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 6 Apr 2020 11:01:29 +0100
Message-ID: <CAFEAcA-HEZ8S_Dt86uwrm2neOBZNaPVOuPK3i+HHhMUCD+G6YQ@mail.gmail.com>
Subject: Re: [PATCH for-5.0] dump: Fix writing of ELF section
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
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
Cc: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 qemu-stable <qemu-stable@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I forgot to cc qemu-stable, so doing that now (I've also added the
Cc: tag to the commit message for when I send this in the target-arm
pullreq today); for the record, the Coverity id is CID 1421970
(also added to the commit message).

thanks
-- PMM

On Tue, 24 Mar 2020 at 17:36, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> In write_elf_section() we set the 'shdr' pointer to point to local
> structures shdr32 or shdr64, which we fill in to be written out to
> the ELF dump.  Unfortunately the address we pass to fd_write_vmcore()
> has a spurious '&' operator, so instead of writing out the section
> header we write out the literal pointer value followed by whatever is
> on the stack after the 'shdr' local variable.
>
> Pass the correct address into fd_write_vmcore().
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> I have not tested this because I can't reproduce the conditions
> under which we try to actually use write_elf_section() (they
> must be rare, because currently we produce a bogus ELF file
> for this code path). In dump_init() s->list.num must be
> at least UINT16_MAX-1, which I think means it has to be a
> paging-enabled dump and the guest's page table must be
> extremely fragmented ?
> ---
>  dump/dump.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/dump/dump.c b/dump/dump.c
> index 6fb6e1245ad..22ed1d3b0d4 100644
> --- a/dump/dump.c
> +++ b/dump/dump.c
> @@ -364,7 +364,7 @@ static void write_elf_section(DumpState *s, int type, Error **errp)
>          shdr = &shdr64;
>      }
>
> -    ret = fd_write_vmcore(&shdr, shdr_size, s);
> +    ret = fd_write_vmcore(shdr, shdr_size, s);
>      if (ret < 0) {
>          error_setg_errno(errp, -ret,
>                           "dump: failed to write section header table");
> --
> 2.20.1
>

