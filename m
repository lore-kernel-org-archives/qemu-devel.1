Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D46E5C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 12:09:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 704EC2083B
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 12:09:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F5fqcGM6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 704EC2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37480 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmFpU-0007qm-M6
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 08:09:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51854)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jmFkK-0000vb-VQ
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 08:03:49 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26829
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jmFkI-0006o1-D9
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 08:03:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592568223;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nC2IQtKFOP6TahGTPavO4FBi7ihe9GoceBt0/eucKN8=;
 b=F5fqcGM6FmN73t/NaIkyu2dC6LYuZICJdnWs9ZZGQN7T4hFpA6vu4spgy8DDzb0MONSMjC
 cee5pcJwdS/ni0aqNcpVHoTbWKMoFmL5GHtGlL/ckPe05y6yL0xBkIY0vZF+GutuuaEjHX
 0h8Lrwpsp3v0loPcd2oSZuOeIzAHk2A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-457-oDkaV-E4Nu2Zc8IKxvT9Bw-1; Fri, 19 Jun 2020 08:03:41 -0400
X-MC-Unique: oDkaV-E4Nu2Zc8IKxvT9Bw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C63081005512;
 Fri, 19 Jun 2020 12:03:40 +0000 (UTC)
Received: from localhost (ovpn-113-212.ams2.redhat.com [10.36.113.212])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C8A575BAC3;
 Fri, 19 Jun 2020 12:03:34 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Coiby Xu <coiby.xu@gmail.com>
Subject: [PATCH 1/2] vhost-user-blk-server: adjust
 vhost_user_server_set_aio_context() arguments
Date: Fri, 19 Jun 2020 13:03:31 +0100
Message-Id: <20200619120332.2422664-1-stefanha@redhat.com>
In-Reply-To: <20200614183907.514282-5-coiby.xu@gmail.com>
References: <20200614183907.514282-5-coiby.xu@gmail.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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

VGhlIGZ1bmN0aW9uIGFyZ3VtZW50cyB3ZXJlIHJlb3JkZXJlZCBpbiBhIHByZXZpb3VzIHBhdGNo
LiBVc2UgdGhlIG5ldwpvcmRlcmluZy4KClNpZ25lZC1vZmYtYnk6IFN0ZWZhbiBIYWpub2N6aSA8
c3RlZmFuaGFAcmVkaGF0LmNvbT4KLS0tCiBibG9jay9leHBvcnQvdmhvc3QtdXNlci1ibGstc2Vy
dmVyLmMgfCA0ICsrLS0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRp
b25zKC0pCgpkaWZmIC0tZ2l0IGEvYmxvY2svZXhwb3J0L3Zob3N0LXVzZXItYmxrLXNlcnZlci5j
IGIvYmxvY2svZXhwb3J0L3Zob3N0LXVzZXItYmxrLXNlcnZlci5jCmluZGV4IGJiZjJjZWFhOWIu
LmJlZDNjNDM3MzcgMTAwNjQ0Ci0tLSBhL2Jsb2NrL2V4cG9ydC92aG9zdC11c2VyLWJsay1zZXJ2
ZXIuYworKysgYi9ibG9jay9leHBvcnQvdmhvc3QtdXNlci1ibGstc2VydmVyLmMKQEAgLTM1Miw3
ICszNTIsNyBAQCBzdGF0aWMgdm9pZCBibGtfYWlvX2F0dGFjaGVkKEFpb0NvbnRleHQgKmN0eCwg
dm9pZCAqb3BhcXVlKQogewogICAgIFZ1QmxvY2tEZXYgKnZ1Yl9kZXYgPSBvcGFxdWU7CiAgICAg
YWlvX2NvbnRleHRfYWNxdWlyZShjdHgpOwotICAgIHZob3N0X3VzZXJfc2VydmVyX3NldF9haW9f
Y29udGV4dChjdHgsICZ2dWJfZGV2LT52dV9zZXJ2ZXIpOworICAgIHZob3N0X3VzZXJfc2VydmVy
X3NldF9haW9fY29udGV4dCgmdnViX2Rldi0+dnVfc2VydmVyLCBjdHgpOwogICAgIGFpb19jb250
ZXh0X3JlbGVhc2UoY3R4KTsKIH0KIApAQCAtMzYxLDcgKzM2MSw3IEBAIHN0YXRpYyB2b2lkIGJs
a19haW9fZGV0YWNoKHZvaWQgKm9wYXF1ZSkKICAgICBWdUJsb2NrRGV2ICp2dWJfZGV2ID0gb3Bh
cXVlOwogICAgIEFpb0NvbnRleHQgKmN0eCA9IHZ1Yl9kZXYtPnZ1X3NlcnZlci5jdHg7CiAgICAg
YWlvX2NvbnRleHRfYWNxdWlyZShjdHgpOwotICAgIHZob3N0X3VzZXJfc2VydmVyX3NldF9haW9f
Y29udGV4dChOVUxMLCAmdnViX2Rldi0+dnVfc2VydmVyKTsKKyAgICB2aG9zdF91c2VyX3NlcnZl
cl9zZXRfYWlvX2NvbnRleHQoJnZ1Yl9kZXYtPnZ1X3NlcnZlciwgTlVMTCk7CiAgICAgYWlvX2Nv
bnRleHRfcmVsZWFzZShjdHgpOwogfQogCi0tIAoyLjI2LjIKCg==


