Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 540A6C4363D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 18:53:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF6B720795
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 18:53:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RsHhkVDA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF6B720795
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57262 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOQBY-0000o9-Om
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 14:53:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58988)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kOQ8V-0006e4-TN
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 14:50:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54584)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kOQ8T-0003Hc-8t
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 14:50:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601664628;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dwF7psAnj/ysn7pRH+n0JfdIMrlRVE8kzQs5BgjaUXI=;
 b=RsHhkVDA6w1e8XUinssw00xGEgm+9AmKiACUC4++UR1WLhuY0M31e9Kcyu+ss+IQdpgXEI
 jTT3lEwemXQuZypW7lQx6ePETULmFjcxRgTlSYUTWB8GiyivLwUd/9U90jLNAnmGIs8/V+
 rBA4AMoQD9VXYs/no2p5CUHAGsXMsQo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-475-euSj4PzgPcKvTL_ZWIyDtA-1; Fri, 02 Oct 2020 14:50:26 -0400
X-MC-Unique: euSj4PzgPcKvTL_ZWIyDtA-1
Received: by mail-wr1-f72.google.com with SMTP id i10so875533wrq.5
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2020 11:50:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=dwF7psAnj/ysn7pRH+n0JfdIMrlRVE8kzQs5BgjaUXI=;
 b=I/kmH+jFagKMqhHzUlquft1djlhItW6VNXhzw//vH4twzH2Klm0XQ7SzzRpJCOfwrk
 pwcpE/2BLDbbrye8HoPXF1c3GNxx/v33ZrQTOFdJL1IGkOJdES6Vh8kxS88cQERsSF0Z
 xRX4QE/amtOXx8DUQ/h+SIZawS31vJ8CyHio5k3tEaBFuNR7qX+7aGW/v4qyfoyoOQpK
 QKj+Tt7EUFLhd8hkPDih8tlcDvPRup2P2DiHmc+1qZ1Iu1uySn+DIc1T5UdqeZ9nketO
 hdByxm+10L08ROonZXg0UGlqE3cvTzXg4+DoEOFyNT+HCaCJ5PBL4E0N14TLL7BbROiU
 LPOQ==
X-Gm-Message-State: AOAM533m0nJ0q/2r9Oa+QJbQ0n1Vdz39SPHP41RfoL9NPqdFpi/0L4qW
 /XqBZnKG28EImDJPsx2eGlqSSM9e4O1ziOTITMiPjtrNboqhmrag+WDoHWuAnNGX+H9vPMbH/BG
 iuKkV511uKeMCQ/k=
X-Received: by 2002:a05:600c:297:: with SMTP id
 23mr4127041wmk.184.1601664625085; 
 Fri, 02 Oct 2020 11:50:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzbkJWBvWPbxXObhVgA8qy/BGGEASRljk16HRZzOojfeCpPmp5DZmUQkwfwWwZQmDuzo1cJrw==
X-Received: by 2002:a05:600c:297:: with SMTP id
 23mr4127027wmk.184.1601664624841; 
 Fri, 02 Oct 2020 11:50:24 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:47e0:e742:75ba:b84d?
 ([2001:b07:6468:f312:47e0:e742:75ba:b84d])
 by smtp.gmail.com with ESMTPSA id d135sm2586374wmd.33.2020.10.02.11.50.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Oct 2020 11:50:24 -0700 (PDT)
Subject: Re: [PATCH 2/8] docs: tweak kernel-doc for QEMU coding standards
To: Eduardo Habkost <ehabkost@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20191129140217.17797-1-pbonzini@redhat.com>
 <20191129140217.17797-3-pbonzini@redhat.com>
 <CAFEAcA-svKVfBGRfwX6d5woqOW0z--rV3-gC9Qi9NqypYfZ=hw@mail.gmail.com>
 <20201002183455.GF7303@habkost.net>
 <CAFEAcA_KXvADFm7uQX1a4peofK_On3DaFH2ZCUtWteaiABM-yA@mail.gmail.com>
 <20201002184608.GG7303@habkost.net>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e63e073b-31b3-590d-2f9b-e871c9677448@redhat.com>
Date: Fri, 2 Oct 2020 20:50:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201002184608.GG7303@habkost.net>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/02 01:13:31
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.256, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 02/10/20 20:46, Eduardo Habkost wrote:
> This is not the code that parses "#MemoryRegionSection", it is
> the code that parses:
> 
> /**
>  * MemoryRegionSection: describes a fragment of a #MemoryRegion
>    ^^^^^^^ this line

We can probably just adjust the comments to include the "struct" keyword
first.  There aren't that many, (un)fortunately.

It may even be possible to print to stderr the file and line number so
that the script tells us where the hack is firing.

Paolo


