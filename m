Received: from eggs.gnu.org ([209.51.188.92]:57387)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gxX7t-0002wm-Po
	for qemu-devel@nongnu.org; Sat, 23 Feb 2019 08:13:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gxX61-0000qN-5G
	for qemu-devel@nongnu.org; Sat, 23 Feb 2019 08:12:02 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:45996)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gxX60-0000Xs-Lh
	for qemu-devel@nongnu.org; Sat, 23 Feb 2019 08:12:01 -0500
Received: by mail-oi1-x241.google.com with SMTP id t82so3865599oie.12
	for <qemu-devel@nongnu.org>; Sat, 23 Feb 2019 05:11:41 -0800 (PST)
MIME-Version: 1.0
References: <20190214102816.3393-1-peter.maydell@linaro.org>
	<20190214102816.3393-2-peter.maydell@linaro.org>
	<20190222151910.io5pvf6u3kp3axns@SPB-NB-133.local>
	<CAFEAcA_Ek6iZshV45qykNiu8mTgwh0a5zYFRWX-mUNX2f6Na6Q@mail.gmail.com>
	<20190222214806.km4yjotea6cstkhy@SPB-NB-133.local>
In-Reply-To: <20190222214806.km4yjotea6cstkhy@SPB-NB-133.local>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 23 Feb 2019 13:11:29 +0000
Message-ID: <CAFEAcA_bG6up1hqJunyyOgQreEX5GWGGcS4W7n1SKQMvSO1NaA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 1/7] ui/cocoa: Ensure we have the
 iothread lock when calling into QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Roman Bolshakov <r.bolshakov@yadro.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, John Arbuckle <programmingkidx@gmail.com>, Berkus Decker <berkus@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>, Ben Hekster <ben.hekster@foghorn.io>, BALATON Zoltan <balaton@eik.bme.hu>

On Fri, 22 Feb 2019 at 21:48, Roman Bolshakov <r.bolshakov@yadro.com> wrote:
>
> On Fri, Feb 22, 2019 at 03:41:05PM +0000, Peter Maydell wrote:
> > On Fri, 22 Feb 2019 at 15:19, Roman Bolshakov <r.bolshakov@yadro.com> wrote:
> > >
> > > On Thu, Feb 14, 2019 at 10:28:10AM +0000, Peter Maydell wrote:
> > > > The Cocoa UI should run on the main thread; this is enforced
> > > > in OSX Mojave. In order to be able to run on the main thread,
> > > > we need to make sure we hold the iothread lock whenever we
> > > > call into various QEMU UI midlayer functions.
> > > >
> > >
> > > I also think it's better to clarify that the reason of the commit is not
> > > Mojave enforcing usage of event loop in main thread but an improvement
> > > of event processing in Cocoa UI, because Cocoa UI works on Mojave.
> >
> > Hmm? The point of this patchset is exactly that Mojave enforces
> > that things go on the main thread, where previous OSX versions
> > did not, and so in some situations QEMU will crash on Mojave
> > where it did not on older versions. So I'm not sure what you're
> > suggesting should be clarified here.
> >
>
> I'm not exactly sure there's an issue with QEMU on Mojave. But I lean
> towards the opinion because I haven't seen it :)

It only happens for some guest workloads. The "usual" case
is that the cocoa_refresh callback is called from the QEMU
main loop, which happens to be on the OSX main thread, which
means OSX is still happy. But in some cases cocoa_refresh can
be called from a guest vCPU thread -- I think we've seen this
when a guest initiates a screen resolution change: the call
from the guest vCPU thread goes into the model of the graphics
device, which makes a call into the UI midlayer to say
"resolution changed", which immediately triggers a
refresh callback to the UI frontend layer from that thread.
In Mojave this causes OSX to terminate QEMU. I think in
older OSX versions it would probably be a race condition,
so it's technically a bug but not one that usually has
any visible bad effects; it's only surfaced as a problem
now that Mojave actively checks for this condition and
kills the process.

thanks
-- PMM
