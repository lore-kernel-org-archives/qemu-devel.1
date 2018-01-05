Received: from eggs.gnu.org ([2001:4830:134:3::10]:59392)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eXXrk-00082W-00
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 14:41:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eXXre-0007vL-Rg
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 14:41:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46218)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1eXXre-0007uS-Ez
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 14:41:14 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B5EE7780EF
	for <qemu-devel@nongnu.org>; Fri,  5 Jan 2018 19:41:12 +0000 (UTC)
Date: Fri, 5 Jan 2018 19:41:04 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180105194104.GC2490@work-vm>
References: <20171201125813.1437-1-quintela@redhat.com>
	<20171201125813.1437-6-quintela@redhat.com>
	<20171208114241.GJ2403@work-vm> <87r2r4nmbq.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r2r4nmbq.fsf@secure.laptop>
Subject: Re: [Qemu-devel] [PATCH v3 5/6] tests: Add migration xbzrle test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, peterx@redhat.com

* Juan Quintela (quintela@redhat.com) wrote:
> "Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> > * Juan Quintela (quintela@redhat.com) wrote:
> >> Signed-off-by: Juan Quintela <quintela@redhat.com>
> >> ---
> >>  tests/migration-test.c | 68 ++++++++++++++++++++++++++++++++++++++++++++++++++
> >>  1 file changed, 68 insertions(+)
> >> 
> >> diff --git a/tests/migration-test.c b/tests/migration-test.c
> >> index 841c89e28a..41dee78a9a 100644
> >> --- a/tests/migration-test.c
> >> +++ b/tests/migration-test.c
> >> @@ -410,6 +410,20 @@ static void deprecated_set_speed(QTestState *who, const char *value)
> >>      migrate_check_parameter(who, "max-bandwidth", value);
> >>  }
> >>  
> >> +static void deprecated_set_cache_size(QTestState *who, const char *value)
> >> +{
> >> +    QDict *rsp;
> >> +    gchar *cmd;
> >> +
> >> +    cmd = g_strdup_printf("{ 'execute': 'migrate-set-cache-size',"
> >> +                          "'arguments': { 'value': %s } }", value);
> >> +    rsp = qtest_qmp(who, cmd);
> >> +    g_free(cmd);
> >> +    g_assert(qdict_haskey(rsp, "return"));
> >> +    QDECREF(rsp);
> >> +    migrate_check_parameter(who, "xbzrle-cache-size", value);
> >> +}
> >> +
> >>  static void migrate_set_parameter(QTestState *who, const char *parameter,
> >>                                    const char *value)
> >>  {
> >> @@ -424,6 +438,10 @@ static void migrate_set_parameter(QTestState *who, const char *parameter,
> >>          deprecated_set_speed(who, "12345");
> >>      }
> >>  
> >> +    if (strcmp(parameter, "xbzrle-cache-size") == 0) {
> >> +        deprecated_set_cache_size(who, "4096");
> >> +    }
> >> +
> >>      cmd = g_strdup_printf("{ 'execute': 'migrate-set-parameters',"
> >>                            "'arguments': { '%s': %s } }",
> >>                            parameter, value);
> >> @@ -673,6 +691,55 @@ static void test_precopy_tcp(void)
> >>      g_free(port);
> >>  }
> >>  
> >> +static void test_xbzrle(const char *uri)
> >> +{
> >> +    QTestState *from, *to;
> >> +
> >> +    test_migrate_start(&from, &to, uri);
> >> +
> >> +    /* We want to pick a speed slow enough that the test completes
> >> +     * quickly, but that it doesn't complete precopy even on a slow
> >> +     * machine, so also set the downtime.
> >> +     */
> >> +    /* 100 ms */
> >> +    migrate_set_parameter(from, "downtime-limit", "1");
> >
> > ? That's 1 ms not 100ms as the comment says?
> 
> Changed comment.
> 
> >
> >> +    /* 1MB/s slow*/
> >> +    migrate_set_parameter(from, "max-bandwidth", "1000000000");
> >
> > That's still 1GB/s isn't it?
> 
> Changed also.
> 
> > Don't you need to reduce that if xbzrle is actually working otherwise
> > it'll complete?
> 
> It don't complete on my setup (dunno with a faster machine).
> 
> >> +    migrate_set_parameter(from, "xbzrle-cache-size", "33554432");
> >
> > That's 32M - why?
> 
> I need to check that the command is running, no clue about _which_ one
> is better here.
> 
> > The test continually rewrites 100M of data; only changing one byte/page
> > - so actually the fun way to do the xbzrle test is to leave this as 32M
> > here.....
> 
> My idea here is that we somke test all the transports/commands.  Not
> that I fully test everything.

OK, but if you set the cache size to 150M instead of 32M then xbzrle
should actually kick in and be tested; at 32M very little is being
tested.

> See on my next series, It already takes around 15 seconds, just adding
> stuff will make things go longer really fast.
> 
> BTW, is there a trivial way to convince qtest/getestr whatevre to run
> all the migration tests in parallel?

Not that I know of.

Dave

> Later, Juan.
> 
> 
> 
> >> +    migrate_set_capability(from, "xbzrle", "true");
> >> +    migrate_set_capability(to, "xbzrle", "true");
> >> +    /* Wait for the first serial output from the source */
> >> +    wait_for_serial("src_serial");
> >> +
> >> +    migrate(from, uri);
> >> +
> >> +    wait_for_migration_pass(from);
> >> +
> >> +    /* 300ms it should converge */
> >> +    migrate_set_parameter(from, "downtime-limit", "300");
> >
> > but first increase the xvzrle cache to 120M and give it a couple of
> > seconds delay; you might even find it completes without the downtime
> > limit schange; but you should still do that after a few seconds.
> > You can check the stats as well, you should get some xbzrle cache hits
> > as long as you raised the cache size.
> >
> > Dave
> >
> >> +    if (!got_stop) {
> >> +        qtest_qmp_eventwait(from, "STOP");
> >> +    }
> >> +    qtest_qmp_eventwait(to, "RESUME");
> >> +
> >> +    wait_for_serial("dest_serial");
> >> +    wait_for_migration_complete(from);
> >> +
> >> +    test_migrate_end(from, to);
> >> +}
> >> +
> >> +static void test_xbzrle_unix(void)
> >> +{
> >> +    char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
> >> +
> >> +    test_xbzrle(uri);
> >> +    g_free(uri);
> >> +}
> >> +
> >> +
> >>  int main(int argc, char **argv)
> >>  {
> >>      char template[] = "/tmp/migration-test-XXXXXX";
> >> @@ -695,6 +762,7 @@ int main(int argc, char **argv)
> >>      qtest_add_func("/migration/precopy/unix", test_precopy_unix);
> >>      qtest_add_func("/migration/precopy/tcp", test_precopy_tcp);
> >>      qtest_add_func("/migration/postcopy/unix", test_postcopy);
> >> +    qtest_add_func("/migration/xbzrle/unix", test_xbzrle_unix);
> >>  
> >>      ret = g_test_run();
> >>  
> >> -- 
> >> 2.14.3
> >> 
> > --
> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
