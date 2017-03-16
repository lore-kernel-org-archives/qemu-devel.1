Received: from eggs.gnu.org ([2001:4830:134:3::10]:57758)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1coXhH-0003qd-KY
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 11:52:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1coXhD-0003pK-NM
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 11:52:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45552)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1coXhD-0003pA-Ez
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 11:52:11 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5069F9D4F4
	for <qemu-devel@nongnu.org>; Thu, 16 Mar 2017 15:52:11 +0000 (UTC)
Date: Thu, 16 Mar 2017 15:52:07 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170316155206.GK2567@work-vm>
References: <20170315135021.6978-1-quintela@redhat.com>
	<20170315135021.6978-12-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170315135021.6978-12-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 11/31] ram: Remove unused pages_skiped
 variable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org

* Juan Quintela (quintela@redhat.com) wrote:
> For compatibility, we need to still send a value, but just specify it
> and comment the fact.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>

Note missing p in subject,

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  include/migration/migration.h |  2 --
>  migration/migration.c         |  3 ++-
>  migration/ram.c               | 11 -----------
>  3 files changed, 2 insertions(+), 14 deletions(-)
> 
> diff --git a/include/migration/migration.h b/include/migration/migration.h
> index 3e6bb68..9c83951 100644
> --- a/include/migration/migration.h
> +++ b/include/migration/migration.h
> @@ -277,8 +277,6 @@ void free_xbzrle_decoded_buf(void);
>  void acct_update_position(QEMUFile *f, size_t size, bool zero);
>  
>  uint64_t dup_mig_pages_transferred(void);
> -uint64_t skipped_mig_bytes_transferred(void);
> -uint64_t skipped_mig_pages_transferred(void);
>  uint64_t norm_mig_bytes_transferred(void);
>  uint64_t norm_mig_pages_transferred(void);
>  uint64_t xbzrle_mig_bytes_transferred(void);
> diff --git a/migration/migration.c b/migration/migration.c
> index 3dab684..c3e1b95 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -639,7 +639,8 @@ static void populate_ram_info(MigrationInfo *info, MigrationState *s)
>      info->ram->transferred = ram_bytes_transferred();
>      info->ram->total = ram_bytes_total();
>      info->ram->duplicate = dup_mig_pages_transferred();
> -    info->ram->skipped = skipped_mig_pages_transferred();
> +    /* legacy value.  It is not used anymore */
> +    info->ram->skipped = 0;
>      info->ram->normal = norm_mig_pages_transferred();
>      info->ram->normal_bytes = norm_mig_bytes_transferred();
>      info->ram->mbps = s->mbps;
> diff --git a/migration/ram.c b/migration/ram.c
> index 83fe20a..468f042 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -169,7 +169,6 @@ static RAMState ram_state;
>  
>  /* accounting for migration statistics */
>  typedef struct AccountingInfo {
> -    uint64_t skipped_pages;
>      uint64_t norm_pages;
>      uint64_t iterations;
>      uint64_t xbzrle_bytes;
> @@ -191,16 +190,6 @@ uint64_t dup_mig_pages_transferred(void)
>      return ram_state.zero_pages;
>  }
>  
> -uint64_t skipped_mig_bytes_transferred(void)
> -{
> -    return acct_info.skipped_pages * TARGET_PAGE_SIZE;
> -}
> -
> -uint64_t skipped_mig_pages_transferred(void)
> -{
> -    return acct_info.skipped_pages;
> -}
> -
>  uint64_t norm_mig_bytes_transferred(void)
>  {
>      return acct_info.norm_pages * TARGET_PAGE_SIZE;
> -- 
> 2.9.3
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
