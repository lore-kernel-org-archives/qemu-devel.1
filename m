Received: from eggs.gnu.org ([2001:4830:134:3::10]:38694)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Antonios.Motakis@huawei.com>) id 1emd68-0003nL-JY
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 05:18:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Antonios.Motakis@huawei.com>) id 1emd65-0006lJ-Dp
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 05:18:32 -0500
Received: from lhrrgout.huawei.com ([194.213.3.17]:44263 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Antonios.Motakis@huawei.com>)
	id 1emd65-0006l5-3z
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 05:18:29 -0500
References: <20180208180019.13683-1-antonios.motakis@huawei.com>
	<20180208180019.13683-3-antonios.motakis@huawei.com>
	<20180209140331.6c2b36a2@bahia.lan>
From: Antonios Motakis <antonios.motakis@huawei.com>
Message-ID: <875f6ecf-5592-5dc8-86aa-36c8c49b3ab4@huawei.com>
Date: Fri, 16 Feb 2018 11:19:35 +0100
MIME-Version: 1.0
In-Reply-To: <20180209140331.6c2b36a2@bahia.lan>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 2/4] 9pfs: check for file device to avoid
 QID path collisions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, veaceslav.falico@huawei.com, Eduard.Shishkin@huawei.com, andy.wangguoli@huawei.com, Jani.Kokkonen@huawei.com, cota@braap.org, berrange@redhat.com



