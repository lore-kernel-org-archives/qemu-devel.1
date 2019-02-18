Received: from eggs.gnu.org ([209.51.188.92]:39652)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gvfrm-0000Sq-8b
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 05:09:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gvfrg-0003OF-Bh
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 05:09:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59144)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1gvfrY-0003Kd-J5
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 05:09:26 -0500
Date: Mon, 18 Feb 2019 11:09:19 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190218100919.GB5303@dhcp-200-176.str.redhat.com>
References: <CAFEAcA-W7AAFsrEkmUSpwqoQic7TDHnPGwnpFB_FQ25ad32n0A@mail.gmail.com>
	<596fc361faea408cabae8a5f41df2e41@AMSPEX02CL03.citrite.net>
	<61c2a38ace454e2d963dcdd89d53737d@AMSPEX02CL03.citrite.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61c2a38ace454e2d963dcdd89d53737d@AMSPEX02CL03.citrite.net>
Subject: Re: [Qemu-devel] QEMU xen coverity issues
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paul Durrant <Paul.Durrant@citrix.com>
Cc: 'Peter Maydell' <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Anthony Perard <anthony.perard@citrix.com>

Am 15.02.2019 um 17:20 hat Paul Durrant geschrieben:
> > -----Original Message-----
> [snip]
> > >
> > > (5) CID 1398649: resource leak in xen_block_drive_create():
> > >
> > > In hw/block/xen-block.c xen_block_drive_create() Coverity
> > > complains that the call "driver_layer = qdict_new()" allocates
> > > memory that's leaked because we don't save the pointer anywhere
> > > but don't deallocate it before the end of the function either.
> > > Coverity is not great at understanding our refcounting objects,
> > > but this does look like either we're missing a qobject_unref()
> > > or something should be keeping hold of the dictionary. Probably
> > > best to ask a block layer expert.
> > 
> > AFAICT nothing will consume the dictionary so it does appear that we're
> > missing an unref here.
> 
> Testing proves me wrong... This one is a false positive.

Hm, but where is it freed?

xen_block_blockdev_add() only feeds it to an input visitor, which
doesn't take ownership of the QDict (and in the first error path, it
hasn't even done that yet).

Kevin
