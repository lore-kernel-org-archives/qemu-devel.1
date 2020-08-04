Return-Path: <SRS0=UEgn=BO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A74DC433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 16:18:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5A512086A
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 16:18:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HUgAJ9lA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5A512086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59128 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2ze9-0005WL-3H
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 12:18:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47316)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1k2zcK-0003t8-Eh
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 12:16:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37980
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1k2zcI-0007C3-Oz
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 12:16:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596557802;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HtTsTBrmbkA5+awXwb04H1HVgFKNkM/ZIQZzvJHZ7YE=;
 b=HUgAJ9lAuWOsLFEDV/oAfEYFA2T/0ej8ithKFA5sHr546O26IZ3AUb7VgrlUYLPGn8K/r0
 IYMODyoUwioF0nXld7vpa5Zb0IqyeQttd9K3NPkrvN3dRT24N758DRf+eP0Pif0DjH/nuM
 kkAE6Q42PSPlqaaBaoIqZYz9D6TTdk8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-281-2EuLAOPwMI-mn61R-RPe7w-1; Tue, 04 Aug 2020 12:16:38 -0400
X-MC-Unique: 2EuLAOPwMI-mn61R-RPe7w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5A90779EC6;
 Tue,  4 Aug 2020 16:16:37 +0000 (UTC)
Received: from linux.fritz.box (ovpn-113-165.ams2.redhat.com [10.36.113.165])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5076C7B901;
 Tue,  4 Aug 2020 16:16:36 +0000 (UTC)
Date: Tue, 4 Aug 2020 18:16:34 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v6 02/12] monitor: Use getter/setter functions for cur_mon
Message-ID: <20200804161634.GC4860@linux.fritz.box>
References: <20200528153742.274164-1-kwolf@redhat.com>
 <20200528153742.274164-3-kwolf@redhat.com>
 <87lfiubmu3.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
In-Reply-To: <87lfiubmu3.fsf@dusky.pond.sub.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/04 01:28:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: marcandre.lureau@gmail.com, qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 04.08.2020 um 14:46 hat Markus Armbruster geschrieben:
> > diff --git a/monitor/hmp.c b/monitor/hmp.c
> > index d598dd02bb..f609fcf75b 100644
> > --- a/monitor/hmp.c
> > +++ b/monitor/hmp.c
> > @@ -1301,11 +1301,11 @@ cleanup:
> >  static void monitor_read(void *opaque, const uint8_t *buf, int size)
> >  {
> >      MonitorHMP *mon;
> > -    Monitor *old_mon = cur_mon;
> > +    Monitor *old_mon = monitor_cur();
> >      int i;
> >  
> > -    cur_mon = opaque;
> > -    mon = container_of(cur_mon, MonitorHMP, common);
> > +    monitor_set_cur(opaque);
> > +    mon = container_of(monitor_cur(), MonitorHMP, common);
> 
> Simpler:
> 
>        MonitorHMP *mon = container_of(opaque, MonitorHMP, common);

opaque is void*, so it doesn't have a field 'common'.

> > diff --git a/monitor/monitor.c b/monitor/monitor.c
> > index 125494410a..182ba136b4 100644
> > --- a/monitor/monitor.c
> > +++ b/monitor/monitor.c
> > @@ -66,13 +66,24 @@ MonitorList mon_list;
> >  int mon_refcount;
> >  static bool monitor_destroyed;
> >  
> > -__thread Monitor *cur_mon;
> > +static __thread Monitor *cur_monitor;
> > +
> > +Monitor *monitor_cur(void)
> > +{
> > +    return cur_monitor;
> > +}
> > +
> > +void monitor_set_cur(Monitor *mon)
> > +{
> > +    cur_monitor = mon;
> > +}
> 
> All uses of monitor_set_cur() look like this:
> 
>     old_mon = monitor_cur();
>     monitor_set_cur(new_mon);
>     ...
>     monitor_set_cur(old_mon);
> 
> If we let monitor_set_cur() return the old value, this becomes
> 
>     old_mon = monitor_set_cur(new_mon);
>     ...
>     monitor_set_cur(old_mon);
> 
> I like this better.

Fine with me.

> > diff --git a/stubs/monitor-core.c b/stubs/monitor-core.c
> > index 6cff1c4e1d..0cd2d864b2 100644
> > --- a/stubs/monitor-core.c
> > +++ b/stubs/monitor-core.c
> > @@ -3,7 +3,10 @@
> >  #include "qemu-common.h"
> >  #include "qapi/qapi-emit-events.h"
> >  
> > -__thread Monitor *cur_mon;
> > +Monitor *monitor_cur(void)
> > +{
> > +    return NULL;
> > +}
> 
> Is this meant to be called?  If not, abort().

error_report() and friends are supposed to be called pretty much
everywhere, so I'd say yes.

Kevin


