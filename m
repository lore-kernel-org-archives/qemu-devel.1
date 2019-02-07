Received: from eggs.gnu.org ([209.51.188.92]:50779)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1grfii-0002K0-W0
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 04:11:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1grfih-0003Uq-QT
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 04:11:45 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:42205)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1grfih-0003UP-KX
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 04:11:43 -0500
Received: by mail-wr1-x442.google.com with SMTP id q18so10613766wrx.9
	for <qemu-devel@nongnu.org>; Thu, 07 Feb 2019 01:11:43 -0800 (PST)
MIME-Version: 1.0
References: <20190129062801.15799-1-pagupta@redhat.com>
	<CAJ+F1CKenN+Ujg1ajtgixwJabir5+zfBAV3r=4LBqodpqHd8iA@mail.gmail.com>
	<20190206162901.GW12331@redhat.com>
	<1385614518.70345867.1549524112156.JavaMail.zimbra@redhat.com>
In-Reply-To: <1385614518.70345867.1549524112156.JavaMail.zimbra@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 7 Feb 2019 10:11:29 +0100
Message-ID: <CAJ+F1CKia-RCF=oDcKoLAQapD8pRYd4vXhztDspmww+bi-H-AQ@mail.gmail.com>
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
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, QEMU <qemu-devel@nongnu.org>, xiaohli@redhat.com, Paolo Bonzini <pbonzini@redhat.com>

Hi

On Thu, Feb 7, 2019 at 8:21 AM Pankaj Gupta <pagupta@redhat.com> wrote:
>
>
> Hi Daniel, Marc-Andre,
>
> Thanks for your reply. Please find my reply inline.
>
> > > > Hotplugging existing char chardev with qmp, dereferences(removes)
> > > > existing chardev. This patch avoids adding a chardev if a chardev
> > > > with same id exists.
> > >
> > > As you pointed out, if you attempt to add a chardev with an existing
> > > ID, you get an error:
> > >
> > > {"execute":"chardev-add","arguments":{"id":"charchannel1","backend":{=
"type":"socket","data":{"addr":{"type":"unix",
> > > "data": {"path": "/tmp/helloworld1"}}}}}}
> > > {"return": {}}
> > > {"execute":"chardev-add","arguments":{"id":"charchannel1","backend":{=
"type":"socket","data":{"addr":{"type":"unix",
> > > "data": {"path": "/tmp/helloworld1"}}}}}}
> > > {"error": {"class": "GenericError", "desc": "attempt to add duplicate
> > > property 'charchannel1' to object (type 'container')"}}
> > >
> > >
> > > But the existing chardev is left untouched.
> > >
> > > However, since unix socket chardev will delete existing file and
> > > rebind (this is not always a good idea, but people seem to prefer
> > > that)
> > > the rebound socket is removed on error cleanup.
> > >
> > >
> > > I am not sure this is a bug tbh.
> > >
> > > Your solution to check for duplicate ID upfront is ok. But any other
> > > later error path could have the same "bug" effect of removing existin=
g
> > > chardev because of the overwrite socket creation.
> >
> > Checking the ID is not a useful fix IMHO. Someone could just as easily
> > send 2 commands with different IDs and the same socket path.
> >
> > A more accurate fix would be to iterate over existing chardevs and chec=
k
> > whether any of them clash, but even that is useless if you have two
> > separate QEMU instances and both try to use the same UNIX socket path.
> > To deal with that you need to start taking out fcntl locks to ensure
> > real mutual exclusion.
>
> The reason we are already throwing error "attempt to add duplicate proper=
ty"
> implies we are considering "id" as primary key? Even if we throw the erro=
r
> existing chardev should work as before. But this is not the case right no=
w,
> it just deletes the existing chardev after error.

It deletes the socket "file" (since it overwrites it on chardev
creation). The existing chardev is not deleted:

qemu-system-x86_64 -qmp stdio
{"QMP": {"version": {"qemu": {"micro": 0, "minor": 0, "major": 3},
"package": "qemu-3.0.0-3.fc29"}, "capabilities": []}}
{"execute":"qmp_capabilities"}
{"return": {}}
 {"execute":"chardev-add","arguments":{"id":"charchannel1","backend":{"type=
":"socket","data":{"addr":{"type":"unix",
"data": {"path": "/tmp/helloworld1"}}}}}}
{"return": {}}
{"execute":"chardev-add","arguments":{"id":"charchannel1","backend":{"type"=
:"socket","data":{"addr":{"type":"unix",
"data": {"path": "/tmp/helloworld1"}}}}}}
{"error": {"class": "GenericError", "desc": "attempt to add duplicate
property 'charchannel1' to object (type 'container')"}}
{"execute":"query-chardev"}
{"return": [{"frontend-open": true, "filename": "vc", "label":
"serial0"}, {"frontend-open": true, "filename": "stdio", "label":
"compat_monitor0"}, {"frontend-open": false, "filename":
"disconnected:unix:/tmp/helloworld1,server", "label": "charchannel1"},
{"frontend-open": true, "filename": "vc", "label": "parallel0"}]}


>
> Thanks,
> Pankaj
>
> >
> > I think I'd really just call this user error and do nothing
> >
> > Regards,
> > Daniel
> > --
> > |: https://berrange.com      -o-    https://www.flickr.com/photos/dberr=
ange
> > |:|
> > |: https://libvirt.org         -o-            https://fstop138.berrange=
.com
> > |:|
> > |: https://entangle-photo.org    -o-    https://www.instagram.com/dberr=
ange
> > |:|
> >



--=20
Marc-Andr=C3=A9 Lureau
