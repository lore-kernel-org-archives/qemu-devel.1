Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B1D1C2D0CE
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 11:00:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6545720882
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 11:00:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jbqmnk2n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6545720882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51572 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itrGZ-0000a3-5N
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 06:00:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39353)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1itrFg-0008Hf-GL
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 05:59:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1itrFd-00081z-Ar
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 05:59:20 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60714
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1itrFd-00081d-73
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 05:59:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579604356;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PWN7WYYhGpWJtGq5gmEw7o4qADwvo3xJbKEwClMLZ58=;
 b=Jbqmnk2n1hli1qyewpIX6eQIZOVaOUT3Z9fzcgS179FgxOaodeoJGY3ZsVZ3isqUZgvsZy
 ZwTxL2oKH6AFSBD0mbepck7tQpfRg48QfSYVv36IrvvngtlKpgLJMwvM+gix60Otjc2aYK
 /yDbrQ67iIY3f9jYykmLvS/8u3+NoLQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-266-zdPFdJwbNXitlkPblUNFsg-1; Tue, 21 Jan 2020 05:59:15 -0500
Received: by mail-wm1-f70.google.com with SMTP id h130so466198wme.7
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2020 02:59:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=dhmFsf64YHm2QwKtabgb9Eq8RCEDAMNQvq6h9ZwPk1M=;
 b=FVZ86CU3d/niYAIXV+hdIHfWl40kFvBte3uhOuN7V1Sw3LL8vQFPn6GjHbRBCo5VBX
 JpIXmBlzpBELCg0vwjBcqpCQjSel0aiUOOuK1IOFT/RtaUu0EElvXrK0AH/YgtgMhJkw
 jdh1b+M734c/tO2VvV9+JKle0MY8W9xJZfRHX4F0l0/BPFpg/GAEzqx2frCl3GMPKW7l
 Z9is4ya6VQvpQDlhwSaCWSrcNu0ZqZwoYPtiCTWaWsRU7CIk+cg0jFm3Ivx4+sn4tEeK
 TzvW6myMWtE5QSmSM72e3PgchErn4RhfpxGxTqS16It7QmvYum9Vb7updWqgpv5qzjyM
 TqYA==
X-Gm-Message-State: APjAAAXnZBn0l4XNL6ra/WP7XvSePZnnyNLHwTcK7o3tzcNIFnknaAyI
 2C4dXfb/JipJXbRZqOk+BmumPP+4ac3vMaqq+YvUQCf9Ri+PvFIWwuZpFzuk6pzVkPNFZatg99O
 i8c4vjuVIvAfrc/w=
X-Received: by 2002:a05:600c:22d1:: with SMTP id
 17mr3615182wmg.23.1579604354078; 
 Tue, 21 Jan 2020 02:59:14 -0800 (PST)
X-Google-Smtp-Source: APXvYqx5MelZWV8+LtGF8E2sEf1inJxThgnZN5UI8GrShXpw11KCyiUD0YGEfhi45CvbShwMET9s7Q==
X-Received: by 2002:a05:600c:22d1:: with SMTP id
 17mr3615153wmg.23.1579604353778; 
 Tue, 21 Jan 2020 02:59:13 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id i5sm3450746wml.31.2020.01.21.02.59.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jan 2020 02:59:13 -0800 (PST)
Subject: Re: [PATCH v2 5/6] hw/core: Restrict reset handlers API to system-mode
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20200118140619.26333-1-philmd@redhat.com>
 <20200118140619.26333-6-philmd@redhat.com> <877e1m4c9f.fsf@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <f76e8053-1a93-9be7-1030-fa6e9ad3753d@redhat.com>
Date: Tue, 21 Jan 2020 11:59:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <877e1m4c9f.fsf@linaro.org>
Content-Language: en-US
X-MC-Unique: zdPFdJwbNXitlkPblUNFsg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Riku Voipio <riku.voipio@iki.fi>, qemu-devel@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/20/20 12:07 PM, Alex Benn=C3=A9e wrote:
>=20
> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:
>=20
>> The user-mode code does not use this API, restrict it
>> to the system-mode.
>>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> ---
>>   hw/core/Makefile.objs | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/core/Makefile.objs b/hw/core/Makefile.objs
>> index 0edd9e635d..2fea68ccf7 100644
>> --- a/hw/core/Makefile.objs
>> +++ b/hw/core/Makefile.objs
>> @@ -1,6 +1,7 @@
>>   # core qdev-related obj files, also used by *-user:
>>   common-obj-y +=3D qdev.o qdev-properties.o
>> -common-obj-y +=3D bus.o reset.o
>> +common-obj-y +=3D bus.o
>> +common-obj-$(CONFIG_SOFTMMU) +=3D reset.o
>=20
> This seems a very minor tweaks as far as it goes. I though the only
> thing needed in hw was hw/core/cpu and everything else was system
> emulation?

Unfortunately qdev.o pulls in a lot of unnecessary code (qbus, machine=20
properties...).

>=20
> However it at least moves the needle in the right direction:
>=20
> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

Thanks!

>>   common-obj-$(CONFIG_SOFTMMU) +=3D qdev-fw.o
>>   common-obj-$(CONFIG_SOFTMMU) +=3D fw-path-provider.o
>>   # irq.o needed for qdev GPIO handling:
>=20
>=20


