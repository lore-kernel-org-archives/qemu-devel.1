Received: from eggs.gnu.org ([2001:4830:134:3::10]:55188)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gJZKQ-0006dA-TU
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 02:29:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gJZKM-0007s8-40
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 02:29:42 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:38581)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1gJZK8-0007RA-4b
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 02:29:29 -0500
Received: by mail-qk1-f194.google.com with SMTP id d19so13064287qkg.5
	for <qemu-devel@nongnu.org>; Sun, 04 Nov 2018 23:29:22 -0800 (PST)
MIME-Version: 1.0
References: <0084f7223c080cdbdfc2c5a2d132f8d6c0eff866.1541083966.git.artem.k.pisarenko@gmail.com>
	<CAMxuvazxmYdvn_0aTH0ETt_Eeo7rxCLXvZ_oANfcKhgGW92+ng@mail.gmail.com>
	<CANzW0mspj-xxYw5qXLvnQp-uNdLwJ+ztU2Ho-fR10_VXKQVkjw@mail.gmail.com>
In-Reply-To: <CANzW0mspj-xxYw5qXLvnQp-uNdLwJ+ztU2Ho-fR10_VXKQVkjw@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 5 Nov 2018 11:29:10 +0400
Message-ID: <CAMxuvaz7bQBqRZGkHsYB1hRhWn5mZ5KNuHRRnESbni36On=B6A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] chardev: fix mess in OPENED/CLOSED events
 when muxed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: artem.k.pisarenko@gmail.com
Cc: qemu-devel <qemu-devel@nongnu.org>, "Bonzini, Paolo" <pbonzini@redhat.com>

Hi
On Mon, Nov 5, 2018 at 11:22 AM Artem Pisarenko
<artem.k.pisarenko@gmail.com> wrote:
>
> Sorry, I forgot to check unit tests. Although, it's very strange that this specific test failed while things work functionally...
>
> > I am a bit reluctant to take patches that don't actually "fix" things.
> >
> > Could you add some tests to demonstrate the problems?
>
> Ok
>
> >> @@ -257,6 +257,7 @@ void qemu_chr_fe_set_handlers(CharBackend *b,
> >>  {
> >>      Chardev *s;
> >>      int fe_open;
> >> +    static __thread bool mux_reentered;
> >
> > Not very elegant. Maybe mux_chr_set_handlers() could call a refactored
> > internal chr_fe_set_handlers() with an extra arg "no_open_event" ?
>
> Agree. It would make this hack more elegant. Although, it may become irrelevant as soon as I'll find soultion for failed docker test...
>
> >> @@ -272,21 +272,24 @@ static void char_mux_finalize(Object *obj)
> >>      for (i = 0; i < d->mux_cnt; i++) {
> >>          CharBackend *be = d->backends[i];
> >>          if (be) {
> >> +            if (be->chr && be->chr->be_open) {
> >> +                qemu_chr_be_event(be->chr, CHR_EVENT_CLOSED);
> >> +            }
> >
> > It looks like this could be a seperate patch, with a seperate test.
>
> Why this should be separate ? Do you mean that overall "opened/closed" pairing fix should be separated to "opened" fix+test and "closed" fix+test ?
>
> Since in next version it cannot be single patch anymore, how should I proceed with it ? Should I publish it as patch series with same subject marked as V2 or start new patch series?

A patch series would be great. You can keep the subject and make it v2.

thanks
