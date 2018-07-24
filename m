Received: from eggs.gnu.org ([2001:4830:134:3::10]:43831)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fzheng@redhat.com>) id 1fhlxm-0008Pq-Qb
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 21:18:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fzheng@redhat.com>) id 1fhlxh-0006yg-T1
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 21:18:06 -0400
Received: from mail-ua0-f196.google.com ([209.85.217.196]:34034)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <fzheng@redhat.com>) id 1fhlxh-0006yS-NA
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 21:18:01 -0400
Received: by mail-ua0-f196.google.com with SMTP id r10-v6so1712022uao.1
	for <qemu-devel@nongnu.org>; Mon, 23 Jul 2018 18:18:01 -0700 (PDT)
MIME-Version: 1.0
References: <20180719034118.27741-1-famz@redhat.com>
	<640247eb-482c-0c27-f1f3-acea29e8cb3a@redhat.com>
	<CAK1Eb9mQ8ERn5eiA6hyXotmbgTckU=TE8mNbX+zeotXXfMxmGg@mail.gmail.com>
	<46511655-713c-6537-0495-0b36384d6fb7@redhat.com>
	<CAK1Eb9kzqTwEjkv5NN1zSYVMmg2h_6BOmxQc2Qz+-c3=_T3=7g@mail.gmail.com>
	<88ac3a1a-0eae-5356-d53c-ced561a5b890@redhat.com>
In-Reply-To: <88ac3a1a-0eae-5356-d53c-ced561a5b890@redhat.com>
From: Fam Zheng <famz@redhat.com>
Date: Tue, 24 Jul 2018 09:17:24 +0800
Message-ID: <CAK1Eb9nL5DY1WMbies-10hkzuWTfQQGR29EnKuJfeT098UziNQ@mail.gmail.com>
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

On Mon, Jul 23, 2018 at 10:37 PM Max Reitz <mreitz@redhat.com> wrote:
>
> On 2018-07-23 03:56, Fam Zheng wrote:
> > On Sun, Jul 22, 2018 at 10:06 PM Max Reitz <mreitz@redhat.com> wrote:
> >>
> >> On 2018-07-22 04:37, Fam Zheng wrote:
> >>> On Sun, Jul 22, 2018 at 5:08 AM Max Reitz <mreitz@redhat.com> wrote:
> >>>>
> >>>> On 2018-07-19 05:41, Fam Zheng wrote:
> >>>>> On my Fedora 28, /dev/null is locked by some other process (couldn'=
t
> >>>>> inspect it due to the current lslocks limitation), so iotests 226 f=
ails
> >>>>> with some unexpected image locking errors because it uses qemu-io t=
o
> >>>>> open it.
> >>>>>
> >>>>> Actually it's safe to not use any lock on /dev/null or /dev/zero.
> >>>>>
> >>>>> Signed-off-by: Fam Zheng <famz@redhat.com>
> >>>>> ---
> >>>>>  block/file-posix.c | 7 ++++++-
> >>>>>  1 file changed, 6 insertions(+), 1 deletion(-)
> >>>>>
> >>>>> diff --git a/block/file-posix.c b/block/file-posix.c
> >>>>> index 60af4b3d51..8bf034108a 100644
> >>>>> --- a/block/file-posix.c
> >>>>> +++ b/block/file-posix.c
> >>>>> @@ -503,7 +503,12 @@ static int raw_open_common(BlockDriverState *b=
s, QDict *options,
> >>>>>          s->use_lock =3D false;
> >>>>>          break;
> >>>>>      case ON_OFF_AUTO_AUTO:
> >>>>> -        s->use_lock =3D qemu_has_ofd_lock();
> >>>>> +        if (!strcmp(filename, "/dev/null") ||
> >>>>> +                   !strcmp(filename, "/dev/zero")) {
> >>>>
> >>>> I=E2=80=99m not sure I like a strcmp() based on filename (though it =
should work
> >>>> for all of the cases where someone would want to specify either of t=
hose
> >>>> for a qemu block device).  Isn=E2=80=99t there some specific major/m=
inor number
> >>>> we can use to check for these two files?  Or are those Linux-specifi=
c?
> >>>
> >>> Yeah, I guess major/minor numbers are Linux-specific.
> >>>
> >>>>
> >>>> I could also imagine just not locking any host_device, but since peo=
ple
> >>>> do use qcow2 immediately on block devices, maybe we do want to lock =
them.
> >>>
> >>> That's right.
> >>>
> >>>>
> >>>> Finally, if really all you are trying to do is to make test code eas=
ier,
> >>>> then I don=E2=80=99t know exactly why.  Just disabling locking in 22=
6 shouldn=E2=80=99t
> >>>> be too hard.
> >>>
> >>> The tricky thing is in remembering to do that for future test cases.
> >>> My machine seems to be somehow different than John's so that my 226
> >>> cannot lock /dev/null, but I'm not sure that is the case for other
> >>> releases, distros or system instances.
> >>
> >> Usually we don=E2=80=99t need to use /dev/null, though, because null-c=
o:// is
> >> better suited for most purposes.  This is a very specific test of host
> >> devices.
> >>
> >> Maybe we should start a doc file with common good practices about
> >> writing iotests?
> >
> > Yes, mentioning using pseudo devices in docs/devel/testing.rst would
> > probably be a good idea. So is my understanding right that you prefer
> > fixing the test case and discard this patch? If so I'll send another
> > version together with the doc update.
>
> I personally would prefer fixing the test and not modifying the code,
> yes.  But I'm aware that it is a personal opinion.

Sure, and you are the maintainer, so why not follow what you think. :)

Fam
