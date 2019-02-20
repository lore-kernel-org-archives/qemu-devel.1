Received: from eggs.gnu.org ([209.51.188.92]:59169)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gwUum-0006bB-6G
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 11:40:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gwUug-0003hO-Cm
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 11:40:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40144)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gwUug-0003a8-57
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 11:40:02 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 31C4531F3F0
	for <qemu-devel@nongnu.org>; Wed, 20 Feb 2019 16:39:43 +0000 (UTC)
Date: Wed, 20 Feb 2019 16:39:31 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190220163931.GQ21870@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <1550677216-5077-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1550677216-5077-1-git-send-email-pbonzini@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] chardev-socket: do not blindly reset
 handlers when switching GMainContext
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>

On Wed, Feb 20, 2019 at 04:40:16PM +0100, Paolo Bonzini wrote:
> If the socket is connecting or connected, tcp_chr_update_read_handler w=
ill
> be called but it should not set the NetListener's callbacks again.
> Otherwise, tcp_chr_accept is invoked while the socket is in connected
> state and you get an assertion failure.
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  chardev/char-socket.c |  2 +-
>  tests/test-char.c     | 95 +++++++++++++++++++++++++++++++++++++++++++=
++++++++
>  2 files changed, 96 insertions(+), 1 deletion(-)

> diff --git a/tests/test-char.c b/tests/test-char.c
> index 63b4d32..f1dec89 100644
> --- a/tests/test-char.c
> +++ b/tests/test-char.c
> @@ -1346,6 +1437,10 @@ int main(int argc, char **argv)
>      SOCKET_SERVER_TEST(unix, &unixaddr);
>      SOCKET_CLIENT_TEST(unix, &unixaddr);
>  #endif
> +    g_test_add_data_func("/char/socket/server/two-clients/tcp", &tcpad=
dr,
> +		         char_socket_server_two_clients_test);
> +    g_test_add_data_func("/char/socket/server/two-clients/unix", &unix=
addr,
> +		         char_socket_server_two_clients_test);

The use of "unixaddr" needs to be inside a "#ifndef WIN32" conditional.

If that is fixed, then consider it

 Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
=20
Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
