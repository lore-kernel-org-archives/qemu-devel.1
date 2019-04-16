Received: from eggs.gnu.org ([209.51.188.92]:39163)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hGJmA-0001TY-MK
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 04:49:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hGJm9-0006cW-Ih
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 04:49:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42444)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hGJm9-0006c7-99
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 04:49:09 -0400
Date: Tue, 16 Apr 2019 09:48:56 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190416084856.GE31311@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190415154503.6758-1-berrange@redhat.com>
	<83042152-1af4-a237-92a1-f56841623e89@redhat.com>
	<CAFEAcA9ndqdFv8hkMhjVudbajTDLZtcu7rpSdR5OFiqiJtp1bg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA9ndqdFv8hkMhjVudbajTDLZtcu7rpSdR5OFiqiJtp1bg@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-4.0? 0/3] usb-mtp: fix ObjectInfo
 request handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Eric Blake <eblake@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>, Greg Kurz <groug@kaod.org>, Bandan Das <bsd@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

On Mon, Apr 15, 2019 at 06:18:01PM +0100, Peter Maydell wrote:
> On Mon, 15 Apr 2019 at 18:10, Eric Blake <eblake@redhat.com> wrote:
> > On 4/15/19 10:45 AM, Daniel P. Berrang=C3=A9 wrote:
> > > The 2nd patch in this series is a security flaw fix since the
> > > code was not correctly validating guest provided data length.
> >
> > Given that this is a security flaw, I've added this series to
> > https://wiki.qemu.org/Planning/4.0 in case you're hoping to get it in=
 -rc4.
>=20
> What are the consequences of the flaw ? IIRC it's only one
> extra byte read?

No, it is arbitrary extra bytes read.  We have a USB packet N bytes in
length, where N is supposed to match

  sizeof(ObjectInfo) + (ObjectInfo.length * 2)

but we checked it against

  sizeof(ObjectInfo) + ObjectInfo.length

As a result a malicious value for ObjectInfo.length can make QEMU can
read  ObjectInfo.length too many bytes when converting the string from
UTF16 to UTF8.

IOW, the returned UTF-8 string will end with whatever data is next on
the heap. This in turn creates a filename on disk with this random
data. I don't think this is a serious problem though, because if you
have enabled write support you've already given the guest ermission
to create arbitrary named files, so I don't see what they gain by
trying to exploit this. We already outlaw "/" which is the main danger
point in guest provided filenames.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
