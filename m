Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 003F5C10F26
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 08:05:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B947920732
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 08:05:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="grwGkIzM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B947920732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58190 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGI5o-00029N-U4
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 04:05:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43935)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jGI5A-0001ee-Qs
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 04:05:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jGI58-0002fU-RU
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 04:05:11 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:29153)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jGI58-0002eW-OI
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 04:05:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584950710;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WfLOALv4gWl4454/x2n7KSNgB4G8ka9+kqdA9ljT2bo=;
 b=grwGkIzMdkJ77dcfaObsblZSSpO/MOjL/YLzRxs7Z8d/sFMARWoSB6hFpDwP2+USZZm7CC
 a39Wot67pl0cweJ4MOvXgHoZ5Bf+KfkLPRW+6HLM5yd7hwTszDe7Xtq4Z/TsU6qyb0dQux
 TjY/i45VKoDbJGrlXR33rib6ZBLhlJA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-67-5WIM56QXPrStZ0mflngOMA-1; Mon, 23 Mar 2020 04:05:06 -0400
X-MC-Unique: 5WIM56QXPrStZ0mflngOMA-1
Received: by mail-wm1-f72.google.com with SMTP id f185so3657465wmf.8
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2020 01:05:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=hjO1ytxYoPYVD1ShivxXzr1V2LHs86TxH50RT2TVJp8=;
 b=iG9RO66URx+MCLV++hyrRZxudtJGKPIo2EO0GVHtGRK58liXtcKxJB94J6YpkCfWOX
 M7jnaSTqahxwiKEsZ4wC2CnAhhqmdWCYmxq23WZCrZDN1tUHEwf23BOuB+V8ZDBAwUQL
 KxX9YHwPQ0o+9lx6Plwztv/q+o2ufyi3fq0imeSRLFwHzhZCo6WaDc8Y/4T7g0Jf1+fW
 b6gRIX7xMtQWMrGvlmC23Vp5xaXxhCTrM/1B0G97qGmxrB49j6NPhjn62Hf8udqHQyBu
 Dniy/Ci9ZidR5v4gpYehytZNMLJziAeXr4TOaIee5r+gN7R8GNiRdye7jXrrAA0nCfts
 EJLw==
X-Gm-Message-State: ANhLgQ3z9tPgwWsi5+CGUpGQesR1meDI3VEq1AN2v3JINyrJ/yaKxf8M
 2Zt2a4coL+2KVy2yZFC1ezksaN2KU76xLWY9TMZ+7cpXK4tdzqB2BEG/k1frxIzIxtNJBXV69ID
 z8FuP/i8bTkoD87U=
X-Received: by 2002:adf:f7ce:: with SMTP id a14mr29257246wrq.180.1584950705582; 
 Mon, 23 Mar 2020 01:05:05 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtTwSFpiFWWZBdSjVnXc9AJtJdu9RkBI7U+NuutC8yL/xtUGEAVzDJmcqdBvG06riM9jpoo8A==
X-Received: by 2002:adf:f7ce:: with SMTP id a14mr29257209wrq.180.1584950705319; 
 Mon, 23 Mar 2020 01:05:05 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:24d8:ed40:c82a:8a01?
 ([2001:b07:6468:f312:24d8:ed40:c82a:8a01])
 by smtp.gmail.com with ESMTPSA id s7sm21759367wri.61.2020.03.23.01.05.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Mar 2020 01:05:04 -0700 (PDT)
Subject: Re: [PATCH-for-5.0 1/2] hw/acpi/piix4: Add 'system-hotplug-support'
 property
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
References: <20200318221531.22910-1-philmd@redhat.com>
 <20200318221531.22910-2-philmd@redhat.com>
 <20200319114424.5723e777@office.mammed.net>
 <4d42697e-ba84-e5af-3a17-a2cc52cf0dbc@redhat.com>
 <20200319160800.614de5fb@redhat.com>
 <d6c0dc2f-5b0f-2e34-6c12-e9d9cd7402c6@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3f70d63d-e9ae-6676-edd5-20613b4b8856@redhat.com>
Date: Mon, 23 Mar 2020 09:05:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <d6c0dc2f-5b0f-2e34-6c12-e9d9cd7402c6@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 22/03/20 17:27, Philippe Mathieu-Daud=C3=A9 wrote:
>>>
>> That 'ugly' is typically used within QEMU to deal with such things
>> probably due to its low complexity.
>=20
> OK. Can you point me to the documentation for this feature? I can find
> reference of GPE in the ICH9, but I can't find where this IO address on
> the PIIX4 comes from:
>=20
> #define GPE_BASE 0xafe0

It's made up.  The implementation is placed in PIIX4_PM because it is
referenced by the ACPI tables.  Real hardware would probably place this
in the ACPI embedded controller or in the BMC.

Paolo


