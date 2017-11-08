Received: from eggs.gnu.org ([2001:4830:134:3::10]:55287)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eCMG0-0002zV-Go
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 04:02:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eCMFq-0006ig-Cy
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 04:02:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52270)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eCMFq-0006iN-3J
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 04:02:38 -0500
Date: Wed, 8 Nov 2017 09:02:33 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171108090233.GD12670@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20171103153333.6416-1-berrange@redhat.com>
	<20171103153333.6416-6-berrange@redhat.com>
	<d1704cf4-d3d4-cc69-df96-1298c11e1295@ozlabs.ru>
	<1dee5931-84f6-89e5-54e0-5a61cda23ccf@ozlabs.ru>
	<20171107101254.GA3213@redhat.com>
	<d4dff69f-ce98-1309-990d-62425ab636b1@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d4dff69f-ce98-1309-990d-62425ab636b1@ozlabs.ru>
Subject: Re: [Qemu-devel] [PATCH v3 5/5] build: delay check for empty git
 submodule list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

On Wed, Nov 08, 2017 at 09:58:11AM +1100, Alexey Kardashevskiy wrote:
> On 07/11/17 21:12, Daniel P. Berrange wrote:
> > On Tue, Nov 07, 2017 at 04:13:27PM +1100, Alexey Kardashevskiy wrote:
> >> On 07/11/17 15:12, Alexey Kardashevskiy wrote:
> >>> On 04/11/17 02:33, Daniel P. Berrange wrote:
> >>>> We short circuit the git submodule update when passed an empty module list.
> >>>> This accidentally causes the 'status' command to write to the status file. The
> >>>> test needs to be delayed into the individual commands to avoid this premature
> >>>> writing of the status file.
> >>>>
> >>>> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> >>>> ---
> >>>>  scripts/git-submodule.sh | 19 ++++++++++++-------
> >>>>  1 file changed, 12 insertions(+), 7 deletions(-)
> >>>>
> >>>> diff --git a/scripts/git-submodule.sh b/scripts/git-submodule.sh
> >>>> index 2857fc57c4..90376a7dae 100755
> >>>> --- a/scripts/git-submodule.sh
> >>>> +++ b/scripts/git-submodule.sh
> >>>> @@ -33,12 +33,6 @@ error() {
> >>>>      exit 1
> >>>>  }
> >>>>  
> >>>> -if test -z "$maybe_modules"
> >>>> -then
> >>>> -    test -e $substat || touch $substat
> >>>> -    exit 0
> >>>> -fi
> >>>> -
> >>>>  modules=""
> >>>>  for m in $maybe_modules
> >>>>  do
> >>>> @@ -51,7 +45,7 @@ do
> >>>>      fi
> >>>>  done
> >>>>  
> >>>> -if ! test -e ".git"
> >>>> +if test -n "$maybe_modules" && ! test -e ".git"
> >>>
> >>>
> >>> $GIT_DIR should be checked too imho:
> >>>
> >>> if test -n "$maybe_modules" && ! test -e ".git" && test "$GIT_DIR" = ""
> >>
> >> Uff. Just this won't help, it is assumed everywhere that the ".git" folder
> >> exists :(
> >>
> >> I was hoping to use "git --work-dir=" for the source tree to have a full
> >> complete source tree to compile on a build machine but
> >> "./scripts/git-submodule.sh status" is always called, no matter what.
> > 
> > If you need to pass extra args to 'git' this is supported already by
> > this changeset. Just create a wrapper script containing whatever args
> > you need to give git, and use "./configure --with-git=your-wrapper"
> > 
> >> I'd really love to have some way to disable git activities in Makefile...
> > 
> > I don't want to add that. We don't want to ever build if we detect that
> > the submodules are at a different version to what we expect as it would
> > cause obscure hard to diagnose build problems
> > 
> 
> I gave you an example with one build machine having dtc and another not
> having it - your system breaks. What is the proper solution to this?

You could create separate source directories for each system you're building
on. This won't take up extra disk space if you clone extra source dirs from
your first checkout using --reference (or even --shared - but see caveats
in git manpage for that)

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
