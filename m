Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CD52C433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 10:30:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFF96208B8
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 10:30:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K3Mp8yFI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFF96208B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdtKY-0008Fb-Mo
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 06:30:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55814)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jdtJc-0006m5-TU
 for qemu-devel@nongnu.org; Wed, 27 May 2020 06:29:40 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:40821
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jdtJb-0000zw-AQ
 for qemu-devel@nongnu.org; Wed, 27 May 2020 06:29:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590575377;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=CEYSJmVzTNIYluSOttOVKcndsZi4ILRg3ku5sStIvc0=;
 b=K3Mp8yFImUj4a0THSCG4835abg1ut9FqenqJiTm9gt28Qmeq5LRXvdeMUlnsmbiTzlTK8t
 MH0CnhqltVQP5E2xOIDFae+VyyWLL6VT04OEuy1eG8Zd1iu3r4t5JukBwVi8wBUzzeiDHm
 sIt+TXDvZVSt/boqBtD6lrrOcxi4ozg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-286-EkIdHvXsM4-0usgXR7RhvA-1; Wed, 27 May 2020 06:29:33 -0400
X-MC-Unique: EkIdHvXsM4-0usgXR7RhvA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 68EFA8005AA;
 Wed, 27 May 2020 10:29:32 +0000 (UTC)
Received: from localhost (ovpn-114-250.ams2.redhat.com [10.36.114.250])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 574DB5C1B0;
 Wed, 27 May 2020 10:29:26 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 0/5] virtio-pci: enable blk and scsi multi-queue by default
Date: Wed, 27 May 2020 11:29:20 +0100
Message-Id: <20200527102925.128013-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=205.139.110.61; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/27 05:46:19
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
Cc: Kevin Wolf <kwolf@redhat.com>, Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, cohuck@redhat.com,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

