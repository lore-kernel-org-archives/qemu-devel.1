Received: from eggs.gnu.org ([2001:4830:134:3::10]:46094)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cOgNg-0001Z3-9h
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 02:53:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cOgNb-00087M-RO
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 02:53:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56678)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1cOgNb-000870-Hq
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 02:53:03 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 34346F44CD
	for <qemu-devel@nongnu.org>; Wed,  4 Jan 2017 07:53:03 +0000 (UTC)
References: <20161230104130.29ff671b@x240.lan>
	<4eda1813-d732-5dfc-e6ff-29ac95fe22d8@redhat.com>
	<8aae955f-44ff-134e-818f-31b0bd510ba1@redhat.com>
	<20170103182332-mutt-send-email-mst@kernel.org>
	<007b2d16-56f6-a551-815a-527f6732fae7@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <4820970a-44ee-9e49-efe1-5527cb8bddb6@redhat.com>
Date: Wed, 4 Jan 2017 15:52:55 +0800
MIME-Version: 1.0
In-Reply-To: <007b2d16-56f6-a551-815a-527f6732fae7@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] vhost-user breaks after 96a3d98.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, Flavio Leitner <fbl@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>



On 2017=E5=B9=B401=E6=9C=8804=E6=97=A5 11:26, Jason Wang wrote:
>
>
> On 2017=E5=B9=B401=E6=9C=8804=E6=97=A5 00:27, Michael S. Tsirkin wrote:
>> On Tue, Jan 03, 2017 at 06:28:18PM +0800, Jason Wang wrote:
>>>
>>> On 2017=E5=B9=B401=E6=9C=8803=E6=97=A5 11:09, Jason Wang wrote:
>>>>
>>>> On 2016=E5=B9=B412=E6=9C=8830=E6=97=A5 20:41, Flavio Leitner wrote:
>>>>> Hi,
>>>>>
>>>>> While I was testing vhost-user using OVS 2.5 and DPDK 2.2.0 in the
>>>>> host and testpmd dpdk 2.2.0 in the guest, I found that the commit
>>>>> below breaks the environment and no packets gets into the guest.
>>>>>
>>>>> dpdk port --> OVS --> vhost-user --> guest --> testpmd
>>>>>                            ^--- drops here         ^--- no packets=20
>>>>> here.
>>>>>
>>>>> commit 96a3d98d2cdbd897ff5ab33427aa4cfb94077665
>>>>> Author: Jason Wang <jasowang@redhat.com>
>>>>> Date:   Mon Aug 1 16:07:58 2016 +0800
>>>>>
>>>>>       vhost: don't set vring call if no vector
>>>>>            We used to set vring call fd unconditionally even if gue=
st
>>>>> driver does
>>>>>       not use MSIX for this vritqueue at all. This will cause lots =
of
>>>>>       unnecessary userspace access and other checks for drivers doe=
s
>>>>> not use
>>>>>       interrupt at all (e.g virtio-net pmd). So check and clean vri=
ng
>>>>> call
>>>>>       fd if guest does not use any vector for this virtqueue at
>>>>>       all.
>>>>> [...]
>>>>>
>>>>> Thanks,
>>>> Hi Flavio:
>>>>
>>>> Thanks for reporting this issue, could this be a bug of vhost-user? =
(I
>>>> believe virito-net pmd does not use interrupt for rx/tx at all)
>>>>
>>>> Anyway, will try to reproduce it.
>>>>
>>> Could not reproduce this issue on similar setups (the only=20
>>> difference is I
>>> don't create dpdk port) with dpdk 16.11 and ovs.git HEAD. Suspect an=20
>>> issue
>>> dpdk. Will try OVS 2.5 + DPDK 2.2.0.
>>>
>>> Thanks
>> Possibly dpdk assumed that call fd must be present unconditionally.
>> Limit this patch to when protocol is updated? add a new protocol flag?
>
> If this is a bug of dpdk, I tend to fix it (or just disable this patch=20
> for vhost-user). I'm not sure whether or not it's worthwhile to add a=20
> new protocol flag which was used to tell qemu that bug X was fixed.
>
> Thanks
>
>

Haven't tried but looking at vq_is_ready() in v2.2.0:

static int
vq_is_ready(struct vhost_virtqueue *vq)
{
     return vq && vq->desc   &&
            vq->kickfd !=3D -1 &&
            vq->callfd !=3D -1;
}

Which assumes callfd must be set which seems wrong. And this has been=20
fixed by

commit fb871d0a4dc1c038a381c524cdb86fe83d21d842
Author: Tetsuya Mukawa <mukawa@igel.co.jp>
Date:   Mon Mar 14 17:53:32 2016 +0900

     vhost: fix default value of kickfd and callfd

     Currently, default values of kickfd and callfd are -1.
     If the values are -1, current code guesses kickfd and callfd haven't
     been initialized yet. Then vhost library will guess the virtqueue is=
n't
     ready for processing.

     But callfd and kickfd will be set as -1 when "--enable-kvm"
     isn't specified in QEMU command line. It means we cannot treat -1 as
     uninitialized state.

     The patch defines -1 and -2 as VIRTIO_INVALID_EVENTFD and
     VIRTIO_UNINITIALIZED_EVENTFD, and uses VIRTIO_UNINITIALIZED_EVENTFD =
for
     the default values of kickfd and callfd.

     Signed-off-by: Tetsuya Mukawa <mukawa@igel.co.jp>
     Acked-by: Yuanhan Liu <yuanhan.liu@linux.intel.com>

Flavio, you could try to backport this to 2.2.0 to see if it fixes your=20
issue.

Thanks
