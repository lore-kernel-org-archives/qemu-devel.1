Received: from eggs.gnu.org ([2001:4830:134:3::10]:54263)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dLMJo-0003sv-Bp
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 00:23:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dLMJl-0001zt-79
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 00:23:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53566)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1dLMJl-0001xH-0K
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 00:23:37 -0400
References: <201706131924483092713@zte.com.cn>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <d62e03ee-f3ab-303e-011d-8b995530b6ab@redhat.com>
Date: Thu, 15 Jun 2017 12:23:27 +0800
MIME-Version: 1.0
In-Reply-To: <201706131924483092713@zte.com.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel]
 =?utf-8?b?562U5aSNOiBSZTog562U5aSNOiBSZTogW1BBVENI?=
 =?utf-8?q?v2_02/04=5D_colo-compare=3A_Process_pactkets_in_the_IOThread_of?=
 =?utf-8?q?the_primary?=
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: wang.yong155@zte.com.cn, zhang.zhanghailiang@huawei.com
Cc: zhangchen.fnst@cn.fujitsu.com, lizhijian@cn.fujitsu.com, qemu-devel@nongnu.org, wang.guang55@zte.com.cn, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>



On 2017=E5=B9=B406=E6=9C=8813=E6=97=A5 19:24, wang.yong155@zte.com.cn wro=
te:
>
> >>Char-fe.c for sure which means frontend of chardev.
>
>
> >>> These API can only watch events in the qemu main thread, not in the
>
> >>> IOThread.
>
> >>>
>
> >>> I had to use the qio_channel_socket_set_aio_fd_handler function to
>
> >>>
>
> >>> monitor the char event in the IOThread,so the io channel is used he=
r
>
> >>>
>
>
> >>The point is not touching the internal structure of chardev like ioc,
>
> >>instead extend its helper like e.g qemu_chr_fe_set_handlers() and let=
 it
>
> >>set aio handlers,
>
>
> >Currently character devices are tied to the GSource API. However,I'll=20
> try to submit a patch first.
>
>
> Hi Jason,
>
>
> I have investigated the change, which involves a great deal.
>
> We have to convert the user of those APIs (the external API is
>
> qemu_chr_fe_add_watch) from GSource/QIOChannel to AioContext.
>
>
> Can we join this series first?  and replace GSource with AioContext in=20
> a future patch.
>
>

Touching internal chardev member out of its scope is bad, we need to=20
seek a solution for this.

Paolo, Marc and Stefan:

We want let chardev front-end run in colo comparing IOThread. This looks=20
not supported by current chardev frontend API. Any idea/suggestion on=20
how to achieve this?

Thanks
