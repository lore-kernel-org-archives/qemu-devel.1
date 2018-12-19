Received: from eggs.gnu.org ([2001:4830:134:3::10]:49669)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gZha0-00056h-8F
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 14:32:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gZhZz-0001Cm-CD
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 14:32:28 -0500
References: <20181217164847.24411-1-remy.noel@blade-group.com>
	<eca584ae-042b-39f7-ca23-c23573676675@redhat.com>
	<5e90fbad-578a-5f0a-7c6d-e06dae7ba8a3@blade-group.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a8813976-fe90-a77a-d75b-0201300ae6ab@redhat.com>
Date: Wed, 19 Dec 2018 20:32:01 +0100
MIME-Version: 1.0
In-Reply-To: <5e90fbad-578a-5f0a-7c6d-e06dae7ba8a3@blade-group.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
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
To: Remy NOEL <remy.noel@blade-group.com>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>, Stefan Weil <sw@weilnetz.de>, "open list:Block I/O path" <qemu-block@nongnu.org>

On 19/12/18 17:29, Remy NOEL wrote:
>>
>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 atomic_read(&ctx->poll_disable_cnt) +
>>> poll_disable_change);
>>> =C2=A0 -=C2=A0=C2=A0=C2=A0 aio_epoll_update(ctx, node, is_new);
>>> +=C2=A0=C2=A0=C2=A0 if (new_node) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 aio_epoll_update(ctx, new=
_node, is_new);
>>> +=C2=A0=C2=A0=C2=A0 }
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_lockcnt_unlock(&ctx->list_lock);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 aio_notify(ctx);
>> ... so I think this should be "if (node || new_node)"?
>=20
> Well, currently, when an AioHandler is removed, we do not change
> node->pdf.events (only revents).
>=20
> Therefore a call to aio_epoll_update on node will only result in a call
> to epoll_ctl with EPOLL_CTL_MOD and the same event, which seems kinda
> pointless.
>=20
> we may set node->pfd.events to 0 to unregister the file descriptor, but
> this would change the behavior compared to current handling of node
> deletion if i'm not mistaken.

You found another bug then. :)

Paolo
