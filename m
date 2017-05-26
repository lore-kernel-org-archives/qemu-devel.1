Received: from eggs.gnu.org ([2001:4830:134:3::10]:52966)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dEFkP-0003gX-EH
	for qemu-devel@nongnu.org; Fri, 26 May 2017 09:57:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dEFkO-0003DA-89
	for qemu-devel@nongnu.org; Fri, 26 May 2017 09:57:45 -0400
Date: Fri, 26 May 2017 14:57:31 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170526135731.GJ24484@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170525163851.8047-1-berrange@redhat.com>
	<20170525163851.8047-13-berrange@redhat.com>
	<bf5923b7-60aa-f2b9-4a22-7d5ff814698a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bf5923b7-60aa-f2b9-4a22-7d5ff814698a@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v7 12/20] qcow2: extend specification to
 cover LUKS encryption
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>

On Thu, May 25, 2017 at 02:39:56PM -0500, Eric Blake wrote:
> On 05/25/2017 11:38 AM, Daniel P. Berrange wrote:
> > Update the qcow2 specification to describe how the LUKS header is
> > placed inside a qcow2 file, when using LUKS encryption for the
> > qcow2 payload instead of the legacy AES-CBC encryption
> > 
> > Reviewed-by: Alberto Garcia <berto@igalia.com>
> > Reviewed-by: Max Reitz <mreitz@redhat.com>
> > Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> > ---
> >  docs/specs/qcow2.txt | 96 ++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 96 insertions(+)
> > 
> 
> > +
> > +The first 592 bytes of the header clusters will contain the LUKS
> > +partition header. This is then followed by the key material data areas.
> > +The size of the key material data areas is determined by the number of
> > +stripes in the key slot and key size. Refer to the LUKS format
> > +specification ('docs/on-disk-format.pdf' in the cryptsetup source
> > +package) for details of the LUKS partition header format.
> > +
> > +In the LUKS partition header, the "payload-offset" field will be
> > +calculated as normal for the LUKS spec. ie the size of the LUKS
> > +header, plus key material regions, plus padding, relative to the
> > +start of the LUKS header. Its value is never used in the context
> > +of qcow2, however, since the qcow2 file format itself defines where
> > +the real payload offset is.
> 
> Is it possible/valid for the LUKS payload-offset field to NOT be
> qcow2-cluster-aligned?  (I'm guessing yes, for example, if we have 2M
> clusters; and that we don't care, because you documented that we don't
> actually use that offset).  Is it worth documenting this?

Yeah, it is not required to be cluster aligned, and that doesn't
matter because we don't use it in context of qcow2.

Essentially the only time it would be used if is we had some
optimized way in future to convert from qcow2 w/ luks over to
file w/ luks, without having to decrypt+reencrypt the payload.
ie we could just copy out the entire luks header as-is, and
then copy out the qcow2 payload after it.

> > +== Data encryption ==
> > +
> > +When an encryption method is requested in the header, the image payload
> > +data must be encrypted/decrypted on every write/read. The image headers
> > +and metadata is never encrypted.
> 
> s/is/are/
> 
> > +
> > +The algorithms used for encryption vary depending on the method
> > +
> > + - AES:
> > +
> > +   The AES cipher, in CBC mode, with 256 bit keys.
> > +
> > +   Initialization vectors generated using plain64 method, with
> > +   the virtual disk sector as the input tweak.
> 
> Worth documenting that implementations should avoid creating new images
> with this encryption (ie. make it officially part of the spec that this
> is not recommended, but merely documented for back-compat data
> liberation purposes)?

I guess I could document that here too - I did add such a note to
the qemu-doc.texi at the end of this series.

> 
> Reviewed-by: Eric Blake <eblake@redhat.com>


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
