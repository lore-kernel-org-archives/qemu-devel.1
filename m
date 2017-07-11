Received: from eggs.gnu.org ([2001:4830:134:3::10]:52452)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dUvWn-0001aF-5U
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 09:48:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dUvWk-00089z-JL
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 09:48:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34218)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dUvWk-00089Z-Cj
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 09:48:34 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4DDE37CE05
	for <qemu-devel@nongnu.org>; Tue, 11 Jul 2017 13:48:33 +0000 (UTC)
Date: Tue, 11 Jul 2017 14:48:29 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170711134829.GV17792@stefanha-x1.localdomain>
References: <20170710072027.7948-1-famz@redhat.com>
	<20170710072027.7948-5-famz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="v7CWsE/Dy737oYst"
Content-Disposition: inline
In-Reply-To: <20170710072027.7948-5-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH RFC 4/5] Introduce iothread-group
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com


--v7CWsE/Dy737oYst
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 10, 2017 at 03:20:26PM +0800, Fam Zheng wrote:
> +static void iothread_group_complete(UserCreatable *obj, Error **errp)
> +{
> +    Error *local_err = NULL;
> +    IOThreadGroup *group = IOTHREAD_GROUP(obj);
> +    char *name, *thread_name;
> +    int i;
> +
> +    group->ctx = aio_context_new(&local_err);
> +    if (!group->ctx) {
> +        error_propagate(errp, local_err);
> +        return;
> +    }
> +
> +    aio_context_set_poll_params(group->ctx, group->poll_params,
> +                                &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        aio_context_unref(group->ctx);
> +        group->ctx = NULL;
> +        return;
> +    }
> +
> +    /* This assumes we are called from a thread with useful CPU affinity for us
> +     * to inherit.
> +     */
> +    name = object_get_canonical_path_component(OBJECT(obj));
> +    group->iothreads = g_new0(IOThread *, group->size);
> +    for (i = 0; i < group->size; ++i) {

group->size > INT_MAX must be rejected.  The error message below is
wrong for this property:

  if (value < 0) {
    error_setg(&local_err, "%s value must be in range [0, %"PRId64"]",
               info->name, INT64_MAX);

--v7CWsE/Dy737oYst
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZZNctAAoJEJykq7OBq3PIRkUH/0u6YRJJUfFQB5ICFYHxP9ju
5di4kMVyueRPp6tmi6afyPZsSSYSjsd0eiL87LYhr/l4xMBzanrsbRvPoeIdjPjI
tkxkkAlALi8RNVN92NKh1mxglI35lVoFpg1QlgefVeU7Lt1Nndfi3qdf/C3rEPb9
CDvQ0BpTO+F1iITK5I46J/ASE64s7enhtRlJmLLjWNdRtH3+1QC3a/L7CFhsMkhG
0zm1hucqcg+/WkRszULnymRKBAf2Jq2xmEJiejDUMwoXf5xSzyhVY67JhxmlB2MQ
Twe1oK3kdOeNFAO1N5n/yZHlhW2x1AvP0WgK7tIJu1FL+oV5rFJHby1i2Pctw5M=
=oaPB
-----END PGP SIGNATURE-----

--v7CWsE/Dy737oYst--
