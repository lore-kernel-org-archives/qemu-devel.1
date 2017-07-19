Received: from eggs.gnu.org ([2001:4830:134:3::10]:49420)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jfreimann@redhat.com>) id 1dXrMZ-0000ij-By
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 11:58:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jfreimann@redhat.com>) id 1dXrMW-00008x-BG
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 11:58:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60560)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jfreimann@redhat.com>)
	id 1dXrMW-00007x-43
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 11:58:08 -0400
Date: Wed, 19 Jul 2017 17:51:27 +0200
From: Jens Freimann <jfreimann@redhat.com>
Message-ID: <20170719155127.dqdm2wghdnbsmwie@dhcp-192-218.str.redhat.com>
References: <20170712094149.23069-1-jfreimann@redhat.com>
	<20170712180550-mutt-send-email-mst@kernel.org>
	<20170712211305.ajtizorj4yq6jble@localhost.localdomain>
	<20170713012811-mutt-send-email-mst@kernel.org>
	<20170719084402.GA5628@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20170719084402.GA5628@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [PATCH RFC 0/3] tests/pxe-testt: add testcase
 using vhost-user-bridge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, marcandre.lureau@redhat.com, maxime.coquelin@redhat.com, victork@redhat.com, qemu-devel@nongnu.org

On Wed, Jul 19, 2017 at 09:44:02AM +0100, Stefan Hajnoczi wrote:
>On Thu, Jul 13, 2017 at 01:33:43AM +0300, Michael S. Tsirkin wrote:
>> On Wed, Jul 12, 2017 at 11:13:05PM +0200, Jens Freimann wrote:
>> > On Wed, Jul 12, 2017 at 06:10:05PM +0300, Michael S. Tsirkin wrote:
>> > > On Wed, Jul 12, 2017 at 11:41:46AM +0200, Jens Freimann wrote:
>> > > > This implements a testcase for pxe-test using the vhost-user interface. Spawn a
>> > > > vhost-user-bridge process and connect it to the qemu process.
>> > > >
>> > > > It is send as an RFC because:
>> > > >  - Patch 3/3: there must be cleaner way to do this.
>> > > >  - Does Patch 1/3 make sense or should I just redirect all output to /dev/null?
>> > > >  - don't hardcode port numbers in qemu cmdline, create socket and pass
>> > > >     fd to -netdev (need to figure out how to do this)
>> > >
>> > > Doesn't this work?
>> > >
>> > > -netdev socket,id=str[,fd=h]
>> >
>> > It should. But I get this:
>> >
>> >        dded sock 5 for watching. max_sock: 5
>> >        Sock 3 removed from dispatcher watch.
>> >        qemu: error: specified mcastaddr "127.0.0.1" (0x7f000001) does not contain a multicast address
>> >        qemu-system-x86_64: -netdev socket,id=n1,fd=3: Device 'socket' could not be initialized
>> >        Broken pipe
>>
>> Not sure what's wrong with it, should not be too hard to debug.
>
>Jens asked me this question on IRC.  I didn't know the answer either but
>git-log(1) shows what happened:
>
>-net socket,fd= was broken for SOCK_DGRAM from the moment mcast was
>introduced by commit 3d830459b1eccdb61b75e2712fd364012ce5a115 ("'-net
>socket,mcast=' option support (initial patch by Juan Jose Ciarlante)").
>
>The issue is probably that the fd init code doesn't know whether the
>user wanted mcast or not.  Right now it's hardcoded to assume that mcast
>is desired.  It may be necessary to extend the command-line syntax to
>specify mcast explicitly with fd=.

Thanks for confirming this Stefan! I'll try to come up with an extension to the
command-line syntax and send a proposal to the list.

regards,
Jens
