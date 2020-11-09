Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2151EC2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 17:59:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9989E20665
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 17:59:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T/3KDEjI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9989E20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kcBS1-0007WR-Kx
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 12:59:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42216)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kcBD7-0005qo-33
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 12:44:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:40872)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kcBD5-0002Dc-2x
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 12:44:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604943846;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=4HKnjMevd+nRs52G0Nuu3zrCgW4gQKmlKEyCNxRzAy0=;
 b=T/3KDEjIbexarrxpLBOhU0wZVzu/BEgBUbcGIekFsyQpcusJPQ7l+hDAnBFLQbGlUxBqV9
 HbvH+wofNsMofS/ESR4ZM6PXqEJg0nhqFr2G0r0b4joYweXo2olcqmtPjr8lAlhAo0zqYU
 ysnTN1JOBd5jWrF4P1ly4pY9/I4XMhU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-426-GL3j7vqINYO34O3W5Q9qDw-1; Mon, 09 Nov 2020 12:44:04 -0500
X-MC-Unique: GL3j7vqINYO34O3W5Q9qDw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 885CD1084C89;
 Mon,  9 Nov 2020 17:44:03 +0000 (UTC)
Received: from localhost (ovpn-114-110.ams2.redhat.com [10.36.114.110])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BD4AC614F5;
 Mon,  9 Nov 2020 17:43:56 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH for-5.2] vhost-user: fix VHOST_USER_ADD/REM_MEM_REG truncation
