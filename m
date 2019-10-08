Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95C25C4360C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 12:22:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C1C1206BB
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 12:22:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C1C1206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54778 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHoVF-0003Bw-GT
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 08:22:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57118)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iHoUX-0002kf-04
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 08:21:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iHoUU-0000C1-GE
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 08:21:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58502)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iHoUU-00005g-Ab
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 08:21:22 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D1DE210C030B;
 Tue,  8 Oct 2019 12:21:19 +0000 (UTC)
Received: from work-vm (ovpn-116-59.ams2.redhat.com [10.36.116.59])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0344F19D70;
 Tue,  8 Oct 2019 12:21:18 +0000 (UTC)
Date: Tue, 8 Oct 2019 13:21:16 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Wei Yang <richardw.yang@linux.intel.com>
Subject: Re: [PATCH] migration: use migration_is_active to represent active
 state
Message-ID: <20191008122116.GC3441@work-vm>
References: <20190717005341.14140-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190717005341.14140-1-richardw.yang@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.65]); Tue, 08 Oct 2019 12:21:19 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: qemu-devel@nongnu.org, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Wei Yang (richardw.yang@linux.intel.com) wrote:
> Wrap the check into a function to make it easy to read.
> 
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  include/migration/misc.h |  1 +
>  migration/migration.c    | 12 ++++++++----
>  2 files changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/include/migration/misc.h b/include/migration/misc.h
> index 5cdbabd094..42d6abc920 100644
> --- a/include/migration/misc.h
> +++ b/include/migration/misc.h
> @@ -61,6 +61,7 @@ void migration_object_init(void);
>  void migration_shutdown(void);
>  void qemu_start_incoming_migration(const char *uri, Error **errp);
>  bool migration_is_idle(void);
> +bool migration_is_active(MigrationState *);
>  void add_migration_state_change_notifier(Notifier *notify);
>  void remove_migration_state_change_notifier(Notifier *notify);
>  bool migration_in_setup(MigrationState *);
> diff --git a/migration/migration.c b/migration/migration.c
> index 43fd8297ef..4c066fc85c 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1529,8 +1529,7 @@ static void migrate_fd_cleanup(MigrationState *s)
>          qemu_fclose(tmp);
>      }
>  
> -    assert((s->state != MIGRATION_STATUS_ACTIVE) &&
> -           (s->state != MIGRATION_STATUS_POSTCOPY_ACTIVE));
> +    assert(!migration_is_active(s));
>  
>      if (s->state == MIGRATION_STATUS_CANCELLING) {
>          migrate_set_state(&s->state, MIGRATION_STATUS_CANCELLING,
> @@ -1690,6 +1689,12 @@ bool migration_is_idle(void)
>      return false;
>  }
>  
> +bool migration_is_active(MigrationState *s)
> +{
> +    return (s->state == MIGRATION_STATUS_ACTIVE ||
> +            s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE);
> +}
> +
>  void migrate_init(MigrationState *s)
>  {
>      /*
> @@ -3226,8 +3231,7 @@ static void *migration_thread(void *opaque)
>  
>      trace_migration_thread_setup_complete();
>  
> -    while (s->state == MIGRATION_STATUS_ACTIVE ||
> -           s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE) {
> +    while (migration_is_active(s)) {
>          int64_t current_time;
>  
>          if (urgent || !qemu_file_rate_limit(s->to_dst_file)) {
> -- 
> 2.17.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

