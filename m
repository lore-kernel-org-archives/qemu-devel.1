Return-Path: <SRS0=qpXq=5Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95E63C2BA19
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 18:04:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 622BF2072F
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 18:04:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TYzFrM1p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 622BF2072F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53660 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMbXT-0007Np-CS
	for qemu-devel@archiver.kernel.org; Thu, 09 Apr 2020 14:04:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43715)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jMbV9-0004wu-Ib
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 14:02:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jMbV8-0001Vt-HW
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 14:02:07 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:38702
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jMbV8-0001U3-7z
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 14:02:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586455324;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ohurTFnwHTFEvah1f7EZXFN/XV+nDXWrD4MHbi4zHEc=;
 b=TYzFrM1pKmut2aZhQls06xPwLD9MI+RfGM3F9T9zHD5OsWUWJpLjqMJNZ6iQ6HGvEXB0De
 I8K4ZkASPuXBofTxa1CZl6H/39XJdN9ceIW307Gw6retFyQgvB0fyNBoo3OK5j67uI6pkb
 gRMIOCeY0IUfeYCxuqerJDi331bNqCk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-167-Mjl1GEcMMeqHSazoxH7GOg-1; Thu, 09 Apr 2020 14:02:00 -0400
X-MC-Unique: Mjl1GEcMMeqHSazoxH7GOg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0033E800D53;
 Thu,  9 Apr 2020 18:02:00 +0000 (UTC)
Received: from [10.3.114.49] (ovpn-114-49.phx2.redhat.com [10.3.114.49])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8B3BA391;
 Thu,  9 Apr 2020 18:01:59 +0000 (UTC)
Subject: Re: [PATCH for-5.1 2/8] qemu-options: Factor out get_opt_name_value()
 helper
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200409153041.17576-1-armbru@redhat.com>
 <20200409153041.17576-3-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <5f39e636-f799-55f3-873f-08a3a0f53dca@redhat.com>
Date: Thu, 9 Apr 2020 13:01:59 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200409153041.17576-3-armbru@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/9/20 10:30 AM, Markus Armbruster wrote:
> The next commits will put it to use.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   util/qemu-option.c | 102 +++++++++++++++++++++++++--------------------
>   1 file changed, 56 insertions(+), 46 deletions(-)
> 

> +static const char *get_opt_name_value(const char *params,
> +                                      const char *firstname,
> +                                      char **name, char **value)
> +{
> +    const char *p, *pe, *pc;
> +
> +    pe = strchr(params, '=');
> +    pc = strchr(params, ',');
> +
> +    if (!pe || (pc && pc < pe)) {
> +        /* found "foo,more" */
> +        if (firstname) {
> +            /* implicitly named first option */
> +            *name = g_strdup(firstname);
> +            p = get_opt_value(params, value);

Is this correct even when params is "foo,,more"?  But...

>   static void opts_do_parse(QemuOpts *opts, const char *params,
>                             const char *firstname, bool prepend,
>                             bool *invalidp, Error **errp)
>   {
> -    char *option = NULL;
> -    char *value = NULL;
> -    const char *p,*pe,*pc;
>       Error *local_err = NULL;
> +    char *option, *value;
> +    const char *p;
>   
> -    for (p = params; *p != '\0'; p++) {
> -        pe = strchr(p, '=');
> -        pc = strchr(p, ',');
> -        if (!pe || (pc && pc < pe)) {
> -            /* found "foo,more" */
> -            if (p == params && firstname) {
> -                /* implicitly named first option */
> -                option = g_strdup(firstname);
> -                p = get_opt_value(p, &value);

...in this patch, it is just code motion, so if it is a bug, it's 
pre-existing and worth a separate fix.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


