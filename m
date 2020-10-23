Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BC8DC4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 15:26:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE7A721D47
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 15:26:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VsYoWNgN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE7A721D47
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36010 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVyxq-0001qh-JC
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 11:26:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58052)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kVytF-0004cb-F7
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 11:22:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49751)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kVytB-0000Yv-Sl
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 11:22:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603466517;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=qyQokd3B8PJ7KwiadYgF2AhDDrWjlZwZrsYDfCrjjuI=;
 b=VsYoWNgNfdfWP1iTwYv8BLlrmDUAE0tchYy2vS//sgOnEc68k2xM4byCs1wtZtKntEKJUb
 vTD8vW3BrqWhgygLv3IQ7gPNLFu7kmjONLbGjKLONMALcXT32dIJXBr7WQZrdP5ZiwU7R3
 6JcTLF6f3+2TQgeeSXiTtHZpF4XTNWk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-105-UviqaUWHP7qBS5GcCyaNXQ-1; Fri, 23 Oct 2020 11:21:53 -0400
X-MC-Unique: UviqaUWHP7qBS5GcCyaNXQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0CDCB1020900;
 Fri, 23 Oct 2020 15:21:52 +0000 (UTC)
Received: from localhost (ovpn-114-178.ams2.redhat.com [10.36.114.178])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 752835B4AC;
 Fri, 23 Oct 2020 15:21:48 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL v3 00/28] Block patches
Date: Fri, 23 Oct 2020 16:21:19 +0100
Message-Id: <20201023152147.1016281-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=216.205.24.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 01:44:00
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Coiby Xu <Coiby.Xu@gmail.com>,
 Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