djM6DQogKiBJbnRyb2R1Y2UgdmlydGlvX3BjaV9vcHRpbWFsX251bV9xdWV1ZXMoKSBoZWxwZXIg
dG8gZW5mb3JjZSBWSVJUSU9fUVVFVUVfTUFYDQogICBpbiBvbmUgcGxhY2UNCiAqIFVzZSBWSVJU
SU9fU0NTSV9WUV9OVU1fRklYRUQgY29uc3RhbnQgaW4gYWxsIGNhc2VzIFtDb3JuZWxpYV0NCiAq
IFVwZGF0ZSBody9jb3JlL21hY2hpbmUuYyBjb21wYXQgcHJvcGVydGllcyBmb3IgUUVNVSA1LjAg
W01pY2hhZWxdDQp2MzoNCiAqIEFkZCBuZXcgcGVyZm9ybWFuY2UgcmVzdWx0cyB0aGF0IGRlbW9u
c3RyYXRlIHRoZSBzY2FsYWJpbGl0eQ0KICogTWVudGlvbiB0aGF0IHRoaXMgaXMgUENJLXNwZWNp
ZmljIFtDb3JuZWxpYV0NCnYyOg0KICogTGV0IHRoZSB2aXJ0aW8tREVWSUNFLXBjaSBkZXZpY2Ug
c2VsZWN0IG51bS1xdWV1ZXMgYmVjYXVzZSB0aGUgb3B0aW1hbA0KICAgbXVsdGktcXVldWUgY29u
ZmlndXJhdGlvbiBtYXkgZGlmZmVyIGJldHdlZW4gdmlydGlvLXBjaSwgdmlydGlvLW1taW8sIGFu
ZA0KICAgdmlydGlvLWNjdyBbQ29ybmVsaWFdDQoNCkVuYWJsaW5nIG11bHRpLXF1ZXVlIG9uIHZp
cnRpby1wY2kgc3RvcmFnZSBkZXZpY2VzIGltcHJvdmVzIHBlcmZvcm1hbmNlIG9uIFNNUA0KZ3Vl
c3RzIGJlY2F1c2UgdGhlIGNvbXBsZXRpb24gaW50ZXJydXB0IGlzIGhhbmRsZWQgb24gdGhlIHZD
UFUgdGhhdCBzdWJtaXR0ZWQNCnRoZSBJL08gcmVxdWVzdC4gIFRoaXMgYXZvaWRzIElQSXMgaW5z
aWRlIHRoZSBndWVzdC4NCg0KTm90ZSB0aGF0IHBlcmZvcm1hbmNlIGlzIHVuY2hhbmdlZCBpbiB0
aGVzZSBjYXNlczoNCjEuIFVuaXByb2Nlc3NvciBndWVzdHMuICBUaGV5IGRvbid0IGhhdmUgSVBJ
cy4NCjIuIEFwcGxpY2F0aW9uIHRocmVhZHMgbWlnaHQgYmUgc2NoZWR1bGVkIG9uIHRoZSBzb2xl
IHZDUFUgdGhhdCBoYW5kbGVzDQogICBjb21wbGV0aW9uIGludGVycnVwdHMgcHVyZWx5IGJ5IGNo
YW5jZS4gIChUaGlzIGlzIG9uZSByZWFzb24gd2h5IGJlbmNobWFyaw0KICAgcmVzdWx0cyBjYW4g
dmFyeSBub3RpY2FibHkgYmV0d2VlbiBydW5zLikNCjMuIFVzZXJzIG1heSBiaW5kIHRoZSBhcHBs
aWNhdGlvbiB0byB0aGUgdkNQVSB0aGF0IGhhbmRsZXMgY29tcGxldGlvbg0KICAgaW50ZXJydXB0
cy4NCg0KU2V0IHRoZSBudW1iZXIgb2YgcXVldWVzIHRvIHRoZSBudW1iZXIgb2YgdkNQVXMgYnkg
ZGVmYXVsdCBvbiB2aXJ0aW8tYmxrIGFuZA0KdmlydGlvLXNjc2kgUENJIGRldmljZXMuICBPbGRl
ciBtYWNoaW5lIHR5cGVzIGNvbnRpbnVlIHRvIGRlZmF1bHQgdG8gMSBxdWV1ZQ0KZm9yIGxpdmUg
bWlncmF0aW9uIGNvbXBhdGliaWxpdHkuDQoNClJhbmRvbSByZWFkIHBlcmZvcm1hbmNlOg0KICAg
ICAgSU9QUw0KcT0xICAgIDc4aw0KcT0zMiAgMTA0ayAgKzMzJQ0KDQpCb290IHRpbWU6DQogICAg
ICBEdXJhdGlvbg0KcT0xICAgICAgICA1MXMNCnE9MzIgICAgIDFtNDFzICArOTglDQoNCkd1ZXN0
IGNvbmZpZ3VyYXRpb246IDMyIHZDUFVzLCAxMDEgdmlydGlvLWJsay1wY2kgZGlza3MNCg0KUHJl
dmlvdXNseSBtZWFzdXJlZCByZXN1bHRzIG9uIGEgNCB2Q1BVIGd1ZXN0IHdlcmUgYWxzbyBwb3Np
dGl2ZSBidXQgc2hvd2VkIGENCnNtYWxsZXIgMS00JSBwZXJmb3JtYW5jZSBpbXByb3ZlbWVudC4g
IFRoZXkgYXJlIG5vIGxvbmdlciB2YWxpZCBiZWNhdXNlDQpzaWduaWZpY2FudCBldmVudCBsb29w
IG9wdGltaXphdGlvbnMgaGF2ZSBiZWVuIG1lcmdlZC4NCg0KU3RlZmFuIEhham5vY3ppICg1KToN
CiAgdmlydGlvLXBjaTogYWRkIHZpcnRpb19wY2lfb3B0aW1hbF9udW1fcXVldWVzKCkgaGVscGVy
DQogIHZpcnRpby1zY3NpOiBpbnRyb2R1Y2UgYSBjb25zdGFudCBmb3IgZml4ZWQgdmlydHF1ZXVl
cw0KICB2aXJ0aW8tc2NzaTogZGVmYXVsdCBudW1fcXVldWVzIHRvIC1zbXAgTg0KICB2aXJ0aW8t
YmxrOiBkZWZhdWx0IG51bV9xdWV1ZXMgdG8gLXNtcCBODQogIHZob3N0LXVzZXItYmxrOiBkZWZh
dWx0IG51bV9xdWV1ZXMgdG8gLXNtcCBODQoNCiBody92aXJ0aW8vdmlydGlvLXBjaS5oICAgICAg
ICAgICAgIHwgIDkgKysrKysrKysrDQogaW5jbHVkZS9ody92aXJ0aW8vdmhvc3QtdXNlci1ibGsu
aCB8ICAyICsrDQogaW5jbHVkZS9ody92aXJ0aW8vdmlydGlvLWJsay5oICAgICB8ICAyICsrDQog
aW5jbHVkZS9ody92aXJ0aW8vdmlydGlvLXNjc2kuaCAgICB8ICA1ICsrKysrDQogaHcvYmxvY2sv
dmhvc3QtdXNlci1ibGsuYyAgICAgICAgICB8ICA2ICsrKysrLQ0KIGh3L2Jsb2NrL3ZpcnRpby1i
bGsuYyAgICAgICAgICAgICAgfCAgNiArKysrKy0NCiBody9jb3JlL21hY2hpbmUuYyAgICAgICAg
ICAgICAgICAgIHwgIDggKysrKysrKy0NCiBody9zY3NpL3Zob3N0LXNjc2kuYyAgICAgICAgICAg
ICAgIHwgIDMgKystDQogaHcvc2NzaS92aG9zdC11c2VyLXNjc2kuYyAgICAgICAgICB8ICA1ICsr
Ky0tDQogaHcvc2NzaS92aXJ0aW8tc2NzaS5jICAgICAgICAgICAgICB8IDEzICsrKysrKysrKy0t
LS0NCiBody92aXJ0aW8vdmhvc3Qtc2NzaS1wY2kuYyAgICAgICAgIHwgIDkgKysrKysrKy0tDQog
aHcvdmlydGlvL3Zob3N0LXVzZXItYmxrLXBjaS5jICAgICB8ICA0ICsrKysNCiBody92aXJ0aW8v
dmhvc3QtdXNlci1zY3NpLXBjaS5jICAgIHwgIDkgKysrKysrKy0tDQogaHcvdmlydGlvL3ZpcnRp
by1ibGstcGNpLmMgICAgICAgICB8ICA3ICsrKysrKy0NCiBody92aXJ0aW8vdmlydGlvLXBjaS5j
ICAgICAgICAgICAgIHwgIDcgKysrKysrKw0KIGh3L3ZpcnRpby92aXJ0aW8tc2NzaS1wY2kuYyAg
ICAgICAgfCAgOSArKysrKysrLS0NCiAxNiBmaWxlcyBjaGFuZ2VkLCA4NyBpbnNlcnRpb25zKCsp
LCAxNyBkZWxldGlvbnMoLSkNCg0KLS0gDQoyLjI1LjQNCg0K


