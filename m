Received: from eggs.gnu.org ([2001:4830:134:3::10]:39054)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berkus@gmail.com>) id 1gSBoH-0000wx-1T
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 21:12:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berkus@gmail.com>) id 1gSBo5-0001Ad-G4
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 21:12:04 -0500
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131]:33434)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <berkus@gmail.com>) id 1gSBnx-00013C-Au
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 21:11:51 -0500
Received: by mail-lf1-x131.google.com with SMTP id i26so262573lfc.0
	for <qemu-devel@nongnu.org>; Wed, 28 Nov 2018 18:11:46 -0800 (PST)
MIME-Version: 1.0
References: <20181128010817.6191-1-programmingkidx@gmail.com>
	<CAFEAcA_C3BtOvEFrSOntma4GtreJNEmtg3pxkB+2iCYKVFQinA@mail.gmail.com>
	<AFD02114-6C8E-441B-87C0-469BE693601E@gmail.com>
In-Reply-To: <AFD02114-6C8E-441B-87C0-469BE693601E@gmail.com>
From: berkus infinitus <berkus@gmail.com>
Date: Thu, 29 Nov 2018 04:11:34 +0200
Message-ID: <CABsm=W35aFrF=cTJD74E6d9Ugau=PwPQ9wrjCDZueJwhMGVHgA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] (no subject)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Programmingkid <programmingkidx@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

I suspect the main problem is the blocking call to qemu_main from the UI
thread in the app delegate didFinishLoadingWithOptions if i=E2=80=99m not m=
istaken
and everything else grows from there. Going to build and run it now, since
I woke up in the middle of the night anyway for reasons unexplainable)
On Thu, 29 Nov 2018 at 02:21, Programmingkid <programmingkidx@gmail.com>
wrote:

>
> > On Nov 28, 2018, at 2:39 PM, Peter Maydell <peter.maydell@linaro.org>
> wrote:
> >
> > On Wed, 28 Nov 2018 at 01:12, John Arbuckle <programmingkidx@gmail.com>
> wrote:
> >>
> >> From af4497f2b161bb4165acb8eee5cae3f2a7ea2227 Mon Sep 17 00:00:00 2001
> >> From: John Arbuckle <programmingkidx@gmail.com>
> >> Date: Tue, 27 Nov 2018 20:01:20 -0500
> >> Subject: [PATCH] ui/cocoa.m: fix crash due to cocoa_refresh() on Mac O=
S
> 10.14
> >
> > Something seems to have got the formatting of this patch email
> > wrong -- it's got all this in the body and the actual Subject
> > line of the email is blank.
>
> I don't know what happened.
>
> >
> >> Mac OS 10.14 only wants UI code to be called from the main thread. The
> >> cocoa_refresh() function is called on another thread and this causes a
> >> crash to take place. To fix this problem the cocoa_refresh() code is
> >> called from the main thread only.
> >>
> >> Signed-off-by: John Arbuckle <programmingkidx@gmail.com>
> >> ---
> >> ui/cocoa.m | 59
> ++++++++++++++++++++++++++++++++++-------------------------
> >> 1 file changed, 34 insertions(+), 25 deletions(-)
> >
> > I get a compile warning with this patch:
> > /Users/pm215/src/qemu/ui/cocoa.m:1615:23: warning: instance method
> > '-cocoa_refresh' not found (return type defaults to 'id')
> > [-Wobjc-method-access]
> >    [[NSApp delegate] cocoa_refresh];
> >                      ^~~~~~~~~~~~~
>
> This will fix the problem:
>
> static void cocoa_refresh(DisplayChangeListener *dcl)
> {
>     QemuCocoaAppController *controller =3D (QemuCocoaAppController *)[NSA=
pp
> delegate];
>     [controller cocoa_refresh];
> }
>
> > To be honest, I'm still confused about what is causing the
> > problems on Mojave. The refresh method should be being called
> > on the main thread even with the code on master -- it's just
> > that that is the iothread and it's running the event pumping
> > code in the refresh callback rather than a standard OSX
> > event loop. I'm hoping that the backtrace with symbols of
> > the Mojave assertion failure will help there, since I
> > can't currently see where refresh gets called from some
> > non-main thread.
>
> This might be a Mojave issue and not a QEMU issue.
> I'm on Mac OS 10.12 so I can't confirm anything.
>
> > I also think that this patch doesn't address the problems
> > of locking that I mention on the discussion thread for
> > Berkus' patch. It also doesn't handle any of the other
> > callbacks from QEMU to the cocoa UI -- surely we need to
> > handle all of them if there is a problem here?
>
> To answer this question I would have to know how my patch
> does on Mac OS 10.14. Does it stop the crashing issue? If
> this patch does fix that problem then I think sticking to
> a simple solution may be the answer. The use of locks may
> not be needed.
>
> > (I have some prototype patches which I've been working
> > on which address the locking problem and also make all
> > the QEMU callbacks run their work on the main thread.
> > I may be able get those into shape to post those next week.)
>
> Please CC me when do release it. I will test it on Mac OS 10.12
> and Mac OS 10.6.
