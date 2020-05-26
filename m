Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D15DC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 11:24:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CEE42053B
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 11:24:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jdf2uFCW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CEE42053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38120 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdXhA-0005ku-76
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 07:24:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42368)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jdXgU-0005H7-I3
 for qemu-devel@nongnu.org; Tue, 26 May 2020 07:23:50 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:59518
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jdXgT-000840-Pb
 for qemu-devel@nongnu.org; Tue, 26 May 2020 07:23:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590492227;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Il4L9kCC7e4uQcwR1x0yQNpWEwaXov9SO7WgCp26gA8=;
 b=Jdf2uFCWYt25WxZ4UzSyc4mrPvfUimSg1a9Se/a5Zewi2pUgVJO4BHQi7lOwwWiovsDcP1
 qMq5/8T9OWYEyAogfRZXhkwjGvfN4RyNJ6FJxqNOf/agz8NMVBtIHhg50wwrCrttWfYNwz
 Q/HHBwzAYJAEl0sqetRJ39xWcughLzQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-120-vBMpKHT7PDC34aBuEyoKog-1; Tue, 26 May 2020 07:23:45 -0400
X-MC-Unique: vBMpKHT7PDC34aBuEyoKog-1
Received: by mail-wr1-f69.google.com with SMTP id f4so6994232wrp.21
 for <qemu-devel@nongnu.org>; Tue, 26 May 2020 04:23:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Il4L9kCC7e4uQcwR1x0yQNpWEwaXov9SO7WgCp26gA8=;
 b=hi0CP+ALZsLVbKYVp7CV2gEFsjej8esAQQ5vuQ+9k8gZzgam6VI0DUlL2m6WaejI11
 A8/2Tjr5ItXn/DrBWygG6xxFCeti/1CBQQ9fJFU1NCPLaQqplFTacNhAfAXXk+BbrXzu
 rvQcEcsxVmiQqkxttLJXLOjzWwSRyRIOGHPrtd+xBcL1YQBiKXTCP3XTO8NlbwT68E29
 OZ11UUp47w2LOhu4Ra0orfVA7CxBqa4FCWPMBsog506OilEfiS4QE5ZrM0fDLSpSAxbg
 a4lA+emEgPfT8eK8gUT3Y3DtP1WYcxNk599PuDs64z9TQU37u/4y2/Y54oZb3acPQzXb
 +f3g==
X-Gm-Message-State: AOAM532LRih4VIWn84fChqEldmGd1zj7Dhl1v8XiwxukQZ1KLIQcIJrb
 xEbXaUI6MxAAAOkYmyClTiB1p/Q77Q/7NmiZQLzv+arwHTOO6XCVKsg/q88YZpwAsa1F0Ctux5l
 dVJMpofW0IPc7lSA=
X-Received: by 2002:adf:9106:: with SMTP id j6mr1329006wrj.216.1590492224481; 
 Tue, 26 May 2020 04:23:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJylzb8O2JYWwCQhvAY7cHRL8DuFpzeI/mARjKLBgLbad61iHLbsZS02b+mWR2JrsVDVw29PPw==
X-Received: by 2002:adf:9106:: with SMTP id j6mr1328978wrj.216.1590492224209; 
 Tue, 26 May 2020 04:23:44 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:3c1c:ffba:c624:29b8?
 ([2001:b07:6468:f312:3c1c:ffba:c624:29b8])
 by smtp.gmail.com with ESMTPSA id m7sm21349334wmc.40.2020.05.26.04.23.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 May 2020 04:23:43 -0700 (PDT)
Subject: Re: [PATCH 50/55] s390x/event-facility: Simplify creation of SCLP
 event devices
To: Cornelia Huck <cohuck@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <20200519145551.22836-1-armbru@redhat.com>
 <20200519145551.22836-51-armbru@redhat.com>
 <20200526114523.65082262.cohuck@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <38aea6e3-a076-f29f-0167-f6ba084f5bb8@redhat.com>
Date: Tue, 26 May 2020 13:23:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200526114523.65082262.cohuck@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/26 01:14:47
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
Cc: berrange@redhat.com, ehabkost@redhat.com,
 David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 26/05/20 11:45, Cornelia Huck wrote:
> On Tue, 19 May 2020 16:55:46 +0200
> Markus Armbruster <armbru@redhat.com> wrote:
> 
>> init_event_facility() creates the SCLP events bus with two SCLP event
>> devices (sclpquiesce and sclp-cpu-hotplug).  It leaves the devices
>> unrealized.  A comment explains they will be realized "via the bus".
>>
>> The bus's realize method sclp_events_bus_realize() indeed realizes all
>> unrealized devices on this bus.  It carries a TODO comment claiming
>> this "has to be done in common code".  No other bus realize method
>> realizes its devices.
>>
>> The common code in question is bus_set_realized(), which has a TODO
>> comment asking for recursive realization.  It's been asking for years.
>>
>> The only devices sclp_events_bus_realize() will ever realize are the
>> two init_event_facility() puts there.
>>
>> Simplify as follows:
>>
>> * Make the devices members of the event facility instance struct, just
>>   like the bus.  object_initialize_child() is simpler than
>>   object_property_add_child() and object_unref().
>>
>> * Realize them in the event facility realize method.
>>
>> This is in line with how such things are done elsewhere.
>>
>> Cc: Cornelia Huck <cohuck@redhat.com>
>> Cc: Halil Pasic <pasic@linux.ibm.com>
>> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
>> Cc: Richard Henderson <rth@twiddle.net>
>> Cc: David Hildenbrand <david@redhat.com>
>> Cc: qemu-s390x@nongnu.org
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  hw/s390x/event-facility.c | 59 ++++++++++++++++-----------------------
>>  1 file changed, 24 insertions(+), 35 deletions(-)
> 
> So, what should happen with this patch? Should it go with the rest of
> the series, or should it go through the s390 tree?

I think an Acked-by is the simplest way to handle it, since qdev_realize
doesn't exist upstream.

Paolo


