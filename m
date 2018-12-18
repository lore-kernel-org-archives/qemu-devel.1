Received: from eggs.gnu.org ([2001:4830:134:3::10]:58803)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gZJLt-0000Fx-RG
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 12:40:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gZJLr-000284-2J
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 12:40:15 -0500
References: <20181217164847.24411-1-remy.noel@blade-group.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <eca584ae-042b-39f7-ca23-c23573676675@redhat.com>
Date: Tue, 18 Dec 2018 18:39:55 +0100
MIME-Version: 1.0
In-Reply-To: <20181217164847.24411-1-remy.noel@blade-group.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: remy.noel@blade-group.com, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>, Stefan Weil <sw@weilnetz.de>, "open list:Block I/O path" <qemu-block@nongnu.org>

On 17/12/18 17:48, remy.noel@blade-group.com wrote:
> Also, we do not call aio_epoll_update for deleted handlers as this has
> no impact whatsoever.

Why?  epoll is used in level-triggered mode, so you do have to remove
the file descriptor...

>                 atomic_read(&ctx->poll_disable_cnt) + poll_disable_change);
>  
> -    aio_epoll_update(ctx, node, is_new);
> +    if (new_node) {
> +        aio_epoll_update(ctx, new_node, is_new);
> +    }
>      qemu_lockcnt_unlock(&ctx->list_lock);
>      aio_notify(ctx);

... so I think this should be "if (node || new_node)"?

Paolo
