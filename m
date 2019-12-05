Return-Path: <SRS0=YrRb=Z3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91CF5C43603
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 22:07:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 589E820707
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 22:07:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="KdkaZwkh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 589E820707
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33132 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iczHU-00084w-G9
	for qemu-devel@archiver.kernel.org; Thu, 05 Dec 2019 17:07:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46868)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=235b7d7bf=sveith@amazon.de>) id 1iczFS-0006Hi-1k
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 17:05:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=235b7d7bf=sveith@amazon.de>) id 1iczFQ-0007sG-Qy
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 17:05:21 -0500
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:16889)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <prvs=235b7d7bf=sveith@amazon.de>)
 id 1iczFA-0007ib-6y; Thu, 05 Dec 2019 17:05:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
 t=1575583504; x=1607119504;
 h=subject:to:references:from:message-id:date:mime-version:
 in-reply-to:content-transfer-encoding;
 bh=P8mYv0xtxGqWLdjaZW6V3Ab1CXn0QejLguDGBu0GVMc=;
 b=KdkaZwkhTO6HHsgueshg6o54S9IvWmoQHh6Zio6QvcQKHKMVAZ2xQ84V
 mIHL1lgsgFbgtI7aaY4SRM8IZd0X+1khoPjLoZhHH72WY7MJhxFfqPLcy
 Cg3A2UfEevhfqLyf0/fEtmH1F9DpT7DppGk77YHVbpr2W54ORxxl78qWE U=;
IronPort-SDR: BSls0ZgOCEvY6zuYJFv1d5GRNCESfSb+rcY46D3cmF7B/2l0LipF7FIYGoT0Hz8ZRyfJR4S47t
 v/4WD2dsyWEg==
X-IronPort-AV: E=Sophos;i="5.69,282,1571702400"; 
   d="scan'208";a="7339802"
Received: from iad6-co-svc-p1-lb1-vlan2.amazon.com (HELO
 email-inbound-relay-2a-f14f4a47.us-west-2.amazon.com) ([10.124.125.2])
 by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP;
 05 Dec 2019 22:05:01 +0000
Received: from EX13MTAUEA001.ant.amazon.com
 (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
 by email-inbound-relay-2a-f14f4a47.us-west-2.amazon.com (Postfix) with ESMTPS
 id 7D2E1A22CB; Thu,  5 Dec 2019 22:05:00 +0000 (UTC)
Received: from EX13D18EUC002.ant.amazon.com (10.43.164.50) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 5 Dec 2019 22:04:59 +0000
Received: from [10.95.146.221] (10.43.166.12) by EX13D18EUC002.ant.amazon.com
 (10.43.164.50) with Microsoft SMTP Server (TLS) id 15.0.1367.3;
 Thu, 5 Dec 2019 22:04:58 +0000
Subject: Re: [PATCH 1/5] hw/arm/smmuv3: Apply address mask to linear strtab
 base address
To: Auger Eric <eric.auger@redhat.com>, <qemu-devel@nongnu.org>,
 <qemu-arm@nongnu.org>
References: <1575467748-28898-1-git-send-email-sveith@amazon.de>
 <1575467748-28898-2-git-send-email-sveith@amazon.de>
 <0f01a30e-5b27-f97c-903a-a8a2a74a1cdd@redhat.com>
From: Simon Veith <sveith@amazon.de>
Message-ID: <13be5c71-128a-0ae7-1af0-72b58b5958ab@amazon.de>
Date: Thu, 5 Dec 2019 23:04:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <0f01a30e-5b27-f97c-903a-a8a2a74a1cdd@redhat.com>
Content-Language: en-US
X-Originating-IP: [10.43.166.12]
X-ClientProxiedBy: EX13D30EUC004.ant.amazon.com (10.43.164.11) To
 EX13D18EUC002.ant.amazon.com (10.43.164.50)
Precedence: Bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 72.21.196.25
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SGVsbG8gRXJpYywKCk9uIDA1LzEyLzIwMTkgMDk6NDIsIEF1Z2VyIEVyaWMgd3JvdGU6Cj4gTm90
IHJlbGF0ZWQgdG8gdGhpcyBwYXRjaCBidXQgSSBub3RpY2VkIFNNTVVfQkFTRV9BRERSX01BU0sg
c2hvdWxkIGJlCj4gMHhmZmZmZmZmZmZmYzAgYW5kIG5vdCAweGZmZmZmZmZmZmZlMC4gSSBjYW4g
Zml4IGl0IHNlcGFyYXRlbHkgb3IgaWYgeW91Cj4gcmVzcGluLCB5b3UgbWF5IGZpeCBpdCBhcyB3
ZWxsPwoKR29vZCBjYXRjaCwgdGhhbmsgeW91LiBJJ2xsIGZpeCBpdCBpbiB0aGUgbmV4dCB2ZXJz
aW9uLgoKTG9va2luZyBhdCB0aGUgdXBwZXIgZW5kIG9mIHRoYXQgbWFzaywgaXQgc2VlbXMgdGhh
dCB3ZSBhcmUgY3VycmVudGx5IG1hc2tpbmcgb3V0IGJpdHMgNDggdGhyb3VnaCA2MywgcmF0aGVy
IHRoYW4ganVzdCA1MSB0aHJvdWdoIDYzLgpUaGUgcmVmZXJlbmNlIG1hbnVhbCBzYXlzIHRoYXQg
dGhpcyBzaG91bGQgYmUgZG9uZSB0byBtYXRjaCB0aGUgc3lzdGVtIHBoeXNpY2FsIGFkZHJlc3Mg
c2l6ZSBhcyBnaXZlbiBieSBTTU1VX0lEUjUuT0FTLgoKV2UgZGVmaW5lIFNNTVVfSURSNV9PQVMg
dG8gYmUgNCwgd2hpY2ggc2VsZWN0cyBhIHBoeXNpY2FsIGFkZHJlc3Mgc2l6ZSBvZiA0NCBiaXRz
IChyZWYuIHNlY3Rpb24gNi4zLjYpLiBJIHRoaW5rIHRoZSBtYXNrIHNob3VsZCB0aGVyZWZvcmUg
YmUgMHhmZmZmZmZmZmZjMCB0byBjbGVhciBiaXRzIDQ0IGFuZCBhYm92ZS4gRG8geW91IGFncmVl
PwoKSWRlYWxseSwgd2Ugd291bGQgZGVyaXZlIHRoaXMgbWFzayBmcm9tIG91ciBkZWZpbml0aW9u
IG9mIFNNTVVfSURSNV9PQVMsIGJ1dCBJJ20gbm90IHN1cmUgaXQncyBva2F5IHRvIHN0dWZmIGEg
Y2FsbCB0byBvYXMyYml0cygpIGludG8gdGhlIFNNTVVfQkFTRV9BRERSX01BU0sgbWFjcm8uCgpS
ZWdhcmRzClNpbW9uCgoKCkFtYXpvbiBEZXZlbG9wbWVudCBDZW50ZXIgR2VybWFueSBHbWJICkty
YXVzZW5zdHIuIDM4CjEwMTE3IEJlcmxpbgpHZXNjaGFlZnRzZnVlaHJ1bmc6IENocmlzdGlhbiBT
Y2hsYWVnZXIsIFJhbGYgSGVyYnJpY2gKRWluZ2V0cmFnZW4gYW0gQW10c2dlcmljaHQgQ2hhcmxv
dHRlbmJ1cmcgdW50ZXIgSFJCIDE0OTE3MyBCClNpdHo6IEJlcmxpbgpVc3QtSUQ6IERFIDI4OSAy
MzcgODc5CgoK


