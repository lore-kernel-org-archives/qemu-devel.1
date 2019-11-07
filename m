Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BC4BC5DF60
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 12:13:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4A372166E
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 12:13:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="equvkdjR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4A372166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41448 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSgex-0004N6-0u
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 07:13:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55247)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iSgdZ-0003NX-2i
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 07:11:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iSgdX-0007Hl-8c
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 07:11:40 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44298
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iSgdX-0007Gu-3p
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 07:11:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573128693;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O37KNe058FRW/xYbyj9Ui7LgdAoReAFGIHly4bLVUqs=;
 b=equvkdjRdhU1IDlwykIQw57VRes6kXcdRgUo7Y1/ocoFC65ZmtCRsiF/UbcGGZNN82+HJd
 OUDH9ir9KpcurnMm7xeu2v+j2jdUHYM7b1y6j/EDQ0I6k76wgZXwt+VY3/sqozfOXCBPAa
 enNAQVgPPMmpyaJLWN3sY1NFcT9SglU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-236-JJGui4duOgWM60d1eWyXcg-1; Thu, 07 Nov 2019 07:11:29 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E4B071800D7A;
 Thu,  7 Nov 2019 12:11:28 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.14])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0FEDC19C6A;
 Thu,  7 Nov 2019 12:11:27 +0000 (UTC)
Date: Thu, 7 Nov 2019 12:11:25 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Wei Yang <richardw.yang@linux.intel.com>
Subject: Re: [PATCH 2/2] migration/compress: disable compress if failed to
 setup
Message-ID: <20191107121125.GI2816@work-vm>
References: <20191012023932.1863-1-richardw.yang@linux.intel.com>
 <20191012023932.1863-3-richardw.yang@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <20191012023932.1863-3-richardw.yang@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: JJGui4duOgWM60d1eWyXcg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
> In current logic, if compress_threads_save_setup() returns -1 the whole
> migration would fail, while we could handle it gracefully by disable
> compress.

I think it's fine for migration to fail here; the user askd for
compression - if it doesn't work then it's OK to fail and they can
switch it off; since it fails right at the start there's nothing lost.

Dave

> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> ---
>  migration/migration.c |  9 +++++++++
>  migration/migration.h |  1 +
>  migration/ram.c       | 15 ++++++++-------
>  3 files changed, 18 insertions(+), 7 deletions(-)
>=20
> diff --git a/migration/migration.c b/migration/migration.c
> index 5f7e4d15e9..02b95f4223 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -2093,6 +2093,15 @@ bool migrate_use_compression(void)
>      return s->enabled_capabilities[MIGRATION_CAPABILITY_COMPRESS];
>  }
> =20
> +void migrate_disable_compression(void)
> +{
> +    MigrationState *s;
> +
> +    s =3D migrate_get_current();
> +
> +    s->enabled_capabilities[MIGRATION_CAPABILITY_COMPRESS] =3D false;
> +}
> +
>  int migrate_compress_level(void)
>  {
>      MigrationState *s;
> diff --git a/migration/migration.h b/migration/migration.h
> index 4f2fe193dc..51368d3a6e 100644
> --- a/migration/migration.h
> +++ b/migration/migration.h
> @@ -309,6 +309,7 @@ bool migrate_use_return_path(void);
>  uint64_t ram_get_total_transferred_pages(void);
> =20
>  bool migrate_use_compression(void);
> +void migrate_disable_compression(void);
>  int migrate_compress_level(void);
>  int migrate_compress_threads(void);
>  int migrate_compress_wait_thread(void);
> diff --git a/migration/ram.c b/migration/ram.c
> index 96c9b16402..39279161a8 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -533,12 +533,12 @@ static void compress_threads_save_cleanup(void)
>      comp_param =3D NULL;
>  }
> =20
> -static int compress_threads_save_setup(void)
> +static void compress_threads_save_setup(void)
>  {
>      int i, thread_count;
> =20
>      if (!migrate_use_compression()) {
> -        return 0;
> +        return;
>      }
>      thread_count =3D migrate_compress_threads();
>      compress_threads =3D g_new0(QemuThread, thread_count);
> @@ -569,11 +569,14 @@ static int compress_threads_save_setup(void)
>                             do_data_compress, comp_param + i,
>                             QEMU_THREAD_JOINABLE);
>      }
> -    return 0;
> +    return;
> =20
>  exit:
>      compress_threads_save_cleanup();
> -    return -1;
> +    migrate_disable_compression();
> +    error_report("%s: failed to setup compress threads, compress disable=
d",
> +                 __func__);
> +    return;
>  }
> =20
>  /* Multiple fd's */
> @@ -3338,9 +3341,7 @@ static int ram_save_setup(QEMUFile *f, void *opaque=
)
>      RAMState **rsp =3D opaque;
>      RAMBlock *block;
> =20
> -    if (compress_threads_save_setup()) {
> -        return -1;
> -    }
> +    compress_threads_save_setup();
> =20
>      /* migration has already setup the bitmap, reuse it. */
>      if (!migration_in_colo_state()) {
> --=20
> 2.17.1
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


