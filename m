Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BC65C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 11:06:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46E582077B
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 11:06:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LtuB+1LR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46E582077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57704 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifMIW-0005Bd-Bc
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 06:06:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46273)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1ifMHk-0004ct-IY
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 06:05:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1ifMHi-00047v-U0
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 06:05:32 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:50837)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1ifMHi-000468-Ly
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 06:05:30 -0500
Received: by mail-wm1-x341.google.com with SMTP id a5so1900721wmb.0
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 03:05:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=5zEkpfuhmmYzTM6Zw4x+jgEwCVkCkpIugjomt8Ng2wo=;
 b=LtuB+1LR6WpVUSora9nFVAAS6K1MV9slQ5LZhyB11K2MCN6S0apAGalDu4X01tCWly
 clFt0psFfAR8ldDz0XdWG+qhlDt55Nz6yUGUt07x9kbQ1g14iBxJYxHKobilEVtPn6/E
 /o4NZiL3KmTI+hhuVVH/ppWn2UXpG94yzqZASLm9EIeShyS4NpWJZpXA+GLAupLE/jIT
 ETU2ZKlFcsa5aW3v+2X6A5U6qISfTurEQQGxTXJGMFL9tNpO+XB+RrCeDklnBGCorfb6
 /8O2DOhZj5/y6xAEjKj1eKrJPn2kAJlzCvZcM4rpkcJ8uXxHa1UE2QfgsjriPx3aubhx
 FmjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=5zEkpfuhmmYzTM6Zw4x+jgEwCVkCkpIugjomt8Ng2wo=;
 b=nTA9PXOQ0XslI7L1N4do4v9nLmIQKyImX4b/IOqsz2Guz6EXEcOXQGJ5amAtVp8ixY
 gWGBIZYqJoEcCIPElN/zlLIF4LH4iZnyOyKt4Exbq0m3URaJYhPt6BPMxZbvrw7MSFLc
 MV93R++YhOu6aBZ+cePEfR7CwaSqENQk1QvplYPOSCmc536fAFc3ryv83J4JQ/yf8tmU
 GdR9W0g7Jo0CkFNSv5SLQ33dpgTlmKlPB45BKWYSkseiTvC6nNTitHsiBuFlHdomqTPe
 XVSNsqhKRU0tL3mqabQGAbtSoYcZhf0draGTFS+u6z9oKZF0V0fMuKz+7EoZhK19pFew
 4ZdQ==
X-Gm-Message-State: APjAAAXucKzvJteuLIENe/OLEJAqmYfezoqy6Fh15ysnGQXnD1u74DP7
 NWTmp49EXuI+hLxJQyCj4fI=
X-Google-Smtp-Source: APXvYqxuMpH20ENgX9GmJNFU1Ql1L0s9kiT6ftnRmVyxMsQ5Utg0LIPNxxeLTVTxNdARcg7pRHYHaQ==
X-Received: by 2002:a7b:c151:: with SMTP id z17mr5819752wmi.137.1576148729098; 
 Thu, 12 Dec 2019 03:05:29 -0800 (PST)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id f17sm5769894wmc.8.2019.12.12.03.05.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Dec 2019 03:05:27 -0800 (PST)
Date: Thu, 12 Dec 2019 11:05:25 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: ning.bo9@zte.com.cn
Subject: Re: [Qemu-devel] [PATCH v2] vhost-vsock: report QMP event when
 setrunning
Message-ID: <20191212110525.GA1141992@stefanha-x1.localdomain>
References: <20190809134134.GA8594@stefanha-x1.localdomain>
 <201911281926474453744@zte.com.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="T4sUOijqQbZv57TR"
Content-Disposition: inline
In-Reply-To: <201911281926474453744@zte.com.cn>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: mst@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--T4sUOijqQbZv57TR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 28, 2019 at 07:26:47PM +0800, ning.bo9@zte.com.cn wrote:
> Let me describe the issue with an example via `nc-vsock`:
>=20
> Let's assume the Guest cid is 3.
> execute 'rmmod vmw_vsock_virtio_transport' in Guest,
> then execute 'while true; do nc-vsock 3 1234' in Host.
>=20
> Host                             Guest
>                                  # rmmod vmw_vsock_virtio_transport
>=20
> # while true; do ./nc-vsock 3 1234; done
> (after 2 second)
> connect: Connection timed out
> (after 2 second)
> connect: Connection timed out
> ...
>=20
>                                  # modprobe vmw_vsock_virtio_transport
>=20
> connect: Connection reset by peer
> connect: Connection reset by peer
> connect: Connection reset by peer
> ...
>=20
>                                  # nc-vsock -l 1234
>                                  Connetion from cid 2 port ***...
> (stop printing)
>=20
>=20
> The above process simulates the communication process between
> the `kata-runtime` and `kata-agent` after starting the Guest.
> In order to connect to `kata-agent` as soon as possible,=20
> `kata-runtime` will continuously try to connect to `kata-agent` in a loop.
> see https://github.com/kata-containers/runtime/blob/d054556f60f092335a22a=
288011fa29539ad4ccc/vendor/github.com/kata-containers/agent/protocols/clien=
t/client.go#L327
> But when the vsock device in the Guest is not ready, the connection
> will block for 2 seconds. This situation actually slows down
> the entire startup time of `kata-runtime`.

