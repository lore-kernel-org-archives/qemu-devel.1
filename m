Received: from eggs.gnu.org ([2001:4830:134:3::10]:47201)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gOka3-00027R-3a
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 09:31:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gOkZy-0007mv-Vr
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 09:31:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56424)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gOkZy-0007mT-P1
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 09:31:10 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 09BD8308339D
	for <qemu-devel@nongnu.org>; Mon, 19 Nov 2018 14:31:10 +0000 (UTC)
References: <20181119134228.11031-1-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <aa7c80f5-395e-bd61-fb95-afe87e2ce04d@redhat.com>
Date: Mon, 19 Nov 2018 08:31:08 -0600
MIME-Version: 1.0
In-Reply-To: <20181119134228.11031-1-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] io: return 0 for EOF in TLS session read
 after shutdown
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>, qemu-devel@nongnu.org

On 11/19/18 7:42 AM, Daniel P. Berrang=C3=A9 wrote:
> GNUTLS takes a paranoid approach when seeing 0 bytes returned by the
> underlying OS read() function. It will consider this an error and
> return GNUTLS_E_PREMATURE_TERMINATION instead of propagating the 0
> return value. It expects apps to arrange for clean termination at
> the protocol level and not rely on seeing EOF from a read call to
> detect shutdown. This is to harden apps against a malicious 3rd party
> causing termination of the sockets layer.
>=20
> This is unhelpful for the QEMU NBD code which does have a clean
> protocol level shutdown, but still relies on seeing 0 from the I/O
> channel read in the coroutine handling incoming replies.
>=20
> The upshot is that when using a plain NBD connection shutdown is
> silent, but when using TLS, the client spams the console with
>=20
>    Cannot read from TLS channel: Broken pipe
>=20
> The NBD connection has, however, called qio_channel_shutdown()
> at this point to indicate that it is done with I/O. This gives
> the opportunity to optimize the code such that when the channel
> has been shutdown in the read direction, the error code
> GNUTLS_E_PREMATURE_TERMINATION gets turned into a '0' return
> instead of an error.

Detecting premature termination when the client has NOT requested=20
orderly shutdown is still important, and this patch preserves that=20
aspect.  You are only changing the case where the client has informed=20
the qio code "yes, an early termination is now okay".

>=20
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---

> +++ b/include/io/channel.h
> @@ -51,9 +51,9 @@ enum QIOChannelFeature {
>   typedef enum QIOChannelShutdown QIOChannelShutdown;
>  =20
>   enum QIOChannelShutdown {
> -    QIO_CHANNEL_SHUTDOWN_BOTH,
> -    QIO_CHANNEL_SHUTDOWN_READ,
> -    QIO_CHANNEL_SHUTDOWN_WRITE,
> +    QIO_CHANNEL_SHUTDOWN_READ =3D 1,
> +    QIO_CHANNEL_SHUTDOWN_WRITE =3D 2,
> +    QIO_CHANNEL_SHUTDOWN_BOTH =3D 3,

Nice use of bit operations :)

> +++ b/io/channel-tls.c
> @@ -275,6 +275,9 @@ static ssize_t qio_channel_tls_readv(QIOChannel *io=
c,
>                   } else {
>                       return QIO_CHANNEL_ERR_BLOCK;
>                   }
> +            } else if (errno =3D=3D ECONNABORTED &&
> +                       (tioc->shutdown & QIO_CHANNEL_SHUTDOWN_READ)) {
> +                return 0;
>               }

Reviewed-by: Eric Blake <eblake@redhat.com>

I like this patch better than my proposed hack to ignore read errors=20
after requesting quit; testing it now.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
