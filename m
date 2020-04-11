Return-Path: <SRS0=9/5m=53=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25128C2BA2B
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Apr 2020 13:07:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E75A520753
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Apr 2020 13:07:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ea21BXhd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E75A520753
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jNFqf-000410-4H
	for qemu-devel@archiver.kernel.org; Sat, 11 Apr 2020 09:07:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33238)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jNFnQ-00078B-Iq
 for qemu-devel@nongnu.org; Sat, 11 Apr 2020 09:03:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jNFnO-0002ZZ-Hz
 for qemu-devel@nongnu.org; Sat, 11 Apr 2020 09:03:40 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47216
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jNFnO-0002Z7-EF
 for qemu-devel@nongnu.org; Sat, 11 Apr 2020 09:03:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586610218;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=taSWfJvQWiJh1LHKH1Z4zjsoIVsofodaoPw9g1FbQ0g=;
 b=ea21BXhdanWcADdeIBsneGL9wuWkjnUf9B5ePu1jkVXMyIBGqRFZSIRLQrtOYChZUx5Mdf
 y+MONJOfyrsSbCd3Inr0uh5Mh8B0HkdOgqSPqbd+XyYJ8vW+rtV/sU8XpA1Jflup4mKpcC
 Vi8A/Dw1a15Bd0dUeUc4iItpbav2Y9E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-321-RY3z9BdZNYC9o0CcKaNh_A-1; Sat, 11 Apr 2020 09:03:35 -0400
X-MC-Unique: RY3z9BdZNYC9o0CcKaNh_A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 776241005513;
 Sat, 11 Apr 2020 13:03:34 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EDB3998A2B;
 Sat, 11 Apr 2020 13:03:31 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 2/8] oslib-posix: take lock before qemu_cond_broadcast
Date: Sat, 11 Apr 2020 09:03:24 -0400
Message-Id: <20200411130330.1993-3-pbonzini@redhat.com>
In-Reply-To: <20200411130330.1993-1-pbonzini@redhat.com>
References: <20200411130330.1993-1-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Bauerchen <bauerchen@tencent.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Bauerchen <bauerchen@tencent.com>

In touch_all_pages, if the mutex is not taken around qemu_cond_broadcast,
qemu_cond_broadcast may be called before all touch page threads enter
qemu_cond_wait. In this case, the touch page threads wait forever for the
main thread to wake them up, causing a deadlock.

Signed-off-by: Bauerchen <bauerchen@tencent.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 util/oslib-posix.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index 4dd6d7d4b4..062236a1ab 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
@@ -492,8 +492,11 @@ static bool touch_all_pages(char *area, size_t hpagesi=
ze, size_t numpages,
                            QEMU_THREAD_JOINABLE);
         addr +=3D memset_thread[i].numpages * hpagesize;
     }
+
+    qemu_mutex_lock(&page_mutex);
     threads_created_flag =3D true;
     qemu_cond_broadcast(&page_cond);
+    qemu_mutex_unlock(&page_mutex);
=20
     for (i =3D 0; i < memset_num_threads; i++) {
         qemu_thread_join(&memset_thread[i].pgthread);
--=20
2.18.2



