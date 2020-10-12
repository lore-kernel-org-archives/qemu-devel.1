Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0613C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 18:31:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CFD52072C
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 18:31:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d7/1lYHH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CFD52072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44850 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kS2bO-00056M-TD
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 14:31:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39460)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kS2YQ-0003HP-Gj
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 14:28:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:44139)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kS2YM-00044o-V9
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 14:28:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602527289;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=eWQsbr78QTZXXmdXYAvv5VtHbsAd8lRMqsPNEw4dBoQ=;
 b=d7/1lYHHfTkZdUm5jwtmqo70x1c0/6q727ceVamAykEhGqJ/TBNX/qhhb64iwwrq/hV3Gp
 mm56OygrXUat4tAbZrZ+4fdVb2soJbLWX0LJdaCJowZVeENAHm9xmrmN9V9gOZsvs+qV/6
 LGk3a03nykg7ZMU1KNRANUtUd38a+zE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-192-MuwtrLoiOIStu4fHbjGXhQ-1; Mon, 12 Oct 2020 14:28:06 -0400
X-MC-Unique: MuwtrLoiOIStu4fHbjGXhQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 63BBF185A0C1;
 Mon, 12 Oct 2020 18:28:04 +0000 (UTC)
Received: from localhost (ovpn-115-4.ams2.redhat.com [10.36.115.4])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E915719C78;
 Mon, 12 Oct 2020 18:28:00 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PULL v2 00/30] Block patches
Date: Mon, 12 Oct 2020 19:27:30 +0100
Message-Id: <20201012182800.157697-1-stefanha@redhat.com>
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
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/12 02:58:41
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
Cc: Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Coiby Xu <Coiby.Xu@gmail.com>,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

