Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02007C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 06:47:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A94A7205CB
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 06:47:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YGHpyWH7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A94A7205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39748 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbIVT-0000CY-Rb
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 02:47:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57856)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jbIUT-0007pi-7b
 for qemu-devel@nongnu.org; Wed, 20 May 2020 02:46:09 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30627
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jbIUS-0000kq-CN
 for qemu-devel@nongnu.org; Wed, 20 May 2020 02:46:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589957167;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8O6kyHrAXzedp+n3Nvd24+JQBjIpJ9kDRyGxGhFRDdk=;
 b=YGHpyWH7FCiqmTNO61Td0PCQDYaBsvop5DkPvfS8g90OSXj1l84ek1/4BT3sERIr8YE4K7
 Us/Cv40MfGKxd4D5tz0Emv3AxrlDh7R024hsssuenaWVT3D6gKYvFZOIQDKyE259RMTs4Z
 i6yftb4Sn2gmw1MDetFSM8AUCmaPCmM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-232-GqZL5lGiPr-hihDBXaGkCQ-1; Wed, 20 May 2020 02:46:05 -0400
X-MC-Unique: GqZL5lGiPr-hihDBXaGkCQ-1
Received: by mail-wr1-f69.google.com with SMTP id r14so967206wrw.8
 for <qemu-devel@nongnu.org>; Tue, 19 May 2020 23:46:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=8O6kyHrAXzedp+n3Nvd24+JQBjIpJ9kDRyGxGhFRDdk=;
 b=QNz2wZu2mGr3e4idcQBb1Gn8mMiP1iBnPSkbNbi1QuiG20sTsrEf0spjpParf3ZDlS
 0Sxy3x83Fp2zzaiv7RMDstWolLo9V6JjoJKHjVcGZ3d0ITIj/LgZaPcPvIUGaH90V4TK
 7yaQykmFP+8EesBHaiPwZAJNnO3L1v7Vjk1n2RKrlRC9VxJQXz8CGyfH7qnHryeWR3tF
 SiAMJtudF8jcgt9Z7H8AscsdXyrnxn5KrFQXQYYzcKM0SYgTbszHXPTOGAJKAxHkVBB3
 8kzm475OHIhWqtK2hYYjWV8lYj5HAst8EtxGsBVUlrGwZYp2SzdApDBiHyec94JBoUDC
 U+dw==
X-Gm-Message-State: AOAM533u6zzz+ohB9MEcRX78m/3mXyqVbrzXED5oeV1mmHs6exaKAjVV
 20yCAn+nKKorT3rQdfVr9IKIyFbFiKn/tJsxBHwWectZwFYgbB99bT+Dutkyd6sMfHsS8WlzqLF
 v6e/tkzaNdHCKSX8=
X-Received: by 2002:adf:f40a:: with SMTP id g10mr2836714wro.117.1589957164537; 
 Tue, 19 May 2020 23:46:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzyP6fXTAbVyUgCLCue5D7yxLWMLOPv/kgyNQ3NY7/fKHCl9CQwB/i29CBdlUrAWkj4hipOhA==
X-Received: by 2002:adf:f40a:: with SMTP id g10mr2836693wro.117.1589957164318; 
 Tue, 19 May 2020 23:46:04 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:591e:368f:1f3f:27d2?
 ([2001:b07:6468:f312:591e:368f:1f3f:27d2])
 by smtp.gmail.com with ESMTPSA id f128sm2201390wme.1.2020.05.19.23.46.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 May 2020 23:46:03 -0700 (PDT)
Subject: Re: [PATCH 00/55] qdev: Rework how we plug into the parent bus
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200519145551.22836-1-armbru@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5f7c749a-ccbe-5ff6-3889-696d5de05fc0@redhat.com>
Date: Wed, 20 May 2020 08:46:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200519145551.22836-1-armbru@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/19 22:48:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 "Michael S . Tsirkin" <mst@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Gerd Hoffmann <kraxel@redhat.com>, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 19/05/20 16:54, Markus Armbruster wrote:
> Paolo recently suggested "to move the bus argument (and thus
> qdev_set_parent_bus) to qdev_init"[1], and that it "would be quite
> large but hopefully scriptable"[2].  Nerd sniped!
> 
> The series is big, but at least the bigger patches are all mechanical.
> 
> It is based on my "[PATCH 00/24] Fixes around device realization".
> 
> I'm abstaining from cc'ing maintainers on mechanical conversions.  I
> still cc: for patches I deem interesting, with related patches thrown
> in for context.  Let me know if you think I should cc: more widely.
> 
> PATCH 01-02  	Preliminary cleanup
> PATCH 03     	New qdev infrastructure
>       	     	Commit message explains why the current state is
>       	     	problematic, and how my work improves it.
> PATCH 04-11  	Convert direct users of qdev
> PATCH 12-16  	Convert PCI
> PATCH 17-20  	Convert ISA
> PATCH 21-24  	Convert SSI
> PATCH 25-28  	Convert USB
> PATCH 29     	Garbage collection
> PATCH 30-32  	Convert aux-bus
> PATCH 33-40  	Clean up around child device initialization
> PATCH 41-49  	Convert sysbus
> PATCH 50     	Stop pretending recursive realization is about to become
>       	     	real
> PATCH 51-53  	Convert bus-less devices
> PATCH 54	Garbage collection
> PATCH 55	Maintain MAINTAINERS

Great stuff, I only had some comments on the commit messages.  I still
have to review patches 47 and 48 more corefully.

Paolo


