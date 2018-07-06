Received: from eggs.gnu.org ([2001:4830:134:3::10]:34676)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bala24@linux.vnet.ibm.com>) id 1fbJeu-0001Lf-Pu
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 01:51:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bala24@linux.vnet.ibm.com>) id 1fbJeq-0002I0-RU
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 01:51:56 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44992)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bala24@linux.vnet.ibm.com>)
	id 1fbJeq-0002EC-Gn
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 01:51:52 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w665n6oR061945
	for <qemu-devel@nongnu.org>; Fri, 6 Jul 2018 01:51:51 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2k21h3a302-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 06 Jul 2018 01:51:50 -0400
Received: from localhost
	by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bala24@linux.vnet.ibm.com>;
	Fri, 6 Jul 2018 06:51:48 +0100
Date: Fri, 6 Jul 2018 11:21:42 +0530
From: Balamuruhan S <bala24@linux.vnet.ibm.com>
References: <20180705080017.31123-1-bala24@linux.vnet.ibm.com>
	<20180705080017.31123-3-bala24@linux.vnet.ibm.com>
	<20180705092609.GE1389@xz-mi>
	<20180705125230.GC22608@localhost.localdomain>
	<20180706043740.GG23001@xz-mi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180706043740.GG23001@xz-mi>
Message-Id: <20180706055142.GA12737@localhost.localdomain>
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

