Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C0A3C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 14:39:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CF05206BE
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 14:39:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DTESPZBC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CF05206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqdtu-0007Jj-LN
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 10:39:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43234)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jqdt3-0006am-IC
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 10:38:57 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33637
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jqdt1-0004jN-4d
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 10:38:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593614333;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QyTwtP3Fs+xAtEKSYUlCt0dnjvP1H0ESd55IvBWEi8I=;
 b=DTESPZBCRP1N+bCybC59lEK2+G+B2K8aaERX8/HdmetTsRsAd6er8pJiKEa2KBIrcMninv
 j2LJmgppgZK11wvlNyc5XroWEnFWJzMBsmeDG12g7LoNz2FpDV6EFlVPYmEehfejrt6P2a
 v7I9CWOFK/rKeONL0moCgqcaJKEFpjQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-471-yoR8La0xN6ewdL7yxNkacA-1; Wed, 01 Jul 2020 10:38:51 -0400
X-MC-Unique: yoR8La0xN6ewdL7yxNkacA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0FE258C451D;
 Wed,  1 Jul 2020 14:38:33 +0000 (UTC)
Received: from [10.3.114.107] (ovpn-114-107.phx2.redhat.com [10.3.114.107])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 399A160CD0;
 Wed,  1 Jul 2020 14:38:32 +0000 (UTC)
Subject: Re: [PATCH 1/4] migration: Prevent memleak by ...params_test_apply
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200630084552.46362-1-mreitz@redhat.com>
 <20200630084552.46362-2-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <1e801600-db27-1625-f168-1b08396dc5b2@redhat.com>
Date: Wed, 1 Jul 2020 09:38:31 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200630084552.46362-2-mreitz@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/01 01:29:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/30/20 3:45 AM, Max Reitz wrote:
> The created structure is not really a proper QAPI object, so we cannot
> and will not free its members.  Strings therein should therefore not be
> duplicated, or we will leak them.

This seems fragile to me; having to code QAPI usage differently 
depending on whether the containing struct was malloc'd or not (and 
therefore whether someone will call qapi_free_MigrateSetParameters or 
not) looks awkward to maintain.  We have 
visit_type_MigrateSetParameters_members, could that be used as a cleaner 
way to free all members of the struct without freeing the struct itself? 
  Should the QAPI generator start generating qapi_free_FOO_members to 
make such cleanup easier?

> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>   migration/migration.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index 481a590f72..47c7da4e55 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1336,12 +1336,12 @@ static void migrate_params_test_apply(MigrateSetParameters *params,
>   
>       if (params->has_tls_creds) {
>           assert(params->tls_creds->type == QTYPE_QSTRING);
> -        dest->tls_creds = g_strdup(params->tls_creds->u.s);
> +        dest->tls_creds = params->tls_creds->u.s;
>       }
>   
>       if (params->has_tls_hostname) {
>           assert(params->tls_hostname->type == QTYPE_QSTRING);
> -        dest->tls_hostname = g_strdup(params->tls_hostname->u.s);
> +        dest->tls_hostname = params->tls_hostname->u.s;
>       }
>   
>       if (params->has_max_bandwidth) {
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


