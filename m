Received: from eggs.gnu.org ([2001:4830:134:3::10]:37958)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1daCUq-0006Km-7N
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 22:56:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1daCUm-0007ky-8w
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 22:56:24 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:35416)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <flukshun@gmail.com>) id 1daCUm-0007kj-31
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 22:56:20 -0400
Received: by mail-oi0-x243.google.com with SMTP id q70so8201892oic.2
	for <qemu-devel@nongnu.org>; Tue, 25 Jul 2017 19:56:19 -0700 (PDT)
Sender: fluxion <flukshun@gmail.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <150103762159.26979.13316299204767598566@loki>
References: <20170725011530.17958-1-f4bug@amsat.org>
	<150102382734.26979.483898024984598924@loki>
	<cb21f5d1-18be-51a4-5e51-e429ab4b1b46@amsat.org>
	<150103762159.26979.13316299204767598566@loki>
Message-ID: <150103777491.26979.16844695290515425301@loki>
Date: Tue, 25 Jul 2017 21:56:14 -0500
Subject: Re: [Qemu-devel] [PATCH] configure: fix qemu-ga missing '.exe'
 extension on windows
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, =?utf-8?b?VG9tw6HFoSBHb2xlbWJpb3Zza8O9?= <tgolembi@redhat.com>, =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Sameeh Jubran <sjubran@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org

Quoting Michael Roth (2017-07-25 21:53:41)
> Quoting Philippe Mathieu-Daud=C3=A9 (2017-07-25 20:45:31)
> > Hi Michael,
> > =

> > On 07/25/2017 08:03 PM, Michael Roth wrote:
> > > Quoting Philippe Mathieu-Daud=C3=A9 (2017-07-24 20:15:30)
> > >> Reported-by: Sameeh Jubran <sjubran@redhat.com>
> > >> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> > >> ---
> > >> original report from Sameeh Jubran:
> > >> http://lists.nongnu.org/archive/html/qemu-devel/2017-07/msg00906.html
> > > =

> > > AFAICT the issue discussed in the context of that patch is simply that
> > > the qemu-ga.exe file isn't deleted as part of `make clean`, which does
> > > seem to be an issue.
> > > =

> > > But qemu.ga.exe is created just fine as part of `make qemu-ga`, at le=
ast
> > > as of:
> > > =

> > >    fafcaf1d build: qemu-ga: add 'qemu-ga' build target for w32
> > > =

> > =

> > Yes, on w32 if "make ASDF" invokes the linker, it will create ASDF.exe.
> > =

> > > The 'qemu-ga' target is actually an intermediate target which, on w32,
> > > creates the MSI package (if configured) as well as qemu-ga.exe.
> > > =

> > >>
> > >>   Makefile  | 2 +-
> > >>   configure | 2 +-
> > >>   2 files changed, 2 insertions(+), 2 deletions(-)
> > >>
> > >> diff --git a/Makefile b/Makefile
> > >> index ef721480eb..5f18243d05 100644
> > >> --- a/Makefile
> > >> +++ b/Makefile
> > >> @@ -490,7 +490,7 @@ clean:
> > >>          rm -f qemu-options.def
> > >>          rm -f *.msi
> > >>          find . \( -name '*.so' -o -name '*.dll' -o -name '*.mo' -o =
-name '*.[oda]' \) -type f -exec rm {} +
> > >> -       rm -f $(filter-out %.tlb,$(TOOLS)) $(HELPERS-y) qemu-ga TAGS=
 cscope.* *.pod *~ */*~
> > >> +       rm -f $(filter-out %.tlb,$(TOOLS)) $(HELPERS-y) TAGS cscope.=
* *.pod *~ */*~
> > =

> > On win32, this patch add qemu-ga.exe instead of qemu-ga in $TOOLS, so =

> > when the 'clean' target is executed it removes qemu-ga.exe (Sameeh =

> =

> Ok, that makes more sense, but it's not what the commit msg implies.
> =

> > Jubran report). Before this patch the $TOOLS looks like:
> > "qemu-img.exe qemu-io.exe qemu-nbd.exe ivshmem-client.exe =

