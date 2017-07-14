Received: from eggs.gnu.org ([2001:4830:134:3::10]:55480)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dW1qe-0001vB-QC
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 10:45:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dW1qZ-0007Mg-Pc
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 10:45:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:10500)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dW1qZ-0007MB-GI
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 10:45:35 -0400
Date: Fri, 14 Jul 2017 17:45:27 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170714173714-mutt-send-email-mst@kernel.org>
References: <1499964378-24344-1-git-send-email-mst@redhat.com>
	<c491c6ee-67ed-e7a0-4294-b128f63d6841@redhat.com>
	<415ee774-cab4-f48a-c081-c2158de35b50@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <415ee774-cab4-f48a-c081-c2158de35b50@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] tests: switch pxe and vm gen id tests to
 use kvm
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Ben Warren <ben@skyportsystems.com>, Peter Maydell <peter.maydell@linaro.org>

On Fri, Jul 14, 2017 at 07:59:54AM +0200, Thomas Huth wrote:
> On 13.07.2017 19:00, Paolo Bonzini wrote:
> > On 13/07/2017 18:47, Michael S. Tsirkin wrote:
> >> Speed up tests on host systems with kvm support.
> >>
> >> Cc: Paolo Bonzini <pbonzini@redhat.com>
> >> Cc: Thomas Huth <thuth@redhat.com>
> >> Cc: Laurent Vivier <lvivier@redhat.com>
> >> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> >> ---
> >>
> >> This is on top of my previous patch fixing vmgenid.
> >>
> >> PPC PXE test is reported to be especially slow - does anyone care to try
> >> it and measure whether this helps?
> >>
> >>  tests/pxe-test.c     | 2 +-
> >>  tests/vmgenid-test.c | 2 +-
> >>  2 files changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/tests/pxe-test.c b/tests/pxe-test.c
> >> index 34282d3..cf6e225 100644
> >> --- a/tests/pxe-test.c
> >> +++ b/tests/pxe-test.c
> >> @@ -25,7 +25,7 @@ static void test_pxe_one(const char *params, bool ipv6)
> >>  {
> >>      char *args;
> >>  
> >> -    args = g_strdup_printf("-machine accel=tcg -nodefaults -boot order=n "
> >> +    args = g_strdup_printf("-machine accel=kvm:tcg -nodefaults -boot order=n "
> >>                             "-netdev user,id=" NETNAME ",tftp=./,bootfile=%s,"
> >>                             "ipv4=%s,ipv6=%s %s", disk, ipv6 ? "off" : "on",
> >>                             ipv6 ? "on" : "off", params);
> >> diff --git a/tests/vmgenid-test.c b/tests/vmgenid-test.c
> >> index 0556ba2..6477dcc 100644
> >> --- a/tests/vmgenid-test.c
> >> +++ b/tests/vmgenid-test.c
> >> @@ -132,7 +132,7 @@ static char disk[] = "tests/vmgenid-test-disk-XXXXXX";
> >>  
> >>  static char *guid_cmd_strdup(const char *guid)
> >>  {
> >> -    return g_strdup_printf("-machine accel=tcg "
> >> +    return g_strdup_printf("-machine accel=kvm:tcg "
> >>                             "-device vmgenid,id=testvgid,guid=%s "
> >>                             "-drive id=hd0,if=none,file=%s,format=raw "
> >>                             "-device ide-hd,drive=hd0 ",
> > 
> > Acked-by: Paolo Bonzini <pbonzini@redhat.com>
> 
> NACK.

As a rule, don't send nacks please. Skip directly to the technical
argument. Nacks add very little to the discussion and tend to scare away
contributors. All upper case also looks like shouting. That's unlike
acks which include reviewer's name and can be recorded in git history so
people know whom to ask questions about a commit.

> It's not that simple. If you do it like this, you then suddenly get
> these ugly '"kvm" accelerator not found' messages during "make check"
> which we really should avoid.
> 
> Laurent suggested some better ideas a couple of months ago, but I think
> the common sense was rather "unit tests should always use TCG" at that
> point in time:
> 
>  https://lists.gnu.org/archive/html/qemu-devel/2016-10/msg00400.html

Looks good. This was never posted as a patch. Would you or him care
to test it and re-post? I'll include it with my patch.

> Well, now that we've got the "--disable-tcg" configure option, we should
> maybe start to reconsider that ;-)
> 
> So I'm fine with the patch if you also include Laurent's patch to shut
> up the error message:
> 
>  https://lists.gnu.org/archive/html/qemu-devel/2016-10/msg00395.html
> 
>  Thomas
