Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF7F5C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 19:48:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1F4D2081A
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 19:48:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JKd2hr7i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1F4D2081A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48608 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joBNX-0000A2-Sr
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 15:48:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45742)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1joBMT-0007zB-Eq
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 15:47:09 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48718
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1joBMQ-0001xN-QN
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 15:47:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593028025;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/+uhegA9Mz4DOR2c+wwtdw6/bbhMbpxgP655ZiFQAy8=;
 b=JKd2hr7iltXOUDJSqDsA1PdhZV/UOhPMFcmDlQknN29gyF1/USYcxrNNeYwSAjIOmxJJxu
 7nHnbD5j+TIpqLH2JSm/6J1ZKAtW/+V5FOs1Pgn+amGUKgzcQtMoxOtWLJZDEV1n7bc4FV
 0Fpj/ZAxpuFoodaOr8GTvi9h/ISYFXA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-417-W95Icj5GO1S66g1JhxfaSA-1; Wed, 24 Jun 2020 15:47:03 -0400
X-MC-Unique: W95Icj5GO1S66g1JhxfaSA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1F41D800C60;
 Wed, 24 Jun 2020 19:47:02 +0000 (UTC)
Received: from [10.3.114.107] (ovpn-114-107.phx2.redhat.com [10.3.114.107])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8CFE860F8A;
 Wed, 24 Jun 2020 19:46:58 +0000 (UTC)
Subject: Re: [PATCH 13/46] qemu-option: Simplify around find_default_by_name()
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200624164344.3778251-1-armbru@redhat.com>
 <20200624164344.3778251-14-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <13665429-b6ae-351b-0b96-7810da94f0db@redhat.com>
Date: Wed, 24 Jun 2020 14:46:57 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200624164344.3778251-14-armbru@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/24 02:33:25
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
Cc: peter.maydell@linaro.org, vsementsov@virtuozzo.com, berrange@redhat.com,
 ehabkost@redhat.com, qemu-block@nongnu.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/24/20 11:43 AM, Markus Armbruster wrote:
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   util/qemu-option.c | 13 ++++---------
>   1 file changed, 4 insertions(+), 9 deletions(-)
> 
> diff --git a/util/qemu-option.c b/util/qemu-option.c
> index ddcf3072c5..d9293814b4 100644
> --- a/util/qemu-option.c
> +++ b/util/qemu-option.c
> @@ -286,11 +286,9 @@ const char *qemu_opt_get(QemuOpts *opts, const char *name)
>       opt = qemu_opt_find(opts, name);
>       if (!opt) {
>           def_val = find_default_by_name(opts, name);
> -        if (def_val) {
> -            return def_val;
> -        }
> +        return def_val;
>       }
> -    return opt ? opt->str : NULL;
> +    return opt->str;
>   }

You could go with even fewer lines and variables by inverting the logic:

if (opt) {
     return opt->str;
}
return find_default_by_name(opts, name);


>   
>   void qemu_opt_iter_init(QemuOptsIter *iter, QemuOpts *opts, const char *name)
> @@ -320,7 +318,7 @@ char *qemu_opt_get_del(QemuOpts *opts, const char *name)
>   {
>       QemuOpt *opt;
>       const char *def_val;
> -    char *str = NULL;
> +    char *str;
>   
>       if (opts == NULL) {
>           return NULL;
> @@ -329,10 +327,7 @@ char *qemu_opt_get_del(QemuOpts *opts, const char *name)
>       opt = qemu_opt_find(opts, name);
>       if (!opt) {
>           def_val = find_default_by_name(opts, name);
> -        if (def_val) {
> -            str = g_strdup(def_val);
> -        }
> -        return str;
> +        return g_strdup(def_val);

Similarly, you could drop def_val with:
  return g_strdup(find_default_by_name(opts, name));

Either way,
Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


