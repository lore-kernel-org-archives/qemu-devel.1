Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 160F9C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 14:02:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D54CC2064B
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 14:02:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SNeD5WzP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D54CC2064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43532 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxsqX-0000zz-3c
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 10:02:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58216)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jxspv-0000aK-Az
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 10:01:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41637
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jxspt-0008ME-Qf
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 10:01:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595340096;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mhAuwq5sD7tvcPGVylUKCyO6MSgM3RtvHrdJu1vOrNI=;
 b=SNeD5WzPcxT/o1jZDxvc1FFhXkxe2Dd9yTLzbjEXMp2hN3QKg9V9lJ7J1hpJubWK5i0e2H
 bwGkVhIPIL2CPqPf05F/iv7y2nqTA5BocPctPtsXlmx69d0cgnbZDxjykyzY9ADXYy4Hsx
 qUkRarGuGN9t9YkGQ2PYuJokE2SUpTQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-11-OwjnbuurP2qusx5A_VofMw-1; Tue, 21 Jul 2020 10:01:34 -0400
X-MC-Unique: OwjnbuurP2qusx5A_VofMw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B6739800469;
 Tue, 21 Jul 2020 14:01:32 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-115-89.ams2.redhat.com
 [10.36.115.89])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 27D9F87314;
 Tue, 21 Jul 2020 14:01:32 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 67BD09D9E; Tue, 21 Jul 2020 16:01:31 +0200 (CEST)
Date: Tue, 21 Jul 2020 16:01:31 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH for-5.1] xhci: fix valid.max_access_size to access
 address registers
Message-ID: <20200721140131.ygigq46fkd4ntqog@sirius.home.kraxel.org>
References: <20200721083322.90651-1-lvivier@redhat.com>
 <65c1e6b9-523b-99ec-39eb-00ce59399ccf@redhat.com>
 <d7f4e646-ac72-cb41-c3bc-13e4e5b91827@redhat.com>
MIME-Version: 1.0
In-Reply-To: <d7f4e646-ac72-cb41-c3bc-13e4e5b91827@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kraxel@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/21 01:46:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Alexey Kardashevskiy <aik@au1.ibm.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  Hi,

> >> -    .valid.max_access_size = 4,
> >> +    .valid.max_access_size = sizeof(dma_addr_t),

> I don't think it's needed as AC64 (in fact a bit in HCCPARAMS) is set
> only if sizeof(dma_addr_t) != 4...

So both AC64 bit and max_access_size are in sync, good.

Patch queued.

thanks,
  Gerd


