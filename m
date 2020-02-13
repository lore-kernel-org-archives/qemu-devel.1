Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30A85C2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 10:18:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0A3320873
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 10:17:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RRTJ2LDE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0A3320873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50098 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2BZH-0005xU-7P
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 05:17:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51700)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1j2BYZ-0005GF-PW
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 05:17:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1j2BYY-0003Sf-C5
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 05:17:15 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57328
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1j2BYY-0003S1-7a
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 05:17:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581589033;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FRwOgPhw9SAZ38jv6eYd4quFzTZFpaeBXukrl+64AmY=;
 b=RRTJ2LDE5FSsNnDBLnU00y4w2HynJYHDtWs0cOtTW9+H+kOayMBpfNuqymjhlbf2SwvRTY
 bFc562rxHU7lNTYiNvDT5vphvFuyHGRIv5TCOqbAxnojbX+H8bMCszVTThDXLUwPmhjhKs
 SgZ4kiS5BAcn+k7gLM/4EglWqK51jGw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-391-m2WbdkdqMwmlDzrMDvRDAA-1; Thu, 13 Feb 2020 05:17:09 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5AD8D8017CC;
 Thu, 13 Feb 2020 10:17:08 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.58])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 735E260BF4;
 Thu, 13 Feb 2020 10:17:07 +0000 (UTC)
Date: Thu, 13 Feb 2020 10:17:04 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Wei Yang <richardw.yang@linux.intel.com>
Subject: Re: [PATCH] migration/postcopy: not necessary to discard all RAM at
 the beginning
