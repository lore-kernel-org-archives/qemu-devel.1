Received: from eggs.gnu.org ([2001:4830:134:3::10]:36093)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1g9v8z-0001AP-5j
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 12:46:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1g9v8y-000565-79
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 12:46:01 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1535739372-24454-1-git-send-email-Liam.Merwick@oracle.com>
Date: Tue, 09 Oct 2018 18:45:47 +0200
In-Reply-To: <1535739372-24454-1-git-send-email-Liam.Merwick@oracle.com> (Liam
	Merwick's message of "Fri, 31 Aug 2018 19:16:04 +0100")
Message-ID: <87r2gzrrus.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 0/8] off-by-one and NULL pointer
 accesses detected by static analysis
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Liam Merwick <Liam.Merwick@oracle.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, =?utf-8?Q?Daniel_P=2E_Berrang?= =?utf-8?Q?=C3=A9?= <berrange@redhat.com>, John Snow <jsnow@redhat.com>

I'm afraid this fell through the cracks, most likely because you
neglected to cc: maintainers.  I'm doing that for you now.  Next time,
feed your patches to scripts/get_maintainer.pl for suggestions on whom
to copy.  Thanks!

Liam Merwick <Liam.Merwick@oracle.com> writes:

> Below are a number of fixes to some off-by-one, read outside array bounds=
, and
> NULL pointer accesses detected by an internal Oracle static analysis tool=
 (Parfait).
> https://labs.oracle.com/pls/apex/f?p=3Dlabs:49:::::P49_PROJECT_ID:13
>
> I have also included a patch to add a command-line option to configure to
> select if AVX2 is used or not (keeping the existing behaviour by default).
> My motivation was avoiding an issue with the static analysis tool but Net=
Spectre
> was announced as I was working on this and I felt it may have more genera=
l uses.
>
> v1 -> v2
> Based on feedback from Eric Blake:
> patch2: reworded commit message to clarify issue
> patch6: Reverted common qlist routines and added assert to qlist_dump ins=
tead
> patch7: Fixed incorrect logic
> patch8: Added QEMU_BUILD_BUG_ON to catch future =D1=96nstance at compile-=
time
>
> v2 -> v3
> Based on feedback from Eric Blake:
> patch6: removed double space from commit message
> patch8: removed unnecessary comment and updated QEMU_BUILD_BUG_ON to use =
ARRAY_SIZE
> Added Eric's R-b to patches 6,7,8
>
> Liam Merwick (8):
>   configure: Provide option to explicitly disable AVX2
>   job: Fix off-by-one assert checks for JobSTT and JobVerbTable
>   block: Null pointer dereference in blk_root_get_parent_desc()
>   qemu-img: potential Null pointer deref in img_commit()
>   block: Fix potential Null pointer dereferences in vvfat.c
>   block: dump_qlist() may dereference a Null pointer
>   io: potential unnecessary check in qio_channel_command_new_spawn()
>   qcow2: Read outside array bounds in qcow2_pre_write_overlap_check()
>
>  block/block-backend.c  |  2 +-
>  block/qapi.c           |  2 ++
>  block/qcow2-refcount.c | 18 ++++++++--------
>  block/vvfat.c          | 56 ++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  configure              | 11 ++++++++--
>  io/channel-command.c   |  3 +--
>  job.c                  |  4 ++--
>  qemu-img.c             |  3 +++
>  8 files changed, 84 insertions(+), 15 deletions(-)
