Return-Path: <SRS0=wgY8=XI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29F4DC49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 23:55:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E819B2083B
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 23:55:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TwuTqsUU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E819B2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48184 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8vPT-0001Ig-0Q
	for qemu-devel@archiver.kernel.org; Fri, 13 Sep 2019 19:55:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38487)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.weiyang@gmail.com>) id 1i8vOf-0000oo-4y
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 19:54:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.weiyang@gmail.com>) id 1i8vOe-0002WQ-09
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 19:54:37 -0400
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543]:37340)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.weiyang@gmail.com>)
 id 1i8vOd-0002Vc-Pw
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 19:54:35 -0400
Received: by mail-ed1-x543.google.com with SMTP id i1so28456862edv.4
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2019 16:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=r60rTeozZXg8fla4/9Hv53O1/pSsi8t2qM7w+ivltaU=;
 b=TwuTqsUUv4VJNsiXL2FxeZn9Tnp5L1nR/HQDz9Lx5xZBreylroPy2rOqUlUBhkrkNn
 eJ4HxkbCwo+gSxrstWqXT3oOXgNuEAXMhoHyuRIcvVRuQyDFhc/KmAVDGBXJwh9mQfhR
 E8FK3SWFeAQMm6Nyh3aVZB7c0Hu6u2jwPWmfAYuYsoqLJ6d9FfRGvsP/Wlxtdy3/rrEm
 bNcwRDx7629ItawMqx4OoXARW0zPiVeNBygRzmVmiSy9gxsFRSFNDEbGP6sevt2bLrH4
 lXfvjOUZJe3S7HWJFNwJ2/fgwTTgqKx+C2/9ZFRu5KPpaZg8Fw3ZeNaahMBhwLxYtJ0z
 ZFbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
 :references:mime-version:content-disposition:in-reply-to:user-agent;
 bh=r60rTeozZXg8fla4/9Hv53O1/pSsi8t2qM7w+ivltaU=;
 b=CkL3Dejh1QdiDxpcvpZIJA4K9DMGxVrl4NwqcYcWXYU5jj1BKssuxsoCe9OnuHs8jf
 yiwKQgVLfphU7yPgMXV7XhU/d79d1tajbCGSDGPNA8nkBuY6IR4qgU4yJ59dvrrd1ovR
 MeBq8KE8A58Ip1uDfj1q4faQGlVr+qOHh4MDZFFeR2cLnSyo+WhLsL3UnzmITH7Gzttv
 C2JTvs/5Yq0C4ud7HHWlDxyFXNE//9JBc8qn3S7ZUMrpy9Ti4ToJnHjh00UNp7JPYNoY
 DA0xZ2je5oy7Kqvesvr/qinz6T8+ECDQfXHCcE7HeZHRaI3VJ2Wa4p6OtgasA9YV6WWi
 WVCA==
X-Gm-Message-State: APjAAAU7hYKVOhMMzviGITN81MGybpL+FdhrCBbHy33EaenQ1cus3Bw7
 7fgrT4tT5wIVFRuRT7JE66o=
X-Google-Smtp-Source: APXvYqxmSbzKx2mGSqwNAYkOoZ+cGrzec4/2vowfUB6UucrzLWVyjlbGSEHG0U5MXrmDImhYzwjUfQ==
X-Received: by 2002:aa7:d0d1:: with SMTP id u17mr45001249edo.99.1568418874981; 
 Fri, 13 Sep 2019 16:54:34 -0700 (PDT)
Received: from localhost ([185.92.221.13])
 by smtp.gmail.com with ESMTPSA id gv20sm407383ejb.43.2019.09.13.16.54.34
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 13 Sep 2019 16:54:34 -0700 (PDT)
Date: Fri, 13 Sep 2019 23:54:33 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Wei Yang <richardw.yang@linux.intel.com>
Message-ID: <20190913235433.u66jqdhx4afnqae5@master>
References: <20190717005341.14140-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190717005341.14140-1-richardw.yang@linux.intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::543
Subject: Re: [Qemu-devel] [PATCH] migration: use migration_is_active to
 represent active state
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
Reply-To: Wei Yang <richard.weiyang@gmail.com>
Cc: quintela@redhat.com, qemu-devel@nongnu.org, dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jul 17, 2019 at 08:53:41AM +0800, Wei Yang wrote:
>Wrap the check into a function to make it easy to read.
>

Hi, Dave & Juan

Do you like this one :-) ?

>Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>---
> include/migration/misc.h |  1 +
> migration/migration.c    | 12 ++++++++----
> 2 files changed, 9 insertions(+), 4 deletions(-)
>
>diff --git a/include/migration/misc.h b/include/migration/misc.h
>index 5cdbabd094..42d6abc920 100644
>--- a/include/migration/misc.h
>+++ b/include/migration/misc.h
>@@ -61,6 +61,7 @@ void migration_object_init(void);
> void migration_shutdown(void);
> void qemu_start_incoming_migration(const char *uri, Error **errp);
> bool migration_is_idle(void);
>+bool migration_is_active(MigrationState *);
> void add_migration_state_change_notifier(Notifier *notify);
> void remove_migration_state_change_notifier(Notifier *notify);
> bool migration_in_setup(MigrationState *);
>diff --git a/migration/migration.c b/migration/migration.c
>index 43fd8297ef..4c066fc85c 100644
>--- a/migration/migration.c
>+++ b/migration/migration.c
>@@ -1529,8 +1529,7 @@ static void migrate_fd_cleanup(MigrationState *s)
>         qemu_fclose(tmp);
>     }
> 
>-    assert((s->state != MIGRATION_STATUS_ACTIVE) &&
>-           (s->state != MIGRATION_STATUS_POSTCOPY_ACTIVE));
>+    assert(!migration_is_active(s));
> 
>     if (s->state == MIGRATION_STATUS_CANCELLING) {
>         migrate_set_state(&s->state, MIGRATION_STATUS_CANCELLING,
>@@ -1690,6 +1689,12 @@ bool migration_is_idle(void)
>     return false;
> }
> 
>+bool migration_is_active(MigrationState *s)
>+{
>+    return (s->state == MIGRATION_STATUS_ACTIVE ||
>+            s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE);
>+}
>+
> void migrate_init(MigrationState *s)
> {
>     /*
>@@ -3226,8 +3231,7 @@ static void *migration_thread(void *opaque)
> 
>     trace_migration_thread_setup_complete();
> 
>-    while (s->state == MIGRATION_STATUS_ACTIVE ||
>-           s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE) {
>+    while (migration_is_active(s)) {
>         int64_t current_time;
> 
>         if (urgent || !qemu_file_rate_limit(s->to_dst_file)) {
>-- 
>2.17.1
>

-- 
Wei Yang
Help you, Help me

