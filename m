Return-Path: <SRS0=7Gz3=WW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13FE2C3A59F
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 10:44:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6B1220828
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 10:44:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="PSS/rDIw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6B1220828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2CTg-000520-Ol
	for qemu-devel@archiver.kernel.org; Mon, 26 Aug 2019 06:44:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40465)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yury-kotov@yandex-team.ru>) id 1i2CSg-0004aO-T3
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 06:43:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yury-kotov@yandex-team.ru>) id 1i2CSf-0003fm-Hy
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 06:42:58 -0400
Received: from forwardcorp1j.mail.yandex.net ([5.45.199.163]:59880)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yury-kotov@yandex-team.ru>)
 id 1i2CSf-0003fN-7O
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 06:42:57 -0400
Received: from mxbackcorp1g.mail.yandex.net (mxbackcorp1g.mail.yandex.net
 [IPv6:2a02:6b8:0:1402::301])
 by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id B9FBC2E0B17;
 Mon, 26 Aug 2019 13:42:54 +0300 (MSK)
Received: from localhost (localhost [::1])
 by mxbackcorp1g.mail.yandex.net (nwsmtp/Yandex) with ESMTP id
 Gufxu1MJVq-gsZ4ORVu; Mon, 26 Aug 2019 13:42:54 +0300
Precedence: bulk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1566816174; bh=/DB52OGG1d/2jMkZxzgKva+pDbNTi/VunlBlqg0arJQ=;
 h=Subject:In-Reply-To:Cc:Date:References:To:From:Message-Id;
 b=PSS/rDIw3xr+sY3EP/aqLZ2R8PoXyAblXT6KvAkRkXV+dBAOgVwayVTqvK0rmR/4I
 A2iLmn+B/wYfkGqQX5vlFrhvOOYY1HGq8ywVxfcSwZ4ylB8/sV2O60hQHO7zNu+OUl
 mwyRaBjjT0E9B+O9vSe7DOOjdIkfAzd0sgBheRms=
Authentication-Results: mxbackcorp1g.mail.yandex.net;
 dkim=pass header.i=@yandex-team.ru
X-Yandex-Sender-Uid: 1120000000071945
X-Yandex-Avir: 1
Received: from mxbackcorp1g.mail.yandex.net (localhost [::1])
 by mxbackcorp1g.mail.yandex.net with LMTP id u5K20j1sme-R6ch8Iii
 for <yury-kotov@yandex-team.ru>; Mon, 26 Aug 2019 13:42:43 +0300
Received: by iva5-c4dd0484b46b.qloud-c.yandex.net with HTTP;
 Mon, 26 Aug 2019 13:42:43 +0300
From: Yury Kotov <yury-kotov@yandex-team.ru>
To: Dr. David Alan Gilbert <dgilbert@redhat.com>
In-Reply-To: <20190826103726.25538-4-yury-kotov@yandex-team.ru>
References: <20190826103726.25538-1-yury-kotov@yandex-team.ru>
 <20190826103726.25538-4-yury-kotov@yandex-team.ru>
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date: Mon, 26 Aug 2019 13:42:53 +0300
Message-Id: <796011566816163@iva5-c4dd0484b46b.qloud-c.yandex.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 5.45.199.163
Subject: Re: [Qemu-devel] [PATCH v5 3/3] tests/migration: Add a test for
 auto converge
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 "open list:Overall" <qemu-devel@nongnu.org>,
 "yc-core@yandex-team.ru" <yc-core@yandex-team.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

David,

I kept your Reviewed-by, but could you take another look at the test?
I've made many changes in it.

Thanks!

