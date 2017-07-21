Received: from eggs.gnu.org ([2001:4830:134:3::10]:40586)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dYVrj-0003vi-LC
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 07:13:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dYVrg-0006ML-Dk
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 07:13:03 -0400
References: <1500395194-21455-1-git-send-email-peter.maydell@linaro.org>
	<1500395194-21455-4-git-send-email-peter.maydell@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <5de01cad-5a63-ff42-8c6f-25210aa8348d@redhat.com>
Date: Fri, 21 Jul 2017 13:12:56 +0200
MIME-Version: 1.0
In-Reply-To: <1500395194-21455-4-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.10 3/4] bsd-user/bsdload.c: Remove
 write-only id_change variable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Cc: patches@linaro.org, Juan Quintela <quintela@redhat.com>

On 18.07.2017 18:26, Peter Maydell wrote:
> On OpenBSD the compiler complains:
> bsd-user/bsdload.c:54:17: warning: variable 'id_change' set but not used [-Wunused-but-set-variable]
> 
> This is dead code that was originally copied from linux-user.
> We fixed this in linux-user in commit 331c23b5ca44293d1 in 2011;
> delete the useless code from bsd-user too.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  bsd-user/bsdload.c | 25 +------------------------
>  1 file changed, 1 insertion(+), 24 deletions(-)
> 
> diff --git a/bsd-user/bsdload.c b/bsd-user/bsdload.c
> index 94eec36..f38c4fa 100644
> --- a/bsd-user/bsdload.c
> +++ b/bsd-user/bsdload.c
> @@ -20,22 +20,6 @@ abi_long memcpy_to_target(abi_ulong dest, const void *src,
>      return 0;
>  }
>  
> -static int in_group_p(gid_t g)
> -{
> -    /* return TRUE if we're in the specified group, FALSE otherwise */
> -    int         ngroup;
> -    int         i;
> -    gid_t       grouplist[TARGET_NGROUPS];
> -
> -    ngroup = getgroups(TARGET_NGROUPS, grouplist);
> -    for(i = 0; i < ngroup; i++) {
> -        if(grouplist[i] == g) {
> -            return 1;
> -        }
> -    }
> -    return 0;
> -}
> -
>  static int count(char ** vec)
>  {
>      int         i;
> @@ -51,7 +35,7 @@ static int prepare_binprm(struct linux_binprm *bprm)
>  {
>      struct stat         st;
>      int mode;
> -    int retval, id_change;
> +    int retval;
>  
>      if(fstat(bprm->fd, &st) < 0) {
>          return(-errno);
> @@ -67,14 +51,10 @@ static int prepare_binprm(struct linux_binprm *bprm)
>  
>      bprm->e_uid = geteuid();
>      bprm->e_gid = getegid();
> -    id_change = 0;
>  
>      /* Set-uid? */
>      if(mode & S_ISUID) {
>          bprm->e_uid = st.st_uid;
> -        if(bprm->e_uid != geteuid()) {
> -            id_change = 1;
> -        }
>      }
>  
>      /* Set-gid? */
> @@ -85,9 +65,6 @@ static int prepare_binprm(struct linux_binprm *bprm)
>       */
>      if ((mode & (S_ISGID | S_IXGRP)) == (S_ISGID | S_IXGRP)) {
>          bprm->e_gid = st.st_gid;
> -        if (!in_group_p(bprm->e_gid)) {
> -                id_change = 1;
> -        }
>      }
>  
>      memset(bprm->buf, 0, sizeof(bprm->buf));

Matches the commit from linux-user, and looks sane to me, so:

Reviewed-by: Thomas Huth <thuth@redhat.com>
