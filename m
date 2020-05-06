Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19E0AC54E49
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 21:50:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA6142075E
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 21:50:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TNOBrfoo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA6142075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55524 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWRvq-0002GS-0x
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 17:50:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53896)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jWRvC-0001qg-5E
 for qemu-devel@nongnu.org; Wed, 06 May 2020 17:49:42 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:36802
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jWRvB-0007Xs-5z
 for qemu-devel@nongnu.org; Wed, 06 May 2020 17:49:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588801779;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tgckUckiJ3JUMZEb4kgj1jyvKvREDuVTqsyi8eS1ZpU=;
 b=TNOBrfooT6esiZa8KlXyYlXIeeztoi4z6z0RuSxCAnOtVqB/LHuNGl3uxtiL+li4Nm3u4g
 hzcZPiazkfZj2CfeAlsz5MIOc/m83j63TflTn2jJRLiHEfnJCf0sNxL8u6To4iKiPn2AMK
 Ty7x/5pBUfG/CiQqcW6mJ+RdBS0Zft0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-491-5WBNuSiBOn2NESSGldhVMA-1; Wed, 06 May 2020 17:49:33 -0400
X-MC-Unique: 5WBNuSiBOn2NESSGldhVMA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6464A107ACCA;
 Wed,  6 May 2020 21:49:32 +0000 (UTC)
Received: from [10.3.114.73] (ovpn-114-73.phx2.redhat.com [10.3.114.73])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 966686106A;
 Wed,  6 May 2020 21:49:31 +0000 (UTC)
Subject: Re: [PATCH v2 1/5] qemu-img: remove check that cvtnum value > MAX_INT
To: Eyal Moscovici <eyal.moscovici@oracle.com>
References: <59b0896d-85ad-08b5-fcc1-36adad7501a4@redhat.com>
 <20200506213459.44743-1-eyal.moscovici@oracle.com>
 <20200506213459.44743-2-eyal.moscovici@oracle.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <f4131818-f606-2b30-ef69-d9612fb66a80@redhat.com>
Date: Wed, 6 May 2020 16:49:31 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200506213459.44743-2-eyal.moscovici@oracle.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/06 02:39:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, liran.alon@oracle.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/6/20 4:34 PM, Eyal Moscovici wrote:
> Following commit f46bfdbfc8f95cf65d7818ef68a801e063c40332 (util/cutils: Change
> qemu_strtosz*() from int64_t to uint64_t) which added a similar check to
> cvtnum. As a result there is no need to check it separately outside of cvtnum.
> 
> Acked-by: Mark Kanda <mark.kanda@oracle.com>
> Signed-off-by: Eyal Moscovici <eyal.moscovici@oracle.com>
> ---
>   qemu-img.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/qemu-img.c b/qemu-img.c
> index 6a4327aaba..116a9c6349 100644
> --- a/qemu-img.c
> +++ b/qemu-img.c
> @@ -4307,7 +4307,7 @@ static int img_bench(int argc, char **argv)
>               int64_t sval;
>   
>               sval = cvtnum(optarg);
> -            if (sval < 0 || sval > INT_MAX) {
> +            if (sval < 0) {
>                   error_report("Invalid buffer size specified");

INT_MAX is smaller than cvtnum's check for INT64_MAX.  This code change 
allows larger buffer sizes, which is probably not a good idea.

>                   return 1;
>               }
> @@ -4320,7 +4320,7 @@ static int img_bench(int argc, char **argv)
>               int64_t sval;
>   
>               sval = cvtnum(optarg);
> -            if (sval < 0 || sval > INT_MAX) {
> +            if (sval < 0) {
>                   error_report("Invalid step size specified");
>                   return 1;
>               }
> @@ -4493,7 +4493,7 @@ static int img_dd_bs(const char *arg,
>   
>       res = cvtnum(arg);
>   
> -    if (res <= 0 || res > INT_MAX) {
> +    if (res <= 0) {
>           error_report("invalid number: '%s'", arg);
>           return 1;
>       }
> 

NACK.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


