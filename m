Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7189C388F2
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 11:29:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1886F22275
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 11:29:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DZAwy5qs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1886F22275
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVYmR-0005Dv-RZ
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 07:29:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35984)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kVYkv-0003Ye-8p
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 07:27:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:59217)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kVYks-0004xq-2H
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 07:27:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603366055;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=zGZQvHsPVlj60c3v/wA0vdwUvmSME+kzmw1ZHHPBPQA=;
 b=DZAwy5qsZgMdsFlow1VU9CurH8eEJnf3B7gMtlkxQmEEhzlGHZtZjF8U20IlrJ7DvsvmcL
 t96Ll3WX+aOAw1RUuWagghVoQOjTN9dKKFwZJoHSSJXCxKm941FMPF/Mp0TvZuDkvqbkYe
 ESLPjdAcGIZvuC7x2JkTnhpdx2Tk6gU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-284-g-BqfeTGMZyqM7cSndWYgw-1; Thu, 22 Oct 2020 07:27:32 -0400
X-MC-Unique: g-BqfeTGMZyqM7cSndWYgw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3280E186DD3E;
 Thu, 22 Oct 2020 11:27:31 +0000 (UTC)
Received: from localhost (ovpn-114-229.ams2.redhat.com [10.36.114.229])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E647A19C4F;
 Thu, 22 Oct 2020 11:27:27 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL v2 00/28] Block patches
Date: Thu, 22 Oct 2020 12:26:58 +0100
Message-Id: <20201022112726.736757-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/22 06:53:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Coiby Xu <Coiby.Xu@gmail.com>,
 Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

