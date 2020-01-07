Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0307C33C8C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 13:20:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B93642072A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 13:20:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bRloEPHc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B93642072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48536 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioom6-0004PQ-NI
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 08:19:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45931)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1ionMF-0003U3-2I
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 06:49:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1ionMD-0004hx-7P
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 06:49:10 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60398
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ionMD-0004hn-36
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 06:49:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578397748;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Dq/ocOTrdBYhMDsv7RdCZ/wy3eBDAC5R79Y0YIV7th8=;
 b=bRloEPHc0nmd3KOd+I+sIvqLdLEEkiS+HRe4yivbjb0coCXVNWAWzaqZQmGmqDC85RiFP8
 /Mxf949WPoL21x88aeP2+y9cMmVH5Je7RxJv1p8ECfP3MTyDGDLM1kxJgL8a3vm2FzCu2/
 a7N3aQqCNAunXx/5VLzqKzjg5rTJGic=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-361-87fD03XNPz-tUtwqryjsLQ-1; Tue, 07 Jan 2020 06:49:07 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 201C7DC06
 for <qemu-devel@nongnu.org>; Tue,  7 Jan 2020 11:49:06 +0000 (UTC)
Received: from work-vm (ovpn-117-52.ams2.redhat.com [10.36.117.52])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BC60C7C357;
 Tue,  7 Jan 2020 11:49:04 +0000 (UTC)
Date: Tue, 7 Jan 2020 11:49:02 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Subject: Re: [PATCH v2 3/3] migration-test: Make sure that multifd and cancel
 works
Message-ID: <20200107114902.GF2732@work-vm>
References: <20200107104914.1814-1-quintela@redhat.com>
 <20200107104914.1814-4-quintela@redhat.com>
 <20200107112713.GD2732@work-vm> <871rsbsd53.fsf@trasno.org>
MIME-Version: 1.0
In-Reply-To: <871rsbsd53.fsf@trasno.org>
User-Agent: Mutt/1.13.0 (2019-11-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: 87fD03XNPz-tUtwqryjsLQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Juan Quintela (quintela@redhat.com) wrote:
> "Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> > * Juan Quintela (quintela@redhat.com) wrote:
> >> Test that this sequerce works:
> >>=20
> >> - launch source
> >> - launch target
> >> - start migration
> >> - cancel migration
> >> - relaunch target
> >> - do migration again
> >>=20
> >> Signed-off-by: Juan Quintela <quintela@redhat.com>
> >> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> >> Signed-off-by: Juan Quintela <quintela@redhat.com>
> >>=20
> >> ---
> >>=20
> >> - Wait for 1st trhead to move to cancelled before launching second
> >>   migration
> >> - Add 'to2' parameter to diferentiate 1st and second target.
> >> ---
> >>  tests/migration-test.c | 110 ++++++++++++++++++++++++++++++++++++++++=
-
> >>  1 file changed, 109 insertions(+), 1 deletion(-)
> >>=20
> >> diff --git a/tests/migration-test.c b/tests/migration-test.c
> >> index 1a8d06718e..7a833d65ce 100644
> >> --- a/tests/migration-test.c
> >> +++ b/tests/migration-test.c
> >> @@ -387,6 +387,14 @@ static void migrate_recover(QTestState *who, cons=
t char *uri)
> >>      qobject_unref(rsp);
> >>  }
> >> =20
> >> +static void migrate_cancel(QTestState *who)
> >> +{
> >> +    QDict *rsp;
> >> +
> >> +    rsp =3D wait_command(who, "{ 'execute': 'migrate_cancel' }");
> >> +    qobject_unref(rsp);
> >> +}
> >> +
> >>  static void migrate_set_capability(QTestState *who, const char *capab=
ility,
> >>                                     bool value)
> >>  {
> >> @@ -419,6 +427,8 @@ static void migrate_postcopy_start(QTestState *fro=
m, QTestState *to)
> >>  typedef struct {
> >>      bool hide_stderr;
> >>      bool use_shmem;
> >> +    /* only launch the target process */
> >> +    bool only_target;
> >>      char *opts_source;
> >>      char *opts_target;
> >>  } MigrateStart;
> >> @@ -534,7 +544,9 @@ static int test_migrate_start(QTestState **from, Q=
TestState **to,
> >>                                   arch_source, shmem_opts, args->opts_=
source,
> >>                                   ignore_stderr);
> >>      g_free(arch_source);
> >> -    *from =3D qtest_init(cmd_source);
> >> +    if (!args->only_target) {
> >> +        *from =3D qtest_init(cmd_source);
> >> +    }
> >>      g_free(cmd_source);
> >> =20
> >>      cmd_target =3D g_strdup_printf("-accel kvm -accel tcg%s%s "
> >> @@ -1257,6 +1269,101 @@ static void test_multifd_tcp(void)
> >>      free(uri);
> >>  }
> >> =20
> >> +/*
> >> + * This test does:
> >> + *  source               target
> >> + *                       migrate_incoming
> >> + *     migrate
> >> + *     migrate_cancel
> >> + *                       launch another target
> >> + *     migrate
> >> + *
> >> + *  And see that it works
> >> + */
> >> +
> >> +static void test_multifd_tcp_cancel(void)
> >> +{
> >> +    MigrateStart *args =3D migrate_start_new();
> >> +    QTestState *from, *to, *to2;
> >> +    QDict *rsp;
> >> +    char *uri;
> >> +
> >> +    args->hide_stderr =3D true;
> >> +
> >> +    if (test_migrate_start(&from, &to, "defer", args)) {
> >> +        return;
> >> +    }
> >> +
> >> +    /*
> >> +     * We want to pick a speed slow enough that the test completes
> >> +     * quickly, but that it doesn't complete precopy even on a slow
> >> +     * machine, so also set the downtime.
> >> +     */
> >> +    /* 1 ms should make it not converge*/
> >> +    migrate_set_parameter_int(from, "downtime-limit", 1);
> >> +    /* 1GB/s */
> >> +    migrate_set_parameter_int(from, "max-bandwidth", 1000000000);
> >
> > See previous comment about my update in the postcopy test, but OK.
>=20
> Yes and no O:-)
>=20
> function                 value
> --------                 -----
> postcopy_prepare            30 000 000
> precopy_unix             1 000 000 000
> xbzrle                   1 000 000 000
> precpy_tcp               1 000 000 000
> fd_proto                 1 000 000 000
> auto-converge            1 000 000 000
> multifd                  1 000 000 000
> multifd_cancel           1 000 000 000
>=20
> Can we agree to create three global constants with the following values:
>=20
>=20
> const long long downtime_initial =3D 1;
> const long long downtime_final =3D 300;  /* or ever 600 */
> const long long bandwidth_initial =3D 30 000 000;
>=20
> And substitute everywhere with the rigths constants?

Yeh, so we just have to make sure we only change it in the places
where we want to/dont want it to converge.

> Thanks, Juan.
>=20
> >> +    migrate_set_parameter_int(from, "multifd-channels", 16);
> >> +    migrate_set_parameter_int(to, "multifd-channels", 16);
> >> +
> >> +    migrate_set_capability(from, "multifd", "true");
> >> +    migrate_set_capability(to, "multifd", "true");
> >> +
> >> +    /* Start incoming migration from the 1st socket */
> >> +    rsp =3D wait_command(to, "{ 'execute': 'migrate-incoming',"
> >> +                           "  'arguments': { 'uri': 'tcp:127.0.0.1:0'=
 }}");
