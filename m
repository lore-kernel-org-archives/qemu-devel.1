Received: from eggs.gnu.org ([2001:4830:134:3::10]:50110)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d8Txz-0002Vk-Le
	for qemu-devel@nongnu.org; Wed, 10 May 2017 11:55:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d8Txy-0003to-R2
	for qemu-devel@nongnu.org; Wed, 10 May 2017 11:55:55 -0400
References: <1494431442-25163-1-git-send-email-thuth@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <51843a32-50ee-391c-0377-a9b7db470ed1@redhat.com>
Date: Wed, 10 May 2017 17:55:43 +0200
MIME-Version: 1.0
In-Reply-To: <1494431442-25163-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] blockdev: Print a warning for legacy drive
 options that belong to -device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org



On 10/05/2017 17:50, Thomas Huth wrote:
> We likely do not want to carry these legacy -drive options along forever.
> Let's emit a deprecation warning for the -drive options that have a
> replacement with the -device option, so that the (hopefully few) remaining
> users are aware of this and can adapt their scripts / behaviour.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  blockdev.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/blockdev.c b/blockdev.c
> index 4d8cded..87a025a 100644
> --- a/blockdev.c
> +++ b/blockdev.c
> @@ -797,6 +797,9 @@ DriveInfo *drive_new(QemuOpts *all_opts, BlockInterfaceType block_default_type)
>      const char *filename;
>      Error *local_err = NULL;
>      int i;
> +    const char *deprecated[] = {
> +        "serial", "trans", "secs", "heads", "cyls"
> +    };
>  
>      /* Change legacy command line options into QMP ones */
>      static const struct {
> @@ -880,6 +883,14 @@ DriveInfo *drive_new(QemuOpts *all_opts, BlockInterfaceType block_default_type)
>                  "update your scripts.\n");
>      }
>  
> +    /* Other deprecated options */
> +    for (i = 0; i < ARRAY_SIZE(deprecated); i++) {
> +        if (qemu_opt_get(legacy_opts, deprecated[i]) != NULL) {
> +            error_report("'%s' is deprecated, please use the corresponding "
> +                         "option of '-device' instead", deprecated[i]);
> +        }
> +    }
> +
>      /* Media type */
>      value = qemu_opt_get(legacy_opts, "media");
>      if (value) {

This one should be deprecated too (separate patch if you prefer).

Paolo
