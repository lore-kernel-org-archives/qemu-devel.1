Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2680C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 14:30:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B26E6207FC
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 14:30:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WqmGJmcc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B26E6207FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55422 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k049B-0001as-1C
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 10:30:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51122)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k048a-0001BF-Dq
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 10:29:56 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55810
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k048Y-0000sT-AG
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 10:29:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595860193;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qbG3HpIwsCLLeMsIpH8ZzcPnkGY8LTfEp7N2CbNlcic=;
 b=WqmGJmccuv3WRJllI5GTn0mSs2VgQllbpEHPkRkePJcOdDnCUbf74nMtRp9SQxUhpCVCVe
 xDEHEYGI7wlz0xX5igX9Ee53D4dJV9ePfwz23f+x9COiCeh2OsNiMh3zmIrveQ/y6eCdl5
 p63iVyKdXAqESy/JD1ccZlDhgc6dGVI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-314-r8rUI-vfPdu3QZDEHaBw7w-1; Mon, 27 Jul 2020 10:29:51 -0400
X-MC-Unique: r8rUI-vfPdu3QZDEHaBw7w-1
Received: by mail-wm1-f71.google.com with SMTP id v8so6150516wma.6
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2020 07:29:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=qbG3HpIwsCLLeMsIpH8ZzcPnkGY8LTfEp7N2CbNlcic=;
 b=ruu/1PyW8aUQHAVXZtJRifgdT/gFIIVlHki8VPRyoICLn9u4oN7cap9UF9j7wLR3cw
 XDsreiWquMD7CN0/yeO0SuGAbGK2o1NunksFNkef+b9cWDZElNGb6folWXbgVWeF5ots
 NlmIG+tSy4o7BCD/6Iyy66CGiVyr51SrIzaSNnCZXrsC0vplAPxc71FEpYsGLntejQJb
 RjrFO/1Lan8XszlbMWqlabMVXPSQ9+/rjFeambX+wFPZzeCGxb9qMwtur5CIZQTYkYeG
 qFPdXIhZlnq8rvuE5jMhwshrg1JGgNfbie8EB0rCo6N4CIxryIeW/qjpKXIJQgZz9EUp
 VJBQ==
X-Gm-Message-State: AOAM531bf9qeUUEXOE9TTXa4GAT8oAdNtGu9P2DffvDzd0msy8P1DIgz
 svirLwlp4RMrPIlq5FjzDH3dtPaz4pVv6el9JHemH4kT+/7nQXP7TX6a6oYsL6IoG+tMka7SmXU
 LhGaBl0IWvygY16M=
X-Received: by 2002:adf:f44b:: with SMTP id f11mr2981827wrp.114.1595860190360; 
 Mon, 27 Jul 2020 07:29:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy+HQEG6szahCt71/x/QD08QHCVOsFhKv0LbW1qFhZxIt0mk6rpWIbTFYZe5NsYTSLq+O23bw==
X-Received: by 2002:adf:f44b:: with SMTP id f11mr2981805wrp.114.1595860190072; 
 Mon, 27 Jul 2020 07:29:50 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:4502:3ee3:2bae:c612?
 ([2001:b07:6468:f312:4502:3ee3:2bae:c612])
 by smtp.gmail.com with ESMTPSA id d14sm12496663wre.44.2020.07.27.07.29.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Jul 2020 07:29:49 -0700 (PDT)
Subject: Re: sysbus_create_simple Vs qdev_create
To: Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
References: <CA+aXn+EkkyiXmKpNhbggy0pjKVpiHxa+TUqEnZLB4v_D=T+7tA@mail.gmail.com>
 <CA+aXn+HHXAmT6Ljj2tpovGAYSurHKSdtUL3y-89t31B0e7jpsA@mail.gmail.com>
 <adb25c78-2edc-115a-5264-ca9f97864ec7@redhat.com>
 <87365t18mp.fsf@dusky.pond.sub.org>
 <CA+aXn+Guvt34PDD=N3FsD5w1C-aDXZ7gS8H_AZN-JEM8j8wBiQ@mail.gmail.com>
 <87lfjkvo81.fsf@dusky.pond.sub.org> <20200716222130.GO1274972@habkost.net>
 <87tuy6k9pa.fsf@dusky.pond.sub.org> <20200717162312.GR1274972@habkost.net>
 <87r1t6hc0f.fsf@dusky.pond.sub.org> <20200720155955.GV1274972@habkost.net>
 <87v9ihbe6u.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <50e31ece-215c-a632-e5a2-86ae7ab3abab@redhat.com>
Date: Mon, 27 Jul 2020 16:29:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <87v9ihbe6u.fsf@dusky.pond.sub.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 01:44:14
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, Pratik Parvati <pratikp@vayavyalabs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 21/07/20 08:00, Markus Armbruster wrote:
>> They are already mirrored as links, and guess what's the link
>> name: "child[...]".
> You're right, except for the link name: it's parent_bus.

There's links in both directions.

> So the qtree is actually embedded in the QOM graph: it's the device and
> bus nodes connected by the child edges from device to provided bus and
> parent_bus link egdes from device to bus it's plugged into, except the
> latter are backward rather than forward.
> 
> Strange: even bus-less devices have this parent_bus link, and its value
> is "" (the underlying pointer is null, and null gets mapped to "", for
> better or worse).
> 
> Should the property be limited to devices that actually have a parent
> bus?

Yes, it could be done.

>>> I don't know why the rebase of qdev onto QOM was done that way.  Perhaps
>>> Paolo remembers.
>> I'm guessing this is because QOM parent/child relationships
>> represent ownership, while there's no ownership relationship
>> between buses and devices.
>
> Plausible.  I guess the separate qtree was kept even though it's
> redundant with the QOM graph because switching its users to the QOM
> graph would be work.

No, it was kept because:

1) the QOM graph wasn't embedding the qdev tree at the time.  That was
added later.

2) the composition tree generally mirrors things that are born and die
at the same time, and creating children is generally reserved to the
object itself.  Children are usually embedded directly in a struct, for
example.  Instead, peripherals are not created by the bus, they are
created by the device_add monitor command and the like.

3) accessing the QOM graph is slow (it requires hash table lookups,
string comparisons and all that), so the pointers that cache the
parent-child links are needed for use in hot paths.


