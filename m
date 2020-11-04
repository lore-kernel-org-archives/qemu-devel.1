Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74129C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 15:38:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB8782072C
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 15:38:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OYrsUg0L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB8782072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41404 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaKrt-0007GB-Ps
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 10:38:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60564)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kaKbM-0008Bn-EQ
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 10:21:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60492)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kaKbI-0008Mt-LB
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 10:21:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604503287;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Epts384DsHq2EDzB8osaYgcnKC56AH4XpG7OYuTiA9w=;
 b=OYrsUg0LxJ49yXftfWmAurZd8eI+CUDfV2o2YzSrQiQ4usKyXp1B0oUXwBKYxe4wT+J0k0
 B32FuWwUa4sMi348b/TbV4UgsdBQ/QEyGxw93fCkfAVUZszB8XR3i7qRYj8rriR+ZLf/j7
 5COBRn6mOmUFHaEjRrw/VxkYCADULmo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-269-qzUYfoSWNO-DAUgAeQpwZg-1; Wed, 04 Nov 2020 10:21:23 -0500
X-MC-Unique: qzUYfoSWNO-DAUgAeQpwZg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 407B11891E88;
 Wed,  4 Nov 2020 15:21:22 +0000 (UTC)
Received: from localhost (ovpn-115-145.ams2.redhat.com [10.36.115.145])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CF4005C3E1;
 Wed,  4 Nov 2020 15:21:21 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 26/33] block/nvme: Fix nvme_submit_command() on big-endian host
Date: Wed,  4 Nov 2020 15:18:21 +0000
Message-Id: <20201104151828.405824-27-stefanha@redhat.com>
In-Reply-To: <20201104151828.405824-1-stefanha@redhat.com>
References: <20201104151828.405824-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Received-SPF: pass client-ip=216.205.24.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 00:03:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 Eric Auger <eric.auger@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Coiby Xu <Coiby.Xu@gmail.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Klaus Jensen <its@irrelevant.dk>, Stefan Hajnoczi <stefanha@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

RnJvbTogUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEByZWRoYXQuY29tPgoKVGhlIENv
bXBsZXRpb24gUXVldWUgQ29tbWFuZCBJZGVudGlmaWVyIGlzIGEgMTYtYml0IHZhbHVlLApzbyBu
dm1lX3N1Ym1pdF9jb21tYW5kKCkgaXMgdW5saWtlbHkgdG8gd29yayBvbiBiaWctZW5kaWFuCmhv
c3RzLCBhcyB0aGUgcmVsZXZhbnQgYml0cyBhcmUgdHJ1bmNhdGVkLgpGaXggYnkgdXNpbmcgdGhl
IGNvcnJlY3QgYnl0ZS1zd2FwIGZ1bmN0aW9uLgoKRml4ZXM6IGJkZDZhOTBhOWU1ICgiYmxvY2s6
IEFkZCBWRklPIGJhc2VkIE5WTWUgZHJpdmVyIikKUmVwb3J0ZWQtYnk6IEtlaXRoIEJ1c2NoIDxr
YnVzY2hAa2VybmVsLm9yZz4KU2lnbmVkLW9mZi1ieTogUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kg
PHBoaWxtZEByZWRoYXQuY29tPgpSZXZpZXdlZC1ieTogU3RlZmFuIEhham5vY3ppIDxzdGVmYW5o
YUByZWRoYXQuY29tPgpNZXNzYWdlLWlkOiAyMDIwMTAyOTA5MzMwNi4xMDYzODc5LTI1LXBoaWxt
ZEByZWRoYXQuY29tClNpZ25lZC1vZmYtYnk6IFN0ZWZhbiBIYWpub2N6aSA8c3RlZmFuaGFAcmVk
aGF0LmNvbT4KVGVzdGVkLWJ5OiBFcmljIEF1Z2VyIDxlcmljLmF1Z2VyQHJlZGhhdC5jb20+Ci0t
LQogYmxvY2svbnZtZS5jIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAx
IGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvYmxvY2svbnZtZS5jIGIvYmxvY2svbnZtZS5jCmlu
ZGV4IGM4ZWY2OWNiYjIuLmEwNmExODhkNTMgMTAwNjQ0Ci0tLSBhL2Jsb2NrL252bWUuYworKysg
Yi9ibG9jay9udm1lLmMKQEAgLTQ2OSw3ICs0NjksNyBAQCBzdGF0aWMgdm9pZCBudm1lX3N1Ym1p
dF9jb21tYW5kKE5WTWVRdWV1ZVBhaXIgKnEsIE5WTWVSZXF1ZXN0ICpyZXEsCiAgICAgYXNzZXJ0
KCFyZXEtPmNiKTsKICAgICByZXEtPmNiID0gY2I7CiAgICAgcmVxLT5vcGFxdWUgPSBvcGFxdWU7
Ci0gICAgY21kLT5jaWQgPSBjcHVfdG9fbGUzMihyZXEtPmNpZCk7CisgICAgY21kLT5jaWQgPSBj
cHVfdG9fbGUxNihyZXEtPmNpZCk7CiAKICAgICB0cmFjZV9udm1lX3N1Ym1pdF9jb21tYW5kKHEt
PnMsIHEtPmluZGV4LCByZXEtPmNpZCk7CiAgICAgbnZtZV90cmFjZV9jb21tYW5kKGNtZCk7Ci0t
IAoyLjI4LjAKCg==


