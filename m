Received: from eggs.gnu.org ([2001:4830:134:3::10]:35191)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fXSzJ-0006CB-4U
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 11:01:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fXSzF-0006AH-7S
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 11:01:05 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43658 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fXSzF-00069L-1B
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 11:01:01 -0400
Date: Mon, 25 Jun 2018 16:00:57 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180625150056.GF2390@work-vm>
References: <20180601153922.11590-1-ricardo.perez_blanco@nokia.com>
	<a51fbf8b-9839-ebc1-cde5-5ae95656f918@suse.de>
	<20180608094101.GG2671@work-vm>
	<0cc71e01-7015-8f8b-6988-d3b411d3b28c@suse.de>
	<87y3fky231.fsf@dusky.pond.sub.org>
	<87h8lrumny.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <87h8lrumny.fsf@dusky.pond.sub.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] Show values and description when using
 "qom-list"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>, Ricardo Perez Blanco <ricardo.perez_blanco@nokia.com>, qemu-devel <qemu-devel@nongnu.org>, Dongli Zhang <dongli.zhang@oracle.com>

* Markus Armbruster (armbru@redhat.com) wrote:
> Markus Armbruster <armbru@redhat.com> writes:
>=20
> > Andreas F=E4rber <afaerber@suse.de> writes:
> >
> >> Am 08.06.2018 um 11:41 schrieb Dr. David Alan Gilbert:
> >>> * Andreas F=E4rber (afaerber@suse.de) wrote:
> >>>> Am 01.06.2018 um 17:39 schrieb Ricardo Perez Blanco:
> >>>>> For debugging purposes it is very useful to:
> >>>>>  - See the description of the field. This information is already =
filled
> >>>>>    in but not shown in "qom-list" command.
> >>>>
> >>>> No objection on this part.
> >>>>
> >>>>>  - Display value of the field.
> >>>>
> >>>> That is by definition the qom-get operation, not qom-list. Just li=
ke the
> >>>> ls command does not show file contents, there's cat etc. for that.=
 For
> >>>> debugging purposes we had a qom-tree (?) command that would combin=
e
> >>>> both.
> >>>
> >>> I'm not too bothered about distinguishing between the two commands;
> >>> but it would be nice
> >
> > When an HMP and QMP both have a command with the same name, they shou=
ld
> > do the same.
> >
> > HMP may add convenience features that aren't wanted in QMP, but I fee=
l
> > extending an operation to list objects to also show their contents go=
es
> > beyond that.  If we want an HMP command that does both, it should be
> > named differently.  Perhaps that might even be more appropriate for H=
MP
> > than low-level commands qom-list and qom-get, but I leave that to the
> > HMP maintainer to decide.
> >
> >>>                      - one reason I'm not too bothered is because w=
e've
> >>> failed to get a qom-get in multiple years of trying.
> >
> > We clearly haven't tried hard enough.
> >
> > If we can figure out how to show values in qom-list, surely we can
> > figure out how to show them in qom-get.
> >
> >>>>       There might be unmerged patches on qemu-devel related to dis=
play
> >>>> of certain data types.
> >>>=20
> >>> Which ones?
> >>
> >> My original qom-info series needed StringOutputVisitor changes for e=
nums
> >> (test case: rtc) that did not get accepted immediately and thus some
> >> part of HMP qom-info/qom-get got stuck due to risking assertions for
> >> qom-info / otherwise; QMP was not affected IIRC.
> >
> > Here's the last try I can find:
> > [PATCH v2] qom: Implement qom-get HMP command
> > Message-Id: <1473157086-12062-1-git-send-email-dgilbert@redhat.com>
> > https://lists.gnu.org/archive/html/qemu-devel/2016-09/msg01041.html
>=20
> Stalled on output format and consistency with qom-set.  I wrote back
> then "We can take qom-get as is and improve its output later."  I'd lik=
e
> to encourage you to dust it off.  Perfect's the enemy of good.
>=20
> Wanted improvements include:
>=20
> * Prettier output format.  I'd suggest creating a keyval variant of the
>   output visitor.

I'm not too bothered about pretty at first, as long as we don't stop
anyway of making it pretty later; especially if non-compound types work
well.

> * Make qom-set input format consistent by switching to the matching
>   input visitor.
>=20
> > Its v1 tries a different approach:
> > [PATCH 0/2] qom-get [for 2.8]
> > Message-Id: <1472117833-10236-1-git-send-email-dgilbert@redhat.com>
> > Unfortunately the mailing list archive doesn't show the full thread, =
so
> > you get to follow three links:
> > https://lists.gnu.org/archive/html/qemu-devel/2016-08/msg03815.html
> > https://lists.gnu.org/archive/html/qemu-devel/2016-09/msg04261.html
> > https://lists.gnu.org/archive/html/qemu-devel/2016-09/msg04267.html
>=20
> This one stalled on string visitor limitations.  You didn't feel like
> addressing them just to get qom-get working.  Understandable.

Have there been any changes in the last 2 years that have helped?

Dave

--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