26.08.2019, 13:39, "Yury Kotov" <yury-kotov@yandex-team.ru>:
> Signed-off-by: Yury Kotov <yury-kotov@yandex-team.ru>
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
> =C2=A0tests/migration-test.c | 120 ++++++++++++++++++++++++++++++++++++=
+----
> =C2=A01 file changed, 109 insertions(+), 11 deletions(-)
>
> diff --git a/tests/migration-test.c b/tests/migration-test.c
> index b87ba99a9e..e5caf93dfa 100644
> --- a/tests/migration-test.c
> +++ b/tests/migration-test.c
> @@ -240,6 +240,17 @@ static int64_t read_ram_property_int(QTestState *w=
ho, const char *property)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return result;
> =C2=A0}
>
> +static int64_t read_migrate_property_int(QTestState *who, const char *=
property)
> +{
> + QDict *rsp_return;
> + int64_t result;
> +
> + rsp_return =3D migrate_query(who);
> + result =3D qdict_get_try_int(rsp_return, property, 0);
> + qobject_unref(rsp_return);
> + return result;
> +}
> +
> =C2=A0static uint64_t get_migration_pass(QTestState *who)
> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return read_ram_property_int(who, "dirty-=
sync-count");
> @@ -254,20 +265,22 @@ static void read_blocktime(QTestState *who)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0qobject_unref(rsp_return);
> =C2=A0}
>
> +static bool check_migration_status(QTestState *who, const char *status=
)
> +{
> + bool completed;
> + char *current_status;
> +
> + current_status =3D migrate_query_status(who);
> + completed =3D strcmp(current_status, status) =3D=3D 0;
> + g_assert_cmpstr(current_status, !=3D, "failed");
> + g_free(current_status);
> + return completed;
> +}
> +
> =C2=A0static void wait_for_migration_status(QTestState *who,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0const char *goal)
> =C2=A0{
> - while (true) {
> - bool completed;
> - char *status;
> -
> - status =3D migrate_query_status(who);
> - completed =3D strcmp(status, goal) =3D=3D 0;
> - g_assert_cmpstr(status, !=3D, "failed");
> - g_free(status);
> - if (completed) {
> - return;
> - }
> + while (!check_migration_status(who, goal)) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0usleep(1000);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> =C2=A0}
> @@ -1125,6 +1138,90 @@ static void test_migrate_fd_proto(void)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0test_migrate_end(from, to, true);
> =C2=A0}
>
> +static void test_migrate_auto_converge(void)
> +{
> + char *uri =3D g_strdup_printf("unix:%s/migsocket", tmpfs);
> + QTestState *from, *to;
> + int64_t remaining, percentage;
> +
> + /*
> + * We want the test to be stable and as fast as possible.
> + * E.g., with 1Gb/s bandwith migration may pass without throttling,
> + * so we need to decrease a bandwidth.
> + */
> + const int64_t init_pct =3D 5, inc_pct =3D 50, max_pct =3D 95;
> + const int64_t max_bandwidth =3D 400000000; /* ~400Mb/s */
> + const int64_t downtime_limit =3D 250; /* 250ms */
> + /*
> + * We migrate through unix-socket (> 500Mb/s).
> + * Thus, expected migration speed ~=3D bandwidth limit (< 500Mb/s).
> + * So, we can predict expected_threshold
> + */
> + const int64_t expected_threshold =3D max_bandwidth * downtime_limit /=
 1000;
> +
> + if (test_migrate_start(&from, &to, uri, false, false)) {
> + return;
> + }
> +
> + migrate_set_capability(from, "auto-converge", true);
> + migrate_set_parameter_int(from, "cpu-throttle-initial", init_pct);
> + migrate_set_parameter_int(from, "cpu-throttle-increment", inc_pct);
> + migrate_set_parameter_int(from, "max-cpu-throttle", max_pct);
> +
> + /*
> + * Set the initial parameters so that the migration could not converge
> + * without throttling.
> + */
> + migrate_set_parameter_int(from, "downtime-limit", 1);
> + migrate_set_parameter_int(from, "max-bandwidth", 100000000); /* ~100M=
b/s */
> +
> + /* To check remaining size after precopy */
> + migrate_set_capability(from, "pause-before-switchover", true);
> +
> + /* Wait for the first serial output from the source */
> + wait_for_serial("src_serial");
> +
> + migrate(from, uri, "{}");
> +
> + /* Wait for throttling begins */
> + percentage =3D 0;
> + while (percentage =3D=3D 0) {
> + percentage =3D read_migrate_property_int(from, "cpu-throttle-percenta=
ge");
> + usleep(100);
> + g_assert_false(got_stop);
> + }
> + /* The first percentage of throttling should be equal to init_pct */
> + g_assert_cmpint(percentage, =3D=3D, init_pct);
> + /* Now, when we tested that throttling works, let it converge */
> + migrate_set_parameter_int(from, "downtime-limit", downtime_limit);
> + migrate_set_parameter_int(from, "max-bandwidth", max_bandwidth);
> +
> + /*
> + * Wait for pre-switchover status to check last throttle percentage
> + * and remaining. These values will be zeroed later
> + */
> + wait_for_migration_status(from, "pre-switchover");
> +
> + /* The final percentage of throttling shouldn't be greater than max_p=
ct */
> + percentage =3D read_migrate_property_int(from, "cpu-throttle-percenta=
ge");
> + g_assert_cmpint(percentage, <=3D, max_pct);
> +
> + remaining =3D read_ram_property_int(from, "remaining");
> + g_assert_cmpint(remaining, <, expected_threshold);
> +
> + wait_command(from, "{ 'execute': 'migrate-continue' , 'arguments':"
> + " { 'state': 'pre-switchover' } }");
> +
> + qtest_qmp_eventwait(to, "RESUME");
> +
> + wait_for_serial("dest_serial");
> + wait_for_migration_complete(from);
> +
> + g_free(uri);
> +
> + test_migrate_end(from, to, true);
> +}
> +
> =C2=A0int main(int argc, char **argv)
> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0char template[] =3D "/tmp/migration-test-=
XXXXXX";
> @@ -1180,6 +1277,7 @@ int main(int argc, char **argv)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* qtest_add_func("/migration/ignore_shar=
ed", test_ignore_shared); */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0qtest_add_func("/migration/xbzrle/unix", =
test_xbzrle_unix);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0qtest_add_func("/migration/fd_proto", tes=
t_migrate_fd_proto);
> + qtest_add_func("/migration/auto_converge", test_migrate_auto_converge=
);
>
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ret =3D g_test_run();
>
> --
> 2.22.0

Regards,
Yury

