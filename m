Received: from eggs.gnu.org ([2001:4830:134:3::10]:57880)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dhrJI-0007va-9o
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 01:56:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dhrJH-0002lx-Er
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 01:56:08 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <3f54377d.5e06.15de49ec4d5.Coremail.zhang_youjia@126.com>
Date: Wed, 16 Aug 2017 07:55:58 +0200
In-Reply-To: <3f54377d.5e06.15de49ec4d5.Coremail.zhang_youjia@126.com>
	(=?utf-8?B?IsOVw4XDk8ORwrzDkyIncw==?= message of "Tue,
	15 Aug 2017 14:39:56 +0800 (CST)")
Message-ID: <87h8x8f441.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] a tiny tool for checking and repairing damaged
 qcow2 image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?B?w5XDhcOTw5HCvMOT?= <zhang_youjia@126.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org

Cc'ing QCOW2 maintainer.

=C3=95=C3=85=C3=93=C3=91=C2=BC=C3=93 <zhang_youjia@126.com> writes:

> Hi,
>
> I want to introduce a tiny tool(https://github.com/zhangyoujia/qcow2-dump=
) for checking and repairing damaged qcow2 image.
>
> I met many damaged qcow2 images when I work.
>
> It does't always work by using the qemu-img command to check and repair t=
hese damaged qcow2 images.
>
> The functions of the qemu-img check command are too limited for developer=
s.
>
> It's difficult to known where is damaged, and difficult to repair the dam=
age too.
>
> For example: more than one active L2 entries point to the same active clu=
ster(mostly caused by refcount error), such as:
>
> Active Cluster:
> ----------------------------------------------------------------
> REUSED cluster offset: 0x44000000 | l1_index:    2, l2_index: 1017 | refc=
ount: 2
> REUSED cluster offset: 0x44000000 | l1_index:   12, l2_index: 7780
>
> REUSED cluster offset: 0x45000000 | l1_index:    2, l2_index: 1273 | refc=
ount: 2
> REUSED cluster offset: 0x45000000 | l1_index:   12, l2_index: 6742
>
> REUSED cluster offset: 0x4a000000 | l1_index:    2, l2_index: 2553 | refc=
ount: 2
> REUSED cluster offset: 0x4a000000 | l1_index:   12, l2_index: 7068
>
> The results of qemu-img check command are wrong which only show refcount =
errors and copied errors, but do not show the active cluster reused errors.=
 so if you use qemu-img check -r sub-command to repair this qcow2 image, it=
 only increases refcount of the reused cluster, but does not rebuild the re=
used active cluster. that does't work. (eg: reused_active_cluster.png)
>
> That's why I want to make a tool has more functions.
>
> qcow2-dump has some improvements compare with qemu-img check command:
>
> 1. -m check: output the status of qcow2 image and statistics of metadata.=
 (eg: rebuild_refcount_table.png)
>
> 2. -m error: output of -m check + the damaged positions of qcow2 image. (=
eg: reused_active_cluster.png & error.tgz)
>
> 3. -m dump: output of -m error + dump all metadata of qcow2 image. (eg: d=
ump.tgz)
>
>
> qcow2-dump also has some functions for repairing damaged qcow2 image:
>
> 1. rebuild damaged refcount table. (eg: rebuild_refcount_table.png)
>    qcow2-dump -R all rebuild_refcount_table.qcow2
>
> 2. rebuild reused active cluster. (eg: reused_active_cluster.png)
>    qcow2-dump -R all -r reused_active_cluster.qcow2
>
> 3. delete damaged qcow2 snapshot header. (eg: invalid_snapshot_header.png)
>    qcow2-dump -D snapshot[0] vm-disk-2.qcow2
>
> 4. -m edit / -m copy: for repairing some special damage.  (eg: comments o=
f qcow2_edit_modify is a instance)
>
> ...
>
> But this tool is not good enough yet, hope to receive your advices to imp=
rove it.
>
> Best wishes
> youplus
