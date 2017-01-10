Received: from eggs.gnu.org ([2001:4830:134:3::10]:46651)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cQyuC-00065Q-JI
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 11:04:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cQyu7-0005Ht-BV
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 11:04:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51268)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cQyu7-0005Hl-60
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 11:04:07 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 39C0112B27
	for <qemu-devel@nongnu.org>; Tue, 10 Jan 2017 16:04:07 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170109143437.30554-1-marcandre.lureau@redhat.com>
	<20170109143437.30554-13-marcandre.lureau@redhat.com>
	<87wpe3qf2a.fsf@dusky.pond.sub.org>
	<724269411.621337.1484052915061.JavaMail.zimbra@redhat.com>
Date: Tue, 10 Jan 2017 17:04:04 +0100
In-Reply-To: <724269411.621337.1484052915061.JavaMail.zimbra@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Tue, 10 Jan 2017
	07:55:15 -0500 (EST)")
Message-ID: <87d1fuoqa3.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v7 12/21] qapi.py: fix line break before
 binary operator pep8
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <mlureau@redhat.com>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org

Marc-Andr=C3=A9 Lureau <mlureau@redhat.com> writes:

> Hi
>
> ----- Original Message -----
>> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>>=20
>> > Python code style accepts both form, but pep8 complains. Better to cle=
an
>> > up the single warning for now, so new errors stand out more easily.
>> >
>> > Fix scripts/qapi.py:1539:21: W503 line break before binary operator
>>=20
>> PEP 8 permits both, but prefers line break before binary operator.
>> Thus, this warning is clearly bogus.  What version of pep8 do you use?
>> Mine doesn't warn.
>
> I tried both 1.6.2 and 1.7.0

I tried again, and I can now see the warning.  No idea what I did wrong
the first time.

Turns out PEP8 used to demand line break after the operator, but no
more[1].  The pep8 program hasn't caught up, but it will[2]: its current
git HEAD already suppresses W503.  There's work in progress[3] on a new
W504 to warn on line break after binary operator.

We will have to live with a mix of old and new pep8 / pycodestyle
versions.  Changing code to make new versions instead of old versions
complain instead is not a good idea.  We should simply ignore the
obsolete warning from old versions.

pep8 lets you do that with --ignore=3DW503.  Sadly, --ignore overwrites
the default, so you have to --ignore=3DE121,E123,E126,E226,E24,E704,W503.
Or have a file tox.ini with

    [pep8]
    ignore=3DE121,E123,E126,E226,E24,E704,W503


[1] https://hg.python.org/peps/rev/3857909d7956
[2] https://github.com/PyCQA/pycodestyle/issues/498
[3] https://github.com/PyCQA/pycodestyle/pull/502
