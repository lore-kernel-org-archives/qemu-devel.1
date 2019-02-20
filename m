Received: from eggs.gnu.org ([209.51.188.92]:52084)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gwTvv-00021q-IS
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 10:37:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gwTvr-0005vk-1M
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 10:37:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51456)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gwTvo-0004lb-DI
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 10:37:10 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1FF6A7F413
	for <qemu-devel@nongnu.org>; Wed, 20 Feb 2019 14:04:02 +0000 (UTC)
References: <20190220092214.2384-1-quintela@redhat.com>
	<20190220092214.2384-3-quintela@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2bcdaa5b-4ce2-cf40-5774-a3c81690b1e3@redhat.com>
Date: Wed, 20 Feb 2019 08:03:45 -0600
MIME-Version: 1.0
In-Reply-To: <20190220092214.2384-3-quintela@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v13 2/3] migration: Create socket-address
 parameter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Laurent Vivier <lvivier@redhat.com>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Thomas Huth <thuth@redhat.com>

On 2/20/19 3:22 AM, Juan Quintela wrote:
> It will be used to store the uri parameters. We want this only for
> tcp, so we don't set it for other uris.  We need it to know what port
> is migration running.
>=20
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Signed-off-by: Juan Quintela <quintela@redhat.com>
>=20
> --

> +++ b/qapi/migration.json
> @@ -6,6 +6,7 @@
>  ##
> =20
>  { 'include': 'common.json' }
> +{ 'include': 'sockets.json' }
> =20
>  ##
>  # @MigrationStats:
> @@ -199,6 +200,8 @@
>  # @compression: migration compression statistics, only returned if com=
pression
>  #           feature is on and status is 'active' or 'completed' (Since=
 3.1)
>  #
> +# @socket-address: Only used for tcp, to know what the real port is (S=
ince 4.0)
> +#
>  # Since: 0.14.0
>  ##
>  { 'struct': 'MigrationInfo',
> @@ -213,7 +216,8 @@
>             '*error-desc': 'str',
>             '*postcopy-blocktime' : 'uint32',
>             '*postcopy-vcpu-blocktime': ['uint32'],
> -           '*compression': 'CompressionStats'} }
> +           '*compression': 'CompressionStats',
> +           '*socket-address': ['SocketAddress'] } }
> =20

Okay, I actually tried compiling your patch with the following hunk:

>  ##
>  # @query-migrate:
> diff --git a/qapi/sockets.json b/qapi/sockets.json
> index fc81d8d5e8..d7f77984af 100644
> --- a/qapi/sockets.json
> +++ b/qapi/sockets.json
> @@ -152,3 +152,16 @@
>              'unix': 'UnixSocketAddress',
>              'vsock': 'VsockSocketAddress',
>              'fd': 'String' } }
> +
> +##
> +# @DummyStruct:
> +#
> +# Both block-core and migration needs SocketAddressList
> +# I am open to comments about how to share it
> +#
> +# @dummy-list: A dummy list
> +#
> +# Since: 3.1

4.0

> +##
> +{ 'struct': 'DummyStruct',
> +  'data': { 'dummy-list': ['SocketAddress'] } }
>=20

removed, and got:

In file included from qapi/qapi-types-migration.c:15:
qapi/qapi-types-migration.h:267:5: error: unknown type name
=E2=80=98SocketAddressList=E2=80=99
     SocketAddressList *socket_address;
     ^~~~~~~~~~~~~~~~~
make: *** [/home/eblake/qemu/rules.mak:69: qapi/qapi-types-migration.o]
Error 1

That says we have a bug in our QAPI generator - the type
SocketAddressList should be auto-generated at the point where it is
needed in migration.json. Markus, any ideas why we are not properly
auto-generating an array type when the only use of that array comes from
a different module than where the original type was declared?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org
