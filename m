Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BACEDC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 12:11:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8645423B23
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 12:11:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ixKimUjt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8645423B23
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpsdK-0007Ia-Q3
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 08:11:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34124)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jpsbk-0006Q9-9H
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 08:09:56 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:36195
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jpsbh-0001WR-6m
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 08:09:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593432591;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fQnOtbN1Nslzs6MCLRwR9Rwoe28FDZGyTzzZtbcw+/I=;
 b=ixKimUjtcV1233nPoW7MquKy/E4fCx9aS9pXkxqyNO82eIg7+cz/nY6586nijibfggVU5u
 l6fUIvYQu5cZR0PN+3I53u4N+FCW39DNYYFPZGg+qDkYwfHvd98EDDnVH6Opo2sC0ihFGW
 YTToGpvBk8M/Lk1D1slL9QRL+kJup4I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-299-Y6GNt4e0OUGLwf_vweoWKg-1; Mon, 29 Jun 2020 08:09:49 -0400
X-MC-Unique: Y6GNt4e0OUGLwf_vweoWKg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8AB87804002;
 Mon, 29 Jun 2020 12:09:48 +0000 (UTC)
Received: from work-vm (ovpn-114-210.ams2.redhat.com [10.36.114.210])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8487C7CAC5;
 Mon, 29 Jun 2020 12:09:41 +0000 (UTC)
Date: Mon, 29 Jun 2020 13:09:39 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PULL 08/14] migration: add new migration state wait-unplug
Message-ID: <20200629120939.GI2908@work-vm>
References: <20191029225932.14585-1-mst@redhat.com>
 <20191029225932.14585-9-mst@redhat.com>
 <CAFEAcA8uSbC80a+yB4_DFtCB1_-sXW5R3ugTX6H9XDeBZV-mQQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8uSbC80a+yB4_DFtCB1_-sXW5R3ugTX6H9XDeBZV-mQQ@mail.gmail.com>
User-Agent: Mutt/1.14.3 (2020-06-14)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/29 01:03:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Juan Quintela <quintela@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 Jens Freimann <jfreimann@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Peter Maydell (peter.maydell@linaro.org) wrote:
> On Tue, 29 Oct 2019 at 23:00, Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > From: Jens Freimann <jfreimann@redhat.com>
> >
> > This patch adds a new migration state called wait-unplug.  It is entered
> > after the SETUP state if failover devices are present. It will transition
> > into ACTIVE once all devices were succesfully unplugged from the guest.
> >
> > So if a guest doesn't respond or takes long to honor the unplug request
> > the user will see the migration state 'wait-unplug'.
> >
> > In the migration thread we query failover devices if they're are still
> > pending the guest unplug. When all are unplugged the migration
> > continues. If one device won't unplug migration will stay in wait_unplug
> > state.
> >
> > Signed-off-by: Jens Freimann <jfreimann@redhat.com>
> > Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > Message-Id: <20191029114905.6856-9-jfreimann@redhat.com>
> > Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> 
> Hi; Coverity has just (rather belatedly) noticed a possible
> issue in this code (CID 1429995):
> 
> > @@ -3264,6 +3270,19 @@ static void *migration_thread(void *opaque)
> >
> >      qemu_savevm_state_setup(s->to_dst_file);
> >
> > +    if (qemu_savevm_nr_failover_devices()) {
> > +        migrate_set_state(&s->state, MIGRATION_STATUS_SETUP,
> > +                          MIGRATION_STATUS_WAIT_UNPLUG);
> > +
> > +        while (s->state == MIGRATION_STATUS_WAIT_UNPLUG &&
> > +               qemu_savevm_state_guest_unplug_pending()) {
> > +            qemu_sem_timedwait(&s->wait_unplug_sem, 250);
> 
> Here we call qemu_sem_timedwait() but ignore the return value,
> whereas all the other callsites for that function do something
> with the return value. Is the code correct? (This is just a
> heuristic Coverity has, and it's wrong a fair amount of the
> time, so if it's wrong here too I can just mark it as a
> false-positive in the Coverity UI.)

Hmm it's OK; that semaphore isn't really used at the moment,
so it's pretty much just a sleep. And the loop always
calls the qemu_savevm_state_guest_unplug_pending() before
it goes around again; so it doesn't care if the return
value indicates timeout or not.

Dave

> thanks
> -- PMM
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


