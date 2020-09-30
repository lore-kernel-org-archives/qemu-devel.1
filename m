Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87813C4727C
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 17:45:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF973206DC
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 17:45:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z/0gpErM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF973206DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNgAt-0002YR-JX
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 13:45:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54150)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kNgA7-0001nn-DJ
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 13:45:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:36608)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kNgA5-000494-Ba
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 13:45:07 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601487903;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tI35KbyWGEqysnqo1zKGM8UhdpYfIpQ5KwcWkAM0EjE=;
 b=Z/0gpErMjaMK7z8Rr+6FGHvgV8gsqv44Qp59PLzujNCiT9T6yRB2NxOMk0oUf0wo8/6a52
 I5FQGaaQH7F+0R8CycJC1aRBNJZSJx9oIZ7R7VIag08J+7xfAHaXy7mFH5mHM94H5ef+UC
 2YMI8qb0xLdE3clpSzAiMdSHWBTD4zw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-258-PkshUhfdMge5z6Yh-6iiZg-1; Wed, 30 Sep 2020 13:45:01 -0400
X-MC-Unique: PkshUhfdMge5z6Yh-6iiZg-1
Received: by mail-wm1-f71.google.com with SMTP id p20so119733wmg.0
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2020 10:45:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=tI35KbyWGEqysnqo1zKGM8UhdpYfIpQ5KwcWkAM0EjE=;
 b=ui6BD5M0TC1maLGMYkduJfLb/26LGJ92Ai1wfn7ANRmWDRpYJn/W2F54EATxdhX8fG
 ZO76bnvH3DDEoC4yHof279luFJcQaA9xyX3pqgl6B05VltA5bnafqgk+5IcZYaW15G3N
 z2aPI+mdN5IPgFJ5ke+QBheaoJBmVbFcE3FaNy7y0oWIACDTMWObYMiqQeoQeJGnOdq+
 Ob+X7ekVYdEDjdzBl7gtNlXsRuY9dK9qvb4+gSiEczfvl+GAocPFFxxe+RCHi98LSqv+
 0IbcGXi1QJtJCL9mMhYKBToKBWk3dMk22zCIy1iXuz36NnMVlfxG2mdgnX2Fk1M4dLiq
 mYag==
X-Gm-Message-State: AOAM5329fId6yajtesHa7FhG1HmJivrrY56SbvFpFdnkKlGwkJJsya2e
 vPhx9MRS/8jTQrrtUxFP9a0nZpr3gMDa0uW+UgtI8bpfmXKQE0QmKbuqsQsv+l1SlTgvLaqRdsC
 /ox3L78NZvCzBukU=
X-Received: by 2002:a7b:c95a:: with SMTP id i26mr4478935wml.25.1601487900080; 
 Wed, 30 Sep 2020 10:45:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzcOWh2T5Uo33NVySOmLy0EajQ01LRq75Z/18VCrE8LC5DTmgH45duQix7oFaldiRJfTViXZg==
X-Received: by 2002:a7b:c95a:: with SMTP id i26mr4478920wml.25.1601487899862; 
 Wed, 30 Sep 2020 10:44:59 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:75e3:aaa7:77d6:f4e4?
 ([2001:b07:6468:f312:75e3:aaa7:77d6:f4e4])
 by smtp.gmail.com with ESMTPSA id k15sm4370459wrv.90.2020.09.30.10.44.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Sep 2020 10:44:59 -0700 (PDT)
Subject: Re: [PATCH 06/10] device-core: use atomic_set on .realized property
To: Maxim Levitsky <mlevitsk@redhat.com>, qemu-devel@nongnu.org
References: <20200925172604.2142227-1-pbonzini@redhat.com>
 <20200925172604.2142227-7-pbonzini@redhat.com>
 <9182aa173b31989e07668194e18f4dcb31981388.camel@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e2cf2854-72bc-2f17-88b8-a2548f184583@redhat.com>
Date: Wed, 30 Sep 2020 19:44:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <9182aa173b31989e07668194e18f4dcb31981388.camel@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 00:31:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.469,
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
Cc: stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 30/09/20 16:31, Maxim Levitsky wrote:
>> +
>> +        qatomic_set(&dev->realized, value);
>> +        /*
>> +         * Ensure that concurrent users see this update prior to
>> +         * any other changes done by unrealize.
>> +         */
>> +        smp_wmb();
>
> I''l probably never fully understand where to use read/write/full barrier.
> If I understand corrctly, read barrier prevents reads done by this thread to be reordered,
> by the CPU and write barrier prevents writes done by this CPU to be re-ordered.

I must say that the above is not really satisfactory.  The right thing
to do would be to say which changes are done by unrealize; then you
should make sure that *after* reading something that unrealize could
undo you check if dev->realized is still true.

scsi_device_find is one such case, but I'm not convinced it is enough.

Paolo

> Both (depending on the macro) usually imply compiler barrier (to avoid compilier re-ordering
> stuff...)


