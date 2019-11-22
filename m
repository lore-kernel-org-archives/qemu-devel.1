Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDCBBC43215
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 20:29:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 999432070E
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 20:29:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RM8yVxbX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 999432070E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54784 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iYFYy-0004lt-Qw
	for qemu-devel@archiver.kernel.org; Fri, 22 Nov 2019 15:29:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55238)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iYFXg-0004DA-PC
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 15:28:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iYFXe-0008B0-E6
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 15:28:35 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:48813
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iYFXe-0008AL-4n
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 15:28:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574454513;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aqGDewaeMh9D3BaI3JG8bTmTNFvfpO/YAxTaHMHnDR0=;
 b=RM8yVxbXKwLk4PAFELCiqwtbUA5X5Wv0euO+FGt+Zl0oQT6U8/eGaEC27TpEy++/id3cFz
 RwcWiqn1ofRzYYjM8RKCjcEJEt8SIgKFsIR+BMMUeEVANFSsu6wgyWzynUk/ex1MlVbJWj
 ZUyKdH5y+/T2E5wI1CF4jIEv/9uYfnM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-99-_yVbATbrOWibAfZ2x-NnJQ-1; Fri, 22 Nov 2019 15:28:31 -0500
Received: by mail-wr1-f70.google.com with SMTP id p1so3301148wrw.8
 for <qemu-devel@nongnu.org>; Fri, 22 Nov 2019 12:28:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=o2x+yaeJ/WHyq2S8rwFaJQC4POfynrXGnJ/IpZficrg=;
 b=pnAPsX+85hgNNIPDA9Wc4NPcvH92oZR3UIDu606n351+iqTMPu8to5ya2zsvodHzXQ
 SW3lALIh+o2Sxse/eleZXK9H8/5ToCKrQR3ybCAk9vCsu8XOPysC9z8+X0kPUm/6Jwer
 O5GEt4W5FmY3IBC5D2Te7lD1Bw5Cd+w4H9BsrMIkT5QAaQKPsNjGlL0Yg0Y0ndbG86JJ
 09RtIxUUXyZ78N7lIxQ/GO6SftkzJt81a754K0+L2xTpMhMmQMr7HoC7JJqRbo+o1z8x
 /BXa3I7NQfFRreSWtemn0iojXihyfx/JCDr/QYmZjPtbTr0EIy5eorY3aKi9ej+JgooH
 Wpkg==
X-Gm-Message-State: APjAAAVgCWD9/w5mdLZgP8XbpcFZ+UKRr3I2y1yjEA3qUnZg9uFCTfLI
 YWfRxk7Ea96Na0ThY574jTjRbldDVGYjH2+5pKFSFNwfCqc8nyLDJkEnWHpRIIaqJjTmNBoMGZl
 ciTkF98p5Hqn6f1k=
X-Received: by 2002:a7b:c8c6:: with SMTP id f6mr1020751wml.13.1574454510083;
 Fri, 22 Nov 2019 12:28:30 -0800 (PST)
X-Google-Smtp-Source: APXvYqyL1M2K5O/id7A/acWBl/2CTVGPsojxXEp/1cuwvjQFbScmezV+uSfzeFv9E8+6Ra1p3RFPtA==
X-Received: by 2002:a7b:c8c6:: with SMTP id f6mr1020734wml.13.1574454509898;
 Fri, 22 Nov 2019 12:28:29 -0800 (PST)
Received: from [192.168.1.35] (131.red-88-21-102.staticip.rima-tde.net.
 [88.21.102.131])
 by smtp.gmail.com with ESMTPSA id t187sm134182wma.16.2019.11.22.12.28.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 Nov 2019 12:28:29 -0800 (PST)
Subject: Re: [PATCH v2 5/5] MAINTAINERS: Add two files to Malta section
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
References: <1573652826-23987-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1573652826-23987-6-git-send-email-aleksandar.markovic@rt-rk.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <0fc4bf6b-3725-e2dd-79aa-bc5b74377b39@redhat.com>
Date: Fri, 22 Nov 2019 21:28:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <1573652826-23987-6-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Language: en-US
X-MC-Unique: _yVbATbrOWibAfZ2x-NnJQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: peter.maydell@linaro.org, aleksandar.rikalo@rt-rk.com, hpoussin@reactos.org,
 amarkovic@wavecomp.com, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/13/19 2:47 PM, Aleksandar Markovic wrote:
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
>=20
> Add two files that were recently introduced in a refactoring,
> that Malta emulation relies on. They are added by this patch
> to Malta section, but they are not added to the general MIPS
> section, since they are really not MIPS-specific, and there
> may be some non-MIPS hardware using them in future.
>=20
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> ---
>   MAINTAINERS | 2 ++
>   1 file changed, 2 insertions(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ba9ca98..f8a1646 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -959,8 +959,10 @@ M: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>   R: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
>   R: Aurelien Jarno <aurelien@aurel32.net>
>   S: Maintained
> +F: hw/isa/piix4.c

Maybe:

    F: hw/*/piix4.c

Or also add:

    F: hw/acpi/piix4.c

>   F: hw/mips/mips_malta.c
>   F: hw/mips/gt64xxx_pci.c
> +F: include/hw/southbridge/piix.h
>   F: tests/acceptance/linux_ssh_mips_malta.py
>  =20
>   Mipssim
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


