Received: from eggs.gnu.org ([2001:4830:134:3::10]:59433)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fNlsZ-0004YC-1x
	for qemu-devel@nongnu.org; Tue, 29 May 2018 17:10:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fNlsU-0002mS-Ut
	for qemu-devel@nongnu.org; Tue, 29 May 2018 17:10:03 -0400
Received: from 7.mo177.mail-out.ovh.net ([46.105.61.149]:52790)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fNlsU-0002kp-OA
	for qemu-devel@nongnu.org; Tue, 29 May 2018 17:09:58 -0400
Received: from player158.ha.ovh.net (unknown [10.109.108.117])
	by mo177.mail-out.ovh.net (Postfix) with ESMTP id 7773DB3253
	for <qemu-devel@nongnu.org>; Tue, 29 May 2018 23:09:55 +0200 (CEST)
Date: Tue, 29 May 2018 23:09:51 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180529230951.27a41574@bahia.lan>
In-Reply-To: <17b8b06c00e359d1cb71b883371ad8c677a0e477.1527310210.git.keno@alumni.harvard.edu>
References: <cover.1527310210.git.keno@alumni.harvard.edu>
	<17b8b06c00e359d1cb71b883371ad8c677a0e477.1527310210.git.keno@alumni.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 06/13] 9p: darwin: Address minor differences
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: keno@juliacomputing.com
Cc: qemu-devel@nongnu.org, Keno Fischer <keno@alumni.harvard.edu>

On Sat, 26 May 2018 01:23:08 -0400
keno@juliacomputing.com wrote:

> From: Keno Fischer <keno@alumni.harvard.edu>
> 
> - Darwin doesn't have strchrnul
> - Comparisons of mode_t with -1 require an explicit cast, since mode_t
>   is unsigned on Darwin.
> 
> Signed-off-by: Keno Fischer <keno@juliacomputing.com>
> ---
>  hw/9pfs/9p-local.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
> index fd65d04..6e0b2e8 100644
> --- a/hw/9pfs/9p-local.c
> +++ b/hw/9pfs/9p-local.c
> @@ -67,7 +67,10 @@ int local_open_nofollow(FsContext *fs_ctx, const char *path, int flags,
>          assert(*path != '/');
>  
>          head = g_strdup(path);
> -        c = strchrnul(path, '/');
> +        /* equivalent to strchrnul(), but that is not available on Darwin */

Please make a qemu_strchrnul() helper with a separate implementation for Darwin
then. I guess you can put it in this file since there aren't any other users in
the QEMU code base.

> +        c = strchr(path, '/');
> +        if (!c)
> +            c = path + strlen(path);
>          if (*c) {
>              /* Intermediate path element */
>              head[c - path] = 0;
> @@ -310,7 +313,7 @@ update_map_file:
>      if (credp->fc_gid != -1) {
>          gid = credp->fc_gid;
>      }
> -    if (credp->fc_mode != -1) {
> +    if (credp->fc_mode != (mode_t)-1) {
>          mode = credp->fc_mode;
>      }
>      if (credp->fc_rdev != -1) {
> @@ -416,7 +419,7 @@ static int local_set_xattrat(int dirfd, const char *path, FsCred *credp)
>              return err;
>          }
>      }
> -    if (credp->fc_mode != -1) {
> +    if (credp->fc_mode != (mode_t)-1) {
>          uint32_t tmp_mode = cpu_to_le32(credp->fc_mode);
>          err = fsetxattrat_nofollow(dirfd, path, "user.virtfs.mode", &tmp_mode,
>                                     sizeof(mode_t), 0);
