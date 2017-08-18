Received: from eggs.gnu.org ([2001:4830:134:3::10]:37848)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dic7V-00077P-PU
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 03:55:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dic7Q-000746-G9
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 03:55:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38424)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dic7Q-00073d-7G
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 03:55:00 -0400
Date: Fri, 18 Aug 2017 09:54:48 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170818095448.226fc4e9.cohuck@redhat.com>
In-Reply-To: <98d06e4e-b0e9-9a44-195a-3aab6f3cf219@redhat.com>
References: <1502951113-4246-1-git-send-email-thuth@redhat.com>
	<1502951113-4246-3-git-send-email-thuth@redhat.com>
	<20170817104122.4d72674b.cohuck@redhat.com>
	<98d06e4e-b0e9-9a44-195a-3aab6f3cf219@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/6] tests: Add network filter tests to the
 check-qtest-s390x list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, David Hildenbrand <david@redhat.com>, Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Eric Farman <farman@linux.vnet.ibm.com>, Zhang Chen <zhangchen.fnst@cn.fujitsu.com>, Farhan Ali <alifm@linux.vnet.ibm.com>, Fei Li <sherrylf@linux.vnet.ibm.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>, Jason J Herne <jjherne@linux.vnet.ibm.com>, Jing Liu <liujbjl@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, QingFeng Hao <haoqf@linux.vnet.ibm.com>, Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>, Yang Chen <bjcyang@linux.vnet.ibm.com>, Yi Min Zhao <zyimin@linux.vnet.ibm.com>, Yang Hongyang <yanghy@cn.fujitsu.com>, Cleber Rosa <crosa@redhat.com>, Michael S Tsirkin <mst@redhat.com>

On Thu, 17 Aug 2017 16:02:00 +0200
Thomas Huth <thuth@redhat.com> wrote:

> On 17.08.2017 10:41, Cornelia Huck wrote:
> > On Thu, 17 Aug 2017 08:25:09 +0200
> > Thomas Huth <thuth@redhat.com> wrote:
> >   
> >> With some small modifications, we can also use the the netfilter,
> >> the fiter-mirror and the filter-redirector tests on s390x.  
> > 
> > s/fiter/filter/  
> 
> OK ... could you please fix that when picking up the patch (in case I do
> not have to resend)?

Sure.

> 
> >>
> >> Signed-off-by: Thomas Huth <thuth@redhat.com>
> >> ---
> >>  tests/Makefile.include         |  3 +++
> >>  tests/test-filter-mirror.c     |  9 +++++++--
> >>  tests/test-filter-redirector.c | 22 ++++++++++++++++------
> >>  tests/test-netfilter.c         | 11 ++++++++++-
> >>  4 files changed, 36 insertions(+), 9 deletions(-)
> >>  
> >   
> >> diff --git a/tests/test-filter-mirror.c b/tests/test-filter-mirror.c
> >> index a1d5865..d569d27 100644
> >> --- a/tests/test-filter-mirror.c
> >> +++ b/tests/test-filter-mirror.c
> >> @@ -25,6 +25,11 @@ static void test_mirror(void)
> >>      char *recv_buf;
> >>      uint32_t size = sizeof(send_buf);
> >>      size = htonl(size);
> >> +    const char *devstr = "e1000";
> >> +
> >> +    if (g_str_equal(qtest_get_arch(), "s390x")) {
> >> +        devstr = "virtio-net-ccw";
> >> +    }  
> > 
> > I'm wondering if we could unify selection of the network device
> > somehow. There's probably two cases:
> > - Test a specific device. This obviously needs to be decided
> >   individually.
> > - Just use a functional network device. For s390x, this will be
> >   virtio-net-ccw; for other architectures, this test uses e1000, while
> >   one of the tests below uses rtl8139 (why?). A helper for that may be
> >   useful.  
> 
> Maybe ... OTOH, this likely increases also test coverage if we do not
> use the same PCI NIC in all the tests...?

It just looks like a bit of unneeded churn to me.

Re coverage: Do we have a very simple test that we can run for all kind
of NICs? This would give some reliable testing for various devices
instead of having to rely on people picking different devices for their
tests...
