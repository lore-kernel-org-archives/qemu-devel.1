Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 789F7ECE58D
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 19:00:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 497782089F
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 19:00:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 497782089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55972 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJ09G-0000gK-D2
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 15:00:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59165)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iIzln-0002II-Rz
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 14:36:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iIzlm-0005XZ-76
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 14:36:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57130)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iIzlm-0005X0-1M
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 14:36:06 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id AE5021017C06;
 Fri, 11 Oct 2019 18:36:04 +0000 (UTC)
Received: from work-vm (ovpn-117-210.ams2.redhat.com [10.36.117.210])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 88D56600C4;
 Fri, 11 Oct 2019 18:36:00 +0000 (UTC)
Date: Fri, 11 Oct 2019 19:35:58 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [RFC v5 004/126] hmp: drop Error pointer indirection in
 hmp_handle_error
Message-ID: <20191011183558.GY3354@work-vm>
References: <20191011160552.22907-1-vsementsov@virtuozzo.com>
 <20191011160552.22907-5-vsementsov@virtuozzo.com>
 <f8334660-9e5a-3dcb-6818-746d94ea1add@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f8334660-9e5a-3dcb-6818-746d94ea1add@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.64]); Fri, 11 Oct 2019 18:36:04 +0000 (UTC)
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, armbru@redhat.com,
 qemu-devel@nongnu.org,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Eric Blake (eblake@redhat.com) wrote:
> On 10/11/19 11:03 AM, Vladimir Sementsov-Ogievskiy wrote:
> > We don't need Error **, as all callers pass local Error object, which
> > isn't used after the call. Use Error * instead.
> > 
> > Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> > ---
> >   include/monitor/hmp.h      |   2 +-
> >   dump/dump-hmp-cmds.c       |   4 +-
> >   hw/core/machine-hmp-cmds.c |   6 +-
> >   monitor/hmp-cmds.c         | 155 ++++++++++++++++++-------------------
> >   qdev-monitor.c             |   4 +-
> >   qom/qom-hmp-cmds.c         |   4 +-
> >   6 files changed, 87 insertions(+), 88 deletions(-)
> > 
> 
> > +++ b/dump/dump-hmp-cmds.c
> > @@ -32,7 +32,7 @@ void hmp_dump_guest_memory(Monitor *mon, const QDict *qdict)
> >       if (zlib + lzo + snappy + win_dmp > 1) {
> >           error_setg(&err, "only one of '-z|-l|-s|-w' can be set");
> > -        hmp_handle_error(mon, &err);
> > +        hmp_handle_error(mon, err);
> >           return;
> >       }
> 
> Probably not for this series, but would a patch to various HMP files to have
> a g_auto() sort of reporting on an error the moment it goes out of scope
> (rather than having to manually call hmp_handle_error() everywhere) make
> sense?

Maybe; although lets be a bit careful just how much we hide behind
g_auto.

Dave

> -- 
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3226
> Virtualization:  qemu.org | libvirt.org
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

