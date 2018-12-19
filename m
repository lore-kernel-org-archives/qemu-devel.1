Received: from eggs.gnu.org ([2001:4830:134:3::10]:44480)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmathieu@redhat.com>) id 1gZY3X-0004qS-Dc
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 04:22:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmathieu@redhat.com>) id 1gZY3T-0003Vo-D0
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 04:22:19 -0500
Received: from mail-wm1-f45.google.com ([209.85.128.45]:51580)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pmathieu@redhat.com>) id 1gZY3T-0003Ue-4g
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 04:22:15 -0500
Received: by mail-wm1-f45.google.com with SMTP id b11so5243876wmj.1
	for <qemu-devel@nongnu.org>; Wed, 19 Dec 2018 01:22:15 -0800 (PST)
MIME-Version: 1.0
References: <20181218175122.3229-1-philmd@redhat.com>
	<20181218175122.3229-3-philmd@redhat.com>
	<20181218180846-mutt-send-email-mst@kernel.org>
In-Reply-To: <20181218180846-mutt-send-email-mst@kernel.org>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Date: Wed, 19 Dec 2018 10:22:02 +0100
Message-ID: <CAP+75-WkYZ0SojSEUHUUJeG5KCU=3wVk9wvnxvHFHOCXSNqL0A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 2/5] block/sheepdog: Use QEMU_NONSTRING
 for non NUL-terminated arrays
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Juan Quintela <quintela@redhat.com>, qemu-block@nongnu.org, 1803872@bugs.launchpad.net, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Howard Spoelstra <hsp.cat7@gmail.com>, Jeff Cody <jcody@redhat.com>, David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Weil <sw@weilnetz.de>, Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, Ben Pye <ben@curlybracket.co.uk>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, Thomas Huth <thuth@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Liu Yuan <namei.unix@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Max Reitz <mreitz@redhat.com>

Le mer. 19 d=C3=A9c. 2018 00:09, Michael S. Tsirkin <mst@redhat.com> a =C3=
=A9crit :

> On Tue, Dec 18, 2018 at 06:51:19PM +0100, Philippe Mathieu-Daud=C3=A9 wro=
te:
> > GCC 8 added a -Wstringop-truncation warning:
> >
> >   The -Wstringop-truncation warning added in GCC 8.0 via r254630 for
> >   bug 81117 is specifically intended to highlight likely unintended
> >   uses of the strncpy function that truncate the terminating NUL
> >   character from the source string.
> >
> > This new warning leads to compilation failures:
> >
> >     CC      block/sheepdog.o
> >   qemu/block/sheepdog.c: In function 'find_vdi_name':
> >   qemu/block/sheepdog.c:1239:5: error: 'strncpy' specified bound 256
> equals destination size [-Werror=3Dstringop-truncation]
> >        strncpy(buf + SD_MAX_VDI_LEN, tag, SD_MAX_VDI_TAG_LEN);
> >        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >   make: *** [qemu/rules.mak:69: block/sheepdog.o] Error 1
> >
> > As described previous to the strncpy() calls, the use of strncpy() is
> > correct here:
> >
> >     /* This pair of strncpy calls ensures that the buffer is zero-fille=
d,
> >      * which is desirable since we'll soon be sending those bytes, and
> >      * don't want the send_req to read uninitialized data.
> >      */
> >     strncpy(buf, filename, SD_MAX_VDI_LEN);
> >     strncpy(buf + SD_MAX_VDI_LEN, tag, SD_MAX_VDI_TAG_LEN);
> >
> > Use the QEMU_NONSTRING attribute, since this array is intended to store
> > character arrays that do not necessarily contain a terminating NUL.
> >
> > Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> > ---
> >  block/sheepdog.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/block/sheepdog.c b/block/sheepdog.c
> > index 0125df9d49..d4ad6b119d 100644
> > --- a/block/sheepdog.c
> > +++ b/block/sheepdog.c
> > @@ -1224,7 +1224,7 @@ static int find_vdi_name(BDRVSheepdogState *s,
> const char *filename,
> >      SheepdogVdiReq hdr;
> >      SheepdogVdiRsp *rsp =3D (SheepdogVdiRsp *)&hdr;
> >      unsigned int wlen, rlen =3D 0;
> > -    char buf[SD_MAX_VDI_LEN + SD_MAX_VDI_TAG_LEN];
> > +    QEMU_NONSTRING char buf[SD_MAX_VDI_LEN + SD_MAX_VDI_TAG_LEN];
>
> In case you decide to respin anyway - this would be
> a bit nicer as:
>         char buf[SD_MAX_VDI_LEN + SD_MAX_VDI_TAG_LEN] QEMU_NONSTRING
>

I'll have to, so OK.
(it looked to me more explicit prepended).


>
>
>
> >      fd =3D connect_to_sdog(s, errp);
> >      if (fd < 0) {
> > --
> > 2.17.2
>
