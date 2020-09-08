Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87291C43461
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 14:44:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17A14223E4
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 14:44:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KDo0gh8c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17A14223E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46248 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFerJ-0000ix-7C
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 10:44:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43406)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kFepz-0007Qt-VI
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 10:43:12 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53749
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kFepx-000144-0E
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 10:43:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599576187;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lQ69k2C9pi1QXHJydLvHwOiKpNBrQkn/tdpJx/S6xWk=;
 b=KDo0gh8cyjEW1VMKwvkA3io8U1GqjbeYUy4cDHYoPLvhXuFQWWl/hcoy/a0gvF5iloT53L
 gLTkyF4Zq04syQ9k/zRx2Pxa24agyZ1U7FeNpQCMUqWm5h2r/M8WbKdwvp1H/IZQ+iyHxP
 PJkobaruUZO+mOBH4U0I4epwEEoW6cU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-543-KLaBNWZgMralfgZjXnF0nw-1; Tue, 08 Sep 2020 10:43:05 -0400
X-MC-Unique: KLaBNWZgMralfgZjXnF0nw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1935C801AE6
 for <qemu-devel@nongnu.org>; Tue,  8 Sep 2020 14:43:04 +0000 (UTC)
Received: from work-vm (ovpn-114-204.ams2.redhat.com [10.36.114.204])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5DDF73A40;
 Tue,  8 Sep 2020 14:43:03 +0000 (UTC)
Date: Tue, 8 Sep 2020 15:43:00 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH] monitor: Use LOCK_GUARD macros
Message-ID: <20200908144300.GK3295@work-vm>
References: <20200908135240.130403-1-dgilbert@redhat.com>
 <87363s8i34.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
In-Reply-To: <87363s8i34.fsf@dusky.pond.sub.org>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/08 00:33:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Markus Armbruster (armbru@redhat.com) wrote:
> "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com> writes:
> 
> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> >
> > Use the lock guard macros in monitor/misc.c - saves
> > a bunch of goto's, and a temporary variable, but mostly
> > because I prefer not having to release them in error paths.
> >
> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > ---
> >  monitor/misc.c | 62 ++++++++++++++++----------------------------------
> >  1 file changed, 20 insertions(+), 42 deletions(-)
> >
> > diff --git a/monitor/misc.c b/monitor/misc.c
> > index e847b58a8c..7f0b313d53 100644
> > --- a/monitor/misc.c
> > +++ b/monitor/misc.c
> > @@ -141,13 +141,13 @@ char *qmp_human_monitor_command(const char *command_line, bool has_cpu_index,
> >      handle_hmp_command(&hmp, command_line);
> >      cur_mon = old_mon;
> >  
> > -    qemu_mutex_lock(&hmp.common.mon_lock);
> > -    if (qstring_get_length(hmp.common.outbuf) > 0) {
> > -        output = g_strdup(qstring_get_str(hmp.common.outbuf));
> > -    } else {
> > -        output = g_strdup("");
> > +    WITH_QEMU_LOCK_GUARD(&hmp.common.mon_lock) {
> > +        if (qstring_get_length(hmp.common.outbuf) > 0) {
> > +            output = g_strdup(qstring_get_str(hmp.common.outbuf));
> > +        } else {
> > +            output = g_strdup("");
> > +        }
> >      }
> > -    qemu_mutex_unlock(&hmp.common.mon_lock);
> >  
> >  out:
> >      monitor_data_destroy(&hmp.common);
> 
> 
> Hardly an improvement here.  I figure you want it for the sake of
> consistency.

Right, I was trying to do all the ones that weren't
worse;  there's one case I left where it explicitly needed to do
something after the unlock.

> > @@ -1248,7 +1248,7 @@ void qmp_getfd(const char *fdname, Error **errp)
> >          return;
> >      }
> >  
> > -    qemu_mutex_lock(&cur_mon->mon_lock);
> > +    QEMU_LOCK_GUARD(&cur_mon->mon_lock);
> >      QLIST_FOREACH(monfd, &cur_mon->fds, next) {
> >          if (strcmp(monfd->name, fdname) != 0) {
> >              continue;
> > @@ -1256,7 +1256,6 @@ void qmp_getfd(const char *fdname, Error **errp)
> >  
> >          tmp_fd = monfd->fd;
> >          monfd->fd = fd;
> > -        qemu_mutex_unlock(&cur_mon->mon_lock);
> >          /* Make sure close() is outside critical section */
> >          close(tmp_fd);
> >          return;
> > @@ -1267,7 +1266,6 @@ void qmp_getfd(const char *fdname, Error **errp)
> >      monfd->fd = fd;
> >  
> >      QLIST_INSERT_HEAD(&cur_mon->fds, monfd, next);
> > -    qemu_mutex_unlock(&cur_mon->mon_lock);
> >  }
> >  
> 
> This one makes more sense.
> 
> [More of the same...]
> 
> Reviewed-by: Markus Armbruster <armbru@redhat.com>

Thanks.

Dave

-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


