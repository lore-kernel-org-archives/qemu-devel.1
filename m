Received: from eggs.gnu.org ([2001:4830:134:3::10]:38560)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gP9PZ-0000IO-OL
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 12:02:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gP9PV-00083s-Mu
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 12:02:05 -0500
References: <20181120152753.10463-1-marcandre.lureau@redhat.com>
	<20181120152753.10463-3-marcandre.lureau@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <03454b5c-f889-9401-f502-5b14eaab40c8@redhat.com>
Date: Tue, 20 Nov 2018 11:01:24 -0600
MIME-Version: 1.0
In-Reply-To: <20181120152753.10463-3-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-3.1? 2/3] migration: fix
 stringop-truncation warning
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Juan Quintela <quintela@redhat.com>, Jeff Cody <jcody@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Liu Yuan <namei.unix@gmail.com>

On 11/20/18 9:27 AM, Marc-Andr=C3=A9 Lureau wrote:
> Adding an assert is enough to silence GCC.
>=20
> ~/src/qemu/migration/global_state.c: In function 'global_state_store_ru=
nning':
> ~/src/qemu/migration/global_state.c:45:5: error: 'strncpy' specified bo=
und 100 equals destination size [-Werror=3Dstringop-truncation]
>       strncpy((char *)global_state.runstate,
>       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>              state, sizeof(global_state.runstate));
>              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
>=20
> (alternatively, we could hard-code "running")
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>   migration/global_state.c | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Eric Blake <eblake@redhat.com>

I think this is safe for 3.1, but I know the migration code is=20
particularly wary of assert()s, even when they are non-triggerable (a=20
100-byte buffer at global_state.runstate is big enough for ALL of the=20
run states, not just RUN_STATE_RUNNING).

>=20
> diff --git a/migration/global_state.c b/migration/global_state.c
> index 8e8ab5c51e..01805c567a 100644
> --- a/migration/global_state.c
> +++ b/migration/global_state.c
> @@ -42,6 +42,7 @@ int global_state_store(void)
>   void global_state_store_running(void)
>   {
>       const char *state =3D RunState_str(RUN_STATE_RUNNING);
> +    assert(strlen(state) < sizeof(global_state.runstate));
>       strncpy((char *)global_state.runstate,
>              state, sizeof(global_state.runstate));
>   }
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
