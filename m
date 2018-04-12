Received: from eggs.gnu.org ([2001:4830:134:3::10]:50740)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tournier.elie@gmail.com>) id 1f6d2n-0005VT-V6
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 10:17:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tournier.elie@gmail.com>) id 1f6d2k-0003kq-MJ
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 10:17:45 -0400
Received: from mail-wm0-x22e.google.com ([2a00:1450:400c:c09::22e]:35342)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tournier.elie@gmail.com>)
	id 1f6d2k-0003kE-Cu
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 10:17:42 -0400
Received: by mail-wm0-x22e.google.com with SMTP id r82so9998126wme.0
	for <qemu-devel@nongnu.org>; Thu, 12 Apr 2018 07:17:42 -0700 (PDT)
Date: Thu, 12 Apr 2018 15:11:53 +0100
From: Elie Tournier <tournier.elie@gmail.com>
Message-ID: <20180412141153.GA16814@Nikki.localdomain>
References: <20180410120222.31845-1-tournier.elie@gmail.com>
	<20180410120222.31845-2-tournier.elie@gmail.com>
	<c6e49f50-0cd0-c118-f080-48751de595ec@redhat.com>
	<20180410133335.zzvgg7lqe2lb2zdx@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180410133335.zzvgg7lqe2lb2zdx@sirius.home.kraxel.org>
Subject: Re: [Qemu-devel] [PATCH v2 1/2 for-2.12?] qapi: Parameter gl of
 DisplayType now accept an enum
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, pbonzini@redhat.com, Elie Tournier <elie.tournier@collabora.com>

Hello,

On Tue, Apr 10, 2018 at 03:33:35PM +0200, Gerd Hoffmann wrote:
> > # @off: Disable OpenGL (default).

Just to be sure, I have to add @ in front of all parameter, right?

> > 
> > > + # 'on'    Use OpenGL, pick context type automatically.
> > > + #         Would better be named 'auto' but is called 'on' for backward
> > > + #         compatibility with bool type.
> > 
> > See below...
> 
> > DisplayOptions was added in 2.12.  This is a backwards-incompatible
> > change in QMP (you CANNOT change 'bool' to 'DisplayGLMode' across
> > releases, because the on-the-wire representation differs; pre-patch it
> > would be "gl":true, post-patch it is "gl":"on").  So if it affects QMP,
> > and we want it, this patch either HAS to go in 2.12, or we have to have
> > more finesse (perhaps by using an 'alternate' type in the QAPI) so that
> > it remains backwards-compatible.
> > 
> > /me goes and looks at introspection output...
> > 
> > You may be in luck - there is no instance of 'window-close' in the
> > introspection output, which means 'DisplayType' exists only for ease of
> > command-line parsing and is not currently used by QMP, so tweaks here
> > are not affecting the command line.
> 
> Yes, right now the struct is only used to store the parsed command line
> opts, so no effect on QMP.
> 
> Plan for the future is to also parse command line options with generic
> qapi/json code instead of the home-grown parser, but that switch didn't
> happen yet.
> 
> > That said, you can STILL name the enum value something smarter than 'on'
> > IF you make the change now, for 2.12, given that the QAPI type was only
> > introduced in 2.12 (you only have to worry about backwards compatibility
> > if 2.11 already parsed gl=on).
> 
> gl=on is older, so that must continue to work.  Making both "on" and
> "auto" work isn't a problem for our home-grown parser (aka
> parse_display() in vl.c).  But having quirks like this makes the switch
> to generic parser code more difficuilt, so I'd prefer to avoid that ...

Is it possible to upstream this change before 2.12 release?

> 
> cheers,
>   Gerd
> 
