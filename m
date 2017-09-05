Received: from eggs.gnu.org ([2001:4830:134:3::10]:49824)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dpFrO-0007cW-KM
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 11:33:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dpFrG-0006AJ-Kj
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 11:33:54 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <CAJ+F1C+mPu9ftXwgs4UrGTQp4f65-thhvmWoB-kuRmu0=vnFFw@mail.gmail.com>
	<87zia9palk.fsf@dusky.pond.sub.org>
	<CAJ+F1CJaxdbHnLQy6H=5=Q3ZMw0w01xsvK3ybhj80=6F9dR6gQ@mail.gmail.com>
Date: Tue, 05 Sep 2017 17:33:42 +0200
In-Reply-To: <CAJ+F1CJaxdbHnLQy6H=5=Q3ZMw0w01xsvK3ybhj80=6F9dR6gQ@mail.gmail.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Tue, 05 Sep 2017
	13:29:48 +0000")
Message-ID: <87fuc1ma7d.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] clang-tidy: use g_new() family of functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: qemu trival <qemu-trivial@nongnu.org>, QEMU <qemu-devel@nongnu.org>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:

> Hi
>
> On Tue, Sep 5, 2017 at 2:56 PM Markus Armbruster <armbru@redhat.com> wrot=
e:
>
>> Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:
>>
>> > Hi,
>> >
>> > I have a series of changes generated with clang-tidy qemu [1] pending
>> > for review [2].
>> >
>> > It translates calloc/*malloc*/*realloc() calls to
>> > g_new/g_newa/g_new0/g_renew() where the argument is a sizeof(T) [* N].
>>
>> Only for *type* T, or for arbitrary T?
>>
>>
> If sizeof() argument is a type:
> https://github.com/elmarco/clang-tools-extra/blob/master/clang-tidy/qemu/=
UseGnewCheck.cpp#L65
>
> For type T, we've done the transformation repeatedly with Coccinelle,
>> first in commit b45c03f (commit message appended).  Repeatedly, because
>> they creep back in.
>>
>> How does your technique compare to this prior one?
>>
>
> Well, for one, I have a lot of trouble running coccinelle, mostly because
> it is slow and/or eat all my memory.

It's a bit of a pig, but it doesn't get anywhere close to prohibitive
even on my rather modest development box.  Example run with a minor
variation of the semantic patch from commit b45c03f:

$ time spatch --in-place --sp-file g_new.cocci --macro-file scripts/cocci-m=
acro-file.h --use-idutils --dir .
[...]
real	0m42.379s
user	0m38.988s
sys	0m2.179s
$ git-diff --shortstat
 123 files changed, 211 insertions(+), 216 deletions(-)

Note that "--use-idutils --dir ." directs spatch to work only on files
that need work.  There's also --use-glimpse.  You can easily do the
directing by hand with a judicious `git-grep ...`.  Your experience can
be far worse if you feed it source files indiscriminately.

>                                      Afaik, coccinelle also has trouble
> parsing the code in various cases.

Yes, but anything else that doesn't is almost certainly not tackling the
full problem.

Preprocessing C is easy enough.  Parsing preprocessed C is easy enough.
Parsing unpreprocessed C into something that's suitable for transforming
is darn hard.

Doesn't mean that clang-tidy couldn't be doing a better job for our
code.

>                                    I have also trouble writing coccinelle
> semantic patch...

Point taken.

>                   And, I gave up.

I've found it frustrating at times, but overall too useful to pass up.

I'd love to buy a well-written book on the thing.

> clang-tidy in comparison, is quite fast (it takes a minute to apply on qe=
mu

Same order of magnitude as my spatch run above.

> code base). I find it easier to write a tidy check, and more friendly
> command line / output etc:
>
> /tmp/test.c:3:17: warning: use g_new() instead [qemu-use-gnew]
>         int *f =3D (int*)malloc(sizeof(int) * 2);
>                  ~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~
>                  g_new(int, 2)
>
> clang-tidy should also respect clang-format rules when modifying the code
> (see also
> https://lists.nongnu.org/archive/html/qemu-devel/2017-08/msg05762.html).
>
> I also imagine it should be possible to integrate to clang warnings in the
> future (similar to libreoffice clang plugins for ex). All in all,
> coccinelle or clang-tidy are probably both capable of doing this job, but
> clang-tidy is snappier and has more potentials for toolchain integration.

Suggest you show us cool things you can do with clang-tidy that haven't
been done with Coccinelle :)

[...]
