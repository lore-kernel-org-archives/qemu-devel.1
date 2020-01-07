Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DAE4C33C99
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 09:23:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3572E206DB
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 09:23:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UxgQzQJm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3572E206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45220 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iol4p-0000us-TK
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 04:23:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58518)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iok3I-00082u-40
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 03:17:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iok3F-0004fo-9N
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 03:17:22 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57130
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iok3F-0004f3-66
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 03:17:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578385040;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2Ohh/00XASTFV4FCXDi/7EK0vZHd0Tq6uNQe4Q9vuRU=;
 b=UxgQzQJmjZH0HvWUtwvfOVjb70s2KlfjtRQyFDuiTe2nlOGb7iTKUIiglPtZ7g5R0QkiNv
 zWfwCp+vevxWgnoKEj6MKHvcRV9I7uBwBqu6PQscWOTfNw+W74Ve9nPqIdlu2FEDgjiwY4
 8glzx+HXVuEqOgTOAnMzW3i9s+40dTw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-309-BVkv1nf1Om25Teq3rDTRwA-1; Tue, 07 Jan 2020 03:17:18 -0500
Received: by mail-wm1-f71.google.com with SMTP id h130so3781865wme.7
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 00:17:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=REntnOxvkVvU9/IorJtjyKnxWXB6QVSO/rCfQBHHnv8=;
 b=ZpOs3mm47ZS2T23XnAl5U1McXzG9L64Cdk+8OL0RP14Q2jBPt+RxNCimhk98xlToCV
 0G7juuGIrDq2R783ZD8nCK3mtKCS5EhXOpMfw9LUMaF6l/jM2rcM98MgKDJZOGLMb4CF
 rqmqvlLOeCtZtXEiN0GUCPOl04Xw4ZI6Ybn4GtsFNCWbbSwpX5rvZadad5IBAhRvGxQh
 0VsCxTjya28siWNJuHgKNNYQr3PPY9f4hD/nazOQpNRehzhssmOZASiolriserl6arL2
 7NwmmdjpPxKVSMpO10RQXoRucnA/7/7IzDmaciELCqO53UjYc0CNMXG2xXzqe7zoUhIM
 rJjg==
X-Gm-Message-State: APjAAAUuj+1XG588le3gHIsxRpLpiUCDIH8zgyYrCpfeRC533zr7f2fE
 ILPHozk64IUpefLKL55IoZETlUewrcdGMR63Rp8aNL4nUrYypwSLxRnaEM0HiVtI1byhFI30vLl
 cVSi5QJwLl4VZW3c=
X-Received: by 2002:a7b:c935:: with SMTP id h21mr37708462wml.173.1578385037473; 
 Tue, 07 Jan 2020 00:17:17 -0800 (PST)
X-Google-Smtp-Source: APXvYqzjqu0pveBGSt/XxBYINg45YnX84OBvnfsK9+aKg1J+iGDc6v/z+2BcvUg2hJmRu3CT6RlFqQ==
X-Received: by 2002:a7b:c935:: with SMTP id h21mr37708444wml.173.1578385037268; 
 Tue, 07 Jan 2020 00:17:17 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c6d:4079:b74c:e329?
 ([2001:b07:6468:f312:c6d:4079:b74c:e329])
 by smtp.gmail.com with ESMTPSA id r6sm74998448wrq.92.2020.01.07.00.17.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jan 2020 00:17:16 -0800 (PST)
Subject: Re: [PATCH] hw/timer/Kconfig: Intel 8254 PIT depends of ISA bus
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200106171912.16523-1-philmd@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5d86fe5c-84a9-5f1f-00df-96e4890533a4@redhat.com>
Date: Tue, 7 Jan 2020 09:17:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200106171912.16523-1-philmd@redhat.com>
Content-Language: en-US
X-MC-Unique: BVkv1nf1Om25Teq3rDTRwA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 06/01/20 18:19, Philippe Mathieu-Daud=C3=A9 wrote:
> Since i8254_common.c calls isa_register_ioport() from "hw/isa/isa.h"
> we can not select it when ISA_BUS is disabled. Add a 'depends on'
> clause.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  hw/timer/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/hw/timer/Kconfig b/hw/timer/Kconfig
> index a990f9fe35..59b3f44d69 100644
> --- a/hw/timer/Kconfig
> +++ b/hw/timer/Kconfig
> @@ -15,6 +15,7 @@ config HPET
> =20
>  config I8254
>      bool
> +    depends on ISA_BUS
> =20
>  config ALTERA_TIMER
>      bool
>=20

Queued, thanks.

Paolo


