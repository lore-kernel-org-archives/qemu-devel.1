Received: from eggs.gnu.org ([2001:4830:134:3::10]:43632)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dlWXi-00041o-Ht
	for qemu-devel@nongnu.org; Sat, 26 Aug 2017 04:34:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dlWXh-0004Li-BP
	for qemu-devel@nongnu.org; Sat, 26 Aug 2017 04:34:10 -0400
Received: from mail-vk0-x234.google.com ([2607:f8b0:400c:c05::234]:37345)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dlWXh-0004Kn-6A
	for qemu-devel@nongnu.org; Sat, 26 Aug 2017 04:34:09 -0400
Received: by mail-vk0-x234.google.com with SMTP id q189so5189814vke.4
	for <qemu-devel@nongnu.org>; Sat, 26 Aug 2017 01:34:07 -0700 (PDT)
MIME-Version: 1.0
References: <1503471071-2233-1-git-send-email-peterx@redhat.com>
	<1503471071-2233-3-git-send-email-peterx@redhat.com>
	<CAJ+F1CKvY9iMtTQSrM2xVUwXYb0pcHjtFf8x4xpxG5ke-FPf3g@mail.gmail.com>
	<20170825153304.GJ2090@work-vm>
	<CAJ+F1CJR3UWv4zaGg_6aAyC7WWsVd35=UiRWyWkbGm-gEN2O9A@mail.gmail.com>
	<20170825161221.GM2090@work-vm>
	<CAJ+F1CLURZ8JqRKzCHX+xgq6XW5GL=Th4m3CH2j6OYgupiRGbw@mail.gmail.com>
	<20170825162923.GN2090@work-vm>
In-Reply-To: <20170825162923.GN2090@work-vm>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Sat, 26 Aug 2017 08:33:56 +0000
Message-ID: <CAJ+F1C+XdP6OFzpHQf=6_W09r_q0ktKBYmtoJm0wBUEESYA9og@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC v2 2/8] monitor: allow monitor to create
 thread to poll
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>, mdroth@linux.vnet.ibm.com, Paolo Bonzini <pbonzini@redhat.com>

Hi

On Fri, Aug 25, 2017 at 6:29 PM Dr. David Alan Gilbert <dgilbert@redhat.com=
>
wrote:

> * Marc-Andr=C3=A9 Lureau (marcandre.lureau@gmail.com) wrote:
> > > In (2),  info cpus
> > > > shouldn't keep the BQL (my qapi-async series would probably help
> here)
> > >
> > > How does that work?
> > >
> > >
> > https://lists.gnu.org/archive/html/qemu-devel/2017-01/msg03626.html
> >
> > With the series, a command can be broken up in receive/start &
> > finish/reply. This allows to reenter the loop, potentially freeing the
> BQL,
> > and process other events. This allowed me to fix a screendump glitch bu=
g
> (
> > http://lists.gnu.org/archive/html/qemu-devel/2017-01/msg03650.html).
> This
> > also open the door to concurrent QMP commands (if the client turns on t=
he
> > capability option).
>
> Interesting.
> I can see how that would work well for commands that know they're long
> lived and do that work to split themselves into
> receive/start/finish/reply.  However I'm worried that it means that
> it's fragile in that if something accesses guest memory when they din't
> realise they were doing, or code that forgot it's taking the lock, then
> we've got a command that can occasionally block.  That's going to be a
> lot of analysis and design on each command and if we were to do it
> widely then we'd certainly miss some cases.  Having the monitors in
> spearate threads means you only have to worry about the commands
> you want to be lock-free.
>

Well the concurrency problems are essentially similar in both cases, but I
would argue that avoiding parallelism is easier to deal with. My approach
is also very conservative, only commands that are "async-free" are broken
up, so you mostly have to worry about those regarding concurrency. But with
a seperate thread, you have additional concerns, since you may run while
the BQL is taken somewhere else.

--=20
Marc-Andr=C3=A9 Lureau
