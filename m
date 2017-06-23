Received: from eggs.gnu.org ([2001:4830:134:3::10]:32877)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <xiyou.wangcong@gmail.com>) id 1dOX8Q-0007Ct-7E
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 18:33:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <xiyou.wangcong@gmail.com>) id 1dOX8P-0000yI-BE
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 18:33:02 -0400
Received: from mail-wr0-x22c.google.com ([2a00:1450:400c:c0c::22c]:33776)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <xiyou.wangcong@gmail.com>)
	id 1dOX8P-0000vC-5S
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 18:33:01 -0400
Received: by mail-wr0-x22c.google.com with SMTP id r103so83091782wrb.0
	for <qemu-devel@nongnu.org>; Fri, 23 Jun 2017 15:32:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4f6d4342-8476-882e-e7a8-b3f0ebd20d95@redhat.com>
References: <d2e8cf65-ea3d-7db2-9382-a063daf1168a@gmail.com>
	<20170605050423-mutt-send-email-mst@kernel.org>
	<20170606024211-mutt-send-email-mst@kernel.org>
	<CAOTcU=u_HSMQiwDF3Snv5P8mT-b_Aepeb=Z9gbLd1j=2P+Yy+A@mail.gmail.com>
	<20170622215125-mutt-send-email-mst@kernel.org>
	<4f6d4342-8476-882e-e7a8-b3f0ebd20d95@redhat.com>
From: Cong Wang <xiyou.wangcong@gmail.com>
Date: Fri, 23 Jun 2017 15:32:37 -0700
Message-ID: <CAM_iQpXhW___-iP3kdv9MJcW=hroyp2SuMzAZdx3KCpc9-W76g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, jean-philippe menil <jpmenil@gmail.com>, Linux Kernel Network Developers <netdev@vger.kernel.org>, John Fastabend <john.fastabend@gmail.com>, virtualization@lists.linux-foundation.org, qemu-devel Developers <qemu-devel@nongnu.org>

On Fri, Jun 23, 2017 at 1:43 AM, Jason Wang <jasowang@redhat.com> wrote:
>
>
> On 2017=E5=B9=B406=E6=9C=8823=E6=97=A5 02:53, Michael S. Tsirkin wrote:
>>
>> On Thu, Jun 22, 2017 at 08:15:58AM +0200, jean-philippe menil wrote:
>>>
>>> Hi Michael,
>>>
>>> from what i see, the race appear when we hit virtnet_reset in
>>> virtnet_xdp_set.
>>> virtnet_reset
>>>    _remove_vq_common
>>>      virtnet_del_vqs
>>>        virtnet_free_queues
>>>          kfree(vi->sq)
>>> when the xdp program (with two instances of the program to trigger it
>>> faster)
>>> is added or removed.
>>>
>>> It's easily repeatable, with 2 cpus and 4 queues on the qemu command
>>> line,
>>> running the xdp_ttl tool from Jesper.
>>>
>>> For now, i'm able to continue my qualification, testing if xdp_qp is no=
t
>>> null,
>>> but do not seem to be a sustainable trick.
>>> if (xdp_qp && vi->xdp_queues_pairs !=3D xdp_qp)
>>>
>>> Maybe it will be more clear to you with theses informations.
>>>
>>> Best regards.
>>>
>>> Jean-Philippe
>>
>>
>> I'm pretty clear about the issue here, I was trying to figure out a fix.
>> Jason, any thoughts?
>>
>>
>
> Hi Jean:
>
> Does the following fix this issue? (I can't reproduce it locally through
> xdp_ttl)

It is tricky here.

>From my understanding of the code base, the tx_lock is not sufficient
here, because in virtnet_del_vqs() all vqs are deleted and one vp
maps to one txq.

I am afraid you have to add a spinlock somewhere to serialized
free_old_xmit_skbs() vs. vring_del_virtqueue(). As you can see
they are in different layers, so it is hard to figure out where to add
it...

Also, make sure we don't sleep inside the spinlock, I see a
synchronize_net().
