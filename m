Received: from eggs.gnu.org ([2001:4830:134:3::10]:56691)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dHjCa-0001yA-W8
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 00:01:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dHjCX-0007qj-Vj
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 00:01:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49448)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1dHjCX-0007oY-Pp
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 00:01:09 -0400
References: <20170505162305.15763-1-berrange@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <8ea542c3-d13a-488f-9266-746b6ac1c491@redhat.com>
Date: Mon, 5 Jun 2017 12:00:54 +0800
MIME-Version: 1.0
In-Reply-To: <20170505162305.15763-1-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] Revert "Change net/socket.c to use
 socket_*() functions" again
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Ashijeet Acharya <ashijeetacharya@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>



On 2017=E5=B9=B405=E6=9C=8806=E6=97=A5 00:23, Daniel P. Berrange wrote:
> This reverts commit 883e4f7624e10b98d16d9adaffb8b1795664d899.
>
> This code changed net/socket.c from using socket()+connect(),
> to using socket_connect(). In theory this is great, but in
> practice this has completely broken the ability to connect
> the frontend and backend:
>
>    $ ./x86_64-softmmu/qemu-system-x86_64 \
>         -device e1000,id=3De0,netdev=3Dhn0,mac=3DDE:AD:BE:EF:AF:05 \
>         -netdev socket,id=3Dhn0,connect=3Dlocalhost:1234
>    qemu-system-x86_64: -device e1000,id=3De0,netdev=3Dhn0,mac=3DDE:AD:B=
E:EF:AF:05: Property 'e1000.netdev' can't find value 'hn0'
>
> The old code would call net_socket_fd_init() synchronously,
> while letting the connect() complete in the backgorund. The
> new code moved net_socket_fd_init() so that it is only called
> after connect() completes in the background.
>
> Thus at the time we initialize the NIC frontend, the backend
> does not exist.
>
> The socket_connect() conversion as done is a bad fit for the
> current code, since it did not try to change the way it deals
> with async connection completion. Rather than try to fix this,
> just revert the socket_connect() conversion entirely.
>
> The code is about to be converted to use QIOChannel which
> will let the problem be solved in a cleaner manner. This
> revert is more suitable for stable branches in the meantime.
>
> Signed-off-by: Daniel P. Berrange<berrange@redhat.com>
> ---
>   net/socket.c | 127 ++++++++++++++++++++++++++------------------------=
---------
>   1 file changed, 56 insertions(+), 71 deletions(-)

Applied in -net.

Thanks
