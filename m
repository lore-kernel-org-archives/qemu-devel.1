Received: from eggs.gnu.org ([2001:4830:134:3::10]:56640)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dcUSB-0002oq-UG
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 06:31:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dcUS7-0008KW-W9
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 06:31:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39884)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dcUS7-0008Jv-ME
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 06:31:03 -0400
Date: Tue, 1 Aug 2017 11:30:56 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170801103055.GG2079@work-vm>
References: <1501229198-30588-1-git-send-email-peterx@redhat.com>
	<1501229198-30588-15-git-send-email-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1501229198-30588-15-git-send-email-peterx@redhat.com>
Subject: Re: [Qemu-devel] [RFC 14/29] migration: allow send_rq to fail
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Alexey Perevalov <a.perevalov@samsung.com>, Juan Quintela <quintela@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>

* Peter Xu (peterx@redhat.com) wrote:
> We will not allow failures to happen when sending data from destination
> to source via the return path. However it is possible that there can be
> errors along the way.  This patch allows the migrate_send_rp_message()
> to return error when it happens, and further extended it to
> migrate_send_rp_req_pages().
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/migration.c | 38 ++++++++++++++++++++++++++++++--------
>  migration/migration.h |  2 +-
>  2 files changed, 31 insertions(+), 9 deletions(-)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index d0b9a86..9a0b5b0 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -195,17 +195,35 @@ static void deferred_incoming_migration(Error **errp)
>   * Send a message on the return channel back to the source
>   * of the migration.
>   */
> -static void migrate_send_rp_message(MigrationIncomingState *mis,
> -                                    enum mig_rp_message_type message_type,
> -                                    uint16_t len, void *data)
> +static int migrate_send_rp_message(MigrationIncomingState *mis,
> +                                   enum mig_rp_message_type message_type,
> +                                   uint16_t len, void *data)
>  {
> +    int ret = 0;
> +
>      trace_migrate_send_rp_message((int)message_type, len);
>      qemu_mutex_lock(&mis->rp_mutex);
> +
> +    /*
> +     * It's possible that the file handle got lost due to network
> +     * failures.
> +     */
> +    if (!mis->to_src_file) {
> +        ret = -EIO;
> +        goto error;
> +    }
> +

Right, and this answers one of my questions from the previous patches.



Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

>      qemu_put_be16(mis->to_src_file, (unsigned int)message_type);
>      qemu_put_be16(mis->to_src_file, len);
>      qemu_put_buffer(mis->to_src_file, data, len);
>      qemu_fflush(mis->to_src_file);
> +
> +    /* It's possible that qemu file got error during sending */
> +    ret = qemu_file_get_error(mis->to_src_file);
> +
> +error:
>      qemu_mutex_unlock(&mis->rp_mutex);
> +    return ret;
>  }
>  
>  /* Request a range of pages from the source VM at the given
> @@ -215,26 +233,30 @@ static void migrate_send_rp_message(MigrationIncomingState *mis,
>   *   Start: Address offset within the RB
>   *   Len: Length in bytes required - must be a multiple of pagesize
>   */
> -void migrate_send_rp_req_pages(MigrationIncomingState *mis, const char *rbname,
> -                               ram_addr_t start, size_t len)
> +int migrate_send_rp_req_pages(MigrationIncomingState *mis, const char *rbname,
> +                              ram_addr_t start, size_t len)
>  {
>      uint8_t bufc[12 + 1 + 255]; /* start (8), len (4), rbname up to 256 */
>      size_t msglen = 12; /* start + len */
> +    int rbname_len;
> +    enum mig_rp_message_type msg_type;
>  
>      *(uint64_t *)bufc = cpu_to_be64((uint64_t)start);
>      *(uint32_t *)(bufc + 8) = cpu_to_be32((uint32_t)len);
>  
>      if (rbname) {
> -        int rbname_len = strlen(rbname);
> +        rbname_len = strlen(rbname);
>          assert(rbname_len < 256);
>  
>          bufc[msglen++] = rbname_len;
>          memcpy(bufc + msglen, rbname, rbname_len);
>          msglen += rbname_len;
> -        migrate_send_rp_message(mis, MIG_RP_MSG_REQ_PAGES_ID, msglen, bufc);
> +        msg_type = MIG_RP_MSG_REQ_PAGES_ID;
>      } else {
> -        migrate_send_rp_message(mis, MIG_RP_MSG_REQ_PAGES, msglen, bufc);
> +        msg_type = MIG_RP_MSG_REQ_PAGES;
>      }
> +
> +    return migrate_send_rp_message(mis, msg_type, msglen, bufc);
>  }
>  
>  void qemu_start_incoming_migration(const char *uri, Error **errp)
> diff --git a/migration/migration.h b/migration/migration.h
> index 7aaab13..047872b 100644
> --- a/migration/migration.h
> +++ b/migration/migration.h
> @@ -201,7 +201,7 @@ void migrate_send_rp_shut(MigrationIncomingState *mis,
>                            uint32_t value);
>  void migrate_send_rp_pong(MigrationIncomingState *mis,
>                            uint32_t value);
> -void migrate_send_rp_req_pages(MigrationIncomingState *mis, const char* rbname,
> +int migrate_send_rp_req_pages(MigrationIncomingState *mis, const char* rbname,
>                                ram_addr_t start, size_t len);
>  
>  #endif
> -- 
> 2.7.4
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
