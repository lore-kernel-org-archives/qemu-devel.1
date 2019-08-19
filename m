Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1ADDC3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 13:33:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C9BE2085A
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 13:33:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hIl6Sb32"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C9BE2085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51450 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzhnF-00061L-AR
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 09:33:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54525)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.weiyang@gmail.com>) id 1hzhmB-0005ZH-Le
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 09:32:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.weiyang@gmail.com>) id 1hzhmA-0003hF-F9
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 09:32:47 -0400
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541]:43919)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.weiyang@gmail.com>)
 id 1hzhmA-0003gC-5u
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 09:32:46 -0400
Received: by mail-ed1-x541.google.com with SMTP id h13so1667905edq.10
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2019 06:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=droXX8cbi6nF13djCbKMOABbMDZirQUCO428cqGPh3E=;
 b=hIl6Sb32qbjhdUA+GS0AKYW0pPVvF0erQU7OF56lTi1Vo9tG88CqI6U4OFixitvw8h
 gZvXKV1J3LrbLDbKKt3UWW/iMfNjhJAGFjjydzcqJ6SQ2Vfw/48I/m1rIShpGgrYkY0+
 VMSnokil+yeKbHmc/FasKlBsf23QHzrHy26r1UONEKiVhFGnS40C1ddLU+HMH3aXrhxR
 pASIa0iySxwKRxoNmh8+3TE2YQaO8JwAVPSN7s1tbpnaM/9DiARoGZUVPSRsJSbetWEp
 43N1wLEI0yDhT84kF3nGBvd+Sg1+xhgAWTwd5mDnUajyv0kvtDGHQHxqx3TLtfG3OCW/
 AFpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
 :references:mime-version:content-disposition:in-reply-to:user-agent;
 bh=droXX8cbi6nF13djCbKMOABbMDZirQUCO428cqGPh3E=;
 b=QIRsK/6zXpwz382ip8PdOP18AprlEvpAF1fvl+c7rCZyKuaN0pGfxGhAHOa7zm3gne
 6jaOa5h1W1xUojBph06fNuewd3U3eqFwVbm8jd64RODhHccJBOZaAJTz08xjXtFSrEm3
 93K+/7/e4kqTRdbmzBk0g0WkCNVN3rTncgWaLriA1WE+5X4AKBnrm2uUYhE72qVP8ReP
 7tQ/AVa7SQrcCsXL/i6ZvDBgY5i4g8suubvymgjm2vcRFATMQQe44NhL/dKODdvoYiep
 StjST1winj3u8BWEEOZVF4daswVPbEGupSW1aSSec9+xx5XlMaCgjf/FU6IWzTOpWorL
 gIqQ==
X-Gm-Message-State: APjAAAVzkTu3zx2wnNzbqBHMkKgPmNuzy7uPlyoHfRqn0qLP3G+gxAXv
 dJheGQS0BfMfBuSVbO637es=
X-Google-Smtp-Source: APXvYqy5KKGYUh/BzePpkONOw9xIg9FOHzPgOrpk6zZppFDErR6WWMVKVkrh+ZjcJLNk/wMeTy53tQ==
X-Received: by 2002:a17:906:f145:: with SMTP id
 gw5mr11058907ejb.34.1566221564355; 
 Mon, 19 Aug 2019 06:32:44 -0700 (PDT)
Received: from localhost ([185.92.221.13])
 by smtp.gmail.com with ESMTPSA id z24sm2829186edc.65.2019.08.19.06.32.43
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 19 Aug 2019 06:32:43 -0700 (PDT)
Date: Mon, 19 Aug 2019 13:32:42 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190819133242.dczpmpoq73suhklx@master>
References: <20190621142739.23703-1-richardw.yang@linux.intel.com>
 <20190819032947.GB18468@richard> <20190819112655.GB2765@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190819112655.GB2765@work-vm>
