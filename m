Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0809AC32771
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 10:50:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7F3A207FD
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 10:50:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E+BbNRDX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7F3A207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iw1y3-0002k9-Ua
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 05:50:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44847)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iw1x9-0001xT-HP
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 05:49:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iw1x8-0007my-BF
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 05:49:11 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:30559
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iw1x8-0007ma-8C
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 05:49:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580122149;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1ZGcZobXFPSfW+Y9ZDx4BxNaOVz1JOpgiSu/3hiEJ2I=;
 b=E+BbNRDX+dMDSZWtmkVXqPrQJQP71ZORj+N+jtIRxcEPWLFv3hyqas28G1lMLqwWP9cCST
 GBLqxxLetMjUEIGlDYHn0kReHYlnDHSp8X1+LqgP5pgsdUTvu8oPDZcr2oM/2rSWhgQSzI
 FDXeuolY8ALx59pLgFaVUaoaOt9vowA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-372-FrHVdhRAPvy796Sm1TUo1Q-1; Mon, 27 Jan 2020 05:49:07 -0500
Received: by mail-wr1-f72.google.com with SMTP id u12so5877371wrt.15
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2020 02:49:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=HWt5QEKWSaIwB8izXO+a+hyDvNnZfkOHSWr7GgQFrtI=;
 b=e+tsZJCjd0H9uyLjMPb/qA33W6rfn488JUfvykv2Fwv83wC630UDfpQI4Mza3GZ7YL
 h3id81EiMyNOk65GJQs3HGhyl6LumDxn4lrMAyIqcpmRRrLvYi19j6NXAxsZCaik/PFD
 u7ZNOAKyZHWSbmggINlCQQ2tap3GjHK7sNL9W18cCxMJIiRsxUDFpG9aIHhDVzB/TjMh
 TsAc3SgZ8SvWvl0UDgZ4h/4XbUqxn6sZOCweuzafWNBg7GzxYSvKGpMUDeM/4pJg2mws
 Pt8tDAbSq9fMXmx00/liWiQ1dVrNHUPuu2cc3Sjmvm9FXXml46PVJRpN7AS2zqHIIHq8
 JF2A==
X-Gm-Message-State: APjAAAWw96QbqZsAyizmp/Q4MR53zkBU6nvUDqoC2CNNXil7XUIDnZMp
 ocTwFF6TLSa6IrWeM/win/rl86iCzFkSKYPt7o/yL6CVafwsZYSkwxs7QeMpGIrVCkR0jpM48EZ
 sp1hkQUJ7pkDmjuY=
X-Received: by 2002:a05:600c:242:: with SMTP id 2mr11105308wmj.2.1580122145450; 
 Mon, 27 Jan 2020 02:49:05 -0800 (PST)
X-Google-Smtp-Source: APXvYqxYU0QQeX1MvnSlyOfGGXAzIazUhdv7afSTWwPmgiDS1CnCpq6bpFnpQnHlpbIxQRk28gtaNQ==
X-Received: by 2002:a05:600c:242:: with SMTP id 2mr11105287wmj.2.1580122145240; 
 Mon, 27 Jan 2020 02:49:05 -0800 (PST)
Received: from [192.168.50.32] (243.red-88-26-246.staticip.rima-tde.net.
 [88.26.246.243])
 by smtp.gmail.com with ESMTPSA id y20sm10350484wmi.23.2020.01.27.02.49.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Jan 2020 02:49:04 -0800 (PST)
Subject: Re: [PATCH v3 01/13] usb/dev-storage: remove unused include
To: Maxim Levitsky <mlevitsk@redhat.com>, qemu-devel@nongnu.org
References: <20200127103647.17761-1-mlevitsk@redhat.com>
 <20200127103647.17761-2-mlevitsk@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <bc640c71-dfec-f2a6-c5d3-f38d8fdbfa00@redhat.com>
Date: Mon, 27 Jan 2020 11:49:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200127103647.17761-2-mlevitsk@redhat.com>
Content-Language: en-US
X-MC-Unique: FrHVdhRAPvy796Sm1TUo1Q-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 QEMU Trivial <qemu-trivial@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/27/20 11:36 AM, Maxim Levitsky wrote:
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>   hw/usb/dev-storage.c | 1 -
>   1 file changed, 1 deletion(-)
>=20
> diff --git a/hw/usb/dev-storage.c b/hw/usb/dev-storage.c
> index 8545193488..50d12244ab 100644
> --- a/hw/usb/dev-storage.c
> +++ b/hw/usb/dev-storage.c
> @@ -19,7 +19,6 @@
>   #include "hw/scsi/scsi.h"
>   #include "ui/console.h"
>   #include "migration/vmstate.h"
> -#include "monitor/monitor.h"
>   #include "sysemu/sysemu.h"
>   #include "sysemu/block-backend.h"
>   #include "qapi/visitor.h"
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


