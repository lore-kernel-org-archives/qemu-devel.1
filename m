Received: from eggs.gnu.org ([2001:4830:134:3::10]:51768)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fLu0N-0003mk-Ut
	for qemu-devel@nongnu.org; Thu, 24 May 2018 13:26:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fLu0K-0000E9-1k
	for qemu-devel@nongnu.org; Thu, 24 May 2018 13:26:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56486 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fLu0J-0000Dx-Uj
	for qemu-devel@nongnu.org; Thu, 24 May 2018 13:26:19 -0400
References: <1527178151-181781-1-git-send-email-mst@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <bf33951f-d205-ec9c-4ceb-7703deea97f7@redhat.com>
Date: Thu, 24 May 2018 19:26:16 +0200
MIME-Version: 1.0
In-Reply-To: <1527178151-181781-1-git-send-email-mst@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 2/1] libqtest: add more exit status
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

On 24.05.2018 18:11, Michael S. Tsirkin wrote:
> Add more checks on how did QEMU exit.
>=20
> Legal ways to exit right now:
> - exit(0) or return from main
> - kill(SIGTERM) - sent by testing infrastructure
>=20
> Anything else is illegal.
[...]
> -        if (pid =3D=3D s->qemu_pid && WIFSIGNALED(wstatus)) {
> +        /* waitpid returns child PID on success */
> +        assert(pid =3D=3D s->qemu_pid);
> +
> +        /* If exited on signal - check the reason: core dump is never =
OK */
> +        if (WIFSIGNALED(wstatus)) {
>              assert(!WCOREDUMP(wstatus));
>          }
> +        /* If exited normally - check exit status */
> +        if (WIFEXITED(wstatus)) {
> +            assert(!WEXITSTATUS(wstatus));
> +        }
> +        /* Valid ways to exit: right now only return from main or exit=
 */
> +        assert(WIFEXITED(wstatus));
>      }
>  }

It's strange that you always get WIFEXITED(wstatus) =3D=3D true here, eve=
n
if QEMU has been terminated by SIGTERM? I assume that's due to the fact
that QEMU intercepts SIGTERM and terminates via exit() instead? So I
think you could simply replace the last three asserts with:

	assert(WIFEXITED(wstatus) && !WEXITSTATUS(wstatus));

 Thomas
