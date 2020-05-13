Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DA34CA90AF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 09:48:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF34920769
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 09:48:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ISRlpcrH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF34920769
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYo06-0003lA-V0
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 05:48:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43724)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jYnyr-00032Q-IO
 for qemu-devel@nongnu.org; Wed, 13 May 2020 05:47:13 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:42674
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jYnyq-00027x-9x
 for qemu-devel@nongnu.org; Wed, 13 May 2020 05:47:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589363231;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=icHSjLUhPV4QCazSWdI9Y8/NTLGaUe3IsfXiGpTMN98=;
 b=ISRlpcrHzEo3/FlpvtKy0RtgHt2mq2RxYtjjsVJmM1vAcL1D6pWppyxuFBCEADr7NhhXd7
 QeBS8Q7P+0LcQ00Cxgj1ad7V2pOA/mAzqyK+leyyw+jS5P2YRgoNnLG0NegtBs+yIOE1jD
 tgKrzDBCX2wUrxyDytPcs5LtUnScWVg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-371--uTwej90PIqSCwrdwW_cMQ-1; Wed, 13 May 2020 05:47:07 -0400
X-MC-Unique: -uTwej90PIqSCwrdwW_cMQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6EA568018AC;
 Wed, 13 May 2020 09:47:06 +0000 (UTC)
Received: from work-vm (ovpn-115-30.ams2.redhat.com [10.36.115.30])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 57E2C7D94B;
 Wed, 13 May 2020 09:47:05 +0000 (UTC)
Date: Wed, 13 May 2020 10:47:02 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Lukas Straub <lukasstraub2@web.de>
Subject: Re: [PATCH 2/6] migration/colo.c: Use cpu_synchronize_all_states()
Message-ID: <20200513094702.GC3225@work-vm>
References: <cover.1589193382.git.lukasstraub2@web.de>
 <9675031ce557b73ebd10e7bd20ebbf57f30b177c.1589193382.git.lukasstraub2@web.de>
MIME-Version: 1.0
In-Reply-To: <9675031ce557b73ebd10e7bd20ebbf57f30b177c.1589193382.git.lukasstraub2@web.de>
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 04:17:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 T_HK_NAME_DR=0.01 autolearn=_AUTOLEARN
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
Cc: Juan Quintela <quintela@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Hailiang Zhang <zhang.zhanghailiang@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Lukas Straub (lukasstraub2@web.de) wrote:
> cpu_synchronize_all_pre_loadvm() marks all vcpus as dirty, so the
> registers are loaded from CPUState before we continue running
> the vm. However if we failover during checkpoint, CPUState is not
> initialized and the registers are loaded with garbage. This causes
> guest hangs and crashes.
> 
> Fix this by using cpu_synchronize_all_states(), which initializes
> CPUState from the current cpu registers additionally to marking
> the vcpus as dirty.
> 
> Signed-off-by: Lukas Straub <lukasstraub2@web.de>

OK, so I think you're saying that if the qemu_loadvm_state_main fails
because we failover, we now have duff CPU state, where we should just
carry on running on the secondary with the current state, so yes


Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  migration/colo.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/migration/colo.c b/migration/colo.c
> index 09168627bc..6b2ad35aa4 100644
> --- a/migration/colo.c
> +++ b/migration/colo.c
> @@ -696,7 +696,7 @@ static void colo_incoming_process_checkpoint(MigrationIncomingState *mis,
>      }
>  
>      qemu_mutex_lock_iothread();
> -    cpu_synchronize_all_pre_loadvm();
> +    cpu_synchronize_all_states();
>      ret = qemu_loadvm_state_main(mis->from_src_file, mis);
>      qemu_mutex_unlock_iothread();
>  
> -- 
> 2.20.1
> 


--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


