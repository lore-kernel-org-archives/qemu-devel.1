Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4B20C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 15:47:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F7A720776
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 15:47:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aQ0Z6TwD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F7A720776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnl8h-00087B-Of
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 11:47:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53456)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jnl7B-00075Y-2l
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 11:45:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23494
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jnl79-0002dF-D9
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 11:45:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592927133;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TvUs77JNNA/gIUcCq/h66Z/35lkQeUQLuE5RATcGAnw=;
 b=aQ0Z6TwDuFmcdU2pLSjjjzc3bQzK7xXG4eOC93KphTnGlArQHgtZytiZi//gvwzGI/Y0P7
 4zFY37K2tWXZkPJ0dnbNkeNeVAKZli5QVTDNG3tXCt/fQG31vXelIkS1oWu5ogT/lZhXqy
 IEFzCCo6a+T1GSfdA7C1zT6TKONYEe4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-325-zvxO9CrzOwyTToXiyNg6AQ-1; Tue, 23 Jun 2020 11:45:31 -0400
X-MC-Unique: zvxO9CrzOwyTToXiyNg6AQ-1
Received: by mail-wm1-f71.google.com with SMTP id r1so4856674wmh.7
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 08:45:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=TvUs77JNNA/gIUcCq/h66Z/35lkQeUQLuE5RATcGAnw=;
 b=qQFW5xNZjSQs2nZWcLpNeB+9Z8BmGk5YWljoQHQWtvjwMDirhQa3D7UrGaMLSBW0Ht
 4xav+VS7Ev0oZqHqz3Q9eHj9dxi8nQAbh2/oWvSQ+18zAIdwTh4OBKVamd6kx1lWkCuQ
 +HGWbXg/h0QNQIqUcDvaffdmPgQAA9kCFLPefa5HLlWeyjIjL+IZsu+rDgz8T7flO9zn
 sbcchcO5IkwSth/ZlunG1OkAbpnZ614NYb3qmLkVw6tlqobo4eTftRAe2JC54iFtuogZ
 FiqRokkGGoUirwqrHf2Gk2MdvhY5pHq6C1mSRP4lSp94TMbPZWFrge0PsQfxRJ31bfEO
 rbOw==
X-Gm-Message-State: AOAM532vlSWmPoLOiI/p9pgxQFwS0Qwmuqyk9d6dZRu/bEVO7b9Z6qq3
 1ZwiLsqLXC5HRhBXCApOZAo6cKdTeBdL2FCAhs5qbJlZNIQp5rt+23OuY349Zdn9Dr3FIS0TMd8
 zEgVxDn6Uy8DKBHQ=
X-Received: by 2002:adf:e3c5:: with SMTP id k5mr26160223wrm.121.1592927130546; 
 Tue, 23 Jun 2020 08:45:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxS1L6HD8EgRUUtgXFbhkX2aVI9ZavajuVuyhNAXiTWmPCVqMe3XctyDGm5lRXWjieXwgZXpw==
X-Received: by 2002:adf:e3c5:: with SMTP id k5mr26160206wrm.121.1592927130356; 
 Tue, 23 Jun 2020 08:45:30 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:24f5:23b:4085:b879?
 ([2001:b07:6468:f312:24f5:23b:4085:b879])
 by smtp.gmail.com with ESMTPSA id f12sm9941238wrw.53.2020.06.23.08.45.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jun 2020 08:45:29 -0700 (PDT)
Subject: Re: [PATCH v3 0/3] hyperv: vmbus: ACPI various corrections
To: Igor Mammedov <imammedo@redhat.com>, Jon Doron <arilou@gmail.com>
References: <20200618030027.759594-1-arilou@gmail.com>
 <20200623171108.624027e6@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a91b9cde-1836-8236-928c-44ec9afa463d@redhat.com>
Date: Tue, 23 Jun 2020 17:45:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200623171108.624027e6@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/23 02:55:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: rvkagan@yandex-team.ru, vkuznets@redhat.com, mail@maciej.szmigiero.name,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 23/06/20 17:11, Igor Mammedov wrote:
> On Thu, 18 Jun 2020 06:00:24 +0300
> Jon Doron <arilou@gmail.com> wrote:
> 
>> After doing further tests and looking at the latest HyperV ACPI DSDT.
>> Do minor fix to our VMBus ACPI entry.
>>
>> v3:
>> Removed accidental change for the dct submodule head
>>
>> v2:
>> Renamed irq0 to irq now that there is a single IRQ required
>>
>> Jon Doron (3):
>>   hyperv: vmbus: Remove the 2nd IRQ
>>   i386: acpi: vmbus: Add _ADR definition
>>   acpi: i386: Move VMBus DSDT entry to SB
>>
>>  hw/hyperv/vmbus.c                |  3 +--
>>  hw/i386/acpi-build.c             | 17 +++++++++--------
>>  include/hw/hyperv/vmbus-bridge.h |  3 +--
>>  3 files changed, 11 insertions(+), 12 deletions(-)
>>
> only 1/3 is ready, the rest is not yet ready
> 

Ok, saw this now.  Thanks.

Paolo


