Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ED33C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 12:07:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E4E2207FC
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 12:07:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="biQYEVTh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E4E2207FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmFnS-00055D-Dg
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 08:07:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51512)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jmFj0-0006Tz-Vl
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 08:02:26 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25964
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jmFiz-0006iJ-AJ
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 08:02:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592568144;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=56JOwKR/P0lQLHwY/SoohBFH+hJsKtQ2Z3JzQYThtgI=;
 b=biQYEVThkjvmVKChM4a+3H3wjOgYB6E6By5oupihYyKOyTstiCj5ETc0Bj8LYbghjCWjgv
 wIhqqA/Ti9x3p2OhUzUF8CxANI6TU5znOpvrppFRUWS17NsynK1bZZFuB6gqN6dEMNg2QO
 de24g2ZLhUmgWqLtAkRBK9JgOo72Wsk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-231-pObxXxAlMwuBbptuzeNibA-1; Fri, 19 Jun 2020 08:02:23 -0400
X-MC-Unique: pObxXxAlMwuBbptuzeNibA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E8C92105250A;
 Fri, 19 Jun 2020 12:02:21 +0000 (UTC)
Received: from localhost (ovpn-113-212.ams2.redhat.com [10.36.113.212])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9F9AB60BF4;
 Fri, 19 Jun 2020 12:02:18 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Coiby Xu <coiby.xu@gmail.com>
Subject: [PATCH 4/6] block-helpers: use local_err in case errp is NULL
Date: Fri, 19 Jun 2020 13:01:55 +0100
Message-Id: <20200619120157.2422429-4-stefanha@redhat.com>
In-Reply-To: <20200619120157.2422429-1-stefanha@redhat.com>
References: <20200614183907.514282-4-coiby.xu@gmail.com>
 <20200619120157.2422429-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=207.211.31.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/19 03:15:03
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
Cc: kwolf@redhat.com, bharatlkmlkvm@gmail.com, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SWYgd2UgdXNlIGVycnAgdGhlbiB3ZSB3b24ndCBrbm93IHdoZW4gY2hlY2tfYmxvY2tfc2l6ZSgp
IGZhaWxzIHdoZW4KZXJycCBpcyBOVUxMLgoKVGhlIHB1cnBvc2Ugb2YgbG9jYWxfZXJyIGlzIHRv
IGRldGVjdCBhbiBlcnJvciBoYXMgb2NjdXJyZWQgZXZlbiBpZiB0aGUKY2FsbGVyIGRvZXNuJ3Qg
Y2FyZSBhYm91dCB0aGUgc3BlY2lmaWMgZXJyb3IgYW5kIGhhcyBwYXNzZWQgYSBOVUxMIGVycnAu
CgpTaWduZWQtb2ZmLWJ5OiBTdGVmYW4gSGFqbm9jemkgPHN0ZWZhbmhhQHJlZGhhdC5jb20+Ci0t
LQogaHcvY29yZS9xZGV2LXByb3BlcnRpZXMuYyB8IDUgKysrLS0KIDEgZmlsZSBjaGFuZ2VkLCAz
IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvaHcvY29yZS9xZGV2
LXByb3BlcnRpZXMuYyBiL2h3L2NvcmUvcWRldi1wcm9wZXJ0aWVzLmMKaW5kZXggMjhhNmQ4YjJl
ZS4uMGE2NTFjN2QzMiAxMDA2NDQKLS0tIGEvaHcvY29yZS9xZGV2LXByb3BlcnRpZXMuYworKysg
Yi9ody9jb3JlL3FkZXYtcHJvcGVydGllcy5jCkBAIC04MDAsOCArODAwLDkgQEAgc3RhdGljIHZv
aWQgc2V0X2Jsb2Nrc2l6ZShPYmplY3QgKm9iaiwgVmlzaXRvciAqdiwgY29uc3QgY2hhciAqbmFt
ZSwKICAgICAgICAgZXJyb3JfcHJvcGFnYXRlKGVycnAsIGxvY2FsX2Vycik7CiAgICAgICAgIHJl
dHVybjsKICAgICB9Ci0gICAgY2hlY2tfYmxvY2tfc2l6ZShkZXYtPmlkID8gOiAiIiwgbmFtZSwg
dmFsdWUsIGVycnApOwotICAgIGlmIChlcnJwKSB7CisgICAgY2hlY2tfYmxvY2tfc2l6ZShkZXYt
PmlkID8gOiAiIiwgbmFtZSwgdmFsdWUsICZsb2NhbF9lcnIpOworICAgIGlmIChsb2NhbF9lcnIp
IHsKKyAgICAgICAgZXJyb3JfcHJvcGFnYXRlKGVycnAsIGxvY2FsX2Vycik7CiAgICAgICAgIHJl
dHVybjsKICAgICB9CiAgICAgKnB0ciA9IHZhbHVlOwotLSAKMi4yNi4yCgo=


