Received: from eggs.gnu.org ([2001:4830:134:3::10]:45486)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cTPB0-0001Y2-RK
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 03:31:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cTPAw-0007P7-QX
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 03:31:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59192)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cTPAw-0007Or-Io
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 03:31:30 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <1484559200-2301-1-git-send-email-armbru@redhat.com>
	<CAFEAcA_BBbHeQhWYf_qrL+TwxGT8w34SvUNG_gcNfpNnyaGCzg@mail.gmail.com>
Date: Tue, 17 Jan 2017 09:31:26 +0100
In-Reply-To: <CAFEAcA_BBbHeQhWYf_qrL+TwxGT8w34SvUNG_gcNfpNnyaGCzg@mail.gmail.com>
	(Peter Maydell's message of "Mon, 16 Jan 2017 15:58:41 +0000")
Message-ID: <87pojmjdep.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <mlureau@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> writes:

> On 16 January 2017 at 09:33, Markus Armbruster <armbru@redhat.com> wrote:
>> This is Marc-Andr=C3=A9's "[PATCH v8 00/21] qapi doc generation (whole
>> version, squashed)" with a few commit messages tweaked, and "[PATCH v8
>> 14/21] (SQUASHED) move doc to schema" unsquashed into 161 patches.
>>
>> We did all the respins with in this squashed form to reduce noise.
>> However, since the unsquashed form is better suited for review, and
>> probably nicer if we have to revisit this part of the work down the
>> road, I'm proposing to merge this unsquashed.
>>
>> If you want me to post the unsquashed patches, I'm happy to redo this
>> pull request.
>>
>> If you'd rather pull the squashed version, likewise.
>>
>> I'm afraid this is a bit of a doc conflict magnet.  The sooner we can
>> get it in, the easier for Marc-Andr=C3=A9 and me.
>>
>> v2:
>> * Rebased (v1 conflicts with commit e1ff3c6)
>> * test-qapi.py tweaked to avoid trailing empty lines in .out
>>
>> The following changes since commit b6af8ea60282df514f87d32e36afd1c9aeee2=
8c8:
>>
>>   Merge remote-tracking branch 'remotes/ehabkost/tags/x86-and-machine-pu=
ll-request' into staging (2017-01-13 14:38:21 +0000)
>>
>> are available in the git repository at:
>>
>>   git://repo.or.cz/qemu/armbru.git tags/pull-qapi-2017-01-16
>>
>> for you to fetch changes up to 56e8bdd46a8a42d89b0afea9da83ae7679cc0439:
>>
>>   build-sys: add qapi doc generation targets (2017-01-16 10:11:43 +0100)
>>
>> ----------------------------------------------------------------
>> QAPI patches for 2017-01-16
>
> This seems to trigger some warnings from older makeinfo versions:
>
> On the Fedora 20 ppc64be box and Ubuntu 14.04.5 LTS aarch64 box
> (Ubuntu: makeinfo (GNU texinfo) 5.2;
>  Fedora: makeinfo (GNU texinfo) 5.1)

Nobody should be using F20 by now, but the Ubuntu LTS is still legit.

> /home/pm215/qemu/docs/qemu-ga-ref.texi:41: warning: undefined flag: VERSI=
ON
> /home/pm215/qemu/docs/qemu-ga-ref.texi:41: warning: undefined flag: VERSI=
ON
> /home/pm215/qemu/docs/qemu-qmp-ref.texi:41: warning: undefined flag: VERS=
ION
> /home/pm215/qemu/docs/qemu-qmp-ref.texi:41: warning: undefined flag: VERS=
ION

This is supposed to be defined in Makefile:

    MAKEINFO=3Dmakeinfo -D 'VERSION $(VERSION)'

Hrrm, Texinfo's NEWS file has for 6.0:

* texi2any:
  [...]
  . -D'var val' on the command line works as intended again.

I tried to find out more about this fix, but the Texinfo repository's
commit log is useless.

I can reproduce the warning with 6.2 by running makeinfo without -D.
Curiously, output isn't affected.  Looks like @subtitle is ignored by
makeinfo.

Possible work-around I could squash in:

diff --git a/docs/qemu-qmp-ref.texi b/docs/qemu-qmp-ref.texi
index 818e525..e0f2454 100644
--- a/docs/qemu-qmp-ref.texi
+++ b/docs/qemu-qmp-ref.texi
@@ -38,7 +38,9 @@ along with this manual.  If not, see http://www.gnu.org/l=
icens
es/.
=20
 @titlepage
 @title QMP Reference Manual
+@iftex @c Work around bug in Texinfo prior to 6.0
 @subtitle QEMU version @value{VERSION}
+@end iftex
 @page
 @vskip 0pt plus 1filll
 @insertcopying

Marc-Andr=C3=A9, what do you think?

> On OSX (makeinfo (GNU texinfo) 4.8):

That's from 2004.  Just sayin'.

> ./qemu-options.texi:60: warning: unlikely character [ in @var.
> ./qemu-options.texi:60: warning: unlikely character ] in @var.
> ./qemu-options.texi:61: warning: unlikely character [ in @var.
> ./qemu-options.texi:61: warning: unlikely character ] in @var.

Generated qemu-options.texi did not change (I checked).

The offending lines are

    @item -numa node[,mem=3D@var{size}][,cpus=3D@var{cpu[-cpu]}][,nodeid=3D=
@var{node}]
    @itemx -numa node[,memdev=3D@var{id}][,cpus=3D@var{cpu[-cpu]}][,nodeid=
=3D@var{node}]

which are generated from qemu-options.hx's

    DEF("numa", HAS_ARG, QEMU_OPTION_numa,
        "-numa node[,mem=3Dsize][,cpus=3Dcpu[-cpu]][,nodeid=3Dnode]\n"
        "-numa node[,memdev=3Did][,cpus=3Dcpu[-cpu]][,nodeid=3Dnode]\n", QE=
MU_ARCH_ALL)

by scripts/hxtool.

This use of @var{} is perhaps questionable, but nothing changed around
here for many moons.  Are you sure this is new in my pull request?

> (OSX also has the long standing warning
> /Users/pm215/src/qemu-for-merges/qemu-doc.texi:7: warning:
> unrecognized encoding name `UTF-8'.
> but you can ignore that since it's been that way for years
> and is because osx's makeinfo is ancient.)
>
> thanks
> -- PMM
