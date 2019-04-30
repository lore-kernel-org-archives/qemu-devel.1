Received: from eggs.gnu.org ([209.51.188.92]:39742)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hLUKe-00007i-TL
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 11:06:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hLUKc-0005vn-WA
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 11:06:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51030)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hLUKb-0005tM-1e
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 11:06:06 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 12E97C057F9C
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 15:06:04 +0000 (UTC)
Date: Tue, 30 Apr 2019 16:05:56 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190430150556.GA2423@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190430131919.GN6818@redhat.com> <20190430144546.GA3065@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190430144546.GA3065@work-vm>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] QMP; unsigned 64-bit ints;
 JSON standards compliance
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, libvir-list@redhat.com, =?utf-8?Q?J=C3=A1n?= Tomko <jtomko@redhat.com>, Markus Armbruster <armbru@redhat.com>

On Tue, Apr 30, 2019 at 03:45:46PM +0100, Dr. David Alan Gilbert wrote:
> * Daniel P. Berrang=C3=A9 (berrange@redhat.com) wrote:
> > The QEMU  QMP service is based on JSON which is nice because that is =
a
> > widely supported "standard" data format.....
> >=20
> > ....except QEMU's implementation (and indeed most impls) are not stri=
ctly
> > standards compliant.
> >=20
> > Specifically the problem is around representing 64-bit integers, whet=
her
> > signed or unsigned.
> >=20
> > The JSON standard declares that largest integer is 2^53-1 and the
> > likewise the smallest is -(2^53-1):
> >=20
> >   http://www.ecma-international.org/ecma-262/6.0/index.html#sec-numbe=
r.max_safe_integer
> >=20
> > A crazy limit inherited from its javascript origins IIUC.
>=20
> Ewwww.

Looking a bit deeper it seems this limit comes from the use of double
precision floating point for storing integers. 2^53-1 is the largest
integer value that can be stored in a 64-bit float without loss of
precision.

The Golang JSON parser decodes JSON numbers to float64 by default so
will have this precision limitation too, though at least they provide
a backdoor for custom parsing from the original serialized representation=
.

> > QEMU, and indeed many applications, want to handle 64-bit integers.
> > The C JSON library impls have traditionally mapped integers to the
> > data type 'long long int' which gives a min/max of  -(2^63) / 2^63-1.
> >=20
> > QEMU however /really/ needs 64-bit unsigned integers, ie a max 2^64-1=
.
> >=20
> > Libvirt has historically used the YAJL library which uses 'long long =
int'
> > and thus can't officially go beyond 2^63-1 values. Fortunately it let=
s
> > libvirt get at the raw json string, so libvirt can re-parse the value
> > to get an 'unsigned long long'.
> >=20
> > We recently tried to switch to Jansson because YAJL has a dead upstre=
am
> > for many years and countless unanswered bugs & patches. Unfortunately=
 we
> > forgot about this need for 2^64-1 max, and Jansson also uses 'long lo=
ng int'
> > and raises a fatal parse error for unsigned 64-bit values above 2^63-=
1. It
> > also provides no backdoor for libvirt todo its own integer parsing. T=
hus
> > we had to abort our switch to jansson as it broke parsing QEMU's JSON=
:
> >=20
> >   https://bugzilla.redhat.com/show_bug.cgi?id=3D1614569
> >=20
> > Other JSON libraries we've investigated have similar problems. I imag=
ine
> > the same may well be true of non-C based JOSN impls, though I've not
> > investigated in any detail.
> >=20
> > Essentially libvirt is stuck with either using the dead YAJL library
> > forever, or writing its own JSON parser (most likely copying QEMU's
> > JSON code into libvirt's git).
> >=20
> > This feels like a very unappealing situation to be in as not being
> > able to use a JSON library of our choice is loosing one of the key
> > benefits of using a standard data format.
> >=20
> > Thus I'd like to see a solution to this to allow QMP to be reliably
> > consumed by any JSON library that exists.
> >=20
> > I can think of some options:
> >=20
> >   1. Encode unsigned 64-bit integers as signed 64-bit integers.
> >=20
> >      This follows the example that most C libraries map JSON ints
> >      to 'long long int'. This is still relying on undefined
> >      behaviour as apps don't need to support > 2^53-1.
> >=20
> >      Apps would need to cast back to 'unsigned long long' for
> >      those QMP fields they know are supposed to be unsigned.
> >=20
> >=20
> >   2. Encode all 64-bit integers as a pair of 32-bit integers.
> >    =20
> >      This is fully compliant with the JSON spec as each half
> >      is fully within the declared limits. App has to split or
> >      assemble the 2 pieces from/to a signed/unsigned 64-bit
> >      int as needed.
> >=20
> >=20
> >   3. Encode all 64-bit integers as strings
> >=20
> >      The application has todo all parsing/formatting client
> >      side.
> >=20
> >=20
> > None of these changes are backwards compatible, so I doubt we could m=
ake
> > the change transparently in QMP.  Instead we would have to have a
> > QMP greeting message capability where the client can request enableme=
nt
> > of the enhanced integer handling.
> >=20
> > Any of the three options above would likely work for libvirt, but I
> > would have a slight preference for either 2 or 3, so that we become
> > 100% standards compliant.
>=20
> My preference would be 3 with the strings defined as being
> %x lower case hex formated with a 0x prefix and no longer than 18 chara=
cters
> ("0x" + 16 nybbles). Zero padding allowed but not required.
> It's readable and unambiguous when dealing with addresses; I don't want
> to have to start decoding (2) by hand when debugging.

Yep, that's a good point about readability.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
