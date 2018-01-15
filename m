Received: from eggs.gnu.org ([2001:4830:134:3::10]:43236)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eb8YY-0003FN-4z
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 12:28:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eb8YU-0005li-GK
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 12:28:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35322)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eb8YU-0005lD-5l
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 12:28:18 -0500
Date: Mon, 15 Jan 2018 17:28:00 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20180115172800.GV8218@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20180115170243.24578-1-berrange@redhat.com>
	<20180115170243.24578-8-berrange@redhat.com>
	<33212c79-61aa-3089-dda3-2715cd43caf0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <33212c79-61aa-3089-dda3-2715cd43caf0@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 07/13] qapi: force a UTF-8 locale for
 running Python
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Mon, Jan 15, 2018 at 11:15:01AM -0600, Eric Blake wrote:
> On 01/15/2018 11:02 AM, Daniel P. Berrange wrote:
> > Python2 did not validate locale correctness when reading input data, so
> > would happily read UTF-8 data in non-UTF-8 locales. Python3 is strict so
> > if you try to read UTF-8 data in the C locale, it will raise an error
> > for any UTF-8 bytes that aren't representable in 7-bit ascii encoding.
> 
> Urgh, that sounds like a Python bug. The C locale is defined by POSIX to
> be 8-bit clean (ie. a superset of ascii with 256 characters, not strict
> ascii with only 128 characters and 128 bytes that form encoding errors).
>  But that doesn't change the fact that we have to work around python's
> braindead misinterpretation of reality.

FYI there is some background on this behaviour here:

 https://www.python.org/dev/peps/pep-0538/

NB that doc says the new C-is-UTF-8 assumpion is for Python 3.7 or later,
but Fedora backported it to F27's  Python 3.6 :-)

The failure can be seen on Fedora with 3.0 -> 3.5 only. (BTW you can
install many Python 3.x versions concurrently on Fedora which is handy
for testing)

> > e.g.
> > 
> > UnicodeDecodeError: 'ascii' codec can't decode byte 0xc3 in position 54: ordinal not in range(128)
> > Traceback (most recent call last):
> >   File "/tmp/qemu-test/src/scripts/qapi-commands.py", line 317, in <module>
> >     schema = QAPISchema(input_file)
> >   File "/tmp/qemu-test/src/scripts/qapi.py", line 1468, in __init__
> >     parser = QAPISchemaParser(open(fname, 'r'))
> >   File "/tmp/qemu-test/src/scripts/qapi.py", line 301, in __init__
> >     previously_included)
> >   File "/tmp/qemu-test/src/scripts/qapi.py", line 348, in _include
> >     exprs_include = QAPISchemaParser(fobj, previously_included, info)
> >   File "/tmp/qemu-test/src/scripts/qapi.py", line 271, in __init__
> >     self.src = fp.read()
> >   File "/usr/lib64/python3.5/encodings/ascii.py", line 26, in decode
> >     return codecs.ascii_decode(input, self.errors)[0]
> > 
> > Many distros support a new C.UTF-8 locale that is like the C locale,
> > but with UTF-8 instead of 7-bit ASCII. That is not entirely portable
> > though, so this patch instead forces the en_US.UTF-8 locale, which
> > is pretty similar but more widely available.
> > 
> > We set LANG, rather than only LC_CTYPE, since generated source ought
> > to be independant of all of the user's locale settings.
> 
> s/independant/independent/
> 
> LANG is the lowest-priority setting - if the user has explicitly set
> LC_CTYPE or LC_ALL, their settings override what is in LANG.
> 
> > 
> > This patch only forces UTF-8 for QAPI scripts, since that is the one
> > showing the immediate error under Python3 with C locale, but potentially
> > we ought to force this for all python scripts used in the build process.
> > 
> > Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> > ---
> >  Makefile | 22 ++++++++++++----------
> >  1 file changed, 12 insertions(+), 10 deletions(-)
> > 
> > diff --git a/Makefile b/Makefile
> > index d86ecd2dd4..fde91cc42d 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -17,6 +17,8 @@ ifneq ($(wildcard config-host.mak),)
> >  all:
> >  include config-host.mak
> >  
> > +PYTHON_UTF8 = LANG=en_US.UTF-8 $(PYTHON)
> 
> I'm worried that this is not reproducible in the face of a user that
> explicitly sets different locale env-vars with higher priority than LANG.

You might remember a similar issue affecting libvirt-glib/libosinfo when
glib-mkenums was rewritten to use Python instead of Perl. For that I ended
up doing

   LC_ALL= LANG=C LC_CTYPE=en_US.UTF-8 


> > +
> >  git-submodule-update:
> >  
> >  .PHONY: git-submodule-update
> > @@ -471,17 +473,17 @@ qapi-py = $(SRC_PATH)/scripts/qapi.py $(SRC_PATH)/scripts/ordereddict.py
> >  
> >  qga/qapi-generated/qga-qapi-types.c qga/qapi-generated/qga-qapi-types.h :\
> >  $(SRC_PATH)/qga/qapi-schema.json $(SRC_PATH)/scripts/qapi-types.py $(qapi-py)
> > -	$(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi-types.py \
> > +	$(call quiet-command,$(PYTHON_UTF8) $(SRC_PATH)/scripts/qapi-types.py \
> 
> But once we agree on the right override to stuff into PYTHON_UTF8, the
> rest of the patch converting invocations to PYTHON_UTF8 makes sense.

Any thoughts on whether we should apply this more widely to our build
to make its output predictable regardless of user's locale ?

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
