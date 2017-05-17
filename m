Received: from eggs.gnu.org ([2001:4830:134:3::10]:36795)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dAxxj-0005s9-3L
	for qemu-devel@nongnu.org; Wed, 17 May 2017 08:21:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dAxxi-0002sx-Ay
	for qemu-devel@nongnu.org; Wed, 17 May 2017 08:21:55 -0400
Date: Wed, 17 May 2017 20:21:23 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170517122123.GD17629@lemon.lan>
References: <20170505102153.758-1-famz@redhat.com>
	<20170505104128.GC12773@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170505104128.GC12773@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] iotests: 147: Don't test inet6 if not
 available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On Fri, 05/05 11:41, Daniel P. Berrange wrote:
> On Fri, May 05, 2017 at 06:21:53PM +0800, Fam Zheng wrote:
> > This is the case in our docker tests, as we use --net=none there. Skip
> > this method.
> > 
> > Signed-off-by: Fam Zheng <famz@redhat.com>
> > ---
> >  tests/qemu-iotests/147 | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/tests/qemu-iotests/147 b/tests/qemu-iotests/147
> > index 32afea6..db34838 100755
> > --- a/tests/qemu-iotests/147
> > +++ b/tests/qemu-iotests/147
> > @@ -147,6 +147,13 @@ class BuiltinNBD(NBDBlockdevAddBase):
> >          self._server_down()
> >  
> >      def test_inet6(self):
> > +        try:
> > +            socket.getaddrinfo("::0", "0", socket.AF_INET6,
> > +                               socket.SOCK_STREAM, socket.IPPROTO_TCP,
> > +                               socket.AI_ADDRCONFIG | socket.AI_CANONNAME)
> > +        except socket.gaierror:
> > +            # IPv6 not available, skip
> > +            return
> 
> FWIW, in test-io-channel-socket.c we call getaddrinfo() and also check
> bind() succeeds (use port==0 to let it select a free port to test bind
> on), before assuming IPv6 is working.

Well it then sounds like we should check bind(port=NBD_PORT). But if we do that,
it looks like a slightly bigger topic, for example a previous run not cleanup?

Let's leave it for now.

Fam
