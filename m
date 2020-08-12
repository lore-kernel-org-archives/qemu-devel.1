Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E440C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 10:22:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17C102076B
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 10:22:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MEHubTHc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17C102076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5nu0-0004hi-7m
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 06:22:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54392)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1k5ntG-0003vg-Cl
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 06:21:51 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:39954
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1k5ntE-0003dR-9A
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 06:21:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597227707;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Yqy+eMQTeanmkxo4RN0OtmKppduj6Y4tvcTxH8DSy8c=;
 b=MEHubTHcP7L/tdqAUlrmmthnHbSK63gVLBPxTKEP8oeWdDnur+5i6ixBQS23GP+GtAVG+8
 csIQom+hs3JwfORGyKLb/2MIajo3qcc/6WS1IwZxHrOmueQsxDV0p0vfLuzuYCK26rOdG/
 aQRO3grVPV6+g4SxJ0u1WMst1ud6o0o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-518-TnbAvq-7O0WjuMRrHsCyxw-1; Wed, 12 Aug 2020 06:21:45 -0400
X-MC-Unique: TnbAvq-7O0WjuMRrHsCyxw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 671D5107ACCA;
 Wed, 12 Aug 2020 10:21:44 +0000 (UTC)
Received: from work-vm (ovpn-113-233.ams2.redhat.com [10.36.113.233])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A6D4B1063423;
 Wed, 12 Aug 2020 10:21:41 +0000 (UTC)
Date: Wed, 12 Aug 2020 11:21:39 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH v2 3/6] migration: stop returning errno from
 load_snapshot()
Message-ID: <20200812102139.GD2810@work-vm>
References: <20200727150843.3419256-1-berrange@redhat.com>
 <20200727150843.3419256-4-berrange@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200727150843.3419256-4-berrange@redhat.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/12 04:50:17
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
> None of the callers care about the errno value since there is a full
> Error object populated. This gives consistency with save_snapshot()
> which already just returns -1.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

(Note this is true of snapshots only; in postcopy there are places we
care about the errno for recovery)

> ---
>  migration/savevm.c | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 19259ef7c0..6c4d80fc5a 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -2843,20 +2843,20 @@ int load_snapshot(const char *name, Error **errp)
>      if (!replay_can_snapshot()) {
>          error_setg(errp, "Record/replay does not allow loading snapshot "
>                     "right now. Try once more later.");
> -        return -EINVAL;
> +        return -1;
>      }
>  
>      if (!bdrv_all_can_snapshot(errp)) {
> -        return -ENOTSUP;
> +        return -1;
>      }
>      ret = bdrv_all_find_snapshot(name, errp);
>      if (ret < 0) {
> -        return ret;
> +        return -1;
>      }
>  
>      bs_vm_state = bdrv_all_find_vmstate_bs(errp);
>      if (!bs_vm_state) {
> -        return -ENOTSUP;
> +        return -1;
>      }
>      aio_context = bdrv_get_aio_context(bs_vm_state);
>  
> @@ -2865,11 +2865,11 @@ int load_snapshot(const char *name, Error **errp)
>      ret = bdrv_snapshot_find(bs_vm_state, &sn, name);
>      aio_context_release(aio_context);
>      if (ret < 0) {
> -        return ret;
> +        return -1;
>      } else if (sn.vm_state_size == 0) {
>          error_setg(errp, "This is a disk-only snapshot. Revert to it "
>                     " offline using qemu-img");
> -        return -EINVAL;
> +        return -1;
>      }
>  
>      /* Flush all IO requests so they don't interfere with the new state.  */
> @@ -2884,7 +2884,6 @@ int load_snapshot(const char *name, Error **errp)
>      f = qemu_fopen_bdrv(bs_vm_state, 0);
>      if (!f) {
>          error_setg(errp, "Could not open VM state file");
> -        ret = -EINVAL;
>          goto err_drain;
>      }
>  
> @@ -2900,14 +2899,14 @@ int load_snapshot(const char *name, Error **errp)
>  
>      if (ret < 0) {
>          error_setg(errp, "Error %d while loading VM state", ret);
> -        return ret;
> +        return -1;
>      }
>  
>      return 0;
>  
>  err_drain:
>      bdrv_drain_all_end();
> -    return ret;
> +    return -1;
>  }
>  
>  void vmstate_register_ram(MemoryRegion *mr, DeviceState *dev)
> -- 
> 2.26.2
> 
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


