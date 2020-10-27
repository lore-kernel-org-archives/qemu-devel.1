Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54911C55179
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 17:37:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96F7C2068D
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 17:37:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e9zyN4cm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96F7C2068D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXSuc-0006qj-HQ
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 13:37:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41330)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kXSt2-0005Eq-D6
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 13:35:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:30823)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kXSsz-0003Cv-Be
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 13:35:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603820152;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=f+L2aCyA9GfwtcVWRDGciGhPz9jHG8g9WOW0iydMLc4=;
 b=e9zyN4cmUdq19ElI9LdhpD/WBGUSHaUrelux7ogC2MuGwzMdtyrOk55m7vyMd8CVmtFMMe
 /QmlqajgHs5szx90+z0FT4/c4fRV/J1ZcgbtIHpUcClYFYiExXv5DHeGUzRURoSs8K5pK0
 hiMZvODIdxzgCMjoSwFXz2va9nLOMQE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-478-nnYagcysNjS5gPwzAEAkEw-1; Tue, 27 Oct 2020 13:35:50 -0400
X-MC-Unique: nnYagcysNjS5gPwzAEAkEw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 251DB873112;
 Tue, 27 Oct 2020 17:35:49 +0000 (UTC)
Received: from localhost (ovpn-115-166.ams2.redhat.com [10.36.115.166])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EADC96EF50;
 Tue, 27 Oct 2020 17:35:29 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 00/12] block/export: vhost-user-blk server cleanups and tests
Date: Tue, 27 Oct 2020 17:35:16 +0000
Message-Id: <20201027173528.213464-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 01:06:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Laurent Vivier <lvivier@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Coiby Xu <coiby.xu@gmail.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

