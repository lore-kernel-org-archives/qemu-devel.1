Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CE58C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 17:18:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0CAC20738
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 17:18:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X5TcNEmn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0CAC20738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jcBJp-0006MX-Vj
	for qemu-devel@archiver.kernel.org; Fri, 22 May 2020 13:18:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46728)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jcBIq-0004gN-Vt
 for qemu-devel@nongnu.org; Fri, 22 May 2020 13:17:49 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:31993
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jcBIq-0000cp-6F
 for qemu-devel@nongnu.org; Fri, 22 May 2020 13:17:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590167866;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=rnItJaMZOHNnjwOtY4eic8pZnCXSgtkp9xzqUdB9E1g=;
 b=X5TcNEmnHv2TIaqOhn+bhKAC+vn27enM16Nn/8VyIc55rKQ30BL4Mh3Bdr8ijiuKvpibbx
 0+OtO4c5Cqta7zVH2yUSYdZHzgDza8IIQ5T1zFkyDixGhavroZY78j+DCUljJRqud14/2p
 d526WgS3m1AZQkQDAbklEbxICleSrhc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-428-BctzOgEUPwqeC1yHu6-dxA-1; Fri, 22 May 2020 13:17:42 -0400
X-MC-Unique: BctzOgEUPwqeC1yHu6-dxA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DF04E460;
 Fri, 22 May 2020 17:17:40 +0000 (UTC)
Received: from localhost (ovpn-112-243.ams2.redhat.com [10.36.112.243])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7361F1059584;
 Fri, 22 May 2020 17:17:28 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/5] virtio: enable VIRTIO_F_RING_PACKED for all devices
Date: Fri, 22 May 2020 18:17:21 +0100
Message-Id: <20200522171726.648279-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=205.139.110.61; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/22 11:11:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 jasowang@redhat.com, cohuck@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 "Gonglei \(Arei\)" <arei.gonglei@huawei.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Fam Zheng <fam@euphon.net>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

VGhlIFZJUlRJTyAxLjEgcGFja2VkIHZpcnRxdWV1ZSBsYXlvdXQgaW1wcm92ZXMgcGVyZm9ybWFu
Y2UgYW5kIGd1ZXN0IGRyaXZlcg0Kc3VwcG9ydCBoYXMgYmVlbiBhdmFpbGFibGUgc2luY2UgTGlu
dXggdjUuMC4gdmlydGlvLWJsayBiZW5jaG1hcmtzIHNob3cgaXQgaXMNCmJlbmVmaWNpYWwgZm9y
IG5vbi1uZXQgZGV2aWNlcyB0b28gc28gSSB3cm90ZSBwYXRjaGVzIHRvIGVuYWJsZSBpdCBmb3Ig
YWxsDQpkZXZpY2VzLg0KDQpJdCB0dXJuZWQgb3V0IHRvIGJlIHRyaWNraWVyIHRoYW4gSSBleHBl
Y3RlZCBiZWNhdXNlIHZob3N0IGZlYXR1cmUgbmVnb3RpYXRpb24NCmlzIGN1cnJlbnRseSBub3Qg
cmVhZHkgZm9yIG5ldyB2aXJ0cXVldWUgZmVhdHVyZSBiaXRzIGxpa2UNClZJUlRJT19GX1JJTkdf
UEFDS0VELiBQYXRjaGVzIDItNCBzb2x2ZSB0aGlzLg0KDQpQYXRjaCA1IHRoZW4gZW5hYmxlcyBw
YWNrZWQgdmlydHF1ZXVlcy4NCg0KU3RlZmFuIEhham5vY3ppICg1KToNCiAgdGVzdHMvbGlicW9z
OiBtYXNrIG91dCBWSVJUSU9fRl9SSU5HX1BBQ0tFRCBmb3Igbm93DQogIHZob3N0OiBpbnZvbHZl
IGRldmljZSBiYWNrZW5kcyBpbiBmZWF0dXJlIG5lZ290aWF0aW9uDQogIHZob3N0LXVzZXItYmxr
OiBhZGQgVklSVElPX0ZfUklOR19QQUNLRUQgZmVhdHVyZSBiaXQNCiAgdmhvc3Qtc2NzaTogYWRk
IFZJUlRJT19GX1ZFUlNJT05fMSBhbmQgVklSVElPX0ZfUklOR19QQUNLRUQNCiAgdmlydGlvOiBl
bmFibGUgVklSVElPX0ZfUklOR19QQUNLRUQgZm9yIGFsbCBkZXZpY2VzDQoNCiBpbmNsdWRlL2h3
L3ZpcnRpby92aG9zdC5oICAgICAgICB8ICAxICsNCiBpbmNsdWRlL2h3L3ZpcnRpby92aXJ0aW8t
Z3B1LmggICB8ICAyICsrDQogaW5jbHVkZS9ody92aXJ0aW8vdmlydGlvLmggICAgICAgfCAgMiAr
LQ0KIGluY2x1ZGUvc3lzZW11L2NyeXB0b2Rldi12aG9zdC5oIHwgMTEgKysrKysrKysrKysNCiBi
YWNrZW5kcy9jcnlwdG9kZXYtdmhvc3QuYyAgICAgICB8IDE5ICsrKysrKysrKysrKysrKysrKysN
CiBody9ibG9jay92aG9zdC11c2VyLWJsay5jICAgICAgICB8ICAxICsNCiBody9jb3JlL21hY2hp
bmUuYyAgICAgICAgICAgICAgICB8IDE4ICsrKysrKysrKysrKysrKysrLQ0KIGh3L2Rpc3BsYXkv
dmhvc3QtdXNlci1ncHUuYyAgICAgIHwgMTcgKysrKysrKysrKysrKysrKysNCiBody9kaXNwbGF5
L3ZpcnRpby1ncHUtYmFzZS5jICAgICB8ICAyICstDQogaHcvaW5wdXQvdmhvc3QtdXNlci1pbnB1
dC5jICAgICAgfCAgOSArKysrKysrKysNCiBody9zY3NpL3Zob3N0LXNjc2kuYyAgICAgICAgICAg
ICB8ICAyICsrDQogaHcvc2NzaS92aG9zdC11c2VyLXNjc2kuYyAgICAgICAgfCAgMiArKw0KIGh3
L3ZpcnRpby92aG9zdC11c2VyLWZzLmMgICAgICAgIHwgIDUgKysrLS0NCiBody92aXJ0aW8vdmhv
c3QtdnNvY2suYyAgICAgICAgICB8ICA1ICsrKy0tDQogaHcvdmlydGlvL3Zob3N0LmMgICAgICAg
ICAgICAgICAgfCAyMiArKysrKysrKysrKysrKysrKysrKysrDQogaHcvdmlydGlvL3ZpcnRpby1j
cnlwdG8uYyAgICAgICAgfCAgMyArKy0NCiB0ZXN0cy9xdGVzdC9saWJxb3MvdmlydGlvLmMgICAg
ICB8ICAzICsrLQ0KIDE3IGZpbGVzIGNoYW5nZWQsIDExNSBpbnNlcnRpb25zKCspLCA5IGRlbGV0
aW9ucygtKQ0KDQotLSANCjIuMjUuMw0KDQo=


