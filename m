Received: from eggs.gnu.org ([2001:4830:134:3::10]:54005)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ashijeetacharya@gmail.com>) id 1cOfSV-0007eV-A9
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 01:54:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ashijeetacharya@gmail.com>) id 1cOfSU-0002L3-F4
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 01:54:03 -0500
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:34826)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ashijeetacharya@gmail.com>)
	id 1cOfSU-0002KJ-9n
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 01:54:02 -0500
Received: by mail-oi0-x242.google.com with SMTP id v84so73146714oie.2
	for <qemu-devel@nongnu.org>; Tue, 03 Jan 2017 22:54:00 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20161216113728.77671b1a@bahia.lan>
References: <1481882024-10016-1-git-send-email-ashijeetacharya@gmail.com>
	<1481882024-10016-4-git-send-email-ashijeetacharya@gmail.com>
	<20161216113728.77671b1a@bahia.lan>
From: Ashijeet Acharya <ashijeetacharya@gmail.com>
Date: Wed, 4 Jan 2017 12:23:59 +0530
Message-ID: <CAC2QTZYW_zpWuQ6Vg_zDMU8fs_7GdGPayA2NvzG-M-S9zPdiTA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v2 3/4] migration: disallow
 migrate_add_blocker during migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: "dgilbert@redhat.com" <dgilbert@redhat.com>, John Snow <jsnow@redhat.com>, amit.shah@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, quintela@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>, marcandre.lureau@redhat.com, aneesh.kumar@linux.vnet.ibm.com, Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

On Fri, Dec 16, 2016 at 4:07 PM, Greg Kurz <groug@kaod.org> wrote:
> On Fri, 16 Dec 2016 15:23:43 +0530
> Ashijeet Acharya <ashijeetacharya@gmail.com> wrote:
>
>> If a migration is already in progress and somebody attempts
>> to add a migration blocker, this should rightly fail.
>>
>> Add an errp parameter and a retcode return value to migrate_add_blocker.
>>
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> Signed-off-by: Ashijeet Acharya <ashijeetacharya@gmail.com>
>> ---
>>  block/qcow.c                  |  6 +++++-
>>  block/vdi.c                   |  6 +++++-
>>  block/vhdx.c                  | 16 ++++++++++------
>>  block/vmdk.c                  |  7 ++++++-
>>  block/vpc.c                   | 10 +++++++---
>>  block/vvfat.c                 | 20 ++++++++++++--------
>>  hw/9pfs/9p.c                  | 16 ++++++++++++----
>>  hw/display/virtio-gpu.c       | 29 ++++++++++++++++-------------
>>  hw/intc/arm_gic_kvm.c         | 16 ++++++++++------
>>  hw/intc/arm_gicv3_its_kvm.c   | 18 +++++++++++-------
>>  hw/intc/arm_gicv3_kvm.c       | 19 ++++++++++++-------
>>  hw/misc/ivshmem.c             | 11 +++++++----
>>  hw/scsi/vhost-scsi.c          | 25 +++++++++++++++++++------
>>  hw/virtio/vhost.c             |  8 +++++++-
>>  include/migration/migration.h |  6 +++++-
>>  migration/migration.c         | 35 +++++++++++++++++++++++++++++++++--
>>  stubs/migr-blocker.c          |  3 ++-
>>  target-i386/kvm.c             | 16 +++++++++++++---
>>  18 files changed, 192 insertions(+), 75 deletions(-)
>>
>> diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
>> index faebd91..e72ef43 100644
>> --- a/hw/9pfs/9p.c
>> +++ b/hw/9pfs/9p.c
>> @@ -1013,20 +1013,28 @@ static void coroutine_fn v9fs_attach(void *opaque)
>>          goto out;
>>      }
>>      err += offset;
>> -    memcpy(&s->root_qid, &qid, sizeof(qid));
>> -    trace_v9fs_attach_return(pdu->tag, pdu->id,
>> -                             qid.type, qid.version, qid.path);
>> +
>>      /*
>>       * disable migration if we haven't done already.
>>       * attach could get called multiple times for the same export.
>>       */
>>      if (!s->migration_blocker) {
>> +        int ret;
>>          s->root_fid = fid;
>
> Since we may fail now, I guess ^^ should move...
>
>>          error_setg(&s->migration_blocker,
>>                     "Migration is disabled when VirtFS export path '%s' is mounted in the guest using mount_tag '%s'",
>>                     s->ctx.fs_root ? s->ctx.fs_root : "NULL", s->tag);
>> -        migrate_add_blocker(s->migration_blocker);
>> +        ret = migrate_add_blocker(s->migration_blocker, NULL);
>> +        if (ret < 0) {
>> +            err = ret;
>> +            clunk_fid(s, fid);
>
> Please don't rely on put_fid() to rollback what was done in this
> function. You need to do the following here:
> - error_free(s->migration_blocker)
> - s->migration_blocker = NULL

Okay, I was not aware of this. I have added these two now.

>
>> +            goto out;
>> +        }
>
>           s->root_fid = fid;
>
> ... here.

Right. I missed out on this one. I have moved it now.

Ashijeet
>
>>      }
>> +
>> +    memcpy(&s->root_qid, &qid, sizeof(qid));
>> +    trace_v9fs_attach_return(pdu->tag, pdu->id,
>> +                             qid.type, qid.version, qid.path);
>>  out:
>>      put_fid(pdu, fidp);
>>  out_nofid:
