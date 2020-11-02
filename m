Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDBA1C388F2
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 15:41:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4882F2415A
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 15:41:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gtm/dxXL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4882F2415A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZbxm-0005vO-60
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 10:41:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57660)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kZbwl-0004vf-Ll
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 10:40:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:51096)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kZbwj-0002A8-Mr
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 10:40:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604331636;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AW0qv8UrVtJ7oR0zZURwsHDRzdwAweGt1D+vVZlaTQc=;
 b=Gtm/dxXLq1IMKfwZ9nfOpVbprxtKlT8vrwC9zOr5gBWAEDu19hP5p/R1vDw+02x6WJ17iD
 B0gpSlgc3z4rgNzJi+DvgfgGRLgsF+bRfm6IFQ3UMv3lzrUhR8wIQbe6eXD1wwqsh3gLEM
 WYW35PEJLqcNjIYuatYCEY8JKrc87Ss=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-518-MKEHd_iQMUOM3qNcQMklcw-1; Mon, 02 Nov 2020 10:40:34 -0500
X-MC-Unique: MKEHd_iQMUOM3qNcQMklcw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 811AE879512
 for <qemu-devel@nongnu.org>; Mon,  2 Nov 2020 15:40:33 +0000 (UTC)
Received: from localhost (unknown [10.40.208.69])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8E5695C5DE;
 Mon,  2 Nov 2020 15:40:32 +0000 (UTC)
Date: Mon, 2 Nov 2020 16:40:31 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 06/29] vl: move various initialization routines out of
 qemu_init
Message-ID: <20201102164031.1573f150@redhat.com>
In-Reply-To: <20201027182144.3315885-7-pbonzini@redhat.com>
References: <20201027182144.3315885-1-pbonzini@redhat.com>
 <20201027182144.3315885-7-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=imammedo@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/02 03:02:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 27 Oct 2020 14:21:21 -0400
Paolo Bonzini <pbonzini@redhat.com> wrote:

> Some very simple initialization routines can be nested in existing
> subsystem-level functions, do that to simplify qemu_init.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/core/machine.c      | 3 +++
>  include/hw/qdev-core.h | 8 --------
>  migration/migration.c  | 4 ++++
>  softmmu/qdev-monitor.c | 6 ------
>  softmmu/vl.c           | 5 -----
>  5 files changed, 7 insertions(+), 19 deletions(-)
> 
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index baea4e8613..d84b84463c 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -872,6 +872,9 @@ static void machine_initfn(Object *obj)
>      MachineState *ms = MACHINE(obj);
>      MachineClass *mc = MACHINE_GET_CLASS(obj);
>  
> +    container_get(obj, "/peripheral");
> +    container_get(obj, "/peripheral-anon");
> +
>      ms->dump_guest_core = true;
>      ms->mem_merge = true;
>      ms->enable_graphics = true;
> diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
> index 868973319e..56ce7f2d7f 100644
> --- a/include/hw/qdev-core.h
> +++ b/include/hw/qdev-core.h
> @@ -769,14 +769,6 @@ BusState *sysbus_get_default(void);
>  char *qdev_get_fw_dev_path(DeviceState *dev);
>  char *qdev_get_own_fw_dev_path_from_handler(BusState *bus, DeviceState *dev);
>  
> -/**
> - * @qdev_machine_init
> - *
> - * Initialize platform devices before machine init.  This is a hack until full
> - * support for composition is added.
> - */
> -void qdev_machine_init(void);
> -
>  /**
>   * device_legacy_reset:
>   *
> diff --git a/migration/migration.c b/migration/migration.c
> index deb6005b8d..f48b03cac2 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -169,6 +169,10 @@ void migration_object_init(void)
>          error_report_err(err);
>          exit(1);
>      }
> +
> +    blk_mig_init();
> +    ram_mig_init();
> +    dirty_bitmap_mig_init();
>  }
>  
>  void migration_shutdown(void)
> diff --git a/softmmu/qdev-monitor.c b/softmmu/qdev-monitor.c
> index bcfb90a08f..bcfcbac181 100644
> --- a/softmmu/qdev-monitor.c
> +++ b/softmmu/qdev-monitor.c
> @@ -943,12 +943,6 @@ BlockBackend *blk_by_qdev_id(const char *id, Error **errp)
>      return blk;
>  }
>  
> -void qdev_machine_init(void)
> -{
> -    qdev_get_peripheral_anon();
> -    qdev_get_peripheral();
> -}
> -
>  QemuOptsList qemu_device_opts = {
>      .name = "device",
>      .implied_opt_name = "driver",
> diff --git a/softmmu/vl.c b/softmmu/vl.c
> index 32880616e2..b05340802a 100644
> --- a/softmmu/vl.c
> +++ b/softmmu/vl.c
> @@ -4275,10 +4275,6 @@ void qemu_init(int argc, char **argv, char **envp)
>          exit(1);
>      }
>  
> -    blk_mig_init();
> -    ram_mig_init();
> -    dirty_bitmap_mig_init();
> -
>      qemu_opts_foreach(qemu_find_opts("mon"),
>                        mon_init_func, NULL, &error_fatal);
>  
> @@ -4311,7 +4307,6 @@ void qemu_init(int argc, char **argv, char **envp)
>         reading from the other reads, because timer polling functions query
>         clock values from the log. */
>      replay_checkpoint(CHECKPOINT_INIT);
> -    qdev_machine_init();
>  
>      current_machine->boot_order = boot_order;
>  


