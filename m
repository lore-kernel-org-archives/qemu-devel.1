Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3E8FCA9EB0
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 11:38:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A17362084C
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 11:38:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZNKi0xP+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A17362084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38592 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMW0i-00057x-RF
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 07:38:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50274)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iMVvD-0006Sq-E9
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 07:32:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iMVvB-0004mB-8f
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 07:32:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29654
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iMVvB-0004m0-4t
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 07:32:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571657540;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T3fBuQmZuyTKfh4TNAGZyL24MKVkfAt1JQeOMEtXHmU=;
 b=ZNKi0xP+02mt3/ZyxQqSewg0dn0T8hlNNpDndkVjHO8dITtSPGm1bDA/WWikuQ7PrkKE5J
 Ncfv2GNEnZeEP3Y7vsEklm48fYiwRbj7adUV+Je2MzOQfcmHIcAePyFLpkZRrsoj1I1R8n
 sO5AG3E84Ed5IM5RiPvcpN11aprT/0Y=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-108-gmkyvk3DN92VEMVm7Tu4RA-1; Mon, 21 Oct 2019 07:32:18 -0400
Received: by mail-wm1-f70.google.com with SMTP id z24so4560619wmk.8
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2019 04:32:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=dc81EsQUYMovGw9tqHNJQjD5FdSPmSdOttcXx9o3OPk=;
 b=ovTLk/eL7ovji+w/f94Cd8q1L0HbDE9HlfvevFnOVe7LiDKebWikNBvQpGNLzDmpTP
 iQ4+KPUZc7peYF4KgeTCIsQ6geBenj7WVeNgpCvuaQQRC6CyZLEOw6r6B47Co/gUavl8
 Iki0WR6eyurMDEDZPt4mEBYYg2EIVrDPbkMBpscxvW4GUAiirp68PnJhSIMVy62Cuh4j
 8ghT5hl/U6pXwcq5JnplVDYRxUgxvgD7W8NM6YHs49YGHxJ+ptpWMF0EP1QNpmM0hkEh
 tOhdBIV4jwSHEg9ixsXBZ4wD7MJi0SF8rqRmDUA9B7NjaRyLTf4vqnraTrRYQ7an8q/H
 AYag==
X-Gm-Message-State: APjAAAU4JkrbPHDyUBbsrGUd48tjBIjnFTkS/PsWTj7R3eaZPgsmm4B3
 XqrDiYrZWzDHZ+mgAt8xq/oMIvrQlVZkPYt5OZpIMDb4imdez54jE7538NlmLwAzkysXp/y/vkC
 yNRsjGkuD/GeZf4Q=
X-Received: by 2002:a05:6000:1c9:: with SMTP id
 t9mr1848264wrx.171.1571657537483; 
 Mon, 21 Oct 2019 04:32:17 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwSybvXkKjKDzXBQl386VLgXvJJv8kx2dR+9NK+RTWkluh792KHZw/xzmUTxfRa7+adXlhaNQ==
X-Received: by 2002:a05:6000:1c9:: with SMTP id
 t9mr1848245wrx.171.1571657537213; 
 Mon, 21 Oct 2019 04:32:17 -0700 (PDT)
Received: from [192.168.1.41] (129.red-83-57-174.dynamicip.rima-tde.net.
 [83.57.174.129])
 by smtp.gmail.com with ESMTPSA id z142sm15084756wmc.24.2019.10.21.04.32.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Oct 2019 04:32:16 -0700 (PDT)
