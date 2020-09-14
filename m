Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E031C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 09:54:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C71D20731
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 09:54:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YgSC1zsQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C71D20731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56868 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHlC9-0005SL-Kn
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 05:54:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55696)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kHlAJ-000309-5M
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 05:52:51 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:44448
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kHlAG-0004qN-1X
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 05:52:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600077166;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N/bXL1WF/+Pl/sz8oGctDjtCFcli1jykvzFFUE6LTr0=;
 b=YgSC1zsQAqOmWG+Djsfh1k4SCpnOBXVU3Ny980g2qpvEBc8V9RBq+iPFDotqhG1nN7pwXs
 p/omY6UpGxFrdYEJ90UgAjHjUzI25BVFWcA6UgYwvAL6O1in+XDvjyHAtfbffVNw+azvUH
 LS+6oYvZIcIG7sEBENdiobSTFztx54c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-128-agbB6ulHMVGmYiQkTk-JYQ-1; Mon, 14 Sep 2020 05:52:45 -0400
X-MC-Unique: agbB6ulHMVGmYiQkTk-JYQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1B9A918A2246;
 Mon, 14 Sep 2020 09:52:44 +0000 (UTC)
Received: from localhost (ovpn-114-157.ams2.redhat.com [10.36.114.157])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D93C27B7AD;
 Mon, 14 Sep 2020 09:52:40 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/3] configure: add missing CONFIG_JEMALLOC
Date: Mon, 14 Sep 2020 10:52:30 +0100
Message-Id: <20200914095231.621068-3-stefanha@redhat.com>
In-Reply-To: <20200914095231.621068-1-stefanha@redhat.com>
References: <20200914095231.621068-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=205.139.110.61; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/14 02:33:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.695,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MIME_BASE64_TEXT=1.741, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

VGhlIGZlYXR1cmUgc3VtbWFyeSBpbiBtZXNvbi5idWlsZCBjaGVja3MgZm9yIENPTkZJR19KRU1B
TExPQzoKCiAgc3VtbWFyeV9pbmZvICs9IHsnamVtYWxsb2Mgc3VwcG9ydCc6ICBjb25maWdfaG9z
dC5oYXNfa2V5KCdDT05GSUdfSkVNQUxMT0MnKX0KCk5vdGhpbmcgZW1pdHMgQ09ORklHX0pFTUFM
TE9DIGluIC4vY29uZmlndXJlIHNvIHRoaXMgZmVhdHVyZSBhcHBlYXJzCmRpc2FibGVkIGV2ZW4g
aWYgaXQgaGFzIGJlZW4gZW5hYmxlZC4KClNpZ25lZC1vZmYtYnk6IFN0ZWZhbiBIYWpub2N6aSA8
c3RlZmFuaGFAcmVkaGF0LmNvbT4KLS0tCiBjb25maWd1cmUgfCA0ICsrKysKIDEgZmlsZSBjaGFu
Z2VkLCA0IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9jb25maWd1cmUgYi9jb25maWd1cmUK
aW5kZXggOWY1YjNhODg5Ny4uYTkxNzQ1NjkwOSAxMDA3NTUKLS0tIGEvY29uZmlndXJlCisrKyBi
L2NvbmZpZ3VyZQpAQCAtNzAzMSw2ICs3MDMxLDEwIEBAIGlmIHRlc3QgIiR0Y21hbGxvYyIgPSAi
eWVzIiA7IHRoZW4KICAgZWNobyAiQ09ORklHX1RDTUFMTE9DPXkiID4+ICRjb25maWdfaG9zdF9t
YWsKIGZpCiAKK2lmIHRlc3QgIiRqZW1hbGxvYyIgPSAieWVzIiA7IHRoZW4KKyAgZWNobyAiQ09O
RklHX0pFTUFMTE9DPXkiID4+ICRjb25maWdfaG9zdF9tYWsKK2ZpCisKIGlmIHRlc3QgIiRhdngy
X29wdCIgPSAieWVzIiA7IHRoZW4KICAgZWNobyAiQ09ORklHX0FWWDJfT1BUPXkiID4+ICRjb25m
aWdfaG9zdF9tYWsKIGZpCi0tIAoyLjI2LjIKCg==


