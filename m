Received: from eggs.gnu.org ([2001:4830:134:3::10]:53370)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nsoffer@redhat.com>) id 1gLzHm-0003Q3-1e
	for qemu-devel@nongnu.org; Sun, 11 Nov 2018 18:36:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nsoffer@redhat.com>) id 1gLzHi-0007WI-QV
	for qemu-devel@nongnu.org; Sun, 11 Nov 2018 18:36:57 -0500
Received: from mail-vs1-f48.google.com ([209.85.217.48]:41081)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <nsoffer@redhat.com>) id 1gLzHi-0007TG-KL
	for qemu-devel@nongnu.org; Sun, 11 Nov 2018 18:36:54 -0500
Received: by mail-vs1-f48.google.com with SMTP id t17so4093506vsc.8
	for <qemu-devel@nongnu.org>; Sun, 11 Nov 2018 15:36:54 -0800 (PST)
MIME-Version: 1.0
References: <79c52867-2c10-401b-95d9-2d2edd8afa5e@redhat.com>
In-Reply-To: <79c52867-2c10-401b-95d9-2d2edd8afa5e@redhat.com>
From: Nir Soffer <nsoffer@redhat.com>
Date: Mon, 12 Nov 2018 01:36:42 +0200
Message-ID: <CAMRbyysA2h5MbJM8LyyYfFOOttH_D+Fc=Nb51vcvk=o+=hJsbA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-block] KVM Forum block no[td]es
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block <qemu-block@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, vsementsov@virtuozzo.com, QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>, den@openvz.org

On Mon, Nov 12, 2018 at 12:25 AM Max Reitz <mreitz@redhat.com> wrote:

> This is what I=E2=80=99ve taken from two or three BoF-like get-togethers =
on
> blocky things.  Amendments are more than welcome, of course.

...

> Bitmaps
>
=3D=3D=3D=3D=3D=3D=3D
>
> (Got this section from sneaking into a BoF I wasn=E2=80=99t invited to.  =
Oh
> well.  Won=E2=80=99t hurt to include them here.)
>
> Currently, when dirty bitmaps are loaded, all IN_USE bitmaps are just
> not loaded at all and completely ignored.  That isn=E2=80=99t correct, th=
ough,
> they should either still be loaded (and automatically treated and
> written back as fully dirty), or at least qemu-img check should
> =E2=80=9Crepair=E2=80=9D them (i.e. fully dirtying them).
>

I'm not sure making bitmaps dirty is better.

When bitmap is marked IN_USE, it means that we cannot use it for
backup. Deleting the bitmap or making it as bad so it cannot be used
for the next backup is the same. Making the bitmap as dirty will full
the management layer that everything was fine when the next backup
includes the entire disk. It is better to cause the next backup to fail
in a verbose way, since the backup software can recover by doing
a full backup.

Sometimes qemu (running in a mode as bare as possible) is better than
> using qemu-img convert, for instance.  It gives you more control
> (through QMP; you get e.g. better progress reporting), you get all of
> the mirror optimizations (we do have optimizations for convert, too,
> but whether it=E2=80=99s any good to write the same (or different?)
> optimizations twice is another question), and you get a common
> interface for everything (online and offline).
> Note that besides a bare qemu we=E2=80=99ve also always wanted to convert=
 as
> many qemu-img operations into frontends for block jobs as possible.
> We have only done this for commit, however, even though convert looked
> like basically the ideal target.  It was just too hard with too little
> apparent gain, like always (and convert supports additional features
> like concatenation which we don=E2=80=99t have in the runtime block layer
> yet).
>

I'm not sure it is better to run qemu and use qemu-img as thin wrapper
over qmp.

For example, management system may ascociate qemu-img
with a sanlock lease, and sanlock may try to terminate qemu-img when
a lease is invalidated. In this case sanlock will succeed while qemu is til=
l
accessing storage it should not access.
...

> Transacitonable bitmap primitives (e.g. copying a bitmap) would be
> nice so you can use them when creating a snapshot.  Then it=E2=80=99d be =
up to
> the management layer to make use of them:
> - Do you want to continue using the very same bitmap?  Copy it then
>   (or move it, depending on what exactly you want to do and what
>   primitives there are)
> - Do you want to start with a new bitmap?  Then just create a new one
>   along with the overlay.
>

Having both options sounds good, but we can start with the first.

Nir
