Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28D45C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 17:24:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E883820774
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 17:24:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BlDORSuM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E883820774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jihzS-0002Vx-6i
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 13:24:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51776)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jihec-0004Kc-NB
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 13:03:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30875
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jiheb-0007aQ-NT
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 13:03:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591722192;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TkQ44PTxX2eS9NNAe6MLYdIuw4/KeDlhn5YNPr177VY=;
 b=BlDORSuMGV844JKEHfmxUuxqv+iUJUJuhur3pMBtARCGlm8C+aZnQEKlVdAEg3G/d64rn3
 XGvjWABKlgPcj20YvS0crSWwAzp2prQMjjhoZQ5jcdXnRXTY4WUHv2zfd9wRNfTlgn6V5G
 bG2kohnJd1jtS6zvs//RKp03KVN70oc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-294-9LnoJ3V8PnSPE46RUhlCJA-1; Tue, 09 Jun 2020 13:03:11 -0400
X-MC-Unique: 9LnoJ3V8PnSPE46RUhlCJA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D433A107ACF4;
 Tue,  9 Jun 2020 17:03:09 +0000 (UTC)
Received: from localhost (ovpn-115-52.ams2.redhat.com [10.36.115.52])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 83D8F5D9E4;
 Tue,  9 Jun 2020 17:02:58 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 3/7] docs: document non-net VHOST_USER_GET_FEATURES behavior
Date: Tue,  9 Jun 2020 18:02:14 +0100
Message-Id: <20200609170218.246468-4-stefanha@redhat.com>
In-Reply-To: <20200609170218.246468-1-stefanha@redhat.com>
References: <20200609170218.246468-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=205.139.110.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 02:44:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MIME_BASE64_TEXT=1.741, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, jasowang@redhat.com, cohuck@redhat.com,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Ben Walker <benjamin.walker@intel.com>,
 "Gonglei \(Arei\)" <arei.gonglei@huawei.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Sebastien Boeuf <sebastien.boeuf@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UUVNVSBlbmFibGVkIHNldmVyYWwgZmVhdHVyZSBiaXRzIGZvciBub24tbmV0IGRldmljZXMgd2l0
