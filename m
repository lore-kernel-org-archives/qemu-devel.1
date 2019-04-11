Return-Path: <SRS0=7PPA=SN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7882EC10F13
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 07:27:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3325B21841
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 07:27:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3325B21841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43148 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEU7m-0005dh-Qt
	for qemu-devel@archiver.kernel.org; Thu, 11 Apr 2019 03:27:54 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39682)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hEU6f-00052c-Co
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 03:26:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hEU6c-0001Qz-IG
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 03:26:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51796)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>)
	id 1hETwJ-00048p-E8; Thu, 11 Apr 2019 03:16:03 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DC94F2D7EB;
	Thu, 11 Apr 2019 07:16:01 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-116.ams2.redhat.com
	[10.36.116.116])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 069201001E66;
	Thu, 11 Apr 2019 07:15:59 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 8F7B61138648; Thu, 11 Apr 2019 09:15:57 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Xiang Zheng <zhengxiang9@huawei.com>
References: <87va06kvm6.fsf@dusky.pond.sub.org>
	<59f100b4-f6e9-973d-532b-58fb172a7009@redhat.com>
	<87imw5fv45.fsf@dusky.pond.sub.org>
	<abe1d9cd-85bb-2ef8-630f-af28cae6378c@redhat.com>
	<8736n9eb4s.fsf@dusky.pond.sub.org>
	<bf2decd3-b3cb-08eb-3449-b66f023b084a@huawei.com>
	<c57135ae-41a9-ed7b-976b-bf8fe43596a2@redhat.com>
	<b107e0c0-1c4c-3f0f-eb78-8929c315ce28@huawei.com>
	<a8144a1f-364e-cea5-b0a7-05342bdab936@redhat.com>
	<87bm1fiuo8.fsf@dusky.pond.sub.org>
	<20190409082852.GB6610@localhost.localdomain>
	<c03c51a7-1bb0-b05b-9027-2364ab00517c@huawei.com>
Date: Thu, 11 Apr 2019 09:15:57 +0200
In-Reply-To: <c03c51a7-1bb0-b05b-9027-2364ab00517c@huawei.com> (Xiang Zheng's
	message of "Wed, 10 Apr 2019 16:36:34 +0800")
Message-ID: <87ef693tci.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.30]);
	Thu, 11 Apr 2019 07:16:02 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [RFC PATCH] hw/arm/virt: use variable size of
 flash device to save memory
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
	qemu-block@nongnu.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	QEMU Developers <qemu-devel@nongnu.org>,
	Max Reitz <mreitz@redhat.com>, qemu-arm <qemu-arm@nongnu.org>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Heyi Guo <guoheyi@huawei.com>, wanghaibin.wang@huawei.com,
	Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190411071557.CeDPaJ-1gV5q3cAFXuJbrqddXqm-iwoKfVr4zkfBMKQ@z>

Xiang Zheng <zhengxiang9@huawei.com> writes:

> Hi Kevin,
>
> On 2019/4/9 16:28, Kevin Wolf wrote:
>> Am 09.04.2019 um 08:01 hat Markus Armbruster geschrieben:
>>> L=C3=A1szl=C3=B3's last sentence below is "This really needs the attent=
ion of the
>>> block people."  Cc'ing some.
>>>
>>> Laszlo Ersek <lersek@redhat.com> writes:
>>>
>>>> On 04/08/19 15:43, Xiang Zheng wrote:
>>>>>
>>>>> On 2019/4/3 23:35, Laszlo Ersek wrote:
>>>>>>> I thought about your comments and wrote the following patch (just f=
or test)
>>>>>>> which uses a file mapping to replace the anonymous mapping. UEFI se=
ems to work
>>>>>>> fine. So why not use a file mapping to read or write a pflash devic=
e?
>>>>>> Honestly I can't answer "why not do this". Maybe we should.
>>>>>>
>>>>>> Regarding "why not do this *exactly as shown below*" -- probably bec=
ause
>>>>>> then we'd have updates to the same underlying regular file via both
>>>>>> mmap() and write(), and the interactions between those are really tr=
icky
>>>>>> (=3D best avoided).
>>>>>>
>>>>>> One of my favorite questions over the years used to be posting a mat=
rix
>>>>>> of possible mmap() and file descriptor r/w/sync interactions, with t=
he
>>>>>> outcomes as they were "implied" by POSIX, and then asking at the bot=
tom,
>>>>>> "is my understanding correct?" I've never ever received an answer to
>>>>>> that. :)
>>>>>
>>>>> In my opinion, it's feasible to r/w/sync the memory devices which use=
 a block
