Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B6A1C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 16:52:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 188F3207CD
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 16:52:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KE0CxtWK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 188F3207CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyHyq-0001RV-Bm
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 12:52:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44494)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jyHy1-00006S-Kj
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 12:51:41 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:46228
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jyHxz-0001f5-Gw
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 12:51:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595436698;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ALI6U0VRB0xoOqTZN2Pl/PEvlPkAUkcEkkK8W2icmVs=;
 b=KE0CxtWKTdfrW463cz/sU8zBjxYkREEUe37DhvgyfVwxBSDCNuf23cnzy2DEmp5+pbPkNB
 vvSvkRfX91Qv7jFlJE3lVzEe5yUTGYEvWf4Y36d7lITEzmCuaBIhvN2uo++xD+EnV8C4EY
 O316TUUJCnLqX/6I9q2f0ZD1Dfvd200=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-395-vLBV4WisNXeXzmc7CWCbHg-1; Wed, 22 Jul 2020 12:51:36 -0400
X-MC-Unique: vLBV4WisNXeXzmc7CWCbHg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7FF9080046D
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2020 16:51:35 +0000 (UTC)
Received: from work-vm (ovpn-112-43.ams2.redhat.com [10.36.112.43])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3EC098BEC5;
 Wed, 22 Jul 2020 16:51:28 +0000 (UTC)
Date: Wed, 22 Jul 2020 17:51:25 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH for-5.1 1/3] virtiofsd: drop CAP_DAC_READ_SEARCH
Message-ID: <20200722165125.GJ2660@work-vm>
References: <20200722130206.224898-1-stefanha@redhat.com>
 <20200722130206.224898-2-stefanha@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200722130206.224898-2-stefanha@redhat.com>
User-Agent: Mutt/1.14.5 (2020-06-23)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/21 23:34:34
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
Cc: virtio-fs@redhat.com, rmohr@redhat.com, qemu-devel@nongnu.org,
 vromanso@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Stefan Hajnoczi (stefanha@redhat.com) wrote:
> virtiofsd does not need CAP_DAC_READ_SEARCH because it already has
> the more powerful CAP_DAC_OVERRIDE. Drop it from the list of
> capabilities.
> 
> This is important because container runtimes may not include
> CAP_DAC_READ_SEARCH by default. This patch allows virtiofsd to reduce
> its capabilities when running inside a Docker container.
> 
> Note that CAP_DAC_READ_SEARCH may be necessary again in the future if
> virtiofsd starts using open_by_handle_at(2).
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

Yeh that seems to make sense, and is probably worth having irrespective
of the rest of the series.


Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  tools/virtiofsd/passthrough_ll.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough_ll.c
> index 94e0de2d2b..50a164a599 100644
> --- a/tools/virtiofsd/passthrough_ll.c
> +++ b/tools/virtiofsd/passthrough_ll.c
> @@ -2596,7 +2596,6 @@ static void setup_capabilities(char *modcaps_in)
>      if (capng_updatev(CAPNG_ADD, CAPNG_PERMITTED | CAPNG_EFFECTIVE,
>              CAP_CHOWN,
>              CAP_DAC_OVERRIDE,
> -            CAP_DAC_READ_SEARCH,
>              CAP_FOWNER,
>              CAP_FSETID,
>              CAP_SETGID,
> -- 
> 2.26.2
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