VGhlIGZvbGxvd2luZyBjaGFuZ2VzIHNpbmNlIGNvbW1pdCBhYzc5MzE1NmY2NTBhZTJkNzc4MzQ5
MzJkNzIyMjQxNzVlZTY5MDg2Og0KDQogIE1lcmdlIHJlbW90ZS10cmFja2luZyBicmFuY2ggJ3Jl
bW90ZXMvcG1heWRlbGwvdGFncy9wdWxsLXRhcmdldC1hcm0tMjAyMDEwMjAtMScgaW50byBzdGFn
aW5nICgyMDIwLTEwLTIwIDIxOjExOjM1ICswMTAwKQ0KDQphcmUgYXZhaWxhYmxlIGluIHRoZSBH
aXQgcmVwb3NpdG9yeSBhdDoNCg0KICBodHRwczovL2dpdGxhYi5jb20vc3RlZmFuaGEvcWVtdS5n
aXQgdGFncy9ibG9jay1wdWxsLXJlcXVlc3QNCg0KZm9yIHlvdSB0byBmZXRjaCBjaGFuZ2VzIHVw
IHRvIDMyYTNmZDY1ZTdlMzU1MTMzN2ZkMjZiZmMwZTJmODk5ZDcwYzAyOGM6DQoNCiAgaW90ZXN0
czogYWRkIGNvbW1pdCB0b3AtPmJhc2UgY2FzZXMgdG8gMjc0ICgyMDIwLTEwLTIyIDA5OjU1OjM5
ICswMTAwKQ0KDQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tDQpQdWxsIHJlcXVlc3QNCg0KdjI6DQogKiBGaXggZm9ybWF0IHN0
cmluZyBpc3N1ZXMgb24gMzItYml0IGhvc3RzIFtQZXRlcl0NCiAqIEZpeCBxZW11LW5iZC5jIENP
TkZJR19QT1NJWCBpZmRlZiBpc3N1ZSBbRXJpY10NCiAqIEZpeCBtaXNzaW5nIGV2ZW50ZmQuaCBo
ZWFkZXIgb24gbWFjT1MgW1BldGVyXQ0KICogRHJvcCB1bnJlbGlhYmxlIHZob3N0LXVzZXItYmxr
IHRlc3QgKHdpbGwgc2VuZCBhIG5ldyBwYXRjaCB3aGVuIHJlYWR5KSBbUGV0ZXJdDQoNClRoaXMg
cHVsbCByZXF1ZXN0IGNvbnRhaW5zIHRoZSB2aG9zdC11c2VyLWJsayBzZXJ2ZXIgYnkgQ29pYnkg
WHUgYWxvbmcgd2l0aCBteQ0KYWRkaXRpb25zLCBibG9jay9udm1lLmMgYWxpZ25tZW50IGFuZCBo
YXJkd2FyZSBlcnJvciBzdGF0aXN0aWNzIGJ5IFBoaWxpcHBlDQpNYXRoaWV1LURhdWTDqSwgYW5k
IGJkcnZfY29fYmxvY2tfc3RhdHVzX2Fib3ZlKCkgZml4ZXMgYnkgVmxhZGltaXINClNlbWVudHNv
di1PZ2lldnNraXkuDQoNCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCg0KQ29pYnkgWHUgKDYpOg0KICBsaWJ2aG9zdC11c2Vy
OiBBbGxvdyB2dV9tZXNzYWdlX3JlYWQgdG8gYmUgcmVwbGFjZWQNCiAgbGlidmhvc3QtdXNlcjog
cmVtb3ZlIHdhdGNoIGZvciBraWNrX2ZkIHdoZW4gZGUtaW5pdGlhbGl6ZSB2dS1kZXYNCiAgdXRp
bC92aG9zdC11c2VyLXNlcnZlcjogZ2VuZXJpYyB2aG9zdCB1c2VyIHNlcnZlcg0KICBibG9jazog
bW92ZSBsb2dpY2FsIGJsb2NrIHNpemUgY2hlY2sgZnVuY3Rpb24gdG8gYSBjb21tb24gdXRpbGl0
eQ0KICAgIGZ1bmN0aW9uDQogIGJsb2NrL2V4cG9ydDogdmhvc3QtdXNlciBibG9jayBkZXZpY2Ug
YmFja2VuZCBzZXJ2ZXINCiAgTUFJTlRBSU5FUlM6IEFkZCB2aG9zdC11c2VyIGJsb2NrIGRldmlj
ZSBiYWNrZW5kIHNlcnZlciBtYWludGFpbmVyDQoNClBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpICgx
KToNCiAgYmxvY2svbnZtZTogQWRkIGRyaXZlciBzdGF0aXN0aWNzIGZvciBhY2Nlc3MgYWxpZ25t
ZW50IGFuZCBodyBlcnJvcnMNCg0KU3RlZmFuIEhham5vY3ppICgxNik6DQogIHV0aWwvdmhvc3Qt
dXNlci1zZXJ2ZXI6IHMvZmlsZWRzL2ZpZWxkcy8gdHlwbyBmaXgNCiAgdXRpbC92aG9zdC11c2Vy
LXNlcnZlcjogZHJvcCB1bm5lY2Vzc2FyeSBRT00gY2FzdA0KICB1dGlsL3Zob3N0LXVzZXItc2Vy
dmVyOiBkcm9wIHVubmVjZXNzYXJ5IHdhdGNoIGRlbGV0aW9uDQogIGJsb2NrL2V4cG9ydDogY29u
c29saWRhdGUgcmVxdWVzdCBzdHJ1Y3RzIGludG8gVnVCbG9ja1JlcQ0KICB1dGlsL3Zob3N0LXVz
ZXItc2VydmVyOiBkcm9wIHVudXNlZCBEZXZpY2VQYW5pY05vdGlmaWVyDQogIHV0aWwvdmhvc3Qt
dXNlci1zZXJ2ZXI6IGZpeCBtZW1vcnkgbGVhayBpbiB2dV9tZXNzYWdlX3JlYWQoKQ0KICB1dGls
L3Zob3N0LXVzZXItc2VydmVyOiBjaGVjayBFT0Ygd2hlbiByZWFkaW5nIHBheWxvYWQNCiAgdXRp
bC92aG9zdC11c2VyLXNlcnZlcjogcmV3b3JrIHZ1X2NsaWVudF90cmlwKCkgY29yb3V0aW5lIGxp
ZmVjeWNsZQ0KICBibG9jay9leHBvcnQ6IHJlcG9ydCBmbHVzaCBlcnJvcnMNCiAgYmxvY2svZXhw
b3J0OiBjb252ZXJ0IHZob3N0LXVzZXItYmxrIHNlcnZlciB0byBibG9jayBleHBvcnQgQVBJDQog
IHV0aWwvdmhvc3QtdXNlci1zZXJ2ZXI6IG1vdmUgaGVhZGVyIHRvIGluY2x1ZGUvDQogIHV0aWwv
dmhvc3QtdXNlci1zZXJ2ZXI6IHVzZSBzdGF0aWMgbGlicmFyeSBpbiBtZXNvbi5idWlsZA0KICBx
ZW11LXN0b3JhZ2UtZGFlbW9uOiBhdm9pZCBjb21waWxpbmcgYmxvY2tkZXZfc3MgdHdpY2UNCiAg
YmxvY2s6IG1vdmUgYmxvY2sgZXhwb3J0cyB0byBsaWJibG9ja2Rldg0KICBibG9jay9leHBvcnQ6
IGFkZCBpb3RocmVhZCBhbmQgZml4ZWQtaW90aHJlYWQgb3B0aW9ucw0KICBibG9jay9leHBvcnQ6
IGFkZCB2aG9zdC11c2VyLWJsayBtdWx0aS1xdWV1ZSBzdXBwb3J0DQoNClZsYWRpbWlyIFNlbWVu
dHNvdi1PZ2lldnNraXkgKDUpOg0KICBibG9jay9pbzogZml4IGJkcnZfY29fYmxvY2tfc3RhdHVz
X2Fib3ZlDQogIGJsb2NrL2lvOiBiZHJ2X2NvbW1vbl9ibG9ja19zdGF0dXNfYWJvdmU6IHN1cHBv
cnQgaW5jbHVkZV9iYXNlDQogIGJsb2NrL2lvOiBiZHJ2X2NvbW1vbl9ibG9ja19zdGF0dXNfYWJv
dmU6IHN1cHBvcnQgYnMgPT0gYmFzZQ0KICBibG9jay9pbzogZml4IGJkcnZfaXNfYWxsb2NhdGVk
X2Fib3ZlDQogIGlvdGVzdHM6IGFkZCBjb21taXQgdG9wLT5iYXNlIGNhc2VzIHRvIDI3NA0KDQog
TUFJTlRBSU5FUlMgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICA5ICsNCiBxYXBp
L2Jsb2NrLWNvcmUuanNvbiAgICAgICAgICAgICAgICAgICAgICAgfCAgMjQgKy0NCiBxYXBpL2Js
b2NrLWV4cG9ydC5qc29uICAgICAgICAgICAgICAgICAgICAgfCAgMzYgKy0NCiBibG9jay9jb3Jv
dXRpbmVzLmggICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDIgKw0KIGJsb2NrL2V4cG9ydC92
aG9zdC11c2VyLWJsay1zZXJ2ZXIuaCAgICAgICB8ICAxOSArDQogY29udHJpYi9saWJ2aG9zdC11
c2VyL2xpYnZob3N0LXVzZXIuaCAgICAgIHwgIDIxICsNCiBpbmNsdWRlL3FlbXUvdmhvc3QtdXNl
ci1zZXJ2ZXIuaCAgICAgICAgICAgfCAgNjUgKysrDQogdXRpbC9ibG9jay1oZWxwZXJzLmggICAg
ICAgICAgICAgICAgICAgICAgIHwgIDE5ICsNCiBibG9jay9leHBvcnQvZXhwb3J0LmMgICAgICAg
ICAgICAgICAgICAgICAgfCAgMzcgKy0NCiBibG9jay9leHBvcnQvdmhvc3QtdXNlci1ibGstc2Vy
dmVyLmMgICAgICAgfCA0MzEgKysrKysrKysrKysrKysrKysrKysNCiBibG9jay9pby5jICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAxMzIgKysrLS0tDQogYmxvY2svbnZtZS5jICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDI3ICsrDQogYmxvY2svcWNvdzIuYyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDE2ICstDQogY29udHJpYi9saWJ2aG9zdC11c2Vy
L2xpYnZob3N0LXVzZXItZ2xpYi5jIHwgICAyICstDQogY29udHJpYi9saWJ2aG9zdC11c2VyL2xp
YnZob3N0LXVzZXIuYyAgICAgIHwgIDE1ICstDQogaHcvY29yZS9xZGV2LXByb3BlcnRpZXMtc3lz
dGVtLmMgICAgICAgICAgIHwgIDMxICstDQogbmJkL3NlcnZlci5jICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHwgICAyIC0NCiBxZW11LW5iZC5jICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgfCAgMjEgKy0NCiBzb2Z0bW11L3ZsLmMgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgfCAgIDQgKw0KIHN0dWJzL2Jsay1leHAtY2xvc2UtYWxsLmMgICAgICAgICAgICAgICAg
ICB8ICAgNyArDQogdGVzdHMvdmhvc3QtdXNlci1icmlkZ2UuYyAgICAgICAgICAgICAgICAgIHwg
ICAyICsNCiB0b29scy92aXJ0aW9mc2QvZnVzZV92aXJ0aW8uYyAgICAgICAgICAgICAgfCAgIDQg
Ky0NCiB1dGlsL2Jsb2NrLWhlbHBlcnMuYyAgICAgICAgICAgICAgICAgICAgICAgfCAgNDYgKysr
DQogdXRpbC92aG9zdC11c2VyLXNlcnZlci5jICAgICAgICAgICAgICAgICAgIHwgNDQ2ICsrKysr
KysrKysrKysrKysrKysrKw0KIGJsb2NrL2V4cG9ydC9tZXNvbi5idWlsZCAgICAgICAgICAgICAg
ICAgICB8ICAgMyArLQ0KIGNvbnRyaWIvbGlidmhvc3QtdXNlci9tZXNvbi5idWlsZCAgICAgICAg
ICB8ICAgMSArDQogbWVzb24uYnVpbGQgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwg
IDIyICstDQogbmJkL21lc29uLmJ1aWxkICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAy
ICsNCiBzdG9yYWdlLWRhZW1vbi9tZXNvbi5idWlsZCAgICAgICAgICAgICAgICAgfCAgIDMgKy0N
CiBzdHVicy9tZXNvbi5idWlsZCAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDEgKw0KIHRl
c3RzL3FlbXUtaW90ZXN0cy8yNzQgICAgICAgICAgICAgICAgICAgICB8ICAyMCArDQogdGVzdHMv
cWVtdS1pb3Rlc3RzLzI3NC5vdXQgICAgICAgICAgICAgICAgIHwgIDY4ICsrKysNCiB1dGlsL21l
c29uLmJ1aWxkICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDQgKw0KIDMzIGZpbGVzIGNo
YW5nZWQsIDE0MjAgaW5zZXJ0aW9ucygrKSwgMTIyIGRlbGV0aW9ucygtKQ0KIGNyZWF0ZSBtb2Rl
IDEwMDY0NCBibG9jay9leHBvcnQvdmhvc3QtdXNlci1ibGstc2VydmVyLmgNCiBjcmVhdGUgbW9k
ZSAxMDA2NDQgaW5jbHVkZS9xZW11L3Zob3N0LXVzZXItc2VydmVyLmgNCiBjcmVhdGUgbW9kZSAx
MDA2NDQgdXRpbC9ibG9jay1oZWxwZXJzLmgNCiBjcmVhdGUgbW9kZSAxMDA2NDQgYmxvY2svZXhw
b3J0L3Zob3N0LXVzZXItYmxrLXNlcnZlci5jDQogY3JlYXRlIG1vZGUgMTAwNjQ0IHN0dWJzL2Js
ay1leHAtY2xvc2UtYWxsLmMNCiBjcmVhdGUgbW9kZSAxMDA2NDQgdXRpbC9ibG9jay1oZWxwZXJz
LmMNCiBjcmVhdGUgbW9kZSAxMDA2NDQgdXRpbC92aG9zdC11c2VyLXNlcnZlci5jDQoNCi0tIA0K
Mi4yNi4yDQoNCg==


