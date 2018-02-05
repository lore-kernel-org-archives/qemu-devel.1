Received: from eggs.gnu.org ([2001:4830:134:3::10]:54750)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eidVi-0005mT-Ta
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 04:56:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eidVf-00007T-SI
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 04:56:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60944)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eidVf-00006x-NE
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 04:56:23 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E0E7480467
	for <qemu-devel@nongnu.org>; Mon,  5 Feb 2018 09:56:22 +0000 (UTC)
Date: Mon, 5 Feb 2018 10:56:21 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180205095621.n76r6aydr5ragtyf@sirius.home.kraxel.org>
References: <20180202111022.19269-1-kraxel@redhat.com>
	<20180202111022.19269-7-kraxel@redhat.com>
	<0ef8a626-9623-b87a-b37e-ef4ebdfa8816@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ef8a626-9623-b87a-b37e-ef4ebdfa8816@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 06/12] vl: drop no_quit variable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>

On Fri, Feb 02, 2018 at 09:35:52AM -0600, Eric Blake wrote:
> On 02/02/2018 05:10 AM, Gerd Hoffmann wrote:
> > Not used any more, delete it.
> > 
> > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> > ---
> >  vl.c | 7 ++-----
> >  1 file changed, 2 insertions(+), 5 deletions(-)
> > 
> > diff --git a/vl.c b/vl.c
> 
> > @@ -4368,7 +4364,8 @@ int main(int argc, char **argv, char **envp)
> >          error_report("-no-frame, -alt-grab and -ctrl-grab are only valid "
> >                       "for SDL, ignoring option");
> >      }
> > -    if (no_quit && (display_type != DT_GTK && display_type != DT_SDL)) {
> > +    if (dpy.has_window_close &&
> > +        (display_type != DT_GTK && display_type != DT_SDL)) {
> >          error_report("-no-quit is only valid for GTK and SDL, "
> >                       "ignoring option");
> 
> Does this mean we should move the 'window-close' field out of the common
> base type and into DisplayGTK/DisplaySDL instead (where sdl would need
> its own type instead of DisplayNoOpts)?

Well, strictly speaking that would be more accurate, but backward
compatibility with -no-quit would become more messy then.  Also cocoa
could probably add support for the window-close option without too much
effort.

> I guess the difference is how
> long we have been flagging this error message -

The message is there as long as I remember.  It's a warning only though,
it will not prevent qemu from starting.

> if we rearrange the QAPI
> type, this code is dead and you've broken the command line that tries to
> do window type none combined with -no-quit;

Depends on how you code things up...

With window-close being in the common section you can just set it when
you see '-no-quit'.

With window-close being in the display specific options you have
remember you have seen '-no-quit', then later when we know what the
display type is run

  switch (displaytype) {
  case sdl: sdl.window_close = true; break;

At that point you can do whatever you want in the default branch ...

> but if that command line has
> already been documented as broken, it is no real loss.  But if we
> haven't had enough of a deprecation period yet, then keeping
> window-close global to all variants of the union and doing the runtime
> rejection check lets us finish the deprecation period.

Which deprecation period?  -no-quit isn't deprecated.

cheers,
  Gerd
