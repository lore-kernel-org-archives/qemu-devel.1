Received: from eggs.gnu.org ([209.51.188.92]:51159)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1grL5e-0005x8-5C
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 06:10:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1grL5c-0007Yl-22
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 06:10:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:4727)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kchamart@redhat.com>) id 1grL5a-0007Wh-3i
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 06:09:59 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3C87E3E2A4
	for <qemu-devel@nongnu.org>; Wed,  6 Feb 2019 11:09:55 +0000 (UTC)
Date: Wed, 6 Feb 2019 12:09:47 +0100
From: Kashyap Chamarthy <kchamart@redhat.com>
Message-ID: <20190206110947.GU5349@paraplu.home>
References: <20190205134926.8312-1-marcandre.lureau@redhat.com>
	<781b71d9-f045-ffa9-3674-f6222f6e7e0b@redhat.com>
	<20190206104851.GT5349@paraplu.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190206104851.GT5349@paraplu.home>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] qmp-shell: fix nested json regression
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, armbru@redhat.com, Cleber Rosa <crosa@redhat.com>, ehabkost@redhat.com

On Wed, Feb 06, 2019 at 11:48:51AM +0100, Kashyap Chamarthy wrote:
> On Tue, Feb 05, 2019 at 08:44:12PM -0500, John Snow wrote:
> > On 2/5/19 8:49 AM, Marc-Andr=E9 Lureau wrote:

[...]

> > >              < command-name > [ arg-name1=3Darg1 ] ... [ arg-nameN=3D=
argN ]
> > >          """
> > > -        cmdargs =3D shlex.split(cmdline)
> > > +        cmdargs =3D re.findall(r'''(?:[^\s"']|"(?:\\.|[^"])*"|'(?:=
\\.|[^'])*')+''', cmdline)

Dan Berrang=E9 explained on IRC this way:

    In plain english what that is saying is: give me all blocks of text
    which are:
   =20
      (a) set of chars not including " or '
     =20
      (b) a set of chars surrounded by ".."=20
     =20
      (c) a set of chars surrounded by '... =20

> > It might really be nice to have a comment briefly explaining the rege=
x.
> > This is pretty close to symbol soup.
>=20
> Yeah, a little comment explaining it would be nice. =20

For my own education today I learned that ?: is called a "non-capturing
match".  For reference, quoting from the `perldoc perlretut`:

[quote]

  Non-capturing groupings
    A group that is required to bundle a set of alternatives may or may n=
ot
    be useful as a capturing group. If it isn't, it just creates a
    superfluous addition to the set of available capture group values,
    inside as well as outside the regexp. Non-capturing groupings, denote=
d
    by "(?:regexp)", still allow the regexp to be treated as a single uni=
t,
    but don't establish a capturing group at the same time. Both capturin=
g
    and non-capturing groupings are allowed to co-exist in the same regex=
p.
    Because there is no extraction, non-capturing groupings are faster th=
an
    capturing groupings. Non-capturing groupings are also handy for choos=
ing
    exactly which parts of a regexp are to be extracted to matching
    variables:

        # match a number, $1-$4 are set, but we only want $1
        /([+-]?\ *(\d+(\.\d*)?|\.\d+)([eE][+-]?\d+)?)/;

        # match a number faster , only $1 is set
        /([+-]?\ *(?:\d+(?:\.\d*)?|\.\d+)(?:[eE][+-]?\d+)?)/;

        # match a number, get $1 =3D whole number, $2 =3D exponent
        /([+-]?\ *(?:\d+(?:\.\d*)?|\.\d+)(?:[eE]([+-]?\d+))?)/;

    Non-capturing groupings are also useful for removing nuisance element=
s
    gathered from a split operation where parentheses are required for so=
me
    reason:

        $x =3D '12aba34ba5';
        @num =3D split /(a|b)+/, $x;    # @num =3D ('12','a','34','a','5'=
)
        @num =3D split /(?:a|b)+/, $x;  # @num =3D ('12','34','5')

[/quote]

[...]

--=20
/kashyap
