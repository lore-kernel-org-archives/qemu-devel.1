Received: from eggs.gnu.org ([2001:4830:134:3::10]:57506)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1eMcyp-0004Au-S2
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 11:55:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1eMcyl-0004BH-Mw
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 11:55:31 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46178)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1eMcyl-0004AR-DZ
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 11:55:27 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vB6Gt1Ob053974
	for <qemu-devel@nongnu.org>; Wed, 6 Dec 2017 11:55:22 -0500
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ephf7kc2p-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 06 Dec 2017 11:55:21 -0500
Received: from localhost
	by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 6 Dec 2017 11:55:20 -0500
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <20171117150556.16947-4-eblake@redhat.com>
References: <20171117150556.16947-1-eblake@redhat.com>
	<20171117150556.16947-4-eblake@redhat.com>
Date: Wed, 06 Dec 2017 10:55:13 -0600
Message-Id: <151257931348.8987.3352482385411558267@sif>
Subject: Re: [Qemu-devel] [PULL 3/4] nbd/client: Don't hard-disconnect on
 ESHUTDOWN from server
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-stable@nongnu.org, "open list:Network Block Dev..." <qemu-block@nongnu.org>

Quoting Eric Blake (2017-11-17 09:05:55)
> The NBD spec says that a server may fail any transmission request
> with ESHUTDOWN when it is apparent that no further request from
> the client can be successfully honored.  The client is supposed
> to then initiate a soft shutdown (wait for all remaining in-flight
> requests to be answered, then send NBD_CMD_DISC).  However, since
> qemu's server never uses ESHUTDOWN errors, this code was mostly
> untested since its introduction in commit b6f5d3b5.
> =

> More recently, I learned that nbdkit as the NBD server is able to
> send ESHUTDOWN errors, so I finally tested this code, and noticed
> that our client was special-casing ESHUTDOWN to cause a hard
> shutdown (immediate disconnect, with no NBD_CMD_DISC), but only
> if the server sends this error as a simple reply.  Further
> investigation found that commit d2febedb introduced a regression
> where structured replies behave differently than simple replies -
> but that the structured reply behavior is more in line with the
> spec (even if we still lack code in nbd-client.c to properly quit
> sending further requests).  So this patch reverts the portion of
> b6f5d3b5 that introduced an improper hard-disconnect special-case
> at the lower level, and leaves the future enhancement of a nicer
> soft-disconnect at the higher level for another day.
> =

> CC: qemu-stable@nongnu.org

Since 2.10.x lacks d2febedb, the patch would look something like:

diff --git a/nbd/client.c b/nbd/client.c
index 4caff77119..f04e95542f 100644
--- a/nbd/client.c
+++ b/nbd/client.c
@@ -945,12 +945,6 @@ ssize_t nbd_receive_reply(QIOChannel *ioc, NBDReply *r=
eply, Error **errp)
     reply->handle =3D ldq_be_p(buf + 8);
 =

     reply->error =3D nbd_errno_to_system_errno(reply->error);
-
-    if (reply->error =3D=3D ESHUTDOWN) {
-        /* This works even on mingw which lacks a native ESHUTDOWN */
-        error_setg(errp, "server shutting down");
-        return -EINVAL;
-    }
     trace_nbd_receive_reply(magic, reply->error, reply->handle);
 =

     if (magic !=3D NBD_REPLY_MAGIC) {

If that seems reasonable I can apply it as such.

> Signed-off-by: Eric Blake <eblake@redhat.com>
> Message-Id: <20171113194857.13933-1-eblake@redhat.com>
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  nbd/client.c | 6 ------
>  1 file changed, 6 deletions(-)
> =

> diff --git a/nbd/client.c b/nbd/client.c
> index 4e15fc484d..eea236ca06 100644
> --- a/nbd/client.c
> +++ b/nbd/client.c
> @@ -996,15 +996,9 @@ int nbd_receive_reply(QIOChannel *ioc, NBDReply *rep=
ly, Error **errp)
>          if (ret < 0) {
>              break;
>          }
> -
>          trace_nbd_receive_simple_reply(reply->simple.error,
>                                         nbd_err_lookup(reply->simple.erro=
r),
>                                         reply->handle);
> -        if (reply->simple.error =3D=3D NBD_ESHUTDOWN) {
> -            /* This works even on mingw which lacks a native ESHUTDOWN */
> -            error_setg(errp, "server shutting down");
> -            return -EINVAL;
> -        }
>          break;
>      case NBD_STRUCTURED_REPLY_MAGIC:
>          ret =3D nbd_receive_structured_reply_chunk(ioc, &reply->structur=
ed, errp);
> -- =

> 2.13.6
> =

>=20
