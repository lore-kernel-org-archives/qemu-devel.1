Received: from eggs.gnu.org ([2001:4830:134:3::10]:60728)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cZbVm-0005AP-AF
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 05:54:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cZbVj-0006Jt-7n
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 05:54:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51592)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cZbVi-0006Iy-VD
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 05:54:35 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0B278A89D
	for <qemu-devel@nongnu.org>; Fri,  3 Feb 2017 10:54:35 +0000 (UTC)
Date: Fri, 3 Feb 2017 10:54:30 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170203105430.GB3208@work-vm>
References: <1485207141-1941-1-git-send-email-quintela@redhat.com>
	<1485207141-1941-13-git-send-email-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1485207141-1941-13-git-send-email-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 12/17] migration: really use multiple pages
 at a time
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, amit.shah@redhat.com

* Juan Quintela (quintela@redhat.com) wrote:
> We now send several pages at a time each time that we wakeup a thread.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  migration/ram.c | 44 ++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 38 insertions(+), 6 deletions(-)
> 
> diff --git a/migration/ram.c b/migration/ram.c
> index 9d7bc64..1267730 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -391,6 +391,13 @@ void migrate_compress_threads_create(void)
> 
>  /* Multiple fd's */
> 
> +
> +typedef struct {
> +    int num;
> +    int size;
> +    uint8_t **address;
> +} multifd_pages_t;

The naming is odd for QEMU; should be MultiFDPages ?
You might want to make num & size unsigned.

I was trying to understand why you store 'size' - is that because you worry about
someone changing the size parameter while we're running?  But given that we call
init in a few places I'm not sure it covers it.


>  struct MultiFDSendParams {
>      /* not changed */
>      QemuThread thread;
> @@ -400,7 +407,7 @@ struct MultiFDSendParams {
>      /* protected by param mutex */
>      bool quit;
>      bool started;
> -    uint8_t *address;
> +    multifd_pages_t pages;
>      /* protected by multifd mutex */
>      bool done;
>  };
> @@ -424,8 +431,8 @@ static void *multifd_send_thread(void *opaque)
> 
>      qemu_mutex_lock(&params->mutex);
>      while (!params->quit){
> -        if (params->address) {
> -            params->address = 0;
> +        if (params->pages.num) {
> +            params->pages.num = 0;
>              qemu_mutex_unlock(&params->mutex);
>              qemu_mutex_lock(&multifd_send_mutex);
>              params->done = true;
> @@ -473,6 +480,13 @@ void migrate_multifd_send_threads_join(void)
>      multifd_send = NULL;
>  }
> 
> +static void multifd_init_group(multifd_pages_t *pages)
> +{
> +    pages->num = 0;
> +    pages->size = migrate_multifd_group();
> +    pages->address = g_malloc0(pages->size * sizeof(uint8_t *));

g_new0(uint8_t *, pages->size)

> +}
> +
>  void migrate_multifd_send_threads_create(void)
>  {
>      int i, thread_count;
> @@ -491,7 +505,7 @@ void migrate_multifd_send_threads_create(void)
>          multifd_send[i].quit = false;
>          multifd_send[i].started = false;
>          multifd_send[i].done = true;
> -        multifd_send[i].address = 0;
> +        multifd_init_group(&multifd_send[i].pages);
>          multifd_send[i].c = socket_send_channel_create();
>          if(!multifd_send[i].c) {
>              error_report("Error creating a send channel");
> @@ -511,8 +525,22 @@ void migrate_multifd_send_threads_create(void)
> 
>  static int multifd_send_page(uint8_t *address)

Can you comment multifd_send_page to explain what it returns.

(Do we really need u16 for fd number? More than 256 streams would seem
surprising).

>  {
> -    int i, thread_count;
> +    int i, j, thread_count;
>      bool found = false;
> +    static multifd_pages_t pages;
> +    static bool once = false;
> +
> +    if (!once) {
> +        multifd_init_group(&pages);
> +        once = true;
> +    }
> +
> +    pages.address[pages.num] = address;
> +    pages.num++;
> +
> +    if (pages.num < (pages.size - 1)) {
> +        return UINT16_MAX;
> +    }
> 
>      thread_count = migrate_multifd_threads();
>      qemu_mutex_lock(&multifd_send_mutex);
> @@ -530,7 +558,11 @@ static int multifd_send_page(uint8_t *address)
>      }
>      qemu_mutex_unlock(&multifd_send_mutex);
>      qemu_mutex_lock(&multifd_send[i].mutex);
> -    multifd_send[i].address = address;
> +    multifd_send[i].pages.num = pages.num;
> +    for(j = 0; j < pages.size; j++) {
> +        multifd_send[i].pages.address[j] = pages.address[j];
> +    }
> +    pages.num = 0;
>      qemu_cond_signal(&multifd_send[i].cond);
>      qemu_mutex_unlock(&multifd_send[i].mutex);
> 
> -- 
> 2.9.3

Dave

> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
