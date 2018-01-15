Received: from eggs.gnu.org ([2001:4830:134:3::10]:57252)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eb5BH-0003qf-6C
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 08:52:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eb5BF-0005S5-Rj
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 08:52:07 -0500
Date: Mon, 15 Jan 2018 13:51:46 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20180115135146.GJ8218@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20180111195225.4226-1-kwolf@redhat.com>
	<20180111195225.4226-3-kwolf@redhat.com>
	<20180112105320.GB17392@redhat.com>
	<20180115133848.GD32271@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180115133848.GD32271@localhost.localdomain>
Subject: Re: [Qemu-devel] [RFC PATCH 02/10] block/qapi: Add qcow2 create
 options to schema
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, pkrempa@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com

On Mon, Jan 15, 2018 at 02:38:48PM +0100, Kevin Wolf wrote:
> Am 12.01.2018 um 11:53 hat Daniel P. Berrange geschrieben:
> > On Thu, Jan 11, 2018 at 08:52:17PM +0100, Kevin Wolf wrote:
> > > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > > ---
> > >  qapi/block-core.json | 33 ++++++++++++++++++++++++++++++++-
> > >  1 file changed, 32 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/qapi/block-core.json b/qapi/block-core.json
> > > index 1749376c61..9341f6708d 100644
> > > --- a/qapi/block-core.json
> > > +++ b/qapi/block-core.json
> > > @@ -3320,6 +3320,37 @@
> > >  { 'command': 'blockdev-del', 'data': { 'node-name': 'str' } }
> > >  
> > >  ##
> > > +# @BlockdevQcow2CompatLevel:
> > > +# @0_10:    The original QCOW2 format as introduced in qemu 0.10 (version 2)
> > > +# @1_1:     The extended QCOW2 format as introduced in qemu 1.1 (version 3)
> > > +#
> > > +# Since: 2.10
> > > +##
> > > +{ 'enum': 'BlockdevQcow2CompatLevel',
> > > +  'data': [ '0_10', '1_1' ] }
> > > +
> > > +
> > > +##
> > > +# @BlockdevCreateOptionsQcow2:
> > > +#
> > > +# Driver specific image creation options for qcow2.
> > > +#
> > > +# TODO Describe fields
> > > +#
> > > +# Since: 2.12
> > > +##
> > > +{ 'struct': 'BlockdevCreateOptionsQcow2',
> > > +  'data': { 'size':             'size',
> > > +            '*compat':          'BlockdevQcow2CompatLevel',
> > > +            '*backing-file':    'str',
> > > +            '*backing-fmt':     'BlockdevDriver',
> > 
> > For anything non-trivial, the caller is going to have to stuff a
> > JSON string into 'backing-file' value. It feels like we should
> > be referencing 'BlockdevOptions' here in some manner.
> 
> Hm, that's an interesting question. For the image creation, this is
> really treated as a string that is directly written into the image file,
> without being parsed, so 'str' is the more correct type in this context.
> However, when the backing file gets loaded, that string is in fact
> parsed and we expect it to describe the same thing as BlockdevOptions.
> 
> If we get BlockdevOptions here, qemu would have to convert them into a
> json:{...} string before writing the header of the new image.
> Compatibility code would become a bit more complex because we'd have to
> convert the existing string into BlockdevOptions, only to convert it
> back to a string before we write it to the image file. And finally, the
> 1023 character limit of qcow2 becomes kind of unpredicatble when you
> don't pass the string yourself.
> 
> So considering all of that, I still think that 'str' is the better
> option here.

Hmm, when we write the backing chain into the qcow2 header, we only want to
write the 1st level of the backing chain.

When we are creating the new qcow2 image, we could be pointing to a backing
chain that goes many levels deep. So the actual creation process potentially
needs to be given the full arbitrarily deep backing file eg in order that
we can set 'encrypt.secret' for any encrypted images at at arbitrary level.

IOW, I think we need to be able to pass BlockdevOptions here to specify the
full deep chain, but then only the 1st level of these BlockdevOptions should
get written into the qcow2 file header.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
