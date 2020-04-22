Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEA10C55185
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 18:24:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA3082098B
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 18:24:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LsdWUXHe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA3082098B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55724 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRK2c-0000Xc-OQ
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 14:24:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50912)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alexander.duyck@gmail.com>) id 1jRJzk-000515-1y
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 14:21:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <alexander.duyck@gmail.com>) id 1jRJzj-0002cK-Jc
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 14:21:11 -0400
Received: from mail-qk1-x744.google.com ([2607:f8b0:4864:20::744]:45357)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander.duyck@gmail.com>)
 id 1jRJzh-0002OW-Jw
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 14:21:09 -0400
Received: by mail-qk1-x744.google.com with SMTP id m67so3408633qke.12
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2020 11:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:from:to:cc:date:message-id:in-reply-to:references
 :user-agent:mime-version:content-transfer-encoding;
 bh=r3DmuhsjF9XmFz6gfXOOjELEtTu/H+9BPOkgH77BTws=;
 b=LsdWUXHeOCv6U+GBDHwljJ6mvIk5lxR4xVsOEtIWPNz+D4ZiQ77ZuUvPJtLbFgn2UF
 ReKtV7zJE8wBtNubvuRZ7dEd8O9EyGmMTfwCG3GM1fB9/lWakHoMtrSQKDndAJCo2mNK
 gEGU+vcUClC+4EpnBMzEL+I0P2KW/OsiCKmQGU1cl/yH5Y67vVueLycSmvogES9jm15y
 ic/gClC+LoC220bdCt397kSMtatBdcwfdjWvH6vfNw5+e6uFlCz5+vCSP8jq6adyb9Ni
 8pAo4VjbbI+OeMrvYtgI50FaR3BUQFsohyEzxSMv07FjqwBGlRZUG95SIhdvKAL2uYMc
 dF8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
 :references:user-agent:mime-version:content-transfer-encoding;
 bh=r3DmuhsjF9XmFz6gfXOOjELEtTu/H+9BPOkgH77BTws=;
 b=W/yeCXGZwNca2l3v/ONhbDFReM3Yqtk3+pdiep71UuQWKNi2Wdqdwv1Y9uTBWC2j44
 4e9Dj2/W3YfOpfYnQR6wGXCRsmo6DYEuxQ35PwJ4IVNWmFLAE7/w1DX53DWiEvKMAISp
 tWWO0dLhmO1OE05UDqqYUFODDV7ae8OI8FfsVwoPpexD7TWqXVVbpcBp6YGihcwfNCvo
 UFuhU6UTuP3pKe+Hrfib8zqnAfJCd/Fs6Wq7smiPw9MWYWsJh6sHAQ5XI15zWtDGopG4
 TqDpU+QOeune66kq7FExeGoDRWYIL00GrywXFj/lwnsFnzAmW1UJx5SGpeOEXLU2am9g
 gfmw==
X-Gm-Message-State: AGi0PuZBwp6FpyoWHL5J0lwWJqMuIQlodnYu/S03cebsiIOY9UzIwk4J
 tkWFw5fngLT2SXAa2tEcAiqaACEm1/E=
X-Google-Smtp-Source: APiQypLWRMl5VLgsxPSxxQlLUOs9gHLc9Js+TPE2aDdys6oe9LdYq9QUa54y0nGVnjTffUqdakUL6w==
X-Received: by 2002:a37:881:: with SMTP id 123mr28207659qki.185.1587579668130; 
 Wed, 22 Apr 2020 11:21:08 -0700 (PDT)
Received: from localhost.localdomain ([2001:470:b:9c3:9e5c:8eff:fe4f:f2d0])
 by smtp.gmail.com with ESMTPSA id 60sm4460499qtb.95.2020.04.22.11.21.07
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 22 Apr 2020 11:21:07 -0700 (PDT)
Subject: [PATCH v21 QEMU 2/5] linux-headers: update to contain
 virito-balloon free page reporting
From: Alexander Duyck <alexander.duyck@gmail.com>
To: david@redhat.com, mst@redhat.com
Date: Wed, 22 Apr 2020 11:21:06 -0700
Message-ID: <20200422182106.12258.53215.stgit@localhost.localdomain>
In-Reply-To: <20200422181649.12258.37077.stgit@localhost.localdomain>
References: <20200422181649.12258.37077.stgit@localhost.localdomain>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::744;
 envelope-from=alexander.duyck@gmail.com; helo=mail-qk1-x744.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::744
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
Cc: virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alexander Duyck <alexander.h.duyck@linux.intel.com>

Sync the latest upstream changes for free page reporting. To be
replaced by a full linux header sync.

Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
---
 include/standard-headers/linux/virtio_balloon.h |    1 +
 1 file changed, 1 insertion(+)

diff --git a/include/standard-headers/linux/virtio_balloon.h b/include/standard-headers/linux/virtio_balloon.h
index af0a6b59dab2..af3b7a1fa263 100644
--- a/include/standard-headers/linux/virtio_balloon.h
+++ b/include/standard-headers/linux/virtio_balloon.h
@@ -36,6 +36,7 @@
 #define VIRTIO_BALLOON_F_DEFLATE_ON_OOM	2 /* Deflate balloon on OOM */
 #define VIRTIO_BALLOON_F_FREE_PAGE_HINT	3 /* VQ to report free pages */
 #define VIRTIO_BALLOON_F_PAGE_POISON	4 /* Guest is using page poisoning */
+#define VIRTIO_BALLOON_F_REPORTING	5 /* Page reporting virtqueue */
 
 /* Size of a PFN in the balloon interface. */
 #define VIRTIO_BALLOON_PFN_SHIFT 12


