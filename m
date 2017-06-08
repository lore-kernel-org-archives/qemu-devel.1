Received: from eggs.gnu.org ([2001:4830:134:3::10]:35121)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dIwxe-0002MF-H2
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 08:54:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dIwxd-0001Y8-Lz
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 08:54:50 -0400
References: <20170531094330.1808-1-pbonzini@redhat.com>
	<20170608125231.GJ4145@stefanha-x1.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b69609f1-7b1e-147b-aae0-c9c03656be71@redhat.com>
Date: Thu, 8 Jun 2017 14:54:38 +0200
MIME-Version: 1.0
In-Reply-To: <20170608125231.GJ4145@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 00/11] Block layer thread-safety, part 2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com



On 08/06/2017 14:52, Stefan Hajnoczi wrote:
> On Wed, May 31, 2017 at 11:43:19AM +0200, Paolo Bonzini wrote:
>> This part takes care of drivers and devices, making sure that they can
>> accept concurrent I/O from multiple AioContext.  Only RFC for now beca=
use it
>> depends on Kevin's QED conversion to coroutines, which is still in flu=
x.
>>
>> The following drivers are thread-safe without using any QemuMutex/CoMu=
tex:
>> crypto, gluster, null, rbd, win32-aio.
>>
>> The following drivers already use mutexes for everything except possib=
ly
>> snapshots, which do not (yet?) need protection: bochs, cloop, dmg, qco=
w,
>> parallels, vhdx, vmdk, curl, iscsi, nfs.
>>
>> The following drivers already use mutexes for _almost_ everything: vpc
>> (missing get_block_status), vdi (missing bitmap access), vvfat (missin=
g
>> commit), nbd (s->in_flight not protected), qcow2 (must call CoQueue AP=
Is
>> under CoMutex).  They are fixed by patches 1-6.
>>
>> The following drivers must be changed to use CoMutex to protect intern=
al
>> data: qed (patches 7-9), sheepdog (patch 10).
>>
>> The following driver must be changed to support I/O from any AioContex=
t:
>> ssh.  It is fixed by patch 11.
>>
>> Paolo
>>
>> Paolo Bonzini (11):
>>   qcow2: call CoQueue APIs under CoMutex
>>   coroutine-lock: add qemu_co_rwlock_downgrade and qemu_co_rwlock_upgr=
ade
>>   vdi: make it thread-safe
>>   vpc: make it thread-safe
>>   vvfat: make it thread-safe
>>   nbd: make it thread-safe
>>   qed: move tail of qed_aio_write_main to qed_aio_write_{cow,alloc}
>>   block: invoke .bdrv_drain callback in coroutine context and from Aio=
Context
>>   qed: protect table cache with CoMutex
>>   sheepdog: add queue_lock
>>   ssh: support I/O from any AioContext
>>
>>  block/io.c                 |  42 +++++++---
>>  block/nbd-client.c         |  30 +++----
>>  block/qcow2.c              |   4 +-
>>  block/qed-cluster.c        |   4 +-
>>  block/qed-l2-cache.c       |   6 ++
>>  block/qed-table.c          |  24 ++++--
>>  block/qed.c                | 195 +++++++++++++++++++++++++++---------=
---------
>>  block/qed.h                |  11 ++-
>>  block/sheepdog.c           |  21 ++++-
>>  block/ssh.c                |  24 ++++--
>>  block/vdi.c                |  48 +++++------
>>  block/vpc.c                |  20 ++---
>>  block/vvfat.c              |   8 +-
>>  include/block/block_int.h  |   2 +-
>>  include/qemu/coroutine.h   |  19 +++++
>>  util/qemu-coroutine-lock.c |  35 ++++++++
>>  16 files changed, 326 insertions(+), 167 deletions(-)
>>
>> --=20
>> 2.13.0
>=20
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

Thanks, I'll repost once QED is converted to coroutines, and send part 3
when I have some time.

Paolo
