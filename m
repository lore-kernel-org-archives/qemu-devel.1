Received: from eggs.gnu.org ([2001:4830:134:3::10]:47769)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cTrh9-0002O1-3C
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 09:58:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cTrh5-0000HN-Vc
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 09:58:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37604)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cTrh5-0000GZ-QK
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 09:58:35 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C90A2504BE
	for <qemu-devel@nongnu.org>; Wed, 18 Jan 2017 14:58:35 +0000 (UTC)
Date: Wed, 18 Jan 2017 14:58:33 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170118145833.GF30347@stefanha-x1.localdomain>
References: <20170113131731.1246-1-pbonzini@redhat.com>
	<20170113131731.1246-6-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gdTfX7fkYsEEjebm"
Content-Disposition: inline
In-Reply-To: <20170113131731.1246-6-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 05/16] io: make qio_channel_yield aware of
 AioContexts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, famz@redhat.com


--gdTfX7fkYsEEjebm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 13, 2017 at 02:17:20PM +0100, Paolo Bonzini wrote:
>  /**
> + * qio_channel_set_aio_context:
> + * @ioc: the channel object
> + * @ctx: the #AioContext to set the handlers on
> + *
> + * Request that qio_channel_yield() sets I/O handlers on
> + * the given #AioContext.  If @ctx is %NULL, qio_channel_yield()
> + * uses QEMU's main thread event loop.
> + */
> +void qio_channel_set_aio_context(QIOChannel *ioc,
> +                                 AioContext *ctx);
> +
> +/**
> + * qio_channel_detach_aio_context:
> + * @ioc: the channel object
> + *
> + * Disable any I/O handlers set by qio_channel_yield().  With the
> + * help of aio_co_schedule(), this allows moving a coroutine that was
> + * paused by qio_channel_yield() to another context.
> + */
> +void qio_channel_detach_aio_context(QIOChannel *ioc);

The block layer's bdrv_set_aio_context() has different semantics.  It
invokes .detach()/.attach() callbacks and does AioContext locking so the
function can be called safely even while the block driver is waiting for
events.

It's unfortunate to that the block and io channel APIs act differently
despite having similar names.  Was there a reason to choose different
semantics?

> +
> +/**
>   * qio_channel_yield:
>   * @ioc: the channel object
>   * @condition: the I/O condition to wait for
>   *
> - * Yields execution from the current coroutine until
> - * the condition indicated by @condition becomes
> - * available.
> + * Yields execution from the current coroutine until the condition
> + * indicated by @condition becomes available.  @condition must
> + * be either %G_IO_IN or %G_IO_OUT; it cannot contain both.  In
> + * addition, no two coroutine can be waiting on the same condition

s/coroutine/coroutines/

--gdTfX7fkYsEEjebm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYf4KZAAoJEJykq7OBq3PI9kEIAIzRD0jRFRzkLHHamfYLPzA0
ipBHVi7wdfGzeg+q1vL5sBSPp5ZwnDWMrMH9yWGdBd43oZZ1un8dDu5rff6XQhUi
QHXbKNsHJ11Z3Yao6U2neV/4AwwbNNG0B0yJjRki3iCEaVPuKBNvT7mSLlCnl8kW
r9fkE1LWqqFekIVFScWryRLGKZAW8TLR6vi40vvbSTi7TqvYg09i8102eL4ILzT7
Dpng9KDNEns1kHXZa+tWZDm+KLdc7cuJuykK8YLK2oAlqL8R6JGdbDaiv4lPrgYP
9308ciYmqNarBYpwj4Um4/g+hzeU53gQiI+Ln4SZUQPvBqczWo+6QK8rUvAmqhc=
=Zckj
-----END PGP SIGNATURE-----

--gdTfX7fkYsEEjebm--
