Received: from eggs.gnu.org ([2001:4830:134:3::10]:52696)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tournier.elie@gmail.com>) id 1f5tjV-0005EK-51
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 09:54:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tournier.elie@gmail.com>) id 1f5tjS-00057r-26
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 09:54:49 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:39632)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tournier.elie@gmail.com>)
	id 1f5tjR-00057M-RF
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 09:54:45 -0400
Received: by mail-wm0-x242.google.com with SMTP id f125so23511921wme.4
	for <qemu-devel@nongnu.org>; Tue, 10 Apr 2018 06:54:45 -0700 (PDT)
Date: Tue, 10 Apr 2018 14:49:01 +0100
From: Elie Tournier <tournier.elie@gmail.com>
Message-ID: <20180410134901.GA6818@Nikki.localdomain>
References: <20180410120222.31845-1-tournier.elie@gmail.com>
	<20180410120222.31845-2-tournier.elie@gmail.com>
	<c6e49f50-0cd0-c118-f080-48751de595ec@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c6e49f50-0cd0-c118-f080-48751de595ec@redhat.com>
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
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, Elie Tournier <elie.tournier@collabora.com>, kraxel@redhat.com

On Tue, Apr 10, 2018 at 08:13:00AM -0500, Eric Blake wrote:
> On 04/10/2018 07:02 AM, Elie Tournier wrote:
> > Signed-off-by: Elie Tournier <elie.tournier@collabora.com>
> > ---
> >  qapi/ui.json | 21 ++++++++++++++++++++-
> >  vl.c         | 10 +++++-----
> >  2 files changed, 25 insertions(+), 6 deletions(-)
> > 
> > diff --git a/qapi/ui.json b/qapi/ui.json
> > index 5d01ad4304..c8005867e5 100644
> > --- a/qapi/ui.json
> > +++ b/qapi/ui.json
> > @@ -1019,6 +1019,25 @@
> >  { 'struct'  : 'DisplayGTK',
> >    'data'    : { '*grab-on-hover' : 'bool' } }
> >  
> > + ##
> > + # @DisplayGLMode:
> > + #
> > + # Display OpenGL mode.
> > + #
> > + # 'off'   Disable OpenGL (default).
> 
> Wrong format; this should be:
> 
> # @off: Disable OpenGL (default).

Fix locally
> 
> > + # 'on'    Use OpenGL, pick context type automatically.
> > + #         Would better be named 'auto' but is called 'on' for backward
> > + #         compatibility with bool type.
> 
> See below...
> 
> > + # 'core'  Use OpenGL with Core (desktop) Context.
> > + # 'es'    Use OpenGL with ES (embedded systems) Context.
> > + #
> > + # Since: 2.13
> > + #
> > + ##
> > + { 'enum'    : 'DisplayGLMode',
> > +   'data'    : [ 'off', 'on', 'core', 'es' ] }
> > +
> > +
> >  ##
> >  # @DisplayType:
> >  #
> > @@ -1048,7 +1067,7 @@
> >    'base'    : { 'type'           : 'DisplayType',
> >                  '*full-screen'   : 'bool',
> >                  '*window-close'  : 'bool',
> > -                '*gl'            : 'bool' },
> > +                '*gl'            : 'DisplayGLMode' },
> 
> DisplayOptions was added in 2.12.  This is a backwards-incompatible
> change in QMP (you CANNOT change 'bool' to 'DisplayGLMode' across
> releases, because the on-the-wire representation differs; pre-patch it
> would be "gl":true, post-patch it is "gl":"on").  So if it affects QMP,
> and we want it, this patch either HAS to go in 2.12, or we have to have
> more finesse (perhaps by using an 'alternate' type in the QAPI) so that
> it remains backwards-compatible.
> 
> /me goes and looks at introspection output...
> 
> You may be in luck - there is no instance of 'window-close' in the
> introspection output, which means 'DisplayType' exists only for ease of
> command-line parsing and is not currently used by QMP, so tweaks here
> are not affecting the command line.
> 
> That said, you can STILL name the enum value something smarter than 'on'
> IF you make the change now, for 2.12, given that the QAPI type was only
> introduced in 2.12 (you only have to worry about backwards compatibility
> if 2.11 already parsed gl=on).

It sounds like making the change now is the best option.
So, is 'auto' a better choice than 'on' in the enum?
> 
> -- 
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3266
> Virtualization:  qemu.org | libvirt.org
> 
