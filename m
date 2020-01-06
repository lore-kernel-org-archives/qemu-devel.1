Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4673CC33C8C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 16:07:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 136FD207FF
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 16:07:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cMJZ/c8d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 136FD207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioUuD-0000p5-5i
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 11:07:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56872)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1ioUtY-0008NR-MK
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 11:06:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1ioUtT-0007dB-H2
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 11:06:20 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58754
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1ioUtT-0007cN-6q
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 11:06:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578326774;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PpnLfZc2vcqlJvQnH1+DAugVfefnsGfWO79g7SJAhQ8=;
 b=cMJZ/c8dOXf73vwbjPkcojkOysyYwiCOBNa5PsXui+7R0e+7IvBFjpPL4//5duIppgcAsg
 h0FhxhRzlRbHcB02KdJRJdoEGMrWlekjyqUjGKDB+ONwdEPdnwSoZHo+1nVredXFAmSUl+
 NUi1bt8fmArsTiKYEccc8NK3v69qlL4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-190-7QMHXQT9OKixJSuOiUkYug-1; Mon, 06 Jan 2020 11:06:11 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A16DD100551C;
 Mon,  6 Jan 2020 16:06:08 +0000 (UTC)
Received: from linux.fritz.box (ovpn-116-62.ams2.redhat.com [10.36.116.62])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A662B691AD;
 Mon,  6 Jan 2020 16:06:07 +0000 (UTC)
Date: Mon, 6 Jan 2020 17:06:06 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH 3/3] iotests: Test external snapshot with VM state
Message-ID: <20200106160606.GB11243@linux.fritz.box>
References: <20191217145939.5537-1-kwolf@redhat.com>
 <20191217145939.5537-4-kwolf@redhat.com>
 <e4212782-78ef-6bc9-f0e4-9a069c47a77b@redhat.com>
 <20191219154758.GN5230@linux.fritz.box>
 <20200102132516.GH2927@work-vm>
MIME-Version: 1.0
In-Reply-To: <20200102132516.GH2927@work-vm>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: 7QMHXQT9OKixJSuOiUkYug-1
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

Am 02.01.2020 um 14:25 hat Dr. David Alan Gilbert geschrieben:
> * Kevin Wolf (kwolf@redhat.com) wrote:
> > Am 19.12.2019 um 15:26 hat Max Reitz geschrieben:
> > > On 17.12.19 15:59, Kevin Wolf wrote:
> > > > This tests creating an external snapshot with VM state (which resul=
ts in
> > > > an active overlay over an inactive backing file, which is also the =
root
> > > > node of an inactive BlockBackend), re-activating the images and
> > > > performing some operations to test that the re-activation worked as
> > > > intended.
> > > >=20
> > > > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > >=20
> > > [...]
> > >=20
> > > > diff --git a/tests/qemu-iotests/280.out b/tests/qemu-iotests/280.ou=
t
> > > > new file mode 100644
> > > > index 0000000000..5d382faaa8
> > > > --- /dev/null
> > > > +++ b/tests/qemu-iotests/280.out
> > > > @@ -0,0 +1,50 @@
> > > > +Formatting 'TEST_DIR/PID-base', fmt=3Dqcow2 size=3D67108864 cluste=
r_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
> > > > +
> > > > +=3D=3D=3D Launch VM =3D=3D=3D
> > > > +Enabling migration QMP events on VM...
> > > > +{"return": {}}
> > > > +
> > > > +=3D=3D=3D Migrate to file =3D=3D=3D
> > > > +{"execute": "migrate", "arguments": {"uri": "exec:cat > /dev/null"=
}}
> > > > +{"return": {}}
> > > > +{"data": {"status": "setup"}, "event": "MIGRATION", "timestamp": {=
"microseconds": "USECS", "seconds": "SECS"}}
> > > > +{"data": {"status": "active"}, "event": "MIGRATION", "timestamp": =
{"microseconds": "USECS", "seconds": "SECS"}}
> > > > +{"data": {"status": "completed"}, "event": "MIGRATION", "timestamp=
": {"microseconds": "USECS", "seconds": "SECS"}}
> > > > +
> > > > +VM is now stopped:
> > > > +completed
> > > > +{"execute": "query-status", "arguments": {}}
> > > > +{"return": {"running": false, "singlestep": false, "status": "post=
migrate"}}
> > >=20
> > > Hmmm, I get a finish-migrate status here (on tmpfs)...
> >=20
> > Dave, is it intentional that the "completed" migration event is emitted
> > while we are still in finish-migration rather than postmigrate?
>=20
> Yes it looks like it;  it's that the migration state machine hits
> COMPLETED that then _causes_ the runstate transitition to POSTMIGRATE.
>=20
> static void migration_iteration_finish(MigrationState *s)
> {
>     /* If we enabled cpu throttling for auto-converge, turn it off. */
>     cpu_throttle_stop();
>=20
>     qemu_mutex_lock_iothread();
>     switch (s->state) {
>     case MIGRATION_STATUS_COMPLETED:
>         migration_calculate_complete(s);
>         runstate_set(RUN_STATE_POSTMIGRATE);
>         break;
>=20
> then there are a bunch of error cases where if it landed in
> FAILED/CANCELLED etc then we either restart the VM or also go to
> POSTMIGRATE.

Yes, I read the code. My question was more if there is a reason why we
want things to look like this in the external interface.

I just thought that it was confusing that migration is already called
completed when it will still change the runstate. But I guess the
opposite could be confusing as well (if we're in postmigrate, why should
the migration status still change?)

> > I guess we could change wait_migration() in qemu-iotests to wait for th=
e
> > postmigrate state rather than the "completed" event, but maybe it would
> > be better to change the migration code to avoid similar races in other
> > QMP clients.
>=20
> Given that the migration state machine is driving the runstate state
> machine I think it currently makes sense internally;  (although I don't
> think it's documented to be in that order or tested to be, which we
> might want to fix).

In any case, I seem to remember that it's inconsistent between source
and destination. On one side, the migration status is updated first, on
the other side the runstate is updated first.

> Looking at 234 and 262, it looks like you're calling wait_migration on
> both the source and dest; I don't think the dest will see the
> POSTMIGRATE.  Also note that depending what you're trying to do, with
> postcopy you'll be running on the destination before you see COMPLETED.
>=20
> Waiting for the destination to leave 'inmigrate' state is probably
> the best strategy; then wait for the source to be in postmigrate.
> You can cause early exits if you see transitions to 'FAILED' - but
> actually the destination will likely quit in that case; so it should
> be much rarer for you to hit a timeout on a failed migration.

Commit 37ff7d70 changed it to wait for "postmigrate" on the source and
"running" on the destination, which I guess is good enough for a test
case that doesn't expect failure.

Kevin


