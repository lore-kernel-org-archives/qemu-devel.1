Received: from eggs.gnu.org ([2001:4830:134:3::10]:43014)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1evlkN-0005aX-C1
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 11:21:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1evlkI-0007XN-9n
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 11:21:51 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50152 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1evlkI-0007Wl-4Y
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 11:21:46 -0400
Date: Tue, 13 Mar 2018 23:21:33 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180313152133.GJ11787@xz-mi>
References: <20180312183628.394722-1-eblake@redhat.com>
	<CAFEAcA9HLfz77eEHho+Vod=XSsvoNv10noFJjqoAd0=CXT-8dQ@mail.gmail.com>
	<ad8cb727-8e0d-d2ba-659e-9b91f59c30cd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ad8cb727-8e0d-d2ba-659e-9b91f59c30cd@redhat.com>
Subject: Re: [Qemu-devel] [PULL 00/36] QAPI patches for 2018-03-12,
 2.12 softfreeze
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>

On Tue, Mar 13, 2018 at 09:17:36AM -0500, Eric Blake wrote:
> On 03/13/2018 09:02 AM, Peter Maydell wrote:
> > On 12 March 2018 at 18:35, Eric Blake <eblake@redhat.com> wrote:
> > > The following changes since commit 6ceb1b51f05f9e1892d082960ed602dca7b6696e:
> > > 
> > >    Merge remote-tracking branch 'remotes/kraxel/tags/audio-20180312-pull-request' into staging (2018-03-12 16:14:37 +0000)
> > > 
> > > are available in the Git repository at:
> > > 
> > >    git://repo.or.cz/qemu/ericb.git tags/pull-qapi-2018-03-12
> > > 
> > > for you to fetch changes up to a083c533b5a17c77ef164acdbf30eedfa9681fc6:
> > > 
> > >    qapi: add block latency histogram interface (2018-03-12 13:22:11 -0500)
> > > 
> > > This builds and passes 'make check', so even though the OOB portion
> > > depends on chardev fixes that are still pending a pull request from
> > > Paolo, that dependence can only be observed at runtime by clients
> > > that use the new oob feature.  Given the timing of soft freeze, and
> > > the fact that the chardev fixes do not form a build dependency, I
> > > think it's okay if this pull request gets processed before Paolo's
> > > (but it's also okay if Paolo's goes in first).
> 
> Based on the testsuite failures, it looks like Paolo's pull request with
> chardev fixes DOES have to go in first. More at [1] below.

[...]

> > 
> > on PPC64 Linux, FreeBSD x86, OpenBSD x86, aarch64 Linux hosts, test fails;
> > looks like the same assert but in different tests:
> > 
> > ppc64:
> > TEST: tests/qmp-test... (pid=48041)
> >    /alpha/qmp/protocol:                                                 OK
> >    /alpha/qmp/oob:                                                      OK
> >    /alpha/qmp/query-status:                                             OK
> >    /alpha/qmp/query-block:
> > qemu-system-alpha: /home/pm215/qemu/
> > chardev/char-io.c:91: io_watch_poll_finalize: Assertion `iwp->src ==
> > ((void *)0)' failed.
> > Broken pipe
> > FAIL
> > GTester: last random seed: R02S3e793887202ca8b099adb20531a072e6
> > (pid=48057)
> > 
> 
> [1] this is probably the chardev fixes being tickled by oob.  (Weird that
> the change is not failing the oob test, though - or is the failure happening
> during cleanup of the oob test, AFTER it reported OK?)  Here's where I'm
> hoping Paolo's pull request with chardev fixes is the solution, otherwise, I
> may have to disable Peter's OOB patches.

Yes it is.  The failure can possibly happen randomly on very random
tests if without the whole bunch of chardev patches.

I confirmed with Paolo offlist that all the chardev fixes will be in
Paolo's next chardev pull request for the softfreeze.  So with Paolo's
next pull request, all the tests should pass, with 100%. If it still
fails any, then please feel free to drop the whole OOB series so that
I'll rework after 2.12.

Sorry again for the troublesome.

-- 
Peter Xu
