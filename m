Received: from eggs.gnu.org ([2001:4830:134:3::10]:33319)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eU1xQ-0003Go-PS
	for qemu-devel@nongnu.org; Tue, 26 Dec 2017 22:00:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eU1xL-0006HH-V2
	for qemu-devel@nongnu.org; Tue, 26 Dec 2017 22:00:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52140)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eU1xL-0006Dz-M0
	for qemu-devel@nongnu.org; Tue, 26 Dec 2017 22:00:35 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 23240356E6
	for <qemu-devel@nongnu.org>; Wed, 27 Dec 2017 03:00:34 +0000 (UTC)
Date: Wed, 27 Dec 2017 11:00:29 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20171227030029.GA3202@xz-mi>
References: <20171201125813.1437-1-quintela@redhat.com>
	<20171201125813.1437-3-quintela@redhat.com>
	<20171205073601.GC2925@xz-mi> <877et9p8sx.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <877et9p8sx.fsf@secure.laptop>
Subject: Re: [Qemu-devel] [PATCH v3 2/6] tests: migration test deprecated
 commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com, lvivier@redhat.com

On Tue, Dec 26, 2017 at 08:51:10PM +0100, Juan Quintela wrote:
> Peter Xu <peterx@redhat.com> wrote:
> > On Fri, Dec 01, 2017 at 01:58:09PM +0100, Juan Quintela wrote:
> >> We now test the deprecated commands everytime that we test the new
> >> commands.  This makes unnecesary to add tests for deprecated commands.
> >> 
> >> Signed-off-by: Juan Quintela <quintela@redhat.com>
> >> ---
> >>  tests/migration-test.c | 32 ++++++++++++++++++++++++++++----
> >>  1 file changed, 28 insertions(+), 4 deletions(-)
> >> 
> >> diff --git a/tests/migration-test.c b/tests/migration-test.c
> >> index 799e24ebc6..51f49c74e9 100644
> >> --- a/tests/migration-test.c
> >> +++ b/tests/migration-test.c
> >> @@ -369,7 +369,7 @@ static void migrate_check_parameter(QTestState *who, const char *parameter,
> >>      QDECREF(rsp);
> >>  }
> >>  
> >> -static void migrate_set_downtime(QTestState *who, const double value)
> >> +static void deprecated_set_downtime(QTestState *who, const double value)
> >>  {
> >>      QDict *rsp;
> >>      gchar *cmd;
> >> @@ -388,7 +388,7 @@ static void migrate_set_downtime(QTestState *who, const double value)
> >>      g_free(expected);
> >>  }
> >>  
> >> -static void migrate_set_speed(QTestState *who, const char *value)
> >> +static void deprecated_set_speed(QTestState *who, const char *value)
> >>  {
> >>      QDict *rsp;
> >>      gchar *cmd;
> >> @@ -402,6 +402,30 @@ static void migrate_set_speed(QTestState *who, const char *value)
> >>      migrate_check_parameter(who, "max-bandwidth", value);
> >>  }
> >>  
> >> +static void migrate_set_parameter(QTestState *who, const char *parameter,
> >> +                                  const char *value)
> >> +{
> >> +    QDict *rsp;
> >> +    gchar *cmd;
> >> +
> >> +    if (strcmp(parameter, "downtime-limit") == 0) {
> >> +        deprecated_set_downtime(who, 0.12345);
> >> +    }
> >> +
> >> +    if (strcmp(parameter, "max-bandwidth") == 0) {
> >> +        deprecated_set_speed(who, "12345");
> >> +    }
> >
> > I'm fine with current approach, but I would really prefer to put them
> > all into a standalone test, by just calling them one by one with some
> > specific numbers and that's all.
> 
> That means another test (at least), and we have, also at least three
> deprecated comands:
> - migrate_set_speed
> - migrate_set_downtime
> - migrate_set_cache_size
> 
> And each test makes things slower.  So I *thought* it would we wiser to
> just check _always_ use the deprecated an the not deprecated one.
> 
> > (luckily we only have two deprecated commands and limited tests,
> >  otherwise extra commands will be M*N, say "number of deprecated
> >  command" * "number of test mirations")
> 
> Each test takes time, so adding tests make everything much slower.
> Notice that setting a new setting is fast.
> 
> This was the way that I understood Dave he wanted.

Do you mean every test is slow, or just migration tests?  Here I mean
to only test setting the parameters without doing real migration tests
(then query to make sure the settings were taking effect).  I assume
that should be fast too?  Thanks,

-- 
Peter Xu
