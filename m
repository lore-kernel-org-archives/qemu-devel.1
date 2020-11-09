Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 222F4C388F7
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 16:23:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53A9620897
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 16:23:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J+MNQxT5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53A9620897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kc9wi-0003Av-0J
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 11:23:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46832)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kc9vK-0001r7-MH
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 11:21:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20727)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kc9vI-0007ct-T8
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 11:21:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604938900;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IKul1VeAMDkPH30uMpdvnKKgFIThhHSZLVwPTcHAXmM=;
 b=J+MNQxT5BFqonKmpoc17RiAWqzih5vaN3HVKqjd2Z+sK8xVn6MP9RxT7UxgWnijZtrwaeW
 Ym4RPpn5M3PgtyzleKE+VlB+Ky+PNKwXT/R0R8yJ0Qo2NnVM+n252pbLAA8tkdMsPCVFKn
 opAIUjdgkjjmH3TqnFh8MD/LPAEsYcQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-153-rRRrvRnYN9mr1aaY1z6NSA-1; Mon, 09 Nov 2020 11:21:38 -0500
X-MC-Unique: rRRrvRnYN9mr1aaY1z6NSA-1
Received: by mail-wm1-f72.google.com with SMTP id 3so2158905wms.9
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2020 08:21:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:cc:references:from:subject:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=IKul1VeAMDkPH30uMpdvnKKgFIThhHSZLVwPTcHAXmM=;
 b=Ef2/MLroc830L5juwqOuTv6FQTxfKlAH4RtNxv9e63TPmrp7msvK2zIsD2PFq5gfip
 FSY6ikrVllp3nSbIFfL1xg3T511JiCnnwq646Cn0e0HTOfcalC3mB3mJ5SyYh4ZR2Txo
 4vlpYSOe7eVZhCywxxJSKv+V8fT5arJaoFtnLUATvj/QuIN5RlW1uWzPWzpcsIpRVXIa
 oMNHyXkaFhKmFxFxM7+WWBQREdclZlkwdlJ94+8Uehm3YqCKPJV8xzxRvx9tuYPeyQnh
 y7WZDL+6t5D2T9pIVidfrRk/jEJ4v+T+gAIjMmZPS3OFkQjn2MvPaAYmdkEZCwbQvs6u
 tA0g==
X-Gm-Message-State: AOAM5338xK1xsB2Zb1cEyAxtt+d+r9FhulqsA0W5x50HfmrzCvvgyyTt
 cWpzEr3nSumpbMKV+bkN3z1kfpXKSLNwRQZi1pwkl2kwZaPKiDMH1xauLXcSUeSWiVe+DuOz66W
 KtDVbOixZCHbJrgg=
X-Received: by 2002:adf:f852:: with SMTP id d18mr138823wrq.232.1604938896963; 
 Mon, 09 Nov 2020 08:21:36 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyzoVA09t2R42o3qQcxojHCpBeI6UjnBghKKH7TV0YhUS51iLKfVWGHznqpsRiTDB22+X4GGA==
X-Received: by 2002:adf:f852:: with SMTP id d18mr138799wrq.232.1604938896691; 
 Mon, 09 Nov 2020 08:21:36 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a?
 ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
 by smtp.gmail.com with ESMTPSA id n17sm13723945wrw.69.2020.11.09.08.21.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Nov 2020 08:21:35 -0800 (PST)
To: Markus Armbruster <armbru@redhat.com>
References: <20201109133931.979563-1-pbonzini@redhat.com>
 <20201109133931.979563-4-pbonzini@redhat.com>
 <87eel25xud.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 3/6] qemu-option: restrict qemu_opts_set to merge-lists
 QemuOpts
Message-ID: <0defd899-184d-549e-a799-7000f7b9c92d@redhat.com>
Date: Mon, 9 Nov 2020 17:21:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <87eel25xud.fsf@dusky.pond.sub.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/09 00:04:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09/11/20 16:55, Markus Armbruster wrote:
>>           QemuOptsList *net = qemu_find_opts("net");
>> -        qemu_opts_set(net, NULL, "type", "nic", &error_abort);
>> +        qemu_opts_parse(net, "nic", true, &error_abort);
>>   #ifdef CONFIG_SLIRP
>> -        qemu_opts_set(net, NULL, "type", "user", &error_abort);
>> +        qemu_opts_parse(net, "user", true, &error_abort);
>>   #endif
>>       }
>>   
> Looks safe to me, but I don't quite get why you switch to
> qemu_opts_parse().  The commit message explains it is "so that
> qemu_opts_set is now only used on merge-lists QemuOptsList (for which it
> makes the most sense indeed)..."  Is there anything wrong with using ot
> on non-merge-lists QemuOptsList?

I would *expect* a function named qemu_opts_set to do two things:

1. setting an option in a merge-lists QemuOptsList, such as -kernel.

This is indeed what we mostly use qemu_opts_set for.


2. setting an option in a non-merge-lists QemuOptsList with non-NULL id, 
similar to -set.

QEMU does not use qemu_opts_set for the latter (see qemu_set_option) 
because it wants to use qemu_opts_find rather than qemu_opts_create.  In 
fact it wouldn't *work* to use qemu_opts_set for the latter because 
qemu_opts_set uses fail_if_exists==1. So:

    -> For non-merge-lists QemuOptsList and non-NULL id, it is
       debatable that qemu_opts_set fails if the (QemuOptsList, id)
       pair already exists


On the other hand, I would not *expect* qemu_opts_set to create a 
non-merge-lists QemuOpts with a single option; which it does, though. 
This leads us directly to:

    -> For non-merge-lists QemuOptsList and NULL id, qemu_opts_set
       hardly adds value over qemu_opts_parse.  It does skip some
       parsing and unescaping, but its two call sites don't really care.

So qemu_opts_set has warty behavior for non-merge-lists QemuOptsList if 
id is non-NULL, and it's mostly pointless if id is NULL.  My solution to 
keeping the API as simple as possible is to limit qemu_opts_set to 
merge-lists QemuOptsList.  For them, it's useful (we don't want 
comma-unescaping for -kernel) *and* has sane semantics.

>> +    g_assert(!QTAILQ_EMPTY(&list->head));
>> +
>> +    /* set it again */
>> +    qemu_opts_set(list, "str3", "value", &error_abort);
>>      g_assert(!QTAILQ_EMPTY(&list->head));
> 
> This one not.
> 
> What are you trying to accomplish?

Improve the testcase, though I should have mentioned it in the commit 
message.  Basically emulating "-kernel bc -kernel def".

Paolo


