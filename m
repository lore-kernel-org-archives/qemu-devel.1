Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61248C83008
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 13:48:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E5E4206F0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 13:48:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IiavH/kF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E5E4206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58544 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTQao-0002PI-BP
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 09:48:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37470)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1jTQWT-0007Kv-Tp
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 09:46:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1jTQWH-0003Zc-EI
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 09:43:41 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:59525
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jTQWG-0003ZH-Op
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 09:43:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588081407;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6xgm9JfzJc2lciVk2lZGJaVumiBn9Q/VrE1FMaPUiRs=;
 b=IiavH/kF8OnS65wCWTHod9EVXl8INAYOAkm5jPgUyujLH8IV0SL5osoD47WSUnCZoF9tZ+
 Yr1p8nE6X5T99xsmwWlTpP2+oBzqR3ntpb4UbVbuaDcExq96A7n/A4NPqKoQzTzVDC/hoV
 jDMnKLQ8qJgezqkPoMTfuuryB3yFc1s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-263-jqFWMPS0MM69RmaqHV0L0Q-1; Tue, 28 Apr 2020 09:43:25 -0400
X-MC-Unique: jqFWMPS0MM69RmaqHV0L0Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 961A11899528;
 Tue, 28 Apr 2020 13:43:24 +0000 (UTC)
Received: from work-vm (ovpn-113-77.ams2.redhat.com [10.36.113.77])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6A63819C58;
 Tue, 28 Apr 2020 13:43:23 +0000 (UTC)
Date: Tue, 28 Apr 2020 14:43:20 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Adalbert =?utf-8?B?TGF6xINy?= <alazar@bitdefender.com>
Subject: Re: [RFC PATCH v1 20/26] kvm: vmi: intercept live migration
Message-ID: <20200428134320.GE2794@work-vm>
References: <20200415005938.23895-1-alazar@bitdefender.com>
 <20200415005938.23895-21-alazar@bitdefender.com>
 <20200427190855.GN2923@work-vm> <15880760940.91F7391B.25850@host>
 <20200428122439.GD2794@work-vm> <15880797910.d6Bf.5687@host>
MIME-Version: 1.0
In-Reply-To: <15880797910.d6Bf.5687@host>
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/28 04:11:46
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Marian Rotariu <marian.c.rotariu@gmail.com>, qemu-devel@nongnu.org,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Adalbert Laz=C4=83r (alazar@bitdefender.com) wrote:
> On Tue, 28 Apr 2020 13:24:39 +0100, "Dr. David Alan Gilbert" <dgilbert@re=
dhat.com> wrote:
> > * Adalbert Laz=C4=83r (alazar@bitdefender.com) wrote:
> > > On Mon, 27 Apr 2020 20:08:55 +0100, "Dr. David Alan Gilbert" <dgilber=
t@redhat.com> wrote:
> > > > * Adalbert Laz=C4=83r (alazar@bitdefender.com) wrote:
> > > > > From: Marian Rotariu <marian.c.rotariu@gmail.com>
> > > > >=20
> > > > > It is possible that the introspection tool has made some changes =
inside
> > > > > the introspected VM which can make the guest crash if the introsp=
ection
> > > > > connection is suddenly closed.
> > > > >=20
> > > > > When the live migration starts, for now, the introspection tool i=
s
> > > > > signaled to remove its hooks from the introspected VM.
> > > > >=20
> > > > > CC: Juan Quintela <quintela@redhat.com>
> > > > > CC: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> > > > > Signed-off-by: Marian Rotariu <marian.c.rotariu@gmail.com>
> > > > > Signed-off-by: Adalbert Laz=C4=83r <alazar@bitdefender.com>
> > > >=20
> > > > OK, so this isn't too intrusive to the migration code; and other th=
an
> > > > renaming 'start_live_migration_thread' to
> > > > 'start_outgoing_migration_thread' I think I'd be OK with this,
> > > >=20
> > > > but it might depend what your overall aim is.
> > > >=20
> > > > For example, you might be better intercepting each migration_state
> > > > change in your notifier, that's much finer grain than just the star=
t of
> > > > migration.
> > >=20
> > > Thank you, Dave.
> > >=20
> > > We want to intercept the live migration and 'block' it while the gues=
t
> > > is running (some changes made to the guest by the introspection app h=
as
> > > to be undone while the vCPUs are in certain states).
> > >=20
> > > I'm not sure what is the best way to block these kind of events
> > > (including the pause/shutdown commands). If calling main_loop_wait()
> > > is enough (patch [22/26] kvm: vmi: add 'async_unhook' property [1])
> > > then we can drop a lot of code.
> > >=20
> > > The use of a notifier will be nice, but from what I understand, we ca=
n't
> > > block the migration from a notification callback.
> >=20
> > Oh, if your intention is *just* to block a migration starting then you
> > can use 'migrate_add_blocker' - see hw/9pfs/9p.c for an example where
> > it's used and then removed; they use it to stop migration while the fs
> >  is mounted.  That causes an attempt to start a migration to give an
> > error (of your choosing).
>=20
> One use case is to do VM introspection all the time the guest is running.
> From the user perspective, the pause/suspend/shutdown/snapshot/migrate
> commands should work regardless if the VM is currently introspected
> or not. Our first option was to delay these commands for a couple of
> seconds when the VM is introspected, while the introspection app reverts
> its changes, without blocking the vCPUs.

Ah OK, so it's not really about blocking it completely; just delaying it
a bit; in that case add_blocker is the wrong thing.

> I'll see if we can mix the migrate notifier with migrate_add_blocker(),
> or add a new migration state. To block the migration (with an error)
> is our second option, because the user doing this might not be allowed
> to stop the VM introspection.

Maybe the right thing is to do something just like
MIGRATION_STATUS_WAIT_UNPLUG, it's right near the start of the thread.
Again it's job is just to make the migration wait while it does some
stuff before it can let migration continue.

Dave

> Thank you,
> Adalbert
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


