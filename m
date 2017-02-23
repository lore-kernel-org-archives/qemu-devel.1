Received: from eggs.gnu.org ([2001:4830:134:3::10]:43447)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cgqmR-0001Mg-NT
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 05:37:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cgqmQ-0001Ib-KK
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 05:37:47 -0500
Date: Thu, 23 Feb 2017 10:37:35 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170223103735.GI10047@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170221115512.21918-1-berrange@redhat.com>
	<20170221115512.21918-3-berrange@redhat.com>
	<20170222151833.GM4112@noname.str.redhat.com>
	<20170222154925.GT28937@redhat.com>
	<21ccca53-659f-aa79-3b81-6a8cf1e66ba3@redhat.com>
	<20170223102839.GB6931@noname.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170223102839.GB6931@noname.redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 02/18] block: add ability to set a
 prefix for opt names
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Alberto Garcia <berto@igalia.com>

On Thu, Feb 23, 2017 at 11:28:39AM +0100, Kevin Wolf wrote:
> Am 22.02.2017 um 19:28 hat Eric Blake geschrieben:
> > Using '.' would mean a layer of {} nesting on the wire, maybe as in:
> > 
> > { "driver": "qcow2", ..., "luks" : { "hash-alg": ... } }
> > 
> > but conceptually, I like that a bit better, as it consolidates all the
> > luks-related options in one place, and may indeed make it possible to
> > reuse the type rather than having two variants (one prefixed, one not,
> > depending on whether it is standalone or qcow2).
> 
> Right, and this extra nesting to keep everything luks related in one
> place is exactly what I wanted to achieve with it.
> 
> > I'm also looking later in your series (13/18), where you have:
> > 
> > 
> > @@ -2344,7 +2348,8 @@
> >              '*l2-cache-size': 'int',
> >              '*refcount-cache-size': 'int',
> >              '*cache-clean-interval': 'int',
> > -            '*aes-key-secret': 'str' } }
> > +            '*aes-key-secret': 'str',
> > +            '*luks-key-secret': 'str' } }
> > 
> > 
> > Uggh - we have two optional parameters, that must not both be present at
> > once.  I'm wondering if we can instead do this (hmm, my patches for
> > anonymous base/branches in a flat union haven't been taken yet, but you
> > get the idea):
> > 
> > ...
> > '*cache-clean-interval': 'int',
> > '*encryption': 'Qcow2Encryption' } }
> > 
> > { 'enum': 'Qcow2EncryptionType': [ 'aes', 'luks' ] }
> > { 'union': 'Qcow2Encryption', 'base': { 'type': 'Qcow2EncryptionType' },
> >   'discriminator': 'type', 'data': {
> >     'aes': { 'key-secret': 'str' },
> >     'luks': { 'key-secret': 'str', '*hash-alg': ..., '*slot': 'int' } } }
> > 
> > so that you can only provide one encryption type, but once you have that
> > type, you can then provide all the associated fields for that type.  So
> > the QMP would look like:
> > 
> > { "driver": "qcow2", ..., "encryption" : { "type": "luks", "hash-alg":
> > ... } }
> 
> That's actually even better, a more accurate description of the options
> on the QAPI level. I like it.

Ok, I'll try implementing this approach, though I won't have time to do
this before soft-freeze, so the qcow2/luks feature is definitely 2.10
material now.

Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
