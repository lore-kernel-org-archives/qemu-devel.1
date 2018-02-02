Received: from eggs.gnu.org ([2001:4830:134:3::10]:36053)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgard.kaziakhmedov@virtuozzo.com>)
	id 1ehcWy-0006yh-Qw
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 09:41:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgard.kaziakhmedov@virtuozzo.com>)
	id 1ehcWt-0000uI-Ok
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 09:41:32 -0500
References: <20180118115158.17219-1-edgar.kaziakhmedov@virtuozzo.com>
	<1b55edad-f820-6898-1630-ccc76e6c4845@redhat.com>
	<5858df64-9495-1332-3c53-fab0204f79a9@virtuozzo.com>
	<8b87f82d-2a90-d6cf-0fc4-aee0d704a403@redhat.com>
From: Edgar Kaziakhmedov <edgar.kaziakhmedov@virtuozzo.com>
Message-ID: <4919379e-ee86-5032-ec1e-fea39912783b@virtuozzo.com>
Date: Fri, 2 Feb 2018 17:06:48 +0300
MIME-Version: 1.0
In-Reply-To: <8b87f82d-2a90-d6cf-0fc4-aee0d704a403@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 1/1] nbd: implement bdrv_get_info callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, den@openvz.org, vsementsov@virtuozzo.com



On 01/26/2018 05:28 PM, Eric Blake wrote:
> On 01/26/2018 06:39 AM, Edgar Kaziakhmedov wrote:
>> PIng
>>
>> So, let me know if I need to make any changes in patch
>>
>> On 1/18/18 1:09 PM, Paolo Bonzini wrote:
>>> On 18/01/2018 12:51, Edgar Kaziakhmedov wrote:
>>>> +static int nbd_get_info(BlockDriverState *bs, BlockDriverInfo *bdi)
>>>> +{
>>>> +=C2=A0=C2=A0=C2=A0 if (bs->supported_zero_flags & BDRV_REQ_MAY_UNMAP)=
 {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bdi->can_write_zeroes_with=
_unmap =3D true;
>>>> +=C2=A0=C2=A0=C2=A0 }
>>>> +=C2=A0=C2=A0=C2=A0 return 0;
>>>> +}
>>>> +
>>> Other drivers set the flag always, while NBD only sets it if the server
>>> knows the flag.
> Well, other drivers may be able to always implement it (NBD can only
> implement it if the server supports WRITE_ZEROES - and I'm even in the
> middle of working up an nbdkit patch [1] that makes it easier to write
> an NBD server that specifically does not support WRITE_ZEROES to make
> code paths like this easier to test)
>
> [1]
>
>>> I think NBD is more correct, so:
>>>
>>> Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
> Agreed; I'm fine queueing this on my NBD queue, except I'd first like to
> hear Kevin's opinion:
>
>>> However, it would be nice to remove can_write_zeroes_with_unmap from
>>> BlockDriverInfo, and make bdrv_can_write_zeroes_with_unmap just return
>>> !!(bs->supported_zero_flags & BDRV_REQ_MAY_UNMAP).=C2=A0 Kevin, what do=
 you
>>> think?
> Actually, I may even just give a shot at writing this alternative patch,
> to make Kevin's decision easier.
But actually qcow2 performs some checks for version inside get_info=20
callback before setting can_write_zeroes_with_unmap flag,
so we can't take into account such checks in=20
bdrv_can_write_zeroes_with_unmap subroutine. Therefore, I don't think it=20
is possible to do it like that.