Subject: Re: [PATCH v5 03/10] MAINTAINERS: Update mail address of Aleksandar
 Rikalo
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
References: <1571592258-27994-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1571592258-27994-4-git-send-email-aleksandar.markovic@rt-rk.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <a13a5da5-5020-6225-25a1-3bf9664c5baa@redhat.com>
Date: Mon, 21 Oct 2019 13:32:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <1571592258-27994-4-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Language: en-US
X-MC-Unique: gmkyvk3DN92VEMVm7Tu4RA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: aleksandar.rikalo@rt-rk.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/20/19 7:24 PM, Aleksandar Markovic wrote:
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
>=20
> Aleksandar Rikalo wishes to change his primary mail address for QEMU.
> Some minor line order is corrected in .mailmap to be alphabetical,
> too.
>=20
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> ---
>   .mailmap    |  5 +++--
>   MAINTAINERS | 18 +++++++++---------
>   2 files changed, 12 insertions(+), 11 deletions(-)
>=20
> diff --git a/.mailmap b/.mailmap
> index 0756a0b..3816e4e 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -39,10 +39,11 @@ Julia Suvorova <jusual@mail.ru> Julia Suvorova via Qe=
mu-devel <qemu-devel@nongnu
>   Justin Terry (VM) <juterry@microsoft.com> Justin Terry (VM) via Qemu-de=
vel <qemu-devel@nongnu.org>
>  =20
>   # Next, replace old addresses by a more recent one.
> -Anthony Liguori <anthony@codemonkey.ws> Anthony Liguori <aliguori@us.ibm=
.com>
> -James Hogan <jhogan@kernel.org> <james.hogan@imgtec.com>
>   Aleksandar Markovic <amarkovic@wavecomp.com> <aleksandar.markovic@mips.=
com>
>   Aleksandar Markovic <amarkovic@wavecomp.com> <aleksandar.markovic@imgte=
c.com>
> +Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com> <arikalo@wavecomp.com>
> +Anthony Liguori <anthony@codemonkey.ws> Anthony Liguori <aliguori@us.ibm=
.com>
> +James Hogan <jhogan@kernel.org> <james.hogan@imgtec.com>
>   Paul Burton <pburton@wavecomp.com> <paul.burton@mips.com>
>   Paul Burton <pburton@wavecomp.com> <paul.burton@imgtec.com>
>   Paul Burton <pburton@wavecomp.com> <paul@archlinuxmips.org>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3ca8148..4964fbb 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -208,7 +208,7 @@ F: disas/microblaze.c
>   MIPS TCG CPUs
>   M: Aurelien Jarno <aurelien@aurel32.net>
>   M: Aleksandar Markovic <amarkovic@wavecomp.com>
> -R: Aleksandar Rikalo <arikalo@wavecomp.com>
> +R: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
>   S: Maintained
>   F: target/mips/
>   F: default-configs/*mips*
> @@ -363,7 +363,7 @@ F: target/arm/kvm.c
>  =20
>   MIPS KVM CPUs
>   M: James Hogan <jhogan@kernel.org>
> -R: Aleksandar Rikalo <arikalo@wavecomp.com>
> +R: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
>   S: Maintained
>   F: target/mips/kvm.c
>  =20
> @@ -934,7 +934,7 @@ MIPS Machines
>   -------------
>   Jazz
>   M: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
> -R: Aleksandar Rikalo <arikalo@wavecomp.com>
> +R: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
>   S: Maintained
>   F: hw/mips/mips_jazz.c
>   F: hw/display/jazz_led.c
> @@ -942,7 +942,7 @@ F: hw/dma/rc4030.c
>  =20
>   Malta
>   M: Aurelien Jarno <aurelien@aurel32.net>
> -R: Aleksandar Rikalo <arikalo@wavecomp.com>
> +R: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
>   S: Maintained
>   F: hw/mips/mips_malta.c
>   F: hw/mips/gt64xxx_pci.c
> @@ -950,20 +950,20 @@ F: tests/acceptance/linux_ssh_mips_malta.py
>  =20
>   Mipssim
>   M: Aleksandar Markovic <amarkovic@wavecomp.com>
> -R: Aleksandar Rikalo <arikalo@wavecomp.com>
> +R: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
>   S: Odd Fixes
>   F: hw/mips/mips_mipssim.c
>   F: hw/net/mipsnet.c
>  =20
>   R4000
>   M: Aurelien Jarno <aurelien@aurel32.net>
> -R: Aleksandar Rikalo <arikalo@wavecomp.com>
> +R: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
>   S: Maintained
>   F: hw/mips/mips_r4k.c
>  =20
>   Fulong 2E
>   M: Aleksandar Markovic <amarkovic@wavecomp.com>
> -R: Aleksandar Rikalo <arikalo@wavecomp.com>
> +R: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
>   S: Odd Fixes
>   F: hw/mips/mips_fulong2e.c
>   F: hw/isa/vt82c686.c
> @@ -972,7 +972,7 @@ F: include/hw/isa/vt82c686.h
>  =20
>   Boston
>   M: Paul Burton <pburton@wavecomp.com>
> -R: Aleksandar Rikalo <arikalo@wavecomp.com>
> +R: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
>   S: Maintained
>   F: hw/core/loader-fit.c
>   F: hw/mips/boston.c
> @@ -2348,7 +2348,7 @@ F: disas/i386.c
>  =20
>   MIPS TCG target
>   M: Aurelien Jarno <aurelien@aurel32.net>
> -R: Aleksandar Rikalo <arikalo@wavecomp.com>
> +R: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
>   S: Maintained
>   F: tcg/mips/

Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


