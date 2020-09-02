Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A47CC433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 13:47:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3102020767
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 13:47:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SRCwf1p6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3102020767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50778 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDT6a-0007AY-DV
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 09:47:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49858)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kDT60-0006ec-L8
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 09:46:40 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:42208
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kDT5z-0004sw-04
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 09:46:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599054397;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kuF8c6W6LBWByUnOJD0TFmlXHqszyl7tWJp2Lp0d8tQ=;
 b=SRCwf1p6/OkPzv4aHychMGvdujvTd9lWrI5j+y//2PriJKHYadxlB3JpI3EFfZojnS8KSo
 KlsPwWPkW+ZsPFT+N2527sIxZtlgY189p09A58H84W4gEjJl2CJK/ezmvDXPCCGByhxuA0
 nW30o9moAJwqpeu4n+altN+bYcKIYOo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-340-afeezIrBOxKjct7-nifSCg-1; Wed, 02 Sep 2020 09:46:36 -0400
X-MC-Unique: afeezIrBOxKjct7-nifSCg-1
Received: by mail-wm1-f72.google.com with SMTP id a5so1719051wmj.5
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2020 06:46:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=kuF8c6W6LBWByUnOJD0TFmlXHqszyl7tWJp2Lp0d8tQ=;
 b=rzDbi/AlfOiAFOvAvYNOTRwMVP69Zh6qN5LKx7qwmJzDEUx8WEd+/cVhDWhOJAwW0t
 sMtYG3Cj6HHABHWlLCvcHWoGS6tlxhJbFvsyvp3RUPXgkbMNYA/LUT0StrpL3DgSB733
 ZXWZ+ivEbuTzSWknYKQd/dq5n8vlkNHF8mTxBTmkHhSrSQiwfKHl5BXe2yzTRUEjafr8
 YPxrBJCasX03yURJxymStt6WDC1Av0VN0y1POTLC2XkRQsvpR/dNXSZxFPnD9pcAdFC2
 SrkfXXp148Af4usOsaFaMhyXvx9pXhUyXHEmPSQkNWej4JN+U5BwDPgYapLfrENUVsnx
 32Hg==
X-Gm-Message-State: AOAM530iOFdvSCIOtIMGbHzyv+fn6z+LBnzVaZGHkj7rynY5Ls2UC6Oe
 A/msOmAnsUnYIUQR858wwM6Ev8KoA/74e/hBXiSwkkeIqhrs5melpYIWcQ1rMz8WbivvoaDiPZ/
 8MVGAE5rjL7lWy4A=
X-Received: by 2002:a05:600c:ce:: with SMTP id
 u14mr762615wmm.137.1599054394633; 
 Wed, 02 Sep 2020 06:46:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxge6HT+ld5DonMmAnt9bTEfVJtOpy9OUqV+LwEwArSmb4991ooJYp+TDz4Ucvf8KRS2Av2Tg==
X-Received: by 2002:a05:600c:ce:: with SMTP id
 u14mr762598wmm.137.1599054394367; 
 Wed, 02 Sep 2020 06:46:34 -0700 (PDT)
Received: from [192.168.178.58] ([151.21.173.193])
 by smtp.gmail.com with ESMTPSA id v204sm6841194wmg.20.2020.09.02.06.46.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Sep 2020 06:46:33 -0700 (PDT)
Subject: Re: [PATCH 00/39] Next round of Meson fixes and cleanups
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>
References: <20200902125917.26021-1-pbonzini@redhat.com>
 <CAJ+F1C+x0EQj3KJoEV+4ksb8r473Z_Vk7wN=gx0ua8JHXjh1EQ@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d79222e0-8610-ad02-2e5e-0dbdb526e909@redhat.com>
Date: Wed, 2 Sep 2020 15:46:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAJ+F1C+x0EQj3KJoEV+4ksb8r473Z_Vk7wN=gx0ua8JHXjh1EQ@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 03:24:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.324, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
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
Cc: QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 02/09/20 15:14, Marc-André Lureau wrote:
> 
>     Marc-André Lureau (14):
>       meson: build qapi tests library
>       meson: declare tasn1 dependency
>       meson: declare keyutils dependency
>       meson: convert qht-bench
>       tests: qga has virtio-serial by default when host has it
> 
> 
> When you respin, please drop this patch. While the intention is good
> hopefully, it's not actually correct :)
> 
> thanks

Yeah actually I thought I had dropped it already. :)

Paolo


