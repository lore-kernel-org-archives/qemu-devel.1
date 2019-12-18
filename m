Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7282EC43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 12:25:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41B2521582
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 12:25:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rCSv5bNz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41B2521582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53422 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihYOi-0003F8-12
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 07:25:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47689)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ihY38-0006Ic-0m
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:03:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ihY36-0000WM-EX
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:03:29 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:38306)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ihY35-0000T7-P1
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:03:27 -0500
Received: by mail-wr1-x441.google.com with SMTP id y17so2010285wrh.5
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 04:03:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=0e9iZbZwVOF2w7GIO2zU28bMFshOQAQOAmPOJxZU0us=;
 b=rCSv5bNzkE6a+ZVDTCqrxIsa2bGL3+gU5ilt1Am50Q5Eb+IWwWppIypqbzIpBzxCHE
 /kTrmSd+dvqim7HDCtGvCK6+N1sONdc7uN6R0T7Je/jmwscCb+N4MA/NeNBvrOryOjXE
 Unwl5M4jAeiMn1IsTcHAOhWYYB1XA3EgAA205mzd9fe57zoZebayOfnCjXAMb/m1Bf4o
 URTaBGJfp9t+G+y3u0EYgbUHQaA+IGxQ6QWn6m1jP0l49ZzugUB79ZGhjvIZhz3ITz8r
 i+QHN3y+HzQSuAt63qVhQLqtCy7UrSwVXH7s9L1S/siyw9rOXpWfosvoZrPORk467naJ
 ZGyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=0e9iZbZwVOF2w7GIO2zU28bMFshOQAQOAmPOJxZU0us=;
 b=JAg0JeJfgoXvMy/m2i1AZ9sdmc5OolBKWL8p50WUzloryF3R+jZcL6vMAOBb4ROuAM
 sJpCkkp+1KDzT3cKmiJB/OXcUZDaE0HhTtoVFRXrppduJBsBPH1znxabrOHOc3U88KB9
 ZlryT+EkcsWxKOpRThQgRx/B7HZhCWom/LyH8Zbz12wIsGtqDK2y0rllX1gKlxin+4dz
 fkkWVM+MwLu0QFV+q7iFfheQQycu8H9ueDOSl3et4MPsiU4WoVz5ZPQGFm0cwx23NFD/
 DRMw6S8vTWYFiDyOTU87FVc5f425MuncR28qhLYnrvGEx6XPP3eDQ6NYnC+tyNvoZAJV
 pQDg==
X-Gm-Message-State: APjAAAUdsCrE2dvxOVTY6zbRb1JWB8lfkdgJ9y404Ih1KHMpePHdbyWU
 SmhuHniFeTssko5GaQrqAG35Q/xo
X-Google-Smtp-Source: APXvYqyfDgicVsOuPxkMeKjpzWR4ecSzCY7LsGkprmQxaJp4aNKPZ0CK2/LpMbP2cqIeZmUruYGvFw==
X-Received: by 2002:adf:e984:: with SMTP id h4mr2380406wrm.275.1576670606354; 
 Wed, 18 Dec 2019 04:03:26 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id n67sm2236838wmf.46.2019.12.18.04.03.25
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 18 Dec 2019 04:03:25 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 31/87] object: Improve documentation of interfaces
Date: Wed, 18 Dec 2019 13:01:57 +0100
Message-Id: <1576670573-48048-32-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576670573-48048-1-git-send-email-pbonzini@redhat.com>
References: <1576670573-48048-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Greg Kurz <groug@kaod.org>

QOM interfaces allow a limited form of multiple inheritance, at the
condition of being stateless. That is, they cannot be instantiated
and a pointer to an interface shouldn't be dereferenceable in any way.
This is achieved by making the QOM instance type an incomplete type,
which is, as mentioned by Markus Armbruster, the closest you can get
to abstract class in C.

Incomplete types are widely used to hide implementation details, but
people usually expect to find at least one place where the type is
fully defined. The fact that it doesn't happen with QOM interfaces is
quite disturbing, especially since it isn't documented anywhere as
recently discussed in this thread:

https://lists.gnu.org/archive/html/qemu-devel/2019-12/msg01579.html

Amend the documentation in the object.h header file to provide more
details about why and how to implement QOM interfaces using incomplete
types.

Signed-off-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/qom/object.h | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index f9ad692..bd68d19 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -200,8 +200,14 @@ typedef struct InterfaceInfo InterfaceInfo;
  *
  * Interfaces allow a limited form of multiple inheritance.  Instances are
  * similar to normal types except for the fact that are only defined by
- * their classes and never carry any state.  You can dynamically cast an object
- * to one of its #Interface types and vice versa.
+ * their classes and never carry any state.  As a consequence, a pointer to
+ * an interface instance should always be of incomplete type in order to be
+ * sure it cannot be dereferenced.  That is, you should define the
+ * 'typedef struct SomethingIf SomethingIf' so that you can pass around
+ * 'SomethingIf *si' arguments, but not define a 'struct SomethingIf { ... }'.
+ * The only things you can validly do with a 'SomethingIf *' are to pass it as
+ * an argument to a method on its corresponding SomethingIfClass, or to
+ * dynamically cast it to an object that implements the interface.
  *
  * # Methods #
  *
-- 
1.8.3.1



