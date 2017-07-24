Received: from eggs.gnu.org ([2001:4830:134:3::10]:35137)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dZddT-0005Ni-Pl
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 09:43:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dZddQ-0007A6-IT
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 09:42:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45706)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dZddQ-00079U-9S
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 09:42:56 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E816D883B9
	for <qemu-devel@nongnu.org>; Mon, 24 Jul 2017 13:42:54 +0000 (UTC)
Date: Mon, 24 Jul 2017 14:42:43 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170724134243.GE2784@stefanha-x1.localdomain>
References: <20170721095553.10717-1-jfreimann@redhat.com>
	<20170721095553.10717-5-jfreimann@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IU5/I01NYhRvwH70"
Content-Disposition: inline
In-Reply-To: <20170721095553.10717-5-jfreimann@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 4/4] tests/pxe-test: add testcase using
 vhost-user-bridge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jens Freimann <jfreimann@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, mst@redhat.com, victork@redhat.com, maxime.coquelin@redhat.com


--IU5/I01NYhRvwH70
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 21, 2017 at 11:55:53AM +0200, Jens Freimann wrote:
> +static const char *init_hugepagefs(const char *path)
> +{
> +    struct statfs fs;
> +    int ret;
> +
> +    if (access(path, R_OK | W_OK | X_OK)) {
> +        g_test_message("access on path (%s): %s\n", path, strerror(errno=
));
> +        return NULL;
> +    }
> +
> +    do {
> +        ret =3D statfs(path, &fs);

This system-call and HUGETLBFS_MAGIC are Linux-specific but I don't see
anything in the makefile or this test code that restricts it to Linux.
Will this break non-Linux hosts?

Perhaps #ifdef __linux__ is needed.

> +    } while (ret !=3D 0 && errno =3D=3D EINTR);
> +
> +    if (ret !=3D 0) {
> +        g_test_message("statfs on path (%s): %s\n", path, strerror(errno=
));
> +        return NULL;
> +    }
> +
> +    if (fs.f_type !=3D HUGETLBFS_MAGIC) {
> +        g_test_message("Warning: path not on HugeTLBFS: %s\n", path);
> +        return NULL;
> +    }
> +
> +    return path;
> +}
> +
> +static int vubr_create_socket(struct sockaddr_in *si_remote, int rport)
> +{
> +    int sock;
> +
> +    if (inet_aton("127.0.0.1", (struct in_addr *) &si_remote->sin_addr.s=
_addr)
> +            =3D=3D 0) {
> +        g_test_message("inet_aton failed\n");
> +        return -1;
> +    }

Or:

  si_remote->sin_addr.s_addr =3D htonl(INADDR_LOOPBACK);

> +    sock =3D socket(AF_INET, SOCK_DGRAM, IPPROTO_UDP);
> +    if (sock =3D=3D -1) {
> +        g_test_message("socket creation failed\n");
> +        return -1;
> +    }
> +    if (connect(sock, (struct sockaddr *) si_remote, sizeof(*si_remote))=
) {
> +        g_test_message("connect failed: %s", strerror(errno));
> +        return -1;
> +    }
> +
> +    return sock;
> +}
> +
> +static void test_pxe_vhost_user(void)
> +{
> +    char template[] =3D "/tmp/vhost-user-bridge-XXXXXX";
> +    char template2[] =3D "/tmp/hugepages-XXXXXX";
> +    gchar * vubr_args[] =3D {NULL, NULL, NULL, NULL};
> +    struct sockaddr_in si_remote =3D {
> +        .sin_family =3D AF_INET,
> +        .sin_port =3D htons(RPORT),
> +    };
> +    const char *hugefs =3D NULL;
> +    const char *tmpfs2 =3D NULL;
> +    const char *tmpfs =3D NULL;
> +    const char *root =3D NULL;
> +    GError *error =3D NULL;
> +    char *vubr_binary;
> +    char *qemu_args;
> +    GPid vubr_pid;
> +    int sock =3D -1;
> +
> +    tmpfs =3D mkdtemp(template);
> +    if (!tmpfs) {
> +        g_test_message("mkdtemp on path(%s): %s\n",
> +                       template, strerror(errno));
> +    }
> +    vubr_binary =3D getenv("QTEST_VUBR_BINARY");
> +    g_assert(vubr_binary);
> +    vubr_args[0] =3D g_strdup_printf("%s", vubr_binary);
> +    vubr_args[1] =3D g_strdup_printf("-u");
> +    vubr_args[2] =3D g_strdup_printf("%s/%s", tmpfs, VUBR_SOCK);
> +    g_spawn_async(NULL, vubr_args, NULL,
> +                  G_SPAWN_SEARCH_PATH_FROM_ENVP |
> +                  G_SPAWN_SEARCH_PATH,
> +                  NULL, NULL, &vubr_pid, &error);

I think a few things are missing for test cleanup (especially on
failure).

=46rom https://developer.gnome.org/glib/stable/glib-Spawning-Processes.html=
#g-spawn-async-with-pipes:

  If child_pid is not NULL and an error does not occur then the returned
  process reference must be closed using g_spawn_close_pid().

G_SPAWN_DO_NOT_REAP_CHILD wasn't specified so glib will automatically
reap the child but the test case will not know when the vubr process has
terminated.

A qtest_add_abrt_handler() is also missing to kill the vubr child if the
test case terminates.

--IU5/I01NYhRvwH70
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZdflTAAoJEJykq7OBq3PIu8YIAI/rQcm/zl+5EPhoLnwqDhun
qu3mRRejprbb1RL9wCTiFEzQZPXwBND2FcG/WcWVREcIlv4R51CnYUxcgNdVrVtW
l8++oGU8Z3nDLgs8UR/FelltXUSJFesbPDkHTplqfKPf1P1P1rezzkJwwq4S/Okz
BGQcNkmmtdYHcsj8HfB8x43C1eoDbKQ2M7lkdQtU6ZWX4k5Q1onLneSY7SgJ77Hw
zuH+O21NXuo9VHw7YF8zN73m3HaXU2z6ZipcARUeqIkC0dYfed/hDgFChXZLOuRx
hjJ80MMDMfXc7osDaAQEJe7agQN5ILCoilSBIPo7bqsmRj8kgVzXlSQa+aUskOg=
=fvlh
-----END PGP SIGNATURE-----

--IU5/I01NYhRvwH70--
