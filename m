Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3164DC433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 13:06:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0023C2065F
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 13:06:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ew/Fk17T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0023C2065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jw3aK-0004WO-4R
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 09:06:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46890)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jw3ZI-0003V1-Q0
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 09:04:56 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:59188
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jw3ZG-0007Xy-22
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 09:04:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594904691;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=az+FmhN9pIiPX+LZPos7raST+pyWDt55nirXChkVUsk=;
 b=ew/Fk17TtWzt+TUFAiQysVQ9KMVuF5BjmFXPQxbs8fOcvuIpWeM/VJBaO16AVpcqQvAvYA
 T74cLZzaRoGVzueZaYsOaiGk+TvvT2pUoXY5qOVjI3av5tqSWpAGPY4NSFVsEH5ObWut7f
 p9ynoW0ohYV7CMwPbta0S6F4srFPiPs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-319-wJh8r9ASND-BW_uZ_7uN3Q-1; Thu, 16 Jul 2020 09:04:49 -0400
X-MC-Unique: wJh8r9ASND-BW_uZ_7uN3Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9AB15107ACCA;
 Thu, 16 Jul 2020 13:04:47 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.42])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 99B3D6FEF4;
 Thu, 16 Jul 2020 13:04:43 +0000 (UTC)
Date: Thu, 16 Jul 2020 14:04:40 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: Re: [RFC PATCH-for-5.2 v2 2/2] block/block-backend: Let
 blk_attach_dev() provide helpful error
Message-ID: <20200716130440.GT227735@redhat.com>
References: <20200716123704.6557-1-f4bug@amsat.org>
 <20200716123704.6557-3-f4bug@amsat.org>
MIME-Version: 1.0
In-Reply-To: <20200716123704.6557-3-f4bug@amsat.org>
User-Agent: Mutt/1.14.5 (2020-06-23)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/16 04:55:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Paul Durrant <paul@xen.org>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jul 16, 2020 at 02:37:04PM +0200, Philippe Mathieu-Daudé wrote:
> Let blk_attach_dev() take an Error* object to return helpful
> information. Adapt the callers.
> 
>   $ qemu-system-arm -M n800
>   qemu-system-arm: sd_init failed: cannot attach blk 'sd0' to device 'sd-card'
>   blk 'sd0' is already attached by device 'omap2-mmc'
>   Drive 'sd0' is already in use because it has been automatically connected to another device
>   (do you need 'if=none' in the drive options?)
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
> v2: Rebased after 668f62ec62 ("error: Eliminate error_propagate()")
> ---
>  include/sysemu/block-backend.h   |  2 +-
>  block/block-backend.c            | 11 ++++++++++-
>  hw/block/fdc.c                   |  4 +---
>  hw/block/swim.c                  |  4 +---
>  hw/block/xen-block.c             |  5 +++--
>  hw/core/qdev-properties-system.c | 16 +++++++++-------
>  hw/ide/qdev.c                    |  4 +---
>  hw/scsi/scsi-disk.c              |  4 +---
>  8 files changed, 27 insertions(+), 23 deletions(-)
> 
> diff --git a/include/sysemu/block-backend.h b/include/sysemu/block-backend.h
> index 8203d7f6f9..118fbad0b4 100644
> --- a/include/sysemu/block-backend.h
> +++ b/include/sysemu/block-backend.h
> @@ -113,7 +113,7 @@ BlockDeviceIoStatus blk_iostatus(const BlockBackend *blk);
>  void blk_iostatus_disable(BlockBackend *blk);
>  void blk_iostatus_reset(BlockBackend *blk);
>  void blk_iostatus_set_err(BlockBackend *blk, int error);
> -int blk_attach_dev(BlockBackend *blk, DeviceState *dev);
> +int blk_attach_dev(BlockBackend *blk, DeviceState *dev, Error **errp);
>  void blk_detach_dev(BlockBackend *blk, DeviceState *dev);
>  DeviceState *blk_get_attached_dev(BlockBackend *blk);
>  char *blk_get_attached_dev_id(BlockBackend *blk);
> diff --git a/block/block-backend.c b/block/block-backend.c
> index 63ff940ef9..b7be0a4619 100644
> --- a/block/block-backend.c
> +++ b/block/block-backend.c
> @@ -884,12 +884,21 @@ void blk_get_perm(BlockBackend *blk, uint64_t *perm, uint64_t *shared_perm)
>  
>  /*
>   * Attach device model @dev to @blk.
> + *
> + * @blk: Block backend
> + * @dev: Device to attach the block backend to
> + * @errp: pointer to NULL initialized error object
> + *
>   * Return 0 on success, -EBUSY when a device model is attached already.
>   */
> -int blk_attach_dev(BlockBackend *blk, DeviceState *dev)
> +int blk_attach_dev(BlockBackend *blk, DeviceState *dev, Error **errp)
>  {
>      trace_blk_attach_dev(blk_name(blk), object_get_typename(OBJECT(dev)));
>      if (blk->dev) {
> +        error_setg(errp, "cannot attach blk '%s' to device '%s'",
> +                   blk_name(blk), object_get_typename(OBJECT(dev)));
> +        error_append_hint(errp, "blk '%s' is already attached by device '%s'\n",
> +                          blk_name(blk), object_get_typename(OBJECT(blk->dev)));

I would have a preference for expanding the main error message and not
using a hint.  Any hint is completely thrown away when using QMP :-(


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


