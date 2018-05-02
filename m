Received: from eggs.gnu.org ([2001:4830:134:3::10]:47922)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fDvcI-0006zR-2s
	for qemu-devel@nongnu.org; Wed, 02 May 2018 13:32:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fDvcD-0005Ca-4V
	for qemu-devel@nongnu.org; Wed, 02 May 2018 13:32:34 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59524 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fDvcC-0005CJ-VL
	for qemu-devel@nongnu.org; Wed, 02 May 2018 13:32:29 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 04057406C78D
	for <qemu-devel@nongnu.org>; Wed,  2 May 2018 17:32:25 +0000 (UTC)
Date: Wed, 2 May 2018 18:32:16 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180502173215.GK2679@work-vm>
References: <20180425112723.1111-1-quintela@redhat.com>
	<20180425112723.1111-10-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180425112723.1111-10-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v12 09/21] migration: Define
 MultifdRecvParams sooner
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, peterx@redhat.com

* Juan Quintela (quintela@redhat.com) wrote:
> Once there, we don't need the struct names anywhere, just the
> typedefs.  And now also document all fields.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  migration/ram.c | 46 +++++++++++++++++++++++++++++++---------------
>  1 file changed, 31 insertions(+), 15 deletions(-)
> 
> diff --git a/migration/ram.c b/migration/ram.c
> index 1aab392d8f..ffefa73099 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -412,17 +412,45 @@ typedef struct {
>      uint8_t id;
>  } __attribute__((packed)) MultiFDInit_t;
>  
> -struct MultiFDSendParams {
> +typedef struct {
> +    /* this fields are not changed once the thread is created */
> +    /* channel number */
>      uint8_t id;
> +    /* channel thread name */
>      char *name;
> +    /* channel thread id */
>      QemuThread thread;
> +    /* communication channel */
>      QIOChannel *c;
> +    /* sem where to wait for more work */
>      QemuSemaphore sem;
> +    /* this mutex protects the following parameters */
>      QemuMutex mutex;
> +    /* is this channel thread running */
>      bool running;
> +    /* should this thread finish */
>      bool quit;
> -};
> -typedef struct MultiFDSendParams MultiFDSendParams;
> +}  MultiFDSendParams;
> +
> +typedef struct {
> +    /* this fields are not changed once the thread is created */
> +    /* channel number */
> +    uint8_t id;
> +    /* channel thread name */
> +    char *name;
> +    /* channel thread id */
> +    QemuThread thread;
> +    /* communication channel */
> +    QIOChannel *c;
> +    /* sem where to wait for more work */
> +    QemuSemaphore sem;
> +    /* this mutex protects the following parameters */
> +    QemuMutex mutex;
> +    /* is this channel thread running */
> +    bool running;
> +    /* should this thread finish */
> +    bool quit;
> +} MultiFDRecvParams;
>  
>  static int multifd_send_initial_packet(MultiFDSendParams *p, Error **errp)
>  {
> @@ -619,18 +647,6 @@ int multifd_save_setup(void)
>      return 0;
>  }
>  
> -struct MultiFDRecvParams {
> -    uint8_t id;
> -    char *name;
> -    QemuThread thread;
> -    QIOChannel *c;
> -    QemuSemaphore sem;
> -    QemuMutex mutex;
> -    bool running;
> -    bool quit;
> -};
> -typedef struct MultiFDRecvParams MultiFDRecvParams;
> -
>  struct {
>      MultiFDRecvParams *params;
>      /* number of created threads */
> -- 
> 2.17.0
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
