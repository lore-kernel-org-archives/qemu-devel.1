Return-Path: <SRS0=WIOf=5A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 803F5C10DCE
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 18:03:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 411B120722
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 18:03:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZyVDtC9k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 411B120722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDXbZ-0000MV-6T
	for qemu-devel@archiver.kernel.org; Sun, 15 Mar 2020 14:03:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34435)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jDXWn-000781-E0
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 13:58:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jDXWl-0005U9-L9
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 13:58:20 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:48067
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jDXWl-0005Qs-EN
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 13:58:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584295098;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZgP/zwUWzIPeaA9AJ5zNsLmLGJ2s+i0g1/rJKWHsm7o=;
 b=ZyVDtC9kJfg91pVhqG8aHfruStcE9wiVgCxC7uTvh3e1plupVpUpObLuKw3UGrzwpvO/sj
 Y0c6TD/SmeIwDCVZGIDnbYzjaqu5b+iC/+TULYmmubHQZHPUe86PeeYJ8t7QkH+G+ppejx
 /jJTyrqG60OkZqY7chuhNipnRgWiI4A=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-401-AxDCMghKMEKABb-hIjsK_A-1; Sun, 15 Mar 2020 13:58:16 -0400
X-MC-Unique: AxDCMghKMEKABb-hIjsK_A-1
Received: by mail-wr1-f71.google.com with SMTP id z13so7658163wrv.7
 for <qemu-devel@nongnu.org>; Sun, 15 Mar 2020 10:58:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ZgP/zwUWzIPeaA9AJ5zNsLmLGJ2s+i0g1/rJKWHsm7o=;
 b=tJ57SMMuKrVeKmZrCS5icv/Jty1oUk2u6tHOJodrXjkm0aq4cIG6POA9B9gf6xOcoL
 1pckTIv9BVDYicXODkGp/ydIJ2MSlB3Etl8Xxr4tQp5OkIU26S9nWs7uCvlvLA8qHMuo
 7F5K11msFh3sw+xPuabGJ+c/idbsViiYODWaKIC3GlnsFFM141dcM2ljryOZ8is/Ng00
 dfSKAaDB1mAnLRaZksvOSaeVRcAKOxajotPlc0LCTe4c6eytZozlRTGdccObb2Zhuqhm
 rJiJyFTuHPvNDWNhTIkhAMdh7zKhuPfMt5Un15OAS5u9DxqD3hoZXVhunlktavJMwRm0
 7D6w==
X-Gm-Message-State: ANhLgQ1yHbrq8JXHDr4+eQUi++JX0D6QSRtfoWvMQV4FoDhiAsTllpp5
 1o/tGVtGnh5WysUCqfl1cdMj6Kn85+BiXCHEzEYs9Bxwtxw+zXZkMvqrCj8FGKOGMgSM7y0Gh87
 QWS4RKWf2al9V8no=
X-Received: by 2002:a7b:c75a:: with SMTP id w26mr5346420wmk.2.1584295095316;
 Sun, 15 Mar 2020 10:58:15 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vt7j4wJfLdxMPEte5MA8Qip6keOY08l2jqVoCSGOLodm4BPAgXvy0o13rdIpkIBpcOrH0LgcA==
X-Received: by 2002:a7b:c75a:: with SMTP id w26mr5346400wmk.2.1584295095065;
 Sun, 15 Mar 2020 10:58:15 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:40d4:87da:1ffc:e462?
 ([2001:b07:6468:f312:40d4:87da:1ffc:e462])
 by smtp.gmail.com with ESMTPSA id a184sm27551322wmf.29.2020.03.15.10.58.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 15 Mar 2020 10:58:14 -0700 (PDT)
Subject: Re: [PATCH v4 2/3] mac_via: fix incorrect creation of mos6522 device
 in mac_via
To: Markus Armbruster <armbru@redhat.com>
References: <20200305065422.12707-1-pannengyuan@huawei.com>
 <20200305065422.12707-3-pannengyuan@huawei.com>
 <CAFEAcA_twjUHpvf5ZpzA_bKyf8MZ4BuSY0MvNTgSEyVTYf9mXQ@mail.gmail.com>
 <0b2d3222-d122-e0db-db04-1c4e3028f8f8@huawei.com>
 <CAFEAcA9PQd=PwuF+j=3kOA_eCiRd_8TLEwPx8qB-jWvV_9CcMQ@mail.gmail.com>
 <0c3ae5aa-36c3-a809-4a42-159348f44780@huawei.com>
 <CAFEAcA8_RkECOT=YJ3ML0wxBrKiqVw=CssORU=jyryfcNueB0w@mail.gmail.com>
 <871rq08tn9.fsf@dusky.pond.sub.org>
 <eca27715-554d-2c2e-5e58-ffd01abb654c@ilande.co.uk>
 <e1ae65dd-f9cd-b0ee-0ea6-f3c2b010fdab@redhat.com>
 <87tv2p8y5j.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3f512e33-5875-eee4-bbe8-61e7b313743d@redhat.com>
Date: Sun, 15 Mar 2020 18:58:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <87tv2p8y5j.fsf@dusky.pond.sub.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 zhanghailiang <zhang.zhanghailiang@huawei.com>,
 Pan Nengyuan <pannengyuan@huawei.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <laurent@vivier.eu>, QEMU Developers <qemu-devel@nongnu.org>,
 Euler Robot <euler.robot@huawei.com>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 15/03/20 15:56, Markus Armbruster wrote:
>>
>> The question is why they are not, i.e. where does the above reasoning break.
> I don't know.  But let's for the sake of the argument assume this
> actually worked.  Asking for help in the monitor then *still* has side
> effects visible in the time span between .instance_init() and
> finalization.
> 
> Why is that harmless?

I don't really have an answer, but if that is a problem we could change
"info qtree" to skip non-realized devices.

Paolo


