Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE643C2D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 09:16:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D7102075E
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 09:16:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L+7Aensr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D7102075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKePU-0003BS-6s
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 05:16:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60288)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kKeEP-0002Ez-A7
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 05:05:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41264)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kKeEN-00032s-Sv
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 05:05:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600765499;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LX5N5V/lUVBPk/yUkNWyKB5FTQfis5ieD3QxOjSAbHc=;
 b=L+7AensrpjD7HShbGtzj/ae3szahjXXfB+qYd7381Dlfx1q3PboN4V9kmAV3wL5b0/pC1Y
 oQTSs6n+1Slym+gUcW9wBPIZ9iXe2X6KX4A6qC17ZJvCmwVOmqHWIWzQS9JXMgaDj3UU4T
 zC+0ZAC9w1b+lHFWwXuuQiaKbNl5f8o=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-441-XRtVDofuPyi_yO8mR4MmMg-1; Tue, 22 Sep 2020 05:04:55 -0400
X-MC-Unique: XRtVDofuPyi_yO8mR4MmMg-1
Received: by mail-wr1-f72.google.com with SMTP id j7so7158129wro.14
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2020 02:04:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=LX5N5V/lUVBPk/yUkNWyKB5FTQfis5ieD3QxOjSAbHc=;
 b=t76c0O9L5oz9s7UipvsmC5flQ5vUQyaTGeTmVZ+gAnOG0srq17zGVsb3Xdq6LWRCvO
 iV3cLDt2LUgYwhCzbJOsD7Y+Tto+HglSQh/lOGFvPxO4gVbNNFmlSQzl6eHUsz6mv9KI
 A1cqNc4cnkW38Xtqvmwdd33dfA6VkQQOnCHUdQc8wRUQExalE0l1iE3pSvfwXCsX4MP7
 aUYTntmB2vdGjp7dwGpe+WkCxhlVjgpcfbyF/tCT33zAMe3/mRga9mi11Yva2k0DxH1S
 kkyTaz+ra7PYUkTcRm7qmEiMFc4Bm/xHvz8T6DRg2cslNdBJwRFe2p7I6ZCD4D/RAD39
 mqRg==
X-Gm-Message-State: AOAM530cbNR4HloDoIQqAAf6J3HFbQWVCYvRIHF/6DMXapdrMlv+sRwM
 SWF/bur6SLf2weTnf5Ornsm+jXrSbOwAMLBAgFcSxcR6LCZ3Ef6sD136H4eBhrq6gjrXy9Wqiil
 gcsahbNHv1l7p7xw=
X-Received: by 2002:a5d:510d:: with SMTP id s13mr4200679wrt.177.1600765494016; 
 Tue, 22 Sep 2020 02:04:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxuH1Hh2yYadMhgpTkQIGunATkv8RBjIi4+SoeRrxEgxkP+5/meC6/n4NmIIaVMzXnFcci3oA==
X-Received: by 2002:a5d:510d:: with SMTP id s13mr4200651wrt.177.1600765493746; 
 Tue, 22 Sep 2020 02:04:53 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:ec2c:90a9:1236:ebc6?
 ([2001:b07:6468:f312:ec2c:90a9:1236:ebc6])
 by smtp.gmail.com with ESMTPSA id z13sm25261492wro.97.2020.09.22.02.04.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Sep 2020 02:04:53 -0700 (PDT)
Subject: Re: [PATCH 2/6] block/nvme: Map doorbells pages write-only
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Fam Zheng <fam@euphon.net>, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-devel@nongnu.org
References: <20200921162949.553863-1-philmd@redhat.com>
 <20200921162949.553863-3-philmd@redhat.com>
 <6ea4b96862a0dac22205592b6c8d9e21ab57189a.camel@euphon.net>
 <22dab788-06f1-3686-51f3-24ee7ce77fda@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <bd7e17f6-95cb-e697-731b-e61ac3a64d30@redhat.com>
Date: Tue, 22 Sep 2020 11:04:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <22dab788-06f1-3686-51f3-24ee7ce77fda@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 00:31:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 22/09/20 10:41, Philippe Mathieu-Daudé wrote:
>> Besides looking more correct in access mode, is there any side effect
>> of WO mapping?
> TBH I don't have enough knowledge to answer this question.
> I tested successfully on X86. I'm writing more tests.

No problem with doing this, but PROT_WRITE does not work at all on x86.
:)  PROT_EXEC works if you have a machine with PKRU, but PROT_WRITE
silently becomes PROT_READ|PROT_WRITE because the processor does not
support it.

Paolo