On 02/09/2018 02:03 PM, Greg Kurz wrote:
> On Thu, 8 Feb 2018 19:00:17 +0100
> <antonios.motakis@huawei.com> wrote:
>
>> From: Antonios Motakis <antonios.motakis@huawei.com>
>>
>> The QID path should uniquely identify a file. However, the
>> inode of a file is currently used as the QID path, which
>> on its own only uniquely identifies wiles within a device.
>                                        ^^^^^
>                                      s/wiles/files
>
>> Here we track the device hosting the 9pfs share, in order
>> to prevent security issues with QID path collisions from
>> other devices.
>>
>> Signed-off-by: Antonios Motakis <antonios.motakis@huawei.com>
>> ---
>>   hw/9pfs/9p.c | 67 +++++++++++++++++++++++++++++++++++++++++++++++-------------
>>   hw/9pfs/9p.h |  1 +
>>   2 files changed, 54 insertions(+), 14 deletions(-)
>>
>> diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
>> index 85a1ed8..4da858f 100644
>> --- a/hw/9pfs/9p.c
>> +++ b/hw/9pfs/9p.c
>> @@ -573,10 +573,16 @@ static void coroutine_fn virtfs_reset(V9fsPDU *pdu)
>>                                   P9_STAT_MODE_SOCKET)
>>   
>>   /* This is the algorithm from ufs in spfs */
>> -static void stat_to_qid(const struct stat *stbuf, V9fsQID *qidp)
>> +static int stat_to_qid(V9fsPDU *pdu, const struct stat *stbuf, V9fsQID *qidp)
>>   {
>>       size_t size;
>>   
>> +    if (pdu->s->dev_id == 0) {
> This check would then be performed by nearly all
> requests. I'd rather set stbuf->st_dev at realize
> time since we lstat() the root of the 9pfs share.
>
>> +        pdu->s->dev_id = stbuf->st_dev;
>> +    } else if (pdu->s->dev_id != stbuf->st_dev) {
>> +        return -ENOSYS;
> Not sure ENOSYS is an appropriate return value for most guest
> syscalls that would land here. Maybe ENOENT like if the path
> doesn't exist instead ?
>
> This being said, this st_dev related logic gets reverted in the
> next patch IIUC... maybe this patch should just care to add a
> return value to stat_to_qid() ?

Indeed, I just wanted to keep a separate patch that handles that 
stat_to_qid should be able to return failure. We can remove the st_dev 
checks.

>
>> +    }
>> +
>>       memset(&qidp->path, 0, sizeof(qidp->path));
>>       size = MIN(sizeof(stbuf->st_ino), sizeof(qidp->path));
>>       memcpy(&qidp->path, &stbuf->st_ino, size);
>> @@ -588,6 +594,8 @@ static void stat_to_qid(const struct stat *stbuf, V9fsQID *qidp)
>>       if (S_ISLNK(stbuf->st_mode)) {
>>           qidp->type |= P9_QID_TYPE_SYMLINK;
>>       }
>> +
>> +    return 0;
>>   }
>>   
>>   static int coroutine_fn fid_to_qid(V9fsPDU *pdu, V9fsFidState *fidp,
>> @@ -600,7 +608,10 @@ static int coroutine_fn fid_to_qid(V9fsPDU *pdu, V9fsFidState *fidp,
>>       if (err < 0) {
>>           return err;
>>       }
>> -    stat_to_qid(&stbuf, qidp);
>> +    err = stat_to_qid(pdu, &stbuf, qidp);
>> +    if (err < 0) {
>> +        return err;
>> +    }
>>       return 0;
>>   }
>>   
>> @@ -831,7 +842,10 @@ static int coroutine_fn stat_to_v9stat(V9fsPDU *pdu, V9fsPath *path,
>>   
>>       memset(v9stat, 0, sizeof(*v9stat));
>>   
>> -    stat_to_qid(stbuf, &v9stat->qid);
>> +    err = stat_to_qid(pdu, stbuf, &v9stat->qid);
>> +    if (err < 0) {
>> +        return err;
>> +    }
>>       v9stat->mode = stat_to_v9mode(stbuf);
>>       v9stat->atime = stbuf->st_atime;
>>       v9stat->mtime = stbuf->st_mtime;
>> @@ -892,7 +906,7 @@ static int coroutine_fn stat_to_v9stat(V9fsPDU *pdu, V9fsPath *path,
>>   #define P9_STATS_ALL           0x00003fffULL /* Mask for All fields above */
>>   
>>   
>> -static void stat_to_v9stat_dotl(V9fsState *s, const struct stat *stbuf,
>> +static int stat_to_v9stat_dotl(V9fsPDU *pdu, const struct stat *stbuf,
>>                                   V9fsStatDotl *v9lstat)
>>   {
>>       memset(v9lstat, 0, sizeof(*v9lstat));
>> @@ -914,7 +928,7 @@ static void stat_to_v9stat_dotl(V9fsState *s, const struct stat *stbuf,
>>       /* Currently we only support BASIC fields in stat */
>>       v9lstat->st_result_mask = P9_STATS_BASIC;
>>   
>> -    stat_to_qid(stbuf, &v9lstat->qid);
>> +    return stat_to_qid(pdu, stbuf, &v9lstat->qid);
>>   }
>>   
>>   static void print_sg(struct iovec *sg, int cnt)
>> @@ -1116,7 +1130,6 @@ static void coroutine_fn v9fs_getattr(void *opaque)
>>       uint64_t request_mask;
>>       V9fsStatDotl v9stat_dotl;
>>       V9fsPDU *pdu = opaque;
>> -    V9fsState *s = pdu->s;
>>   
>>       retval = pdu_unmarshal(pdu, offset, "dq", &fid, &request_mask);
>>       if (retval < 0) {
>> @@ -1137,7 +1150,10 @@ static void coroutine_fn v9fs_getattr(void *opaque)
>>       if (retval < 0) {
>>           goto out;
>>       }
>> -    stat_to_v9stat_dotl(s, &stbuf, &v9stat_dotl);
>> +    retval = stat_to_v9stat_dotl(pdu, &stbuf, &v9stat_dotl);
>> +    if (retval < 0) {
>> +        goto out;
>> +    }
>>   
>>       /*  fill st_gen if requested and supported by underlying fs */
>>       if (request_mask & P9_STATS_GEN) {
>> @@ -1377,7 +1393,10 @@ static void coroutine_fn v9fs_walk(void *opaque)
>>               if (err < 0) {
>>                   goto out;
>>               }
>> -            stat_to_qid(&stbuf, &qid);
>> +            err = stat_to_qid(pdu, &stbuf, &qid);
>> +            if (err < 0) {
>> +                goto out;
>> +            }
>>               v9fs_path_copy(&dpath, &path);
>>           }
>>           memcpy(&qids[name_idx], &qid, sizeof(qid));
>> @@ -1477,7 +1496,10 @@ static void coroutine_fn v9fs_open(void *opaque)
>>       if (err < 0) {
>>           goto out;
>>       }
>> -    stat_to_qid(&stbuf, &qid);
>> +    err = stat_to_qid(pdu, &stbuf, &qid);
>> +    if (err < 0) {
>> +        goto out;
>> +    }
>>       if (S_ISDIR(stbuf.st_mode)) {
>>           err = v9fs_co_opendir(pdu, fidp);
>>           if (err < 0) {
>> @@ -1587,7 +1609,10 @@ static void coroutine_fn v9fs_lcreate(void *opaque)
>>           fidp->flags |= FID_NON_RECLAIMABLE;
>>       }
>>       iounit =  get_iounit(pdu, &fidp->path);
>> -    stat_to_qid(&stbuf, &qid);
>> +    err = stat_to_qid(pdu, &stbuf, &qid);
>> +    if (err < 0) {
>> +        goto out;
>> +    }
>>       err = pdu_marshal(pdu, offset, "Qd", &qid, iounit);
>>       if (err < 0) {
>>           goto out;
>> @@ -2308,7 +2333,10 @@ static void coroutine_fn v9fs_create(void *opaque)
>>           }
>>       }
>>       iounit = get_iounit(pdu, &fidp->path);
>> -    stat_to_qid(&stbuf, &qid);
>> +    err = stat_to_qid(pdu, &stbuf, &qid);
>> +    if (err < 0) {
>> +        goto out;
>> +    }
>>       err = pdu_marshal(pdu, offset, "Qd", &qid, iounit);
>>       if (err < 0) {
>>           goto out;
>> @@ -2365,7 +2393,10 @@ static void coroutine_fn v9fs_symlink(void *opaque)
>>       if (err < 0) {
>>           goto out;
>>       }
>> -    stat_to_qid(&stbuf, &qid);
>> +    err = stat_to_qid(pdu, &stbuf, &qid);
>> +    if (err < 0) {
>> +        goto out;
>> +    }
>>       err =  pdu_marshal(pdu, offset, "Q", &qid);
>>       if (err < 0) {
>>           goto out;
>> @@ -3033,7 +3064,10 @@ static void coroutine_fn v9fs_mknod(void *opaque)
>>       if (err < 0) {
>>           goto out;
>>       }
>> -    stat_to_qid(&stbuf, &qid);
>> +    err = stat_to_qid(pdu, &stbuf, &qid);
>> +    if (err < 0) {
>> +        goto out;
>> +    }
>>       err = pdu_marshal(pdu, offset, "Q", &qid);
>>       if (err < 0) {
>>           goto out;
>> @@ -3191,7 +3225,10 @@ static void coroutine_fn v9fs_mkdir(void *opaque)
>>       if (err < 0) {
>>           goto out;
>>       }
>> -    stat_to_qid(&stbuf, &qid);
>> +    err = stat_to_qid(pdu, &stbuf, &qid);
>> +    if (err < 0) {
>> +        goto out;
>> +    }
>>       err = pdu_marshal(pdu, offset, "Q", &qid);
>>       if (err < 0) {
>>           goto out;
>> @@ -3589,6 +3626,8 @@ int v9fs_device_realize_common(V9fsState *s, const V9fsTransport *t,
>>           goto out;
>>       }
>>   
>> +    s->dev_id = 0;
>> +
>>       s->ctx.fst = &fse->fst;
>>       fsdev_throttle_init(s->ctx.fst);
>>   
>> diff --git a/hw/9pfs/9p.h b/hw/9pfs/9p.h
>> index 5ced427..afb4ebd 100644
>> --- a/hw/9pfs/9p.h
>> +++ b/hw/9pfs/9p.h
>> @@ -252,6 +252,7 @@ struct V9fsState
>>       Error *migration_blocker;
>>       V9fsConf fsconf;
>>       V9fsQID root_qid;
>> +    dev_t dev_id;
>>   };
>>   
>>   /* 9p2000.L open flags */