VGhlIGZvbGxvd2luZyBjaGFuZ2VzIHNpbmNlIGNvbW1pdCAyMzg3ZGY0OTdiNGI0YmNmNzU0ZWI3
Mzk4ZWRjYTgyODg5ZTJlZjU0Og0KDQogIE1lcmdlIHJlbW90ZS10cmFja2luZyBicmFuY2ggJ3Jl
bW90ZXMvYXJtYnJ1L3RhZ3MvcHVsbC1xYXBpLTIwMjAtMTAtMTAnIGludG8gc3RhZ2luZyAoMjAy
MC0xMC0xMiAxMToyOTo0MiArMDEwMCkNCg0KYXJlIGF2YWlsYWJsZSBpbiB0aGUgR2l0IHJlcG9z
aXRvcnkgYXQ6DQoNCiAgaHR0cHM6Ly9naXRsYWIuY29tL3N0ZWZhbmhhL3FlbXUuZ2l0IHRhZ3Mv
YmxvY2stcHVsbC1yZXF1ZXN0DQoNCmZvciB5b3UgdG8gZmV0Y2ggY2hhbmdlcyB1cCB0byAzNjY0
ZWM2YmJlMjM2MTI2Yjc5ZDI1MWQ0MDM3ODg5ZTcxODFhYjU1Og0KDQogIGlvdGVzdHM6IGFkZCBj
b21taXQgdG9wLT5iYXNlIGNhc2VzIHRvIDI3NCAoMjAyMC0xMC0xMiAxNjo0Nzo1OCArMDEwMCkN
Cg0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLQ0KUHVsbCByZXF1ZXN0DQoNCnYyOg0KICogUmViYXNlIGFuZCByZXNvbHZlIGNv
bmZsaWN0IHdpdGggY29tbWl0IDAyOWE4OGM5YTdlMyAoInFlbXUtbmJkOiBIb25vcg0KICAgU0lH
SU5UIGFuZCBTSUdIVVAiKSBbUGV0ZXJdDQoNCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCg0KQ29pYnkgWHUgKDcpOg0KICBs
aWJ2aG9zdC11c2VyOiBBbGxvdyB2dV9tZXNzYWdlX3JlYWQgdG8gYmUgcmVwbGFjZWQNCiAgbGli
dmhvc3QtdXNlcjogcmVtb3ZlIHdhdGNoIGZvciBraWNrX2ZkIHdoZW4gZGUtaW5pdGlhbGl6ZSB2
dS1kZXYNCiAgdXRpbC92aG9zdC11c2VyLXNlcnZlcjogZ2VuZXJpYyB2aG9zdCB1c2VyIHNlcnZl
cg0KICBibG9jazogbW92ZSBsb2dpY2FsIGJsb2NrIHNpemUgY2hlY2sgZnVuY3Rpb24gdG8gYSBj
b21tb24gdXRpbGl0eQ0KICAgIGZ1bmN0aW9uDQogIGJsb2NrL2V4cG9ydDogdmhvc3QtdXNlciBi
bG9jayBkZXZpY2UgYmFja2VuZCBzZXJ2ZXINCiAgdGVzdDogbmV3IHFUZXN0IGNhc2UgdG8gdGVz
dCB0aGUgdmhvc3QtdXNlci1ibGstc2VydmVyDQogIE1BSU5UQUlORVJTOiBBZGQgdmhvc3QtdXNl
ciBibG9jayBkZXZpY2UgYmFja2VuZCBzZXJ2ZXIgbWFpbnRhaW5lcg0KDQpQaGlsaXBwZSBNYXRo
aWV1LURhdWTDqSAoMSk6DQogIGJsb2NrL252bWU6IEFkZCBkcml2ZXIgc3RhdGlzdGljcyBmb3Ig
YWNjZXNzIGFsaWdubWVudCBhbmQgaHcgZXJyb3JzDQoNClN0ZWZhbiBIYWpub2N6aSAoMTcpOg0K
ICB1dGlsL3Zob3N0LXVzZXItc2VydmVyOiBzL2ZpbGVkcy9maWVsZHMvIHR5cG8gZml4DQogIHV0
aWwvdmhvc3QtdXNlci1zZXJ2ZXI6IGRyb3AgdW5uZWNlc3NhcnkgUU9NIGNhc3QNCiAgdXRpbC92
aG9zdC11c2VyLXNlcnZlcjogZHJvcCB1bm5lY2Vzc2FyeSB3YXRjaCBkZWxldGlvbg0KICBibG9j
ay9leHBvcnQ6IGNvbnNvbGlkYXRlIHJlcXVlc3Qgc3RydWN0cyBpbnRvIFZ1QmxvY2tSZXENCiAg
dXRpbC92aG9zdC11c2VyLXNlcnZlcjogZHJvcCB1bnVzZWQgRGV2aWNlUGFuaWNOb3RpZmllcg0K
ICB1dGlsL3Zob3N0LXVzZXItc2VydmVyOiBmaXggbWVtb3J5IGxlYWsgaW4gdnVfbWVzc2FnZV9y
ZWFkKCkNCiAgdXRpbC92aG9zdC11c2VyLXNlcnZlcjogY2hlY2sgRU9GIHdoZW4gcmVhZGluZyBw
YXlsb2FkDQogIHV0aWwvdmhvc3QtdXNlci1zZXJ2ZXI6IHJld29yayB2dV9jbGllbnRfdHJpcCgp
IGNvcm91dGluZSBsaWZlY3ljbGUNCiAgYmxvY2svZXhwb3J0OiByZXBvcnQgZmx1c2ggZXJyb3Jz
DQogIGJsb2NrL2V4cG9ydDogY29udmVydCB2aG9zdC11c2VyLWJsayBzZXJ2ZXIgdG8gYmxvY2sg
ZXhwb3J0IEFQSQ0KICB1dGlsL3Zob3N0LXVzZXItc2VydmVyOiBtb3ZlIGhlYWRlciB0byBpbmNs
dWRlLw0KICB1dGlsL3Zob3N0LXVzZXItc2VydmVyOiB1c2Ugc3RhdGljIGxpYnJhcnkgaW4gbWVz
b24uYnVpbGQNCiAgcWVtdS1zdG9yYWdlLWRhZW1vbjogYXZvaWQgY29tcGlsaW5nIGJsb2NrZGV2
X3NzIHR3aWNlDQogIGJsb2NrOiBtb3ZlIGJsb2NrIGV4cG9ydHMgdG8gbGliYmxvY2tkZXYNCiAg
YmxvY2svZXhwb3J0OiBhZGQgaW90aHJlYWQgYW5kIGZpeGVkLWlvdGhyZWFkIG9wdGlvbnMNCiAg
YmxvY2svZXhwb3J0OiBhZGQgdmhvc3QtdXNlci1ibGsgbXVsdGktcXVldWUgc3VwcG9ydA0KICB0
ZXN0cy9xdGVzdDogYWRkIG11bHRpLXF1ZXVlIHRlc3QgY2FzZSB0byB2aG9zdC11c2VyLWJsay10
ZXN0DQoNClZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgKDUpOg0KICBibG9jay9pbzogZml4
IGJkcnZfY29fYmxvY2tfc3RhdHVzX2Fib3ZlDQogIGJsb2NrL2lvOiBiZHJ2X2NvbW1vbl9ibG9j
a19zdGF0dXNfYWJvdmU6IHN1cHBvcnQgaW5jbHVkZV9iYXNlDQogIGJsb2NrL2lvOiBiZHJ2X2Nv
bW1vbl9ibG9ja19zdGF0dXNfYWJvdmU6IHN1cHBvcnQgYnMgPT0gYmFzZQ0KICBibG9jay9pbzog
Zml4IGJkcnZfaXNfYWxsb2NhdGVkX2Fib3ZlDQogIGlvdGVzdHM6IGFkZCBjb21taXQgdG9wLT5i
YXNlIGNhc2VzIHRvIDI3NA0KDQogTUFJTlRBSU5FUlMgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHwgIDEwICsNCiBxYXBpL2Jsb2NrLWNvcmUuanNvbiAgICAgICAgICAgICAgICAgICAg
ICAgfCAgMjQgKy0NCiBxYXBpL2Jsb2NrLWV4cG9ydC5qc29uICAgICAgICAgICAgICAgICAgICAg
fCAgMzYgKy0NCiBibG9jay9jb3JvdXRpbmVzLmggICAgICAgICAgICAgICAgICAgICAgICAgfCAg
IDIgKw0KIGJsb2NrL2V4cG9ydC92aG9zdC11c2VyLWJsay1zZXJ2ZXIuaCAgICAgICB8ICAxOSAr
DQogY29udHJpYi9saWJ2aG9zdC11c2VyL2xpYnZob3N0LXVzZXIuaCAgICAgIHwgIDIxICsNCiBp
bmNsdWRlL3FlbXUvdmhvc3QtdXNlci1zZXJ2ZXIuaCAgICAgICAgICAgfCAgNjUgKysNCiB0ZXN0
cy9xdGVzdC9saWJxb3MvbGlicXRlc3QuaCAgICAgICAgICAgICAgfCAgMTcgKw0KIHRlc3RzL3F0
ZXN0L2xpYnFvcy92aG9zdC11c2VyLWJsay5oICAgICAgICB8ICA0OCArKw0KIHV0aWwvYmxvY2st
aGVscGVycy5oICAgICAgICAgICAgICAgICAgICAgICB8ICAxOSArDQogYmxvY2svZXhwb3J0L2V4
cG9ydC5jICAgICAgICAgICAgICAgICAgICAgIHwgIDM3ICstDQogYmxvY2svZXhwb3J0L3Zob3N0
LXVzZXItYmxrLXNlcnZlci5jICAgICAgIHwgNDMxICsrKysrKysrKysrDQogYmxvY2svaW8uYyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgMTMyICsrLS0NCiBibG9jay9udm1lLmMg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgMjcgKw0KIGJsb2NrL3Fjb3cyLmMgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAxNiArLQ0KIGNvbnRyaWIvbGlidmhvc3QtdXNl
ci9saWJ2aG9zdC11c2VyLWdsaWIuYyB8ICAgMiArLQ0KIGNvbnRyaWIvbGlidmhvc3QtdXNlci9s
aWJ2aG9zdC11c2VyLmMgICAgICB8ICAxNSArLQ0KIGh3L2NvcmUvcWRldi1wcm9wZXJ0aWVzLXN5
c3RlbS5jICAgICAgICAgICB8ICAzMSArLQ0KIG5iZC9zZXJ2ZXIuYyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICB8ICAgMiAtDQogcWVtdS1uYmQuYyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIHwgIDI1ICstDQogc29mdG1tdS92bC5jICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHwgICA0ICsNCiBzdHVicy9ibGstZXhwLWNsb3NlLWFsbC5jICAgICAgICAgICAgICAg
ICAgfCAgIDcgKw0KIHRlc3RzL3F0ZXN0L2xpYnFvcy92aG9zdC11c2VyLWJsay5jICAgICAgICB8
IDEyOSArKysrDQogdGVzdHMvcXRlc3QvbGlicXRlc3QuYyAgICAgICAgICAgICAgICAgICAgIHwg
IDM2ICstDQogdGVzdHMvcXRlc3Qvdmhvc3QtdXNlci1ibGstdGVzdC5jICAgICAgICAgIHwgODIy
ICsrKysrKysrKysrKysrKysrKysrKw0KIHRlc3RzL3Zob3N0LXVzZXItYnJpZGdlLmMgICAgICAg
ICAgICAgICAgICB8ICAgMiArDQogdG9vbHMvdmlydGlvZnNkL2Z1c2VfdmlydGlvLmMgICAgICAg
ICAgICAgIHwgICA0ICstDQogdXRpbC9ibG9jay1oZWxwZXJzLmMgICAgICAgICAgICAgICAgICAg
ICAgIHwgIDQ2ICsrDQogdXRpbC92aG9zdC11c2VyLXNlcnZlci5jICAgICAgICAgICAgICAgICAg
IHwgNDQ2ICsrKysrKysrKysrDQogYmxvY2svZXhwb3J0L21lc29uLmJ1aWxkICAgICAgICAgICAg
ICAgICAgIHwgICAzICstDQogY29udHJpYi9saWJ2aG9zdC11c2VyL21lc29uLmJ1aWxkICAgICAg
ICAgIHwgICAxICsNCiBtZXNvbi5idWlsZCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
fCAgMjIgKy0NCiBuYmQvbWVzb24uYnVpbGQgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAg
IDIgKw0KIHN0b3JhZ2UtZGFlbW9uL21lc29uLmJ1aWxkICAgICAgICAgICAgICAgICB8ICAgMyAr
LQ0KIHN0dWJzL21lc29uLmJ1aWxkICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgMSArDQog
dGVzdHMvcWVtdS1pb3Rlc3RzLzI3NCAgICAgICAgICAgICAgICAgICAgIHwgIDIwICsNCiB0ZXN0
cy9xZW11LWlvdGVzdHMvMjc0Lm91dCAgICAgICAgICAgICAgICAgfCAgNjggKysNCiB0ZXN0cy9x
dGVzdC9saWJxb3MvbWVzb24uYnVpbGQgICAgICAgICAgICAgfCAgIDEgKw0KIHRlc3RzL3F0ZXN0
L21lc29uLmJ1aWxkICAgICAgICAgICAgICAgICAgICB8ICAgNCArLQ0KIHV0aWwvbWVzb24uYnVp
bGQgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgNCArDQogNDAgZmlsZXMgY2hhbmdlZCwg
MjQ3NiBpbnNlcnRpb25zKCspLCAxMjggZGVsZXRpb25zKC0pDQogY3JlYXRlIG1vZGUgMTAwNjQ0
IGJsb2NrL2V4cG9ydC92aG9zdC11c2VyLWJsay1zZXJ2ZXIuaA0KIGNyZWF0ZSBtb2RlIDEwMDY0
NCBpbmNsdWRlL3FlbXUvdmhvc3QtdXNlci1zZXJ2ZXIuaA0KIGNyZWF0ZSBtb2RlIDEwMDY0NCB0
ZXN0cy9xdGVzdC9saWJxb3Mvdmhvc3QtdXNlci1ibGsuaA0KIGNyZWF0ZSBtb2RlIDEwMDY0NCB1
dGlsL2Jsb2NrLWhlbHBlcnMuaA0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBibG9jay9leHBvcnQvdmhv
c3QtdXNlci1ibGstc2VydmVyLmMNCiBjcmVhdGUgbW9kZSAxMDA2NDQgc3R1YnMvYmxrLWV4cC1j
bG9zZS1hbGwuYw0KIGNyZWF0ZSBtb2RlIDEwMDY0NCB0ZXN0cy9xdGVzdC9saWJxb3Mvdmhvc3Qt
dXNlci1ibGsuYw0KIGNyZWF0ZSBtb2RlIDEwMDY0NCB0ZXN0cy9xdGVzdC92aG9zdC11c2VyLWJs
ay10ZXN0LmMNCiBjcmVhdGUgbW9kZSAxMDA2NDQgdXRpbC9ibG9jay1oZWxwZXJzLmMNCiBjcmVh
dGUgbW9kZSAxMDA2NDQgdXRpbC92aG9zdC11c2VyLXNlcnZlci5jDQoNCi0tIA0KMi4yNi4yDQoN
Cg==