On Fri, Jul 06, 2018 at 12:37:40PM +0800, Peter Xu wrote:
> On Thu, Jul 05, 2018 at 06:22:31PM +0530, Balamuruhan S wrote:
> > On Thu, Jul 05, 2018 at 05:26:09PM +0800, Peter Xu wrote:
> > > On Thu, Jul 05, 2018 at 01:30:17PM +0530, Balamuruhan S wrote:
> > > > This patch adds test for multifd migration feature with fd protocol.
> > > > 
> > > > Signed-off-by: Balamuruhan S <bala24@linux.vnet.ibm.com>
> > > > ---
> > > >  tests/migration-test.c | 57 ++++++++++++++++++++++++++++++++++++++++++++++++++
> > > >  1 file changed, 57 insertions(+)
> > > > 
> > > > diff --git a/tests/migration-test.c b/tests/migration-test.c
> > > > index e2434e70ea..29ede3810d 100644
> > > > --- a/tests/migration-test.c
> > > > +++ b/tests/migration-test.c
> > > > @@ -10,6 +10,7 @@
> > > >   *
> > > >   */
> > > >  
> > > > +#include <unistd.h>
> > > >  #include "qemu/osdep.h"
> > > >  
> > > >  #include "libqtest.h"
> > > > @@ -202,6 +203,17 @@ static void read_blocktime(QTestState *who)
> > > >      qobject_unref(rsp);
> > > >  }
> > > >  
> > > > +static void getfd(QTestState *who, const char *fdname, int fd)
> > > > +{
> > > > +    QDict *rsp;
> > > > +    gchar *cmd = g_strdup_printf("{ 'execute': 'getfd',"
> > > > +                                 "'arguments': { '%s': '%d'} }", fdname, fd);
> > > > +    rsp = wait_command(who, cmd);
> > > 
> > > AFAIU Libvirt passes fds to QEMU via the QMP channel using SCM_RIGHTS.
> > > Here we directly specified the fd number. Could you help explain a bit
> > > on how it worked?
> > 
> > Thank you Peter for reviewing the patch.
> > 
> > so I explored on pipe() system call, that could create channel for inter
> > process communication. It gives us 2 fds one for read (I thought
> > we can use it for target qemu process) and one for write (we can use it
> > for source qemu process). I tried the example snippet from man page so
> > I thought we can use it in our migration Qtest.
> > 
> > Please correct my work if it doesn't make sense.
> 
> Yeah the pipe() usage should be fine - though it's the way to pass it
> to QEMU that I'm not sure about.
> 
> Ok I gave it a shot with your tests on my host and I got this
> actually:
> 
>   $ QTEST_QEMU_BINARY=./x86_64-softmmu/qemu-system-x86_64 ./tests/migration-test -p /x86_64/migration/multifd/fd
>   /x86_64/migration/multifd/fd: **
>   ERROR:/home/peterx/git/qemu/tests/migration-test.c:212:getfd: assertion failed: (qdict_haskey(rsp, "return"))
>   Aborted (core dumped)
>   $ QTEST_QEMU_BINARY=./x86_64-softmmu/qemu-system-x86_64 QTEST_LOG=1 ./tests/migration-test -p /x86_64/migration/multifd/fd
>   /x86_64/migration/multifd/fd: [I 1530851360.669526] OPENED
>   [R +0.037850] endianness
>   [S +0.037870] OK little
>   {"QMP": {"version": {"qemu": {"micro": 50, "minor": 12, "major": 2}, "package": "v2.12.0-2164-g20aa87a802"}, "capabilities": []}}{"execute": "qmp_capabilities"}
>   
>   {"return": {}}[I 1530851360.754972] OPENED
>   [R +0.055719] endianness
>   [S +0.055737] OK little
>   {"QMP": {"version": {"qemu": {"micro": 50, "minor": 12, "major": 2}, "package": "v2.12.0-2164-g20aa87a802"}, "capabilities": []}}{"execute": "qmp_capabilities"}
>   
>   {"return": {}}{"execute": "getfd", "arguments": {"srcfd": "5"}}
>   
>   {"error": {"class": "GenericError", "desc": "Parameter 'fdname' is missing"}}**
>   ERROR:/home/peterx/git/qemu/tests/migration-test.c:212:getfd: assertion failed: (qdict_haskey(rsp, "return"))
>   [I +0.058378] CLOSED
>   [I +0.156930] CLOSED
>   Aborted (core dumped)

Okay, I think this is what I am facing when I run it in tp-qemu which I
mentioned in cover letter, I will work on it to make it work in right way.

> 
> So it seems that the "getfd" command will only take one parameter
> "fdname", then the fd should be passed in by UNIX socket magic.  That
> should match with what I understand it.  I'm not sure why it worked on
> your host.

fine, I will use the getfd correctly as per your suggestion, I couldn't hit error,
it was silent false pass.

> 
> > 
> > > 
> > > > +    g_assert(qdict_haskey(rsp, "return"));
> > > > +    g_free(cmd);
> > > > +    qobject_unref(rsp);
> > > > +}
> > > > +
> > > >  static void wait_for_migration_complete(QTestState *who)
> > > >  {
> > > >      while (true) {
> > > > @@ -619,6 +631,50 @@ static void test_precopy_unix(void)
> > > >      g_free(uri);
> > > >  }
> > > >  
> > > > +static void test_multifd_fd(void)
> > > > +{
> > > > +    int fd[2];
> > > > +
> > > > +    /* create pipe */
> > > > +    if (pipe(fd) == -1)
> > > > +        g_test_message("Skipping test: Unable to create pipe");
> > > > +        return;
> > > > +
> > > > +    /* set uri in target with read fd */
> > > > +    char *uri = g_strdup_printf("fd:%d", fd[0]);
> > > > +    QTestState *from, *to;
> > > > +    test_migrate_start(&from, &to, uri, false);
> > > > +
> > > > +    /* Receive a write file descriptor for source using getfd */
> > > > +    getfd(from, "srcfd", fd[1]);
> > > > +
> > > > +    /* set multifd capability on source and target */
> > > > +    migrate_set_capability(from, "x-multifd", "true");
> > > > +    migrate_set_capability(to, "x-multifd", "true");
> > > > +
> > > > +    /* Wait for the first serial output from the source */
> > > > +    wait_for_serial("src_serial");
> > > > +
> > > > +    /* perform migration */
> > > > +    migrate(from, uri);
> > > 
> > > I'm not sure I understand correctly here, but I feel like we should
> > > use the fd[1] or anything that was bound to fd[1] on source side to do
> > > the migration rather than fd[0]?  Please feel free to correct me..
> > > 
> > 
> > fd[0] - read channel so we should use it for target (-incoming fd:fd[0])
> > fd[1] - write channel so we shouls use it for source to transfer/write
> > and for it we need to assign using `getfd` monitor command on source.
> 
> Yeah again the logic should be fine, though we might need to implement
> the SCM_RIGHTS magic here, like what we did in, e.g.,
> qio_channel_socket_writev() in QEMU.

:+1: sure, I will work on it, Thank you Peter for your time and help.

-- Bala
> 
> Regards,
> 
> -- 
> Peter Xu
> 
