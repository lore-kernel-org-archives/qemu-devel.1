Received: from eggs.gnu.org ([2001:4830:134:3::10]:54410)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1fSvih-0004z7-OJ
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 22:41:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1fSvie-0000iQ-LV
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 22:41:11 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57296 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1fSvie-0000i5-Gy
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 22:41:08 -0400
References: <1525734594-11134-1-git-send-email-sridhar.samudrala@intel.com>
	<fcefe501-b410-f1ec-829c-68199edcdbef@intel.com>
	<20180605152344-mutt-send-email-mst@kernel.org>
	<a45625c9-d2cd-f8f7-ce31-37c558e70b88@redhat.com>
	<20180612144743-mutt-send-email-mst@kernel.org>
	<7aa6dbe7-bac2-96f6-d96c-f51e5173c556@intel.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <6c7666e6-dc00-d9ed-8814-68e8b3998eef@redhat.com>
Date: Wed, 13 Jun 2018 10:41:01 +0800
MIME-Version: 1.0
In-Reply-To: <7aa6dbe7-bac2-96f6-d96c-f51e5173c556@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] qemu: Introduce VIRTIO_NET_F_STANDBY
 feature bit to virtio_net
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: alexander.h.duyck@intel.com, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org, jesse.brandeburg@intel.com, virtualization@lists.linux-foundation.org



On 2018=E5=B9=B406=E6=9C=8813=E6=97=A5 08:20, Samudrala, Sridhar wrote:
> On 6/12/2018 4:54 AM, Michael S. Tsirkin wrote:
>> On Wed, Jun 06, 2018 at 10:29:03AM +0800, Jason Wang wrote:
>>>
>>> On 2018=E5=B9=B406=E6=9C=8805=E6=97=A5 20:33, Michael S. Tsirkin wrot=
e:
>>>> I don't think this is sufficient.
>>>>
>>>> If both primary and standby devices are present, a legacy guest=20
>>>> without
>>>> support for the feature might see two devices with same mac and get
>>>> confused.
>>>>
>>>> I think that we should only make primary visible after guest acked t=
he
>>>> backup feature bit.
>>> I think we want exactly the reverse? E.g fail the negotiation when=20
>>> guest
>>> does not ack backup feature.
>>>
>>> Otherwise legacy guest won't even have the chance to see primary=20
>>> device in
>>> the guest.
>> That's by design.
>>
>>>> And on reset or when backup is cleared in some other way, unplug the
>>>> primary.
>>> What if guest does not support hotplug?
>> It shouldn't ack the backup feature then and it's a good point.
>> We should both document this and check kernel config has
>> hotplug support. Sridhar could you take a look pls?
>
> Right now we select NET_FAILOVER when virtio-net is enabled, Should we=20
> select
> PCI_HOTPLUG when NET_FAILOVER is enabled?=20

Maybe I was wrong but it looks to me PCI_HOTPLUG is no sufficient since=20
it depends on other to work e.g HOTPLUG_PCI_ACPI.

Thanks
