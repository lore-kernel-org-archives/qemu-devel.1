Received: from eggs.gnu.org ([209.51.188.92]:56610)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1goQuF-0008EU-83
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 05:46:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1goQu8-0003TR-K7
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 05:46:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:25705)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1goQu6-0003RA-MJ
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 05:46:06 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0F8F82D7EF
	for <qemu-devel@nongnu.org>; Tue, 29 Jan 2019 10:46:05 +0000 (UTC)
Date: Tue, 29 Jan 2019 10:45:57 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190129104557.GB2650@work-vm>
References: <20190128170321.16936-1-dgilbert@redhat.com>
	<20190128170321.16936-10-dgilbert@redhat.com>
	<20190128120446-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190128120446-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] [PATCH 9/9] tests: Add a test for qemu self
 announcments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, quintela@redhat.com, jasowang@redhat.com, eblake@redhat.com, armbru@redhat.com, berrange@redhat.com

* Michael S. Tsirkin (mst@redhat.com) wrote:
> On Mon, Jan 28, 2019 at 05:03:21PM +0000, Dr. David Alan Gilbert (git) wrote:
> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> > 
> > We now expose qemu_announce_self through QMP and HMP.  Add a test
> > with some very basic packet validation (make sure we get a RARP).
> > 
> > Signed-off-by: Vlad Yasevich <vyasevic@redhat.com>
> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> 
> typo in subject

Thanks, fixed.

Dave

> > ---
> >  tests/Makefile.include     |  2 +
> >  tests/test-announce-self.c | 83 ++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 85 insertions(+)
> >  create mode 100644 tests/test-announce-self.c
> > 
> > diff --git a/tests/Makefile.include b/tests/Makefile.include
> > index 19b4c0a696..57ce722d73 100644
> > --- a/tests/Makefile.include
> > +++ b/tests/Makefile.include
> > @@ -143,6 +143,8 @@ check-qtest-generic-y += tests/qmp-cmd-test$(EXESUF)
> >  
> >  check-qtest-generic-y += tests/device-introspect-test$(EXESUF)
> >  check-qtest-generic-y += tests/cdrom-test$(EXESUF)
> > +check-qtest-generic-y += tests/test-announce-self$(EXESUF)
> > +gcov-files-generic-y = migration/savevm.c
> >  
> >  check-qtest-ipack-y += tests/ipoctal232-test$(EXESUF)
> >  
> > diff --git a/tests/test-announce-self.c b/tests/test-announce-self.c
> > new file mode 100644
> > index 0000000000..2ff0c77255
> > --- /dev/null
> > +++ b/tests/test-announce-self.c
> > @@ -0,0 +1,83 @@
> > +/*
> > + * QTest testcase for qemu_announce_self
> > + *
> > + * Copyright (c) 2017 Red hat, Inc.
> > + * Copyright (c) 2014 SUSE LINUX Products GmbH
> > + *
> > + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> > + * See the COPYING file in the top-level directory.
> > + */
> > +
> > +#include "qemu/osdep.h"
> > +#include "libqtest.h"
> > +#include "qapi/qmp/qdict.h"
> > +#include "qemu-common.h"
> > +#include "qemu/sockets.h"
> > +#include "qemu/iov.h"
> > +#include "libqos/libqos-pc.h"
> > +#include "libqos/libqos-spapr.h"
> > +
> > +#ifndef ETH_P_RARP
> > +#define ETH_P_RARP 0x8035
> > +#endif
> > +
> > +static QTestState *test_init(int socket)
> > +{
> > +    char *args;
> > +
> > +    args = g_strdup_printf("-netdev socket,fd=%d,id=hs0 -device "
> > +                           "virtio-net-pci,netdev=hs0", socket);
> > +
> > +    return qtest_start(args);
> > +}
> > +
> > +
> > +static void test_announce(int socket)
> > +{
> > +    char buffer[60];
> > +    int len;
> > +    QDict *rsp;
> > +    int ret;
> > +    uint16_t *proto = (uint16_t *)&buffer[12];
> > +
> > +    rsp = qmp("{ 'execute' : 'announce-self', "
> > +                  " 'arguments': {"
> > +                      " 'params': {"
> > +                          " 'initial': 50, 'max': 550,"
> > +                          " 'rounds': 10, 'step': 50 } } }");
> > +    assert(!qdict_haskey(rsp, "error"));
> > +    qobject_unref(rsp);
> > +
> > +    /* Catch the packet and make sure it's a RARP */
> > +    ret = qemu_recv(socket, &len, sizeof(len), 0);
> > +    g_assert_cmpint(ret, ==,  sizeof(len));
> > +    len = ntohl(len);
> > +
> > +    ret = qemu_recv(socket, buffer, len, 0);
> > +    g_assert_cmpint(*proto, ==, htons(ETH_P_RARP));
> > +}
> > +
> > +static void setup(gconstpointer data)
> > +{
> > +    QTestState *qs;
> > +    void (*func) (int socket) = data;
> > +    int sv[2], ret;
> > +
> > +    ret = socketpair(PF_UNIX, SOCK_STREAM, 0, sv);
> > +    g_assert_cmpint(ret, !=, -1);
> > +
> > +    qs = test_init(sv[1]);
> > +    func(sv[0]);
> > +
> > +    /* End test */
> > +    close(sv[0]);
> > +    qtest_quit(qs);
> > +}
> > +
> > +int main(int argc, char **argv)
> > +{
> > +    g_test_init(&argc, &argv, NULL);
> > +    qtest_add_data_func("/virtio/net/test_announce_self", test_announce, setup);
> > +
> > +    return g_test_run();
> > +}
> > -- 
> > 2.20.1
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
