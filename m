Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47296C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 14:51:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 117C52081A
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 14:51:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f5bFyUet"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 117C52081A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60600 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jb3aV-0003kT-8a
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 10:51:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44198)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jb3Zh-0002VF-I1
 for qemu-devel@nongnu.org; Tue, 19 May 2020 10:50:33 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:41244
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jb3Zg-0002Mv-8F
 for qemu-devel@nongnu.org; Tue, 19 May 2020 10:50:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589899831;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=J9a8OMPGHHcvAQHYPMu0j2PBUOZZuVTRahZ0ZBMTIm0=;
 b=f5bFyUetOL6UWnRpcCNpiX8XcdspTh968dnCXQKGhO7H9wWhBnqy+HIQbfzpzwFL+Qe6w0
 Nzv67lvYgoZDskRBEtbqxx4funfJ+BAWVmuhc8I6zAgFvQFNqRHu2obH1iDbnG9mRAcxBP
 67ZBDRkS8CKKJ264De88TsWrTWzL8YI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-382-kiGMppGtOlSKEJ366xdUzA-1; Tue, 19 May 2020 10:50:27 -0400
X-MC-Unique: kiGMppGtOlSKEJ366xdUzA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9A84A85B68B;
 Tue, 19 May 2020 14:50:25 +0000 (UTC)
Received: from work-vm (ovpn-114-247.ams2.redhat.com [10.36.114.247])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D46801059583;
 Tue, 19 May 2020 14:50:22 +0000 (UTC)
Date: Tue, 19 May 2020 15:50:20 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Lukas Straub <lukasstraub2@web.de>
Subject: Re: [PATCH 5/6] migration/qemu-file.c: Don't ratelimit a shutdown fd
Message-ID: <20200519145020.GG2798@work-vm>
References: <cover.1589193382.git.lukasstraub2@web.de>
 <f3ea4250e6982598ffffc73924a6917dbc823c87.1589193382.git.lukasstraub2@web.de>
 <1dc261c8dce6421b80071c0eb3528afd@huawei.com>
 <20200518115534.GD2786@work-vm> <20200519150846.2b0aa66f@luklap>
MIME-Version: 1.0
In-Reply-To: <20200519150846.2b0aa66f@luklap>
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/18 23:19:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 T_HK_NAME_DR=0.01, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Juan Quintela <quintela@redhat.com>,
 Zhanghailiang <zhang.zhanghailiang@huawei.com>,
 qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Lukas Straub (lukasstraub2@web.de) wrote:
