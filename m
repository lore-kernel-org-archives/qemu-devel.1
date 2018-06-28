Received: from eggs.gnu.org ([2001:4830:134:3::10]:58514)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1fYX5r-0003Tk-6w
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 09:36:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1fYX5n-0006cJ-4E
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 09:36:15 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46850 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1fYX5m-0006af-V2
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 09:36:11 -0400
References: <20180604095520.8563-1-xiaoguangrong@tencent.com>
	<20180604095520.8563-10-xiaoguangrong@tencent.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <355310d0-a33d-dab1-1781-2de37dd648f7@redhat.com>
Date: Thu, 28 Jun 2018 21:36:00 +0800
MIME-Version: 1.0
In-Reply-To: <20180604095520.8563-10-xiaoguangrong@tencent.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 09/12] ring: introduce lockless ring buffer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: guangrong.xiao@gmail.com, pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, dgilbert@redhat.com, peterx@redhat.com, jiang.biao2@zte.com.cn, wei.w.wang@intel.com, Xiao Guangrong <xiaoguangrong@tencent.com>



On 2018=E5=B9=B406=E6=9C=8804=E6=97=A5 17:55, guangrong.xiao@gmail.com wr=
ote:
> From: Xiao Guangrong<xiaoguangrong@tencent.com>
>
> It's the simple lockless ring buffer implement which supports both
> single producer vs. single consumer and multiple producers vs.
> single consumer.
>
> Many lessons were learned from Linux Kernel's kfifo (1) and DPDK's
> rte_ring (2) before i wrote this implement. It corrects some bugs of
> memory barriers in kfifo and it is the simpler lockless version of
> rte_ring as currently multiple access is only allowed for producer.
>
> If has single producer vs. single consumer, it is the traditional fifo,
> If has multiple producers, it uses the algorithm as followings:
>
> For the producer, it uses two steps to update the ring:
>     - first step, occupy the entry in the ring:
>
> retry:
>        in =3D ring->in
>        if (cmpxhg(&ring->in, in, in +1) !=3D in)
>              goto retry;
>
>       after that the entry pointed by ring->data[in] has been owned by
>       the producer.
>
>       assert(ring->data[in] =3D=3D NULL);
>
>       Note, no other producer can touch this entry so that this entry
>       should always be the initialized state.
>
>     - second step, write the data to the entry:
>
>       ring->data[in] =3D data;
>
> For the consumer, it first checks if there is available entry in the
> ring and fetches the entry from the ring:
>
>       if (!ring_is_empty(ring))
>            entry =3D &ring[ring->out];
>
>       Note: the ring->out has not been updated so that the entry pointe=
d
>       by ring->out is completely owned by the consumer.
>
> Then it checks if the data is ready:
>
> retry:
>       if (*entry =3D=3D NULL)
>              goto retry;
> That means, the producer has updated the index but haven't written any
> data to it.
>
> Finally, it fetches the valid data out, set the entry to the initialize=
d
> state and update ring->out to make the entry be usable to the producer:
>
>        data =3D *entry;
>        *entry =3D NULL;
>        ring->out++;
>
> Memory barrier is omitted here, please refer to the comment in the code=
.
>
> (1)https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/t=
ree/include/linux/kfifo.h
> (2)http://dpdk.org/doc/api/rte__ring_8h.html
>
> Signed-off-by: Xiao Guangrong<xiaoguangrong@tencent.com>
> ---

May I ask why you need a MPSC ring here? Can we just use N SPSC ring for=20
submitting pages and another N SPSC ring for passing back results?

Thanks
