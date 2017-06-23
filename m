Received: from eggs.gnu.org ([2001:4830:134:3::10]:36644)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dOKBe-0004dY-3C
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 04:43:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dOKBZ-0005jm-5e
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 04:43:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34058)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1dOKBY-0005iy-TC
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 04:43:25 -0400
References: <d2e8cf65-ea3d-7db2-9382-a063daf1168a@gmail.com>
	<20170605050423-mutt-send-email-mst@kernel.org>
	<20170606024211-mutt-send-email-mst@kernel.org>
	<CAOTcU=u_HSMQiwDF3Snv5P8mT-b_Aepeb=Z9gbLd1j=2P+Yy+A@mail.gmail.com>
	<20170622215125-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <4f6d4342-8476-882e-e7a8-b3f0ebd20d95@redhat.com>
Date: Fri, 23 Jun 2017 16:43:13 +0800
MIME-Version: 1.0
In-Reply-To: <20170622215125-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] BUG: KASAN: use-after-free in free_old_xmit_skbs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, jean-philippe menil <jpmenil@gmail.com>
Cc: netdev@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>, virtualization@lists.linux-foundation.org, qemu-devel@nongnu.org



On 2017=E5=B9=B406=E6=9C=8823=E6=97=A5 02:53, Michael S. Tsirkin wrote:
> On Thu, Jun 22, 2017 at 08:15:58AM +0200, jean-philippe menil wrote:
>> 2017-06-06 1:52 GMT+02:00 Michael S. Tsirkin <mst@redhat.com>:
>>
>>      On Mon, Jun 05, 2017 at 05:08:25AM +0300, Michael S. Tsirkin wrot=
e:
>>      > On Mon, Jun 05, 2017 at 12:48:53AM +0200, Jean-Philippe Menil w=
rote:
>>      > > Hi,
>>      > >
>>      > > while playing with xdp and ebpf, i'm hitting the following:
>>      > >
>>      > > [  309.993136]
>>      > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>      > > [  309.994735] BUG: KASAN: use-after-free in
>>      > > free_old_xmit_skbs.isra.29+0x2b7/0x2e0 [virtio_net]
>>      > > [  309.998396] Read of size 8 at addr ffff88006aa64220 by tas=
k sshd/323
>>      > > [  310.000650]
>>      > > [  310.002305] CPU: 1 PID: 323 Comm: sshd Not tainted 4.12.0-=
rc3+ #2
>>      > > [  310.004018] Hardware name: QEMU Standard PC (i440FX + PIIX=
, 1996),
>>      BIOS
>>      > > 1.10.2-20170228_101828-anatol 04/01/2014
> ...
>
>>      >
>>      > Since commit 680557cf79f82623e2c4fd42733077d60a843513
>>      >     virtio_net: rework mergeable buffer handling
>>      >
>>      > we no longer must do the resets, we now have enough space
>>      > to store a bit saying whether a buffer is xdp one or not.
>>      >
>>      > And that's probably a cleaner way to fix these issues than
>>      > try to find and fix the race condition.
>>      >
>>      > John?
>>      >
>>      > --
>>      > MST
>>
>>
>>      I think I see the source of the race. virtio net calls
>>      netif_device_detach and assumes no packets will be sent after
>>      this point. However, all it does is stop all queues so
>>      no new packets will be transmitted.
>>
>>      Try locking with HARD_TX_LOCK?
>>    =20
>>
>>      --
>>      MST
>>
>>
>> Hi Michael,
>>
>> from what i see, the race appear when we hit virtnet_reset in virtnet_=
xdp_set.
>> virtnet_reset
>>    _remove_vq_common
>>      virtnet_del_vqs
>>        virtnet_free_queues
>>          kfree(vi->sq)
>> when the xdp program (with two instances of the program to trigger it =
faster)
>> is added or removed.
>>
>> It's easily repeatable, with 2 cpus and 4 queues on the qemu command l=
ine,
>> running the xdp_ttl tool from Jesper.
>>
>> For now, i'm able to continue my qualification, testing if xdp_qp is n=
ot null,
>> but do not seem to be a sustainable trick.
>> if (xdp_qp && vi->xdp_queues_pairs !=3D xdp_qp)
>>
>> Maybe it will be more clear to you with theses informations.
>>
>> Best regards.
>>
>> Jean-Philippe
>
> I'm pretty clear about the issue here, I was trying to figure out a fix=
.
> Jason, any thoughts?
>
>

Hi Jean:

Does the following fix this issue? (I can't reproduce it locally through=20
xdp_ttl)

Thanks

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 1f8c15c..3e65c3f 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -1801,7 +1801,9 @@ static void virtnet_freeze_down(struct=20
virtio_device *vdev)
         /* Make sure no work handler is accessing the device */
         flush_work(&vi->config_work);

+       netif_tx_lock_bh(vi->dev);
         netif_device_detach(vi->dev);
+       netif_tx_unlock_bh(vi->dev);
         cancel_delayed_work_sync(&vi->refill);