> >> +    qobject_unref(rsp);
> >> +
> >> +    /* Wait for the first serial output from the source */
> >> +    wait_for_serial("src_serial");
> >> +
> >> +    uri =3D migrate_get_socket_address(to, "socket-address");
> >> +
> >> +    migrate_qmp(from, uri, "{}");
> >> +
> >> +    wait_for_migration_pass(from);
> >> +
> >> +    migrate_cancel(from);
> >
> > You might want to add something here to validate that the cancel has
> > finished before starting the new one.
>=20
>=20
> >> +    args =3D migrate_start_new();
> >> +    args->only_target =3D true;
> >> +
> >> +    if (test_migrate_start(&from, &to2, "defer", args)) {
> >> +        return;
> >> +    }
> >> +
> >> +    migrate_set_parameter_int(to2, "multifd-channels", 16);
> >> +
> >> +    migrate_set_capability(to2, "multifd", "true");
> >> +
> >> +    /* Start incoming migration from the 1st socket */
> >> +    rsp =3D wait_command(to2, "{ 'execute': 'migrate-incoming',"
> >> +                            "  'arguments': { 'uri': 'tcp:127.0.0.1:0=
' }}");
> >> +    qobject_unref(rsp);
> >> +
> >> +    /* 300ms it should converge */
> >> +    migrate_set_parameter_int(from, "downtime-limit", 300);
> >> +
> >> +    uri =3D migrate_get_socket_address(to2, "socket-address");
> >> +
> >> +    wait_for_migration_status(from, "cancelled", NULL);
>=20
> That is exactly what this last line does, not?
> The rest of things that we do here are for "to2" instance, that don't
> affect us at all.
>=20
> Once told that, I think that it makes sense to just move the set of
> downtime-limit after the migration.

Ah OK, yes, that's fine.

Dave

> Thanks, Juan.
>=20
>=20
> >> +
> >> +    migrate_qmp(from, uri, "{}");
> >> +
> >> +    wait_for_migration_pass(from);
> >> +
> >> +    if (!got_stop) {
> >> +        qtest_qmp_eventwait(from, "STOP");
> >> +    }
> >> +    qtest_qmp_eventwait(to2, "RESUME");
> >> +
> >> +    wait_for_serial("dest_serial");
> >> +    wait_for_migration_complete(from);
> >> +    test_migrate_end(from, to2, true);
> >> +    free(uri);
> >> +}
> >> +
> >>  int main(int argc, char **argv)
> >>  {
> >>      char template[] =3D "/tmp/migration-test-XXXXXX";
> >> @@ -1322,6 +1429,7 @@ int main(int argc, char **argv)
> >> =20
> >>      qtest_add_func("/migration/auto_converge", test_migrate_auto_conv=
erge);
> >>      qtest_add_func("/migration/multifd/tcp", test_multifd_tcp);
> >> +    qtest_add_func("/migration/multifd/tcp/cancel", test_multifd_tcp_=
cancel);
> >> =20
> >>      ret =3D g_test_run();
> >> =20
> >> --=20
> >> 2.24.1
> >>=20
> > --
> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


