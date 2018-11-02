Received: from eggs.gnu.org ([2001:4830:134:3::10]:37392)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gIbNF-0003qs-Nt
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 11:28:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gIbN1-0003d0-U9
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 11:28:31 -0400
Date: Fri, 2 Nov 2018 16:28:00 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20181102152800.GI7521@dhcp-200-186.str.redhat.com>
References: <20181102085800.21860-1-philmd@redhat.com>
	<20181102110734.GE7521@dhcp-200-186.str.redhat.com>
	<6d96d96b-21f7-d5fc-9313-8ede0f6a745c@redhat.com>
	<20181102141030.GH7521@dhcp-200-186.str.redhat.com>
	<0b2d802d-4b58-30de-44a8-9f04dc968b1b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <0b2d802d-4b58-30de-44a8-9f04dc968b1b@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] qemu/units: Move out QCow2 specific
 definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>, Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, Leonid Bloch <lbloch@janustech.com>, Max Reitz <mreitz@redhat.com>

Am 02.11.2018 um 15:52 hat Eric Blake geschrieben:
> On 11/2/18 9:10 AM, Kevin Wolf wrote:
> > Am 02.11.2018 um 13:37 hat Philippe Mathieu-Daud=E9 geschrieben:
> > > Hi Kevin,
> > >=20
> > > On 2/11/18 12:07, Kevin Wolf wrote:
> > > > Am 02.11.2018 um 09:58 hat Philippe Mathieu-Daud=E9 geschrieben:
> > > > > This definitions are QCow2 specific, there is no need to expose=
 them
> > > > > in the global namespace.
> > > > >=20
> > > > > This partially reverts commit 540b8492618eb.
> > > > >=20
> > > > > Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> > > >=20
> > > > If we don't want this globally, I think we also don't want it in =
qcow2.
>=20
> Agreed. I didn't want it in the first place, arguing that if we want
> stringification of defaults, it would be better to have a runtime funct=
ion
> do that, rather than adding a set of near-duplicate macro names.
>=20
> > >=20
> > > I only see this definitions used by block/qcow2.h (b6a95c6d1007).
> > >=20
> > > Per 540b8492618eb description "This is needed when a size has to be
> > > stringified" but I can't find other code requiring these definition=
s in the
> > > codebase.
> >=20
> > I guess the real question is: Is qcow2 the only place that needs
> > stringification of sizes?
>=20
> Probably not. It seems like stringifying a default value is a common de=
sire.
>=20
> >=20
> > The only value where this actually seems to be used in qcow2 is for
> > DEFAULT_CLUSTER_SIZE, as the default value for QemuOpts. Other driver=
s
> > still use plain numbers, but this is less readable.
> >=20
> > Then there is VDI which uses (1 * MiB), but that is compiled out and =
if
> > you enable it, it breaks. So it needs the same fix.
> >=20
> > Are block drivers the only places where we stringify a size? I imagin=
e
> > some device models might use something like it, too?
>=20
> Indeed, I would prefer a patch that makes it possible for QemuOpts to
> pretty-print a default value using a generic runtime stringifier, rathe=
r
> than keeping these S_ macros around.

The thing is just, QemuOpts is completetly string based. The default
value field is const char*. Either we get rid of QemuOpts and switch
everything to QAPI (nice thought, but a little unrealistic in the short
term), or we add ways to add non-string values to QemuOpts (would
require significant development on a piece of code we want to get rid of
in the long term), or you keep doing stringification at build time
(which I believe is the only reasonable choice at the moment).

Kevin
