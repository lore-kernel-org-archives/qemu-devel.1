Received: from eggs.gnu.org ([2001:4830:134:3::10]:58075)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gUo9t-0003TI-EV
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 02:33:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gUo9p-0004M1-Rj
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 02:33:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44440)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1gUo9p-0004Hx-Hn
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 02:33:13 -0500
References: <CAHyh4xgZhGnEvkD5RiUazZ9Eq_jzr4=bXHfwBvCBkbOLN2UyKA@mail.gmail.com>
	<915953bd-cc9c-9456-b619-297138f68ae6@redhat.com>
	<CAHyh4xjNU2ZTvBTqRhVn17SpcqXcKnKvK90oGFeA72t_h3-REw@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <7cc73aeb-5eee-8b4f-c005-aee64dfb1bf8@redhat.com>
Date: Thu, 6 Dec 2018 15:33:02 +0800
MIME-Version: 1.0
In-Reply-To: <CAHyh4xjNU2ZTvBTqRhVn17SpcqXcKnKvK90oGFeA72t_h3-REw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Logging dirty pages from vhost-net in-kernel with
 vIOMMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jintack Lim <jintack@cs.columbia.edu>
Cc: QEMU Devel Mailing List <qemu-devel@nongnu.org>, "Michael S . Tsirkin" <mst@redhat.com>


On 2018/12/5 =E4=B8=8B=E5=8D=8810:47, Jintack Lim wrote:
> On Tue, Dec 4, 2018 at 8:30 PM Jason Wang <jasowang@redhat.com> wrote:
>>
>> On 2018/12/5 =E4=B8=8A=E5=8D=882:37, Jintack Lim wrote:
>>> Hi,
>>>
>>> I'm wondering how the current implementation works when logging dirty
>>> pages during migration from vhost-net (in kernel) when used vIOMMU.
>>>
>>> I understand how vhost-net logs GPAs when not using vIOMMU. But when
>>> we use vhost with vIOMMU, then shouldn't vhost-net need to log the
>>> translated address (GPA) instead of the address written in the
>>> descriptor (IOVA) ? The current implementation looks like vhost-net
>>> just logs IOVA without translation in vhost_get_vq_desc() in
>>> drivers/vhost/net.c. It seems like QEMU doesn't do any further
>>> translation of the dirty log when syncing.
>>>
>>> I might be missing something. Could somebody shed some light on this?
>>
>> Good catch. It looks like a bug to me. Want to post a patch for this?
> Thanks for the confirmation.
>
> What would be a good setup to catch this kind of migration bug? I
> tried to observe it in the VM expecting to see network applications
> not getting data correctly on the destination, but it was not
> successful (i.e. the VM on the destination just worked fine.) I didn't
> even see anything going wrong when I disabled the vhost logging
> completely without using vIOMMU.
>
> What I did is I ran multiple network benchmarks (e.g. netperf tcp
> stream and my own one to check correctness of received data) in a VM
> without vhost dirty page logging, and the benchmarks just ran fine in
> the destination. I checked the used ring at the time the VM is stopped
> in the source for migration, and it had multiple descriptors that is
> (probably) not processed in the VM yet. Do you have any insight how it
> could just work and what would be a good setup to catch this?


According to past experience, it could be reproduced by doing scp from=20
host to guest during migration.


>
> About sending a patch, as Michael suggested, I think it's better for
> you to handle this case - this is not my area of expertise, yet :-)


No problem, I will fix this.

Thanks for spotting this issue.


>> Thanks
>>
>>
>>> Thanks,
>>> Jintack
>>>
>>>
