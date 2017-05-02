Received: from eggs.gnu.org ([2001:4830:134:3::10]:48035)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d5YnR-0003DJ-UQ
	for qemu-devel@nongnu.org; Tue, 02 May 2017 10:28:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d5YnP-0004hw-Ub
	for qemu-devel@nongnu.org; Tue, 02 May 2017 10:28:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32866)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1d5YnP-0004gF-Ma
	for qemu-devel@nongnu.org; Tue, 02 May 2017 10:28:55 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 92D17C395D
	for <qemu-devel@nongnu.org>; Tue,  2 May 2017 14:28:54 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170502083500.GA27432@redhat.com>
Date: Tue, 02 May 2017 16:28:52 +0200
In-Reply-To: <20170502083500.GA27432@redhat.com> (Richard W. M. Jones's
	message of "Tue, 2 May 2017 09:35:00 +0100")
Message-ID: <87y3ufjpsr.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Writing a C library to generate qemu command lines
 and configuration files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Richard W.M. Jones" <rjones@redhat.com>
Cc: QEMU Development <qemu-devel@nongnu.org>

"Richard W.M. Jones" <rjones@redhat.com> writes:

> Firstly, is there such a thing already?  (libvirt doesn't count since
> it cannot generate -readconfig configuration files)

I'm not aware of no such thing.

> Well, I have written one.  It's in C and doesn't have any dependencies
> beyond the standard C library:
>
>   https://github.com/rwmjones/libguestfs/tree/max-disks/common/qemuopts
>
> It models command line parameters as either flags (eg. =E2=80=98-nodefcon=
fig=E2=80=99),
> flags with a single argument (=E2=80=98-name guest=E2=80=99), or flags ta=
king a list
> (eg. =E2=80=98-drive file=3Dfoo,id=3Dbar=E2=80=99 modeled as a list of st=
rings).

See "option arguments values have become trees" below.

> I'm immediately aware that there are shortcomings with this approach
> (see below).  Is there a better model to use for qemu command line
> options that also allows -readconfig config files to be generated?
>
> Some of the more obvious problems:
>
> * I don't know if single flags can be translated into config files.

They can't.  -readconfig/-writeconfig cover only options implemented
with QemuOpts.

> * Config files treat the "id=3D.." parameter as special, eg:
>   =E2=80=98-drive file=3Dfoo,id=3Dbar=E2=80=99 is translated to:
>
>   [drive "bar"]
>     file =3D "foo"

Yes.

> * There's no clear mapping between some command line parameters and
>   the config file, eg. =E2=80=98-m 2048 -kernel foo=E2=80=99 should be tr=
anslated into:
>
>   [memory]
>     size =3D "2048"
>   [machine]
>     kernel =3D "foo"
>
>   but my library couldn't do that translation without a look-up table
>   that would duplicate the internals of qemu.

Yes.  Two problems:

* The configuration group name (the thing right after '[') by convention
  matches the command line option name.  Since the convention isn't
  enforced, screwups have crept in.  For instance, [boot-opts] matches
  -boot, and [memory] matches -m.  We suck.  Also plagues
  query-command-line-options.

* Even when it matches, it can only match the *unsugared* option name,
  not its various sugared forms.  For instance, -kernel ARG is sugar for
  -machine kernel=3DARG.

> There are also unknown unknowns:
>
> * Is comma-quoting (ie. doubling any commas) sufficient?  Or are there
>   other forms of quoting?  A quick look at options parsing in qemu
>   doesn't show any.

A quick look at QemuOpts will at best confuse, and possibly deceive.

The beginnings of its replacement in util/keyval.c comes with a *gasp*
grammar.  It doesn't have all of QemuOpts bells & whistles, at least not
yet.  You might find it useful anyway.

To answer your question: you have to double comma after '=3D', or else it
terminates the value.  There is no other quoting.

> * From the point of view of a client generating command lines, is there
>   any significance to dotted names (eg. =E2=80=98-drive file.driver=3Dssh=
,...=E2=80=99)

Right now, you can still pretend dotted names are just names.

But option arguments have really become trees.  We've shoehorned them
into the existing command line syntax with dotted keys.  Design
discussion, if you're interested:

    Subject: Non-flat command line option argument syntax
    Message-ID: <87bmukmlau.fsf@dusky.pond.sub.org>
    https://lists.gnu.org/archive/html/qemu-devel/2017-02/msg00555.html

Implementation is the keyval.c mentioned above.

I'm not sure baking "option argument is a list of (key, string) pairs,
where both key and string are strings" into your library now is a good
idea.  Perhaps it would be better to embrace "option argument is a tree"
from the start.

In the longer run, I intend to make -readconfig (or its replacement)
accept JSON, because it supports trees directly, and is less badly
defined.

We might deprecate the Windows INI syntax then.

This might leave you with more questions.  Please don't hesitate to ask
me.
