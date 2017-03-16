Received: from eggs.gnu.org ([2001:4830:134:3::10]:34673)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1coSCA-00050g-Hg
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 05:59:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1coSC7-0008GS-GC
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 05:59:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57612)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1coSC7-0008Fi-AI
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 05:59:43 -0400
Message-ID: <1489658380.15659.81.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 16 Mar 2017 10:59:40 +0100
In-Reply-To: <1489657576.561.24.camel@nokia.com>
References: <cover.1489494746.git.janne.huttunen@nokia.com>
	<1489510640.8844.18.camel@redhat.com>
	<1489561105.24841.25.camel@nokia.com>
	<1489562641.15659.16.camel@redhat.com>
	<1489657576.561.24.camel@nokia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Re: [Qemu-devel] [RFC][PATCH 0/6] "bootonceindex" property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Janne Huttunen <janne.huttunen@nokia.com>
Cc: qemu-devel@nongnu.org

On Do, 2017-03-16 at 11:46 +0200, Janne Huttunen wrote:
> On Wed, 2017-03-15 at 08:24 +0100, Gerd Hoffmann wrote:
> > >
> > > The short answer: emulating real hardware.
> >=20
> > Ok, that is reason enough.
> >=20
> > Adding bootonceindex everywhere doesn't look like the best plan to me
> > though.  Possibly we can pimp up bootindex in a backward-compatible
> > way?
> > Something like bootindex=3D<normal>[.<once>] ?
>=20
> That would (likely) avoid modifying all devices, but wouldn't
> that make the 'bootindex' property a string (now: 'int32')
> and thus change the QOM API?

Good point.  I was thinking about the cmd line only where it is a string
anyway.

> I did consider making device_add_bootindex_property() to
> automatically add the new property too, but since that API
> is currently such that the _caller_ provides the name of the
> added property, it would mean that the function would need
> to generate the second name using some magic mangling rule
> and that didn't seem very nice to me.

I think the only case where this is something !=3D "bootindex" is the
floppy controller, which has bootindexA and bootindexB for the two
drives.  So name mangling doesn't look too bad to me.  Maybe we could
just add a "first-" or "once-" prefix.  But the second bootindex still
needs to be stored somewhere in the device state struct ...

> Of course the API could
> be modified so that the caller provides two names, but then
> we are already back to modifying all relevant devices.

... so I guess there isn't really some way around that.

cheers,
  Gerd
