Received: from eggs.gnu.org ([2001:4830:134:3::10]:34946)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1d6ZPS-0008Ui-Oq
	for qemu-devel@nongnu.org; Fri, 05 May 2017 05:20:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1d6ZPO-0003OL-Co
	for qemu-devel@nongnu.org; Fri, 05 May 2017 05:20:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34130)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1d6ZPO-0003OD-3b
	for qemu-devel@nongnu.org; Fri, 05 May 2017 05:20:18 -0400
References: <286AC319A985734F985F78AFA26841F7391FDD30@shsmsx102.ccr.corp.intel.com>
	<056500d7-6a91-12e5-be1d-2b2beebd0430@redhat.com>
	<590C1353.7070501@intel.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <6b96612b-2fd9-cf65-023e-f72561ec936a@redhat.com>
Date: Fri, 5 May 2017 17:20:07 +0800
MIME-Version: 1.0
In-Reply-To: <590C1353.7070501@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [virtio-dev] Re: virtio-net: configurable TX queue
 size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Wang <wei.w.wang@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Jan Scheurich <jan.scheurich@ericsson.com>



On 2017=E5=B9=B405=E6=9C=8805=E6=97=A5 13:53, Wei Wang wrote:
> On 05/05/2017 10:27 AM, Jason Wang wrote:
>>
>>
>> On 2017=E5=B9=B405=E6=9C=8804=E6=97=A5 18:58, Wang, Wei W wrote:
>>> Hi,
>>>
>>> I want to re-open the discussion left long time ago:
>>> https://lists.gnu.org/archive/html/qemu-devel/2015-11/msg06194.html
>>> , and discuss the possibility of changing the hardcoded (256) TX  que=
ue
>>> size to be configurable between 256 and 1024.
>>
>> Yes, I think we probably need this.
>
> That's great, thanks.
>
>>
>>>
>>> The reason to propose this request is that a severe issue of packet=20
>>> drops in
>>> TX direction was observed with the existing hardcoded 256 queue size,
>>> which causes performance issues for packet drop sensitive guest
>>> applications that cannot use indirect descriptor tables. The issue=20
>>> goes away
>>> with 1K queue size.
>>
>> Do we need even more, what if we find 1K is even not sufficient in=20
>> the future? Modern nics has size up to ~8192.
>
> Yes. Probably, we can also set the RX queue size to 8192 (currently=20
> it's 1K) as well.
>
>>
>>>
>>> The concern mentioned in the previous discussion (please check the li=
nk
>>> above) is that the number of chained descriptors would exceed
>>> UIO_MAXIOV (1024) supported by the Linux.
>>
>> We could try to address this limitation but probably need a new=20
>> feature bit to allow more than UIO_MAXIOV sgs.
>
> I think we should first discuss whether it would be an issue below.
>
>>
>>>
>>>  From the code,  I think the number of the chained descriptors is=20
>>> limited to
>>> MAX_SKB_FRAGS + 2 (~18), which is much less than UIO_MAXIOV.
>>
>> This is the limitation of #page frags for skb, not the iov limitation.
>
> I think the number of page frags are filled into the same number of=20
> descriptors
> in the virtio-net driver (e.g. use 10 descriptors for 10 page frags).=20
> On the other
> side, the virtio-net backend uses the same number of iov for the=20
> descriptors.
>
> Since the number of page frags is limited to 18, I think there=20
> wouldn't be more
> than 18 iovs to be passed to writev, right?

Looks not, see skb_copy_datagram_from_iter().

Thanks

>
> Best,
> Wei
>
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>
