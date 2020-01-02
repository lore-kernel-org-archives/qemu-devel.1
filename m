Return-Path: <SRS0=Q/S9=2X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CDF4C2D0DC
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2020 13:26:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 287D520863
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2020 13:26:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wbm7OE+d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 287D520863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41070 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1in0UT-0007S8-8o
	for qemu-devel@archiver.kernel.org; Thu, 02 Jan 2020 08:26:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56848)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1in0Tf-0006rg-LO
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 08:25:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1in0Tc-0003bJ-KO
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 08:25:25 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34395
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1in0Tc-0003ae-GN
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 08:25:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577971522;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RVxajW0dY8mCZYoVvbVx+yN2BS/4094FzfPt6ee8Q9k=;
 b=Wbm7OE+df2OpWyfi7UsM6cWQLMAc6yvlXg5nYxVO1Ahh793oZaRook6LBh77hQs6UcI2PV
 4cmpwTNWH7A1EmQFYEzmJ6o3abld4EQn9OnwOue0eJiPxQAOm/OPtOJMoCpybkpKTfTIRP
 XbgY7pCnPuHmsQyXggu8+vtjIa3WJEs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-140-2KAla6-wOs-Uv5751hbUtQ-1; Thu, 02 Jan 2020 08:25:21 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B83A718AAFBC;
 Thu,  2 Jan 2020 13:25:20 +0000 (UTC)
Received: from work-vm (ovpn-117-17.ams2.redhat.com [10.36.117.17])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 250B519E9C;
 Thu,  2 Jan 2020 13:25:18 +0000 (UTC)
Date: Thu, 2 Jan 2020 13:25:16 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH 3/3] iotests: Test external snapshot with VM state
Message-ID: <20200102132516.GH2927@work-vm>
References: <20191217145939.5537-1-kwolf@redhat.com>
 <20191217145939.5537-4-kwolf@redhat.com>
 <e4212782-78ef-6bc9-f0e4-9a069c47a77b@redhat.com>
 <20191219154758.GN5230@linux.fritz.box>
MIME-Version: 1.0
In-Reply-To: <20191219154758.GN5230@linux.fritz.box>
User-Agent: Mutt/1.13.0 (2019-11-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: 2KAla6-wOs-Uv5751hbUtQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Kevin Wolf (kwolf@redhat.com) wrote:
> Am 19.12.2019 um 15:26 hat Max Reitz geschrieben:
> > On 17.12.19 15:59, Kevin Wolf wrote:
> > > This tests creating an external snapshot with VM state (which results=
 in
> > > an active overlay over an inactive backing file, which is also the ro=
ot
> > > node of an inactive BlockBackend), re-activating the images and
> > > performing some operations to test that the re-activation worked as
> > > intended.
> > >=20
> > > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> >=20
> > [...]
> >=20
> > > diff --git a/tests/qemu-iotests/280.out b/tests/qemu-iotests/280.out
> > > new file mode 100644
> > > index 0000000000..5d382faaa8
> > > --- /dev/null
> > > +++ b/tests/qemu-iotests/280.out
> > > @@ -0,0 +1,50 @@
> > > +Formatting 'TEST_DIR/PID-base', fmt=3Dqcow2 size=3D67108864 cluster_=
size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
> > > +
> > > +=3D=3D=3D Launch VM =3D=3D=3D
> > > +Enabling migration QMP events on VM...
> > > +{"return": {}}
> > > +
> > > +=3D=3D=3D Migrate to file =3D=3D=3D
> > > +{"execute": "migrate", "arguments": {"uri": "exec:cat > /dev/null"}}
> > > +{"return": {}}
> > > +{"data": {"status": "setup"}, "event": "MIGRATION", "timestamp": {"m=
icroseconds": "USECS", "seconds": "SECS"}}
> > > +{"data": {"status": "active"}, "event": "MIGRATION", "timestamp": {"=
microseconds": "USECS", "seconds": "SECS"}}
> > > +{"data": {"status": "completed"}, "event": "MIGRATION", "timestamp":=
 {"microseconds": "USECS", "seconds": "SECS"}}
> > > +
> > > +VM is now stopped:
> > > +completed
> > > +{"execute": "query-status", "arguments": {}}
> > > +{"return": {"running": false, "singlestep": false, "status": "postmi=
grate"}}
> >=20
> > Hmmm, I get a finish-migrate status here (on tmpfs)...
>=20
> Dave, is it intentional that the "completed" migration event is emitted
> while we are still in finish-migration rather than postmigrate?

Yes it looks like it;  it's that the migration state machine hits
COMPLETED that then _causes_ the runstate transitition to POSTMIGRATE.

static void migration_iteration_finish(MigrationState *s)
{
    /* If we enabled cpu throttling for auto-converge, turn it off. */
    cpu_throttle_stop();

    qemu_mutex_lock_iothread();
    switch (s->state) {
    case MIGRATION_STATUS_COMPLETED:
        migration_calculate_complete(s);
        runstate_set(RUN_STATE_POSTMIGRATE);
        break;

then there are a bunch of error cases where if it landed in
FAILED/CANCELLED etc then we either restart the VM or also go to
POSTMIGRATE.

> I guess we could change wait_migration() in qemu-iotests to wait for the
> postmigrate state rather than the "completed" event, but maybe it would
> be better to change the migration code to avoid similar races in other
> QMP clients.

Given that the migration state machine is driving the runstate state
machine I think it currently makes sense internally;  (although I don't
think it's documented to be in that order or tested to be, which we
might want to fix).

Looking at 234 and 262, it looks like you're calling wait_migration on
both the source and dest; I don't think the dest will see the
POSTMIGRATE.  Also note that depending what you're trying to do, with
postcopy you'll be running on the destination before you see COMPLETED.

Waiting for the destination to leave 'inmigrate' state is probably
the best strategy; then wait for the source to be in postmigrate.
You can cause early exits if you see transitions to 'FAILED' - but
actually the destination will likely quit in that case; so it should
be much rarer for you to hit a timeout on a failed migration.

Dave


> Kevin


--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


