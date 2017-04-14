Received: from eggs.gnu.org ([2001:4830:134:3::10]:36893)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cyusk-0005Yc-8E
	for qemu-devel@nongnu.org; Fri, 14 Apr 2017 02:38:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cyusf-0002le-DN
	for qemu-devel@nongnu.org; Fri, 14 Apr 2017 02:38:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46022)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1cyusf-0002lN-7P
	for qemu-devel@nongnu.org; Fri, 14 Apr 2017 02:38:53 -0400
References: <1487734936-43472-1-git-send-email-zhang.zhanghailiang@huawei.com>
	<1487734936-43472-3-git-send-email-zhang.zhanghailiang@huawei.com>
	<134776c2-a85d-d06f-5f98-2e664f9c8ca9@cn.fujitsu.com>
	<d33b0150-5ed2-56cc-9261-da7deb1d0bfb@redhat.com>
	<58F06AA1.2010301@huawei.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <9b42232a-e86f-2d61-7987-7a0559d6f705@redhat.com>
Date: Fri, 14 Apr 2017 14:38:40 +0800
MIME-Version: 1.0
In-Reply-To: <58F06AA1.2010301@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 02/15] colo-compare: implement the process
 of checkpoint
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Hailiang Zhang <zhang.zhanghailiang@huawei.com>, Zhang Chen <zhangchen.fnst@cn.fujitsu.com>, qemu-devel@nongnu.org
Cc: xuquan8@huawei.com, dgilbert@redhat.com, lizhijian@cn.fujitsu.com, xiecl.fnst@cn.fujitsu.com



On 2017=E5=B9=B404=E6=9C=8814=E6=97=A5 14:22, Hailiang Zhang wrote:
> Hi Jason,
>
> On 2017/4/14 13:57, Jason Wang wrote:
>>
>> On 2017=E5=B9=B402=E6=9C=8822=E6=97=A5 17:31, Zhang Chen wrote:
>>>
>>> On 02/22/2017 11:42 AM, zhanghailiang wrote:
>>>> While do checkpoint, we need to flush all the unhandled packets,
>>>> By using the filter notifier mechanism, we can easily to notify
>>>> every compare object to do this process, which runs inside
>>>> of compare threads as a coroutine.
>>> Hi~ Jason and Hailiang.
>>>
>>> I will send a patch set later about colo-compare notify mechanism for
>>> Xen like this patch.
>>> I want to add a new chardev socket way in colo-comapre connect to Xen
>>> colo, for notify
>>> checkpoint or failover, Because We have no choice to use this way
>>> communicate with Xen codes.
>>> That's means we will have two notify mechanism.
>>> What do you think about this?
>>>
>>>
>>> Thanks
>>> Zhang Chen
>> I was thinking the possibility of using similar way to for colo compar=
e.
>> E.g can we use socket? This can saves duplicated codes more or less.
>
> Since there are too many sockets used by filter and COLO, (Two unix=20
> sockets and two
>  tcp sockets for each vNIC), I don't want to introduce more ;) , but=20
> i'm not sure if it is
> possible to make it more flexible and optional, abstract these=20
> duplicated codes,
> pass the opened fd (No matter eventfd or socket fd ) as parameter, for=20
> example.
> Is this way acceptable ?
>
> Thanks,
> Hailiang

Yes, that's kind of what I want. We don't want to use two message=20
format. Passing a opened fd need management support, we still need a=20
fallback if there's no management on top. For qemu/kvm, we can do all=20
stuffs transparent to the cli by e.g socketpair() or others, but the key=20
is to have a unified message format.

Thoughts?

Thanks

>
>> Thanks
>>
>>
>> .
>>
>
>
