Received: from eggs.gnu.org ([2001:4830:134:3::10]:38548)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bala24@linux.vnet.ibm.com>) id 1fb3kc-0006pS-8l
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 08:52:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bala24@linux.vnet.ibm.com>) id 1fb3kX-00070Z-Ai
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 08:52:46 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44564)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bala24@linux.vnet.ibm.com>)
	id 1fb3kW-0006yh-VO
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 08:52:41 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w65CnQD5080517
	for <qemu-devel@nongnu.org>; Thu, 5 Jul 2018 08:52:39 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2k1gw6716p-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 05 Jul 2018 08:52:39 -0400
Received: from localhost
	by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bala24@linux.vnet.ibm.com>;
	Thu, 5 Jul 2018 13:52:37 +0100
Date: Thu, 5 Jul 2018 18:22:31 +0530
From: Balamuruhan S <bala24@linux.vnet.ibm.com>
References: <20180705080017.31123-1-bala24@linux.vnet.ibm.com>
	<20180705080017.31123-3-bala24@linux.vnet.ibm.com>
	<20180705092609.GE1389@xz-mi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180705092609.GE1389@xz-mi>
Message-Id: <20180705125230.GC22608@localhost.localdomain>
Subject: Re: [Qemu-devel] [PATCH 2/2] tests: add precopy multifd migration
 with fd protocol
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

On Thu, Jul 05, 2018 at 05:26:09PM +0800, Peter Xu wrote:
> On Thu, Jul 05, 2018 at 01:30:17PM +0530, Balamuruhan S wrote:
> > This patch adds test for multifd migration feature with fd protocol.
> > 
> > Signed-off-by: Balamuruhan S <bala24@linux.vnet.ibm.com>
> > ---
> >  tests/migration-test.c | 57 ++++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 57 insertions(+)
> > 
> > diff --git a/tests/migration-test.c b/tests/migration-test.c
> > index e2434e70ea..29ede3810d 100644
> > --- a/tests/migration-test.c
> > +++ b/tests/migration-test.c
> > @@ -10,6 +10,7 @@
> >   *
> >   */
> >  
> > +#include <unistd.h>
> >  #include "qemu/osdep.h"
> >  
> >  #include "libqtest.h"
> > @@ -202,6 +203,17 @@ static void read_blocktime(QTestState *who)
> >      qobject_unref(rsp);
> >  }
> >  
> > +static void getfd(QTestState *who, const char *fdname, int fd)
> > +{
> > +    QDict *rsp;
> > +    gchar *cmd = g_strdup_printf("{ 'execute': 'getfd',"
> > +                                 "'arguments': { '%s': '%d'} }", fdname, fd);
> > +    rsp = wait_command(who, cmd);
> 
> AFAIU Libvirt passes fds to QEMU via the QMP channel using SCM_RIGHTS.
> Here we directly specified the fd number. Could you help explain a bit
> on how it worked?

Thank you Peter for reviewing the patch.

so I explored on pipe() system call, that could create channel for inter
process communication. It gives us 2 fds one for read (I thought
we can use it for target qemu process) and one for write (we can use it
for source qemu process). I tried the example snippet from man page so
I thought we can use it in our migration Qtest.

Please correct my work if it doesn't make sense.

> 
> > +    g_assert(qdict_haskey(rsp, "return"));
> > +    g_free(cmd);
> > +    qobject_unref(rsp);
> > +}
> > +
> >  static void wait_for_migration_complete(QTestState *who)
> >  {
> >      while (true) {
> > @@ -619,6 +631,50 @@ static void test_precopy_unix(void)
> >      g_free(uri);
> >  }
> >  
> > +static void test_multifd_fd(void)
> > +{
> > +    int fd[2];
> > +
> > +    /* create pipe */
> > +    if (pipe(fd) == -1)
> > +        g_test_message("Skipping test: Unable to create pipe");
> > +        return;
> > +
> > +    /* set uri in target with read fd */
> > +    char *uri = g_strdup_printf("fd:%d", fd[0]);
> > +    QTestState *from, *to;
> > +    test_migrate_start(&from, &to, uri, false);
> > +
> > +    /* Receive a write file descriptor for source using getfd */
> > +    getfd(from, "srcfd", fd[1]);
> > +
> > +    /* set multifd capability on source and target */
> > +    migrate_set_capability(from, "x-multifd", "true");
> > +    migrate_set_capability(to, "x-multifd", "true");
> > +
> > +    /* Wait for the first serial output from the source */
> > +    wait_for_serial("src_serial");
> > +
> > +    /* perform migration */
> > +    migrate(from, uri);
> 
> I'm not sure I understand correctly here, but I feel like we should
> use the fd[1] or anything that was bound to fd[1] on source side to do
> the migration rather than fd[0]?  Please feel free to correct me..
> 

fd[0] - read channel so we should use it for target (-incoming fd:fd[0])
fd[1] - write channel so we shouls use it for source to transfer/write
and for it we need to assign using `getfd` monitor command on source.

> Regards,
> 
> > +
> > +    wait_for_migration_pass(from);
> > +
> > +    if (!got_stop) {
> > +        qtest_qmp_eventwait(from, "STOP");
> > +    }
> > +    qtest_qmp_eventwait(to, "RESUME");
> > +
> > +    wait_for_serial("dest_serial");
> > +    wait_for_migration_complete(from);
> > +    test_migrate_end(from, to, true);
> > +    g_free(uri);
> > +
> > +    /* close the fds */
> > +    close(fd[0]);
> > +    close(fd[1]);

After studying manual example program, we should close the fds
before we start migration like we use for O_CLOSEXEC on fd.
so I will work on resend the patch and fixing style issue caught by
patchew (sorry for it).

-- Bala
> > +}
> > +
> >  static void test_multifd_unix(void)
> >  {
> >      char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
> > @@ -673,6 +729,7 @@ int main(int argc, char **argv)
> >      qtest_add_func("/migration/bad_dest", test_baddest);
> >      qtest_add_func("/migration/precopy/unix", test_precopy_unix);
> >      qtest_add_func("/migration/multifd/unix", test_multifd_unix);
> > +    qtest_add_func("/migration/multifd/fd", test_multifd_fd);
> >  
> >      ret = g_test_run();
> >  
> > -- 
> > 2.14.3
> > 
> 
> -- 
> Peter Xu
> 