User-Agent: NeoMutt/20170113 (1.7.2)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::541
Subject: Re: [Qemu-devel] [PATCH] migrtion: define
 MigrationState/MigrationIncomingState.state as MigrationStatus
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
Cc: quintela@redhat.com, Wei Yang <richardw.yang@linux.intel.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Aug 19, 2019 at 12:26:55PM +0100, Dr. David Alan Gilbert wrote:
>* Wei Yang (richardw.yang@linux.intel.com) wrote:
>> On Fri, Jun 21, 2019 at 10:27:39PM +0800, Wei Yang wrote:
>> >No functional change. Add default case to fix warning.
>> >
>> 
>> Hi, David & Juan
>> 
>> Do you like this?
>
>See other reply; but you are making patches a bit faster than I can
>review them!
>

Sorry for that, my fault.

>Dave
>
>> >Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>> >---
>> > migration/migration.c | 8 +++++++-
>> > migration/migration.h | 6 +++---
>> > 2 files changed, 10 insertions(+), 4 deletions(-)
>> >
>> >diff --git a/migration/migration.c b/migration/migration.c
>> >index 2865ae3fa9..0fd2364961 100644
>> >--- a/migration/migration.c
>> >+++ b/migration/migration.c
>> >@@ -946,6 +946,8 @@ static void fill_source_migration_info(MigrationInfo *info)
>> >     case MIGRATION_STATUS_CANCELLED:
>> >         info->has_status = true;
>> >         break;
>> >+    default:
>> >+        return;
>> >     }
>> >     info->status = s->state;
>> > }
>> >@@ -1054,6 +1056,8 @@ static void fill_destination_migration_info(MigrationInfo *info)
>> >         info->has_status = true;
>> >         fill_destination_postcopy_migration_info(info);
>> >         break;
>> >+    default:
>> >+        return;
>> >     }
>> >     info->status = mis->state;
>> > }
>> >@@ -1446,7 +1450,7 @@ void qmp_migrate_start_postcopy(Error **errp)
>> > 
>> > /* shared migration helpers */
>> > 
>> >-void migrate_set_state(int *state, int old_state, int new_state)
>> >+void migrate_set_state(MigrationStatus *state, int old_state, int new_state)
>> > {
>> >     assert(new_state < MIGRATION_STATUS__MAX);
>> >     if (atomic_cmpxchg(state, old_state, new_state) == old_state) {
>> >@@ -1683,6 +1687,8 @@ bool migration_is_idle(void)
>> >         return false;
>> >     case MIGRATION_STATUS__MAX:
>> >         g_assert_not_reached();
>> >+    default:
>> >+        g_assert_not_reached();
>> >     }
>> > 
>> >     return false;
>> >diff --git a/migration/migration.h b/migration/migration.h
>> >index 5e8f09c6db..418ee00053 100644
>> >--- a/migration/migration.h
>> >+++ b/migration/migration.h
>> >@@ -65,7 +65,7 @@ struct MigrationIncomingState {
>> > 
>> >     QEMUBH *bh;
>> > 
>> >-    int state;
>> >+    MigrationStatus state;
>> > 
>> >     bool have_colo_incoming_thread;
>> >     QemuThread colo_incoming_thread;
>> >@@ -151,7 +151,7 @@ struct MigrationState
>> >     /* params from 'migrate-set-parameters' */
>> >     MigrationParameters parameters;
>> > 
>> >-    int state;
>> >+    MigrationStatus state;
>> > 
>> >     /* State related to return path */
>> >     struct {
>> >@@ -234,7 +234,7 @@ struct MigrationState
>> >     bool decompress_error_check;
>> > };
>> > 
>> >-void migrate_set_state(int *state, int old_state, int new_state);
>> >+void migrate_set_state(MigrationStatus *state, int old_state, int new_state);
>> > 
>> > void migration_fd_process_incoming(QEMUFile *f);
>> > void migration_ioc_process_incoming(QIOChannel *ioc, Error **errp);
>> >-- 
>> >2.19.1
>> 
>> -- 
>> Wei Yang
>> Help you, Help me
>--
>Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

-- 
Wei Yang
Help you, Help me

