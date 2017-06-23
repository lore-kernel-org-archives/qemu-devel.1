Received: from eggs.gnu.org ([2001:4830:134:3::10]:53800)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dOLVz-0006zw-Ck
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 06:08:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dOLVy-0007dB-0T
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 06:08:35 -0400
Date: Fri, 23 Jun 2017 11:08:25 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170623100825.GF28635@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170619173455.18805-1-berrange@redhat.com>
	<20170619173455.18805-8-berrange@redhat.com>
	<w51d19y51e5.fsf@maestria.local.igalia.com>
	<20170620120206.GA23328@redhat.com>
	<w517f06lpl6.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <w517f06lpl6.fsf@maestria.local.igalia.com>
Subject: Re: [Qemu-devel] [PATCH v9 07/20] block: deprecate "encryption=on"
 in favor of "encrypt.format=aes"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>

On Tue, Jun 20, 2017 at 04:07:49PM +0200, Alberto Garcia wrote:
> On Tue 20 Jun 2017 02:02:06 PM CEST, Daniel P. Berrange wrote:
> >> > +    if (encryptfmt) {
> >> > +        buf = qemu_opt_get_del(opts, BLOCK_OPT_ENCRYPT);
> >> > +        if (buf != NULL) {
> >> > +            g_free(buf);
> >> 
> >> If you use qemu_opt_get() instead then you don't need "buf" at all,
> >> do you?
> >
> > IIRC, we needed to delete the option from opts, otherwise something
> > will later complain that there are opts that are not consumed.
> 
> I don't see how, since once you reached this point it means that you
> cannot create the image because the options are already wrong.

Ah yes, that is of course true.

> Anyway, there's a more important problem with this patch that I just
> noticed: in this scenario you're freeing 'buf' twice, first in the snip
> I quoted above, and then at the end of qcow2_create().
> 
> qcow_create() from qcow.c is safe, but perhaps it's clearer if you put
> the declaration of the 'buf' variable inside the 'if (encryptfmt)'
> block.
> 
> That assuming that you really need to use qemu_opt_get_del() there. With
> the double-free bug fixed, I don't see any difference when using
> qemu_opt_get_del() vs qemu_opt_get().

I'll switch to qemu_opt_get as you suggest.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
