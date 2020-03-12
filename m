Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A921C10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 19:59:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA830205F4
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 19:59:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a1l9uy5d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA830205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCTzV-0000ZF-LB
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 15:59:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47843)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1jCTs1-00084U-I3
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 15:51:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1jCTs0-0006z1-D3
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 15:51:53 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:20751
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1jCTs0-0006yW-8z
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 15:51:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584042711;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GX3T7EUWPGa4fw59sAaXOlQEjwxDMJ6VP8MnQ+chE7g=;
 b=a1l9uy5dR6IVTxUikAnokILGDQkz/uI17op48DspKRxjJ/fkzIgp+UY7nvIvDHR+gI2B11
 ODDbwxygVzx3JzGNwMtsh0ejXZh52IJHWIAfe8a+dT3Yvk7OBZ3OPqPvllmqjX7PcNpwEH
 BfLd7TUOmJAEWNHufqMkzw6rWBTO8mA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-28-t28EuzAmPNGiC0PHJ2ETsw-1; Thu, 12 Mar 2020 15:51:44 -0400
X-MC-Unique: t28EuzAmPNGiC0PHJ2ETsw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8EB03800D53;
 Thu, 12 Mar 2020 19:51:43 +0000 (UTC)
Received: from work-vm (ovpn-116-106.ams2.redhat.com [10.36.116.106])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 83BA892D2A;
 Thu, 12 Mar 2020 19:51:42 +0000 (UTC)
Date: Thu, 12 Mar 2020 19:51:40 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: zhanghailiang <zhang.zhanghailiang@huawei.com>
Subject: Re: [PATCH V2 8/8] migration/colo: Only flush ram cache while do
 checkpoint
Message-ID: <20200312195140.GQ3211@work-vm>
References: <20200224065414.36524-1-zhang.zhanghailiang@huawei.com>
 <20200224065414.36524-9-zhang.zhanghailiang@huawei.com>
MIME-Version: 1.0
In-Reply-To: <20200224065414.36524-9-zhang.zhanghailiang@huawei.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: danielcho@qnap.com, qemu-devel@nongnu.org, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* zhanghailiang (zhang.zhanghailiang@huawei.com) wrote:
> After add migrating ram backgroud, we will call ram_load
> for this process, but we should not flush ram cache during
> this process. Move the flush action to the right place.
>=20
> Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  migration/colo.c | 1 +
>  migration/ram.c  | 5 +----
>  migration/ram.h  | 1 +
>  3 files changed, 3 insertions(+), 4 deletions(-)
>=20
> diff --git a/migration/colo.c b/migration/colo.c
> index c36d94072f..18df8289f8 100644
> --- a/migration/colo.c
> +++ b/migration/colo.c
> @@ -799,6 +799,7 @@ static void colo_incoming_process_checkpoint(Migratio=
nIncomingState *mis,
> =20
>      qemu_mutex_lock_iothread();
>      vmstate_loading =3D true;
> +    colo_flush_ram_cache();
>      ret =3D qemu_load_device_state(fb);
>      if (ret < 0) {
>          error_setg(errp, "COLO: load device state failed");
> diff --git a/migration/ram.c b/migration/ram.c
> index 1b3f423351..7bc841d14f 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -3305,7 +3305,7 @@ static bool postcopy_is_running(void)
>   * Flush content of RAM cache into SVM's memory.
>   * Only flush the pages that be dirtied by PVM or SVM or both.
>   */
> -static void colo_flush_ram_cache(void)
> +void colo_flush_ram_cache(void)
>  {
>      RAMBlock *block =3D NULL;
>      void *dst_host;
> @@ -3576,9 +3576,6 @@ static int ram_load(QEMUFile *f, void *opaque, int =
version_id)
>      }
>      trace_ram_load_complete(ret, seq_iter);
> =20
> -    if (!ret  && migration_incoming_in_colo_state()) {
> -        colo_flush_ram_cache();
> -    }
>      return ret;
>  }
> =20
> diff --git a/migration/ram.h b/migration/ram.h
> index 5ceaff7cb4..ae14341482 100644
> --- a/migration/ram.h
> +++ b/migration/ram.h
> @@ -67,5 +67,6 @@ int ram_dirty_bitmap_reload(MigrationState *s, RAMBlock=
 *rb);
>  int colo_init_ram_cache(void);
>  void colo_release_ram_cache(void);
>  void colo_incoming_start_dirty_log(void);
> +void colo_flush_ram_cache(void);
> =20
>  #endif
> --=20
> 2.21.0
>=20
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


