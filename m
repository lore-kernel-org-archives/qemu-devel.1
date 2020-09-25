Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 345ABC4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 08:53:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FA4420936
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 08:53:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jd7OwjIJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FA4420936
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39310 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLjTR-0001Lg-Eg
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 04:53:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52834)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kLjRk-0000CK-23
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 04:51:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:36918)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kLjRh-0005PB-J1
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 04:51:15 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601023871;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pRG0H7r3cKqQm27cVPcMa1iZkYLiHI2CPy4+qCFW1tM=;
 b=Jd7OwjIJqixs8xvIVrED7zo4rZ2HnIFpJ0v6ouui8RIDQzJdzxU6CvJPkxKHPyJsa2YAmN
 a9p9dLIJzMD84QvPHZpuiC0au03FTXMdNBcJlWFCnzMq/apJbUM9xCH3w6JQt1FcOJvNJQ
 ugV9jbkk6FkcHQ3wg/4sTAkzAkpiOWs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-144-aT-PYYwfPOSDU_6BYbwecw-1; Fri, 25 Sep 2020 04:51:09 -0400
X-MC-Unique: aT-PYYwfPOSDU_6BYbwecw-1
Received: by mail-wm1-f70.google.com with SMTP id s24so583508wmh.1
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2020 01:51:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=pRG0H7r3cKqQm27cVPcMa1iZkYLiHI2CPy4+qCFW1tM=;
 b=HcE2MFVeldU88z28YOWCgPjvnXnXwH8CSC10luf/nIHvCFv7ZaRvvDyBslrLmVvFMO
 s8FZPJ17BvKFTII0qULEUwoiP4q2ISEf3q4H6vFikT/lyQm1sw79F2zgOOSwQzkQg3bQ
 QxAs10lQYdmFmVuZH0uWt8sl7GdUVDjWynFOshrKasrZrkdAl/RYXCRjlaFPOl+jJ3+R
 S0KYaRLAsaulSGvo1b83wodqO99Trnop1PRBnAdUy2sRJLQuakKJyUP46zt1KF/n5Rs3
 uW/B0uTK8rYA5T8d5AipLbW4xf7bwZTARKPVhBU/CnEXnKn+67heDxEWncByf6PfQcm8
 G4AQ==
X-Gm-Message-State: AOAM532MX9gCZ942gHRQnJUX/XnnjvaaSj6f9aorJYK6/YLcrY8pnokw
 ugYmKHQhgWelJLMgJ0bWMN6k7tyYL9QxKWidsknGNZ+/bYHTqD/OgjeWpTQa0CsEt1D5iw7FCWG
 sUouTPy63L8laSIE=
X-Received: by 2002:adf:d845:: with SMTP id k5mr3037630wrl.285.1601023867500; 
 Fri, 25 Sep 2020 01:51:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwCfw/mpXmy/j9RdvUPQJBwj94hCzl8r+H9IRq6gYf5nu8Qq2M368LoLovETpecVSxDt/nUUg==
X-Received: by 2002:adf:d845:: with SMTP id k5mr3037611wrl.285.1601023867241; 
 Fri, 25 Sep 2020 01:51:07 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:ec9b:111a:97e3:4baf?
 ([2001:b07:6468:f312:ec9b:111a:97e3:4baf])
 by smtp.gmail.com with ESMTPSA id x10sm2120241wmi.37.2020.09.25.01.51.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Sep 2020 01:51:06 -0700 (PDT)
Subject: Re: SEV guest debugging support for Qemu
To: Ashish Kalra <ashish.kalra@amd.com>, dgilbert@redhat.com,
 qemu-devel@nongnu.org
References: <20200922201124.GA6606@ashkalra_ubuntu_server>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5a58509c-5838-f0aa-d9ab-4f85ca0ac35f@redhat.com>
Date: Fri, 25 Sep 2020 10:51:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200922201124.GA6606@ashkalra_ubuntu_server>
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
 NICE_REPLY_A=-0.214, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: thomas.lendacky@amd.com, jon.grimm@amd.com, brijesh.singh@amd.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 22/09/20 22:11, Ashish Kalra wrote:
> This internally invokes the address_space_rw() accessor functions
> which we had  "fixed" internally (as part of the earlier patch) to
> invoke memory region specific debug ops. In our earlier approach we
> were adding debug ops/callbacks to memory regions and as per comments
> on our earlier patches, Paolo was not happy with this debug API for 
> MemoryRegions and hence the SEV support for Qemu was merged without
> the debug support.

My complaint was only about hooking into address_space_read and
address_space_write; I think the hook should not touch general-purpose
(non-debug) code if possible, so something like this:

typedef struct MemoryDebugOps {
    hwaddr (*translate)(CPUState *cpu, target_ulong addr,
                        MemTxAttrs *attrs);
    MemTxResult (*read)(AddressSpace *as, hwaddr phys_addr,
                        MemTxAttrs attrs, void *buf,
                        hwaddr len);
    MemTxResult (*write)(AddressSpace *as, hwaddr phys_addr,
                         MemTxAttrs attrs, const void *buf,
                         hwaddr len);
} MemoryDebugOps;

These ops would be used only by cpu_memory_rw_debug and would default to

static const MemoryDebugOps default_debug_ops = {
    .translate = cpu_get_phys_page_attrs_debug,
    .read = address_space_read,
    .write = address_space_write_rom
};

static const MemoryDebugOps *debug_ops = &default_debug_ops;

Paolo


