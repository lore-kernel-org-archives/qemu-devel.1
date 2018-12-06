Received: from eggs.gnu.org ([2001:4830:134:3::10]:59140)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gUpuH-0001Yp-07
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 04:25:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gUpu8-0005m3-4N
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 04:25:15 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:34942)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1gUpu2-0005l9-P5
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 04:25:04 -0500
Received: by mail-qt1-f194.google.com with SMTP id v11so25541323qtc.2
	for <qemu-devel@nongnu.org>; Thu, 06 Dec 2018 01:25:01 -0800 (PST)
MIME-Version: 1.0
References: <20181205203737.9011-1-marcandre.lureau@redhat.com>
	<20181205203737.9011-5-marcandre.lureau@redhat.com>
	<87bm5zkx0o.fsf@dusky.pond.sub.org>
	<CAMxuvazPAjrEt2nyEVSwsVhap-dEGGXSa-N1GcdgK-UuhMfN+Q@mail.gmail.com>
	<87tvjrhvb4.fsf@dusky.pond.sub.org>
In-Reply-To: <87tvjrhvb4.fsf@dusky.pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 6 Dec 2018 13:24:49 +0400
Message-ID: <CAMxuvawvii_FQCaZLAhrOmKZsVRZCbQw1Q67=wuajH1idszt9w@mail.gmail.com>
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

On Thu, Dec 6, 2018 at 1:13 PM Markus Armbruster <armbru@redhat.com> wrote:
>
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>
> > Hi
> > On Thu, Dec 6, 2018 at 10:08 AM Markus Armbruster <armbru@redhat.com> w=
rote:
> >>
> >> One more question...
> >>
> >> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
> >>
> >> > Not all backends are able to switch gcontext. Those backends cannot
> >> > drive a OOB monitor (the monitor would then be blocking on main
> >> > thread).
> >> >
> >> > For example, ringbuf, spice, or more esoteric input chardevs like
> >> > braille or MUX.
> >>
> >> These chardevs don't provide QEMU_CHAR_FEATURE_GCONTEXT.
> >>
> >> > We currently forbid MUX because not all frontends are ready to run
> >> > outside main loop. Extend to add a context-switching feature check.
> >>
> >> Why check CHARDEV_IS_MUX() when chardev-mux already fails the
> >> qemu_char_feature_gcontext(chr, QEMU_CHAR_FEATURE_GCONTEXT) check?
> >>
> >
> >
> > It currently fails, but with "[PATCH 4/9] char: update the mux
> > hanlders in class callback", it won't.
>
> That's because it makes chardev-mux implement chr_update_read_handler(),
> and "[PATCH 3/7] char: add a QEMU_CHAR_FEATURE_GCONTEXT flag" assumes
> that a chardev implementing that "will take the updated gcontext into
> account".
>
> Sounds to me as if "[PATCH 4/9] char: update the mux hanlders in class
> callback" violates that assumption.  Why am I wrong?

The mux should be gcontext-feature neutral, or it should in fact
reflects the backend capability, since it is entirely driven by it.

For now, it is simpler to keep it mark as unsupport, and I'll probably
update the aforementioned patch when resubmitting.

> > But the main reason to keep an explicit check on mux is that the
> > monitor frontend doesn't know if other mux frontends can be called
> > from any context (when you set a context, it is set on the backend
> > side, events are dispatched by the backend).
> >
> > We may want to mix this extra frontend-side capability limitation with
> > FEATURE_GCONTEXT flag, but they are fundamentally different: to be
> > able to set a backend context VS attached mux frontends can be
> > dispatched from any context.
>
> I'm afraid I can't yet see the full picture.
>
> The goal of this series PATCH 3-5 is to catch certain thread-related
> badness in chardevs before it can happen.

Yes, as the context is associated with a thread. If a backend is not
able to switch context, it will keep dispatching in the default
context, which may have undesirable results for the frontend.

>
> Apparently, there are two separate kinds of badness:
>
> * The chardev backend may fail to cope with changed gcontext.  I don't
>   understand how exactly the backends screw up, but I doubt I have to
>   right now.
>
> * The chardev frontend may fail to... what exactly?  And why is only
>   chardev-mux affected?

For some reason, the chardev API let the frontend decide which context
should be used for the dispatch.

This is quite fine when you have a one-to-one relationship between
backend and frontend (as long as the backend complies with context
switching, ie FEATURE_GCONTEXT).

But in a one-to-many, as is the case with MUX, things get more
complicated, because one frontend may want to switch the context
(typically an oob monitor, moving dispatch to the iothread) while
another frontend (typically, a serial device) may not expect to be
dispatched from a different thread than the default thread.

As you can see, MUX has two problems wrt context switching: backend
and frontends. I think it would be safer to mark MUX as
!FEATURE_GCONTEXT (although in fact, you could use it if you really
now what you do with backend & frontends)

>
> [...]