VGhlIGZvbGxvd2luZyBjaGFuZ2VzIHNpbmNlIGNvbW1pdCA0YzViOTdiZmQwZGQ1NGRjMjc3MTdh
ZThkMWNkMTBlMTRlZWYxNDMwOg0KDQogIE1lcmdlIHJlbW90ZS10cmFja2luZyBicmFuY2ggJ3Jl
bW90ZXMva3JheGVsL3RhZ3MvbW9kdWxlcy0yMDIwMTAyMi1wdWxsLXJlcXVlc3QnIGludG8gc3Rh
Z2luZyAoMjAyMC0xMC0yMiAxMjozMzoyMSArMDEwMCkNCg0KYXJlIGF2YWlsYWJsZSBpbiB0aGUg
R2l0IHJlcG9zaXRvcnkgYXQ6DQoNCiAgaHR0cHM6Ly9naXRsYWIuY29tL3N0ZWZhbmhhL3FlbXUu
Z2l0IHRhZ3MvYmxvY2stcHVsbC1yZXF1ZXN0DQoNCmZvciB5b3UgdG8gZmV0Y2ggY2hhbmdlcyB1
cCB0byA0ZjE5MzE2OGFmMDk3ZWY2NjQyODdmNGM4MDE3MjRmMDYzYTYwZmMyOg0KDQogIGlvdGVz
dHM6IGFkZCBjb21taXQgdG9wLT5iYXNlIGNhc2VzIHRvIDI3NCAoMjAyMC0xMC0yMyAxMzo0Mjox
NiArMDEwMCkNCg0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLQ0KUHVsbCByZXF1ZXN0DQoNCnYzOg0KICogRml4IGxpbmtlciBl
cnJvciBvbiBGcmVlQlNEIGFuZCBvdGhlciAhQ09ORklHX0xJTlVYIGhvc3QgT1NlcyBbUGV0ZXJd
DQoNCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0NCg0KQ29pYnkgWHUgKDYpOg0KICBsaWJ2aG9zdC11c2VyOiBBbGxvdyB2dV9t
ZXNzYWdlX3JlYWQgdG8gYmUgcmVwbGFjZWQNCiAgbGlidmhvc3QtdXNlcjogcmVtb3ZlIHdhdGNo
IGZvciBraWNrX2ZkIHdoZW4gZGUtaW5pdGlhbGl6ZSB2dS1kZXYNCiAgdXRpbC92aG9zdC11c2Vy
LXNlcnZlcjogZ2VuZXJpYyB2aG9zdCB1c2VyIHNlcnZlcg0KICBibG9jazogbW92ZSBsb2dpY2Fs
IGJsb2NrIHNpemUgY2hlY2sgZnVuY3Rpb24gdG8gYSBjb21tb24gdXRpbGl0eQ0KICAgIGZ1bmN0
aW9uDQogIGJsb2NrL2V4cG9ydDogdmhvc3QtdXNlciBibG9jayBkZXZpY2UgYmFja2VuZCBzZXJ2
ZXINCiAgTUFJTlRBSU5FUlM6IEFkZCB2aG9zdC11c2VyIGJsb2NrIGRldmljZSBiYWNrZW5kIHNl
cnZlciBtYWludGFpbmVyDQoNClBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpICgxKToNCiAgYmxvY2sv
bnZtZTogQWRkIGRyaXZlciBzdGF0aXN0aWNzIGZvciBhY2Nlc3MgYWxpZ25tZW50IGFuZCBodyBl
cnJvcnMNCg0KU3RlZmFuIEhham5vY3ppICgxNik6DQogIHV0aWwvdmhvc3QtdXNlci1zZXJ2ZXI6
IHMvZmlsZWRzL2ZpZWxkcy8gdHlwbyBmaXgNCiAgdXRpbC92aG9zdC11c2VyLXNlcnZlcjogZHJv
cCB1bm5lY2Vzc2FyeSBRT00gY2FzdA0KICB1dGlsL3Zob3N0LXVzZXItc2VydmVyOiBkcm9wIHVu
bmVjZXNzYXJ5IHdhdGNoIGRlbGV0aW9uDQogIGJsb2NrL2V4cG9ydDogY29uc29saWRhdGUgcmVx
dWVzdCBzdHJ1Y3RzIGludG8gVnVCbG9ja1JlcQ0KICB1dGlsL3Zob3N0LXVzZXItc2VydmVyOiBk
cm9wIHVudXNlZCBEZXZpY2VQYW5pY05vdGlmaWVyDQogIHV0aWwvdmhvc3QtdXNlci1zZXJ2ZXI6
IGZpeCBtZW1vcnkgbGVhayBpbiB2dV9tZXNzYWdlX3JlYWQoKQ0KICB1dGlsL3Zob3N0LXVzZXIt
c2VydmVyOiBjaGVjayBFT0Ygd2hlbiByZWFkaW5nIHBheWxvYWQNCiAgdXRpbC92aG9zdC11c2Vy
LXNlcnZlcjogcmV3b3JrIHZ1X2NsaWVudF90cmlwKCkgY29yb3V0aW5lIGxpZmVjeWNsZQ0KICBi
bG9jay9leHBvcnQ6IHJlcG9ydCBmbHVzaCBlcnJvcnMNCiAgYmxvY2svZXhwb3J0OiBjb252ZXJ0
IHZob3N0LXVzZXItYmxrIHNlcnZlciB0byBibG9jayBleHBvcnQgQVBJDQogIHV0aWwvdmhvc3Qt
dXNlci1zZXJ2ZXI6IG1vdmUgaGVhZGVyIHRvIGluY2x1ZGUvDQogIHV0aWwvdmhvc3QtdXNlci1z
ZXJ2ZXI6IHVzZSBzdGF0aWMgbGlicmFyeSBpbiBtZXNvbi5idWlsZA0KICBxZW11LXN0b3JhZ2Ut
ZGFlbW9uOiBhdm9pZCBjb21waWxpbmcgYmxvY2tkZXZfc3MgdHdpY2UNCiAgYmxvY2s6IG1vdmUg
YmxvY2sgZXhwb3J0cyB0byBsaWJibG9ja2Rldg0KICBibG9jay9leHBvcnQ6IGFkZCBpb3RocmVh
ZCBhbmQgZml4ZWQtaW90aHJlYWQgb3B0aW9ucw0KICBibG9jay9leHBvcnQ6IGFkZCB2aG9zdC11
c2VyLWJsayBtdWx0aS1xdWV1ZSBzdXBwb3J0DQoNClZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNr
aXkgKDUpOg0KICBibG9jay9pbzogZml4IGJkcnZfY29fYmxvY2tfc3RhdHVzX2Fib3ZlDQogIGJs
b2NrL2lvOiBiZHJ2X2NvbW1vbl9ibG9ja19zdGF0dXNfYWJvdmU6IHN1cHBvcnQgaW5jbHVkZV9i
YXNlDQogIGJsb2NrL2lvOiBiZHJ2X2NvbW1vbl9ibG9ja19zdGF0dXNfYWJvdmU6IHN1cHBvcnQg
YnMgPT0gYmFzZQ0KICBibG9jay9pbzogZml4IGJkcnZfaXNfYWxsb2NhdGVkX2Fib3ZlDQogIGlv
dGVzdHM6IGFkZCBjb21taXQgdG9wLT5iYXNlIGNhc2VzIHRvIDI3NA0KDQogTUFJTlRBSU5FUlMg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICA5ICsNCiBxYXBpL2Jsb2NrLWNvcmUu
anNvbiAgICAgICAgICAgICAgICAgICAgICAgfCAgMjQgKy0NCiBxYXBpL2Jsb2NrLWV4cG9ydC5q
c29uICAgICAgICAgICAgICAgICAgICAgfCAgMzYgKy0NCiBibG9jay9jb3JvdXRpbmVzLmggICAg
ICAgICAgICAgICAgICAgICAgICAgfCAgIDIgKw0KIGJsb2NrL2V4cG9ydC92aG9zdC11c2VyLWJs
ay1zZXJ2ZXIuaCAgICAgICB8ICAxOSArDQogY29udHJpYi9saWJ2aG9zdC11c2VyL2xpYnZob3N0
LXVzZXIuaCAgICAgIHwgIDIxICsNCiBpbmNsdWRlL3FlbXUvdmhvc3QtdXNlci1zZXJ2ZXIuaCAg
ICAgICAgICAgfCAgNjUgKysrDQogdXRpbC9ibG9jay1oZWxwZXJzLmggICAgICAgICAgICAgICAg
ICAgICAgIHwgIDE5ICsNCiBibG9jay9leHBvcnQvZXhwb3J0LmMgICAgICAgICAgICAgICAgICAg
ICAgfCAgMzcgKy0NCiBibG9jay9leHBvcnQvdmhvc3QtdXNlci1ibGstc2VydmVyLmMgICAgICAg
fCA0MzEgKysrKysrKysrKysrKysrKysrKysNCiBibG9jay9pby5jICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgfCAxMzIgKysrLS0tDQogYmxvY2svbnZtZS5jICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHwgIDI3ICsrDQogYmxvY2svcWNvdzIuYyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHwgIDE2ICstDQogY29udHJpYi9saWJ2aG9zdC11c2VyL2xpYnZob3N0LXVz
ZXItZ2xpYi5jIHwgICAyICstDQogY29udHJpYi9saWJ2aG9zdC11c2VyL2xpYnZob3N0LXVzZXIu
YyAgICAgIHwgIDE1ICstDQogaHcvY29yZS9xZGV2LXByb3BlcnRpZXMtc3lzdGVtLmMgICAgICAg
ICAgIHwgIDMxICstDQogbmJkL3NlcnZlci5jICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHwgICAyIC0NCiBxZW11LW5iZC5jICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAg
MjEgKy0NCiBzb2Z0bW11L3ZsLmMgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDQg
Kw0KIHN0dWJzL2Jsay1leHAtY2xvc2UtYWxsLmMgICAgICAgICAgICAgICAgICB8ICAgNyArDQog
dGVzdHMvdmhvc3QtdXNlci1icmlkZ2UuYyAgICAgICAgICAgICAgICAgIHwgICAyICsNCiB0b29s
cy92aXJ0aW9mc2QvZnVzZV92aXJ0aW8uYyAgICAgICAgICAgICAgfCAgIDQgKy0NCiB1dGlsL2Js
b2NrLWhlbHBlcnMuYyAgICAgICAgICAgICAgICAgICAgICAgfCAgNDYgKysrDQogdXRpbC92aG9z
dC11c2VyLXNlcnZlci5jICAgICAgICAgICAgICAgICAgIHwgNDQ2ICsrKysrKysrKysrKysrKysr
KysrKw0KIGJsb2NrL2V4cG9ydC9tZXNvbi5idWlsZCAgICAgICAgICAgICAgICAgICB8ICAgMyAr
LQ0KIGNvbnRyaWIvbGlidmhvc3QtdXNlci9tZXNvbi5idWlsZCAgICAgICAgICB8ICAgMSArDQog
bWVzb24uYnVpbGQgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDIyICstDQogbmJk
L21lc29uLmJ1aWxkICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAyICsNCiBzdG9yYWdl
LWRhZW1vbi9tZXNvbi5idWlsZCAgICAgICAgICAgICAgICAgfCAgIDMgKy0NCiBzdHVicy9tZXNv
bi5idWlsZCAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDEgKw0KIHRlc3RzL3FlbXUtaW90
ZXN0cy8yNzQgICAgICAgICAgICAgICAgICAgICB8ICAyMCArDQogdGVzdHMvcWVtdS1pb3Rlc3Rz
LzI3NC5vdXQgICAgICAgICAgICAgICAgIHwgIDY4ICsrKysNCiB1dGlsL21lc29uLmJ1aWxkICAg
ICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDQgKw0KIDMzIGZpbGVzIGNoYW5nZWQsIDE0MjAg
aW5zZXJ0aW9ucygrKSwgMTIyIGRlbGV0aW9ucygtKQ0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBibG9j
ay9leHBvcnQvdmhvc3QtdXNlci1ibGstc2VydmVyLmgNCiBjcmVhdGUgbW9kZSAxMDA2NDQgaW5j
bHVkZS9xZW11L3Zob3N0LXVzZXItc2VydmVyLmgNCiBjcmVhdGUgbW9kZSAxMDA2NDQgdXRpbC9i
bG9jay1oZWxwZXJzLmgNCiBjcmVhdGUgbW9kZSAxMDA2NDQgYmxvY2svZXhwb3J0L3Zob3N0LXVz
ZXItYmxrLXNlcnZlci5jDQogY3JlYXRlIG1vZGUgMTAwNjQ0IHN0dWJzL2Jsay1leHAtY2xvc2Ut
YWxsLmMNCiBjcmVhdGUgbW9kZSAxMDA2NDQgdXRpbC9ibG9jay1oZWxwZXJzLmMNCiBjcmVhdGUg
bW9kZSAxMDA2NDQgdXRpbC92aG9zdC11c2VyLXNlcnZlci5jDQoNCi0tIA0KMi4yNi4yDQoNCg==


