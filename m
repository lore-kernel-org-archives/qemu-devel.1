Received: from eggs.gnu.org ([2001:4830:134:3::10]:53270)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eP7tS-0003Jb-94
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 09:20:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eP7tP-0005bG-0z
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 09:20:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:6801)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eP7tO-0005Xp-Pv
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 09:20:14 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 663E06014F
	for <qemu-devel@nongnu.org>; Wed, 13 Dec 2017 14:20:13 +0000 (UTC)
Date: Wed, 13 Dec 2017 14:20:01 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171213142001.GF28379@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170911110623.24981-1-marcandre.lureau@redhat.com>
	<20170911110623.24981-37-marcandre.lureau@redhat.com>
	<87mv2maf91.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87mv2maf91.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [PATCH v3 36/50] qapi: add conditions to VNC
 type/commands/events on the schema
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

On Wed, Dec 13, 2017 at 03:12:26PM +0100, Markus Armbruster wrote:
> Cc: Daniel for his opinion on QCryptoCipherAlgorithm member des-rfb.

> > Enum made conditional:
> 
> The enum isn't made conditional, only one of its values is.  Suggest "
> Enumeration values made conditional:".
> 
> > * QCryptoCipherAlgorithm
> >
> >     # @des-rfb: RFB specific variant of single DES. Do not use except in VNC.
> 
> Daniel, is this okay?

I don't think we should touch the crypto/ code at all here.

Although the VNC server is the only intended user of the des-rfb choice,
I don't really think we should make this conditional on CONFIG_VNC. It
isn't reducing the amount of code we build in any meaningful way and is
littering the crypto code with '#ifdef CONFIG_VNC' conditionals, which
harms readability and I think it is a code layering violation.

So please drop the following changes:

> >  qapi/crypto.json           |  3 ++-
> >  crypto/cipher-builtin.c    |  9 +++++++++
> >  crypto/cipher-gcrypt.c     | 10 ++++++++--
> >  crypto/cipher-nettle.c     | 14 +++++++++++---
> >  crypto/cipher.c            | 13 +++++++++++--
> >  tests/test-crypto-cipher.c |  2 ++

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
