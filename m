Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B26EC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 10:20:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24C462076B
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 10:20:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g0hpL5ho"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24C462076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60504 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5nrg-00033R-9j
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 06:20:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53906)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1k5nqy-0002ZA-9E
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 06:19:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40781
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1k5nqw-0003Im-K9
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 06:19:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597227565;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uUQyw7A/h4VgzSMFZRB3u174WjAxTiPIL30EVHMn/z4=;
 b=g0hpL5hoJ0ROCCaajKV0kABoZhfX408y1NIyHBps7zG+epab4hGWl4Nx7Av9XYQ0EVp6E+
 A1oLe7PQYvcq3pjmI6+EYFP7ZU/BCp+hwD+L68Li3rgB6zvVMc5wgGVheTJJAbrfKQ1JR0
 7WRgDrhAKqfql3peizDUW6LPfA8Jo1k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-202-O-a6E9AxPUqjLbg2wpW4Kw-1; Wed, 12 Aug 2020 06:19:23 -0400
X-MC-Unique: O-a6E9AxPUqjLbg2wpW4Kw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D6EF618B9EC0;
 Wed, 12 Aug 2020 10:19:22 +0000 (UTC)
Received: from work-vm (ovpn-113-233.ams2.redhat.com [10.36.113.233])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 311BA19D82;
 Wed, 12 Aug 2020 10:19:20 +0000 (UTC)
Date: Wed, 12 Aug 2020 11:19:17 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH v2 1/6] migration: improve error reporting of block
 driver state name
Message-ID: <20200812101917.GC2810@work-vm>
References: <20200727150843.3419256-1-berrange@redhat.com>
 <20200727150843.3419256-2-berrange@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200727150843.3419256-2-berrange@redhat.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/12 04:27:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Krempa <pkrempa@redhat.com>,
 "Denis V. Lunev" <den@virtuozzo.com>, qemu-block@nongnu.org,
 Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 John Snow <jsnow@redhat.com>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Daniel P. Berrangé (berrange@redhat.com) wrote:
> With blockdev, a BlockDriverState may not have a device name,
> so using a node name is required as an alternative.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  migration/savevm.c         | 12 ++++++------
>  tests/qemu-iotests/267.out |  4 ++--
>  2 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 45c9dd9d8a..cffee6cab7 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -2655,7 +2655,7 @@ int save_snapshot(const char *name, Error **errp)
>  
>      if (!bdrv_all_can_snapshot(&bs)) {
>          error_setg(errp, "Device '%s' is writable but does not support "
> -                   "snapshots", bdrv_get_device_name(bs));
> +                   "snapshots", bdrv_get_device_or_node_name(bs));
>          return ret;
>      }
>  
> @@ -2664,7 +2664,7 @@ int save_snapshot(const char *name, Error **errp)
>          ret = bdrv_all_delete_snapshot(name, &bs1, errp);
>          if (ret < 0) {
>              error_prepend(errp, "Error while deleting snapshot on device "
> -                          "'%s': ", bdrv_get_device_name(bs1));
> +                          "'%s': ", bdrv_get_device_or_node_name(bs1));
>              return ret;
>          }
>      }
> @@ -2739,7 +2739,7 @@ int save_snapshot(const char *name, Error **errp)
>      ret = bdrv_all_create_snapshot(sn, bs, vm_state_size, &bs);
>      if (ret < 0) {
>          error_setg(errp, "Error while creating snapshot on '%s'",
> -                   bdrv_get_device_name(bs));
> +                   bdrv_get_device_or_node_name(bs));
>          goto the_end;
>      }
>  
> @@ -2857,14 +2857,14 @@ int load_snapshot(const char *name, Error **errp)
>      if (!bdrv_all_can_snapshot(&bs)) {
>          error_setg(errp,
>                     "Device '%s' is writable but does not support snapshots",
> -                   bdrv_get_device_name(bs));
> +                   bdrv_get_device_or_node_name(bs));
>          return -ENOTSUP;
>      }
>      ret = bdrv_all_find_snapshot(name, &bs);
>      if (ret < 0) {
>          error_setg(errp,
>                     "Device '%s' does not have the requested snapshot '%s'",
> -                   bdrv_get_device_name(bs), name);
> +                   bdrv_get_device_or_node_name(bs), name);
>          return ret;
>      }
>  
> @@ -2893,7 +2893,7 @@ int load_snapshot(const char *name, Error **errp)
>      ret = bdrv_all_goto_snapshot(name, &bs, errp);
>      if (ret < 0) {
>          error_prepend(errp, "Could not load snapshot '%s' on '%s': ",
> -                      name, bdrv_get_device_name(bs));
> +                      name, bdrv_get_device_or_node_name(bs));
>          goto err_drain;
>      }
>  
> diff --git a/tests/qemu-iotests/267.out b/tests/qemu-iotests/267.out
> index d6d80c099f..215902b3ad 100644
> --- a/tests/qemu-iotests/267.out
> +++ b/tests/qemu-iotests/267.out
> @@ -81,11 +81,11 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728
>  Testing: -blockdev driver=file,filename=TEST_DIR/t.IMGFMT,node-name=file
>  QEMU X.Y.Z monitor - type 'help' for more information
>  (qemu) savevm snap0
> -Error: Device '' is writable but does not support snapshots
> +Error: Device 'file' is writable but does not support snapshots
>  (qemu) info snapshots
>  No available block device supports snapshots
>  (qemu) loadvm snap0
> -Error: Device '' is writable but does not support snapshots
> +Error: Device 'file' is writable but does not support snapshots
>  (qemu) quit
>  
>  Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728
> -- 
> 2.26.2
> 
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


