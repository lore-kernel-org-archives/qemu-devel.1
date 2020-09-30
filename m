Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C556BC4727F
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 10:19:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EE61206CA
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 10:19:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f3bD8+KL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EE61206CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52394 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNZCi-0002OQ-4h
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 06:19:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43754)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kNZ7O-0003Ki-Ej
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 06:13:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35742)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kNZ7M-00062c-Sl
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 06:13:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601460827;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/A55R2WoegzbUoq+dJ4dhgyorYPVr1bngJXOEeKTN2w=;
 b=f3bD8+KLwYHYErW6QaG20X4sMCQbxsID4C9PTPoypWUQCM05RblGo+DtKNqXc3vFqzYt8Z
 30HV4M5QE6LjOYHGfBNZMWuvpusY3tfjsgKV0A0SnjivZojAKB8oHiDVHUvoV3s6OX0vt7
 vUEv/VkLDZ13YQtHJVtijhSfjy4LTYA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-37-6i_AGRoNM4u3PdZ1yucq2A-1; Wed, 30 Sep 2020 06:13:42 -0400
X-MC-Unique: 6i_AGRoNM4u3PdZ1yucq2A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 45E18801AE8;
 Wed, 30 Sep 2020 10:13:41 +0000 (UTC)
Received: from localhost (ovpn-114-33.ams2.redhat.com [10.36.114.33])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C864573678;
 Wed, 30 Sep 2020 10:13:34 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PULL 06/17] block/nvme: Replace magic value by SCALE_MS definition
Date: Wed, 30 Sep 2020 11:12:54 +0100
Message-Id: <20200930101305.305302-7-stefanha@redhat.com>
In-Reply-To: <20200930101305.305302-1-stefanha@redhat.com>
References: <20200930101305.305302-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=216.205.24.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 00:26:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

RnJvbTogUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEByZWRoYXQuY29tPgoKVXNlIHNl
bGYtZXhwbGljaXQgU0NBTEVfTVMgZGVmaW5pdGlvbiBpbnN0ZWFkIG9mIG1hZ2ljIHZhbHVlCiht
aXNzZWQgaW4gc2ltaWxhciBjb21taXQgZTRmMzEwZmU3ZjUpLgoKU2lnbmVkLW9mZi1ieTogUGhp
bGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEByZWRoYXQuY29tPgpTaWduZWQtb2ZmLWJ5OiBT
dGVmYW4gSGFqbm9jemkgPHN0ZWZhbmhhQHJlZGhhdC5jb20+Ck1lc3NhZ2UtSWQ6IDwyMDIwMDky
MjA4MzgyMS41Nzg1MTktNy1waGlsbWRAcmVkaGF0LmNvbT4KLS0tCiBibG9jay9udm1lLmMgfCAy
ICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYg
LS1naXQgYS9ibG9jay9udm1lLmMgYi9ibG9jay9udm1lLmMKaW5kZXggOTU5NTY5ZDI2Mi4uYjQ4
ZjZmMjU4OCAxMDA2NDQKLS0tIGEvYmxvY2svbnZtZS5jCisrKyBiL2Jsb2NrL252bWUuYwpAQCAt
NzcyLDcgKzc3Miw3IEBAIHN0YXRpYyBpbnQgbnZtZV9pbml0KEJsb2NrRHJpdmVyU3RhdGUgKmJz
LCBjb25zdCBjaGFyICpkZXZpY2UsIGludCBuYW1lc3BhY2UsCiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBDQ19FTl9NQVNLKTsKICAgICAvKiBXYWl0IGZvciBDU1RTLlJEWSA9IDEuICovCiAg
ICAgbm93ID0gcWVtdV9jbG9ja19nZXRfbnMoUUVNVV9DTE9DS19SRUFMVElNRSk7Ci0gICAgZGVh
ZGxpbmUgPSBub3cgKyB0aW1lb3V0X21zICogMTAwMDAwMDsKKyAgICBkZWFkbGluZSA9IG5vdyAr
IHRpbWVvdXRfbXMgKiBTQ0FMRV9NUzsKICAgICB3aGlsZSAoIU5WTUVfQ1NUU19SRFkobGUzMl90
b19jcHUocmVncy0+Y3N0cykpKSB7CiAgICAgICAgIGlmIChxZW11X2Nsb2NrX2dldF9ucyhRRU1V
X0NMT0NLX1JFQUxUSU1FKSA+IGRlYWRsaW5lKSB7CiAgICAgICAgICAgICBlcnJvcl9zZXRnKGVy
cnAsICJUaW1lb3V0IHdoaWxlIHdhaXRpbmcgZm9yIGRldmljZSB0byBzdGFydCAoJSIKLS0gCjIu
MjYuMgoK


