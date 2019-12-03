Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 209FFC432C3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 22:22:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCE8020684
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 22:22:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LM/jyIVV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCE8020684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59590 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icGYd-0004Vs-W6
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 17:22:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40804)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1icFxN-00046x-Mb
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 16:43:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1icFx7-00061J-B9
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 16:43:27 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53071
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1icFx6-0005so-4o
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 16:43:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575409402;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RNaUsrf/99dQ0NcERxnhOeyUPfp8bZQyhDaCGX7kSis=;
 b=LM/jyIVVPP2NctkN7ENA4jXG7XSphKDqWs4b30RKC3hw0ZzdggTbO1ubELiCFXaalAsMBu
 mIqv+RNe0564PfnhaWJhpAts1gtVBGeLuxtRaooZuH2bG5Jz1kb+0CrBHuy81aFfM5doWT
 ao4ZRjylQSQmp20X+Ld0ppmnD/abgK0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-352-UviGYW0kOquiPGgeQwBctQ-1; Tue, 03 Dec 2019 16:43:20 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D1C921856A60;
 Tue,  3 Dec 2019 21:43:19 +0000 (UTC)
Received: from [10.3.116.171] (ovpn-116-171.phx2.redhat.com [10.3.116.171])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8AEE7600C8;
 Tue,  3 Dec 2019 21:43:19 +0000 (UTC)
Subject: Re: [PATCH 21/21] tests-blockjob: Use error_free_or_abort()
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20191130194240.10517-1-armbru@redhat.com>
 <20191130194240.10517-22-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <318ed82a-a7a3-f5a5-eb92-4caac83a9acd@redhat.com>
Date: Tue, 3 Dec 2019 15:43:18 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191130194240.10517-22-armbru@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: UviGYW0kOquiPGgeQwBctQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Cc: vsementsov@virtuozzo.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/30/19 1:42 PM, Markus Armbruster wrote:
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   tests/test-blockjob.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

> diff --git a/tests/test-blockjob.c b/tests/test-blockjob.c
> index e670a20617..4eeb184caf 100644
> --- a/tests/test-blockjob.c
> +++ b/tests/test-blockjob.c
> @@ -48,9 +48,8 @@ static BlockJob *mk_job(BlockBackend *blk, const char *id,
>               g_assert_cmpstr(job->job.id, ==, blk_name(blk));
>           }
>       } else {
> -        g_assert_nonnull(err);
> +        error_free_or_abort(&err);
>           g_assert_null(job);
> -        error_free(err);
>       }
>   
>       return job;
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