aG91dCBhbGxvd2luZwp0aGUgZGV2aWNlIGJhY2tlbmQgdG8gY29udHJvbCB0aGVtLiBUaGlzIG9u
bHkgd29ya3Mgd2hlbiB0aGUgZGV2aWNlCmJhY2tlbmQgaW1wbGVtZW50cyBzdXBwb3J0IGZvciB0
aG9zZSBmZWF0dXJlcy4gSXQgd29uJ3Qgd29yayBmb3IgbmV3CmZlYXR1cmVzIGxpa2UgdGhlIHBh
Y2tlZCB2aXJ0cXVldWUgbGF5b3V0LCB3aGVyZSBwcm9wZXIgZmVhdHVyZQpuZWdvdGlhdGlvbiB3
aWxsIGJlIG5lZWRlZC4KCkRvY3VtZW50IHRoZSBsZWdhY3kgYmVoYXZpb3IgYW5kIHNwZWNpZnkg
dGhhdCBkZXZpY2UgYmFja2VuZHMgbXVzdApyZXBvcnQgZmVhdHVyZXMgc28gdGhhdCB3ZSBjYW4g
YXZvaWQgcHJvYmxlbXMgaW4gdGhlIGZ1dHVyZS4KCkNjOiBCZW4gV2Fsa2VyIDxiZW5qYW1pbi53
YWxrZXJAaW50ZWwuY29tPgpDYzogU2ViYXN0aWVuIEJvZXVmIDxzZWJhc3RpZW4uYm9ldWZAaW50
ZWwuY29tPgpTaWduZWQtb2ZmLWJ5OiBTdGVmYW4gSGFqbm9jemkgPHN0ZWZhbmhhQHJlZGhhdC5j
b20+Ci0tLQpDQ2luZyBTUERLIGFuZCBjbG91ZC1oeXBlcnZpc29yIGZvbGtzIGluIGNhc2UgdGhl
eSBhcmUgYWZmZWN0ZWQuIERQREsKaXNuJ3QgYWZmZWN0ZWQgc2luY2Ugdmhvc3QtdXNlci1uZXQg
cGVyZm9ybXMgZnVsbCBmZWF0dXJlIG5lZ290aWF0aW9uLgotLS0KIGRvY3MvaW50ZXJvcC92aG9z
dC11c2VyLnJzdCB8IDIxICsrKysrKysrKysrKysrKysrKysrKwogMSBmaWxlIGNoYW5nZWQsIDIx
IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9kb2NzL2ludGVyb3Avdmhvc3QtdXNlci5yc3Qg
Yi9kb2NzL2ludGVyb3Avdmhvc3QtdXNlci5yc3QKaW5kZXggM2IxYjY2MDJjNy4uZGZhZGVlNDEx
ZCAxMDA2NDQKLS0tIGEvZG9jcy9pbnRlcm9wL3Zob3N0LXVzZXIucnN0CisrKyBiL2RvY3MvaW50
ZXJvcC92aG9zdC11c2VyLnJzdApAQCAtMjkwLDYgKzI5MCwyNyBAQCBiaXQgd2FzIGRlZGljYXRl
ZCBmb3IgdGhpcyBwdXJwb3NlOjoKIAogICAjZGVmaW5lIFZIT1NUX1VTRVJfRl9QUk9UT0NPTF9G
RUFUVVJFUyAzMAogCitGZWF0dXJlIG5lZ290aWF0aW9uCistLS0tLS0tLS0tLS0tLS0tLS0tCitU
aGUgbWFzdGVyIGZldGNoZXMgZmVhdHVyZXMgZnJvbSB0aGUgYmFja2VuZCB1c2luZyB0aGUKK2Bg
VkhPU1RfVVNFUl9HRVRfRkVBVFVSRVNgYCBtZXNzYWdlLiBUaGUgZmVhdHVyZSBiaXRzIGNvcnJl
c3BvbmQgdG8gdGhvc2UgZnJvbQordGhlIHZpcnRpbyBzcGVjaWZpY2F0aW9uLCBWSE9TVF9GX0xP
R19BTEwgKDI2KSwgYW5kCitgYFZIT1NUX1VTRVJfRl9QUk9UT0NPTF9GRUFUVVJFU2BgICgzMCku
CisKK0JhY2tlbmRzIG11c3QgcmVwb3J0IGFsbCBzdXBwb3J0ZWQgZmVhdHVyZSBiaXRzLiBJZiBh
IGZlYXR1cmUgYml0IGlzIHNldCB0aGVuCit0aGUgbWFzdGVyIG1heSBzZXQgaXQgaW4gdGhlIGBg
VkhPU1RfVVNFUl9TRVRfRkVBVFVSRVNgYCBtZXNzYWdlLiBJZiBhIGZlYXR1cmUKK2JpdCBpcyBj
bGVhcmVkIHRoZW4gdGhlIG1hc3RlciBtdXN0IG5vdCBzZXQgaXQgaW4gdGhlCitgYFZIT1NUX1VT
RVJfU0VUX0ZFQVRVUkVTYGAgbWVzc2FnZS4KKworRm9yIGRldmljZXMgb3RoZXIgdGhhbiB0aGUg
bmV0d29ya2luZyBkZXZpY2UsIG1hc3RlcnMgbWF5IGFzc3VtZSB0aGUgZm9sbG93aW5nCitmZWF0
dXJlIGJpdHMgYXJlIGFsd2F5cyBzZXQgaW4gYGBWSE9TVF9VU0VSX0dFVF9GRUFUVVJFU2BgIGZv
ciBjb21wYXRpYmlsaXR5Cit3aXRoIGxlZ2FjeSBiYWNrZW5kIGltcGxlbWVudGF0aW9ucyB0aGF0
IGRvIG5vdCByZXBvcnQgdGhlbSBjb3JyZWN0bHk6CisqIGBgVklSVElPX0ZfUklOR19JTkRJUkVD
VF9ERVNDYGAKKyogYGBWSVJUSU9fRl9SSU5HX0VWRU5UX0lEWGBgCisqIGBgVklSVElPX0ZfVkVS
U0lPTl8xYGAKKyogYGBWSVJUSU9fRl9OT1RJRllfT05fRU1QVFlgYAorKiBgYFZJUlRJT19GX0FO
WV9MQVlPVVRgYAorCiBTdGFydGluZyBhbmQgc3RvcHBpbmcgcmluZ3MKIC0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLQogCi0tIAoyLjI2LjIKCg==


