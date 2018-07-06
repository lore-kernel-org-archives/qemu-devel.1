Received: from eggs.gnu.org ([2001:4830:134:3::10]:38358)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bala24@linux.vnet.ibm.com>) id 1fbK3p-00070p-9B
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 02:17:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bala24@linux.vnet.ibm.com>) id 1fbK3m-0007G9-3u
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 02:17:41 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40930
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bala24@linux.vnet.ibm.com>)
	id 1fbK3l-0007C6-Th
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 02:17:38 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w666EH8V018193
	for <qemu-devel@nongnu.org>; Fri, 6 Jul 2018 02:17:36 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2k1ugg6mb1-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 06 Jul 2018 02:17:36 -0400
Received: from localhost
	by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bala24@linux.vnet.ibm.com>;
	Fri, 6 Jul 2018 07:17:35 +0100
Date: Fri, 6 Jul 2018 11:47:29 +0530
From: Balamuruhan S <bala24@linux.vnet.ibm.com>
References: <20180705031755.3254-1-peterx@redhat.com>
	<20180705031755.3254-5-peterx@redhat.com>
	<20180705093144.GA22608@localhost.localdomain>
	<20180706021951.GD23001@xz-mi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180706021951.GD23001@xz-mi>
Message-Id: <20180706061729.GA23897@localhost.localdomain>
Subject: Re: [Qemu-devel] [PATCH for-3.0 4/9] tests: introduce
 migrate_postcopy_* helpers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org

On Fri, Jul 06, 2018 at 10:19:51AM +0800, Peter Xu wrote:
> On Thu, Jul 05, 2018 at 03:01:44PM +0530, Balamuruhan S wrote:
> > On Thu, Jul 05, 2018 at 11:17:50AM +0800, Peter Xu wrote:
> > > Separate the old postcopy UNIX socket test into three steps, provide a
> > > helper for each step.  With these helpers, we can do more compliated
> > > tests like postcopy recovery, while keep the codes shared.
> > > 
> > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > > ---
> > >  tests/migration-test.c | 38 +++++++++++++++++++++++++++-----------
> > >  1 file changed, 27 insertions(+), 11 deletions(-)
> > > 
> > > diff --git a/tests/migration-test.c b/tests/migration-test.c
> > > index 3a85446f95..2155869b96 100644
> > > --- a/tests/migration-test.c
> > > +++ b/tests/migration-test.c
> > > @@ -351,13 +351,19 @@ static void migrate(QTestState *who, const char *uri)
> > >      qobject_unref(rsp);
> > >  }
> > > 
> > > -static void migrate_start_postcopy(QTestState *who)
> > > +static void migrate_postcopy_start(QTestState *from, QTestState *to)
> > >  {
> > >      QDict *rsp;
> > > 
> > > -    rsp = wait_command(who, "{ 'execute': 'migrate-start-postcopy' }");
> > > +    rsp = wait_command(from, "{ 'execute': 'migrate-start-postcopy' }");
> > >      g_assert(qdict_haskey(rsp, "return"));
> > >      qobject_unref(rsp);
> > > +
> > > +    if (!got_stop) {
> > > +        qtest_qmp_eventwait(from, "STOP");
> > > +    }
> > > +
> > > +    qtest_qmp_eventwait(to, "RESUME");
> > >  }
> > > 
> > >  static void test_migrate_start(QTestState **from, QTestState **to,
> > > @@ -505,7 +511,8 @@ static void test_deprecated(void)
> > >      qtest_quit(from);
> > >  }
> > > 
> > > -static void test_postcopy(void)
> > > +static void migrate_postcopy_prepare(QTestState **from_ptr,
> > > +                                     QTestState **to_ptr)
> > 
> > if we have uri as one of the configurable argument, it would be still
> > better, so that in future we can call migrate_postcopy_prepare() with
> > any different uri.
> 
> Yes, though we'd better have a first user of it.  Now postcopy only
> covers unix socket test.  We don't have a large matrix yet.
> 
> We can add that when we start to add more complicated tests for
> postcopy.  Thanks,

sure Peter.

Reviewed-by: Balamuruhan S <bala24@linux.vnet.ibm.com>
> 
> -- 
> Peter Xu
> 
