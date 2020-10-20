Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 190BAC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 08:36:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 807752222F
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 08:36:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZGoaF1GW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 807752222F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUn8b-0006ZW-Dl
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 04:36:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45622)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kUn6p-0004UQ-Pm
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 04:35:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:36780)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kUn6n-0000wj-Qr
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 04:35:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603182904;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AomRY/3ralnbX1/tXTDPY6qqpFkf7I/b+KfnWRahn0g=;
 b=ZGoaF1GWLoYMUp4RLX3bFtPdo9xAHh/qwEZ1gAC3ANk3ysP6Sxa6Jo6Qtkm3TXI2xSO75a
 6Xl5qHB0odTIWRHBVtjrJ3UaudnMVkTFzeEx+LJBRQ218C6xTOLyXju+YVO1VxPeb3HG7m
 ABOabHaLE74TfAvKZ4ADKT/iTUjLDzo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-462-dP_5Z8Z0MEepm8ekZ-VhzQ-1; Tue, 20 Oct 2020 04:35:01 -0400
X-MC-Unique: dP_5Z8Z0MEepm8ekZ-VhzQ-1
Received: by mail-wr1-f72.google.com with SMTP id u15so517921wrn.4
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2020 01:35:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:cc:references:from:subject:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=AomRY/3ralnbX1/tXTDPY6qqpFkf7I/b+KfnWRahn0g=;
 b=r14LylOqKZbwFiGXpQoC+9LS5qKBNKd6DtAbY+oNLYqJkZ8JCflJSxEU4oJ4u38k56
 BDm5iWZYUAJMXvimWGBbNlrL0KkghJLWPDkhKu0H3BqlHz0lYo4Px9uIiofCEHayBfLL
 l2Itu8tysFwL6NPNEBqHajB1LB2Pq4uapn3FesQGFj9fo0sMuTlHcKL4hTO+C+tI4frs
 RtvSGfYAiceZGHkEMb3lnMCp8+KTuSOEumuj6J/Axl4sw3h6UgV+kZ3CgK2CkbeayCSO
 xzlSazbfDFpVYIMG2vi+3VXeHjdDXwG4HLezg9ceDHyBBRFe9JYAsmJM+c2r0i0JM8Pd
 Z2bw==
X-Gm-Message-State: AOAM531aZeFMlg8UZ2yuzT9RmOlt+9LU5foE6tGr4WI6qSRG+5HTxa/t
 tDNXwuLI9danHgZimw3ZxzFUfkzi4i2wNeyE3BLhn0L9+BHHvVIQ2cn0gH54uNjP6xxaHFjdpMe
 KV6raSDLVViNQ/T8=
X-Received: by 2002:adf:ab50:: with SMTP id r16mr2053373wrc.235.1603182900631; 
 Tue, 20 Oct 2020 01:35:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyiZGLmu3LCO4ayrq1feoCOVSN9j+/bPDkFUQz7iVzcxlevW08QIUYDqvy1zxBU46VkosLhsw==
X-Received: by 2002:adf:ab50:: with SMTP id r16mr2053357wrc.235.1603182900451; 
 Tue, 20 Oct 2020 01:35:00 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a?
 ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
 by smtp.gmail.com with ESMTPSA id y7sm1556695wmg.40.2020.10.20.01.34.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Oct 2020 01:34:59 -0700 (PDT)
To: Thomas Huth <thuth@redhat.com>, Joelle van Dyne <j@getutm.app>,
 BALATON Zoltan <balaton@eik.bme.hu>
References: <20201019013928.72770-1-j@getutm.app>
 <20201019013928.72770-3-j@getutm.app>
 <9a68e856-cb97-bf44-eef6-52d7cbca9884@redhat.com>
 <ec63904c-f0d2-b37b-9f9f-8f2109f1335a@redhat.com>
 <1f92b68-6d6c-d125-c034-7cbe414b198e@eik.bme.hu>
 <CA+E+eSCjkYf-6GYbJUQ=gpmQHH2zAH3g1JN+-2kjy2rUnwk3fA@mail.gmail.com>
 <d27c852c-b982-9b58-fbff-1bfc3d075e94@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 2/9] configure: cross-compiling without cross_prefix
Message-ID: <0a7b6404-55db-ec3f-2b56-1d695f840475@redhat.com>
Date: Tue, 20 Oct 2020 10:34:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <d27c852c-b982-9b58-fbff-1bfc3d075e94@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 01:15:43
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 20/10/20 07:15, Thomas Huth wrote:
>>>>>> +  ;;
>>>>>> +  --enable-cross-compile) cross_compile="yes"
>>>>>> +  ;;
>>>>>> +  --disable-cross-compile) cross_compile="no"
>>>>>
>>>>> Can't you simply use --cros-prefix="" instead?
>>>>
>>>> I mean, still introduce the "cross_compile=yes" variable, just omit the new
>>>> options.
>>>
>>> That seems less intuitive for people trying to find this option. If --help
>>> lists --enable-cross-compile I can guess what that means but there's no
>>> way I could guess --cros-prefix="" unless I've been told or searched and
>>> stumbled upon it. So unless it's a big problem I like the explicit options
>>> better. Or is that a convention in other projects to use empty prefix to
>>> enable cross compile that I don't know about?
>
> I don't think that --cross-prefix is a "standard" option... Most other
> (GNU-tools related) projects use "--build" and "--host" instead... so I
> guess we're free to chose here. Let's see whether other people here have an
> opionion on this...

Yeah, the way GNU tools do it is that you specify --build and --host,
and --host triggers cross compilation.  I'm not sure how they'd handle
the situation where the cross prefix is empty.

For QEMU, I agree with Thomas that --cross-prefix="" is enough.

Paolo


