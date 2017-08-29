Received: from eggs.gnu.org ([2001:4830:134:3::10]:41011)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dmjSY-0001Bg-Tr
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 12:33:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dmjSS-0000pc-S6
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 12:33:50 -0400
Received: from mail-ua0-x241.google.com ([2607:f8b0:400c:c08::241]:37170)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dmjSS-0000pR-Ni
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 12:33:44 -0400
Received: by mail-ua0-x241.google.com with SMTP id 104so1644790uas.4
	for <qemu-devel@nongnu.org>; Tue, 29 Aug 2017 09:33:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1500290093.12570.6.camel@redhat.com>
References: <20170717101700.23552-1-kraxel@redhat.com>
	<CAJ+F1C+1pVwXxAH=g_5hx25VXBeMU7irpvkJ+guaqMEc7yS2Ag@mail.gmail.com>
	<1500288560.12570.3.camel@redhat.com>
	<CAJ+F1C+yg2jzSZf4PM8L=5-NBwgg25buHjTS-FBT2hF4jzpkxQ@mail.gmail.com>
	<1500290093.12570.6.camel@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 29 Aug 2017 18:33:43 +0200
Message-ID: <CAJ+F1C+vLvXrwNgFmCRZRgb__n-Q6WD=Ev1UZ9WLpx8Lx0SiAw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] add scripts/indent.sh
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>

Hi

On Mon, Jul 17, 2017 at 1:14 PM, Gerd Hoffmann <kraxel@redhat.com> wrote:
> On Mon, 2017-07-17 at 10:58 +0000, Marc-Andr=C3=A9 Lureau wrote:
>> Hi
>>
>> On Mon, Jul 17, 2017 at 12:49 PM Gerd Hoffmann <kraxel@redhat.com>
>> wrote:
>> > On Mon, 2017-07-17 at 10:36 +0000, Marc-Andr=C3=A9 Lureau wrote:
>> > > Hi
>> > >
>> > > On Mon, Jul 17, 2017 at 12:18 PM Gerd Hoffmann <kraxel@redhat.com
>> > >
>> > > wrote:
>> > > > Script to reformat sources in qemu style.
>> > > >
>> > > > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>> > >
>> > > A quite powerful approach would be to use clang-format: https://l
>> > ists
>> > > .gnu.org/archive/html/qemu-devel/2015-10/msg01278.html
>> > >
>> > > It comes with a bunch of editor integration and scripts. My
>> > config
>> > > could use a bit more tweaking though, I haven't been using it for
>> > a
>> > > while, and newer version have more options.
>> >
>> > Hmm, I want reformat all audio stuff to qemu code style some day,
>> > the
>> > current situation where patches are either break qemu code style or
>> > lead to mixed-style in the audio source files isn't very good.
>> >
>> > I don't mind much which tool we use for that, I picked indent
>> > mostly
>> > because I know that one.  If clang-format can do that too, fine
>> > with
>> > me.  I'm missing documentation though, there is no man-page and
>> > there
>> > isn't anything in /usr/share/doc/clang-3.4.2 either ...
>>
>> Afaik, most of clang-tools documentation is only in html. The most
>> recent version is online at
>> https://clang.llvm.org/docs/ClangFormat.html &
>> https://clang.llvm.org/docs/ClangFormatStyleOptions.html
>
> Can you add those links as comments to the .clang-format file?

Sorry for the late reply, fwiw, my best attempt so far:
https://gist.github.com/elmarco/aa5e0b23567f46fb7f0e73cde586a0c1

It's not perfect, you can easily see the result by running inplace
with clang-format -i && git diff.

In particular:
- array declaration is often much uglier (with the indendation aligned
to open brace) - indent seems doing worse.
  also related: https://bugs.llvm.org/show_bug.cgi?id=3D18455
- it uses a space in "FOREACH (" macros - good/bad ?
- long line are splitted in less friendly way than manual split - also
true with indent
- qemu doesn't have BinPack true/false, it uses a mix - clang-format
should learn that - perhaps covered by
https://bugs.llvm.org/show_bug.cgi?id=3D31907
- we may want not to do #include ordering - I find it nicer though

The point is not to apply blindly clang-format over the whole code
base, but rather to give a decent default formatting when running
clang-tools, or simply when making a patch. For this, .clang-format is
necessary, and I would rather have it in qemu tree than in my own
working directory.



--=20
Marc-Andr=C3=A9 Lureau
