Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19DDCC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 12:09:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB594208B8
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 12:09:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dGfIq5M2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB594208B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37556 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmFpV-0007sg-47
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 08:09:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51168)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jmFhz-0004jK-Hs
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 08:01:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52080
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jmFhx-0006cE-FG
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 08:01:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592568080;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tfmkb6e98JMf1G+0GulfEcJaJRrZZtju2ljHAav9YU0=;
 b=dGfIq5M2ZA3dYGyc6g76c22V/w3WYw5Q8CEEKHKREZM6K9PH05Sfwlg1dBBQUkPtOuU0bV
 EfwsZseGCJ9XOGwvrPi4sSNt9e2qdcsZjF7Lwu82CIE5vo17vd+G1rSWA2id58XZCloICi
 sVccxEmB8rE9N6o6DtWvfhQWhG0ydvY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-418-dKShk33kOqyeldXC1dElDw-1; Fri, 19 Jun 2020 08:01:18 -0400
X-MC-Unique: dKShk33kOqyeldXC1dElDw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D0F46464;
 Fri, 19 Jun 2020 12:01:17 +0000 (UTC)
Received: from localhost (ovpn-113-212.ams2.redhat.com [10.36.113.212])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 65F3C5D9CA;
 Fri, 19 Jun 2020 12:01:17 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Coiby Xu <coiby.xu@gmail.com>
Subject: [PATCH 6/6] vhost-user-server: use DevicePanicNotifierFn everywhere
Date: Fri, 19 Jun 2020 13:00:46 +0100
Message-Id: <20200619120046.2422205-6-stefanha@redhat.com>
In-Reply-To: <20200619120046.2422205-1-stefanha@redhat.com>
References: <20200614183907.514282-3-coiby.xu@gmail.com>
 <20200619120046.2422205-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=205.139.110.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/19 05:19:18
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MIME_BASE64_TEXT=1.741, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
Cc: kwolf@redhat.com, bharatlkmlkvm@gmail.com, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

VXNlIHRoZSBEZXZpY2VQYW5pY05vdGlmaWVyRm4gdHlwZWRlZiBpbnN0ZWFkIG9mIG9wZW4tY29k
aW5nIHRoZQpmdW5jdGlvbiBwb2ludGVyLiBXcml0aW5nIHRoZSBjb2RlIHRoaXMgd2F5IGF2b2lk
cyBkdXBsaWNhdGluZyB0aGUKZnVuY3Rpb24gcHJvdG90eXBlLgoKQWxzbyB1c2UgdGhlIFZ1U2Vy
dmVyIHR5cGVkZWYgaW5zdGVhZCBvZiBzdHJ1Y3QgVnVTZXJ2ZXIgYXMgcmVxdWlyZWQgYnkKUUVN
VSdzIGNvZGluZyBzdHlsZS4KClNpZ25lZC1vZmYtYnk6IFN0ZWZhbiBIYWpub2N6aSA8c3RlZmFu
aGFAcmVkaGF0LmNvbT4KLS0tCiB1dGlsL3Zob3N0LXVzZXItc2VydmVyLmggfCAxMiArKysrKyst
LS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pCgpk
aWZmIC0tZ2l0IGEvdXRpbC92aG9zdC11c2VyLXNlcnZlci5oIGIvdXRpbC92aG9zdC11c2VyLXNl
cnZlci5oCmluZGV4IDU4NGFhYjNkYTUuLjM3YWNhMWU1YWEgMTAwNjQ0Ci0tLSBhL3V0aWwvdmhv
c3QtdXNlci1zZXJ2ZXIuaAorKysgYi91dGlsL3Zob3N0LXVzZXItc2VydmVyLmgKQEAgLTI1LDEw
ICsyNSwxMyBAQCB0eXBlZGVmIHN0cnVjdCBLaWNrSW5mbyB7CiAgICAgdnVfd2F0Y2hfY2IgY2I7
CiB9IEtpY2tJbmZvOwogCi10eXBlZGVmIHN0cnVjdCBWdVNlcnZlciB7Cit0eXBlZGVmIHN0cnVj
dCBWdVNlcnZlciBWdVNlcnZlcjsKK3R5cGVkZWYgdm9pZCBEZXZpY2VQYW5pY05vdGlmaWVyRm4o
VnVTZXJ2ZXIgKnNlcnZlcik7CisKK3N0cnVjdCBWdVNlcnZlciB7CiAgICAgUUlPTmV0TGlzdGVu
ZXIgKmxpc3RlbmVyOwogICAgIEFpb0NvbnRleHQgKmN0eDsKLSAgICB2b2lkICgqZGV2aWNlX3Bh
bmljX25vdGlmaWVyKShzdHJ1Y3QgVnVTZXJ2ZXIgKnNlcnZlcikgOworICAgIERldmljZVBhbmlj
Tm90aWZpZXJGbiAqZGV2aWNlX3BhbmljX25vdGlmaWVyOwogICAgIGludCBtYXhfcXVldWVzOwog
ICAgIGNvbnN0IFZ1RGV2SWZhY2UgKnZ1X2lmYWNlOwogICAgIFZ1RGV2IHZ1X2RldjsKQEAgLTQx
LDEwICs0NCw3IEBAIHR5cGVkZWYgc3RydWN0IFZ1U2VydmVyIHsKICAgICBLaWNrSW5mbyAqa2lj
a19pbmZvOyAvKiBhbiBhcnJheSB3aXRoIHRoZSBsZW5ndGggb2YgdGhlIHF1ZXVlIG51bWJlciAq
LwogICAgIC8qIHJlc3RhcnQgY29yb3V0aW5lIGNvX3RyaXAgaWYgQUlPQ29udGV4dCBpcyBjaGFu
Z2VkICovCiAgICAgYm9vbCBhaW9fY29udGV4dF9jaGFuZ2VkOwotfSBWdVNlcnZlcjsKLQotCi10
eXBlZGVmIHZvaWQgRGV2aWNlUGFuaWNOb3RpZmllckZuKHN0cnVjdCBWdVNlcnZlciAqc2VydmVy
KTsKK307CiAKIGJvb2wgdmhvc3RfdXNlcl9zZXJ2ZXJfc3RhcnQoVnVTZXJ2ZXIgKnNlcnZlciwK
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgU29ja2V0QWRkcmVzcyAqdW5peF9zb2NrZXQs
Ci0tIAoyLjI2LjIKCg==


