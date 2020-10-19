Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0034C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 08:24:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F36A32224D
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 08:24:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gSDeBDeQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F36A32224D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41038 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUQTP-0004CH-1d
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 04:24:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58738)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kUQHC-0001IA-BR
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 04:12:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30944)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kUQHA-0006WI-FV
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 04:12:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603095135;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t+pPN6/DrZ9l0OwUW89Jap14Z4wxSoZ5MhUWgMQIoS4=;
 b=gSDeBDeQsNXGRWAs+kXWvHQoWszaatX6mZdo1KDAv/peBwVfoGs93ocTv61hu6JRLWahM3
 FcfYGHiCEWgl1zyULIpJOqi9ecVBx+tcr+S9c9Cte2Rp2nm7Azpe27fKeBcSZbxnICEaeB
 I2X6TaHaYRO37F9Ph98XG5An8SprcMA=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-267-DTyUVPsBODaBLR5IPqoktA-1; Mon, 19 Oct 2020 04:12:13 -0400
X-MC-Unique: DTyUVPsBODaBLR5IPqoktA-1
Received: by mail-ej1-f69.google.com with SMTP id j7so4338166ejy.7
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2020 01:12:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=t+pPN6/DrZ9l0OwUW89Jap14Z4wxSoZ5MhUWgMQIoS4=;
 b=HSqROMWZFXAHZcctMk0pzyD0W5HezQV6AiJj9J08PbFGPOti/d5jtrAW9yQi89JD9D
 oqLvmG6Ga+wjb1SQ3/he/J/P0oVdNjYR8Xn3qaqCdtj6/Egp3TPDPHET+GmHqk9/FzI/
 VajGUz4RWTR9akz87UwiEmMGMOBxXoOzyO3PWlDwU6v2HIuA2o4RqNYwJ/qPqg0QnlXb
 Po+lwnauVUybW9Ohi0SZ9r27lem7/pUEW0K96E8noP0i8uHV81929ySTJN9kXbRkFIHz
 /AEMeaNbP16BCwcxZeO1/sZwbNMCwPDd5f/NRNGspol2dW1IVTUAsCbB5P54trH/9nIZ
 R4CQ==
X-Gm-Message-State: AOAM531WEwte0k3gXDofCG6Av/l0Q/5DnXg9dnC93r4tylN9QHepd6HD
 YF5huGj7wA6SpuqQJdoSVeOa9G5zLelLaIZmoj0OfkYPnfmcwAxb/gX36xfYKbJbs3jsvRo2TMo
 wAiOUxxS91NovMdI=
X-Received: by 2002:aa7:c447:: with SMTP id n7mr17017398edr.134.1603095132321; 
 Mon, 19 Oct 2020 01:12:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyVNXdOnH9jfPI0RGrZin/ehhCNfPWC82s/IWe5+/dbq8AIo4WkROsoLIQwHbFoAQfc8anVXg==
X-Received: by 2002:aa7:c447:: with SMTP id n7mr17017377edr.134.1603095132049; 
 Mon, 19 Oct 2020 01:12:12 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a?
 ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
 by smtp.gmail.com with ESMTPSA id n15sm9849436edv.34.2020.10.19.01.12.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Oct 2020 01:12:11 -0700 (PDT)
Subject: Re: [PULL v2 00/22] Build system + misc changes for 2020-10-16
To: Peter Maydell <peter.maydell@linaro.org>
References: <20201016155331.1613089-1-pbonzini@redhat.com>
 <CAFEAcA_ZW2mq3ygzCjuphW2kkdOy4fcTzDObcyQTw0BJJgspZw@mail.gmail.com>
 <ecd2b5bf-0c3c-fa58-ce4d-3d4d55274424@redhat.com>
 <CAFEAcA_HDoheozjRjcAKy3eEJ94cBgU29FDftMe2yn=SdMKHMA@mail.gmail.com>
 <03d83be5-db1a-3856-5243-66b0f7bdc724@redhat.com>
 <04d2d02d-e5c0-ac69-1de5-f3d7bac32883@redhat.com>
 <CAFEAcA-HiKQ5Kj7-kJhJjzCjd80-OPhiUFUzJVJcCNo7z2w4tw@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1efe7775-d004-be35-706d-1b72a662bc52@redhat.com>
Date: Mon, 19 Oct 2020 10:12:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-HiKQ5Kj7-kJhJjzCjd80-OPhiUFUzJVJcCNo7z2w4tw@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/19 01:44:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
Cc: Yonggang Luo <luoyonggang@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 17/10/20 21:48, Peter Maydell wrote:
>> 1) are you going to pull v3 and I can fix up everything later?  Or would
>> you prefer me to send v4 once the new curses test is reviewed?
> 
> If the only issue with v3 is that stray warning message I'm
> OK with applying it and improving the test later.

Yes.

>> 2) would you prefer the "library was found but headers weren't" to warn,
>> issue an informative message, or be completely silent?
> 
> I think the build system should just say whether it found a
> working curses setup or not, and do our usual "this is fatal
> if --enable-whatever, otherwise just disable feature". If we
> happen to have convenient information to put in whatever
> the new build system's equivalent of config.log is [ie the
> saved-for-debug-purposes log], we might as well put it in,
> but we don't need to put that in the stdout. (We shouldn't
> say "ncurses found: YES" unless we actually found a working
> version, ideally.)

Ok, I think we can at least use cc.find_library(has_headers: '...') to
avoid warning for the most basic failure mode, and then use cc.links()
to further refine the check.  If the curses header is present but the
test program fails to link, then we are in the same situation as the
multipath check and warning makes sense.

Paolo


