Received: from eggs.gnu.org ([2001:4830:134:3::10]:58217)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yvugenfi@redhat.com>) id 1d7Ku6-0007tY-Kt
	for qemu-devel@nongnu.org; Sun, 07 May 2017 08:03:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yvugenfi@redhat.com>) id 1d7Ku3-0003U5-HF
	for qemu-devel@nongnu.org; Sun, 07 May 2017 08:03:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39658)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yvugenfi@redhat.com>) id 1d7Ku3-0003TK-8S
	for qemu-devel@nongnu.org; Sun, 07 May 2017 08:03:07 -0400
From: Yan Vugenfirer <yvugenfi@redhat.com>
Message-Id: <D37F7228-10A4-438F-8AEE-461EC54F64AA@redhat.com>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Date: Sun, 7 May 2017 15:02:03 +0300
In-Reply-To: <6b96612b-2fd9-cf65-023e-f72561ec936a@redhat.com>
References: <286AC319A985734F985F78AFA26841F7391FDD30@shsmsx102.ccr.corp.intel.com>
	<056500d7-6a91-12e5-be1d-2b2beebd0430@redhat.com>
	<590C1353.7070501@intel.com>
	<6b96612b-2fd9-cf65-023e-f72561ec936a@redhat.com>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [virtio-dev] virtio-net: configurable TX queue size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: Wei Wang <wei.w.wang@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, =?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Jan Scheurich <jan.scheurich@ericsson.com>


> On 5 May 2017, at 12:20, Jason Wang <jasowang@redhat.com> wrote:
>=20
>=20
>=20
> On 2017=E5=B9=B405=E6=9C=8805=E6=97=A5 13:53, Wei Wang wrote:
>> On 05/05/2017 10:27 AM, Jason Wang wrote:
>>>=20
>>>=20
>>> On 2017=E5=B9=B405=E6=9C=8804=E6=97=A5 18:58, Wang, Wei W wrote:
>>>> Hi,
>>>>=20
>>>> I want to re-open the discussion left long time ago:
>>>> https://lists.gnu.org/archive/html/qemu-devel/2015-11/msg06194.html
>>>> , and discuss the possibility of changing the hardcoded (256) TX  =
queue
>>>> size to be configurable between 256 and 1024.
>>>=20
>>> Yes, I think we probably need this.
>>=20
>> That's great, thanks.
>>=20
>>>=20
>>>>=20
>>>> The reason to propose this request is that a severe issue of packet =
drops in
>>>> TX direction was observed with the existing hardcoded 256 queue =
size,
>>>> which causes performance issues for packet drop sensitive guest
>>>> applications that cannot use indirect descriptor tables. The issue =
goes away
>>>> with 1K queue size.
>>>=20
>>> Do we need even more, what if we find 1K is even not sufficient in =
the future? Modern nics has size up to ~8192.
>>=20
>> Yes. Probably, we can also set the RX queue size to 8192 (currently =
it's 1K) as well.
>>=20
>>>=20
>>>>=20
>>>> The concern mentioned in the previous discussion (please check the =
link
>>>> above) is that the number of chained descriptors would exceed
>>>> UIO_MAXIOV (1024) supported by the Linux.
>>>=20
>>> We could try to address this limitation but probably need a new =
feature bit to allow more than UIO_MAXIOV sgs.
>>=20
>> I think we should first discuss whether it would be an issue below.
>>=20
>>>=20
>>>>=20
>>>> =46rom the code,  I think the number of the chained descriptors is =
limited to
>>>> MAX_SKB_FRAGS + 2 (~18), which is much less than UIO_MAXIOV.
>>>=20
>>> This is the limitation of #page frags for skb, not the iov =
limitation.
>>=20
>> I think the number of page frags are filled into the same number of =
descriptors
>> in the virtio-net driver (e.g. use 10 descriptors for 10 page frags). =
On the other
>> side, the virtio-net backend uses the same number of iov for the =
descriptors.
>>=20
>> Since the number of page frags is limited to 18, I think there =
wouldn't be more
>> than 18 iovs to be passed to writev, right?
>=20
This limitation assumption is incorrect for Windows. We saw cases (and =
strangely enough with small packets) when Windows returns scatter gather =
list with 32 descriptors or more.

Best regards,
Yan.

> Looks not, see skb_copy_datagram_from_iter().

>=20
> Thanks
>=20
>>=20
>> Best,
>> Wei
>>=20
>> ---------------------------------------------------------------------
>> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org =
<mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
>> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org =
<mailto:virtio-dev-help@lists.oasis-open.org>
>>=20
>=20
>=20
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org =
<mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org =
<mailto:virtio-dev-help@lists.oasis-open.org>
