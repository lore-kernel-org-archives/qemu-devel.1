Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7F8FC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 11:50:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A680620707
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 11:50:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FxiyCPRP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A680620707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAtx2-0008U9-RI
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 07:50:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58424)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kAtwJ-0007vf-MH
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 07:50:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39066)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kAtwH-0000b0-2K
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 07:50:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598442599;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AjN+LSnqekJw0mJLR/PdGfcNpIInyIISEUzMN56cTm0=;
 b=FxiyCPRP1pUSNc4YflBURDHauyv8gCHfrWpdf9F/sjIyzDzES9koBy3lJTYXuIp5EECl37
 APsyd4I/3aKwfDpzwBH+JQPMGkkOS2tF0g7yF0a1qhF1lGrrkI77XKnVMotsWD2Ygq9E9x
 X0QaEBK9TmUgdZhGdfcuYyKbdpb4Qyo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-516-dWMYksKOMsKyaylUpur4Dg-1; Wed, 26 Aug 2020 07:49:58 -0400
X-MC-Unique: dWMYksKOMsKyaylUpur4Dg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AEC7864084;
 Wed, 26 Aug 2020 11:49:56 +0000 (UTC)
Received: from work-vm (ovpn-114-48.ams2.redhat.com [10.36.114.48])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 604087D892;
 Wed, 26 Aug 2020 11:49:54 +0000 (UTC)
Date: Wed, 26 Aug 2020 12:49:51 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Chuan Zheng <zhengchuan@huawei.com>
Subject: Re: [PATCH v5 02/12] migration/dirtyrate: add DirtyRateStatus to
 denote calculation status
Message-ID: <20200826114951.GD2726@work-vm>
References: <1598319650-36762-1-git-send-email-zhengchuan@huawei.com>
 <1598319650-36762-3-git-send-email-zhengchuan@huawei.com>
MIME-Version: 1.0
In-Reply-To: <1598319650-36762-3-git-send-email-zhengchuan@huawei.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/26 06:53:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
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
Cc: berrange@redhat.com, zhang.zhanghailiang@huawei.com, quintela@redhat.com,
 dme@dme.org, qemu-devel@nongnu.org, xiexiangyou@huawei.com,
 alex.chen@huawei.com, ann.zhuangyanying@huawei.com, fangying1@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Chuan Zheng (zhengchuan@huawei.com) wrote:
> add DirtyRateStatus to denote calculating status.
> 
> Signed-off-by: Chuan Zheng <zhengchuan@huawei.com>

With the minor wording changes from David Edmondson:


Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  migration/dirtyrate.c | 22 ++++++++++++++++++++++
>  qapi/migration.json   | 17 +++++++++++++++++
>  2 files changed, 39 insertions(+)
> 
> diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
> index 366f4e9..91987c5 100644
> --- a/migration/dirtyrate.c
> +++ b/migration/dirtyrate.c
> @@ -23,6 +23,19 @@
>  #include "migration.h"
>  #include "dirtyrate.h"
>  
> +static int CalculatingState = DIRTY_RATE_STATUS_UNSTARTED;
> +
> +static int dirtyrate_set_state(int *state, int old_state, int new_state)
> +{
> +    assert(new_state < DIRTY_RATE_STATUS__MAX);
> +    if (atomic_cmpxchg(state, old_state, new_state) == old_state) {
> +        return 0;
> +    } else {
> +        return -1;
> +    }
> +}
> +
> +
>  static void calculate_dirtyrate(struct DirtyRateConfig config)
>  {
>      /* todo */
> @@ -32,8 +45,17 @@ static void calculate_dirtyrate(struct DirtyRateConfig config)
>  void *get_dirtyrate_thread(void *arg)
>  {
>      struct DirtyRateConfig config = *(struct DirtyRateConfig *)arg;
> +    int ret;
> +
> +    ret = dirtyrate_set_state(&CalculatingState, DIRTY_RATE_STATUS_UNSTARTED,
> +                              DIRTY_RATE_STATUS_MEASURING);
> +    if (ret == -1) {
> +        return NULL;
> +    }
>  
>      calculate_dirtyrate(config);
>  
> +    ret = dirtyrate_set_state(&CalculatingState, DIRTY_RATE_STATUS_MEASURING,
> +                              DIRTY_RATE_STATUS_MEASURED);
>      return NULL;
>  }
> diff --git a/qapi/migration.json b/qapi/migration.json
> index 5f6b061..d640165 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -1720,3 +1720,20 @@
>  ##
>  { 'event': 'UNPLUG_PRIMARY',
>    'data': { 'device-id': 'str' } }
> +
> +##
> +# @DirtyRateStatus:
> +#
> +# An enumeration of dirtyrate status.
> +#
> +# @unstarted: query-dirtyrate thread is not initial.
> +#
> +# @measuring: query-dirtyrate thread is created and start to measure.
> +#
> +# @measured:  query-dirtyrate thread is end, we can get result.
> +#
> +# Since: 5.2
> +#
> +##
> +{ 'enum': 'DirtyRateStatus',
> +  'data': [ 'unstarted', 'measuring', 'measured'] }
> -- 
> 1.8.3.1
> 
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


