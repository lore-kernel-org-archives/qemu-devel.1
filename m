Received: from eggs.gnu.org ([2001:4830:134:3::10]:44091)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eAiBY-0002CJ-Qo
	for Qemu-devel@nongnu.org; Fri, 03 Nov 2017 16:03:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eAiBU-0005MK-7p
	for Qemu-devel@nongnu.org; Fri, 03 Nov 2017 16:03:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58214)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eAiBT-0005La-Tn
	for Qemu-devel@nongnu.org; Fri, 03 Nov 2017 16:03:20 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D9B67861B
	for <Qemu-devel@nongnu.org>; Fri,  3 Nov 2017 20:03:18 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Message-ID: <f88b9c1e-6331-8c7f-b748-62dc11a50c1e@redhat.com>
Date: Fri, 3 Nov 2017 15:03:17 -0500
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="SJq9hbcadBfdLiVEXG2f5TaFsO6O215cC"
Subject: [Qemu-devel] coroutine question, for NBD debugging
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Qemu-devel@nongnu.org" <Qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SJq9hbcadBfdLiVEXG2f5TaFsO6O215cC
From: Eric Blake <eblake@redhat.com>
To: "Qemu-devel@nongnu.org" <Qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f88b9c1e-6331-8c7f-b748-62dc11a50c1e@redhat.com>
Subject: coroutine question, for NBD debugging
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

In include/qemu/coroutine.h, we have:

/**
 * Yield the coroutine for a given duration
 *
 * Behaves similarly to co_sleep_ns(), but the sleeping coroutine will be=

 * resumed when using aio_poll().
 */
void coroutine_fn co_aio_sleep_ns(AioContext *ctx, QEMUClockType type,

but there is no co_sleep_ns() anywhere.  What should the documentation
actually state?

Meanwhile, I'm trying to figure out if there is an easy way to hack
qemu-nbd to send two structured replies interleaved (as in A.1, B.1,
A.2, B.2) to ensure the NBD client coroutines properly handle
interleaved responses, but adding a plain sleep() between A.1 and A.2
does not work, and I'm not sure whether co_aio_sleep_ns() would work for
the hack instead.

The hack I'm currently playing with splits reads and structured errors
into two parts, attempting to use sleeps to force the server to send
replies out of order:

diff --git c/nbd/server.c w/nbd/server.c
index bcf0cdb47c..4b642127bb 100644
--- c/nbd/server.c
+++ w/nbd/server.c
@@ -1285,13 +1285,24 @@ static int coroutine_fn
nbd_co_send_structured_read(NBDClient *client,
         {.iov_base =3D &chunk, .iov_len =3D sizeof(chunk)},
         {.iov_base =3D data, .iov_len =3D size}
     };
+    int ret;

     trace_nbd_co_send_structured_read(handle, offset, data, size);
-    set_be_chunk(&chunk.h, NBD_REPLY_FLAG_DONE, NBD_REPLY_TYPE_OFFSET_DA=
TA,
+    set_be_chunk(&chunk.h, 0, NBD_REPLY_TYPE_OFFSET_DATA,
                  handle, sizeof(chunk) - sizeof(chunk.h) + size);
     stq_be_p(&chunk.offset, offset);

-    return nbd_co_send_iov(client, iov, 2, errp);
+    ret =3D nbd_co_send_iov(client, iov, 2, errp);
+    if (ret < 0) {
+        return ret;
+    }
+
+    sleep(2);
+
+    set_be_chunk(&chunk.h, NBD_REPLY_FLAG_DONE, NBD_REPLY_TYPE_NONE,
+                 handle, 0);
+    iov[0].iov_len =3D sizeof(chunk.h);
+    return nbd_co_send_iov(client, iov, 1, errp);
 }

 static int coroutine_fn nbd_co_send_structured_error(NBDClient *client,
@@ -1306,16 +1317,27 @@ static int coroutine_fn
nbd_co_send_structured_error(NBDClient *client,
         {.iov_base =3D &chunk, .iov_len =3D sizeof(chunk)},
         {.iov_base =3D (char *)msg, .iov_len =3D msg ? strlen(msg) : 0},=

     };
+    int ret;

     assert(nbd_err);
     trace_nbd_co_send_structured_error(handle, nbd_err,
                                        nbd_err_lookup(nbd_err), msg ?
msg : "");
-    set_be_chunk(&chunk.h, NBD_REPLY_FLAG_DONE, NBD_REPLY_TYPE_ERROR,
handle,
+    set_be_chunk(&chunk.h, 0, NBD_REPLY_TYPE_ERROR, handle,
                  sizeof(chunk) - sizeof(chunk.h) + iov[1].iov_len);
     stl_be_p(&chunk.error, nbd_err);
     stw_be_p(&chunk.message_length, iov[1].iov_len);

-    return nbd_co_send_iov(client, iov, 1 + !!iov[1].iov_len, errp);
+    ret =3D nbd_co_send_iov(client, iov, 1 + !!iov[1].iov_len, errp);
+    if (ret < 0) {
+        return ret;
+    }
+
+    sleep(1);
+
+    set_be_chunk(&chunk.h, NBD_REPLY_FLAG_DONE, NBD_REPLY_TYPE_NONE,
+                 handle, 0);
+    iov[0].iov_len =3D sizeof(chunk.h);
+    return nbd_co_send_iov(client, iov, 1, errp);
 }

 /* nbd_co_receive_request


coupled with a client that does:

$ ./qemu-io -f raw nbd://localhost:10809/foo --trace=3D'nbd_*' -c
'aio_write -P 3 1 1' -c 'aio_read -P 1 1 1'

but the trace shows that the client does not receive B.1 until after it
has blocked waiting for A.2, which is not what I was hoping to see.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--SJq9hbcadBfdLiVEXG2f5TaFsO6O215cC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAln8y4UACgkQp6FrSiUn
Q2oA5wf8DiHd8Vr8nQmSpK9yhVGmJzV9cmnqg8gvbP+Xcwyx2klbeCZvxGaKFl75
kkVbEqhfT71JE9byRZlKV0Q5CLA+1VZse/nus8nCrEv7pV4hjIeLH7851VCOj4Ca
xNl0R1P/abhk9XnLzXcriIiRd6wvuk0G9Xx4s9IeoPQqL4UR8srrS3Su5IaejR0H
BoeVPdP1kOAOFWfViUYL6TDXLdUdXjXK4C1sfcmamKD6he/bUFKBaAz5LIyIj26t
a081VrdFnM47dL8TVBo0oaGOJncnAPE30Bhk0W3uwWuRdd5TrMKwHola8XYoQb1D
UC4U/fM9P8u1tm0sl1HztVi4rKBvOg==
=PJRu
-----END PGP SIGNATURE-----

--SJq9hbcadBfdLiVEXG2f5TaFsO6O215cC--