Message-ID: <20200213101704.GD2960@work-vm>
References: <20191007091008.9435-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <20191007091008.9435-1-richardw.yang@linux.intel.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: m2WbdkdqMwmlDzrMDvRDAA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
> ram_discard_range() unmap page for specific range. To be specific, this
> clears related page table entries so that userfault would be triggered.
> But this step is not necessary at the very beginning.
>=20
> ram_postcopy_incoming_init() is called when destination gets ADVISE
> command. ADVISE command is sent when migration thread just starts, which
> implies destination is not running yet. This means no page fault
> happened and memory region's page tables entries are empty.
>=20
> This patch removes the discard at the beginning.
>=20
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> ---
>  migration/postcopy-ram.c | 46 ----------------------------------------
>  migration/postcopy-ram.h |  7 ------
>  migration/ram.c          | 16 --------------
>  migration/ram.h          |  1 -
>  migration/savevm.c       |  4 ----
>  5 files changed, 74 deletions(-)
>=20
> diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
> index 5da6de8c8b..459be8e780 100644
> --- a/migration/postcopy-ram.c
> +++ b/migration/postcopy-ram.c
> @@ -443,32 +443,6 @@ out:
>      return ret;
>  }
> =20
> -/*
> - * Setup an area of RAM so that it *can* be used for postcopy later; thi=
s
> - * must be done right at the start prior to pre-copy.
> - * opaque should be the MIS.
> - */
> -static int init_range(RAMBlock *rb, void *opaque)
> -{
> -    const char *block_name =3D qemu_ram_get_idstr(rb);
> -    void *host_addr =3D qemu_ram_get_host_addr(rb);
> -    ram_addr_t offset =3D qemu_ram_get_offset(rb);
> -    ram_addr_t length =3D qemu_ram_get_used_length(rb);
> -    trace_postcopy_init_range(block_name, host_addr, offset, length);
> -
> -    /*
> -     * We need the whole of RAM to be truly empty for postcopy, so thing=
s
> -     * like ROMs and any data tables built during init must be zero'd
> -     * - we're going to get the copy from the source anyway.
> -     * (Precopy will just overwrite this data, so doesn't need the disca=
rd)
> -     */

But this comment explains why we want to do the discard; we want to make
sure that any memory that's been populated by the destination during the
init process is discarded and replaced by content from the source.

Dave

> -    if (ram_discard_range(block_name, 0, length)) {
> -        return -1;
> -    }
> -
> -    return 0;
> -}
> -
>  /*
>   * At the end of migration, undo the effects of init_range
>   * opaque should be the MIS.
> @@ -506,20 +480,6 @@ static int cleanup_range(RAMBlock *rb, void *opaque)
>      return 0;
>  }
> =20
> -/*
> - * Initialise postcopy-ram, setting the RAM to a state where we can go i=
nto
> - * postcopy later; must be called prior to any precopy.
> - * called from arch_init's similarly named ram_postcopy_incoming_init
> - */
> -int postcopy_ram_incoming_init(MigrationIncomingState *mis)
> -{
> -    if (foreach_not_ignored_block(init_range, NULL)) {
> -        return -1;
> -    }
> -
> -    return 0;
> -}
> -
>  /*
>   * Manage a single vote to the QEMU balloon inhibitor for all postcopy u=
sage,
>   * last caller wins.
> @@ -1282,12 +1242,6 @@ bool postcopy_ram_supported_by_host(MigrationIncom=
ingState *mis)
>      return false;
>  }
> =20
> -int postcopy_ram_incoming_init(MigrationIncomingState *mis)
> -{
> -    error_report("postcopy_ram_incoming_init: No OS support");
> -    return -1;
> -}
> -
>  int postcopy_ram_incoming_cleanup(MigrationIncomingState *mis)
>  {
>      assert(0);
> diff --git a/migration/postcopy-ram.h b/migration/postcopy-ram.h
> index c0ccf64a96..1c79c6e51f 100644
> --- a/migration/postcopy-ram.h
> +++ b/migration/postcopy-ram.h
> @@ -22,13 +22,6 @@ bool postcopy_ram_supported_by_host(MigrationIncomingS=
tate *mis);
>   */
>  int postcopy_ram_incoming_setup(MigrationIncomingState *mis);
> =20
> -/*
> - * Initialise postcopy-ram, setting the RAM to a state where we can go i=
nto
> - * postcopy later; must be called prior to any precopy.
> - * called from ram.c's similarly named ram_postcopy_incoming_init
> - */
> -int postcopy_ram_incoming_init(MigrationIncomingState *mis);
> -
>  /*
>   * At the end of a migration where postcopy_ram_incoming_init was called=
.
>   */
> diff --git a/migration/ram.c b/migration/ram.c
> index dfc50d57d5..9a853703d8 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -4015,22 +4015,6 @@ static int ram_load_cleanup(void *opaque)
>      return 0;
>  }
> =20
> -/**
> - * ram_postcopy_incoming_init: allocate postcopy data structures
> - *
> - * Returns 0 for success and negative if there was one error
> - *
> - * @mis: current migration incoming state
> - *
> - * Allocate data structures etc needed by incoming migration with
> - * postcopy-ram. postcopy-ram's similarly names
> - * postcopy_ram_incoming_init does the work.
> - */
> -int ram_postcopy_incoming_init(MigrationIncomingState *mis)
> -{
> -    return postcopy_ram_incoming_init(mis);
> -}
> -
>  /**
>   * ram_load_postcopy: load a page in postcopy case
>   *
> diff --git a/migration/ram.h b/migration/ram.h
> index 44fe4753ad..66cbff1d52 100644
> --- a/migration/ram.h
> +++ b/migration/ram.h
> @@ -58,7 +58,6 @@ void ram_postcopy_migrated_memory_release(MigrationStat=
e *ms);
>  int ram_postcopy_send_discard_bitmap(MigrationState *ms);
>  /* For incoming postcopy discard */
>  int ram_discard_range(const char *block_name, uint64_t start, size_t len=
gth);
> -int ram_postcopy_incoming_init(MigrationIncomingState *mis);
>  bool postcopy_is_running(void);
> =20
>  void ram_handle_compressed(void *host, uint8_t ch, uint64_t size);
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 9dc191e0a0..d2a427a3bf 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -1674,10 +1674,6 @@ static int loadvm_postcopy_handle_advise(Migration=
IncomingState *mis,
>          return -1;
>      }
> =20
> -    if (ram_postcopy_incoming_init(mis)) {
> -        return -1;
> -    }
> -
>      return 0;
>  }
> =20
> --=20
> 2.17.1
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


