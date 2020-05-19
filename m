Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0A57C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 17:14:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A273820709
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 17:14:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NYnC+b1s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A273820709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49586 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jb5or-0006xh-Ls
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 13:14:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34112)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jb5mS-0002mG-2u
 for qemu-devel@nongnu.org; Tue, 19 May 2020 13:11:52 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56833
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jb5mR-0002Ss-7b
 for qemu-devel@nongnu.org; Tue, 19 May 2020 13:11:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589908310;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=O9LXJ6jm8JE9UNEKl3DOYcno5mV/ygzy8yQu2DFqXYM=;
 b=NYnC+b1sbEfOzbtD1JWOhBqDICP2zwPK+V4D3RofuO1ISzriqmGOh1R2s2oDVrHfu52mox
 qgDjdKVeLAqqcjHxs6Uhb0lAguB0g0Kx4pZLQF6b6sczCvjmaBXdtAr7dKQF1AGWmonSSM
 e8M523CoA/3CSLCNtrjAsmQ2hMdlljo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-430-aLS5Hp4sN5aFIb4DtGff7Q-1; Tue, 19 May 2020 13:11:46 -0400
X-MC-Unique: aLS5Hp4sN5aFIb4DtGff7Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 81D1B464;
 Tue, 19 May 2020 17:11:43 +0000 (UTC)
Received: from localhost (ovpn-114-215.ams2.redhat.com [10.36.114.215])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2BF8B50F54;
 Tue, 19 May 2020 17:11:39 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/7] block/nvme: support nested aio_poll()
Date: Tue, 19 May 2020 18:11:31 +0100
Message-Id: <20200519171138.201667-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=205.139.110.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/18 23:56:10
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

VGhpcyBzZXJpZXMgYWxsb3dzIGFpb19wb2xsKCkgdG8gd29yayBmcm9tIEkvTyByZXF1ZXN0IGNv
bXBsZXRpb24gY2FsbGJhY2tzLg0KUUVNVSBibG9jayBkcml2ZXJzIGFyZSBzdXBwb3NlZCB0byBz
dXBwb3J0IHRoaXMgYmVjYXVzZSBzb21lIGNvZGUgcGF0aHMgcmVseSBvbg0KdGhpcyBiZWhhdmlv
ci4NCg0KVGhlcmUgd2FzIG5vIG1lYXN1cmFibGUgcGVyZm9ybWFuY2UgZGlmZmVyZW5jZSB3aXRo
IG5lc3RlZCBhaW9fcG9sbCgpIHN1cHBvcnQuDQoNClRoaXMgcGF0Y2ggc2VyaWVzIGFsc28gY29u
dGFpbnMgY2xlYW51cHMgdGhhdCBJIG1hZGUgd2hpbGUgZXhhbWluaW5nIGFuZA0KYmVuY2htYXJr
aW5nIHRoZSBjb2RlLg0KDQpTdGVmYW4gSGFqbm9jemkgKDcpOg0KICBibG9jay9udm1lOiBwb2xs
IHF1ZXVlcyB3aXRob3V0IHEtPmxvY2sNCiAgYmxvY2svbnZtZTogZHJvcCB0YXV0b2xvZ291cyBh
c3NlcnRpb24NCiAgYmxvY2svbnZtZTogZG9uJ3QgYWNjZXNzIENRRSBhZnRlciBtb3ZpbmcgY3Eu
aGVhZA0KICBibG9jay9udm1lOiBzd2l0Y2ggdG8gYSBOVk1lUmVxdWVzdCBmcmVlbGlzdA0KICBi
bG9jay9udm1lOiBjbGFyaWZ5IHRoYXQgZnJlZV9yZXFfcXVldWUgaXMgcHJvdGVjdGVkIGJ5IHEt
PmxvY2sNCiAgYmxvY2svbnZtZToga2VlcCBCRFJWTlZNZVN0YXRlIHBvaW50ZXIgaW4gTlZNZVF1
ZXVlUGFpcg0KICBibG9jay9udm1lOiBzdXBwb3J0IG5lc3RlZCBhaW9fcG9sbCgpDQoNCiBibG9j
ay9udm1lLmMgICAgICAgfCAyMjAgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0t
LS0tLS0tLS0tDQogYmxvY2svdHJhY2UtZXZlbnRzIHwgICAyICstDQogMiBmaWxlcyBjaGFuZ2Vk
LCAxNjAgaW5zZXJ0aW9ucygrKSwgNjIgZGVsZXRpb25zKC0pDQoNCi0tIA0KMi4yNS4zDQoNCg==


