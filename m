Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 797D6C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 10:03:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45BCB2088E
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 10:03:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TefbBEk4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45BCB2088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40702 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jo2Ft-0003E3-Fc
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 06:03:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43436)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jo2Eo-0001NE-1a
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 06:02:38 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:41429
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jo2Em-0003XU-CJ
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 06:02:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592992955;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E39TEhvqpslW6LMdaJyMYG+MFqK+bgNrvvGjnCuls6c=;
 b=TefbBEk4EZghulMx8mXcDwfZXtFOpksYYPBDGLJn56huBJSvfhd0jCSJqxgxwveFtKCh6m
 yVKt5PCGTJ0bIDbBpx6qXbjyYPHdiTptcOu4ebAnpWYjseq8pT2Z+iib10+Ik2tR+gPlyW
 P8R0rzfZHE3fghdVhBUaiEh43y7N7Hc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-282-2rit4UI1PwK5BFegOvQAyg-1; Wed, 24 Jun 2020 06:02:33 -0400
X-MC-Unique: 2rit4UI1PwK5BFegOvQAyg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BE3DB1B18BC6;
 Wed, 24 Jun 2020 10:02:31 +0000 (UTC)
Received: from localhost (ovpn-114-150.ams2.redhat.com [10.36.114.150])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 877EF5C557;
 Wed, 24 Jun 2020 10:02:27 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 03/12] coroutine: add check for SafeStack in sigaltstack
Date: Wed, 24 Jun 2020 11:02:01 +0100
Message-Id: <20200624100210.59975-4-stefanha@redhat.com>
In-Reply-To: <20200624100210.59975-1-stefanha@redhat.com>
References: <20200624100210.59975-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=205.139.110.61; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/24 00:34:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MIME_BASE64_TEXT=1.741, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Daniele Buono <dbuono@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

RnJvbTogRGFuaWVsZSBCdW9ubyA8ZGJ1b25vQGxpbnV4LnZuZXQuaWJtLmNvbT4KCkN1cnJlbnQg
aW1wbGVtZW50YXRpb24gb2YgTExWTSdzIFNhZmVTdGFjayBpcyBub3QgY29tcGF0aWJsZSB3aXRo
CmNvZGUgdGhhdCB1c2VzIGFuIGFsdGVybmF0ZSBzdGFjayBjcmVhdGVkIHdpdGggc2lnYWx0c3Rh
Y2soKS4KU2luY2UgY29yb3V0aW5lLXNpZ2FsdHN0YWNrIHJlbGllcyBvbiBzaWdhbHRzdGFjaygp
LCBpdCBpcyBub3QKY29tcGF0aWJsZSB3aXRoIFNhZmVTdGFjay4gVGhlIHJlc3VsdGluZyBiaW5h
cnkgaXMgaW5jb3JyZWN0LCB3aXRoCmRpZmZlcmVudCBjb3JvdXRpbmVzIHNoYXJpbmcgdGhlIHNh
bWUgdW5zYWZlIHN0YWNrIGFuZCBwcm9kdWNpbmcKdW5kZWZpbmVkIGJlaGF2aW9yIGF0IHJ1bnRp
bWUuCgpJbiB0aGUgZnV0dXJlIExMVk0gbWF5IHByb3ZpZGUgYSBTYWZlU3RhY2sgaW1wbGVtZW50
YXRpb24gY29tcGF0aWJsZSB3aXRoCnNpZ2FsdHN0YWNrKCkuIEluIHRoZSBtZWFudGltZSwgaWYg
U2FmZVN0YWNrIGlzIGRlc2lyZWQsIHRoZSBjb3JvdXRpbmUKaW1wbGVtZW50YXRpb24gZnJvbSBj
b3JvdXRpbmUtdWNvbnRleHQgc2hvdWxkIGJlIHVzZWQuCkFzIGEgc2FmZXR5IGNoZWNrLCBhZGQg
YSBjb250cm9sIGluIGNvcm91dGluZS1zaWdhbHRzdGFjayB0byB0aHJvdyBhCnByZXByb2Nlc3Nv
ciAjZXJyb3IgaWYgU2FmZVN0YWNrIGlzIGVuYWJsZWQgYW5kIHdlIGFyZSB0cnlpbmcgdG8KdXNl
IGNvcm91dGluZS1zaWdhbHRzdGFjayB0byBpbXBsZW1lbnQgY29yb3V0aW5lcy4KClNpZ25lZC1v
ZmYtYnk6IERhbmllbGUgQnVvbm8gPGRidW9ub0BsaW51eC52bmV0LmlibS5jb20+Ck1lc3NhZ2Ut
aWQ6IDIwMjAwNTI5MjA1MTIyLjcxNC0zLWRidW9ub0BsaW51eC52bmV0LmlibS5jb20KU2lnbmVk
LW9mZi1ieTogU3RlZmFuIEhham5vY3ppIDxzdGVmYW5oYUByZWRoYXQuY29tPgotLS0KIHV0aWwv
Y29yb3V0aW5lLXNpZ2FsdHN0YWNrLmMgfCA0ICsrKysKIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2Vy
dGlvbnMoKykKCmRpZmYgLS1naXQgYS91dGlsL2Nvcm91dGluZS1zaWdhbHRzdGFjay5jIGIvdXRp
bC9jb3JvdXRpbmUtc2lnYWx0c3RhY2suYwppbmRleCBmNmZjNDlhMGU1Li5hYWRlODJhZmI4IDEw
MDY0NAotLS0gYS91dGlsL2Nvcm91dGluZS1zaWdhbHRzdGFjay5jCisrKyBiL3V0aWwvY29yb3V0
aW5lLXNpZ2FsdHN0YWNrLmMKQEAgLTMwLDYgKzMwLDEwIEBACiAjaW5jbHVkZSAicWVtdS1jb21t
b24uaCIKICNpbmNsdWRlICJxZW11L2Nvcm91dGluZV9pbnQuaCIKIAorI2lmZGVmIENPTkZJR19T
QUZFU1RBQ0sKKyNlcnJvciAiU2FmZVN0YWNrIGlzIG5vdCBjb21wYXRpYmxlIHdpdGggY29kZSBy
dW4gaW4gYWx0ZXJuYXRlIHNpZ25hbCBzdGFja3MiCisjZW5kaWYKKwogdHlwZWRlZiBzdHJ1Y3Qg
ewogICAgIENvcm91dGluZSBiYXNlOwogICAgIHZvaWQgKnN0YWNrOwotLSAKMi4yNi4yCgo=


