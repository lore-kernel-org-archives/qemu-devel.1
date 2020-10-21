Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE96EC4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 21:35:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12AB3223C7
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 21:35:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TnSffA8/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12AB3223C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37230 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVLlW-0002Cf-2I
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 17:35:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46826)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1kVLe4-0003H7-Cp
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 17:27:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:35106)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1kVLdz-00025w-Dk
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 17:27:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603315654;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cXAIBJAlfQRCJ7NOr2j/4Mg/y+8/XbU5hJsy4VMjNYE=;
 b=TnSffA8/Yd8fxyy965khc32qh7RVMpy2dnai8v58TodwUdlz1KyZe1DzvOUy3XTIfpgbwj
 sLKtUB4BpqZ4Xf3+XmHYvO6mm+RzDDFcnkWRmYBcrIEz8hdoe3MG3C1V8hWv11cMs7lqJV
 aHvtut31aGKFFsOQQcVRZy1a0tokHnk=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-122-FSw4oeMwP4m7bSn8XytjLg-1; Wed, 21 Oct 2020 17:27:33 -0400
X-MC-Unique: FSw4oeMwP4m7bSn8XytjLg-1
Received: by mail-qk1-f197.google.com with SMTP id s14so2639859qke.1
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2020 14:27:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=cXAIBJAlfQRCJ7NOr2j/4Mg/y+8/XbU5hJsy4VMjNYE=;
 b=MBVMMRFUvD7er3OmNCxYQyI0xx8tlR/ndsJRZkTRKlTYBL7xCiV9marLSEOzplos/J
 yWK7buKLDSsvNvUFmxuu9+lRqQiDuhGkgWoKN4z2tllWyujAn9uVG4kOYd9elUBLAhDo
 LM842EbYq/Gx9ZQpEHBFDTeMSx7Go5MPw7E+7vabxXKfDr9xDRHoicaWw8Flcr9vhdXA
 TQ6b5ax2CvnaMDppOOdXejcIECGK0oswUtsv30Rauc0MQjlGUQrrpwL20TbZl8MsR2XK
 4a4+i/BV5jU3WzCa/WuB0BPQoIkGKltrxjzrRPsofO+PmjyB8VmLnXiUM0Ygmrki3PMO
 Zu+Q==
X-Gm-Message-State: AOAM532y3A0nWNdGFxHG6/n1BVr72lYuqqJ9rrTN3ocgBL2dUPRMt1G0
 mZJdfq8MK9NtIRqbSC+5OwfjQafiLZPgje5bnI+7gWWghuAD+yMngI+3nDs0mDaFzkuNVG4OYih
 amrEzIKinArZo3/k=
X-Received: by 2002:a05:622a:1d4:: with SMTP id
 t20mr5161521qtw.173.1603315652167; 
 Wed, 21 Oct 2020 14:27:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx9vIjo4GQc6sAWwEBA9I+Tq3BUZgW2AY0FmipYOLK3dgBv+KaZ/BZxBqhk58ytGUfUmf04yA==
X-Received: by 2002:a05:622a:1d4:: with SMTP id
 t20mr5161500qtw.173.1603315651936; 
 Wed, 21 Oct 2020 14:27:31 -0700 (PDT)
Received: from xz-x1.redhat.com
 (toroon474qw-lp140-04-174-95-215-133.dsl.bell.ca. [174.95.215.133])
 by smtp.gmail.com with ESMTPSA id p187sm2089145qkf.70.2020.10.21.14.27.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2020 14:27:31 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 5/6] migration/postcopy: Release fd before going into
 'postcopy-pause'
Date: Wed, 21 Oct 2020 17:27:20 -0400
Message-Id: <20201021212721.440373-6-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201021212721.440373-1-peterx@redhat.com>
References: <20201021212721.440373-1-peterx@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=peterx@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 22:12:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Logically below race could trigger with the old code:

          test program                        migration thread
          ------------                        ----------------
       wait_until('postcopy-pause')
                                          postcopy_pause()
                                            set_state('postcopy-pause')
       do_postcopy_recover()
         arm s->to_dst_file with new fd
                                            release s->to_dst_file [1]

Here [1] could have released the just-installed recoverying channel.  Then the
migration could hang without really resuming.

Instead, it should be very safe to release the fd before setting the state into
'postcopy-pause', because there's no reason for any other thread to touch it
during 'postcopy-active'.

Dave reported a very rare postcopy recovery hang that the migration-test
program waited for the migration to complete in migrate_postcopy_complete().
We do suspect it's the same thing that we're gonna fix here.  Hard to tell.
However since we've noticed this, fix this irrelevant of the hang report.

Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index e3a958b299..20e04855d9 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -3178,9 +3178,6 @@ static MigThrError postcopy_pause(MigrationState *s)
     while (true) {
         QEMUFile *file;
 
-        migrate_set_state(&s->state, s->state,
-                          MIGRATION_STATUS_POSTCOPY_PAUSED);
-
         /* Current channel is possibly broken. Release it. */
         assert(s->to_dst_file);
         qemu_mutex_lock(&s->qemu_file_lock);
@@ -3191,6 +3188,9 @@ static MigThrError postcopy_pause(MigrationState *s)
         qemu_file_shutdown(file);
         qemu_fclose(file);
 
+        migrate_set_state(&s->state, s->state,
+                          MIGRATION_STATUS_POSTCOPY_PAUSED);
+
         error_report("Detected IO failure for postcopy. "
                      "Migration paused.");
 
-- 
2.26.2


