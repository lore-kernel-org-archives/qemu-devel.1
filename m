Received: from eggs.gnu.org ([2001:4830:134:3::10]:47363)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tgnyang@gmail.com>) id 1d1RFA-0003zo-3V
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 01:36:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tgnyang@gmail.com>) id 1d1RF8-00037p-I0
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 01:36:32 -0400
Received: from mail-io0-x243.google.com ([2607:f8b0:4001:c06::243]:33315)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tgnyang@gmail.com>) id 1d1RF8-00036P-C3
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 01:36:30 -0400
Received: by mail-io0-x243.google.com with SMTP id k87so26012482ioi.0
	for <qemu-devel@nongnu.org>; Thu, 20 Apr 2017 22:36:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170418181504.66fb3a11.cornelia.huck@de.ibm.com>
References: <1492345561-10267-1-git-send-email-tgnyang@gmail.com>
	<20170418181504.66fb3a11.cornelia.huck@de.ibm.com>
From: Zihan Yang <tgnyang@gmail.com>
Date: Fri, 21 Apr 2017 13:36:28 +0800
Message-ID: <CAPnP68hvotOdPXb64JDXQS8Ld5PSbY6GGfLyL-rcDt1W3+83ow@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH] hw: make *_exit functions return void
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, "Michael S. Tsirkin" <mst@redhat.com>

(I forgot to reply all in last email, so I resend the reply again)
I have resubmitted two split-out patches in https://lists.nongnu.org/
archive/html/qemu-devel/2017-04/msg03096.html, which change the exit
funtion of sclp and virtio-ccw. But the exit function of DeviceClass still
returns int after the patch because it involves other folders like hw/audio,
and as suggested by Markus Armbruster, the exit function of DeviceClass
should be converted to unrealize(), so I just leave `virtio_ccw_busdev_exit`
at present because it is an exit function of DeviceClass.


2017-04-19 0:15 GMT+08:00 Cornelia Huck <cornelia.huck@de.ibm.com>:

> On Sun, 16 Apr 2017 20:26:01 +0800
> Zihan Yang <tgnyang@gmail.com> wrote:
>
> >     According to the second suggestion listed on Dead code Removal
> >     of BiteSizedTasks, I modify some *_exit functions to make them
> >     return void. Some *_exit and *_exitfn functions that already
> >     return void remain unchanged. Also, the checks for the callers
> >     are deleted.
> >
> > Signed-off-by: Zihan Yang <tgnyang@gmail.com>
> > ---
> >  hw/audio/hda-codec.c              | 3 +--
> >  hw/audio/intel-hda.c              | 3 +--
> >  hw/audio/intel-hda.h              | 2 +-
> >  hw/char/sclpconsole-lm.c          | 3 +--
> >  hw/char/sclpconsole.c             | 3 +--
> >  hw/core/qdev.c                    | 6 +-----
> >  hw/s390x/event-facility.c         | 6 +-----
> >  hw/s390x/virtio-ccw.c             | 7 +++----
> >  hw/s390x/virtio-ccw.h             | 2 +-
> >  hw/usb/dev-smartcard-reader.c     | 3 +--
> >  include/hw/qdev-core.h            | 2 +-
> >  include/hw/s390x/event-facility.h | 2 +-
> >  12 files changed, 14 insertions(+), 28 deletions(-)
>
> Hm, I wondered why I had a deja vu... ah, here:
> https://marc.info/?t=149003291200008&r=1&w=2
>
> The author of that patch did not follow up AFAICS, but some of the
> suggestions made in that thread apply to your patch as well.
>
> In particular:
>
>
> > diff --git a/hw/char/sclpconsole-lm.c b/hw/char/sclpconsole-lm.c
> > index 07d6ebd..6fa8922 100644
> > --- a/hw/char/sclpconsole-lm.c
> > +++ b/hw/char/sclpconsole-lm.c
> > @@ -318,9 +318,8 @@ static int console_init(SCLPEvent *event)
> >      return 0;
> >  }
> >
> > -static int console_exit(SCLPEvent *event)
> > +static void console_exit(SCLPEvent *event)
> >  {
> > -    return 0;
> >  }
> >
> >  static void console_reset(DeviceState *dev)
> > diff --git a/hw/char/sclpconsole.c b/hw/char/sclpconsole.c
> > index b78f240..d9bbc5e 100644
> > --- a/hw/char/sclpconsole.c
> > +++ b/hw/char/sclpconsole.c
> > @@ -246,9 +246,8 @@ static void console_reset(DeviceState *dev)
> >     scon->notify = false;
> >  }
> >
> > -static int console_exit(SCLPEvent *event)
> > +static void console_exit(SCLPEvent *event)
> >  {
> > -    return 0;
> >  }
>
> These two now empty functions are not very useful; it is better to
> simply remove them.
>
> With that change, I'd take a split-out patch for sclp and virtio-ccw
> through my tree, or I'd ack a not-split-out version.
>
>
