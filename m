Received: from eggs.gnu.org ([2001:4830:134:3::10]:42685)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fzheng@redhat.com>) id 1fh4GC-0000Rw-01
	for qemu-devel@nongnu.org; Sat, 21 Jul 2018 22:38:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fzheng@redhat.com>) id 1fh4G8-0002JK-P1
	for qemu-devel@nongnu.org; Sat, 21 Jul 2018 22:38:12 -0400
Received: from mail-ua0-f195.google.com ([209.85.217.195]:41731)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <fzheng@redhat.com>) id 1fh4G8-0002J1-KJ
	for qemu-devel@nongnu.org; Sat, 21 Jul 2018 22:38:08 -0400
Received: by mail-ua0-f195.google.com with SMTP id t14-v6so9720553uao.8
	for <qemu-devel@nongnu.org>; Sat, 21 Jul 2018 19:38:08 -0700 (PDT)
MIME-Version: 1.0
References: <20180719034118.27741-1-famz@redhat.com>
	<640247eb-482c-0c27-f1f3-acea29e8cb3a@redhat.com>
In-Reply-To: <640247eb-482c-0c27-f1f3-acea29e8cb3a@redhat.com>
From: Fam Zheng <famz@redhat.com>
Date: Sun, 22 Jul 2018 10:37:31 +0800
Message-ID: <CAK1Eb9mQ8ERn5eiA6hyXotmbgTckU=TE8mNbX+zeotXXfMxmGg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] block: Don't lock /dev/null and /dev/zero
 automatically
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, qemu block <qemu-block@nongnu.org>

On Sun, Jul 22, 2018 at 5:08 AM Max Reitz <mreitz@redhat.com> wrote:
>
> On 2018-07-19 05:41, Fam Zheng wrote:
> > On my Fedora 28, /dev/null is locked by some other process (couldn't
> > inspect it due to the current lslocks limitation), so iotests 226 fails
> > with some unexpected image locking errors because it uses qemu-io to
> > open it.
> >
> > Actually it's safe to not use any lock on /dev/null or /dev/zero.
> >
> > Signed-off-by: Fam Zheng <famz@redhat.com>
> > ---
> >  block/file-posix.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/block/file-posix.c b/block/file-posix.c
> > index 60af4b3d51..8bf034108a 100644
> > --- a/block/file-posix.c
> > +++ b/block/file-posix.c
> > @@ -503,7 +503,12 @@ static int raw_open_common(BlockDriverState *bs, Q=
Dict *options,
> >          s->use_lock =3D false;
> >          break;
> >      case ON_OFF_AUTO_AUTO:
> > -        s->use_lock =3D qemu_has_ofd_lock();
> > +        if (!strcmp(filename, "/dev/null") ||
> > +                   !strcmp(filename, "/dev/zero")) {
>
> I=E2=80=99m not sure I like a strcmp() based on filename (though it shoul=
d work
> for all of the cases where someone would want to specify either of those
> for a qemu block device).  Isn=E2=80=99t there some specific major/minor =
number
> we can use to check for these two files?  Or are those Linux-specific?

Yeah, I guess major/minor numbers are Linux-specific.

>
> I could also imagine just not locking any host_device, but since people
> do use qcow2 immediately on block devices, maybe we do want to lock them.

That's right.

>
> Finally, if really all you are trying to do is to make test code easier,
> then I don=E2=80=99t know exactly why.  Just disabling locking in 226 sho=
uldn=E2=80=99t
> be too hard.

The tricky thing is in remembering to do that for future test cases.
My machine seems to be somehow different than John's so that my 226
cannot lock /dev/null, but I'm not sure that is the case for other
releases, distros or system instances.

Fam

>
> Max
>
> > +            s->use_lock =3D false;
> > +        } else {
> > +            s->use_lock =3D qemu_has_ofd_lock();
> > +        }
> >          break;
> >      default:
> >          abort();
> >
>
>
