Received: from eggs.gnu.org ([2001:4830:134:3::10]:36665)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gWedO-00073m-Q4
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 04:47:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gWedN-0005HN-V7
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 04:47:22 -0500
Date: Tue, 11 Dec 2018 10:47:09 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20181211094709.GA31849@localhost.localdomain>
References: <94f9fc23-961c-7109-643b-ba1e8c625d92@yandex-team.ru>
	<87h8fkbjyn.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <87h8fkbjyn.fsf@dusky.pond.sub.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC] block: Is name of BlockBackend deprecated
 with -blockdev parameter?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Anton Kuchin <antonkuchin@yandex-team.ru>, qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com

Am 11.12.2018 um 08:28 hat Markus Armbruster geschrieben:
> I figure Kevin knows, but you typoed his e-mail address.  I fixed it fo=
r
> you.
>=20
> Anton Kuchin <antonkuchin@yandex-team.ru> writes:
>=20
> > Hello,
> >
> > I'm trying to switch from -drive parameter to -blockdev + -device and
> > having problems. Looks like with this option I have no way to set the
> > name of=A0 created BlockBackend, but some QMP and HMP commands are
> > trying to find blk with blk_by_name() and fail to locate my device
> > (e.g. hmp_commit, qmp_x_bloc_latency_histogram_set ...). Was it
> > intentional and BB names are going to be deprecated?
> >
> > This also seems to be a the case for all block devices hotplugged wit=
h
> > QMP as they use the same code path.
> >
> > As far as I understand all named backends are stored in
> > monitor_block_backends list, but I can't get what is the point of
> > having this list, and why parse_drive() function doesn't call
> > monitor_add_blk() like blockdev_init() does with -drive option. Can
> > someone give me a hint on this?
> >
> > I also noticed that some commands fallback to search by qdev_id or
> > BDS->node_name,=A0 but at the creation time (both in
> > bdrv_assing_node_name and monitor_add_blk) it is already checked that
> > names are unique across these namespaces so may be it would be useful
> > to introduce generic search function?

Yes, BlockBackend names are not supposed to be used in the external
interfaces any more. If the QMP command is about the backend, it will
take a node name, and if it's about the guest device (which may not even
have a node attached with removable media), it will take a qdev ID.

The implementation of qmp_x_block_latency_histogram_set() is incorrect,
it shouldn't use blk_by_name(). I wonder where it got that pattern from
because it was added long after all other QMP commands had switched to
qmp_get_blk() or bdrv_lookup_bs().

hmp_commit() should indeed use bdrv_lookup_bs() to also accept node
names. I think we reviewed QMP to make sure we converted everything
and forgot about HMP commands that aren't mapped to QMP.

Kevin
