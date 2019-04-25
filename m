Received: from eggs.gnu.org ([209.51.188.92]:59889)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb413@gmail.com>) id 1hJk1s-0005YY-IN
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 15:27:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb413@gmail.com>) id 1hJjvh-0001jD-24
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 15:21:11 -0400
Received: from mail-qk1-x743.google.com ([2607:f8b0:4864:20::743]:44096)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <danielhb413@gmail.com>)
	id 1hJjvf-0001K7-2Q
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 15:21:07 -0400
Received: by mail-qk1-x743.google.com with SMTP id y5so432262qkc.11
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 12:21:04 -0700 (PDT)
References: <20190424004700.12766-1-richardw.yang@linux.intel.com>
	<20190424004700.12766-2-richardw.yang@linux.intel.com>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
Message-ID: <e9cd3438-345f-2a68-daec-1ce4cba37ef1@gmail.com>
Date: Thu, 25 Apr 2019 16:20:57 -0300
MIME-Version: 1.0
In-Reply-To: <20190424004700.12766-2-richardw.yang@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 1/4] migration/savevm: remove duplicate
 check of migration_is_blocked
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Yang <richardw.yang@linux.intel.com>, qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, quintela@redhat.com



On 4/23/19 9:46 PM, Wei Yang wrote:
> Current call flow of save_snapshot is:
>
>    save_snapshot
>      migration_is_blocked
>        qemu_savevm_state
>          migration_is_blocked
>
> Since qemu_savevm_state is only called in save_snapshot, this means
> migration_is_blocked has been already checked.

I think it would be a nice touch to add a comment in qemu_savevm_state,
saying that the function must be called with migration_is_blocked()
context. Just in case someone else in the future ends up re-using the
function.


Other than that, +1 for less code duplication.


Reviewed-by: Daniel Henrique Barboza <danielhb413@gmail.com>




>
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> ---
>   migration/savevm.c | 4 ----
>   1 file changed, 4 deletions(-)
>
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 92af2471cd..2eea604624 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -1412,10 +1412,6 @@ static int qemu_savevm_state(QEMUFile *f, Error **errp)
>           return -EINVAL;
>       }
>   
> -    if (migration_is_blocked(errp)) {
> -        return -EINVAL;
> -    }
> -
>       if (migrate_use_block()) {
>           error_setg(errp, "Block migration and snapshots are incompatible");
>           return -EINVAL;
