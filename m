Received: from eggs.gnu.org ([2001:4830:134:3::10]:33017)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eWnqp-00024P-51
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 13:33:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eWnqo-0006JL-3V
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 13:33:19 -0500
Received: from mail-wm0-x233.google.com ([2a00:1450:400c:c09::233]:39149)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1eWnqn-0006In-Pz
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 13:33:18 -0500
Received: by mail-wm0-x233.google.com with SMTP id i11so4217453wmf.4
	for <qemu-devel@nongnu.org>; Wed, 03 Jan 2018 10:33:17 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171222134527.14467-5-berrange@redhat.com>
References: <20171222134527.14467-1-berrange@redhat.com>
	<20171222134527.14467-5-berrange@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 3 Jan 2018 19:33:15 +0100
Message-ID: <CAJ+F1C+q80fJqZcSZ+=v0A0LenSeFKcpAgLGMw06ZmkQMsXdDg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 4/8] sockets: strengthen test suite IP
 protocol availability checks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Fri, Dec 22, 2017 at 2:45 PM, Daniel P. Berrange <berrange@redhat.com> w=
rote:
> Instead of just checking whether it is possible to bind() on a socket, al=
so
> check that we can successfully connect() to the socket we bound to. This
> more closely replicates the level of functionality that tests will actual=
ly
> use.
>
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  tests/socket-helpers.c | 67 +++++++++++++++++++++++++++++++++++++++++++-=
------
>  tests/socket-helpers.h |  4 +--
>  2 files changed, 60 insertions(+), 11 deletions(-)
>
> diff --git a/tests/socket-helpers.c b/tests/socket-helpers.c
> index 13b6bb38eb..161aa5da09 100644
> --- a/tests/socket-helpers.c
> +++ b/tests/socket-helpers.c
> @@ -30,10 +30,15 @@
>  # define EAI_ADDRFAMILY 0
>  #endif
>
> -int socket_can_bind(const char *hostname)
> +int socket_can_bind_connect(const char *hostname)
>  {
> -    int fd =3D -1;
> +    int lfd =3D -1, cfd =3D -1, afd =3D -1;
>      struct addrinfo ai, *res =3D NULL;
> +    struct sockaddr_storage ss;
> +    socklen_t sslen =3D sizeof(ss);
> +    int soerr;
> +    socklen_t soerrlen =3D sizeof(soerr);
> +    bool check_soerr =3D false;
>      int rc;
>      int ret =3D -1;
>
> @@ -54,24 +59,68 @@ int socket_can_bind(const char *hostname)
>          goto cleanup;
>      }
>
> -    fd =3D qemu_socket(res->ai_family, res->ai_socktype, res->ai_protoco=
l);
> -    if (fd < 0) {
> +    lfd =3D qemu_socket(res->ai_family, res->ai_socktype, res->ai_protoc=
ol);
> +    if (lfd < 0) {
>          goto cleanup;
>      }
>
> -    if (bind(fd, res->ai_addr, res->ai_addrlen) < 0) {
> +    cfd =3D qemu_socket(res->ai_family, res->ai_socktype, res->ai_protoc=
ol);
> +    if (cfd < 0) {
> +        goto cleanup;
> +    }
> +
> +    if (bind(lfd, res->ai_addr, res->ai_addrlen) < 0) {
>          if (errno =3D=3D EADDRNOTAVAIL) {
>              goto done;
>          }
>          goto cleanup;
>      }
>
> +    if (listen(lfd, 1) < 0) {
> +        goto cleanup;
> +    }
> +
> +    if (getsockname(lfd, (struct sockaddr *)&ss, &sslen) < 0) {
> +        goto cleanup;
> +    }
> +
> +    qemu_set_nonblock(cfd);
> +    if (connect(cfd, (struct sockaddr *)&ss, sslen) < 0) {
> +        if (errno =3D=3D EINPROGRESS) {
> +            check_soerr =3D true;
> +        } else {
> +            goto cleanup;
> +        }
> +    }
> +
> +    sslen =3D sizeof(ss);
> +    afd =3D accept(lfd,  (struct sockaddr *)&ss, &sslen);
> +    if (afd < 0) {
> +        goto cleanup;
> +    }
> +
> +    if (check_soerr) {
> +        if (qemu_getsockopt(cfd, SOL_SOCKET, SO_ERROR, &soerr, &soerrlen=
) < 0) {
> +            goto cleanup;
> +        }
> +        if (soerr) {
> +            errno =3D soerr;
> +            goto cleanup;
> +        }
> +    }
> +
>   done:
>      ret =3D 0;
>
>   cleanup:
> -    if (fd !=3D -1) {
> -        close(fd);
> +    if (afd !=3D -1) {
> +        close(afd);
> +    }
> +    if (cfd !=3D -1) {
> +        close(cfd);
> +    }
> +    if (lfd !=3D -1) {
> +        close(lfd);
>      }
>      if (res) {
>          freeaddrinfo(res);
> @@ -84,7 +133,7 @@ int socket_check_protocol_support(bool *has_ipv4, bool=
 *has_ipv6)
>  {
>      *has_ipv4 =3D *has_ipv6 =3D false;
>
> -    if (socket_can_bind("127.0.0.1") < 0) {
> +    if (socket_can_bind_connect("127.0.0.1") < 0) {
>          if (errno !=3D EADDRNOTAVAIL) {
>              return -1;
>          }
> @@ -92,7 +141,7 @@ int socket_check_protocol_support(bool *has_ipv4, bool=
 *has_ipv6)
>          *has_ipv4 =3D true;
>      }
>
> -    if (socket_can_bind("::1") < 0) {
> +    if (socket_can_bind_connect("::1") < 0) {
>          if (errno !=3D EADDRNOTAVAIL) {
>              return -1;
>          }
> diff --git a/tests/socket-helpers.h b/tests/socket-helpers.h
> index efa96eddc2..1c07d6d656 100644
> --- a/tests/socket-helpers.h
> +++ b/tests/socket-helpers.h
> @@ -21,13 +21,13 @@
>  /*
>   * @hostname: a DNS name or numeric IP address
>   *
> - * Check whether it is possible to bind to ports
> + * Check whether it is possible to bind & connect to ports
>   * on the DNS name or IP address @hostname. If an IP address
>   * is used, it must not be a wildcard address.
>   *
>   * Returns 0 on success, -1 on error with errno set
>   */
> -int socket_can_bind(const char *hostname);
> +int socket_can_bind_connect(const char *hostname);
>
>  /*
>   * @has_ipv4: set to true on return if IPv4 is available
> --
> 2.14.3
>
>



--=20
Marc-Andr=C3=A9 Lureau