>>>>> backend via mmap() and write().
>>>>
>>>> Maybe. I think that would be a first in QEMU, and you'd likely have to
>>>> describe and follow a semi-formal model between fd actions and mmap()
>>>> actions.
>>>>
>>>> Here's the (unconfirmed) table I referred to earlier.
>>>>
>>>> +-------------+-----------------------------------------------------+
>>>> | change made | change visible via                                  |
>>>> | through     +-----------------+-------------+---------------------+
>>>> |             | MAP_SHARED      | MAP_PRIVATE | read()              |
>>>> +-------------+-----------------+-------------+---------------------+
>>>> | MAP_SHARED  | yes             | unspecified | depends on MS_SYNC, |
>>>> |             |                 |             | MS_ASYNC, or normal |
>>>> |             |                 |             | system activity     |
>>>> +-------------+-----------------+-------------+---------------------+
>>>> | MAP_PRIVATE | no              | no          | no                  |
>>>> +-------------+-----------------+-------------+---------------------+
>>>> | write()     | depends on      | unspecified | yes                 |
>>>> |             | MS_INVALIDATE,  |             |                     |
>>>> |             | or the system's |             |                     |
>>>> |             | read/write      |             |                     |
>>>> |             | consistency     |             |                     |
>>>> +-------------+-----------------+-------------+---------------------+
>>>>
>>>> Presumably:
>>>>
>>>> - a write() to some offset range of a regular file should be visible in
>>>> a MAP_SHARED mapping of that range after a matching msync(...,
>>>> MS_INVALIDATE) call;
>>>>
>>>> - changes through a MAP_SHARED mapping to a regular file should be
>>>> visible via read() after a matching msync(..., MS_SYNC) call returns.
>>>>
>>>> I sent this table first in 2010 to the Austin Group mailing list, and
>>>> received no comments. Then another person (on the same list) asked
>>>> basically the same questions in 2013, to which I responded with the
>>>> above assumptions / interpretations -- and received no comments from
>>>> third parties again.
>>>>
>>>> But, I'm really out of my depth here -- we're not even discussing
>>>> generic read()/write()/mmap()/munmap()/msync() interactions, but how
>>>> they would fit into the qemu block layer. And I have no idea.
>>=20
>> There is no infrastructure in the block layer for mmapping image files.
>>=20
>>>>>> Also... although we don't really use them in practice, some QCOW2
>>>>>> features for pflash block backends are -- or would be -- nice. (Not =
the
>>>>>> internal snapshots or the live RAM dumps, of course.)
>>>>>
>>>>> Regarding sparse files, can we read actual backend size data for the =
read-only
>>>>> pflash memory as the following steps shown?
>>>>>
>>>>> 1) Create a sparse file -- QEMU_EFI-test.raw:
>>>>>    dd if=3D/dev/zero of=3DQEMU_EFI-test.raw bs=3D1M seek=3D64 count=
=3D0
>>>>>
>>>>> 2) Read from QEMU_EFI.fd and write to QEMU_EFI-test.raw:
>>>>>    dd of=3D"QEMU_EFI-test.raw" if=3D"QEMU_EFI.fd" conv=3Dnotrunc
>>>>>
>>>>> 3) Use QEMU_EFI-test.raw as the read-only pflash and start qemu with =
the below
>>>>> patch applied:
>>>>>
>>>>> ---8>---
>>>>>
>>>>> diff --git a/hw/block/block.c b/hw/block/block.c
>>>>> index bf56c76..ad18d5e 100644
>>>>> --- a/hw/block/block.c
>>>>> +++ b/hw/block/block.c
>>>>> @@ -30,7 +30,7 @@
>>>>>  bool blk_check_size_and_read_all(BlockBackend *blk, void *buf, hwadd=
r size,
>>>>>                                   Error **errp)
>>>>>  {
>>>>> -    int64_t blk_len;
>>>>> +    int64_t blk_len, actual_len;
>>>>>      int ret;
>>>>>
>>>>>      blk_len =3D blk_getlength(blk);
>>>>> @@ -53,7 +53,9 @@ bool blk_check_size_and_read_all(BlockBackend *blk,=
 void *buf, hwaddr size,
>>>>>       * block device and read only on demand.
>>>>>       */
>>>>>      assert(size <=3D BDRV_REQUEST_MAX_BYTES);
>>>>> -    ret =3D blk_pread(blk, 0, buf, size);
>>>>> +    actual_len =3D bdrv_get_allocated_file_size(blk_bs(blk));
>>>>> +    ret =3D blk_pread(blk, 0, buf,
>>>>> +            (!blk_is_read_only(blk) || actual_len < 0) ? size : actu=
al_len);
>>>>>      if (ret < 0) {
>>>>>          error_setg_errno(errp, -ret, "can't read block backend");
>>>>>          return false;
>>>>>
>>>>
>>>> This hunk looks dubious for a general helper function. It seems to
>>>> assume that the holes are punched at the end of the file.
>>>>
>>>> Sorry, this discussion is making me uncomfortable. I don't want to
>>>> ignore your questions, but I have no idea about the right answers. This
>>>> really needs the attention of the block people.
>>=20
>> Yes, this code is wrong. bdrv_get_allocated_file_size() isn't even
>> implemented in all block drivers, and when it is implemented it isn't
>> necessarily reliable (e.g. return 0 for block devices). It's fine for
>> 'qemu-img info', but that's it.
>>=20
>> But even if you actually get the correct allocated file size, that's the
>> disk space used on the host filesystem, so it doesn't include any holes,
>> but it does include image format metadata, the data could possibly be
>> compressed etc. In other words, for a guest device it's completely
>> meaningless.
>>=20
>> I'm not even sure why you would want to do this even in your special
>> case of a raw image that is sparse only at the end. Is it an
>> optimisation to avoid reading zeros? This ends up basically being
>> memset() for sparse blocks, so very quick. And I think you do want to
>> zero out the remaining part of the buffer anyway. So it looks to me as
>> if it were complicating the code for no use.
>
> The primary target of this discussion is to save the memory allocated
> for UEFI firmware device. On virtual machine, we split it into two flash
> devices[1] -- one is read-only in 64MB size and another is read-write in
> 64MB size. The qemu commandline is:
>
>    -drive file=3DQEMU_EFI-pflash.raw,if=3Dpflash,format=3Draw,unit=3D0,re=
adonly=3Don \
>    -drive file=3Dempty_VARS.fd,if=3Dpflash,format=3Draw,unit=3D1 \
>
> Regarding the read-only one which are created from QEMU_EFI.fd, the origi=
nal
> QEMU_EFI.fd is only 2MB in size and we need to stuff it to 64MB with 62MB
> 'zeros':
>
>    dd of=3D"QEMU_EFI-pflash.raw" if=3D"/dev/zero" bs=3D1M count=3D64
>    dd of=3D"QEMU_EFI-pflash.raw" if=3D"QEMU_EFI.fd" conv=3Dnotrunc
>
> For some historical reasons such as compatibility and extensibility[2], we
> restrict both their size to 64MB -- both UEFI and qemu have cold hard
> constants.

These reasons aren't historical.  But they're valid, and that's all that
matters :)

> This will consume a large amount of memory when running multiple VM
> simultaneously (each guest needs 128MB).

Understood.

> There are accepted ideas proposed by Markus and Laszlo from prior discuss=
ion[3]:
>
> 1) Getting flash memory size from a machine type or property.
>
> 2) Map the read-only part so it is shared among guests; Map the read-write
> part normally.
>
> The first idea called explicit configuration which may break migration.

