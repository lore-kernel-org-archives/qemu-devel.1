Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 286C8C2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 12:45:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A28F2075B
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 12:45:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GyliSPy3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A28F2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kL49e-0001hu-8K
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 08:45:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50688)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kL47P-0007ua-SB
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 08:43:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29805)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kL47O-000726-6J
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 08:43:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600865009;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tuk6dAmFoIhJ7ZB+Jfr9nrTvwW81F8MtBWAMn/4WSe8=;
 b=GyliSPy3TJzbeZXKXtrUg3RUQXLOPNaqKSkKK8n6VP2Qgo9tDo0Sx9Bk5C8lNocjXAwDif
 MJ9Sfe6H2+Hw4H55aSBREF1ZC3+wB9UCvINWhHzbHeZNqSqqcImW0jGtcayPLE5z5gDALT
 fKlRgjNsx8Eq1bCZe/Ue0X1RXmoqRFs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-353-OWsSH6XyPCS0VVo9LSc-NA-1; Wed, 23 Sep 2020 08:43:27 -0400
X-MC-Unique: OWsSH6XyPCS0VVo9LSc-NA-1
Received: by mail-wm1-f72.google.com with SMTP id x6so2187734wmi.1
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2020 05:43:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=tuk6dAmFoIhJ7ZB+Jfr9nrTvwW81F8MtBWAMn/4WSe8=;
 b=JjcJY+ZFTKM0sF971lunAresfhcQlx6Kxz0twyXG7wIkmEh6dmv3kKMCJrixH9R++o
 ivHXjUjbFP16r9CPV1AUgShXaXJdLcfcIxSbdAJxPM1W9iT1c7yHrJq+qd3QHRy7igjh
 LhqDicEQbmJkg1bMTAJXymM1f8eNoQslEnHHAZVEvxsFf2qa4CgpAz+/yVeuysHzgStO
 xbc70D/I0MHO5n6P/LIocPBIw4CgV8gyJzoaH84cOcSCqpP1HPvAVOGSVBHeoB1S5HO6
 /Mqgncmf8JtUZCyuXLlzrfbj2DQzjhkJKz7tgILA9JXAta8cJALYX55OoBy95Pu10z3c
 B3zw==
X-Gm-Message-State: AOAM5309yD8VFmiTwWrJ6pcob0M6pIQsUgm1OogXcT2pYwyf6NfYxI5x
 4fJjEsAwW8aGtTpwqGhpIgFW3g0jppiY5qGPgv9Te2KDS44w02HdZHjKErneM2rO9pknsfyo7kM
 1wfwtlJMhlU7dwm0=
X-Received: by 2002:a1c:4187:: with SMTP id o129mr6205689wma.113.1600865006349; 
 Wed, 23 Sep 2020 05:43:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz7Ke3U7ksa+AtG5AgcqNxDZMOwwmv8ZRzG1SiJiS5vgyYkHBn80SzwfbEt4yoS144hPlkuZA==
X-Received: by 2002:a1c:4187:: with SMTP id o129mr6205673wma.113.1600865006094; 
 Wed, 23 Sep 2020 05:43:26 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:15f1:648d:7de6:bad9?
 ([2001:b07:6468:f312:15f1:648d:7de6:bad9])
 by smtp.gmail.com with ESMTPSA id z11sm30383948wru.88.2020.09.23.05.43.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Sep 2020 05:43:25 -0700 (PDT)
Subject: Re: [PATCH 0/3] i386/kvm: Assume IRQ routing is always available
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
References: <20200922201922.2153598-1-ehabkost@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <68fe355a-10de-0810-f001-46a4f9d8f3f2@redhat.com>
Date: Wed, 23 Sep 2020 14:43:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200922201922.2153598-1-ehabkost@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 23:02:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.228,
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
Cc: Sergio Lopez <slp@redhat.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 22/09/20 22:19, Eduardo Habkost wrote:
> KVM_CAP_IRQ_ROUTING is available since 2019 (Linux v2.6.30), so
> we can safely assume it's always present and remove some runtime
> checks.
> 
> Eduardo Habkost (3):
>   i386/kvm: Require KVM_CAP_IRQ_ROUTING
>   i386/kvm: Remove IRQ routing support checks
>   i386/kvm: Delete kvm_allows_irq0_override()
> 
>  target/i386/kvm_i386.h |  1 -
>  hw/i386/fw_cfg.c       |  2 +-
>  hw/i386/kvm/apic.c     |  5 ++---
>  hw/i386/kvm/ioapic.c   | 33 ++++++++++++++++-----------------
>  hw/i386/microvm.c      |  2 +-
>  hw/i386/pc.c           |  2 +-
>  target/i386/kvm-stub.c |  5 -----
>  target/i386/kvm.c      | 17 +++++------------
>  8 files changed, 26 insertions(+), 41 deletions(-)
> 

Acked-by: Paolo Bonzini <pbonzini@redhat.com>


