Received: from eggs.gnu.org ([209.51.188.92]:35166)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1grgiy-0000dg-5d
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 05:16:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1grgix-0002sl-AE
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 05:16:04 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:40955)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1grgiw-0002ro-V1
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 05:16:03 -0500
Received: by mail-wr1-x444.google.com with SMTP id q1so887437wrp.7
	for <qemu-devel@nongnu.org>; Thu, 07 Feb 2019 02:16:02 -0800 (PST)
MIME-Version: 1.0
References: <20190129062801.15799-1-pagupta@redhat.com>
	<CAJ+F1CKenN+Ujg1ajtgixwJabir5+zfBAV3r=4LBqodpqHd8iA@mail.gmail.com>
	<20190206162901.GW12331@redhat.com>
	<1385614518.70345867.1549524112156.JavaMail.zimbra@redhat.com>
	<CAJ+F1CKia-RCF=oDcKoLAQapD8pRYd4vXhztDspmww+bi-H-AQ@mail.gmail.com>
	<20190207093400.GB19438@redhat.com>
	<1487450667.70375757.1549534386311.JavaMail.zimbra@redhat.com>
In-Reply-To: <1487450667.70375757.1549534386311.JavaMail.zimbra@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 7 Feb 2019 11:15:49 +0100
Message-ID: <CAJ+F1CLbVsR12vavTBKi0rQjBQ+JaZuD_7Tpb5WqRthwn0uUhQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] chardev: Avoid adding duplicate chardev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pankaj Gupta <pagupta@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, QEMU <qemu-devel@nongnu.org>, xiaohli@redhat.com

Hi

On Thu, Feb 7, 2019 at 11:13 AM Pankaj Gupta <pagupta@redhat.com> wrote:
>
>
> > > > Thanks for your reply. Please find my reply inline.
> > > >
> > > > > > > Hotplugging existing char chardev with qmp, dereferences(remo=
ves)
> > > > > > > existing chardev. This patch avoids adding a chardev if a cha=
rdev
> > > > > > > with same id exists.
> > > > > >
> > > > > > As you pointed out, if you attempt to add a chardev with an exi=
sting
> > > > > > ID, you get an error:
> > > > > >
> > > > > > {"execute":"chardev-add","arguments":{"id":"charchannel1","back=
end":{"type":"socket","data":{"addr":{"type":"unix",
> > > > > > "data": {"path": "/tmp/helloworld1"}}}}}}
> > > > > > {"return": {}}
> > > > > > {"execute":"chardev-add","arguments":{"id":"charchannel1","back=
end":{"type":"socket","data":{"addr":{"type":"unix",
> > > > > > "data": {"path": "/tmp/helloworld1"}}}}}}
> > > > > > {"error": {"class": "GenericError", "desc": "attempt to add dup=
licate
> > > > > > property 'charchannel1' to object (type 'container')"}}
> > > > > >
> > > > > >
> > > > > > But the existing chardev is left untouched.
> > > > > >
> > > > > > However, since unix socket chardev will delete existing file an=
d
> > > > > > rebind (this is not always a good idea, but people seem to pref=
er
> > > > > > that)
> > > > > > the rebound socket is removed on error cleanup.
> > > > > >
> > > > > >
> > > > > > I am not sure this is a bug tbh.
> > > > > >
> > > > > > Your solution to check for duplicate ID upfront is ok. But any =
other
> > > > > > later error path could have the same "bug" effect of removing
> > > > > > existing
> > > > > > chardev because of the overwrite socket creation.
> > > > >
> > > > > Checking the ID is not a useful fix IMHO. Someone could just as e=
asily
> > > > > send 2 commands with different IDs and the same socket path.
> > > > >
> > > > > A more accurate fix would be to iterate over existing chardevs an=
d
> > > > > check
> > > > > whether any of them clash, but even that is useless if you have t=
wo
> > > > > separate QEMU instances and both try to use the same UNIX socket =
path.
> > > > > To deal with that you need to start taking out fcntl locks to ens=
ure
> > > > > real mutual exclusion.
> > > >
> > > > The reason we are already throwing error "attempt to add duplicate
> > > > property"
> > > > implies we are considering "id" as primary key? Even if we throw th=
e
> > > > error
> > > > existing chardev should work as before. But this is not the case ri=
ght
> > > > now,
> > > > it just deletes the existing chardev after error.
> > >
> > > It deletes the socket "file" (since it overwrites it on chardev
> > > creation). The existing chardev is not deleted:
> >
> > I think this is yet another example of why it is a bad idea for the
> > qemu_chardev_new API to also open the backend. We should have a
> > qemu_chardev_new that only does the arg parsing, object creation
> > and registration. Then have a separate API for actually opening
> > it.
>
> Agree. This looks bigger fix. Till we fix that. Can we accept this patch
> to avoid deleting/corrupting existing socket "file" if user tries to add
> chardev with existing same "id"?

It's not a proper fix. As I and Daniel explained, there are many other
cases where a similar effect of deleting existing socket file can
happen.

I would rather not merge this, but if it's critical, I would add a
FIXME comment around.


--=20
Marc-Andr=C3=A9 Lureau