> > ivshmem-server.exe qemu-ga fsdev/virtfs-proxy-helper.exe"
> =

> That change was done explicitly via fafcaf1d so that `make qemu-ga` and
> `make` without --disable-tools specified to configure will generate the
> MSI package when the user configures it. So, unlike the other $TOOLS
> targets, the qemu-ga "distributables" encompass more than just the .exe
> on w32, so we use the "qemu-ga" target instead of "qemu-ga.exe" directly.
> =

> Reverting that change to coax `make clean` into cleaning up qemu-ga.exe
> means that `make` no longer builds the qemu-ga-*.msi when the user
> configures it, which is a regression.
> =

> > The only executables which doesn't match %.exe is qemu-ga, so the =

> > 'clean' target remove all .exe _but_ qemu-ga.exe.
> =

> As with Sameeh's original patch, the qemu-ga target would already
> require special handling to deal with qemu-ga-*.msi file. We should
> similarly just cleanup qemu-ga.exe as a special case instead of
> modifying $TOOLS, since that brings about unecessary side-effects
> described above.
> =

> As a workaround to the issue you/Peter pointed out with Sameeh's patch
> (nuking the entire source tree for posix builds where $EXESUF =3D=3D ""),=
 I
> proposed we just do:
> =

>   make clean:
>     ...
>   ifneq($EXESUF,)
>     rm -f *$(EXESUF)
>   endif
> =

> But given your clarification here, I understand that $TOOLS already
> takes care of everything except qemu-ga.exe, so I think you've already
> mentioned the most straightforward fix in the other thread:
> =

> - rm -f $(filter-out %.tlb,$(TOOLS)) $(HELPERS-y) qemu-ga TAGS cscope.* *=
.pod *~ */*~
> + rm -f $(filter-out %.tlb,$(TOOLS)) $(HELPERS-y) qemu-ga${EXESUF} TAGS c=
scope.* *.pod *~ */*~
> =

> It's a bit ugly since `rm -f qemu-ga.exe` would silently fail on posix,

On w32 I mean, sorry.

> but `rm -f $TOOLS qemu-ga ...` already silently fails since it already ge=
ts
> removed via $TOOLS.
> =

> Alternatively, you can explicitly check for qemu-ga.exe and remove it if
> it exists. I would consider either acceptable, but not this patch as it
> currently stands.
> =

> > =

> > Now if by "this is not an issue" you mean it is not a bug, I agree this =

> > can wait 2.11.
> =

> I just mean the issue as described in the commit msg.
> =

> For the `make clean` stuff, if it's simple enough it might be acceptable =
for
> rc1 if you can get it out this week. Otherwise we can wait for 2.11.
> =

> > =

> > Regards,
> > =

> > Phil.
> > =

> > >>          rm -f fsdev/*.pod
> > >>          rm -f qemu-img-cmds.h
> > >>          rm -f ui/shader/*-vert.h ui/shader/*-frag.h
> > >> diff --git a/configure b/configure
> > >> index 48d4d7a2a7..f8b1d014d7 100755
> > >> --- a/configure
> > >> +++ b/configure
> > >> @@ -5073,7 +5073,7 @@ fi
> > >>
> > >>   if [ "$guest_agent" !=3D "no" ]; then
> > >>     if [ "$linux" =3D "yes" -o "$bsd" =3D "yes" -o "$solaris" =3D "y=
es" -o "$mingw32" =3D "yes" ] ; then
> > >> -      tools=3D"qemu-ga $tools"
> > >> +      tools=3D"qemu-ga\$(EXESUF) $tools"
> > >>         guest_agent=3Dyes
> > >>     elif [ "$guest_agent" !=3D yes ]; then
> > >>         guest_agent=3Dno
> > >> -- =

> > >> 2.13.3
> > >>
> > >>
> > > =

> >=20
