Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96834C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 10:13:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 632E42073E
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 10:13:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hts+6BRE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 632E42073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48222 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmE1z-0006jp-MW
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 06:13:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50502)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jmDzt-0003r0-SK
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 06:11:45 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49348
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jmDzs-0004AS-8Q
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 06:11:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592561503;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tvUusN2KT2/dP9oHEXmn3+NtCB5T7EoWy8EJVdJdMj0=;
 b=Hts+6BREmnk/A17KsVr6gQSskf4bfNINw5k2VJS2IEjPOyFP61VrKW9xgcf0SEE1w8O0l3
 cyXF91/CWCpJh8iveAwkLbJQk4ceBYnvpc71Y8Z71mOPkgBL16fIl5cHkDEUoFImk9aKR1
 X4VjHM0nfx9CyjvRxPYaxm6mBxhuLFc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-376-UY1yfVY3PoSGfjQDR1wP5Q-1; Fri, 19 Jun 2020 06:11:42 -0400
X-MC-Unique: UY1yfVY3PoSGfjQDR1wP5Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1E6DA1800D4A;
 Fri, 19 Jun 2020 10:11:41 +0000 (UTC)
Received: from localhost (ovpn-113-212.ams2.redhat.com [10.36.113.212])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 128D15C1D0;
 Fri, 19 Jun 2020 10:11:37 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/2] qemu-storage-daemon: remember to add qemu_object_opts
Date: Fri, 19 Jun 2020 11:11:31 +0100
Message-Id: <20200619101132.2401756-2-stefanha@redhat.com>
In-Reply-To: <20200619101132.2401756-1-stefanha@redhat.com>
References: <20200619101132.2401756-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=205.139.110.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/19 05:19:18
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MIME_BASE64_TEXT=1.741, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

VGhlIC0tb2JqZWN0IG9wdGlvbiBpcyBzdXBwb3J0ZWQgYnkgcWVtdS1zdG9yYWdlLWRhZW1vbiBi
dXQgdGhlCnFlbXVfb2JqZWN0X29wdHMgUWVtdU9wdHNMaXN0IHdhc24ndCBiZWluZyBhZGRlZC4g
QXMgYSByZXN1bHQgY2FsbHMgdG8KcWVtdV9maW5kX29wdHMoIm9iamVjdCIpIGZhaWxlZCB3aXRo
ICJUaGVyZSBpcyBubyBvcHRpb24gZ3JvdXAKJ29iamVjdCciLgoKVGhpcyBwYXRjaCBmaXhlcyB0
aGUgb2JqZWN0LWRlbCBRTVAgY29tbWFuZC4KClNpZ25lZC1vZmYtYnk6IFN0ZWZhbiBIYWpub2N6
aSA8c3RlZmFuaGFAcmVkaGF0LmNvbT4KLS0tCiBxZW11LXN0b3JhZ2UtZGFlbW9uLmMgfCAxICsK
IDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQoKZGlmZiAtLWdpdCBhL3FlbXUtc3RvcmFn
ZS1kYWVtb24uYyBiL3FlbXUtc3RvcmFnZS1kYWVtb24uYwppbmRleCA5ZTdhZGZlM2E2Li5hMDFj
YmQ2MzcxIDEwMDY0NAotLS0gYS9xZW11LXN0b3JhZ2UtZGFlbW9uLmMKKysrIGIvcWVtdS1zdG9y
YWdlLWRhZW1vbi5jCkBAIC0zMTYsNiArMzE2LDcgQEAgaW50IG1haW4oaW50IGFyZ2MsIGNoYXIg
KmFyZ3ZbXSkKIAogICAgIG1vZHVsZV9jYWxsX2luaXQoTU9EVUxFX0lOSVRfUU9NKTsKICAgICBt
b2R1bGVfY2FsbF9pbml0KE1PRFVMRV9JTklUX1RSQUNFKTsKKyAgICBxZW11X2FkZF9vcHRzKCZx
ZW11X29iamVjdF9vcHRzKTsKICAgICBxZW11X2FkZF9vcHRzKCZxZW11X3RyYWNlX29wdHMpOwog
ICAgIHFjcnlwdG9faW5pdCgmZXJyb3JfZmF0YWwpOwogICAgIGJkcnZfaW5pdCgpOwotLSAKMi4y
Ni4yCgo=


