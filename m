Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 411D3C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 17:40:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BEAD20714
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 17:40:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KOUhjr4a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BEAD20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52818 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGnXF-00020c-8L
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 13:40:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58240)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jGnVy-000120-Nl
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 13:39:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jGnVx-0006Ke-BV
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 13:38:58 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:42215)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jGnVw-0006KR-W4
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 13:38:57 -0400
Received: by mail-oi1-x242.google.com with SMTP id e4so5731653oig.9
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2020 10:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=YTNlgKZGjTrkTDpb+XM6xbG1zTxAGD1mH3QOFM+84lk=;
 b=KOUhjr4a0DSVv8yiFgk7BxTFHcLqlP7srruXqR6+mHBU8fOOjF7R9bfHHyJB7a19Xa
 pdrdOiSSefh8RovLGq1IYjr5K0Lz60I/hW8dO4y1oSBE3CFuVvv1GnjUcb2dJRoJB9ob
 wzx3vZF9Mh3NvNo7ZqNlNbdxc5yc4jYk3KJeFMAfJT/oORnwhzoDZ8yqW1Ny/l6bUwDA
 Z09UCUYTJrQeGABPoMBrpDtdHQSqZurHsvGZCaOjOtINZBvSt5mzDoLOclq8bWx99EZV
 psJGzRZUDKgsXwEjFFPLewVwdJmXU5/w78Pi21op5VbLMfTGbPuhtsMLOKCujSQx75O4
 RCpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=YTNlgKZGjTrkTDpb+XM6xbG1zTxAGD1mH3QOFM+84lk=;
 b=U+pv+Rm0uPqRcklKI6E8Nx/tj5crPBKNPRNY5Ksb/vSgKQzXHBNV2PFJ1uPB+hApyD
 GWn1sric1iDQM10YEZT7SKNfStCVdaz2YQhr0/feQo58Ev4+vywLjpFWcRCjAKpCE14l
 tNOh1tyJBC8/+Mu7pJnr2udqk8RgaGaStV41eZqYquAAg0Hvpo6EybyKVTXV75gn5Z94
 Zma8zZOf+SiwWIfYzUvSnE9Qa563ATS3hlnIO9+6dPNUAb4NvNnLZnbnmSO2Fp0VkJ3E
 8bIQqHK/wTp2EdCMpGQijJAsorTWHOnqff+kmYDRvvIZl9iAku0Rkem+YY8VN/schxQ3
 Ludg==
X-Gm-Message-State: ANhLgQ3sMTXxf1zByp1PQuFC+zgWzaHRI06zUOGHaswVN4XB/9OmMhIr
 7PFpoAhal6mbFPsqklM0xxJDPnVwGhBEARJwPS2gNAPZtwU=
X-Google-Smtp-Source: ADFU+vsOcdWxGFb8J3IDgODjpoJbg1uql5pnTXelmA1hnb8N7ICXPzy5QhdCBKZ9NAfEZakgsLYKtfNHuf6GxLjE6p8=
X-Received: by 2002:aca:c608:: with SMTP id w8mr4348918oif.163.1585071535913; 
 Tue, 24 Mar 2020 10:38:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200324173630.12221-1-peter.maydell@linaro.org>
In-Reply-To: <20200324173630.12221-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Mar 2020 17:38:44 +0000
Message-ID: <CAFEAcA8epRWom-KVMA8D4JH5vq5h=zKOtON4q6tRUmE-wup=Qw@mail.gmail.com>
Subject: Re: [PATCH for-5.0] dump: Fix writing of ELF section
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
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
 qemu-stable <qemu-stable@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

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

Just realized this probably merits
Cc: qemu-stable@nongnu.org

thanks
-- PMM

