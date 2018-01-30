Received: from eggs.gnu.org ([2001:4830:134:3::10]:56913)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1egcFz-0004oN-Rs
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 15:13:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1egcEs-0003Ut-JC
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 15:11:51 -0500
References: <20180130083532.GA31511@localhost>
From: John Snow <jsnow@redhat.com>
Message-ID: <b5c53de8-64c7-41df-d0ba-009962a18b9e@redhat.com>
Date: Tue, 30 Jan 2018 15:08:34 -0500
MIME-Version: 1.0
In-Reply-To: <20180130083532.GA31511@localhost>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] block/mirror: change the semantic of
 'force' of block-job-cancel
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>
Cc: Liang Li <liliang.opensource@gmail.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org, Liang Li <liliangleo@didichuxing.com>, Huaitong Han <huanhuaitong@didichuxing.com>



On 01/30/2018 03:38 AM, Liang Li wrote:
> When doing drive mirror to a low speed shared storage, if there was hea=
vy
> BLK IO write workload in VM after the 'ready' event, drive mirror block=
 job
> can't be canceled immediately, it would keep running until the heavy BL=
K IO
> workload stopped in the VM.
>=20
> Because libvirt depends on block-job-cancel for block live migration, t=
he
> current block-job-cancel has the semantic to make sure data is in sync =
after
> the 'ready' event.  This semantic can't meet some requirement, for exam=
ple,
> people may use drive mirror for realtime backup while need the ability =
of
> block live migration. If drive mirror can't not be cancelled immediatel=
y,
> it means block live migration need to wait, because libvirt make use dr=
ive
> mirror to implement block live migration and only one drive mirror bloc=
k
> job is allowed at the same time for a give block dev.
>=20
> We need a new interface for 'force cancel', which could quit block job
> immediately if don't care about whether data is in sync or not.
>=20
> 'force' is not used by libvirt currently, to make things simple, change
> it's semantic slightly, hope it will not break some use case which need=
 its
> original semantic.
>=20
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Jeff Cody <jcody@redhat.com>
> Cc: Kevin Wolf <kwolf@redhat.com>
> Cc: Max Reitz <mreitz@redhat.com>
> Cc: Eric Blake <eblake@redhat.com>
> Cc: John Snow <jsnow@redhat.com>
> Reported-by: Huaitong Han <huanhuaitong@didichuxing.com>
> Signed-off-by: Huaitong Han <huanhuaitong@didichuxing.com>
> Signed-off-by: Liang Li <liliangleo@didichuxing.com>

Just a note to JTC that this will conflict with my two series trying to
refactor jobs:

(1) [Qemu-devel] [PATCH v2 00/13] blockjob: refactor mirror_throttle
(2) [Qemu-devel] [RFC v3 00/14] blockjobs: add explicit job management=E2=
=80=8B
