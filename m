Return-Path: <SRS0=XKWp=7H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 203CFC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 12:33:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE3C2207C3
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 12:33:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B+a8KFRZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE3C2207C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43536 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdCI3-0007Ja-0J
	for qemu-devel@archiver.kernel.org; Mon, 25 May 2020 08:33:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37076)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jdCHC-0006SO-9W
 for qemu-devel@nongnu.org; Mon, 25 May 2020 08:32:18 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:59396
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jdCHB-0004Kt-Fq
 for qemu-devel@nongnu.org; Mon, 25 May 2020 08:32:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590409936;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AlNW6ZFGEnuCf+hvYjyPazmjBRoFnYUpMICEDFbLyUk=;
 b=B+a8KFRZa7i8y2YcHTXl7MwK+NDi5dNl15ZIi3EXJE47tYjyoVLkAIIkZSjJ4iuPqPEv6f
 tsOW/FYJ5ledQnMt175vTNYsockfuL0S9DdBAdH7+IK0nbPYwR960r6gAB/4w0FBRFpqOa
 O15LfDB3wXstf8vBRo6kln/aPI9Gy04=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-104-cc10pi3_M1Clq38ZZfmV3w-1; Mon, 25 May 2020 08:32:15 -0400
X-MC-Unique: cc10pi3_M1Clq38ZZfmV3w-1
Received: by mail-ej1-f70.google.com with SMTP id gl5so6371521ejb.5
 for <qemu-devel@nongnu.org>; Mon, 25 May 2020 05:32:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=AlNW6ZFGEnuCf+hvYjyPazmjBRoFnYUpMICEDFbLyUk=;
 b=ZlSvLeGWP/2An8EDTZQ1/xolYuJhv6z+HZNeRWdkStwO81Bk8TuJomb/QBTzI8hNIB
 DgCrGxXc3L5Tdb59ri8ox3MTbt3P05fTMOQRhaC1Xianb/chTECUwMvrB7kJ0MUP6JZZ
 HfmnNAiFbbS2fLU6/WT+MOhp37jDmnrmvJJJCICnOXNGK7Mvw+SyEEVVho/F+OAD1De6
 bkgHwkTfbXBGQI6HD09WReA/IUkLDAkA1Yu3RljqlD7Boz54jSlYNfAtHQ8ALdMY/Odi
 a4llJ4KWc4UVTG8qG2ZU9yNQFcFMl2uEL1lSzYWevK4bFRZ89+V9AousxjsKSX5cCu46
 MToA==
X-Gm-Message-State: AOAM530koSz2pTdVSQu+17dOulRYDsM4QKlGABnynGWVAcRpH+R5VG0M
 fCGC+hCIadvVUfApWJ5ybLdMIrsmsvcro7rD1TnDDV8hrV0fpV19zeSBxLgkCjudjeC+9O0z37i
 GKS939xuThcivfGk=
X-Received: by 2002:a05:6402:1bc1:: with SMTP id
 ch1mr15373737edb.90.1590409933779; 
 Mon, 25 May 2020 05:32:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxdCKIWqtcoMU+iq1pAShQfeAcZ9riAVZ5AaYrjYF5lo1u2kNBwvgf9/V7NAGdXX0E83DUeeQ==
X-Received: by 2002:a05:6402:1bc1:: with SMTP id
 ch1mr15373720edb.90.1590409933555; 
 Mon, 25 May 2020 05:32:13 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:3c1c:ffba:c624:29b8?
 ([2001:b07:6468:f312:3c1c:ffba:c624:29b8])
 by smtp.gmail.com with ESMTPSA id t23sm15158953edr.71.2020.05.25.05.32.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 May 2020 05:32:12 -0700 (PDT)
Subject: Re: [PATCH 06/24] armv7m: Bury unwanted "ARM,bitband-memory" devices
To: Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20200518050408.4579-1-armbru@redhat.com>
 <20200518050408.4579-7-armbru@redhat.com>
 <CAFEAcA9UampZxo-4Z=6+LKkC9HLrdGYT5AcLyiGVYvgU5VE+cA@mail.gmail.com>
 <878shgh8be.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3ebe626e-0373-0eee-6a54-27a88d656122@redhat.com>
Date: Mon, 25 May 2020 14:32:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <878shgh8be.fsf@dusky.pond.sub.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/25 02:40:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-arm <qemu-arm@nongnu.org>, "Daniel P. Berrange" <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 25/05/20 07:50, Markus Armbruster wrote:
> Peter Maydell <peter.maydell@linaro.org> writes:
> 
>> On Mon, 18 May 2020 at 06:04, Markus Armbruster <armbru@redhat.com> wrote:
>>> These devices are optional, and enabled by property "enable-bitband".
>>> armv7m_instance_init() creates them unconditionally, because the
>>> property has not been set then.  armv7m_realize() realizes them only
>>> when the property is true.  Works, although it leaves unrealized
>>> devices hanging around in the QOM composition tree.  Affects machines
>>> microbit, mps2-an505, mps2-an521, musca-a, and musca-b1.
>>>
>>> Bury the unwanted devices by making armv7m_realize() unparent them.
>>> Visible in "info qom-tree"; here's the change for microbit:
>>
>> What does "bury" mean here? To me it implies "they still
>> exist but we've stuck them in a hole somewhere and covered
>> them up", but the qom-tree delta suggests we've actually
>> really deleted them?
> 
> We really delete them now.
> 
> "They've been lying dead in the streets; give them a decent burial".
> 
> Would you like me to s/Bury/Delete/?

"Bury unwanted" -> "Dispose of unused"?


Paolo


