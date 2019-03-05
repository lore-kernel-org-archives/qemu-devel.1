Received: from eggs.gnu.org ([209.51.188.92]:60972)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h1BwM-0006kw-C3
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 10:25:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h1BwK-0003kE-HZ
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 10:25:10 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:33614)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1h1BwK-0003it-3p
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 10:25:08 -0500
Received: by mail-oi1-x244.google.com with SMTP id z14so7124364oid.0
	for <qemu-devel@nongnu.org>; Tue, 05 Mar 2019 07:25:07 -0800 (PST)
MIME-Version: 1.0
References: <20190228145624.24885-1-peter.maydell@linaro.org>
	<20190228145624.24885-10-peter.maydell@linaro.org>
	<7ec8917a-eabd-6a14-3c1f-38b1d429c900@redhat.com>
	<CAFEAcA-G8FN63M57JJt8K_0omq8kujABetsr31unCxxxno+MiA@mail.gmail.com>
In-Reply-To: <CAFEAcA-G8FN63M57JJt8K_0omq8kujABetsr31unCxxxno+MiA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 Mar 2019 15:24:55 +0000
Message-ID: <CAFEAcA-L=fQPvT_biEm0ko8jUP88H++Gf7ttMyZx=f6dcjd+bg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 09/11] Makefile,
 configure: Support building rST documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>

On Tue, 5 Mar 2019 at 12:47, Peter Maydell <peter.maydell@linaro.org> wrote=
:
>
> On Thu, 28 Feb 2019 at 15:49, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.=
com> wrote:
> >
> > Hi Peter,
> >
> > On 2/28/19 3:56 PM, Peter Maydell wrote:
> > > +# Sphinx builds all its documentation at once in one invocation
> > > +# and handles "don't rebuild things unless necessary" itself.
> > > +# The '.doctrees' files are cached information to speed this up.
> >
> > Can you add .doctrees to .gitignore?
>
> Since this was the only change request for this patchset,
> I plan to send out a pullreq containing it, with this folded
> into this patch:
>
> diff --git a/.gitignore b/.gitignore
> index b66b7725512..77522561b8e 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -1,3 +1,4 @@
> +/.doctrees
>  /config-devices.*
>  /config-all-devices.*
>  /config-all-disas.*

Testing on various hosts revealed that we have a problem on
hosts with ancient versions of sphinx that predate the 'alabaster'
theme, so the configure test needs to be smarter. The fixup is
the change below.

Are people OK with me squashing this in too, or have we
reached the point where it really ought to have a v3 sent out ?


diff --git a/configure b/configure
index f1f028340aa..47bf617fcc5 100755
--- a/configure
+++ b/configure
@@ -4589,9 +4589,20 @@ if compile_prog "" "" ; then
   syncfs=3Dyes
 fi

+# Check we have a new enough version of sphinx-build
+has_sphinx_build() {
+    # This is a bit awkward but works: create a trivial document and
+    # try to run it with our configuration file (which enforces a
+    # version requirement). This will fail if either
+    # sphinx-build doesn't exist at all or if it is too old.
+    mkdir -p "$TMPDIR1/sphinx"
+    touch "$TMPDIR1/sphinx/index.rst"
+    sphinx-build -c "$source_path/docs" -b html "$TMPDIR1/sphinx"
"$TMPDIR1/sphinx/out" >/dev/null 2>&1
+}
+
 # Check if tools are available to build documentation.
 if test "$docs" !=3D "no" ; then
-  if has makeinfo && has pod2man && has sphinx-build; then
+  if has makeinfo && has pod2man && has_sphinx_build; then
     docs=3Dyes
   else
     if test "$docs" =3D "yes" ; then
diff --git a/docs/conf.py b/docs/conf.py
index 0842d44e930..befbcc6c3e1 100644
--- a/docs/conf.py
+++ b/docs/conf.py
@@ -48,7 +48,8 @@ except NameError:

 # If your documentation needs a minimal Sphinx version, state it here.
 #
-# needs_sphinx =3D '1.0'
+# 1.3 is where the 'alabaster' theme was shipped with Sphinx.
+needs_sphinx =3D '1.3'

 # Add any Sphinx extension module names here, as strings. They can be
 # extensions coming with Sphinx (named 'sphinx.ext.*') or your custom


thanks
-- PMM
