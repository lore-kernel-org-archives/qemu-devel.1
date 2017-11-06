Received: from eggs.gnu.org ([2001:4830:134:3::10]:44716)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eBepx-0002K5-Ua
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 05:41:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eBepu-0006Uh-T7
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 05:41:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41778)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eBepu-0006Sx-ND
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 05:40:58 -0500
Date: Mon, 6 Nov 2017 10:40:53 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171106104053.GD23361@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20171016201650.18399-1-berrange@redhat.com>
	<20171016201650.18399-4-berrange@redhat.com>
	<CAFEAcA-0as0ACWy-KHv9+DoS+6aaiHShR4xAMj9bXAMQGr3_Lw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA-0as0ACWy-KHv9+DoS+6aaiHShR4xAMj9bXAMQGr3_Lw@mail.gmail.com>
Subject: Re: [Qemu-devel] [PULL v1 03/11] sockets: Handle race condition
 between binds to the same port
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Knut Omang <knut.omang@oracle.com>

On Fri, Nov 03, 2017 at 06:54:44PM +0000, Peter Maydell wrote:
> On 16 October 2017 at 21:16, Daniel P. Berrange <berrange@redhat.com> wrote:
> > From: Knut Omang <knut.omang@oracle.com>
> >
> > If an offset of ports is specified to the inet_listen_saddr function(),
> > and two or more processes tries to bind from these ports at the same time,
> > occasionally more than one process may be able to bind to the same
> > port. The condition is detected by listen() but too late to avoid a failure.
> >
> > This function is called by socket_listen() and used
> > by all socket listening code in QEMU, so all cases where any form of dynamic
> > port selection is used should be subject to this issue.
> >
> > Add code to close and re-establish the socket when this
> > condition is observed, hiding the race condition from the user.
> >
> > Also clean up some issues with error handling to allow more
> > accurate reporting of the cause of an error.
> >
> > This has been developed and tested by means of the
> > test-listen unit test in the previous commit.
> > Enable the test for make check now that it passes.
> >
> > Reviewed-by: Bhavesh Davda <bhavesh.davda@oracle.com>
> > Reviewed-by: Yuval Shaia <yuval.shaia@oracle.com>
> > Reviewed-by: Girish Moodalbail <girish.moodalbail@oracle.com>
> > Signed-off-by: Knut Omang <knut.omang@oracle.com>
> > Reviewed-by: Daniel P. Berrange <berrange@redhat.com>
> > Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> 
> Hi. Coverity points out that this code could leak a socket fd
> (CID 1381805):

Yeah, I have a patch posted a week or two back to fix this. I'll get a pull
request in before release to fix it, along with test suite

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
