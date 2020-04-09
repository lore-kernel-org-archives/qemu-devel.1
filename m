Return-Path: <SRS0=qpXq=5Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49AAEC2BA19
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 18:12:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AA1420757
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 18:12:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hzI6o0bJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AA1420757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53772 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMbeo-0003MP-8a
	for qemu-devel@archiver.kernel.org; Thu, 09 Apr 2020 14:12:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45063)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jMbdH-0002fd-2z
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 14:10:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jMbdE-0006hs-Uf
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 14:10:31 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54943
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jMbdE-0006h1-Py
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 14:10:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586455828;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w4SYP8VkMun5hgK27pOv0+WoDU07aiNKSwo0tvqLKT8=;
 b=hzI6o0bJBWpZPAmji5i5a0/LijeSVOUxJwprPyN5nlW+715+ht2aRdChqktXA3yMyf8uof
 96l5cwoBAhR2A7vlL5itsSuehiKL3UtsqkT5CduJjHzkziV1qqVoj94NvzJkRMFtW6+QBO
 xW/+m0dAw942GafvC7iev+mSxenB5nY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-284-Ct2GEXm-PVW4SatoTaIigQ-1; Thu, 09 Apr 2020 14:10:26 -0400
X-MC-Unique: Ct2GEXm-PVW4SatoTaIigQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2020E18C35A0;
 Thu,  9 Apr 2020 18:10:25 +0000 (UTC)
Received: from [10.3.114.49] (ovpn-114-49.phx2.redhat.com [10.3.114.49])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8B70A5DA7C;
 Thu,  9 Apr 2020 18:10:24 +0000 (UTC)
Subject: Re: [PATCH for-5.1 5/8] qemu-option: Fix has_help_option()'s sloppy
 parsing
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200409153041.17576-1-armbru@redhat.com>
 <20200409153041.17576-6-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <4e7c8e64-b5fe-4b8c-70d4-f6b2ea527e6a@redhat.com>
Date: Thu, 9 Apr 2020 13:10:24 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200409153041.17576-6-armbru@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/9/20 10:30 AM, Markus Armbruster wrote:
> has_help_option() uses its own parser.  It's inconsistent with
> qemu_opts_parse(), as demonstrated by test-qemu-opts case
> /qemu-opts/has_help_option.  Fix by reusing the common parser.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   tests/test-qemu-opts.c |  2 +-
>   util/qemu-option.c     | 39 +++++++++++++++++++--------------------
>   2 files changed, 20 insertions(+), 21 deletions(-)
> 
> diff --git a/tests/test-qemu-opts.c b/tests/test-qemu-opts.c
> index 27c24bb1a2..58a4ea2408 100644
> --- a/tests/test-qemu-opts.c
> +++ b/tests/test-qemu-opts.c
> @@ -744,7 +744,7 @@ static void test_has_help_option(void)
>           { "a,help", true, true, true },
>           { "a=0,help,b", true, true, true },
>           { "help,b=1", true, true, false },
> -        { "a,b,,help", false /* BUG */, true, true },
> +        { "a,b,,help", true, true, true },

Okay, this revisits my question from 1/8.

I guess the argument is that since 'b,help' is NOT a valid option name 
(only as an option value), that we are instead parsing three separate 
options 'b', '', and 'help', and whether or not the empty option is 
valid, the face that 'help' is valid is what makes this return true?


> +++ b/util/qemu-option.c
> @@ -165,26 +165,6 @@ void parse_option_size(const char *name, const char *value,
>       *ret = size;
>   }
>   
> -bool has_help_option(const char *param)
> -{
> -    const char *p = param;
> -    bool result = false;
> -
> -    while (*p && !result) {
> -        char *value;
> -
> -        p = get_opt_value(p, &value);
> -        if (*p) {
> -            p++;
> -        }
> -
> -        result = is_help_option(value);

Old code: both 'help' and '?' are accepted.

> +bool has_help_option(const char *params)
> +{
> +    const char *p;
> +    char *name, *value;
> +    bool ret;
> +
> +    for (p = params; *p;) {
> +        p = get_opt_name_value(p, NULL, &name, &value);
> +        ret = !strcmp(name, "help");

New code: only 'help' is accepted.  Is the loss of '?' intentional?

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


