Received: from eggs.gnu.org ([2001:4830:134:3::10]:55239)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <remy.noel@blade-group.com>) id 1gZeiz-0007Hm-Cv
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 11:29:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <remy.noel@blade-group.com>) id 1gZeiw-0001K1-0a
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 11:29:33 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:40495)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <remy.noel@blade-group.com>)
	id 1gZeiv-0001H3-Li
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 11:29:29 -0500
Received: by mail-wm1-x343.google.com with SMTP id f188so6401529wmf.5
	for <qemu-devel@nongnu.org>; Wed, 19 Dec 2018 08:29:27 -0800 (PST)
References: <20181217164847.24411-1-remy.noel@blade-group.com>
	<eca584ae-042b-39f7-ca23-c23573676675@redhat.com>
From: Remy NOEL <remy.noel@blade-group.com>
Message-ID: <5e90fbad-578a-5f0a-7c6d-e06dae7ba8a3@blade-group.com>
Date: Wed, 19 Dec 2018 17:29:47 +0100
MIME-Version: 1.0
In-Reply-To: <eca584ae-042b-39f7-ca23-c23573676675@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US-large
Subject: Re: [Qemu-devel] [QEMU-devel][PATCH v3] aio-posix: Fix concurrent
 aio_poll/set_fd_handler.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>, Stefan Weil <sw@weilnetz.de>, "open list:Block I/O path" <qemu-block@nongnu.org>

On 12/18/18 6:39 PM, Paolo Bonzini wrote:

> On 17/12/18 17:48, remy.noel@blade-group.com wrote:
>> Also, we do not call aio_epoll_update for deleted handlers as this has
>> no impact whatsoever.
> Why?  epoll is used in level-triggered mode, so you do have to remove
> the file descriptor...
>
>>                  atomic_read(&ctx->poll_disable_cnt) + poll_disable_change);
>>   
>> -    aio_epoll_update(ctx, node, is_new);
>> +    if (new_node) {
>> +        aio_epoll_update(ctx, new_node, is_new);
>> +    }
>>       qemu_lockcnt_unlock(&ctx->list_lock);
>>       aio_notify(ctx);
> ... so I think this should be "if (node || new_node)"?

Well, currently, when an AioHandler is removed, we do not change 
node->pdf.events (only revents).

Therefore a call to aio_epoll_update on node will only result in a call 
to epoll_ctl with EPOLL_CTL_MOD and the same event, which seems kinda 
pointless.

we may set node->pfd.events to 0 to unregister the file descriptor, but 
this would change the behavior compared to current handling of node 
deletion if i'm not mistaken.

Remy
