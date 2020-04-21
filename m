Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57228C54FCC
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 16:27:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 103D6206F4
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 16:27:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JnMIJDw9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 103D6206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQvkb-0001Rp-6L
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 12:27:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54084)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1jQveR-00011J-8m
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 12:21:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1jQveQ-0004DU-Lb
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 12:21:35 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:22107
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1jQveQ-0004Cz-7Y
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 12:21:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587486093;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OK+DIsPslG72w2IO6pbi47ldoAbHvOu1kXaqnZ0hY+0=;
 b=JnMIJDw9A3YKQa2ndHEPLR++TcJ9mdxdtTEF5OwBsvsR1VRuJkcEehg/HiKzFowssE4dYT
 MftHRWYpcuXEBbWtHXrDbjepj31Q5LngMGVr9xKKyra9AYz2vodoDwc+jipumK+z1VxWAO
 rtdSEDtKE37XPNkbiqJ69foN/uISabc=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-169-mbqNGD1CO82q49E-ozeCcw-1; Tue, 21 Apr 2020 12:21:31 -0400
X-MC-Unique: mbqNGD1CO82q49E-ozeCcw-1
Received: by mail-qv1-f70.google.com with SMTP id f4so14336537qvu.19
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2020 09:21:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=fRMHDItsx9hNNfR+euE1kI/dNdII4x7dwM+Q4RAjUSc=;
 b=aVuDdUIqcN5kUkxHEuGAopMeOYoCJ56OalqXqvTU/Y4cjIIcsu5VlGmHxl5GJCLCFM
 pMfT8Xm6CbrevRG2K0Hq7bHE6knFMIZsk+36bNb3h0FqVaXrn0bN+9DLLI54+MhOXUwi
 QB2DJgXDl7O42CEC8qv9suqh5Fpacr5anjRI1AlIcPtHrmPvps/vlCzpXapDV2E4/hEm
 3ToEOv9LbtJQ6+VyNPB5Ru/CoBWcWQWVpKwVbljvS2ICXEfF+HUiwXEozHLNENVd6rGY
 WMjueYHWP7M0ImsVijsLYcD8UbZkKc8G3B++H1YAPRkzxxy2TDnNULZXSdpbiqiLKrIS
 HNgw==
X-Gm-Message-State: AGi0Pub68w5TH4iqy85YFSiNtUh91f2zGh6B/A9Jb2OlFh7HvT1u+DuM
 EQdcAjI0XHC4S+IcbzpVXvbaqJf30WZe5FsIvsWpe02mnELEOYycZLTAPnKBL9fFiaDtm3nAlDw
 D4d0UmN1r/FwvN2g=
X-Received: by 2002:a0c:f70c:: with SMTP id w12mr21187007qvn.28.1587486090495; 
 Tue, 21 Apr 2020 09:21:30 -0700 (PDT)
X-Google-Smtp-Source: APiQypLkeQXvii5i6XbB/9MmopgbcRFNkqUjk07cE6Av4jZKy9ipmw+U72L7n+JYe6pzAUEgj1z44A==
X-Received: by 2002:a0c:f70c:: with SMTP id w12mr21186980qvn.28.1587486090289; 
 Tue, 21 Apr 2020 09:21:30 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id n10sm1888503qkk.105.2020.04.21.09.21.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2020 09:21:29 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 6/8] cpus: Introduce qemu_mutex_unlock_iothread_prepare()
Date: Tue, 21 Apr 2020 12:21:06 -0400
Message-Id: <20200421162108.594796-7-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200421162108.594796-1-peterx@redhat.com>
References: <20200421162108.594796-1-peterx@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/21 01:28:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, peterx@redhat.com,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The prepare function before unlocking BQL.  There're only three places that=
 can
release the BQL: unlock(), cond_wait() or cond_timedwait().

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 cpus.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/cpus.c b/cpus.c
index 5cbc3f30de..48aa295fea 100644
--- a/cpus.c
+++ b/cpus.c
@@ -1832,20 +1832,27 @@ void qemu_mutex_lock_iothread_impl(const char *file=
, int line)
     iothread_locked =3D true;
 }
=20
+static void qemu_mutex_unlock_iothread_prepare(void)
+{
+}
+
 void qemu_mutex_unlock_iothread(void)
 {
     g_assert(qemu_mutex_iothread_locked());
     iothread_locked =3D false;
+    qemu_mutex_unlock_iothread_prepare();
     qemu_mutex_unlock(&qemu_global_mutex);
 }
=20
 void qemu_cond_wait_iothread(QemuCond *cond)
 {
+    qemu_mutex_unlock_iothread_prepare();
     qemu_cond_wait(cond, &qemu_global_mutex);
 }
=20
 void qemu_cond_timedwait_iothread(QemuCond *cond, int ms)
 {
+    qemu_mutex_unlock_iothread_prepare();
     qemu_cond_timedwait(cond, &qemu_global_mutex, ms);
 }
=20
--=20
2.24.1


