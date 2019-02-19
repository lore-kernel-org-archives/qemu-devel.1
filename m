Received: from eggs.gnu.org ([209.51.188.92]:49934)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gw8Lr-0003T9-1Z
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 11:34:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gw8Lp-0002oo-QD
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 11:34:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:28138)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1gw8Lp-0002o1-HF
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 11:34:33 -0500
Date: Tue, 19 Feb 2019 17:34:27 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190219163427.GM4727@localhost.localdomain>
References: <CAFEAcA-W7AAFsrEkmUSpwqoQic7TDHnPGwnpFB_FQ25ad32n0A@mail.gmail.com>
	<596fc361faea408cabae8a5f41df2e41@AMSPEX02CL03.citrite.net>
	<61c2a38ace454e2d963dcdd89d53737d@AMSPEX02CL03.citrite.net>
	<20190218100919.GB5303@dhcp-200-176.str.redhat.com>
	<1dd9342a7ee149f2beaaebc27c72fd15@AMSPEX02CL03.citrite.net>
	<20190218105855.GC5303@dhcp-200-176.str.redhat.com>
	<0df31154c0a149ab89212aae77259f98@AMSPEX02CL03.citrite.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0df31154c0a149ab89212aae77259f98@AMSPEX02CL03.citrite.net>
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
Cc: Anthony Perard <anthony.perard@citrix.com>, 'Peter Maydell' <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

Am 19.02.2019 um 17:17 hat Paul Durrant geschrieben:
> > -----Original Message-----
> > From: Kevin Wolf [mailto:kwolf@redhat.com]
> > Sent: 18 February 2019 10:59
> > To: Paul Durrant <Paul.Durrant@citrix.com>
> > Cc: Anthony Perard <anthony.perard@citrix.com>; 'Peter Maydell'
> > <peter.maydell@linaro.org>; QEMU Developers <qemu-devel@nongnu.org>
> > Subject: Re: [Qemu-devel] QEMU xen coverity issues
> > 
> > Am 18.02.2019 um 11:28 hat Paul Durrant geschrieben:
> > > > -----Original Message-----
> > > > From: Kevin Wolf [mailto:kwolf@redhat.com]
> > > > Sent: 18 February 2019 10:09
> > > > To: Paul Durrant <Paul.Durrant@citrix.com>
> > > > Cc: 'Peter Maydell' <peter.maydell@linaro.org>; QEMU Developers <qemu-
> > > > devel@nongnu.org>; Anthony Perard <anthony.perard@citrix.com>
> > > > Subject: Re: [Qemu-devel] QEMU xen coverity issues
> > > >
> > > > Am 15.02.2019 um 17:20 hat Paul Durrant geschrieben:
> > > > > > -----Original Message-----
> > > > > [snip]
> > > > > > >
> > > > > > > (5) CID 1398649: resource leak in xen_block_drive_create():
> > > > > > >
> > > > > > > In hw/block/xen-block.c xen_block_drive_create() Coverity
> > > > > > > complains that the call "driver_layer = qdict_new()" allocates
> > > > > > > memory that's leaked because we don't save the pointer anywhere
> > > > > > > but don't deallocate it before the end of the function either.
> > > > > > > Coverity is not great at understanding our refcounting objects,
> > > > > > > but this does look like either we're missing a qobject_unref()
> > > > > > > or something should be keeping hold of the dictionary. Probably
> > > > > > > best to ask a block layer expert.
> > > > > >
> > > > > > AFAICT nothing will consume the dictionary so it does appear that
> > > > we're
> > > > > > missing an unref here.
> > > > >
> > > > > Testing proves me wrong... This one is a false positive.
> > > >
> > > > Hm, but where is it freed?
> > > >
> > > > xen_block_blockdev_add() only feeds it to an input visitor, which
> > > > doesn't take ownership of the QDict (and in the first error path, it
> > > > hasn't even done that yet).
> > >
> > > Agreed that error path does not free things... that's definitely a
> > > leak... but attempting to free the QDict's on return from
> > > xen_block_blockdev_add() certainly causes a seg fault. My assumption
> > > was that, having been fed through the input visitor and then through
> > > the output visitor in qmp_blockdev_add() that the BlockDriverState
> > > eventually takes ownership... but maybe that's not true?
> > 
> > qmp_blockdev_add() only ever sees the QAPI object, not the original
> > QDict, so it should be able to take ownership of it. If anything, the
> > visitor could do so, but I don't think it does (it takes an extra
> > reference, which it frees at the end, but it doesn't free the reference
> > it was originally passed).
> > 
> > Maybe worth having another look at that segfault? It could point to a
> > related, but separate bug.
> 
> What I'd failed to realize that was, having done a qdict_put_obj() to
> include the file_layer QDict in the driver_layer QDict, that doing a
> qobject_unref() on driver_layer would also implicitly unref the
> file_layer. I now have a patch that just unrefs driver_layer and that
> seems to be fine. I'll send it shortly.

Yes, that sounds right. qdict_put_obj() takes ownership of the reference
that you pass it, so we should only unref driver_layer.

Kevin
