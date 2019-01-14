Received: from eggs.gnu.org ([209.51.188.92]:36141)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gj0DW-0006ih-HW
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 06:15:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gj0DV-0004ry-Du
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 06:15:42 -0500
References: <20181213162727.17438-1-lvivier@redhat.com>
	<20181213162727.17438-2-lvivier@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <7aef3078-085d-b020-e89d-ae30082381b4@redhat.com>
Date: Mon, 14 Jan 2019 12:15:30 +0100
MIME-Version: 1.0
In-Reply-To: <20181213162727.17438-2-lvivier@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/4] block/ssh: Convert from DPRINTF()
 macro to trace events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, qemu-block@nongnu.org, Liu Yuan <namei.unix@gmail.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Kevin Wolf <kwolf@redhat.com>, "Richard W.M. Jones" <rjones@redhat.com>

On 13.12.18 17:27, Laurent Vivier wrote:
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> Reviewed-by: Richard W.M. Jones <rjones@redhat.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>=20
> Notes:
>     v2: use %zu with size_t
>         change an uint64_t to int64_t to match % PRIi64
>=20
>  block/ssh.c        | 46 +++++++++++++++++-----------------------------
>  block/trace-events | 17 +++++++++++++++++
>  2 files changed, 34 insertions(+), 29 deletions(-)
>=20
> diff --git a/block/ssh.c b/block/ssh.c
> index 7fbc27abdf..bbc513e095 100644
> --- a/block/ssh.c
> +++ b/block/ssh.c

[...]

> @@ -1038,9 +1026,9 @@ static coroutine_fn int ssh_read(BDRVSSHState *s,=
 BlockDriverState *bs,
>       */
>      for (got =3D 0; got < size; ) {
>      again:
> -        DPRINTF("sftp_read buf=3D%p size=3D%zu", buf, end_of_vec - buf=
);
> +        trace_ssh_read_buf(buf, end_of_vec - buf);
>          r =3D libssh2_sftp_read(s->sftp_handle, buf, end_of_vec - buf)=
;
> -        DPRINTF("sftp_read returned %zd", r);
> +        trace_ssh_read_return(r);

(Here...

> =20
>          if (r =3D=3D LIBSSH2_ERROR_EAGAIN || r =3D=3D LIBSSH2_ERROR_TI=
MEOUT) {
>              co_yield(s, bs);

[...]

> @@ -1108,9 +1096,9 @@ static int ssh_write(BDRVSSHState *s, BlockDriver=
State *bs,
> =20
>      for (written =3D 0; written < size; ) {
>      again:
> -        DPRINTF("sftp_write buf=3D%p size=3D%zu", buf, end_of_vec - bu=
f);
> +        trace_ssh_write_buf(buf, end_of_vec - buf);
>          r =3D libssh2_sftp_write(s->sftp_handle, buf, end_of_vec - buf=
);
> -        DPRINTF("sftp_write returned %zd", r);
> +        trace_ssh_write_return(r);

...and here r is of type ssize_t)

> =20
>          if (r =3D=3D LIBSSH2_ERROR_EAGAIN || r =3D=3D LIBSSH2_ERROR_TI=
MEOUT) {
>              co_yield(s, bs);

[...]

> diff --git a/block/trace-events b/block/trace-events
> index 3e8c47bb24..e1dfd9713a 100644
> --- a/block/trace-events
> +++ b/block/trace-events
> @@ -156,3 +156,20 @@ nvme_cmd_map_qiov_iov(void *s, int i, void *page, =
int pages) "s %p iov[%d] %p pa
> =20
>  # block/iscsi.c
>  iscsi_xcopy(void *src_lun, uint64_t src_off, void *dst_lun, uint64_t d=
st_off, uint64_t bytes, int ret) "src_lun %p offset %"PRIu64" dst_lun %p =
offset %"PRIu64" bytes %"PRIu64" ret %d"
> +
> +# block/ssh.c
> +ssh_restart_coroutine(void *co) "co=3D%p"
> +ssh_flush(void) "fsync"
> +ssh_check_host_key_knownhosts(const char *key) "host key OK: %s"
> +ssh_connect_to_ssh(char *path, int flags, int mode) "opening file %s f=
lags=3D0x%x creat_mode=3D0%o"
> +ssh_co_yield(int sock, void *rd_handler, void *wr_handler) "s->sock=3D=
%d rd_handler=3D%p wr_handler=3D%p"
> +ssh_co_yield_back(int sock) "s->sock=3D%d - back"
> +ssh_getlength(int64_t length) "length=3D%" PRIi64
> +ssh_co_create_opts(uint64_t size) "total_size=3D%" PRIu64
> +ssh_read(int64_t offset, size_t size) "offset=3D%" PRIi64 " size=3D%zu=
"
> +ssh_read_buf(void *buf, size_t size) "sftp_read buf=3D%p size=3D%zu"
> +ssh_read_return(size_t ret) "sftp_read returned %zu"

Shouldn't this be ssize_t and %zi/%zd?

> +ssh_write(int64_t offset, size_t size) "offset=3D%" PRIi64 " size=3D%z=
u"
> +ssh_write_buf(void *buf, size_t size) "sftp_write buf=3D%p size=3D%zu"
> +ssh_write_return(size_t ret) "sftp_write returned %zu"

Same here.

Max

> +ssh_seek(int64_t offset) "seeking to offset=3D%" PRIi6
