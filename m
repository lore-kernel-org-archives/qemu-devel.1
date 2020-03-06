Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54C1DC10DCE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 11:39:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F0E32072A
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 11:39:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SI7h45Yl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F0E32072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jABKM-0000qN-5v
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 06:39:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35662)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jABJY-00080X-TT
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 06:38:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jABJX-0006aP-Pr
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 06:38:48 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27827
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jABJX-0006Yv-Kl
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 06:38:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583494727;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Spzl07gt6AiHxSswf4FMxeagCVtGBrYL0CA43/3EHAA=;
 b=SI7h45YlI5aXOuXPVuos+GLlbQlME1gHzeW5ZnBmkYKTh/UCtEeEp5/tOpoXoo0cVt4zqb
 V1WhXsj3KsUg34AFLMbttDbsrcy0KZfwaYvQRI+5Q/NhqMY45ksj/B0BoRZ409VJ2RRfkS
 uw1ZbfKB/0fN078Un5qVVOBJUA5IfU8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-474-CslfBGySMYqe8kR1jsoYzQ-1; Fri, 06 Mar 2020 06:38:45 -0500
X-MC-Unique: CslfBGySMYqe8kR1jsoYzQ-1
Received: by mail-wm1-f72.google.com with SMTP id w3so530764wmg.4
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2020 03:38:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Spzl07gt6AiHxSswf4FMxeagCVtGBrYL0CA43/3EHAA=;
 b=qAbhXR8eUvIAL2iVwzD0uE4dFQDDO4RNExq2JALVqwik2Iex7IkuQ2A/s6wG1nEOua
 uhbHzYUvKLg9zLw/j9/2Ue+j2ZbAxa016S5gp8htVIKV9kYrd/+G/8jbvmTVn2mQeRs0
 SIKEqjM3BaIFKMvJVGgqdsZP67E4+ajTN12SwLVRKJLmPv/oTQxZ+jquepOA+s6xp2Uc
 hUs4CrRPl0VvAKgSK5B1eOwcAkNPySF0kj+jYQnxO7sDcKKi24oNuDC3NZ7YDsGio2eh
 Aj3oe+UqskGGszud8iJO7jXSF2JEDBQyFkavXiE4QZ4mSRjZfTjOwuX8H4cFiBG5kOAq
 HBoA==
X-Gm-Message-State: ANhLgQ2BTZGArZfLzSzWKxb3lU7hAxGbXwTWUcECYmf3I8rBDnNCRURc
 OgvlABhzuJ/2aYwLGoZjcxG3FitfcrqXJCqBGKA8UzUAJNbTQL6wRUbd5hQTEsKLZ4lq5Cu6x5i
 +8r2gFY+1NhavvFA=
X-Received: by 2002:a1c:e442:: with SMTP id b63mr570794wmh.174.1583494723764; 
 Fri, 06 Mar 2020 03:38:43 -0800 (PST)
X-Google-Smtp-Source: ADFU+vuLdMqaEBrFkhWpgZz11Wwa03MCR7/8PlHXB9UcY9iaRG8MEtnrqJPJIvECyJFWVOJbykuMyw==
X-Received: by 2002:a1c:e442:: with SMTP id b63mr570759wmh.174.1583494723368; 
 Fri, 06 Mar 2020 03:38:43 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:8cd7:8509:4683:f03a?
 ([2001:b07:6468:f312:8cd7:8509:4683:f03a])
 by smtp.gmail.com with ESMTPSA id 19sm14946335wma.3.2020.03.06.03.38.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Mar 2020 03:38:42 -0800 (PST)
Subject: Re: [PATCH RFC 4/4] kvm: Implement atomic memory region resizes via
 region_resize()
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20200303141939.352319-1-david@redhat.com>
 <20200303141939.352319-5-david@redhat.com>
 <102af47e-7ec0-7cf9-8ddd-0b67791b5126@redhat.com>
 <3b67a5ba-dc21-ad42-4363-95bb685240b9@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2a8d8b63-d54f-c1e7-9668-5d065e36aa1d@redhat.com>
Date: Fri, 6 Mar 2020 12:38:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <3b67a5ba-dc21-ad42-4363-95bb685240b9@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Peter Xu <peterx@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 06/03/20 11:20, David Hildenbrand wrote:
> Yeah, rwlocks are not optimal and I am still looking for better
> alternatives (suggestions welcome :) ). Using RCU might not work,
> because the rcu_read region might be too big (esp. while in KVM_RUN).
> 
> I had a prototype which used a bunch of atomics + qemu_cond_wait. But it
> was quite elaborate and buggy.
> 
> (I assume only going into KVM_RUN is really affected, and I do wonder if
> it will be noticeable at all. Doing an ioctl is always already an
> expensive operation.)
> 
> I can look into per-cpu locks instead of the rwlock.

Assuming we're only talking about CPU ioctls (seems like a good
approximation) maybe you could use start_exclusive/end_exclusive?  The
current_cpu->in_exclusive_context assignments can be made conditional on
"if (current_cpu)".

However that means you have to drop the BQL, see
process_queued_cpu_work.  It may be a problem.


Paolo


