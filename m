Return-Path: <SRS0=YGca=2Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0089CC2D0C2
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jan 2020 11:53:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFE4A21734
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jan 2020 11:53:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="em6BFNCn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFE4A21734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33468 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1inhzQ-0000YW-UJ
	for qemu-devel@archiver.kernel.org; Sat, 04 Jan 2020 06:53:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51713)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1inhyn-0008U8-0p
 for qemu-devel@nongnu.org; Sat, 04 Jan 2020 06:52:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1inhyk-0003m4-Fp
 for qemu-devel@nongnu.org; Sat, 04 Jan 2020 06:52:27 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26423
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1inhyk-0003l2-8N
 for qemu-devel@nongnu.org; Sat, 04 Jan 2020 06:52:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578138745;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xUPxvr1j/yrxmzlyDub+hti4+qiGUCmgAfwfIn5Kl1o=;
 b=em6BFNCnWzsI9kX9JnKbKn7/C6JoA3QbMyDJMhY18INlnei7rsfV36TUlZ1UUEd611a8ja
 L7qw7lL6eYt7kx8DLWw+ybHnCkcRap1E+ctiVpWpJOAXo/Elt+fjY9KAyhnbru0XSes/W7
 B38wIsXSkg0/pPQOSHB+KZEoifLb9AE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-49-qTiTc4qSOnugERVy8mHXdQ-1; Sat, 04 Jan 2020 06:52:24 -0500
Received: by mail-wr1-f69.google.com with SMTP id f10so16121698wro.14
 for <qemu-devel@nongnu.org>; Sat, 04 Jan 2020 03:52:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=vq+dQShX6JSIhEI8T/QVO+7pzoZQzvn3krVIbWkxjDg=;
 b=LrWmrXBkdaj++5Spwg1WSuabmqSetkRT8TyX5Ge5Kez4xS/of8KhBtfdi2E9o2s0RH
 mm5LEzBvvWC2amitqXbAMawBV6MBvLN6swVuKP+x+XRQOLeo6KGRTp/Tdxg2dyu/44Mh
 gXd9RTGDRjp7RlhMPOzH0lfMD9foxDTk2a+UI73HOPETB/SCBiV4lJclWyWhv/jQOeio
 0P5ia7uWmgT9/c+/sfFb4YLTJbEggAm+PglOJw7OHkqMHjFojk+mPAni26b/6X5In7Z4
 +APHJt0pMTLkTL4I8UFH0HgULktOzIexH2HDtTIIMGB9TX1HO43MvjBrvmnLdXKKvH9+
 8/rQ==
X-Gm-Message-State: APjAAAWUZFEPdmWiqfF5f0Yu/kXWfYiQEgXhcvkscw5JSwqcUU+EfIil
 09xGcZhpL3O8ZU8aHHoQtpC9Gb3/DnC+hQhBrFK+w901BV7+4rzbPnTx+BScX/JwPy8HA9BxaZ7
 x9kFskTFesuVZHS8=
X-Received: by 2002:adf:ee88:: with SMTP id b8mr98121291wro.249.1578138742958; 
 Sat, 04 Jan 2020 03:52:22 -0800 (PST)
X-Google-Smtp-Source: APXvYqx5J/b69s9JGzELiy7eFsUlZCxeGY5DVHYbHyakAaVm27Lt5KwoGSpOwTrcnrDvVhLKOesEFA==
X-Received: by 2002:adf:ee88:: with SMTP id b8mr98121274wro.249.1578138742709; 
 Sat, 04 Jan 2020 03:52:22 -0800 (PST)
Received: from [192.168.1.35] (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id b10sm66387540wrt.90.2020.01.04.03.52.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 04 Jan 2020 03:52:22 -0800 (PST)
Subject: Re: [PATCH v3 09/29] plugins: Include trace/mem.h in api.c
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20191228231124.18307-1-richard.henderson@linaro.org>
 <20191228231124.18307-10-richard.henderson@linaro.org>
 <e93e6b71-60ca-3fb1-7030-a68b3877b8ea@redhat.com>
 <f684bf22-4b89-897f-7f03-3e6d86e06692@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <a08971df-296f-460b-de68-dee1445ec0a6@redhat.com>
Date: Sat, 4 Jan 2020 12:52:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <f684bf22-4b89-897f-7f03-3e6d86e06692@linaro.org>
Content-Language: en-US
X-MC-Unique: qTiTc4qSOnugERVy8mHXdQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Llu=c3=ads_Vilanova?= <vilanova@ac.upc.edu>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/3/20 10:59 PM, Richard Henderson wrote:
> On 1/3/20 5:22 PM, Philippe Mathieu-Daud=C3=A9 wrote:
>> Hi Richard,
>>
>> On 12/29/19 12:11 AM, Richard Henderson wrote:
>>> Code movement in an upcoming patch will show that this file
>>> was implicitly depending on trace/mem.h being included beforehand.
>>
>> Ah, it uses the TRACE_MEM_* macros from "trace/mem-internal.h", which is
>> include by "trace/mem.h". OK.
>>
>> Which part requires "trace-root.h"? Isn't it "trace/mem-internal.h" that=
 should
>> include "trace-root.h"?
>=20
> I don't know -- perhaps it's not required at all.  I think I did a blind =
copy
> of the trace related includes that were being removed.

I'v tested your series, removing "trace-root.h" from this patch and=20
building next patches, and there is no problem, it is indeed not=20
required at all.

Removing "trace-root.h":
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Regardless:
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


