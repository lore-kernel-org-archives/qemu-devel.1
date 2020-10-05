Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE3E5C4363D
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 15:45:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7595F206DD
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 15:45:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bQnPNRnW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7595F206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33362 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPSgA-0006rE-Hp
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 11:45:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56282)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kPSeJ-0004nG-TY
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 11:43:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:31514)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kPSeH-00087g-Qf
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 11:43:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601912616;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tx7PPL5IZ0TX3/fiyMAXN29HmQFckjsJgmoCzOjgIW4=;
 b=bQnPNRnWHlM1oOWvN7dFfoEgh9g6ZE3Kt8rVhZXR+bc6Y50enCMlRLkcjFkz6+B1581rDf
 a426x1E3pAX8FTcm494F/nghpAy1axYAeGLLkM8/UmjDpkRe0tq788eD1Cqr9sWZEUPDqz
 EndV6vEdCWBweImchDHZuslHXQjQLE4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-116-LBZntdlsO9GcTgBXVPeFtg-1; Mon, 05 Oct 2020 11:43:34 -0400
X-MC-Unique: LBZntdlsO9GcTgBXVPeFtg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ED25E18A8223;
 Mon,  5 Oct 2020 15:43:32 +0000 (UTC)
Received: from localhost (ovpn-112-117.ams2.redhat.com [10.36.112.117])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 72D3555764;
 Mon,  5 Oct 2020 15:43:29 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL v2 01/17] util/vfio-helpers: Pass page protections to
 qemu_vfio_pci_map_bar()
Date: Mon,  5 Oct 2020 16:43:07 +0100
Message-Id: <20201005154323.31347-2-stefanha@redhat.com>
In-Reply-To: <20201005154323.31347-1-stefanha@redhat.com>
References: <20201005154323.31347-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/05 01:25:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

RnJvbTogUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEByZWRoYXQuY29tPgoKUGFnZXMg
YXJlIGN1cnJlbnRseSBtYXBwZWQgUkVBRC9XUklURS4gVG8gYmUgYWJsZSB0byB1c2UgZGlmZmVy
ZW50CnByb3RlY3Rpb25zLCBhZGQgYSBuZXcgYXJndW1lbnQgdG8gcWVtdV92ZmlvX3BjaV9tYXBf
YmFyKCkuCgpTaWduZWQtb2ZmLWJ5OiBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8cGhpbG1kQHJl
ZGhhdC5jb20+ClNpZ25lZC1vZmYtYnk6IFN0ZWZhbiBIYWpub2N6aSA8c3RlZmFuaGFAcmVkaGF0
LmNvbT4KTWVzc2FnZS1JZDogPDIwMjAwOTIyMDgzODIxLjU3ODUxOS0yLXBoaWxtZEByZWRoYXQu
Y29tPgotLS0KIGluY2x1ZGUvcWVtdS92ZmlvLWhlbHBlcnMuaCB8IDIgKy0KIGJsb2NrL252bWUu
YyAgICAgICAgICAgICAgICB8IDMgKystCiB1dGlsL3ZmaW8taGVscGVycy5jICAgICAgICAgfCA0
ICsrLS0KIDMgZmlsZXMgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQoK
ZGlmZiAtLWdpdCBhL2luY2x1ZGUvcWVtdS92ZmlvLWhlbHBlcnMuaCBiL2luY2x1ZGUvcWVtdS92
ZmlvLWhlbHBlcnMuaAppbmRleCAxZjA1N2MyYjllLi40NDkxYzhlMWE2IDEwMDY0NAotLS0gYS9p
bmNsdWRlL3FlbXUvdmZpby1oZWxwZXJzLmgKKysrIGIvaW5jbHVkZS9xZW11L3ZmaW8taGVscGVy
cy5oCkBAIC0yMiw3ICsyMiw3IEBAIGludCBxZW11X3ZmaW9fZG1hX21hcChRRU1VVkZJT1N0YXRl
ICpzLCB2b2lkICpob3N0LCBzaXplX3Qgc2l6ZSwKIGludCBxZW11X3ZmaW9fZG1hX3Jlc2V0X3Rl
bXBvcmFyeShRRU1VVkZJT1N0YXRlICpzKTsKIHZvaWQgcWVtdV92ZmlvX2RtYV91bm1hcChRRU1V
VkZJT1N0YXRlICpzLCB2b2lkICpob3N0KTsKIHZvaWQgKnFlbXVfdmZpb19wY2lfbWFwX2JhcihR
RU1VVkZJT1N0YXRlICpzLCBpbnQgaW5kZXgsCi0gICAgICAgICAgICAgICAgICAgICAgICAgICAg
dWludDY0X3Qgb2Zmc2V0LCB1aW50NjRfdCBzaXplLAorICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHVpbnQ2NF90IG9mZnNldCwgdWludDY0X3Qgc2l6ZSwgaW50IHByb3QsCiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgRXJyb3IgKiplcnJwKTsKIHZvaWQgcWVtdV92ZmlvX3BjaV91bm1h
cF9iYXIoUUVNVVZGSU9TdGF0ZSAqcywgaW50IGluZGV4LCB2b2lkICpiYXIsCiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHVpbnQ2NF90IG9mZnNldCwgdWludDY0X3Qgc2l6ZSk7CmRpZmYg
LS1naXQgYS9ibG9jay9udm1lLmMgYi9ibG9jay9udm1lLmMKaW5kZXggZjRmMjdiNmRhNy4uNWE0
ZGM2YTcyMiAxMDA2NDQKLS0tIGEvYmxvY2svbnZtZS5jCisrKyBiL2Jsb2NrL252bWUuYwpAQCAt
NzEyLDcgKzcxMiw4IEBAIHN0YXRpYyBpbnQgbnZtZV9pbml0KEJsb2NrRHJpdmVyU3RhdGUgKmJz
LCBjb25zdCBjaGFyICpkZXZpY2UsIGludCBuYW1lc3BhY2UsCiAgICAgICAgIGdvdG8gb3V0Owog
ICAgIH0KIAotICAgIHMtPnJlZ3MgPSBxZW11X3ZmaW9fcGNpX21hcF9iYXIocy0+dmZpbywgMCwg
MCwgTlZNRV9CQVJfU0laRSwgZXJycCk7CisgICAgcy0+cmVncyA9IHFlbXVfdmZpb19wY2lfbWFw
X2JhcihzLT52ZmlvLCAwLCAwLCBOVk1FX0JBUl9TSVpFLAorICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgUFJPVF9SRUFEIHwgUFJPVF9XUklURSwgZXJycCk7CiAgICAgaWYgKCFz
LT5yZWdzKSB7CiAgICAgICAgIHJldCA9IC1FSU5WQUw7CiAgICAgICAgIGdvdG8gb3V0OwpkaWZm
IC0tZ2l0IGEvdXRpbC92ZmlvLWhlbHBlcnMuYyBiL3V0aWwvdmZpby1oZWxwZXJzLmMKaW5kZXgg
NTgzYmRmYjM2Zi4uOWFjMzA3ZTNkNCAxMDA2NDQKLS0tIGEvdXRpbC92ZmlvLWhlbHBlcnMuYwor
KysgYi91dGlsL3ZmaW8taGVscGVycy5jCkBAIC0xNDYsMTMgKzE0NiwxMyBAQCBzdGF0aWMgaW50
IHFlbXVfdmZpb19wY2lfaW5pdF9iYXIoUUVNVVZGSU9TdGF0ZSAqcywgaW50IGluZGV4LCBFcnJv
ciAqKmVycnApCiAgKiBNYXAgYSBQQ0kgYmFyIGFyZWEuCiAgKi8KIHZvaWQgKnFlbXVfdmZpb19w
Y2lfbWFwX2JhcihRRU1VVkZJT1N0YXRlICpzLCBpbnQgaW5kZXgsCi0gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgdWludDY0X3Qgb2Zmc2V0LCB1aW50NjRfdCBzaXplLAorICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHVpbnQ2NF90IG9mZnNldCwgdWludDY0X3Qgc2l6ZSwgaW50IHByb3Qs
CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgRXJyb3IgKiplcnJwKQogewogICAgIHZvaWQg
KnA7CiAgICAgYXNzZXJ0X2Jhcl9pbmRleF92YWxpZChzLCBpbmRleCk7CiAgICAgcCA9IG1tYXAo
TlVMTCwgTUlOKHNpemUsIHMtPmJhcl9yZWdpb25faW5mb1tpbmRleF0uc2l6ZSAtIG9mZnNldCks
Ci0gICAgICAgICAgICAgUFJPVF9SRUFEIHwgUFJPVF9XUklURSwgTUFQX1NIQVJFRCwKKyAgICAg
ICAgICAgICBwcm90LCBNQVBfU0hBUkVELAogICAgICAgICAgICAgIHMtPmRldmljZSwgcy0+YmFy
X3JlZ2lvbl9pbmZvW2luZGV4XS5vZmZzZXQgKyBvZmZzZXQpOwogICAgIGlmIChwID09IE1BUF9G
QUlMRUQpIHsKICAgICAgICAgZXJyb3Jfc2V0Z19lcnJubyhlcnJwLCBlcnJubywgIkZhaWxlZCB0
byBtYXAgQkFSIHJlZ2lvbiIpOwotLSAKMi4yNi4yCgo=


