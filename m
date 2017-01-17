Received: from eggs.gnu.org ([2001:4830:134:3::10]:48210)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cTRd0-0007D6-OB
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 06:08:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cTRcz-0007KW-K1
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 06:08:38 -0500
Received: from mail-ua0-x22e.google.com ([2607:f8b0:400c:c08::22e]:34740)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cTRcz-0007KL-AH
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 06:08:37 -0500
Received: by mail-ua0-x22e.google.com with SMTP id 35so100166441uak.1
	for <qemu-devel@nongnu.org>; Tue, 17 Jan 2017 03:08:37 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <87pojmjdep.fsf@dusky.pond.sub.org>
References: <1484559200-2301-1-git-send-email-armbru@redhat.com>
	<CAFEAcA_BBbHeQhWYf_qrL+TwxGT8w34SvUNG_gcNfpNnyaGCzg@mail.gmail.com>
	<87pojmjdep.fsf@dusky.pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Jan 2017 11:08:16 +0000
Message-ID: <CAFEAcA9nhd6x+PT5bG0=YqvmUdxJVFPZ6ACiv-2OKrDFJhrqzg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL v2 000/180] QAPI patches for 2017-01-16
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <mlureau@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 17 January 2017 at 08:31, Markus Armbruster <armbru@redhat.com> wrote:
> Peter Maydell <peter.maydell@linaro.org> writes:
>> This seems to trigger some warnings from older makeinfo versions:
>>
>> On the Fedora 20 ppc64be box and Ubuntu 14.04.5 LTS aarch64 box
>> (Ubuntu: makeinfo (GNU texinfo) 5.2;
>>  Fedora: makeinfo (GNU texinfo) 5.1)
>
> Nobody should be using F20 by now, but the Ubuntu LTS is still legit.

The F20 box is the GCC compile farm's ppc64be box, so I'm not going
to drop it from the build system list I'm afraid.

>> /home/pm215/qemu/docs/qemu-ga-ref.texi:41: warning: undefined flag: VERS=
ION
>> /home/pm215/qemu/docs/qemu-ga-ref.texi:41: warning: undefined flag: VERS=
ION
>> /home/pm215/qemu/docs/qemu-qmp-ref.texi:41: warning: undefined flag: VER=
SION
>> /home/pm215/qemu/docs/qemu-qmp-ref.texi:41: warning: undefined flag: VER=
SION
>
> This is supposed to be defined in Makefile:
>
>     MAKEINFO=3Dmakeinfo -D 'VERSION $(VERSION)'
>
> Hrrm, Texinfo's NEWS file has for 6.0:
>
> * texi2any:
>   [...]
>   . -D'var val' on the command line works as intended again.
>
> I tried to find out more about this fix, but the Texinfo repository's
> commit log is useless.
>
> I can reproduce the warning with 6.2 by running makeinfo without -D.
> Curiously, output isn't affected.  Looks like @subtitle is ignored by
> makeinfo.

That suggests we should be putting the VERSION information
somewhere else so it actually appears in the output :-)

Maybe writing the VERSION info to a file as a @set command
(and then including that file in the texi) would work ?

> Possible work-around I could squash in:
>
> diff --git a/docs/qemu-qmp-ref.texi b/docs/qemu-qmp-ref.texi
> index 818e525..e0f2454 100644
> --- a/docs/qemu-qmp-ref.texi
> +++ b/docs/qemu-qmp-ref.texi
> @@ -38,7 +38,9 @@ along with this manual.  If not, see http://www.gnu.org=
/licens
> es/.
>
>  @titlepage
>  @title QMP Reference Manual
> +@iftex @c Work around bug in Texinfo prior to 6.0
>  @subtitle QEMU version @value{VERSION}
> +@end iftex
>  @page
>  @vskip 0pt plus 1filll
>  @insertcopying
>
> Marc-Andr=C3=A9, what do you think?
>
>> On OSX (makeinfo (GNU texinfo) 4.8):
>
> That's from 2004.  Just sayin'.

I assume it's the last GPLv2 version...

>> ./qemu-options.texi:60: warning: unlikely character [ in @var.
>> ./qemu-options.texi:60: warning: unlikely character ] in @var.
>> ./qemu-options.texi:61: warning: unlikely character [ in @var.
>> ./qemu-options.texi:61: warning: unlikely character ] in @var.
>
> Generated qemu-options.texi did not change (I checked).
>
> The offending lines are
>
>     @item -numa node[,mem=3D@var{size}][,cpus=3D@var{cpu[-cpu]}][,nodeid=
=3D@var{node}]
>     @itemx -numa node[,memdev=3D@var{id}][,cpus=3D@var{cpu[-cpu]}][,nodei=
d=3D@var{node}]
>
> which are generated from qemu-options.hx's
>
>     DEF("numa", HAS_ARG, QEMU_OPTION_numa,
>         "-numa node[,mem=3Dsize][,cpus=3Dcpu[-cpu]][,nodeid=3Dnode]\n"
>         "-numa node[,memdev=3Did][,cpus=3Dcpu[-cpu]][,nodeid=3Dnode]\n", =
QEMU_ARCH_ALL)
>
> by scripts/hxtool.
>
> This use of @var{} is perhaps questionable, but nothing changed around
> here for many moons.  Are you sure this is new in my pull request?

Yep, definitely new. With current master:

bash-3.2$ touch qemu-options.hx
bash-3.2$ make -C build/all
  GEN     qemu-options.def
  GEN     qemu-options.texi
  GEN     qemu-doc.html
/Users/pm215/src/qemu-for-merges/qemu-doc.texi:7: warning:
unrecognized encoding name `UTF-8'.

but no warnings about unlikely characters.

thanks
-- PMM
