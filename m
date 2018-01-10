Received: from eggs.gnu.org ([2001:4830:134:3::10]:38554)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1eZDKi-0001Qr-C3
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 05:10:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1eZDKe-00017r-8Q
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 05:10:08 -0500
Received: from mail.ispras.ru ([83.149.199.45]:37216)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1eZDKe-00017W-0t
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 05:10:04 -0500
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
References: <20171220100205.16625.84632.stgit@pasha-VirtualBox>	<003c01d38923$1c5157f0$54f407d0$@ru>
	<87efmz1ddp.fsf@secure.laptop>	<004301d38940$56013bb0$0203b310$@ru>
	<87zi5nyyap.fsf@secure.laptop>	<001601d389f6$0816d2f0$184478d0$@ru>
	<87d12iyrct.fsf@secure.laptop>
In-Reply-To: <87d12iyrct.fsf@secure.laptop>
Date: Wed, 10 Jan 2018 13:10:04 +0300
Message-ID: <001a01d389fb$2f33b1f0$8d9b15d0$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Language: ru
Subject: Re: [Qemu-devel] [PATCH v2] hpet: recover timer offset correctly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: quintela@redhat.com
Cc: 'Pavel Dovgalyuk' <Pavel.Dovgaluk@ispras.ru>, qemu-devel@nongnu.org, mst@redhat.com, dgilbert@redhat.com, maria.klimushenkova@ispras.ru, pbonzini@redhat.com



> -----Original Message-----
> From: Juan Quintela [mailto:quintela@redhat.com]
> Sent: Wednesday, January 10, 2018 12:51 PM
> To: Pavel Dovgalyuk
> Cc: 'Pavel Dovgalyuk'; qemu-devel@nongnu.org; mst@redhat.com; dgilbert@redhat.com;
> maria.klimushenkova@ispras.ru; pbonzini@redhat.com
> Subject: Re: [PATCH v2] hpet: recover timer offset correctly
> 
> "Pavel Dovgalyuk" <dovgaluk@ispras.ru> wrote:
> >> From: Juan Quintela [mailto:quintela@redhat.com]
> >> "Pavel Dovgalyuk" <dovgaluk@ispras.ru> wrote:
> >> >> From: Juan Quintela [mailto:quintela@redhat.com]
> >> If you *don't* use a needed function then please just increase the
> >> version.  You are just breaking compatibility anyways.  The whole point
> >> of subsections is that they are optional.  If they are mandatory (this
> >> case), then they bring no advantage at all.
> >
> > Thanks, I thought that the sections are skipped automatically when
> > there is no code for loading
> > them.
> >
> >> What dave is asked for your previous version is that you disable the
> >> section for old machine types.  Look at how to use DEFINE_PROP_* for
> >> this use case.
> >
> > How do you like this one?
> 
> Much better, thanks.
> 
> > +static bool hpet_offset_needed(void *opaque)
> > +{
> > +    HPETState *s = opaque;
> > +
> > +    return s->hpet_offset_saved;
> > +}
> > +
> 
> If this is only one optimization, this test is ok.  If it makes things
> go worse, you can add something there like && hpet_enabled() or
> whatever.  Remember that I don't understand HPET.

Right. Please check the new version of the patch.

> > diff --git a/include/hw/compat.h b/include/hw/compat.h
> > index 263de97..8897302 100644
> > --- a/include/hw/compat.h
> > +++ b/include/hw/compat.h
> > @@ -13,6 +13,10 @@
> >          .driver   = "virtio-tablet-device",\
> >          .property = "wheel-axis",\
> >          .value    = "false",\
> > +    },{\
> > +        .driver   = "hpet",\
> > +        .property = "hpet-offset-saved",\
> > +        .value    = "off",\
> >      },
> >
> >  #define HW_COMPAT_2_9 \
> 
> This should be on 2_11 not 2_10 O:-)
> 
> But for the vmstate bits:
> 
> Reviewed-by: Juan Quintela <quintela@redhat.com>

Thanks.

Pavel Dovgalyuk
