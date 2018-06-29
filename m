Received: from eggs.gnu.org ([2001:4830:134:3::10]:36845)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1fYmgl-0005Zv-3T
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 02:15:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1fYmgh-0003ys-Nm
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 02:15:22 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51044 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1fYmgh-0003x5-ED
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 02:15:19 -0400
References: <20180604095520.8563-1-xiaoguangrong@tencent.com>
	<20180604095520.8563-10-xiaoguangrong@tencent.com>
	<355310d0-a33d-dab1-1781-2de37dd648f7@redhat.com>
	<73324779-b76f-3081-adbb-590bc2030833@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <b0373677-8503-aea8-caf0-6a16c36fc12b@redhat.com>
Date: Fri, 29 Jun 2018 14:15:07 +0800
MIME-Version: 1.0
In-Reply-To: <73324779-b76f-3081-adbb-590bc2030833@gmail.com>
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
To: Xiao Guangrong <guangrong.xiao@gmail.com>, pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, dgilbert@redhat.com, peterx@redhat.com, jiang.biao2@zte.com.cn, wei.w.wang@intel.com, Xiao Guangrong <xiaoguangrong@tencent.com>



On 2018=E5=B9=B406=E6=9C=8829=E6=97=A5 11:59, Xiao Guangrong wrote:
>
>
> On 06/28/2018 09:36 PM, Jason Wang wrote:
>>
>>
>> On 2018=E5=B9=B406=E6=9C=8804=E6=97=A5 17:55, guangrong.xiao@gmail.com=
 wrote:
>>> From: Xiao Guangrong<xiaoguangrong@tencent.com>
>>>
>>> It's the simple lockless ring buffer implement which supports both
>>> single producer vs. single consumer and multiple producers vs.
>>> single consumer.
>>>
>
>>> Finally, it fetches the valid data out, set the entry to the=20
>>> initialized
>>> state and update ring->out to make the entry be usable to the produce=
r:
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 data =3D *entry;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *entry =3D NULL;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ring->out++;
>>>
>>> Memory barrier is omitted here, please refer to the comment in the=20
>>> code.
>>>
>>> (1)https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git=
/tree/include/linux/kfifo.h=20
>>>
>>> (2)http://dpdk.org/doc/api/rte__ring_8h.html
>>>
>>> Signed-off-by: Xiao Guangrong<xiaoguangrong@tencent.com>
>>> ---
>>
>> May I ask why you need a MPSC ring here? Can we just use N SPSC ring=20
>> for submitting pages and another N SPSC ring for passing back results?
>
> Sure.
>
> We had this option in our mind, however, it is not scalable which will=20
> slow
> the main thread down, instead, we'd rather to speed up main thread and=20
> move
> reasonable workload to the threads.

I'm not quite understand the scalability issue here. Is it because of=20
main thread need go through all N rings (which I think not)?

Thanks