For any configuration that can break migration, the solution is to have
identical configuration on source and destination.

> For the second idea, the only way I can imagine is using a file mapping to
> read or write pflash devices so that we can allocate memory on demand. So=
 I
> tried to fit mmap() actions into the block layer[4]. However I am not sure
> that maping image file whether can work fine for block layer.

It adds an odd special case to the block layer.  But then flash devices
are an odd user of the block layer.

Normal users use the block layer as a *block* layer: to read and write
blocks.

Our flash devices don't do that.  They are *memory* devices, not *block*
devices.  Pretty much the only thing the two have in common is
persistence of data.  The block layer provides persistence, and I figure
that's why it got pressed into service here.

What the flash devices do is keep the complete image contents in memory,
with changes written through to disk.

This is pretty much exactly what mmap() does, so using it suggests
itself.

It's very much *not* what the block layer does.  mmap() is not even
possible for anything but a file backend.

With mmap(), memory gets faulted in on demand, and sharing read-only
memory with other VMs should be feasible.  The question is how to use it
here.  Is there a sane way to use it without rewriting the flash devices
not to use the block layer?

> On the other hand, Laszlo had mentioned the features of QCOW2 and sparse
> files which may be nice for pflash block backends. But I am not familiar =
with
> it.

Offhand, two QCOW2 features come to mind:

1. Sparse storage even when the storage substrate can't do sparse.  I
consider this one largely irrelevant.  Any decent file system can do
sparse.  Archival and network transfer can compress instead.

2. Snapshots to go with disk snapshots.  *Live* snapshots (the ones that
include memory) already have the flash contents in the memory part, so
this sems only relevant for "dead" snapshots.

Anything else?

> Till now I still have no idea to get rid of this problem (more properly i=
t's
> a optimization).
>
>
> [1]https://lists.nongnu.org/archive/html/qemu-devel/2019-01/msg06606.html
> [2]https://lists.nongnu.org/archive/html/qemu-devel/2019-03/msg07009.html
> [3]https://lists.nongnu.org/archive/html/qemu-devel/2019-03/msg07107.html
> [4]https://lists.nongnu.org/archive/html/qemu-devel/2019-04/msg00719.html

