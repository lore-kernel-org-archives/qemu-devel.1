Received: from eggs.gnu.org ([2001:4830:134:3::10]:60955)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fGmca-0008OH-AY
	for qemu-devel@nongnu.org; Thu, 10 May 2018 10:32:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fGmcW-0006UH-8z
	for qemu-devel@nongnu.org; Thu, 10 May 2018 10:32:40 -0400
Date: Thu, 10 May 2018 15:32:23 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180510143222.GF18604@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180509165530.29561-1-mreitz@redhat.com>
	<20180509165530.29561-6-mreitz@redhat.com>
	<9bbee72f-4ac6-c564-3537-9d9e37e551be@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9bbee72f-4ac6-c564-3537-9d9e37e551be@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 05/13] qapi: Formalize qcow encryption
 probing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>

On Thu, May 10, 2018 at 09:24:24AM -0500, Eric Blake wrote:
> On 05/09/2018 11:55 AM, Max Reitz wrote:
> > Currently, you can give no encryption format for a qcow file while still
> > passing a key-secret.  That does not conform to the schema, so this
> > patch changes the schema to allow it.
> > 
> > Signed-off-by: Max Reitz <mreitz@redhat.com>
> > ---
> 
> >   ##
> >   # @BlockdevQcowEncryptionFormat:
> >   #
> >   # @aes: AES-CBC with plain64 initialization vectors
> >   #
> > +# @from-image:      Determine the encryption format from the image
> > +#                   header.  This only allows the use of the
> > +#                   key-secret option.  (Since: 2.13)
> > +#
> >   # Since: 2.10
> >   ##
> >   { 'enum': 'BlockdevQcowEncryptionFormat',
> > -  'data': [ 'aes' ] }
> > +  'data': [ 'aes', 'from-image' ] }
> 
> Overkill.  Why not just:
> 
> >   ##
> >   # @BlockdevQcowEncryption:
> > @@ -2728,9 +2748,11 @@
> >   # Since: 2.10
> >   ##
> >   { 'union': 'BlockdevQcowEncryption',
> > -  'base': { 'format': 'BlockdevQcowEncryptionFormat' },
> > +  'base': { '*format': 'BlockdevQcowEncryptionFormat' },
> >     'discriminator': 'format',
> > -  'data': { 'aes': 'QCryptoBlockOptionsQCow' } }
> > +  'default-variant': 'from-image',
> 
> 'default-variant': 'aes'
> 
> > +  'data': { 'aes': 'QCryptoBlockOptionsQCow',
> 
> and call it good, because there are no other options to pick from, so
> 'from-image' would always resolve to 'aes' anyway.

Sounds reasonable because qcowv1 is a dead format we don't intend to
add more features to.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
