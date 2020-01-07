Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B995DC33C8C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 13:13:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87BFD2072A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 13:13:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dzNt60Ry"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87BFD2072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioogC-0000Dw-6k
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 08:13:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45368)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1ionJK-0005k7-EE
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 06:46:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1ionJI-0002qi-R7
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 06:46:10 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30465
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1ionJI-0002q2-K1
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 06:46:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578397568;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yM5IS3HqtWgwnpNE576oj3PVhdaMNhceRfzu2BL1eaY=;
 b=dzNt60RyBS3NmSMMFEjpgoBXHGNgPoMwp3hYABz+XipprrtC1vO6uFkF1K4UDoIBdzzLnl
 JgznEAw/EoyRy6Zuk0wYcV7jhtNGV962lIl1vhhcWSlCoP9Qz7RrIzPcONdm0ZPQEcdWFo
 Xbp+HQqIfUmptcRRwXFz+frURSX7cXo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-207-r6rsSsyiOWiY-t2tC9kTSQ-1; Tue, 07 Jan 2020 06:46:06 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ED6A3107ACC7
 for <qemu-devel@nongnu.org>; Tue,  7 Jan 2020 11:46:05 +0000 (UTC)
Received: from redhat.com (ovpn-116-141.ams2.redhat.com [10.36.116.141])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 395387C000;
 Tue,  7 Jan 2020 11:46:05 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH v2 3/3] migration-test: Make sure that multifd and cancel
 works
In-Reply-To: <20200107112713.GD2732@work-vm> (David Alan Gilbert's message of
 "Tue, 7 Jan 2020 11:27:13 +0000")
References: <20200107104914.1814-1-quintela@redhat.com>
 <20200107104914.1814-4-quintela@redhat.com>
 <20200107112713.GD2732@work-vm>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Date: Tue, 07 Jan 2020 12:46:00 +0100
Message-ID: <871rsbsd53.fsf@trasno.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: r6rsSsyiOWiY-t2tC9kTSQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
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
Reply-To: quintela@redhat.com
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

"Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> * Juan Quintela (quintela@redhat.com) wrote:
>> Test that this sequerce works:
>>=20
>> - launch source
>> - launch target
>> - start migration
>> - cancel migration
>> - relaunch target
>> - do migration again
>>=20
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>>=20
>> ---
>>=20
>> - Wait for 1st trhead to move to cancelled before launching second
>>   migration
>> - Add 'to2' parameter to diferentiate 1st and second target.
>> ---
>>  tests/migration-test.c | 110 ++++++++++++++++++++++++++++++++++++++++-
>>  1 file changed, 109 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/tests/migration-test.c b/tests/migration-test.c
>> index 1a8d06718e..7a833d65ce 100644
>> --- a/tests/migration-test.c
>> +++ b/tests/migration-test.c
>> @@ -387,6 +387,14 @@ static void migrate_recover(QTestState *who, const =
char *uri)
>>      qobject_unref(rsp);
>>  }
>> =20
>> +static void migrate_cancel(QTestState *who)
>> +{
>> +    QDict *rsp;
>> +
>> +    rsp =3D wait_command(who, "{ 'execute': 'migrate_cancel' }");
>> +    qobject_unref(rsp);
>> +}
>> +
>>  static void migrate_set_capability(QTestState *who, const char *capabil=
ity,
>>                                     bool value)
>>  {
>> @@ -419,6 +427,8 @@ static void migrate_postcopy_start(QTestState *from,=
 QTestState *to)
>>  typedef struct {
>>      bool hide_stderr;
>>      bool use_shmem;
>> +    /* only launch the target process */
>> +    bool only_target;
>>      char *opts_source;
>>      char *opts_target;
>>  } MigrateStart;
>> @@ -534,7 +544,9 @@ static int test_migrate_start(QTestState **from, QTe=
stState **to,
>>                                   arch_source, shmem_opts, args->opts_so=
urce,
>>                                   ignore_stderr);
>>      g_free(arch_source);
>> -    *from =3D qtest_init(cmd_source);
>> +    if (!args->only_target) {
>> +        *from =3D qtest_init(cmd_source);
>> +    }
>>      g_free(cmd_source);
>> =20
>>      cmd_target =3D g_strdup_printf("-accel kvm -accel tcg%s%s "
>> @@ -1257,6 +1269,101 @@ static void test_multifd_tcp(void)
>>      free(uri);
>>  }
>> =20
>> +/*
>> + * This test does:
>> + *  source               target
>> + *                       migrate_incoming
>> + *     migrate
>> + *     migrate_cancel
>> + *                       launch another target
>> + *     migrate
>> + *
>> + *  And see that it works
>> + */
>> +
>> +static void test_multifd_tcp_cancel(void)
>> +{
>> +    MigrateStart *args =3D migrate_start_new();
>> +    QTestState *from, *to, *to2;
>> +    QDict *rsp;
>> +    char *uri;
>> +
>> +    args->hide_stderr =3D true;
>> +
>> +    if (test_migrate_start(&from, &to, "defer", args)) {
>> +        return;
>> +    }
>> +
>> +    /*
>> +     * We want to pick a speed slow enough that the test completes
>> +     * quickly, but that it doesn't complete precopy even on a slow
>> +     * machine, so also set the downtime.
>> +     */
>> +    /* 1 ms should make it not converge*/
>> +    migrate_set_parameter_int(from, "downtime-limit", 1);
>> +    /* 1GB/s */
>> +    migrate_set_parameter_int(from, "max-bandwidth", 1000000000);
>
> See previous comment about my update in the postcopy test, but OK.

Yes and no O:-)

function                 value
--------                 -----
postcopy_prepare            30 000 000
precopy_unix             1 000 000 000
xbzrle                   1 000 000 000
precpy_tcp               1 000 000 000
fd_proto                 1 000 000 000
auto-converge            1 000 000 000
multifd                  1 000 000 000
multifd_cancel           1 000 000 000

Can we agree to create three global constants with the following values:


const long long downtime_initial =3D 1;
const long long downtime_final =3D 300;  /* or ever 600 */
const long long bandwidth_initial =3D 30 000 000;

And substitute everywhere with the rigths constants?

Thanks, Juan.

>> +    migrate_set_parameter_int(from, "multifd-channels", 16);
>> +    migrate_set_parameter_int(to, "multifd-channels", 16);
>> +
>> +    migrate_set_capability(from, "multifd", "true");
>> +    migrate_set_capability(to, "multifd", "true");
>> +
>> +    /* Start incoming migration from the 1st socket */
>> +    rsp =3D wait_command(to, "{ 'execute': 'migrate-incoming',"
>> +                           "  'arguments': { 'uri': 'tcp:127.0.0.1:0' }=
}");
>> +    qobject_unref(rsp);
>> +
>> +    /* Wait for the first serial output from the source */
>> +    wait_for_serial("src_serial");
>> +
>> +    uri =3D migrate_get_socket_address(to, "socket-address");
>> +
>> +    migrate_qmp(from, uri, "{}");
>> +
>> +    wait_for_migration_pass(from);
>> +
>> +    migrate_cancel(from);
>
> You might want to add something here to validate that the cancel has
> finished before starting the new one.


>> +    args =3D migrate_start_new();
>> +    args->only_target =3D true;
>> +
>> +    if (test_migrate_start(&from, &to2, "defer", args)) {
>> +        return;
>> +    }
>> +
>> +    migrate_set_parameter_int(to2, "multifd-channels", 16);
>> +
>> +    migrate_set_capability(to2, "multifd", "true");
>> +
>> +    /* Start incoming migration from the 1st socket */
>> +    rsp =3D wait_command(to2, "{ 'execute': 'migrate-incoming',"
>> +                            "  'arguments': { 'uri': 'tcp:127.0.0.1:0' =
}}");
>> +    qobject_unref(rsp);
>> +
>> +    /* 300ms it should converge */
>> +    migrate_set_parameter_int(from, "downtime-limit", 300);
>> +
>> +    uri =3D migrate_get_socket_address(to2, "socket-address");
>> +
>> +    wait_for_migration_status(from, "cancelled", NULL);

That is exactly what this last line does, not?
The rest of things that we do here are for "to2" instance, that don't
affect us at all.

Once told that, I think that it makes sense to just move the set of
downtime-limit after the migration.

Thanks, Juan.


>> +
>> +    migrate_qmp(from, uri, "{}");
>> +
>> +    wait_for_migration_pass(from);
>> +
>> +    if (!got_stop) {
>> +        qtest_qmp_eventwait(from, "STOP");
>> +    }
>> +    qtest_qmp_eventwait(to2, "RESUME");
>> +
>> +    wait_for_serial("dest_serial");
>> +    wait_for_migration_complete(from);
>> +    test_migrate_end(from, to2, true);
>> +    free(uri);
>> +}
>> +
>>  int main(int argc, char **argv)
>>  {
>>      char template[] =3D "/tmp/migration-test-XXXXXX";
>> @@ -1322,6 +1429,7 @@ int main(int argc, char **argv)
>> =20
>>      qtest_add_func("/migration/auto_converge", test_migrate_auto_conver=
ge);
>>      qtest_add_func("/migration/multifd/tcp", test_multifd_tcp);
>> +    qtest_add_func("/migration/multifd/tcp/cancel", test_multifd_tcp_ca=
ncel);
>> =20
>>      ret =3D g_test_run();
>> =20
>> --=20
>> 2.24.1
>>=20
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