Date: Mon,  9 Nov 2020 17:43:55 +0000
Message-Id: <20201109174355.1069147-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/09 01:25:23
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MIME_BASE64_TEXT=1.741, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Cornelia Huck <cohuck@redhat.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UUVNVSBjdXJyZW50bHkgdHJ1bmNhdGVzIHRoZSBtbWFwX29mZnNldCBmaWVsZCB3aGVuIHNlbmRp
bmcKVkhPU1RfVVNFUl9BRERfTUVNX1JFRyBhbmQgVkhPU1RfVVNFUl9SRU1fTUVNX1JFRyBtZXNz
YWdlcy4gVGhlIHN0cnVjdApsYXlvdXQgbG9va3MgbGlrZSB0aGlzOgoKICB0eXBlZGVmIHN0cnVj
dCBWaG9zdFVzZXJNZW1vcnlSZWdpb24gewogICAgICB1aW50NjRfdCBndWVzdF9waHlzX2FkZHI7
CiAgICAgIHVpbnQ2NF90IG1lbW9yeV9zaXplOwogICAgICB1aW50NjRfdCB1c2Vyc3BhY2VfYWRk
cjsKICAgICAgdWludDY0X3QgbW1hcF9vZmZzZXQ7CiAgfSBWaG9zdFVzZXJNZW1vcnlSZWdpb247
CgogIHR5cGVkZWYgc3RydWN0IFZob3N0VXNlck1lbVJlZ01zZyB7CiAgICAgIHVpbnQzMl90IHBh
ZGRpbmc7CiAgICAgIC8qIFdBUk5JTkc6IHRoZXJlIGlzIGEgMzItYml0IGhvbGUgaGVyZSEgKi8K
ICAgICAgVmhvc3RVc2VyTWVtb3J5UmVnaW9uIHJlZ2lvbjsKICB9IFZob3N0VXNlck1lbVJlZ01z
ZzsKClRoZSBwYXlsb2FkIHNpemUgaXMgY2FsY3VsYXRlZCBhcyBmb2xsb3dzIHdoZW4gc2VuZGlu
ZyB0aGUgbWVzc2FnZSBpbgpody92aXJ0aW8vdmhvc3QtdXNlci5jOgoKICBtc2ctPmhkci5zaXpl
ID0gc2l6ZW9mKG1zZy0+cGF5bG9hZC5tZW1fcmVnLnBhZGRpbmcpICsKICAgICAgc2l6ZW9mKFZo
b3N0VXNlck1lbW9yeVJlZ2lvbik7CgpUaGlzIGNhbGN1bGF0aW9uIHByb2R1Y2VzIGFuIGluY29y
cmVjdCByZXN1bHQgb2Ygb25seSAzNiBieXRlcy4Kc2l6ZW9mKFZob3N0VXNlck1lbVJlZ01zZykg
aXMgYWN0dWFsbHkgNDAgYnl0ZXMuCgpUaGUgY29uc2VxdWVuY2Ugb2YgdGhpcyBpcyB0aGF0IHRo
ZSBmaW5hbCBmaWVsZCwgbW1hcF9vZmZzZXQsIGlzCnRydW5jYXRlZC4gVGhpcyBicmVha3MgeDg2
XzY0IFRDRyBndWVzdHMgb24gczM5MCBob3N0cy4gT3RoZXIgZ3Vlc3QvaG9zdApjb21iaW5hdGlv
bnMgbWF5IGdldCBsdWNreSBpZiBlaXRoZXIgb2YgdGhlIGZvbGxvd2luZyBob2xkczoKMS4gVGhl
IGd1ZXN0IG1lbW9yeSBsYXlvdXQgZG9lcyBub3QgbmVlZCBtbWFwX29mZnNldCAhPSAwLgoyLiBU
aGUgaG9zdCBpcyBsaXR0bGUtZW5kaWFuIGFuZCBtbWFwX29mZnNldCA8PSAweGZmZmZmZmZmIHNv
IHRoZQogICB0cnVuY2F0aW9uIGhhcyBubyBlZmZlY3QuCgpGaXggdGhpcyBieSBleHRlbmRpbmcg
dGhlIGV4aXN0aW5nIDMyLWJpdCBwYWRkaW5nIGZpZWxkIHRvIDY0LWJpdC4gTm93CnRoZSBwYWRk
aW5nIHJlZmxlY3RzIHRoZSBhY3R1YWwgY29tcGlsZXIgcGFkZGluZy4gVGhpcyBjYW4gYmUgdmVy
aWZpZWQKdXNpbmcgcGFob2xlKDEpLgoKQWxzbyBkb2N1bWVudCB0aGUgbGF5b3V0IHByb3Blcmx5
IGluIHRoZSB2aG9zdC11c2VyIHNwZWNpZmljYXRpb24uICBUaGUKdmhvc3QtdXNlciBzcGVjIGRp
ZCBub3QgZG9jdW1lbnQgdGhlIGV4YWN0IGxheW91dC4gSXQgd291bGQgYmUKaW1wb3NzaWJsZSB0
byBpbXBsZW1lbnQgdGhlIHNwZWMgd2l0aG91dCBsb29raW5nIGF0IHRoZSBRRU1VIHNvdXJjZQpj
b2RlLgoKRXhpc3Rpbmcgdmhvc3QtdXNlciBmcm9udGVuZHMgYW5kIGRldmljZSBiYWNrZW5kcyBj
b250aW51ZSB0byB3b3JrIGFmdGVyCnRoaXMgZml4IGhhcyBiZWVuIGFwcGxpZWQuIFRoZSBvbmx5
IGNoYW5nZSBpbiB0aGUgd2lyZSBwcm90b2NvbCBpcyB0aGF0ClFFTVUgbm93IHNldHMgaGRyLnNp
emUgdG8gNDAgaW5zdGVhZCBvZiAzNi4gSWYgYSB2aG9zdC11c2VyCmltcGxlbWVudGF0aW9uIGhh
cyBhIGhhcmRjb2RlZCBzaXplIGNoZWNrIGZvciAzNiBieXRlcywgdGhlbiBpdCB3aWxsCmZhaWwg
d2l0aCBuZXcgUUVNVXMuIEJvdGggUUVNVSBhbmQgRFBESy9TUERLIGRvbid0IGNoZWNrIHRoZSBl
eGFjdApwYXlsb2FkIHNpemUsIHNvIHRoZXkgY29udGludWUgdG8gd29yay4KCkZpeGVzOiBmMWFl
YjE0YjA4MDllMzEzYzc0MjQ0ZDgzODY0NWVkMjVlODVlYTYzICgiVHJhbnNtaXQgdmhvc3QtdXNl
ciBtZW1vcnkgcmVnaW9ucyBpbmRpdmlkdWFsbHkiKQpDYzogUmFwaGFlbCBOb3J3aXR6IDxyYXBo
YWVsLm5vcndpdHpAbnV0YW5peC5jb20+CkNjOiBDb3JuZWxpYSBIdWNrIDxjb2h1Y2tAcmVkaGF0
LmNvbT4KQ2M6IE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+CkNjOiBDaHJpc3Rp
YW4gQm9ybnRyYWVnZXIgPGJvcm50cmFlZ2VyQGRlLmlibS5jb20+ClNpZ25lZC1vZmYtYnk6IFN0
ZWZhbiBIYWpub2N6aSA8c3RlZmFuaGFAcmVkaGF0LmNvbT4KLS0tCiBkb2NzL2ludGVyb3Avdmhv
c3QtdXNlci5yc3QgICAgICAgICAgIHwgMjEgKysrKysrKysrKysrKysrKysrKy0tCiBjb250cmli
L2xpYnZob3N0LXVzZXIvbGlidmhvc3QtdXNlci5oIHwgIDIgKy0KIGh3L3ZpcnRpby92aG9zdC11
c2VyLmMgICAgICAgICAgICAgICAgfCAgNSArKy0tLQogMyBmaWxlcyBjaGFuZ2VkLCAyMiBpbnNl
cnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RvY3MvaW50ZXJvcC92aG9z
dC11c2VyLnJzdCBiL2RvY3MvaW50ZXJvcC92aG9zdC11c2VyLnJzdAppbmRleCA5ODhmMTU0MTQ0
Li42ZDQwMjViYTZhIDEwMDY0NAotLS0gYS9kb2NzL2ludGVyb3Avdmhvc3QtdXNlci5yc3QKKysr
IGIvZG9jcy9pbnRlcm9wL3Zob3N0LXVzZXIucnN0CkBAIC0xMzEsNiArMTMxLDIzIEBAIEEgcmVn
aW9uIGlzOgogCiA6bW1hcCBvZmZzZXQ6IDY0LWJpdCBvZmZzZXQgd2hlcmUgcmVnaW9uIHN0YXJ0
cyBpbiB0aGUgbWFwcGVkIG1lbW9yeQogCitTaW5nbGUgbWVtb3J5IHJlZ2lvbiBkZXNjcmlwdGlv
bgorXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl4KKworKy0tLS0tLS0tLSstLS0tLS0t
LS0tLS0tLS0rLS0tLS0tKy0tLS0tLS0tLS0tLS0tKy0tLS0tLS0tLS0tLS0rCit8IHBhZGRpbmcg
fCBndWVzdCBhZGRyZXNzIHwgc2l6ZSB8IHVzZXIgYWRkcmVzcyB8IG1tYXAgb2Zmc2V0IHwKKyst
LS0tLS0tLS0rLS0tLS0tLS0tLS0tLS0tKy0tLS0tLSstLS0tLS0tLS0tLS0tLSstLS0tLS0tLS0t
LS0tKworCis6cGFkZGluZzogNjQtYml0CisKKzpndWVzdCBhZGRyZXNzOiBhIDY0LWJpdCBndWVz
dCBhZGRyZXNzIG9mIHRoZSByZWdpb24KKworOnNpemU6IGEgNjQtYml0IHNpemUKKworOnVzZXIg
YWRkcmVzczogYSA2NC1iaXQgdXNlciBhZGRyZXNzCisKKzptbWFwIG9mZnNldDogNjQtYml0IG9m
ZnNldCB3aGVyZSByZWdpb24gc3RhcnRzIGluIHRoZSBtYXBwZWQgbWVtb3J5CisKIExvZyBkZXNj
cmlwdGlvbgogXl5eXl5eXl5eXl5eXl5eCiAKQEAgLTEyODEsNyArMTI5OCw3IEBAIE1hc3RlciBt
ZXNzYWdlIHR5cGVzCiBgYFZIT1NUX1VTRVJfQUREX01FTV9SRUdgYAogICA6aWQ6IDM3CiAgIDpl
cXVpdmFsZW50IGlvY3RsOiBOL0EKLSAgOnNsYXZlIHBheWxvYWQ6IG1lbW9yeSByZWdpb24KKyAg
OnNsYXZlIHBheWxvYWQ6IHNpbmdsZSBtZW1vcnkgcmVnaW9uIGRlc2NyaXB0aW9uCiAKICAgV2hl
biB0aGUgYGBWSE9TVF9VU0VSX1BST1RPQ09MX0ZfQ09ORklHVVJFX01FTV9TTE9UU2BgIHByb3Rv
Y29sCiAgIGZlYXR1cmUgaGFzIGJlZW4gc3VjY2Vzc2Z1bGx5IG5lZ290aWF0ZWQsIHRoaXMgbWVz
c2FnZSBpcyBzdWJtaXR0ZWQKQEAgLTEyOTYsNyArMTMxMyw3IEBAIE1hc3RlciBtZXNzYWdlIHR5
cGVzCiBgYFZIT1NUX1VTRVJfUkVNX01FTV9SRUdgYAogICA6aWQ6IDM4CiAgIDplcXVpdmFsZW50
IGlvY3RsOiBOL0EKLSAgOnNsYXZlIHBheWxvYWQ6IG1lbW9yeSByZWdpb24KKyAgOnNsYXZlIHBh
eWxvYWQ6IHNpbmdsZSBtZW1vcnkgcmVnaW9uIGRlc2NyaXB0aW9uCiAKICAgV2hlbiB0aGUgYGBW
SE9TVF9VU0VSX1BST1RPQ09MX0ZfQ09ORklHVVJFX01FTV9TTE9UU2BgIHByb3RvY29sCiAgIGZl
YXR1cmUgaGFzIGJlZW4gc3VjY2Vzc2Z1bGx5IG5lZ290aWF0ZWQsIHRoaXMgbWVzc2FnZSBpcyBz
dWJtaXR0ZWQKZGlmZiAtLWdpdCBhL2NvbnRyaWIvbGlidmhvc3QtdXNlci9saWJ2aG9zdC11c2Vy
LmggYi9jb250cmliL2xpYnZob3N0LXVzZXIvbGlidmhvc3QtdXNlci5oCmluZGV4IGExNTM5ZGJi
NjkuLjdkNDdmMTM2NGEgMTAwNjQ0Ci0tLSBhL2NvbnRyaWIvbGlidmhvc3QtdXNlci9saWJ2aG9z
dC11c2VyLmgKKysrIGIvY29udHJpYi9saWJ2aG9zdC11c2VyL2xpYnZob3N0LXVzZXIuaApAQCAt
MTM2LDcgKzEzNiw3IEBAIHR5cGVkZWYgc3RydWN0IFZob3N0VXNlck1lbW9yeSB7CiB9IFZob3N0
VXNlck1lbW9yeTsKIAogdHlwZWRlZiBzdHJ1Y3QgVmhvc3RVc2VyTWVtUmVnTXNnIHsKLSAgICB1
aW50MzJfdCBwYWRkaW5nOworICAgIHVpbnQ2NF90IHBhZGRpbmc7CiAgICAgVmhvc3RVc2VyTWVt
b3J5UmVnaW9uIHJlZ2lvbjsKIH0gVmhvc3RVc2VyTWVtUmVnTXNnOwogCmRpZmYgLS1naXQgYS9o
dy92aXJ0aW8vdmhvc3QtdXNlci5jIGIvaHcvdmlydGlvL3Zob3N0LXVzZXIuYwppbmRleCA5YzVi
NGY3ZmJjLi4yZmRkNWRhZjc0IDEwMDY0NAotLS0gYS9ody92aXJ0aW8vdmhvc3QtdXNlci5jCisr
KyBiL2h3L3ZpcnRpby92aG9zdC11c2VyLmMKQEAgLTE0OSw3ICsxNDksNyBAQCB0eXBlZGVmIHN0
cnVjdCBWaG9zdFVzZXJNZW1vcnkgewogfSBWaG9zdFVzZXJNZW1vcnk7CiAKIHR5cGVkZWYgc3Ry
dWN0IFZob3N0VXNlck1lbVJlZ01zZyB7Ci0gICAgdWludDMyX3QgcGFkZGluZzsKKyAgICB1aW50
NjRfdCBwYWRkaW5nOwogICAgIFZob3N0VXNlck1lbW9yeVJlZ2lvbiByZWdpb247CiB9IFZob3N0
VXNlck1lbVJlZ01zZzsKIApAQCAtODAwLDggKzgwMCw3IEBAIHN0YXRpYyBpbnQgdmhvc3RfdXNl
cl9hZGRfcmVtb3ZlX3JlZ2lvbnMoc3RydWN0IHZob3N0X2RldiAqZGV2LAogICAgIHVpbnQ2NF90
IHNoYWRvd19wY2JbVkhPU1RfVVNFUl9NQVhfUkFNX1NMT1RTXSA9IHt9OwogICAgIGludCBucl9h
ZGRfcmVnLCBucl9yZW1fcmVnOwogCi0gICAgbXNnLT5oZHIuc2l6ZSA9IHNpemVvZihtc2ctPnBh
eWxvYWQubWVtX3JlZy5wYWRkaW5nKSArCi0gICAgICAgIHNpemVvZihWaG9zdFVzZXJNZW1vcnlS
ZWdpb24pOworICAgIG1zZy0+aGRyLnNpemUgPSBzaXplb2YobXNnLT5wYXlsb2FkLm1lbV9yZWcp
OwogCiAgICAgLyogRmluZCB0aGUgcmVnaW9ucyB3aGljaCBuZWVkIHRvIGJlIHJlbW92ZWQgb3Ig
YWRkZWQuICovCiAgICAgc2NydWJfc2hhZG93X3JlZ2lvbnMoZGV2LCBhZGRfcmVnLCAmbnJfYWRk
X3JlZywgcmVtX3JlZywgJm5yX3JlbV9yZWcsCi0tIAoyLjI4LjAKCg==