VGhpcyBwYXRjaCBzZXJpZXMgc29sdmVzIHNvbWUgaXNzdWVzIHdpdGggdGhlIG5ldyB2aG9zdC11
c2VyLWJsay1zZXJ2ZXIgYW5kDQphZGRzIHRoZSBxdGVzdCB0ZXN0IGNhc2UuIFRoZSB0ZXN0IGNh
c2Ugd2FzIG5vdCBpbmNsdWRlZCBpbiB0aGUgcHVsbCByZXF1ZXN0DQp0aGF0IGludHJvZHVjZWQg
dGhlIHZob3N0LXVzZXItYmxrIHNlcnZlciBiZWNhdXNlIG9mIHJlbGlhYmlsaXR5IGlzc3VlcyB0
aGF0DQphcmUgZml4ZWQgaW4gdGhpcyBwYXRjaCBzZXJpZXMuDQoNCkNvaWJ5IFh1ICgxKToNCiAg
dGVzdDogbmV3IHFUZXN0IGNhc2UgdG8gdGVzdCB0aGUgdmhvc3QtdXNlci1ibGstc2VydmVyDQoN
ClN0ZWZhbiBIYWpub2N6aSAoMTEpOg0KICBsaWJ2aG9zdC11c2VyOiBmb2xsb3cgUUVNVSBjb21t
ZW50IHN0eWxlDQogIGNvbmZpZ3VyZTogaW50cm9kdWNlIC0tZW5hYmxlLXZob3N0LXVzZXItYmxr
LXNlcnZlcg0KICBibG9jay9leHBvcnQ6IG1ha2Ugdmhvc3QtdXNlci1ibGsgY29uZmlnIHNwYWNl
IGxpdHRsZS1lbmRpYW4NCiAgYmxvY2svZXhwb3J0OiBmaXggdmhvc3QtdXNlci1ibGsgZ2V0X2Nv
bmZpZygpIGluZm9ybWF0aW9uIGxlYWsNCiAgY29udHJpYi92aG9zdC11c2VyLWJsazogZml4IGdl
dF9jb25maWcoKSBpbmZvcm1hdGlvbiBsZWFrDQogIHRlc3RzL3F0ZXN0OiBhZGQgbXVsdGktcXVl
dWUgdGVzdCBjYXNlIHRvIHZob3N0LXVzZXItYmxrLXRlc3QNCiAgbGlicXRlc3Q6IGFkZCBxdGVz
dF9zb2NrZXRfc2VydmVyKCkNCiAgdmhvc3QtdXNlci1ibGstdGVzdDogcmVuYW1lIGRlc3Ryb3lf
ZHJpdmUoKSB0byBkZXN0cm95X2ZpbGUoKQ0KICB2aG9zdC11c2VyLWJsay10ZXN0OiBjbG9zZSBm
b3JrIGNoaWxkIGZpbGUgZGVzY3JpcHRvcnMNCiAgdmhvc3QtdXNlci1ibGstdGVzdDogZHJvcCB1
bnVzZWQgcmV0dXJuIHZhbHVlDQogIHZob3N0LXVzZXItYmxrLXRlc3Q6IGZpeCByYWNlcyBieSB1
c2luZyBmZCBwYXNzaW5nDQoNCiBjb25maWd1cmUgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgfCAgMTUgKw0KIGNvbnRyaWIvbGlidmhvc3QtdXNlci9saWJ2aG9zdC11c2VyLmggICB8ICAx
NSArLQ0KIHRlc3RzL3F0ZXN0L2xpYnFvcy9saWJxdGVzdC5oICAgICAgICAgICB8ICAyNSArDQog
dGVzdHMvcXRlc3QvbGlicW9zL3Zob3N0LXVzZXItYmxrLmggICAgIHwgIDQ4ICsrDQogYmxvY2sv
ZXhwb3J0L2V4cG9ydC5jICAgICAgICAgICAgICAgICAgIHwgICA0ICstDQogYmxvY2svZXhwb3J0
L3Zob3N0LXVzZXItYmxrLXNlcnZlci5jICAgIHwgIDI4ICstDQogY29udHJpYi92aG9zdC11c2Vy
LWJsay92aG9zdC11c2VyLWJsay5jIHwgICAyICsNCiB0ZXN0cy9xdGVzdC9saWJxb3Mvdmhvc3Qt
dXNlci1ibGsuYyAgICAgfCAxMjkgKysrKw0KIHRlc3RzL3F0ZXN0L2xpYnF0ZXN0LmMgICAgICAg
ICAgICAgICAgICB8ICA3NiArKy0NCiB0ZXN0cy9xdGVzdC92aG9zdC11c2VyLWJsay10ZXN0LmMg
ICAgICAgfCA4NDMgKysrKysrKysrKysrKysrKysrKysrKysrDQogYmxvY2svZXhwb3J0L21lc29u
LmJ1aWxkICAgICAgICAgICAgICAgIHwgICAyICstDQogdGVzdHMvcXRlc3QvbGlicW9zL21lc29u
LmJ1aWxkICAgICAgICAgIHwgICAxICsNCiB0ZXN0cy9xdGVzdC9tZXNvbi5idWlsZCAgICAgICAg
ICAgICAgICAgfCAgIDIgKw0KIHV0aWwvbWVzb24uYnVpbGQgICAgICAgICAgICAgICAgICAgICAg
ICB8ICAgMiArLQ0KIDE0IGZpbGVzIGNoYW5nZWQsIDExNTEgaW5zZXJ0aW9ucygrKSwgNDEgZGVs
ZXRpb25zKC0pDQogY3JlYXRlIG1vZGUgMTAwNjQ0IHRlc3RzL3F0ZXN0L2xpYnFvcy92aG9zdC11
c2VyLWJsay5oDQogY3JlYXRlIG1vZGUgMTAwNjQ0IHRlc3RzL3F0ZXN0L2xpYnFvcy92aG9zdC11
c2VyLWJsay5jDQogY3JlYXRlIG1vZGUgMTAwNjQ0IHRlc3RzL3F0ZXN0L3Zob3N0LXVzZXItYmxr
LXRlc3QuYw0KDQotLSANCjIuMjYuMg0KDQo=


