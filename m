Received: from eggs.gnu.org ([2001:4830:134:3::10]:33144)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dMxD2-0002jh-K1
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 09:59:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dMxD1-0003Nf-LV
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 09:59:16 -0400
Date: Mon, 19 Jun 2017 14:58:57 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170619135857.GF2640@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170601172734.9039-1-berrange@redhat.com>
	<20170601172734.9039-10-berrange@redhat.com>
	<e362e833-32b9-57ec-4a92-c17293eefbbe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e362e833-32b9-57ec-4a92-c17293eefbbe@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v8 09/20] qcow: convert QCow to use
 QCryptoBlock for encryption
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>

On Wed, Jun 07, 2017 at 06:55:39PM +0200, Max Reitz wrote:
> On 2017-06-01 19:27, Daniel P. Berrange wrote:
> > This converts the qcow driver to make use of the QCryptoBlock
> > APIs for encrypting image content. This is only wired up to
> > permit use of the legacy QCow encryption format. Users who wish
> > to have the strong LUKS format should switch to qcow2 instead.
> > 
> > With this change it is now required to use the QCryptoSecret
> > object for providing passwords, instead of the current block
> > password APIs / interactive prompting.
> > 
> 
> Beware, nit picks incoming:
> 
> >   $QEMU \
> >     -object secret,id=sec0,filename=/home/berrange/encrypted.pw \>     -drive file=/home/berrange/encrypted.qcow,encrypt.format=qcow,\
> 
> encrypt.format should be "aes".
> 
> >            encrypt.key-secret=sec0
> 
> This doesn't work at all, though, because:
> 
> Use of AES-CBC encrypted qcow images is no longer supported in system
> emulators
> You can use 'qemu-img convert' to convert your image to an alternative
> supported format, such as unencrypted qcow, or raw with the LUKS format
> instead.

Good point. I'll leave this example here, since it is
useful to illustrate the overall syntax approach, but
I'll add a note that this example won't let you run
the VM

> > Likewise when creating images with the legacy AES-CBC format
> > 
> >   qemu-img create -f qcow \
> >     -object secret,id=sec0,filename=/home/berrange/encrypted.pw \
> 
> Should be --object.

Yep

> 
> >     -o encrypt.format=aes,encrypt.key-secret=sec0 \
> >     /home/berrange/encrypted.qcow
> 
> There should be a size here to make it work.

Ok


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
