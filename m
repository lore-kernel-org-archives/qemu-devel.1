Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CC78C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 12:01:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DDBB206C3
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 12:01:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d/meLyNf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DDBB206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38712 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtVFQ-0000qq-J6
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 08:01:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36754)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jtVDx-0008I7-VV
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 08:00:22 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48233
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jtVDw-0007GD-1I
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 08:00:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594296018;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O+dONCW3NR7CQ2TtfnxIkIwc7NM2tp+KFy6GMY6RXN0=;
 b=d/meLyNfqB+1gd9+tUt3pG1trjONbG6r5HNiDOOjZl/1yn3Y8YN6m/pOc5vNYVw0ajzUlB
 0q8A5z5+pP9wkAyU6FQlJoEx6XH8EyLMBXcZlg+LzU0yGBmZIDdTZI+nJNAcIdEJ6nuz92
 0Je7ApitSz1TZXYKdNlQoeJs9sBZWIA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-495-Fsgkd35uMaq7y31cZ8ycQA-1; Thu, 09 Jul 2020 08:00:17 -0400
X-MC-Unique: Fsgkd35uMaq7y31cZ8ycQA-1
Received: by mail-wm1-f70.google.com with SMTP id b13so1900981wme.9
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2020 05:00:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=O+dONCW3NR7CQ2TtfnxIkIwc7NM2tp+KFy6GMY6RXN0=;
 b=sXGO8sXKmAb0nB0X92//j9neotPJw8H9NMJTbfC4m5I5X6+F4SnxkYVbyjLYkw6t7l
 8fpvQDNM5/qvBQAhNaNVtOAvssZjJN3wEDHlhOky17GNEUq87y+GFED0jCzEeTP/8zRr
 XrKku7Sy90zghGBgzP+84RPecpfZFbj0GU+y4X3RKivJRamwVCt8efjzLdAkaCjOcmSK
 w6nRUljLR8FRimF4RYiCxATPgwx7el5A6yQ7Ehjuh7rqIWwc2kglZ77CAEfOB4c5jrxK
 5EMXx+V1TP0ERCX2iraFsE2P028HgpiC0WRLvn/JeNZGBvoV9Q7v4FazpiT16zx+HKwJ
 XM0g==
X-Gm-Message-State: AOAM531dEz7Gtl3t1oDB5nBFZQIS2Wvy8AEe0xNaFSLQq1buZnXsn4YB
 +rKQQ0RV3ehFzIZ6chlVdgW2c7QaDL+Z/cCVnQDFT6E6huYPNrQ4Goc4chyA4YbtmipjvrpTqfe
 4iZymrbQy40SBPfY=
X-Received: by 2002:a1c:48:: with SMTP id 69mr14440098wma.32.1594296015948;
 Thu, 09 Jul 2020 05:00:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyCiGCV0bEs/RQHxrX7YLvWL+DJmld202/ZnB0aXP4FV34QxfC73GZ3+2chN8dFK7fNMQ7lsw==
X-Received: by 2002:a1c:48:: with SMTP id 69mr14440077wma.32.1594296015679;
 Thu, 09 Jul 2020 05:00:15 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9541:9439:cb0f:89c?
 ([2001:b07:6468:f312:9541:9439:cb0f:89c])
 by smtp.gmail.com with ESMTPSA id u23sm5781255wru.94.2020.07.09.05.00.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jul 2020 05:00:14 -0700 (PDT)
Subject: Re: Questions about online resizing a lun passthrough disk with
 virtio-scsi
To: Lin Ma <lma@suse.de>
References: <af3e33e4a5bb15d9f0b30c8de4941a37@suse.de>
 <a1d96da7-444e-d3b0-abd5-63cdab92e869@redhat.com>
 <bb1050f276b9f0a6447f64f1e31b69c9@suse.de>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3c1d7530-91bf-4e6b-c53c-06e6c5b31cac@redhat.com>
Date: Thu, 9 Jul 2020 14:00:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <bb1050f276b9f0a6447f64f1e31b69c9@suse.de>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 17:25:10
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09/07/20 13:52, Lin Ma wrote:
>> It's not recommended however, because block_resize will report the
>> change to the guest directly with a CAPACITY HAS CHANGED unit attention
>> condition.
> 
> Got it, The 'block_resize' is the recommended or necessary step, Even for
> passthrough disk online resizing.

If your target is able to report the unit attention itself, it is okay
to skip it.  AFAIK drivers/target/ doesn't, though.

Paolo


