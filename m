Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DEB8C10F14
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 17:44:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B7CB2070B
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 17:44:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B7CB2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59410 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHtXb-0005qI-Fs
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 13:44:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49274)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iHt8Z-0007ue-UJ
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 13:19:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iHt8W-0002pq-9H
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 13:19:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35926)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iHt8V-0002p2-9b
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 13:18:59 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C51613003715;
 Tue,  8 Oct 2019 17:18:57 +0000 (UTC)
Received: from work-vm (ovpn-116-59.ams2.redhat.com [10.36.116.59])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EB6C61001DC0;
 Tue,  8 Oct 2019 17:18:56 +0000 (UTC)
Date: Tue, 8 Oct 2019 18:18:54 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Wei Yang <richardw.yang@linux.intel.com>
Subject: Re: [PATCH 1/2] migration/postcopy: allocate tmp_page in setup stage
Message-ID: <20191008171854.GG3441@work-vm>
References: <20191005135021.21721-1-richardw.yang@linux.intel.com>
 <20191005135021.21721-2-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191005135021.21721-2-richardw.yang@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Tue, 08 Oct 2019 17:18:57 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-devel@nongnu.org, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Wei Yang (richardw.yang@linux.intel.com) wrote:
> During migration, a tmp page is allocated so that we could place a whole
> host page during postcopy.
> 
> Currently the page is allocated during load stage, this is a little bit
> late. And more important, if we failed to allocate it, the error is not
> checked properly. Even it is NULL, we would still use it.

Oops, yes.


Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> 
> This patch moves the allocation to setup stage and if failed error
> message would be printed and caller would notice it.
> 
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> ---
>  migration/postcopy-ram.c | 40 ++++++++++------------------------------
>  migration/postcopy-ram.h |  7 -------
>  migration/ram.c          |  2 +-
>  3 files changed, 11 insertions(+), 38 deletions(-)
> 
> diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
> index 51dc164693..e554f93eec 100644
> --- a/migration/postcopy-ram.c
> +++ b/migration/postcopy-ram.c
> @@ -1132,6 +1132,16 @@ int postcopy_ram_incoming_setup(MigrationIncomingState *mis)
>          return -1;
>      }
>  
> +    mis->postcopy_tmp_page = mmap(NULL, mis->largest_page_size,
> +                                  PROT_READ | PROT_WRITE, MAP_PRIVATE |
> +                                  MAP_ANONYMOUS, -1, 0);
> +    if (mis->postcopy_tmp_page == MAP_FAILED) {
> +        mis->postcopy_tmp_page = NULL;
> +        error_report("%s: Failed to map postcopy_tmp_page %s",
> +                     __func__, strerror(errno));
> +        return -1;
> +    }
> +
>      /*
>       * Ballooning can mark pages as absent while we're postcopying
>       * that would cause false userfaults.
> @@ -1258,30 +1268,6 @@ int postcopy_place_page_zero(MigrationIncomingState *mis, void *host,
>      }
>  }
>  
> -/*
> - * Returns a target page of memory that can be mapped at a later point in time
> - * using postcopy_place_page
> - * The same address is used repeatedly, postcopy_place_page just takes the
> - * backing page away.
> - * Returns: Pointer to allocated page
> - *
> - */
> -void *postcopy_get_tmp_page(MigrationIncomingState *mis)
> -{
> -    if (!mis->postcopy_tmp_page) {
> -        mis->postcopy_tmp_page = mmap(NULL, mis->largest_page_size,
> -                             PROT_READ | PROT_WRITE, MAP_PRIVATE |
> -                             MAP_ANONYMOUS, -1, 0);
> -        if (mis->postcopy_tmp_page == MAP_FAILED) {
> -            mis->postcopy_tmp_page = NULL;
> -            error_report("%s: %s", __func__, strerror(errno));
> -            return NULL;
> -        }
> -    }
> -
> -    return mis->postcopy_tmp_page;
> -}
> -
>  #else
>  /* No target OS support, stubs just fail */
>  void fill_destination_postcopy_migration_info(MigrationInfo *info)
> @@ -1339,12 +1325,6 @@ int postcopy_place_page_zero(MigrationIncomingState *mis, void *host,
>      return -1;
>  }
>  
> -void *postcopy_get_tmp_page(MigrationIncomingState *mis)
> -{
> -    assert(0);
> -    return NULL;
> -}
> -
>  int postcopy_wake_shared(struct PostCopyFD *pcfd,
>                           uint64_t client_addr,
>                           RAMBlock *rb)
> diff --git a/migration/postcopy-ram.h b/migration/postcopy-ram.h
> index e3dde32155..c0ccf64a96 100644
> --- a/migration/postcopy-ram.h
> +++ b/migration/postcopy-ram.h
> @@ -100,13 +100,6 @@ typedef enum {
>      POSTCOPY_INCOMING_END
>  } PostcopyState;
>  
> -/*
> - * Allocate a page of memory that can be mapped at a later point in time
> - * using postcopy_place_page
> - * Returns: Pointer to allocated page
> - */
> -void *postcopy_get_tmp_page(MigrationIncomingState *mis);
> -
>  PostcopyState postcopy_state_get(void);
>  /* Set the state and return the old state */
>  PostcopyState postcopy_state_set(PostcopyState new_state,
> diff --git a/migration/ram.c b/migration/ram.c
> index 4c15162bd6..adbaf0b11a 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -4048,7 +4048,7 @@ static int ram_load_postcopy(QEMUFile *f)
>      bool matches_target_page_size = false;
>      MigrationIncomingState *mis = migration_incoming_get_current();
>      /* Temporary page that is later 'placed' */
> -    void *postcopy_host_page = postcopy_get_tmp_page(mis);
> +    void *postcopy_host_page = mis->postcopy_tmp_page;
>      void *last_host = NULL;
>      bool all_zero = false;
>  
> -- 
> 2.17.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

