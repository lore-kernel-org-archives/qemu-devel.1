Received: from eggs.gnu.org ([2001:4830:134:3::10]:60973)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cjtNb-0003jd-4l
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 15:00:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cjtNW-0006eW-Bk
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 15:00:43 -0500
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:36138)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cjtNW-0006eC-6Y
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 15:00:38 -0500
Received: by mail-qk0-x243.google.com with SMTP id n141so6084120qke.3
	for <qemu-devel@nongnu.org>; Fri, 03 Mar 2017 12:00:38 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <148856422757.9841.6298006998523421948.stgit@bahia.lan>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <ea59f435-d6e1-c608-6820-9d3822f53572@amsat.org>
Date: Fri, 3 Mar 2017 17:00:33 -0300
MIME-Version: 1.0
In-Reply-To: <148856422757.9841.6298006998523421948.stgit@bahia.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] 9pfs: fail local_statfs() earlier
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org

On 03/03/2017 03:03 PM, Greg Kurz wrote:
> If we cannot open the given path, we can return right away instead of
> passing -1 to fstatfs() and close(). This will make Coverity happy.
>
> (Coverity issue CID1371729)
>
> Signed-off-by: Greg Kurz <groug@kaod.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/9pfs/9p-local.c |    3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
> index fe930300445a..ea9a1ced0394 100644
> --- a/hw/9pfs/9p-local.c
> +++ b/hw/9pfs/9p-local.c
> @@ -1053,6 +1053,9 @@ static int local_statfs(FsContext *s, V9fsPath *fs_path, struct statfs *stbuf)
>      int fd, ret;
>
>      fd = local_open_nofollow(s, fs_path->data, O_RDONLY, 0);
> +    if (fd == -1) {
> +        return -1;
> +    }
>      ret = fstatfs(fd, stbuf);
>      close_preserve_errno(fd);
>      return ret;
>
>
