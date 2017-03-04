Received: from eggs.gnu.org ([2001:4830:134:3::10]:40029)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1ckA6s-0003HZ-1j
	for qemu-devel@nongnu.org; Sat, 04 Mar 2017 08:52:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1ckA6o-0006vz-Qp
	for qemu-devel@nongnu.org; Sat, 04 Mar 2017 08:52:34 -0500
Received: from chuckie.co.uk ([82.165.15.123]:56406
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1ckA6o-0006t8-Fd
	for qemu-devel@nongnu.org; Sat, 04 Mar 2017 08:52:30 -0500
References: <148862487677.5452.160308730808722965.stgit@bahia.lan>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <eeea9fa3-9d5e-1a67-67a8-072b7b943965@ilande.co.uk>
Date: Sat, 4 Mar 2017 13:52:07 +0000
MIME-Version: 1.0
In-Reply-To: <148862487677.5452.160308730808722965.stgit@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] 9pfs: don't use AT_EMPTY_PATH in
 local_set_cred_passthrough()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org

On 04/03/17 10:54, Greg Kurz wrote:

> The name argument can never be an empty string, and dirfd always point to
> the containing directory of the file name. AT_EMPTY_PATH is hence useless
> here. Also it breaks build with glibc version 2.13 and older.
> 
> It is actually an oversight of a previous tentative patch to implement this
> function. We can safely drop it.
> 
> Reported-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  hw/9pfs/9p-local.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
> index ea9a1ced0394..45e9a1f9b0ca 100644
> --- a/hw/9pfs/9p-local.c
> +++ b/hw/9pfs/9p-local.c
> @@ -349,7 +349,7 @@ static int local_set_cred_passthrough(FsContext *fs_ctx, int dirfd,
>                                        const char *name, FsCred *credp)
>  {
>      if (fchownat(dirfd, name, credp->fc_uid, credp->fc_gid,
> -                 AT_SYMLINK_NOFOLLOW | AT_EMPTY_PATH) < 0) {
> +                 AT_SYMLINK_NOFOLLOW) < 0) {
>          /*
>           * If we fail to change ownership and if we are
>           * using security model none. Ignore the error
> 
> 

Thanks Greg - this, along with the updated version of the previous patch
fixes the build for me.

Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


ATB,

Mark.
