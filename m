Received: from eggs.gnu.org ([2001:4830:134:3::10]:46675)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e2D9U-0002KE-Tv
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 05:18:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e2D9R-0001W4-PI
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 05:18:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39262)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1e2D9R-0001VR-JU
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 05:18:05 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 82D273E2A3
	for <qemu-devel@nongnu.org>; Wed, 11 Oct 2017 09:18:03 +0000 (UTC)
Date: Wed, 11 Oct 2017 10:18:00 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171011091800.GD20372@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20171010154328.8419-1-berrange@redhat.com>
	<20171010154328.8419-7-berrange@redhat.com>
	<5c734ef0-5cb3-30eb-1b9a-1f2238deaa96@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5c734ef0-5cb3-30eb-1b9a-1f2238deaa96@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v1 6/7] io: cope with websock 'Connection'
 header having multiple values
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org

On Tue, Oct 10, 2017 at 12:42:55PM -0500, Eric Blake wrote:
> On 10/10/2017 10:43 AM, Daniel P. Berrange wrote:
> > The noVNC server sends a header "Connection: keep-alive, Upgrade" which
> > fails our simple equality test. Split the header on ',', trim whitespace
> > and then check for 'upgrade' token.
> > 
> > Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> > ---
> >  io/channel-websock.c | 14 +++++++++++++-
> >  1 file changed, 13 insertions(+), 1 deletion(-)
> > 
> 
> > @@ -440,7 +443,16 @@ static void qio_channel_websock_handshake_process(QIOChannelWebsock *ioc,
> >          goto bad_request;
> >      }
> >  
> > -    if (strcasecmp(connection, QIO_CHANNEL_WEBSOCK_CONNECTION_UPGRADE) != 0) {
> 
> My first thought was whether you could just use strcasestr() instead of
> strcasecmp(), rather than the malloc overhead of g_strsplit().  But that
> would treat "noUpgradeGarbage" as success, making your approach a bit
> stricter.

Also note that when reading HTTP headers we've already limited max data
size to 4k for the entire HTTP header set. So we're doing g_strsplit
over a pretty short piece of data, so negligible perf implications
of that.

> 
> Reviewed-by: Eric Blake <eblake@redhat.com>

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
