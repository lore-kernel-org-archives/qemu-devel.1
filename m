Received: from eggs.gnu.org ([2001:4830:134:3::10]:42873)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eKNjI-0004xK-HF
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 07:14:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eKNjC-0002J7-BM
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 07:14:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48182)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1eKNjC-0002Dh-2H
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 07:14:06 -0500
Date: Thu, 30 Nov 2017 12:13:57 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20171130121357.GD2248@work-vm>
References: <20171108060130.3772-1-peterx@redhat.com>
	<20171108060130.3772-9-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171108060130.3772-9-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 08/32] migration: allow send_rq to fail
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Alexey Perevalov <a.perevalov@samsung.com>, "Daniel P . Berrange" <berrange@redhat.com>, Juan Quintela <quintela@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>

* Peter Xu (peterx@redhat.com) wrote:
> We will not allow failures to happen when sending data from destination
> to source via the return path. However it is possible that there can be
> errors along the way.  This patch allows the migrate_send_rp_message()
> to return error when it happens, and further extended it to
> migrate_send_rp_req_pages().
> 
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/migration.c | 38 ++++++++++++++++++++++++++++++--------
>  migration/migration.h |  2 +-
>  2 files changed, 31 insertions(+), 9 deletions(-)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index 8d93b891e3..db896233f6 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -199,17 +199,35 @@ static void deferred_incoming_migration(Error **errp)
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
> @@ -219,26 +237,30 @@ static void migrate_send_rp_message(MigrationIncomingState *mis,
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

I don't think that move of the declaration of rbname_len is necessary;
it's only msglen that you need to keep for longer.

Dave

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
> index ebb049f692..b63cdfbfdb 100644
> --- a/migration/migration.h
> +++ b/migration/migration.h
> @@ -216,7 +216,7 @@ void migrate_send_rp_shut(MigrationIncomingState *mis,
>                            uint32_t value);
>  void migrate_send_rp_pong(MigrationIncomingState *mis,
>                            uint32_t value);
> -void migrate_send_rp_req_pages(MigrationIncomingState *mis, const char* rbname,
> +int migrate_send_rp_req_pages(MigrationIncomingState *mis, const char* rbname,
>                                ram_addr_t start, size_t len);
>  
>  #endif
> -- 
> 2.13.6
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
