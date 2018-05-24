Received: from eggs.gnu.org ([2001:4830:134:3::10]:54898)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fLsZi-0008MS-3O
	for qemu-devel@nongnu.org; Thu, 24 May 2018 11:54:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fLsZf-00005D-1W
	for qemu-devel@nongnu.org; Thu, 24 May 2018 11:54:46 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34972 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fLsZe-000050-SV
	for qemu-devel@nongnu.org; Thu, 24 May 2018 11:54:42 -0400
References: <1527176250-178968-1-git-send-email-mst@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <872e6cdb-9cff-cb4d-e667-a664f2daa633@redhat.com>
Date: Thu, 24 May 2018 17:54:37 +0200
MIME-Version: 1.0
In-Reply-To: <1527176250-178968-1-git-send-email-mst@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 2/1] libqtest: add more exit status
 checks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Markus Armbruster <armbru@redhat.com>

On 24.05.2018 17:38, Michael S. Tsirkin wrote:
> Add more checks on how did QEMU exit.
>=20
> Legal ways to exit right now:
> - exit(0) or return from main
> - kill(SIGTERM) - sent by testing infrastructure
>=20
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>=20
> Changes from v1:
> - drop SIGTERM as suggested by Eric
>=20
>  tests/libqtest.c | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/tests/libqtest.c b/tests/libqtest.c
> index f869854..0576874 100644
> --- a/tests/libqtest.c
> +++ b/tests/libqtest.c
> @@ -110,7 +110,12 @@ static void kill_qemu(QTestState *s)
>          pid =3D waitpid(s->qemu_pid, &wstatus, 0);
> =20
>          if (pid =3D=3D s->qemu_pid && WIFSIGNALED(wstatus)) {

Since we're only waiting for one pid ... wouldn't it be better to do

 assert(pid =3D=3D s->qemu_pid)

instead?

> +            /* Core dump is never OK */
>              assert(!WCOREDUMP(wstatus));
> +            /* Must exit normally */
> +            assert(WIFEXITED(wstatus));

So you asserted that WIFEXITED(wstatus) !=3D 0 here ...

> +            /* If exited normally - check exit status */
> +            assert(!WIFEXITED(wstatus) || !WEXITSTATUS(wstatus));

So "!WIFEXITED(wstatus)" is always 0 here? That's confusing...?

 Thomas
