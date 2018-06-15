Received: from eggs.gnu.org ([2001:4830:134:3::10]:48322)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fTqTh-0005eB-Os
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 11:17:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fTqTe-0001fs-IB
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 11:17:29 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43962 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fTqTe-0001fc-BD
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 11:17:26 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180615044042.7928-1-tamiko@43-1.org>
	<20180615044042.7928-2-tamiko@43-1.org>
	<20180615094207.GK31552@redhat.com> <8736xorxsr.fsf@43-1.org>
Date: Fri, 15 Jun 2018 17:17:24 +0200
In-Reply-To: <8736xorxsr.fsf@43-1.org> (Matthias Maier's message of "Fri, 15
	Jun 2018 08:20:36 -0500")
Message-ID: <87h8m4yt8b.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/2] Partially revert commit d4e5ec877ca
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Matthias Maier <tamiko@43-1.org>
Cc: "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>, Arfrever Frehtes Taifersar Arahesis <arfrever.fta@gmail.com>, qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>

"Partially revert"?  Which part isn't reverted?

Matthias Maier <tamiko@43-1.org> writes:

> On Fri, Jun 15, 2018, at 04:42 CDT, Daniel P. Berrang=C3=A9 <berrange@red=
hat.com> wrote:
>
>> On Thu, Jun 14, 2018 at 11:40:41PM -0500, Matthias Maier wrote:
>>> This commit removes the PYTHON_UTF8 workaround. The problem with setting
>>>=20
>>>   LC_ALL=3D LANG=3DC LC_CTYPE=3Den_US.UTF-8
>>>=20
>>> is that the en_US.UTF-8 locale might not be available. In this case

The workaround is from

commit d4e5ec877ca698a87dabe68814c6f93668f50c60
Author: Daniel P. Berrange <berrange@redhat.com>
Date:   Tue Jan 16 13:42:11 2018 +0000

    qapi: force a UTF-8 locale for running Python
=20=20=20=20
    Python2 did not validate locale correctness when reading input data, so
    would happily read UTF-8 data in non-UTF-8 locales. Python3 is strict so
    if you try to read UTF-8 data in the C locale, it will raise an error
    for any UTF-8 bytes that aren't representable in 7-bit ascii encoding.
    e.g.

    More background on this can be seen in
=20=20=20=20
      https://www.python.org/dev/peps/pep-0538/
=20=20=20=20
    Many distros support a new C.UTF-8 locale that is like the C locale,
    but with UTF-8 instead of 7-bit ASCII. That is not entirely portable
    though. This patch thus sets the LANG to "C", but overrides LC_CTYPE
    to be en_US.UTF-8 locale. This gets us pretty close to C.UTF-8, but
    in a way that should be portable to everywhere QEMU builds.
=20=20=20=20
    This patch only forces UTF-8 for QAPI scripts, since that is the one
    showing the immediate error under Python3 with C locale, but potentially
    we ought to force this for all python scripts used in the build process.

It's still used only for running QAPI generators.

As far as I can tell, the only non-ASCII input characters are:

* qapi/trace.json

  # Copyright (C) 2011-2016 Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>

* tests/qapi-schema/escape-too-big.json

  # { 'command': '=C3=A9' }

* tests/qapi-schema/unicode-str.json

  { 'command': '=C3=A9' }

I believe these characters made Dan put in the workaround.  We could get
rid of them if the fix is too onerous (I haven't really looked, yet).

>> What platform are you using where  UTF8 locale is not available ?
>
> For example, neither Debian (and for that matter Ubuntu) nor Gentoo
> guarantee that the en_US.UTF-8 locale is available.
>
> We in particular encounter build problems on Gentoo when users have only
> set very specific, non en_US locales, for example de_DE.UTF-8 (or
> similar).
>
>> Indeed I would ideally like to make the entire of QEMU build with an
>> explicit en_US.UTF-8 or C.UTF-8 locale, to ensure that we get reliably
>> reproducible builds, as locale differences have been known to impact
>> output of many tools not just python.
>
> We face the same problem in Gentoo and usually advice users to set
> LC_ALL=3DC when submitting bug reports. (It is frustrating that glibc
> upstream doesn't get their act together fixing and merging the current
> C.UTF-8 proposal.)
>
> So what about making the build system more robust (by merging the
> patches, or a variant) and either setting C.UTF-8, or C globally
> (depending on availability)?

"git-grep -Fi .utf-8" coughs up

    ui/gtk.c:    setlocale(LC_CTYPE, "C.UTF-8");

This runs whenever you pick -display gtk.  Errors are ignored, though.

commit 27b224a61f97faabbd20bdf72c0c1a3dbe400cd1
Author: Kevin Wolf <kwolf@redhat.com>
Date:   Tue Jan 31 11:09:45 2017 +0100

    gtk: Hardcode LC_CTYPE as C.utf-8
=20=20=20=20
    Commit 2cb5d2a4 removed setlocale() for everything except LC_MESSAGES in
    order to avoid unwanted side effects such as using the wrong decimal
    separator in generated JSON objects. However, the problem that unsetting
    LC_CTYPE caused is that non-ASCII characters are considered
    non-printable now and therefore the GTK menus display question marks for
    accented letters, Chinese characters etc.
=20=20=20=20
    A first attempt to fix this [1] was rejected because even just setting
    LC_CTYPE to the user's locale (and thereby modifying the semantics of
    the ctype.h functions) could have unwanted effects that we're not aware
    of yet.
=20=20=20=20
    Recently, however, glibc introduced a new locale "C.utf-8" that just
    uses UTF-8 as its charset, but otherwise leaves the semantics alone.
    Just setting the right character set is enough for our use case, so we
    can just hardcode this one without having to be afraid of nasty side
    effects.
=20=20=20=20
    Older systems that don't have the new locale will continue displaying
    question marks, but this should fix the problem for most users.
=20=20=20=20
    [1] https://lists.gnu.org/archive/html/qemu-devel/2015-12/msg03591.html
        ('Re: gtk: use setlocale() for LC_MESSAGES only')
=20=20=20=20
    Signed-off-by: Kevin Wolf <kwolf@redhat.com>
    Message-id: 20170131100945.8189-1-kwolf@redhat.com
=20=20=20=20
    [ kraxel: change C.utf-8 to C.UTF-8 ]
=20=20=20=20
    Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Looks like your frustration about upstream glibc is quite stale :)
