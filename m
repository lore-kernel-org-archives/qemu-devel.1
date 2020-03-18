Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20E37C10DCE
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 13:22:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFC902076F
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 13:22:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="doofUpYn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFC902076F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50714 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEYer-00073y-VC
	for qemu-devel@archiver.kernel.org; Wed, 18 Mar 2020 09:22:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55577)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jEYe5-0006fT-7T
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 09:22:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jEYe3-0006Xj-KN
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 09:22:04 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:28916)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jEYe3-0006X3-6h
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 09:22:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584537722;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yZoyX8fUNElkASwOa27tcspKLiejw3mqiHYdAuqcbxo=;
 b=doofUpYnXm7qTY1iCuse6b11rez7eTD2wA5cXmO63yvvsJZF/2Co0WUCYdLxl34mBquMwI
 kXnznUxXvmOjYvqtmKoUpAoggNn8hrlxlORgTMCiK4GK8Smg6e5SngM/Yrwp53t5OCCxfr
 DuFzskV5/PQdjRi8PFmyL32P/tR/5As=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-42-iga7v3d2PrWWgYHShFCSNQ-1; Wed, 18 Mar 2020 09:22:00 -0400
X-MC-Unique: iga7v3d2PrWWgYHShFCSNQ-1
Received: by mail-wr1-f72.google.com with SMTP id b12so12444822wro.4
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2020 06:22:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=yZoyX8fUNElkASwOa27tcspKLiejw3mqiHYdAuqcbxo=;
 b=aCmM7LIaeZtLJnKTpPkBaJEK+344PfihHA5HxqC/LPgmsjKzcEv7RE5firBmHSTOB5
 UGJb9jSHqT+Nzcd7/U4YHSzHoHQuzSQPcwgDlHOPxtuAFgXgvyNrYcs3jnvB/r+V/iYj
 VbygodNcm3AUJNMiWgi+v82Luga/e57nYW5WsU8JP/a9v06B9FHMwYoCtOYkKNMNU+HJ
 sjyQfuxbTE8Wx73IczuqI57OE+8s/NciTdOs8RK3rL1hWnaxhB02Rz6BcmGz8APl8h8o
 3+mk7LJwlOder++ScwBvEI5JLgJmazuBi2havpxJi+n95GJB4tT18yh8jejxQtMmJ8Y6
 7Lmg==
X-Gm-Message-State: ANhLgQ1hpRxxu86fPcjJVQCxkH2s1Nz9gic6ShQm6B8X6yZNhGZ0DdT5
 iyqPhqiR14Vr/V5kpJmcNN+hvRFEKXDwf34nKHzZQllkaLoOMgRgmZc7s6WBaQe1opbaFTsfMtG
 A0UP95ThJXVnDgzk=
X-Received: by 2002:a5d:4b8a:: with SMTP id b10mr5523853wrt.8.1584537719502;
 Wed, 18 Mar 2020 06:21:59 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vty6wHxarUi5540o59XR8KUG6eDR11DyyaZZ/jxZzWIwdvVTQxH0jcQK0m7iC2rjuLqyJeu+Q==
X-Received: by 2002:a5d:4b8a:: with SMTP id b10mr5523823wrt.8.1584537719211;
 Wed, 18 Mar 2020 06:21:59 -0700 (PDT)
Received: from [192.168.178.58] ([151.21.15.43])
 by smtp.gmail.com with ESMTPSA id b202sm4184614wmd.15.2020.03.18.06.21.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Mar 2020 06:21:58 -0700 (PDT)
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
 <3f512e33-5875-eee4-bbe8-61e7b313743d@redhat.com>
 <87mu8g3kgj.fsf@dusky.pond.sub.org>
 <bd83fe53-6541-b04d-04d9-76ddd29e2b99@redhat.com>
 <875zf1ak9e.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d94927af-eb46-f704-6658-e3f321c4d8ed@redhat.com>
Date: Wed, 18 Mar 2020 14:21:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <875zf1ak9e.fsf@dusky.pond.sub.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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

On 18/03/20 14:02, Markus Armbruster wrote:
> Object instantiation must be completely reverted by finalization.
> 
> device-introspect-test guards against a particularly egregious violation
> of this rule, namely output of "info qtree" after initialization +
> finalization differing from output before.  Surprisingly common issue.
> It's what made Peter invite me to this thread.
> 
> Device realization must be completely reverted by unrealization.

So far so good.

> We don't always implement unrealize.  Fine when the device cannot be
> unrealized.  But the code doesn't seem to guard against omitting
> unrealize when the device actually can be unrealized.
> 
> Properties for use with device_add must exist after object
> instantiation.
> 
> But is that true?  Setting a property can run arbitrary code.  What if
> setting property P to value V runs code that adds property Q?  Then
> device_add P=V,Q=W works provided P gets set before Q, which is
> anybody's guess.
> 
> So "must exist" is actually "should exist", and we' already moved from
> the self-evident to the unclear.

Right, and there is already one case where the properties don't exist,
namely the "fake array" properties.

> Even less clear: what side effects may be visible between object
> initialization and realization / finalization?
> 
> A safe but constricting answer would be "only host resource
> reservation".
> 
> What's your answer?

Here are some random thoughts about it:

- object initialization should cause no side effects outside the subtree
of the object

- setting properties can cause side effects outside the subtree of the
object (e.g. marking an object as "in use"), but they must be undone by
finalization.

- realization can also cause side effects outside the subtree of the
object, but if unrealization is possible, they must be undone by
unrealization. if an object is realized and unrealization is not
possible, finalization will never run (and in that case, side effects of
realization need not be undone at all).

Paolo


