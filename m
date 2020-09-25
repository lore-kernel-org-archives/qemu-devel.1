Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C1BEC4727E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 20:41:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1503520838
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 20:41:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ccIhm495"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1503520838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46690 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLuXT-0006Pt-6D
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 16:41:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48342)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kLuWH-0005xU-Pr
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 16:40:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55505)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kLuWG-0005oz-53
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 16:40:41 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601066439;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EAubhKnwyEs8w9HrWjRkvDMBUMr7xck3seQiqdvNCL4=;
 b=ccIhm495cV1pnlrpCe69Cj6qVLZAh7NUzcg0nDLFvmas7BfGqxY+b3/MxJDNvOUY5sIBwu
 PbRyJC5Pe7TSu7KVbasahBEOBKp0cmt3dlgBYHfcJzdhfSFUeC+CHJ6Ypd2gqbkCcXnBnT
 S6KfW7JhuddIHZnQEy7Jkl4MUwxh8nQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-422-Y59qkiVCN7isFQN0vcTmxQ-1; Fri, 25 Sep 2020 16:40:37 -0400
X-MC-Unique: Y59qkiVCN7isFQN0vcTmxQ-1
Received: by mail-wm1-f71.google.com with SMTP id x81so69246wmg.8
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2020 13:40:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=EAubhKnwyEs8w9HrWjRkvDMBUMr7xck3seQiqdvNCL4=;
 b=WBO12aSQS4ioQxXJFJYMk3lJ2D1ONTUMNQi7V145Of7RQEWraF9ev/OwVzo3P2VGnq
 ZNnyfqEoaAFyoLrDTtFfWOUpe0VoJxJngGc85Bl/7Y52LrddjDM79THRXrD5oDyl8fzh
 ppfUpkxgm0xHRWlbmFpKeLs59VHKhv+xarBFRq1ikt62p6J9NEiax00sOWTgAo1/7lk3
 nCLJhTLeL5Pc/KcQiyS0eEK1MxMC9EcEU2npbtqjJL93mZA7T89e/lZBj+gkimhRlVAg
 RUIGZzuZm9gU2GQ+woreGUioE/ypX11O9kxBP+dprlB3epkZS11iRf7dVBy+OT60Ch7c
 Vv7w==
X-Gm-Message-State: AOAM5303UZscD9duiOG2tqGETicLDjSR22SH7uRX/94rkFPvcGL7EWF0
 WRVM7fCyA8rbEEeSsrOmWVUg0jWrZEoidhcVCgW4igNq5mb6xiT5DFNiVvjInpfXikdg4o2Kog1
 nTM9nJTipiR9geas=
X-Received: by 2002:adf:a3ca:: with SMTP id m10mr6458354wrb.104.1601066436439; 
 Fri, 25 Sep 2020 13:40:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy1ymA4ihf4Yb5gmaE9JLo7z92q/jSHxxiPHu8gDHsNp0Wji4GQSm7sgd6OPgh5z1zqPc5J6A==
X-Received: by 2002:adf:a3ca:: with SMTP id m10mr6458337wrb.104.1601066436186; 
 Fri, 25 Sep 2020 13:40:36 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:ec9b:111a:97e3:4baf?
 ([2001:b07:6468:f312:ec9b:111a:97e3:4baf])
 by smtp.gmail.com with ESMTPSA id 97sm3895548wrm.15.2020.09.25.13.40.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Sep 2020 13:40:35 -0700 (PDT)
Subject: Re: [PATCH v1 1/3] i386: Remove the limitation of IP payloads for
 Intel PT
To: Eduardo Habkost <ehabkost@redhat.com>
References: <1582580312-19864-1-git-send-email-luwei.kang@intel.com>
 <1582580312-19864-2-git-send-email-luwei.kang@intel.com>
 <20200925161539.GS3717385@habkost.net>
 <MW3PR11MB46655375CAECC74BA2D7CAECF2360@MW3PR11MB4665.namprd11.prod.outlook.com>
 <20200925165415.GT3717385@habkost.net>
 <036ba624-670c-d6b7-721c-ad5c9d648c1f@redhat.com>
 <20200925202956.GV3717385@habkost.net>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <db31a0fa-c6cf-4730-6d64-f81228948d30@redhat.com>
Date: Fri, 25 Sep 2020 22:40:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200925202956.GV3717385@habkost.net>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 01:07:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.238, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Kang,
 Luwei" <luwei.kang@intel.com>, "Strong, Beeman" <beeman.strong@intel.com>,
 "rth@twiddle.net" <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 25/09/20 22:29, Eduardo Habkost wrote:
>> No, it's not possible.  KVM doesn't have a say on what the processor
>> writes in the tracing packets.
> Can KVM refuse to enable packet generation if CSbase is not zero
> and CPUID.(EAX=14H,ECX=0)[bit 31] seen by guest is different from
> host?

Yes, but the processor could change operating mode (and hence CSbase)
while tracing is active.  This is very unlikely, since it would require
nonzero CS-base and a 32-bit host, but in principle not impossible
(could be a firmware call, for example).

The only solution is for KVM to accept both, and for QEMU to refuse a
setting that does not match the host.

Paolo


