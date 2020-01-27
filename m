Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9404C32771
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 09:36:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5B5B214DB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 09:36:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yrb+gDkK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5B5B214DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iw0pF-0001cc-Vi
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 04:36:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58125)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iw0oN-0001Ac-Ku
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 04:36:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iw0oM-00080h-LV
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 04:36:03 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30071
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iw0oM-00080V-HD
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 04:36:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580117762;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tdb9VwP9j2ZpPFO+HE4e7VvAj9kp74CdpDeTEB/JQ34=;
 b=Yrb+gDkK4yuoBjadUHy8NZ7ACwfkDKJq3+psrmw7BWdo5pTYb2z+qdVEjW7I0fXp0VGGmh
 4OCAJdnfBv3PbRUkeKI6NFdNSGmEi7LqgDn5K2bU9lt23py4SDGKv/ni5aTX1Xw9NZQ5l8
 HNi3H47nNX7UgDqC4TuQAOJoKIq4BMw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-169-ILgVop-BNqSYsA_0Cpuljw-1; Mon, 27 Jan 2020 04:36:00 -0500
Received: by mail-wm1-f70.google.com with SMTP id l11so2766189wmi.0
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2020 01:36:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=tdb9VwP9j2ZpPFO+HE4e7VvAj9kp74CdpDeTEB/JQ34=;
 b=kGPPAoOyFp0kw7KSlfK4RQcMqePQfHFCaoSJxJwnAv/i9vMz/WjsX+w68gRvsgSxDA
 h3BPGcDQPQQU2/dk3VDPeY3xXBmPIZPS7+UeAAybORsHXuayawmrY1kr4u8Rzbof+hjd
 6nqPwwKFloMNCfjH3cnoAKBzx5cIIAdXuntZGlPn6nuQG/Cw7Oc69cTgkgAUwMf0SKGh
 A3VTt8ICzUTQhKZCXSflm0bnm1jLHwbBpVmquKI0A9kzLzIVAfs6lPzaNmQ82hOrddmM
 8qHqMEta8bqX6zBiDdNeNCQjE9MXDAkFZWnP3r2hu6GTri768Wpwnm2cntPuF5OeeZN/
 6xwA==
X-Gm-Message-State: APjAAAV+TGPBwr5i7ZG1z8iJsDCaseI97Hl1TgV6JWkEQlW1xIzCKDux
 WLCtWl33L1/8tttwRJT6MbBueIQ0nJ6WHFip0dPSjEgvg37VVm10C91znFzyg8S3EhIUybPt/DY
 hhwJMXb3LFNeo+Bw=
X-Received: by 2002:a5d:6a10:: with SMTP id m16mr20222253wru.411.1580117759604; 
 Mon, 27 Jan 2020 01:35:59 -0800 (PST)
X-Google-Smtp-Source: APXvYqy3Oo8z1ltjEEZ7ZhVvir9hFtzRymKQ4tbWzqwuTcNiUdfsYVrFgEjK7zLh6Iz0ucEuCwQaew==
X-Received: by 2002:a5d:6a10:: with SMTP id m16mr20222217wru.411.1580117759258; 
 Mon, 27 Jan 2020 01:35:59 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:784d:f09c:63f4:b9cb?
 ([2001:b07:6468:f312:784d:f09c:63f4:b9cb])
 by smtp.gmail.com with ESMTPSA id z3sm19728927wrs.94.2020.01.27.01.35.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Jan 2020 01:35:58 -0800 (PST)
Subject: Re: [PATCH v2] hw/i386: disable smbus migration for xenfv
To: Paul Durrant <pdurrant@gmail.com>, Olaf Hering <olaf@aepfle.de>
References: <20200113174521.3336-1-olaf@aepfle.de>
 <20200116180321.24968-1-olaf@aepfle.de>
 <0335edd2-3d33-88f8-2ab4-4791f7289885@redhat.com>
 <20200117102244.22edd8a6.olaf@aepfle.de>
 <ea3a65c3-bd69-7815-6893-cb1cd8b9cfd6@redhat.com>
 <20200117140616.18cb8c45.olaf@aepfle.de>
 <CACCGGhCO_OqPq__t+V9RrFMYhXCJ5N4PPkq9CASJULV2rTkT-g@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d8d31bb7-01d1-8bb9-889e-c03c55818df3@redhat.com>
Date: Mon, 27 Jan 2020 10:35:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CACCGGhCO_OqPq__t+V9RrFMYhXCJ5N4PPkq9CASJULV2rTkT-g@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: ILgVop-BNqSYsA_0Cpuljw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 Anthony Perard <anthony.perard@citrix.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 20/01/20 12:18, Paul Durrant wrote:
>>
>> What would future domUs lose if 'xenfv' would be locked to 'pc-i440fx-3.0'?
>
> I guess eventually that pc type would be removed and then we'd have a
> compat issue.

That's years away, so ideally libxl would have migrated away from xenfv
before that.  For now, sticking to a fixed version as in Olaf's patch is
a good stopgap measure.

Paolo

> Ideally I think libxl should simply not use xenfv and
> then it can be deprecated and removed, and then such issues can be
> dealt with directly in xl/libxl.


