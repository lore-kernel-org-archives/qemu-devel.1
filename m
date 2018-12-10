Received: from eggs.gnu.org ([2001:4830:134:3::10]:43613)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <antonkuchin@yandex-team.ru>) id 1gWQx8-0006jX-9s
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 14:10:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <antonkuchin@yandex-team.ru>) id 1gWQx4-0005jN-8L
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 14:10:48 -0500
From: Anton Kuchin <antonkuchin@yandex-team.ru>
Message-ID: <94f9fc23-961c-7109-643b-ba1e8c625d92@yandex-team.ru>
Date: Mon, 10 Dec 2018 22:10:30 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC] block: Is name of BlockBackend deprecated with
 -blockdev parameter?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: wolf@redhat.com, mreitz@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org

Hello,

I'm trying to switch from -drive parameter to -blockdev + -device and=20
having problems. Looks like with this option I have no way to set the=20
name of=C2=A0 created BlockBackend, but some QMP and HMP commands are try=
ing=20
to find blk with blk_by_name() and fail to locate my device (e.g.=20
hmp_commit, qmp_x_bloc_latency_histogram_set ...). Was it intentional=20
and BB names are going to be deprecated?

This also seems to be a the case for all block devices hotplugged with=20
QMP as they use the same code path.

As far as I understand all named backends are stored in=20
monitor_block_backends list, but I can't get what is the point of having=20
this list, and why parse_drive() function doesn't call monitor_add_blk()=20
like blockdev_init() does with -drive option. Can someone give me a hint=20
on this?

I also noticed that some commands fallback to search by qdev_id or=20
BDS->node_name,=C2=A0 but at the creation time (both in bdrv_assing_node_=
name=20
and monitor_add_blk) it is already checked that names are unique across=20
these namespaces so may be it would be useful to introduce generic=20
search function?

Thanks,
Anton
