Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BF84C43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 17:09:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16D5E20665
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 17:09:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m9i/2UcY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16D5E20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57132 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igtsW-0005Q0-OO
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 12:09:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57567)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1igtFn-00063A-Fp
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:29:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1igtFm-0000mo-Fc
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:29:51 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:38453)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1igtFl-0000jV-PO
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:29:49 -0500
Received: by mail-wr1-x433.google.com with SMTP id y17so8052540wrh.5
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 08:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=hZVVOGkgb20bftRL1JMnXY5FFlbJTfG81bARHGzmB20=;
 b=m9i/2UcYLH3jc427b+umGKl+c4FrFCMLc2CJPAarBEeGlMEFUn+TkYEMDDE8LWkYuN
 +M22i1U5LE2Qa9fArBY3W/ZtHHxOjnJeHrF4/jvNhWRpzyxBDaQUtPS/aDOC7KneEpkB
 j4EDv8K4wX+xXGT/uHnQgeFxx+h2JZi2AJSw9+uwjjTOnqOapsYHyYrzqhCN719y65a4
 Ui5P4fAIMde5OnTuZ1eKv5Upr3BjFKj3v6ojMYROty3WSxSNqtlw77VD6z+Z6/6mI6UB
 pvQcG8AgBncfZ+oOjoPgH3djBpON9LIb0l2PNPPZSSmMUh/4d3Snbop+VWu8Kc3QxAJ9
 Weww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=hZVVOGkgb20bftRL1JMnXY5FFlbJTfG81bARHGzmB20=;
 b=be1mGSaXnVKXUVhX5a7SNN2H+sgz7GargtWfBfZhylI7PNNj+4s/g0llts28mVPavA
 Z1xx2IQfc6uRfgXoKjo4QxdcxAZ/BC7GBLHOW1LTvYIYv10f8vDFRaAivp7T+K0iqCRy
 CUapDgFGBsND3F2Us/1oJl8S4YcSgH8rz63hebgHUbLamb7tA8RVy/ZNXV/HpR2Ks6PO
 rKJbYVcMKUXG5N9xJwtjrQHwQutaqW+SBfmgb3y0bz+cvYFg4SoCUUy/PVqnHPz0c8sA
 LNKIsWctH0cKcMOfd0PHXfgme4FWAs7HhE8VB/ci6AK+46fTiDa8tiIiOx+QtlbP5mxA
 hkzw==
X-Gm-Message-State: APjAAAVehuro9Iu7ce5IOXDsadH5uViWeIIFiuDp6zYhyanxMkNsCeoO
 Zj+9heGQaeykKCXzCuvlnRhCWUkE
X-Google-Smtp-Source: APXvYqyv0DROpQUFpgQN5d+Da/7/8nZI4bwEGJMJRiK2/Q2QVJX7HuJ1Btj8FkQbTNHFECB4LOlOig==
X-Received: by 2002:a5d:4687:: with SMTP id u7mr31144180wrq.176.1576513788590; 
 Mon, 16 Dec 2019 08:29:48 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id q68sm19962334wme.14.2019.12.16.08.29.47
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 16 Dec 2019 08:29:48 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 61/62] memory: use RCU_READ_LOCK_GUARD
Date: Mon, 16 Dec 2019 17:28:45 +0100
Message-Id: <1576513726-53700-62-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576513726-53700-1-git-send-email-pbonzini@redhat.com>
References: <1576513726-53700-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::433
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
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/exec/memory.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index e499dc2..e42a9d7 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -2165,7 +2165,7 @@ MemTxResult address_space_read(AddressSpace *as, hwaddr addr,
 
     if (__builtin_constant_p(len)) {
         if (len) {
-            rcu_read_lock();
+            RCU_READ_LOCK_GUARD();
             fv = address_space_to_flatview(as);
             l = len;
             mr = flatview_translate(fv, addr, &addr1, &l, false, attrs);
@@ -2176,7 +2176,6 @@ MemTxResult address_space_read(AddressSpace *as, hwaddr addr,
                 result = flatview_read_continue(fv, addr, attrs, buf, len,
                                                 addr1, l, mr);
             }
-            rcu_read_unlock();
         }
     } else {
         result = address_space_read_full(as, addr, attrs, buf, len);
-- 
1.8.3.1



