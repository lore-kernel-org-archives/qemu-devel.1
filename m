Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A355C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 10:07:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66C3520767
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 10:07:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WfpfalfE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66C3520767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57520 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jo2JL-0002qd-L5
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 06:07:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43480)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jo2Eu-0001dE-NT
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 06:02:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60258
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jo2Es-0003b1-Qc
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 06:02:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592992962;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dVpMD9A8TEZKeHH5TOKBr7wEiFBE4Ujs5DlSnNOvwCg=;
 b=WfpfalfEh3NMEdtHcfygsHK5YvPKFCecF/WkPCYz0eAFg0v8DTBQezgQ8RQolS3iR7/5My
 HnVFhB5dj0M96cKwnbBCZ3qK0ZhVWAR8swJad/NvZXt+0ysoU+2TQN4v4zIA1zZVO+Sc76
 blrOpfNOtPBLkUSy86SaihE4hLJqyaE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-458-f98Tg0ikMYWH5dLfYM-nIw-1; Wed, 24 Jun 2020 06:02:39 -0400
X-MC-Unique: f98Tg0ikMYWH5dLfYM-nIw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B3C3B800D5C;
 Wed, 24 Jun 2020 10:02:38 +0000 (UTC)
Received: from localhost (ovpn-114-150.ams2.redhat.com [10.36.114.150])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4AE3F12CB4;
 Wed, 24 Jun 2020 10:02:38 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 05/12] check-block: enable iotests with SafeStack
Date: Wed, 24 Jun 2020 11:02:03 +0100
Message-Id: <20200624100210.59975-6-stefanha@redhat.com>
In-Reply-To: <20200624100210.59975-1-stefanha@redhat.com>
References: <20200624100210.59975-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=205.139.110.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/24 03:27:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MIME_BASE64_TEXT=1.741, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

RnJvbTogRGFuaWVsZSBCdW9ubyA8ZGJ1b25vQGxpbnV4LnZuZXQuaWJtLmNvbT4KClNhZmVTdGFj
ayBpcyBhIHN0YWNrIHByb3RlY3Rpb24gdGVjaG5pcXVlIGltcGxlbWVudGVkIGluIGxsdm0uIEl0
IGlzCmVuYWJsZWQgd2l0aCBhIC1mc2FuaXRpemUgZmxhZy4KaW90ZXN0cyBhcmUgY3VycmVudGx5
IGRpc2FibGVkIHdoZW4gYW55IC1mc2FuaXRpemUgb3B0aW9uIGlzIHVzZWQsCmJlY2F1c2Ugc3Vj
aCBvcHRpb25zIHRlbmQgdG8gcHJvZHVjZSBhZGRpdGlvbmFsIHdhcm5pbmdzIGFuZCBmYWxzZQpw
b3NpdGl2ZXMuCgpXaGlsZSBjb21tb24gLWZzYW5pdGl6ZSBvcHRpb25zIGFyZSB1c2VkIHRvIHZl
cmlmeSB0aGUgY29kZSBhbmQgbm90CmFkZGVkIGluIHByb2R1Y3Rpb24sIFNhZmVTdGFjaydzIG1h
aW4gdXNlIGlzIGluIHByb2R1Y3Rpb24gZW52aXJvbm1lbnRzCnRvIHByb3RlY3QgYWdhaW5zdCBz
dGFjayBzbWFzaGluZy4KClNpbmNlIFNhZmVTdGFjayBkb2VzIG5vdCBwcmludCBhbnkgd2Fybmlu
ZyBvciBmYWxzZSBwb3NpdGl2ZSwgZW5hYmxlCmlvdGVzdHMgd2hlbiBTYWZlU3RhY2sgaXMgdGhl
IG9ubHkgLWZzYW5pdGl6ZSBvcHRpb24gdXNlZC4KVGhpcyBpcyBsaWtlbHkgZ29pbmcgdG8gYmUg
YSBwcm9kdWN0aW9uIGJpbmFyeSBhbmQgd2Ugd2FudCB0byBtYWtlIHN1cmUKaXQgd29ya3MgY29y
cmVjdGx5LgoKU2lnbmVkLW9mZi1ieTogRGFuaWVsZSBCdW9ubyA8ZGJ1b25vQGxpbnV4LnZuZXQu
aWJtLmNvbT4KTWVzc2FnZS1pZDogMjAyMDA1MjkyMDUxMjIuNzE0LTUtZGJ1b25vQGxpbnV4LnZu
ZXQuaWJtLmNvbQpTaWduZWQtb2ZmLWJ5OiBTdGVmYW4gSGFqbm9jemkgPHN0ZWZhbmhhQHJlZGhh
dC5jb20+Ci0tLQogdGVzdHMvY2hlY2stYmxvY2suc2ggfCAxMiArKysrKysrKysrKy0KIDEgZmls
ZSBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEv
dGVzdHMvY2hlY2stYmxvY2suc2ggYi90ZXN0cy9jaGVjay1ibG9jay5zaAppbmRleCBhZDMyMGMy
MWJhLi44ZTI5Yzg2OGU1IDEwMDc1NQotLS0gYS90ZXN0cy9jaGVjay1ibG9jay5zaAorKysgYi90
ZXN0cy9jaGVjay1ibG9jay5zaApAQCAtMjEsNyArMjEsMTcgQEAgaWYgZ3JlcCAtcSAiQ09ORklH
X0dQUk9GPXkiIGNvbmZpZy1ob3N0Lm1hayAyPi9kZXYvbnVsbCA7IHRoZW4KICAgICBleGl0IDAK
IGZpCiAKLWlmIGdyZXAgLXEgIkNGTEFHUy4qLWZzYW5pdGl6ZSIgY29uZmlnLWhvc3QubWFrIDI+
L2Rldi9udWxsIDsgdGhlbgorIyBEaXNhYmxlIHRlc3RzIHdpdGggYW55IHNhbml0aXplciBleGNl
cHQgZm9yIFNhZmVTdGFjaworQ0ZMQUdTPSQoIGdyZXAgIkNGTEFHUy4qLWZzYW5pdGl6ZSIgY29u
ZmlnLWhvc3QubWFrIDI+L2Rldi9udWxsICkKK1NBTklUSVpFX0ZMQUdTPSIiCisjUmVtb3ZlIGFs
bCBvY2N1cnJlbmNpZXMgb2YgLWZzYW5pdGl6ZT1zYWZlLXN0YWNrCitmb3IgaSBpbiAke0NGTEFH
U307IGRvCisgICAgICAgIGlmIFsgIiR7aX0iICE9ICItZnNhbml0aXplPXNhZmUtc3RhY2siIF07
IHRoZW4KKyAgICAgICAgICAgICAgICBTQU5JVElaRV9GTEFHUz0iJHtTQU5JVElaRV9GTEFHU30g
JHtpfSIKKyAgICAgICAgZmkKK2RvbmUKK2lmIGVjaG8gJHtTQU5JVElaRV9GTEFHU30gfCBncmVw
IC1xICJcLWZzYW5pdGl6ZSIgMj4vZGV2L251bGw7IHRoZW4KKyAgICAjIEhhdmUgYSBzYW5pdGl6
ZSBmbGFnIHRoYXQgaXMgbm90IGFsbG93ZWQsIHN0b3AKICAgICBlY2hvICJTYW5pdGl6ZXJzIGFy
ZSBlbmFibGVkID09PiBOb3QgcnVubmluZyB0aGUgcWVtdS1pb3Rlc3RzLiIKICAgICBleGl0IDAK
IGZpCi0tIAoyLjI2LjIKCg==


