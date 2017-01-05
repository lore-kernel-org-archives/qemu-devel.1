Received: from eggs.gnu.org ([2001:4830:134:3::10]:50288)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cPB7G-0006JR-Ui
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 11:42:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cPB7D-0006H7-5v
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 11:42:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43074)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cPB7D-0006GS-05
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 11:42:11 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DB72F3DFCC
	for <qemu-devel@nongnu.org>; Thu,  5 Jan 2017 16:42:10 +0000 (UTC)
Date: Thu, 5 Jan 2017 16:42:05 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170105164205.GS3292@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170105160321.21786-1-berrange@redhat.com>
	<20170105160321.21786-2-berrange@redhat.com>
	<3ff1cf4e-67c3-b182-1c3c-2e6dce546e85@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3ff1cf4e-67c3-b182-1c3c-2e6dce546e85@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/8] sockets: add ability to disable DNS
 resolution for InetSocketAddress
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

On Thu, Jan 05, 2017 at 10:22:43AM -0600, Eric Blake wrote:
> On 01/05/2017 10:03 AM, Daniel P. Berrange wrote:
> > Add a 'numeric' flag to the InetSocketAddress struct to allow the
> > caller to indicate that DNS should be skipped for the host/port
> > fields. This is useful if the caller knows the address is already
> > numeric and wants to guarantee no (potentially blocking) DNS
> > lookups are attempted.
> > 
> > Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> > ---
> >  qapi-schema.json    | 5 +++++
> >  util/qemu-sockets.c | 3 +++
> >  2 files changed, 8 insertions(+)
> > 
> > diff --git a/qapi-schema.json b/qapi-schema.json
> > index a0d3b5d..d605c1e 100644
> > --- a/qapi-schema.json
> > +++ b/qapi-schema.json
> > @@ -3070,6 +3070,10 @@
> >  #
> >  # @port: port part of the address, or lowest port if @to is present
> >  #
> > +# @numeric: #optional true if the host/port are guaranteed to be numeric,
> > +#           false if name resolution should be attempted. Defaults to false.
> > +#           Since 2.8
> 
> 2.9, actually.  I'm also not sure if Marc-Andre's work requires ()
> brackets around the since designation on a per-member listing.
> 
> > @@ -3084,6 +3088,7 @@
> >    'data': {
> >      'host': 'str',
> >      'port': 'str',
> > +    'numeric':  'bool',
> 
> In order to be optional, it must be spelled '*numeric'.

Sigh, yes.

> >      '*to': 'uint16',
> >      '*ipv4': 'bool',
> >      '*ipv6': 'bool' } }
> 
> Thinking out loud: Do we even need a 'numeric' field?  If we could
> create an alternate type that distinguishes between a 'str' (name, DNS
> resolution required) and an 'int' (numeric, skip DNS), then we don't
> need a field.  Except that an 'int' for IPv4 addresses is awkward, and
> an 'int' for IPv6 addresses in insufficient - so even when the address
> is numeric, you STILL have to pass it in as 'str'.  Okay, experiment
> failed, your interface seems like the correct thing to do.

Basically think of this 'numeric' flag as being the same as
the AI_NUMERIC flag to getaddrinfo. You're still using the
string format as input so that you can reuse existing code
for converting from user friendly string format to raw
byte format.


Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
