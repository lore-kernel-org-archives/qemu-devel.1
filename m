Received: from eggs.gnu.org ([209.51.188.92]:54380)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ghFk8-0004IW-JU
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 10:26:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ghFk7-0008JB-Pm
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 10:26:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54679)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ghFk7-0008Iq-Jd
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 10:26:07 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20181225140449.15786-1-fli@suse.com>
	<20181225140449.15786-14-fli@suse.com>
Date: Wed, 09 Jan 2019 16:26:05 +0100
In-Reply-To: <20181225140449.15786-14-fli@suse.com> (Fei Li's message of "Tue,
	25 Dec 2018 22:04:46 +0800")
Message-ID: <87k1jddf8y.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH for-4.0 v9 13/16] qemu_thread: supplement
 error handling for migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fei Li <fli@suse.com>
Cc: qemu-devel@nongnu.org, shirley17fei@gmail.com, lifei1214@126.com, Peter Xu <peterx@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

Fei Li <fli@suse.com> writes:

> Update qemu_thread_create()'s callers by
> - setting an error on qemu_thread_create() failure for callers that
>   set an error on failure;
> - reporting the error and returning failure for callers that return
>   an error code on failure;
> - reporting the error and setting some state for callers that just
>   report errors and choose not to continue on.
>
> Cc: Markus Armbruster <armbru@redhat.com>
> Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Cc: Peter Xu <peterx@redhat.com>
> Signed-off-by: Fei Li <fli@suse.com>
[...]
> diff --git a/migration/ram.c b/migration/ram.c
> index eed1daf302..1e24a78eaa 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
[...]
> @@ -3625,6 +3637,7 @@ static void compress_threads_load_cleanup(void)
>  static int compress_threads_load_setup(QEMUFile *f)
>  {
>      int i, thread_count;
> +    Error *local_err = NULL;
>  
>      if (!migrate_use_compression()) {
>          return 0;
> @@ -3646,10 +3659,13 @@ static int compress_threads_load_setup(QEMUFile *f)
>          qemu_cond_init(&decomp_param[i].cond);
>          decomp_param[i].done = true;
>          decomp_param[i].quit = false;
> -        /* TODO: let the further caller handle the error instead of abort() */
> -        qemu_thread_create(decompress_threads + i, "decompress",
> -                           do_data_decompress, decomp_param + i,
> -                           QEMU_THREAD_JOINABLE, &error_abort);
> +        if (!qemu_thread_create(decompress_threads + i, "decompress",
> +                                do_data_decompress, decomp_param + i,
> +                                QEMU_THREAD_JOINABLE, &local_err)) {
> +            error_reportf_err(local_err,
> +                              "failed to create do_data_decompress: ");
> +            goto exit;

Broken error handling, see my review of PATCH 16.

> +        }
>      }
>      return 0;
>  exit:
[...]