This can be done efficiently as follows:
1. kata-runtime listens on a vsock port
2. kata-agent-port=3DPORT is added to the kernel command-line options
3. kata-agent parses the port number and connects to the host

This eliminates the reconnection attempts.

> > I think that adding a QMP event is working around the issue rather than
> > fixing the root cause.  This is probably a vhost_vsock.ko problem and
> > should be fixed there.
>=20
> After looking at the source code of vhost_vsock.ko,=20
> I think it is possible to optimize the logic here too.
> The simple patch is as follows. Do you think the modification is appropri=
ate?
>=20
> diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
> index 9f57736f..8fad67be 100644
> --- a/drivers/vhost/vsock.c
> +++ b/drivers/vhost/vsock.c
> @@ -51,6 +51,7 @@ struct vhost_vsock {
>  	atomic_t queued_replies;
>=20
>  	u32 guest_cid;
> +	u32 state;
>  };
>=20
>  static u32 vhost_transport_get_local_cid(void)
> @@ -497,6 +541,7 @@ static int vhost_vsock_start(struct vhost_vsock *vsoc=
k)
>=20
>  		mutex_unlock(&vq->mutex);
>  	}
> +	vsock->state =3D 1;
>=20
>  	mutex_unlock(&vsock->dev.mutex);
>  	return 0;
> @@ -535,6 +580,7 @@ static int vhost_vsock_stop(struct vhost_vsock *vsock)
>  		vq->private_data =3D NULL;
>  		mutex_unlock(&vq->mutex);
>  	}
> +	vsock->state =3D 0;
>=20
>  err:
>  	mutex_unlock(&vsock->dev.mutex);
> @@ -786,6 +832,27 @@ static struct miscdevice vhost_vsock_misc =3D {
>  	.fops =3D &vhost_vsock_fops,
>  };
>=20
> +int vhost_transport_connect(struct vsock_sock *vsk) {
> +	struct vhost_vsock *vsock;
> +
> +	rcu_read_lock();
> +
> +	/* Find the vhost_vsock according to guest context id  */
> +	vsock =3D vhost_vsock_get(vsk->remote_addr.svm_cid);
> +	if (!vsock) {
> +		rcu_read_unlock();
> +		return -ENODEV;
> +	}
> +
> +	rcu_read_unlock();
> +
> +	if (vsock->state =3D=3D 1) {
> +		return virtio_transport_connect(vsk);
> +	} else {
> +		return -ECONNRESET;
> +	}
> +}
> +
>  static struct virtio_transport vhost_transport =3D {
>  	.transport =3D {
>  		.get_local_cid            =3D vhost_transport_get_local_cid,
> @@ -793,7 +860,7 @@ static struct virtio_transport vhost_transport =3D {
>  		.init                     =3D virtio_transport_do_socket_init,
>  		.destruct                 =3D virtio_transport_destruct,
>  		.release                  =3D virtio_transport_release,
> -		.connect                  =3D virtio_transport_connect,
> +		.connect                  =3D vhost_transport_connect,
>  		.shutdown                 =3D virtio_transport_shutdown,
>  		.cancel_pkt               =3D vhost_transport_cancel_pkt,

I'm not keen on adding a special case for vhost_vsock.ko connect.

Userspace APIs to avoid the 2 second wait already exist:

1. The SO_VM_SOCKETS_CONNECT_TIMEOUT socket option controls the connect
   timeout for this socket.

2. Non-blocking connect allows the userspace process to do other things
   while a connection attempt is being made.

But the best solution is the one I mentioned above.

Stefan

--T4sUOijqQbZv57TR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl3yHvUACgkQnKSrs4Gr
c8jg5ggAqaIQAS2Z81lTIi4bs475raquTl3SUzc+6T8yciP/Xs1Sb7tVdHx3WwFq
v1eqefEKrNNpdjUncOKoHRa4uMQZJSlVaJCsEmHUKBGOQPi+hJ8X0Q57/w4hEYQ6
bXrVPlwFK1vBzPPTr1w4qKbKIJyqCYrjhxUxr2KeVr1q8jpvdxnXTILTLWU1JCNS
Fh1l69CTM0RjtRiW4mbskNspNCluS5sq3KG0PMCBW+VqPNP9rXL6C3qpIwM1RY9p
XTrUNSS4wqRNXl2Ug/Pt52Vwr4YAAezsyC+JOCUZbC3nvzR/C2L4i1p/HLVvOuDI
9nsEqtr1Cj7xBuCKq9KCTfS2jpCsTg==
=0QNN
-----END PGP SIGNATURE-----

--T4sUOijqQbZv57TR--

