Return-Path: <SRS0=68uo=YX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7233BCA9EC0
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2019 06:16:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D7D32067D
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2019 06:16:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n4/4gNNa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D7D32067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPhHJ-0002EX-CC
	for qemu-devel@archiver.kernel.org; Wed, 30 Oct 2019 02:16:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42571)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iPhGY-0001ap-2e
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 02:15:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iPhGW-00022R-La
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 02:15:33 -0400
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333]:38381)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iPhGT-0001y3-Hl
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 02:15:31 -0400
Received: by mail-ot1-x333.google.com with SMTP id r14so1124700otn.5
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2019 23:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=qNLvZ4NW7czofI39JBeLB5pWjDvdXKn28u1jTzVFPBY=;
 b=n4/4gNNaqBDKUb9Ypa0hUOTwdTOyRmRuOV2zy1Ug/jvlJ+n65y65qZLVhyZGrg4NW5
 ZpAs7X28zhDzy+bgn8ev93qcv+/dIgBMuWYEdUtSE1cD1yL1jEqsgS6lp3V/ET7jrSXM
 DvgaCVP7zXv06YzUhMZs4afOSENyq2VWfYhGYcpnqWQGWNwjgI4l4cUYtLRh6LgJri0r
 sINiakEdOlhFFlsN7IRGb1pP5xWKpGyjhNF3tToo8UKkzCmJRFDxdXfDTSv5yNekcVYg
 3YDXGx7IxkscAjdU0tQEv7xnO0E8ml24QwuspA/WVn1jQ5alLV4Zw7D6YxbfPp/zHG7B
 fCNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=qNLvZ4NW7czofI39JBeLB5pWjDvdXKn28u1jTzVFPBY=;
 b=rj0RfqqvNxNRE027Bv3M3FyZjp33y5YGkIpZV+Dp0FWqgbBJ8ZJxUbuz7BQyMf8iT/
 oflGx/DD1jOkrAhQTxIKEVXOWlu/ABmPJ+55Twr5yDxNpVwOIJtshrQBI693SO31hVl4
 8wFAbMSJ8+I2tCZ0WiNm7XgJnI1giucc0S3BzHDM0X/f8bVmFUa7rd/2NSefMWOyAIMj
 KGyufhdBCdUEDIIweWbSvOaMwxnmSZ1yrsP056v0lrPVKtNuL7a2lLjsKVEGAXsUe/WJ
 WFCBfjJg7H1kQFtNyKJoLyMnCL3aZj+26XkbHDHXsvAElLrpMbpHVbb/L4HLh1v5gFaV
 xqng==
X-Gm-Message-State: APjAAAUFBNUy1mgAznNzuHRuVhlmywmFX2hh45iw9WxCXicUb6GDDx7E
 eZ2Ova1hE9y92koL8Jv+rZ45GrYJyCCcn8G+6Th2hg==
X-Google-Smtp-Source: APXvYqzEdgHGm6eLzQARVqIy8HRFVHxEtmOIVmf4pq09AYQyTBWRGNXhxefZiaVn/eK7o/lWwj+7JR74vb05zsSfthk=
X-Received: by 2002:a9d:7cd4:: with SMTP id r20mr4336006otn.91.1572416126935; 
 Tue, 29 Oct 2019 23:15:26 -0700 (PDT)
MIME-Version: 1.0
References: <20191028163447.18541-1-philmd@redhat.com>
In-Reply-To: <20191028163447.18541-1-philmd@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 30 Oct 2019 06:15:29 +0000
Message-ID: <CAFEAcA-9wQMzJN+ZeWDE8k1E9uwUw3NHNJuR2H_hHRNeX1Lf8Q@mail.gmail.com>
Subject: Re: [PULL 00/20] hw/i386/pc: Split PIIX3 southbridge from i440FX
 northbridge
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::333
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
Cc: Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 28 Oct 2019 at 17:48, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
>
> Hi Peter,
>
> This is a X86/MIPS pull, Paolo and Aleksandar are OK I send it:
>
>   https://lists.gnu.org/archive/html/qemu-devel/2019-10/msg04959.html
>
> Regards,
>
> Phil.
>
> The following changes since commit 9bb73502321d46f4d320fa17aa38201445783f=
c4:
>
>   Merge remote-tracking branch 'remotes/mst/tags/for_upstream' into stagi=
ng (2019-10-28 13:32:40 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/philmd/qemu.git tags/pc_split_i440fx_piix-pull-reque=
st
>
> for you to fetch changes up to d1389352cde824ce8dab7c1a2ded150df6add124:
>
>   hw/pci-host/i440fx: Remove the last PIIX3 traces (2019-10-28 16:12:29 +=
0100)
>
> ----------------------------------------------------------------
> The i440FX northbridge is only used by the PC machine, while the
> PIIX southbridge is also used by the Malta MIPS machine.
>
> Split the PIIX3 southbridge from i440FX northbridge.
>
> ----------------------------------------------------------------

I get a link failure on my 'do a make clean and then make' build :
  LINK    i386-softmmu/qemu-system-i386
hw/i386/pc_piix.o: In function `pc_init1':
/home/petmay01/linaro/qemu-for-merges/hw/i386/pc_piix.c:197: undefined
reference to `i440fx_init'
/home/petmay01/linaro/qemu-for-merges/hw/i386/pc_piix.c:206: undefined
reference to `piix3_create'
collect2: error: ld returned 1 exit status

thanks
-- PMM

