Received: from eggs.gnu.org ([2001:4830:134:3::10]:40351)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gUqNm-0003sS-51
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 04:55:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gUqNh-0005TM-60
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 04:55:46 -0500
Received: from mail-qk1-f179.google.com ([209.85.222.179]:40524)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1gUqNh-0005Sm-0o
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 04:55:41 -0500
Received: by mail-qk1-f179.google.com with SMTP id y16so13660599qki.7
	for <qemu-devel@nongnu.org>; Thu, 06 Dec 2018 01:55:40 -0800 (PST)
MIME-Version: 1.0
References: <20181205203737.9011-1-marcandre.lureau@redhat.com>
	<20181205203737.9011-5-marcandre.lureau@redhat.com>
	<87bm5zkx0o.fsf@dusky.pond.sub.org>
	<CAMxuvazPAjrEt2nyEVSwsVhap-dEGGXSa-N1GcdgK-UuhMfN+Q@mail.gmail.com>
	<87tvjrhvb4.fsf@dusky.pond.sub.org>
	<CAMxuvawvii_FQCaZLAhrOmKZsVRZCbQw1Q67=wuajH1idszt9w@mail.gmail.com>
	<87h8frhu5s.fsf@dusky.pond.sub.org>
In-Reply-To: <87h8frhu5s.fsf@dusky.pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 6 Dec 2018 13:55:28 +0400
Message-ID: <CAMxuvayaPzLrPrmv=-EoTfws3_5rj5HYjqX9hd6mFA5xfhDbKg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-4.0 v4 4/7] monitor: check if chardev
 can switch gcontext for OOB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Armbruster, Markus" <armbru@redhat.com>
Cc: lizhijian@cn.fujitsu.com, Jason Wang <jasowang@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Peter Xu <peterx@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, zhangckid@gmail.com, "Bonzini, Paolo" <pbonzini@redhat.com>

Hi
On Thu, Dec 6, 2018 at 1:38 PM Markus Armbruster <armbru@redhat.com> wrote:
>
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>
> > Hi
> >
> > On Thu, Dec 6, 2018 at 1:13 PM Markus Armbruster <armbru@redhat.com> wr=
ote:
> >>
> >> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
> >>
> >> > Hi
> >> > On Thu, Dec 6, 2018 at 10:08 AM Markus Armbruster <armbru@redhat.com=
> wrote:
> >> >>
> >> >> One more question...
> >> >>
> >> >> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
> >> >>
> >> >> > Not all backends are able to switch gcontext. Those backends cann=
ot
> >> >> > drive a OOB monitor (the monitor would then be blocking on main
> >> >> > thread).
> >> >> >
> >> >> > For example, ringbuf, spice, or more esoteric input chardevs like
> >> >> > braille or MUX.
> >> >>
> >> >> These chardevs don't provide QEMU_CHAR_FEATURE_GCONTEXT.
> >> >>
> >> >> > We currently forbid MUX because not all frontends are ready to ru=
n
> >> >> > outside main loop. Extend to add a context-switching feature chec=
k.
> >> >>
> >> >> Why check CHARDEV_IS_MUX() when chardev-mux already fails the
> >> >> qemu_char_feature_gcontext(chr, QEMU_CHAR_FEATURE_GCONTEXT) check?
> >> >>
> >> >
> >> >
> >> > It currently fails, but with "[PATCH 4/9] char: update the mux
> >> > hanlders in class callback", it won't.
> >>
> >> That's because it makes chardev-mux implement chr_update_read_handler(=
),
> >> and "[PATCH 3/7] char: add a QEMU_CHAR_FEATURE_GCONTEXT flag" assumes
> >> that a chardev implementing that "will take the updated gcontext into
> >> account".
> >>
> >> Sounds to me as if "[PATCH 4/9] char: update the mux hanlders in class
> >> callback" violates that assumption.  Why am I wrong?
> >
> > The mux should be gcontext-feature neutral, or it should in fact
> > reflects the backend capability, since it is entirely driven by it.
>
> Yes, that makes sense.
>
> > For now, it is simpler to keep it mark as unsupport, and I'll probably
> > update the aforementioned patch when resubmitting.
>
> Okay.
>
> >> > But the main reason to keep an explicit check on mux is that the
> >> > monitor frontend doesn't know if other mux frontends can be called
> >> > from any context (when you set a context, it is set on the backend
> >> > side, events are dispatched by the backend).
> >> >
> >> > We may want to mix this extra frontend-side capability limitation wi=
th
> >> > FEATURE_GCONTEXT flag, but they are fundamentally different: to be
> >> > able to set a backend context VS attached mux frontends can be
> >> > dispatched from any context.
> >>
> >> I'm afraid I can't yet see the full picture.
> >>
> >> The goal of this series PATCH 3-5 is to catch certain thread-related
> >> badness in chardevs before it can happen.
> >
> > Yes, as the context is associated with a thread. If a backend is not
> > able to switch context, it will keep dispatching in the default
> > context, which may have undesirable results for the frontend.
> >
> >>
> >> Apparently, there are two separate kinds of badness:
> >>
> >> * The chardev backend may fail to cope with changed gcontext.  I don't
> >>   understand how exactly the backends screw up, but I doubt I have to
> >>   right now.
> >>
> >> * The chardev frontend may fail to... what exactly?  And why is only
> >>   chardev-mux affected?
> >
> > For some reason, the chardev API let the frontend decide which context
> > should be used for the dispatch.
> >
> > This is quite fine when you have a one-to-one relationship between
> > backend and frontend (as long as the backend complies with context
> > switching, ie FEATURE_GCONTEXT).
> >
> > But in a one-to-many, as is the case with MUX, things get more
> > complicated, because one frontend may want to switch the context
> > (typically an oob monitor, moving dispatch to the iothread) while
> > another frontend (typically, a serial device) may not expect to be
> > dispatched from a different thread than the default thread.
> >
> > As you can see, MUX has two problems wrt context switching: backend
> > and frontends.
>
> Thanks, that helped some.
>
> >                I think it would be safer to mark MUX as
> > !FEATURE_GCONTEXT (although in fact, you could use it if you really
> > now what you do with backend & frontends)
>
> There's no pressing need for a smarter chardev-mux that provides
> FEATURE_GCONTEXT in cases where it's safe.  Simply not providing it at
> all is good enough.
>
> Testing CHARDEV_IS_MUX() in addition to FEATURE_GCONTEXT is then
> redundant.
>
> This makes me think we should drop the CHARDEV_IS_MUX() check from
> monitor_init(), and update the commit message to say
>
>     We already forbid MUX because not all frontends are ready to run outs=
ide
>     main loop.  Replace that by a context-switching feature check.
>
> What do you think?

ack, can you do that on commit?

thanks
