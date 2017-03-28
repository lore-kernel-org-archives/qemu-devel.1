Received: from eggs.gnu.org ([2001:4830:134:3::10]:56911)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1csmKJ-00044N-2V
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 04:18:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1csmKF-0002q6-1Z
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 04:18:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44648)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1csmKE-0002oM-Ot
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 04:17:58 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D3A50C05091A
	for <qemu-devel@nongnu.org>; Tue, 28 Mar 2017 08:17:57 +0000 (UTC)
Date: Tue, 28 Mar 2017 09:17:54 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170328081753.GA2509@work-vm>
References: <1490092792-30957-1-git-send-email-thuth@redhat.com>
	<1490092792-30957-3-git-send-email-thuth@redhat.com>
	<20170327142421.GF2373@work-vm>
	<95bf59af-beeb-74bf-7819-f2a770b64263@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95bf59af-beeb-74bf-7819-f2a770b64263@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/3] libqtest: Add a generic function to
 run a callback function for every machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

* Thomas Huth (thuth@redhat.com) wrote:
> On 27.03.2017 16:24, Dr. David Alan Gilbert wrote:
> > * Thomas Huth (thuth@redhat.com) wrote:
> >> Some tests need to run single tests for every available machine of the
> >> current QEMU binary. To avoid code duplication, let's extract this
> >> code that deals with 'query-machines' into a separate function.
> >>
> >> Signed-off-by: Thomas Huth <thuth@redhat.com>
> > 
> > Having queued it, it's failing my test.
> > 
> > The reason is that qom-tests.c has a blacklist which blacklists Xen;
> > however your new generic function doesn't have the blacklist, so when
> > you run HMP commands on all machines it tries to run it on Xen since
> > my PC has the Xen libraries installed (so builds with Xen support) but
> > isn't a Xen guest.
> > 
> > It fails with:
> > xen be core: xen be core: can't connect to xenstored
> > can't connect to xenstored
> > xen_init_pv: xen backend core setup failed
> > Broken pipe
> > 
> > I suggest you probably need to share the blacklist as well.
> > 
> > (Unqueued)
> > 
> > Dave
> > 
> >> ---
> >>  tests/libqtest.c    | 30 +++++++++++++++++
> >>  tests/libqtest.h    |  8 +++++
> >>  tests/pc-cpu-test.c | 95 ++++++++++++++++++++---------------------------------
> >>  tests/qom-test.c    | 36 ++++----------------
> >>  4 files changed, 80 insertions(+), 89 deletions(-)
> >>
> >> diff --git a/tests/libqtest.c b/tests/libqtest.c
> >> index c9b2d76..d8b8066 100644
> >> --- a/tests/libqtest.c
> >> +++ b/tests/libqtest.c
> >> @@ -938,3 +938,33 @@ bool qtest_big_endian(QTestState *s)
> >>  {
> >>      return s->big_endian;
> >>  }
> >> +
> >> +void qtest_cb_for_every_machine(void (*cb)(const char *machine))
> >> +{
> >> +    QDict *response, *minfo;
> >> +    QList *list;
> >> +    const QListEntry *p;
> >> +    QObject *qobj;
> >> +    QString *qstr;
> >> +    const char *mname;
> >> +
> >> +    qtest_start("-machine none");
> >> +    response = qmp("{ 'execute': 'query-machines' }");
> >> +    g_assert(response);
> >> +    list = qdict_get_qlist(response, "return");
> >> +    g_assert(list);
> >> +
> >> +    for (p = qlist_first(list); p; p = qlist_next(p)) {
> >> +        minfo = qobject_to_qdict(qlist_entry_obj(p));
> >> +        g_assert(minfo);
> >> +        qobj = qdict_get(minfo, "name");
> >> +        g_assert(qobj);
> >> +        qstr = qobject_to_qstring(qobj);
> >> +        g_assert(qstr);
> >> +        mname = qstring_get_str(qstr);
> >> +        cb(mname);
> >> +    }
> >> +
> >> +    qtest_end();
> >> +    QDECREF(response);
> >> +}
> [...]
> >> diff --git a/tests/qom-test.c b/tests/qom-test.c
> >> index d48f890..ab0595d 100644
> >> --- a/tests/qom-test.c
> >> +++ b/tests/qom-test.c
> >> @@ -107,46 +107,22 @@ static void test_machine(gconstpointer data)
> >>      g_free((void *)machine);
> >>  }
> >>  
> >> -static void add_machine_test_cases(void)
> >> +static void add_machine_test_case(const char *mname)
> >>  {
> >>      const char *arch = qtest_get_arch();
> >> -    QDict *response, *minfo;
> >> -    QList *list;
> >> -    const QListEntry *p;
> >> -    QObject *qobj;
> >> -    QString *qstr;
> >> -    const char *mname;
> >>  
> >> -    qtest_start("-machine none");
> >> -    response = qmp("{ 'execute': 'query-machines' }");
> >> -    g_assert(response);
> >> -    list = qdict_get_qlist(response, "return");
> >> -    g_assert(list);
> >> -
> >> -    for (p = qlist_first(list); p; p = qlist_next(p)) {
> >> -        minfo = qobject_to_qdict(qlist_entry_obj(p));
> >> -        g_assert(minfo);
> >> -        qobj = qdict_get(minfo, "name");
> >> -        g_assert(qobj);
> >> -        qstr = qobject_to_qstring(qobj);
> >> -        g_assert(qstr);
> >> -        mname = qstring_get_str(qstr);
> >> -        if (!is_blacklisted(arch, mname)) {
> >> -            char *path = g_strdup_printf("qom/%s", mname);
> >> -            qtest_add_data_func(path, g_strdup(mname), test_machine);
> >> -            g_free(path);
> >> -        }
> >> +    if (!is_blacklisted(arch, mname)) {
> >> +        char *path = g_strdup_printf("qom/%s", mname);
> >> +        qtest_add_data_func(path, g_strdup(mname), test_machine);
> >> +        g_free(path);
> >>      }
> 
> Not sure what is going wrong here ... the "!is_blacklisted" check is
> still here, so why is it trying to start a xen machine here?

I don't think it's this test that fails, I think it's the new one you add
in the last patch but for the same reason.

> Looks like I need to install those xen libraries here, too ...

I think it's xen-libs and xen-devel you need.

Dave

> 
>  Thomas
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
