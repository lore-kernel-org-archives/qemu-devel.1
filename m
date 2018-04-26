Received: from eggs.gnu.org ([2001:4830:134:3::10]:46065)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fBbKS-0005Hq-NB
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 03:28:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fBbKO-0002lG-MG
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 03:28:32 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60266 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fBbKO-0002kr-HO
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 03:28:28 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B80984270947
	for <qemu-devel@nongnu.org>; Thu, 26 Apr 2018 07:28:23 +0000 (UTC)
Date: Thu, 26 Apr 2018 15:28:13 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180426072813.GR9036@xz-mi>
References: <20180425112723.1111-1-quintela@redhat.com>
	<20180425112723.1111-6-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180425112723.1111-6-quintela@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v12 05/21] migration: Export functions to
 create send channels
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com, lvivier@redhat.com

On Wed, Apr 25, 2018 at 01:27:07PM +0200, Juan Quintela wrote:
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  migration/socket.c | 28 +++++++++++++++++++++++++++-
>  migration/socket.h |  7 +++++++
>  2 files changed, 34 insertions(+), 1 deletion(-)
>=20
> diff --git a/migration/socket.c b/migration/socket.c
> index edf33c70cf..893a04f4cc 100644
> --- a/migration/socket.c
> +++ b/migration/socket.c
> @@ -29,6 +29,28 @@
>  #include "trace.h"
> =20
> =20
> +struct SocketOutgoingArgs {
> +    SocketAddress *saddr;
> +} outgoing_args;

I am not sure whether I have asked before, but... could we put this
into MigrateState*?  The thing is that introducing more global
variables will make things scattered, and we do stuff to merge them
(like the RAMState cleanup work).  IMHO it saves time if we can do it
from the very beginning.

> +
> +void socket_send_channel_create(QIOTaskFunc f, void *data)
> +{
> +    QIOChannelSocket *sioc =3D qio_channel_socket_new();
> +    qio_channel_socket_connect_async(sioc, outgoing_args.saddr,
> +                                     f, data, NULL, NULL);
> +}
> +
> +int socket_send_channel_destroy(QIOChannel *send)
> +{
> +    /* Remove channel */
> +    object_unref(OBJECT(send));
> +    if (outgoing_args.saddr) {
> +        qapi_free_SocketAddress(outgoing_args.saddr);
> +        outgoing_args.saddr =3D NULL;
> +    }
> +    return 0;
> +}

Here I would possibly avoid bothering introducing the two new APIs
since AFAIU they didn't do much things, and both of them are only
called once...  And IMHO when we call socket_send_channel_create() in
multifd_save_setup() we can initialize MultiFDSendParams->c already
with the object returned by qio_channel_socket_new() if without the
API, instead of waiting until multifd_new_send_channel_async() is
called.

Thanks,

--=20
Peter Xu
