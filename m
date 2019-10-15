Return-Path: <SRS0=6OCO=YI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4449ECE588
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 10:53:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA7732089C
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 10:53:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA7732089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40698 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKKSk-0006wF-7x
	for qemu-devel@archiver.kernel.org; Tue, 15 Oct 2019 06:53:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51773)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iKKPL-0002aT-Vt
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 06:50:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iKKPJ-0004Zy-La
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 06:50:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41368)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iKKPJ-0004ZZ-DH
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 06:50:25 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 558C1300D20C;
 Tue, 15 Oct 2019 10:50:24 +0000 (UTC)
Received: from work-vm (ovpn-117-145.ams2.redhat.com [10.36.117.145])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 17837194B6;
 Tue, 15 Oct 2019 10:50:10 +0000 (UTC)
Date: Tue, 15 Oct 2019 11:50:08 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Jens Freimann <jfreimann@redhat.com>
Subject: Re: [PATCH v3 07/10] migration: add new migration state wait-unplug
Message-ID: <20191015105008.GE3073@work-vm>
References: <20191011112015.11785-1-jfreimann@redhat.com>
 <20191011112015.11785-8-jfreimann@redhat.com>
 <20191011171133.GU3354@work-vm>
 <20191015094525.zqq4534ghe3l2ngr@jenstp.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191015094525.zqq4534ghe3l2ngr@jenstp.localdomain>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Tue, 15 Oct 2019 10:50:24 +0000 (UTC)
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
Cc: ehabkost@redhat.com, mst@redhat.com, aadam@redhat.com,
 qemu-devel@nongnu.org, alex.williamson@redhat.com, laine@redhat.com,
 ailan@redhat.com, parav@mellanox.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Jens Freimann (jfreimann@redhat.com) wrote:
> On Fri, Oct 11, 2019 at 06:11:33PM +0100, Dr. David Alan Gilbert wrote:
> > * Jens Freimann (jfreimann@redhat.com) wrote:
> > > This patch adds a new migration state called wait-unplug.  It is entered
> > > after the SETUP state and will transition into ACTIVE once all devices
> > > were succesfully unplugged from the guest.
> > > 
> > > So if a guest doesn't respond or takes long to honor the unplug request
> > > the user will see the migration state 'wait-unplug'.
> > > 
> > > In the migration thread we query failover devices if they're are still
> > > pending the guest unplug. When all are unplugged the migration
> > > continues. We give it a defined number of iterations including small
> > > waiting periods before we proceed.
> > > 
> > > Signed-off-by: Jens Freimann <jfreimann@redhat.com>
> [..]
> > > @@ -3260,6 +3271,27 @@ static void *migration_thread(void *opaque)
> > > 
> > >      qemu_savevm_state_setup(s->to_dst_file);
> > > 
> > > +    migrate_set_state(&s->state, MIGRATION_STATUS_SETUP,
> > > +                      MIGRATION_STATUS_WAIT_UNPLUG);
> > 
> > I think I'd prefer if you only went into this state if you had any
> > devices that were going to need unplugging.
> 
> Sure, that makes sense. I'll change it.
> 
> > > +    while (i < FAILOVER_UNPLUG_RETRIES &&
> > > +           s->state == MIGRATION_STATUS_WAIT_UNPLUG) {
> > > +        i++;
> > > +        qemu_sem_timedwait(&s->wait_unplug_sem, FAILOVER_GUEST_UNPLUG_WAIT);
> > > +        all_unplugged = qemu_savevm_state_guest_unplug_pending();
> > > +        if (all_unplugged) {
> > > +            break;
> > > +        }
> > > +    }
> > > +
> > > +    if (all_unplugged) {
> > > +        migrate_set_state(&s->state, MIGRATION_STATUS_WAIT_UNPLUG,
> > > +                MIGRATION_STATUS_ACTIVE);
> > > +    } else {
> > > +        migrate_set_state(&s->state, MIGRATION_STATUS_WAIT_UNPLUG,
> > > +                          MIGRATION_STATUS_CANCELLING);
> > > +    }
> > 
> > I think you can get rid of both the timeout and the count and just make
> > sure that migrate_cancel works at this point.
> 
> I see, I need to add the new state to migration_is_setup_or_active() or
> a cancel won't work.

You probably need to do that anyway given all the other places
is_setup_or_active is called.

> > This pushes the problem up a layer, which I think is fine.
> 
> Seems good to me. To be clear, you're saying I should just poll on
> the device unplugged state? Like
> 
>         while (s->state == MIGRATION_STATUS_WAIT_UNPLUG &&
>                !qemu_savevm_state_guest_unplug_pending()) {
> _            /* This block intentionally left blank */
>         }

I'd keep the qemu_sem_timedwait in there, but with a short time out
(e.g. 250ms say); that way it doesn't eat cpu, but also the cancel still
happens quickly.

Dave

> 
> regards,
> Jens
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