> On Mon, 18 May 2020 12:55:34 +0100
> "Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> 
> > * Zhanghailiang (zhang.zhanghailiang@huawei.com) wrote:
> > > > This causes the migration thread to hang if we failover during checkpoint. A
> > > > shutdown fd won't cause network traffic anyway.
> > > >   
> > > 
> > > I'm not quite sure if this modification can take side effect on normal migration process or not,
> > > There are several places calling it.
> > > 
> > > Maybe Juan and Dave can help ;)
> > >   
> > > > Signed-off-by: Lukas Straub <lukasstraub2@web.de>
> > > > ---
> > > >  migration/qemu-file.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/migration/qemu-file.c b/migration/qemu-file.c index
> > > > 1c3a358a14..0748b5810f 100644
> > > > --- a/migration/qemu-file.c
> > > > +++ b/migration/qemu-file.c
> > > > @@ -660,7 +660,7 @@ int64_t qemu_ftell(QEMUFile *f)  int
> > > > qemu_file_rate_limit(QEMUFile *f)  {
> > > >      if (f->shutdown) {
> > > > -        return 1;
> > > > +        return 0;
> > > >      }  
> > 
> > This looks wrong to me; I'd be curious to understand how it's hanging
> > for you.
> > '1' means 'stop what you're doing', 0 means carry on; carrying on with a
> > shutdown fd sounds wrong.
> > 
> > If we look at ram.c we have:
> > 
> >         while ((ret = qemu_file_rate_limit(f)) == 0 ||
> >                 !QSIMPLEQ_EMPTY(&rs->src_page_requests)) {
> >             int pages;
> >         ....
> > 
> > so if it returns '1', as it does at the moment it should cause it to
> > exit the ram_save_iterate loop - which is what we want if it's failing.
> > Thus I think you need to find the actual place it's stuck in this case -
> > I suspect it's repeatedly calling ram_save_iterate and then exiting it,
> > but if that's happening perhaps we're missing a qemu_file_get_error
> > check somewhere.
> 
> Hi,
> the problem is in ram_save_host_page and migration_rate_limit, here is a backtrace:

Ah...

> #0  0x00007f7b502921a8 in futex_abstimed_wait_cancelable (private=0, abstime=0x7f7ada7fb3f0, clockid=0, expected=0, futex_word=0x55bc358b9908) at ../sysdeps/unix/sysv/linux/futex-internal.h:208
> #1  do_futex_wait (sem=sem@entry=0x55bc358b9908, abstime=abstime@entry=0x7f7ada7fb3f0, clockid=0) at sem_waitcommon.c:112
> #2  0x00007f7b502922d3 in __new_sem_wait_slow (sem=0x55bc358b9908, abstime=0x7f7ada7fb3f0, clockid=0) at sem_waitcommon.c:184
> #3  0x000055bc3382b6c1 in qemu_sem_timedwait (sem=0x55bc358b9908, ms=100) at util/qemu-thread-posix.c:306
> #4  0x000055bc3363950b in migration_rate_limit () at migration/migration.c:3365

OK, so how about:

diff --git a/migration/migration.c b/migration/migration.c
index b6b662e016..4e885385a8 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -3356,6 +3356,10 @@ bool migration_rate_limit(void)
     bool urgent = false;
     migration_update_counters(s, now);
     if (qemu_file_rate_limit(s->to_dst_file)) {
+
+        if (qemu_file_get_error(mis->from_src_file)) {
+            return false;
+        }
         /*
          * Wait for a delay to do rate limiting OR
          * something urgent to post the semaphore.

Does that work?
I wonder if we also need to kick the rate_limit_sem when we yank the
socket.

Dave

> #5  0x000055bc332b70d3 in ram_save_host_page (rs=0x7f7acc001a70, pss=0x7f7ada7fb4b0, last_stage=true) at /home/lukas/qemu/migration/ram.c:1696
> #6  0x000055bc332b71fa in ram_find_and_save_block (rs=0x7f7acc001a70, last_stage=true) at /home/lukas/qemu/migration/ram.c:1750
> #7  0x000055bc332b8bbd in ram_save_complete (f=0x55bc36661330, opaque=0x55bc33fbc678 <ram_state>) at /home/lukas/qemu/migration/ram.c:2606
> #8  0x000055bc3364112c in qemu_savevm_state_complete_precopy_iterable (f=0x55bc36661330, in_postcopy=false) at migration/savevm.c:1344
> #9  0x000055bc33641556 in qemu_savevm_state_complete_precopy (f=0x55bc36661330, iterable_only=true, inactivate_disks=false) at migration/savevm.c:1442
> #10 0x000055bc33641982 in qemu_savevm_live_state (f=0x55bc36661330) at migration/savevm.c:1569
> #11 0x000055bc33645407 in colo_do_checkpoint_transaction (s=0x55bc358b9840, bioc=0x7f7acc059990, fb=0x7f7acc4627b0) at migration/colo.c:464
> #12 0x000055bc336457ca in colo_process_checkpoint (s=0x55bc358b9840) at migration/colo.c:589
> #13 0x000055bc336459e4 in migrate_start_colo_process (s=0x55bc358b9840) at migration/colo.c:666
> #14 0x000055bc336393d7 in migration_iteration_finish (s=0x55bc358b9840) at migration/migration.c:3312
> #15 0x000055bc33639753 in migration_thread (opaque=0x55bc358b9840) at migration/migration.c:3477
> #16 0x000055bc3382bbb5 in qemu_thread_start (args=0x55bc357c27c0) at util/qemu-thread-posix.c:519
> #17 0x00007f7b50288f27 in start_thread (arg=<optimized out>) at pthread_create.c:479
> #18 0x00007f7b501ba31f in clone () at ../sysdeps/unix/sysv/linux/x86_64/clone.S:95
> 
> It hangs in ram_save_host_page for at least 10 Minutes.
> 
> Regards,
> Lukas Straub
> 
> > Dave
> > 
> > > >      if (qemu_file_get_error(f)) {
> > > >          return 1;
> > > > --
> > > > 2.20.1  
> > >   
> > --
> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> > 
> 


--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


