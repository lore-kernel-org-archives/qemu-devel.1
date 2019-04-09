Received: from eggs.gnu.org ([209.51.188.92]:40597)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hDjpK-0005Bv-4t
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 02:01:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hDjpI-0006Ss-5E
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 02:01:46 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20190325125142.11628-1-zhengxiang9@huawei.com>
	<CAFEAcA-O5+A0Q=14k2vrBg3KNM7MmqbcyhBoZZOe=AsyE-UDbw@mail.gmail.com>
	<19929558-9f2d-148a-4357-d48b46f8b62b@huawei.com>
	<87va06kvm6.fsf@dusky.pond.sub.org>
	<59f100b4-f6e9-973d-532b-58fb172a7009@redhat.com>
	<87imw5fv45.fsf@dusky.pond.sub.org>
	<abe1d9cd-85bb-2ef8-630f-af28cae6378c@redhat.com>
	<8736n9eb4s.fsf@dusky.pond.sub.org>
	<bf2decd3-b3cb-08eb-3449-b66f023b084a@huawei.com>
	<c57135ae-41a9-ed7b-976b-bf8fe43596a2@redhat.com>
	<b107e0c0-1c4c-3f0f-eb78-8929c315ce28@huawei.com>
	<a8144a1f-364e-cea5-b0a7-05342bdab936@redhat.com>
Date: Tue, 09 Apr 2019 08:01:27 +0200
In-Reply-To: <a8144a1f-364e-cea5-b0a7-05342bdab936@redhat.com> (Laszlo Ersek's
	message of "Mon, 8 Apr 2019 18:14:15 +0200")
Message-ID: <87bm1fiuo8.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH] hw/arm/virt: use variable size of
 flash device to save memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: Xiang Zheng <zhengxiang9@huawei.com>, Peter Maydell <peter.maydell@linaro.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Heyi Guo <guoheyi@huawei.com>, wanghaibin.wang@huawei.com, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

L=C3=A1szl=C3=B3's last sentence below is "This really needs the attention =
of the
block people."  Cc'ing some.

Laszlo Ersek <lersek@redhat.com> writes:

> On 04/08/19 15:43, Xiang Zheng wrote:
>>=20
>> On 2019/4/3 23:35, Laszlo Ersek wrote:
>>>> I thought about your comments and wrote the following patch (just for =
test)
>>>> which uses a file mapping to replace the anonymous mapping. UEFI seems=
 to work
>>>> fine. So why not use a file mapping to read or write a pflash device?
>>> Honestly I can't answer "why not do this". Maybe we should.
>>>
>>> Regarding "why not do this *exactly as shown below*" -- probably because
>>> then we'd have updates to the same underlying regular file via both
>>> mmap() and write(), and the interactions between those are really tricky
>>> (=3D best avoided).
>>>
>>> One of my favorite questions over the years used to be posting a matrix
>>> of possible mmap() and file descriptor r/w/sync interactions, with the
>>> outcomes as they were "implied" by POSIX, and then asking at the bottom,
>>> "is my understanding correct?" I've never ever received an answer to
>>> that. :)
>>=20
>> In my opinion, it's feasible to r/w/sync the memory devices which use a =
block
>> backend via mmap() and write().
>
> Maybe. I think that would be a first in QEMU, and you'd likely have to
> describe and follow a semi-formal model between fd actions and mmap()
> actions.
>
> Here's the (unconfirmed) table I referred to earlier.
>
> +-------------+-----------------------------------------------------+
> | change made | change visible via                                  |
> | through     +-----------------+-------------+---------------------+
> |             | MAP_SHARED      | MAP_PRIVATE | read()              |
> +-------------+-----------------+-------------+---------------------+
> | MAP_SHARED  | yes             | unspecified | depends on MS_SYNC, |
> |             |                 |             | MS_ASYNC, or normal |
> |             |                 |             | system activity     |
> +-------------+-----------------+-------------+---------------------+
> | MAP_PRIVATE | no              | no          | no                  |
> +-------------+-----------------+-------------+---------------------+
> | write()     | depends on      | unspecified | yes                 |
> |             | MS_INVALIDATE,  |             |                     |
> |             | or the system's |             |                     |
> |             | read/write      |             |                     |
> |             | consistency     |             |                     |
> +-------------+-----------------+-------------+---------------------+
>
> Presumably:
>
> - a write() to some offset range of a regular file should be visible in
> a MAP_SHARED mapping of that range after a matching msync(...,
> MS_INVALIDATE) call;
>
> - changes through a MAP_SHARED mapping to a regular file should be
> visible via read() after a matching msync(..., MS_SYNC) call returns.
>
> I sent this table first in 2010 to the Austin Group mailing list, and
> received no comments. Then another person (on the same list) asked
> basically the same questions in 2013, to which I responded with the
> above assumptions / interpretations -- and received no comments from
> third parties again.
>
> But, I'm really out of my depth here -- we're not even discussing
> generic read()/write()/mmap()/munmap()/msync() interactions, but how
> they would fit into the qemu block layer. And I have no idea.
>
>>=20
>>>
>>> Also... although we don't really use them in practice, some QCOW2
>>> features for pflash block backends are -- or would be -- nice. (Not the
>>> internal snapshots or the live RAM dumps, of course.)
>>=20
>> Regarding sparse files, can we read actual backend size data for the rea=
d-only
>> pflash memory as the following steps shown?
>>=20
>> 1) Create a sparse file -- QEMU_EFI-test.raw:
>>    dd if=3D/dev/zero of=3DQEMU_EFI-test.raw bs=3D1M seek=3D64 count=3D0
>>=20
>> 2) Read from QEMU_EFI.fd and write to QEMU_EFI-test.raw:
>>    dd of=3D"QEMU_EFI-test.raw" if=3D"QEMU_EFI.fd" conv=3Dnotrunc
>>=20
>> 3) Use QEMU_EFI-test.raw as the read-only pflash and start qemu with the=
 below
>> patch applied:
>>=20
>> ---8>---
>>=20
>> diff --git a/hw/block/block.c b/hw/block/block.c
>> index bf56c76..ad18d5e 100644
>> --- a/hw/block/block.c
>> +++ b/hw/block/block.c
>> @@ -30,7 +30,7 @@
>>  bool blk_check_size_and_read_all(BlockBackend *blk, void *buf, hwaddr s=
ize,
>>                                   Error **errp)
>>  {
>> -    int64_t blk_len;
>> +    int64_t blk_len, actual_len;
>>      int ret;
>>=20
>>      blk_len =3D blk_getlength(blk);
>> @@ -53,7 +53,9 @@ bool blk_check_size_and_read_all(BlockBackend *blk, vo=
id *buf, hwaddr size,
>>       * block device and read only on demand.
>>       */
>>      assert(size <=3D BDRV_REQUEST_MAX_BYTES);
>> -    ret =3D blk_pread(blk, 0, buf, size);
>> +    actual_len =3D bdrv_get_allocated_file_size(blk_bs(blk));
>> +    ret =3D blk_pread(blk, 0, buf,
>> +            (!blk_is_read_only(blk) || actual_len < 0) ? size : actual_=
len);
>>      if (ret < 0) {
>>          error_setg_errno(errp, -ret, "can't read block backend");
>>          return false;
>>=20
>
> This hunk looks dubious for a general helper function. It seems to
> assume that the holes are punched at the end of the file.
>
> Sorry, this discussion is making me uncomfortable. I don't want to
> ignore your questions, but I have no idea about the right answers. This
> really needs the attention of the block people.
