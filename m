Received: from eggs.gnu.org ([2001:4830:134:3::10]:42452)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gIaA0-0000Qp-8l
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 10:10:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gIa9z-0005oQ-Hd
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 10:10:52 -0400
Date: Fri, 2 Nov 2018 15:10:30 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20181102141030.GH7521@dhcp-200-186.str.redhat.com>
References: <20181102085800.21860-1-philmd@redhat.com>
	<20181102110734.GE7521@dhcp-200-186.str.redhat.com>
	<6d96d96b-21f7-d5fc-9313-8ede0f6a745c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <6d96d96b-21f7-d5fc-9313-8ede0f6a745c@redhat.com>
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
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>, Leonid Bloch <lbloch@janustech.com>, Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>

Am 02.11.2018 um 13:37 hat Philippe Mathieu-Daud=E9 geschrieben:
> Hi Kevin,
>=20
> On 2/11/18 12:07, Kevin Wolf wrote:
> > Am 02.11.2018 um 09:58 hat Philippe Mathieu-Daud=E9 geschrieben:
> > > This definitions are QCow2 specific, there is no need to expose the=
m
> > > in the global namespace.
> > >=20
> > > This partially reverts commit 540b8492618eb.
> > >=20
> > > Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> >=20
> > If we don't want this globally, I think we also don't want it in qcow=
2.
>=20
> I only see this definitions used by block/qcow2.h (b6a95c6d1007).
>=20
> Per 540b8492618eb description "This is needed when a size has to be
> stringified" but I can't find other code requiring these definitions in=
 the
> codebase.

I guess the real question is: Is qcow2 the only place that needs
stringification of sizes?

The only value where this actually seems to be used in qcow2 is for
DEFAULT_CLUSTER_SIZE, as the default value for QemuOpts. Other drivers
still use plain numbers, but this is less readable.

Then there is VDI which uses (1 * MiB), but that is compiled out and if
you enable it, it breaks. So it needs the same fix.

Are block drivers the only places where we stringify a size? I imagine
some device models might use something like it, too?

I don't mind too much which solution we end up using, but I'd prefer it
to be universal.

Kevin
