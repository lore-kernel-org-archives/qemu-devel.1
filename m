Return-Path: <SRS0=qpXq=5Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED211C2BA19
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 18:05:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1EC620757
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 18:05:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="djpZcho5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1EC620757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53704 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMbYi-0000em-Vg
	for qemu-devel@archiver.kernel.org; Thu, 09 Apr 2020 14:05:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44208)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jMbY9-000060-Qb
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 14:05:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jMbY8-0003Va-QB
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 14:05:13 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34922
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jMbY8-0003UV-MN
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 14:05:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586455510;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3knomRhlz8Y8QrDTmYj66/hAq1o7we2zKIt1pzHJzEQ=;
 b=djpZcho5TGxpo9Nu8uvtmsE5G3V9xi2+Hg5nZuJsoECr7B53Kbl7hu99twjng824/10Kg4
 c0KV6Y7U/RzfBDDSrYlggBLCIsevpzQHnDUGtLvojiUD+IyXk+D5k1Lv3yQ3FF91ap0ZgO
 ZtnSjNZDFjkUv3VXNs6ZBfp0g+QNQsw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-468-MsVVoN0WM-qtk4l3UVBaMw-1; Thu, 09 Apr 2020 14:05:08 -0400
X-MC-Unique: MsVVoN0WM-qtk4l3UVBaMw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8A8D38017F3;
 Thu,  9 Apr 2020 18:05:07 +0000 (UTC)
Received: from [10.3.114.49] (ovpn-114-49.phx2.redhat.com [10.3.114.49])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 001521001925;
 Thu,  9 Apr 2020 18:05:06 +0000 (UTC)
Subject: Re: [PATCH for-5.1 3/8] qemu-option: Fix sloppy recognition of
 "id=..." after ", , "
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200409153041.17576-1-armbru@redhat.com>
 <20200409153041.17576-4-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <657eb2fd-5909-501e-4aa1-9e7490794d5b@redhat.com>
Date: Thu, 9 Apr 2020 13:05:06 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200409153041.17576-4-armbru@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   tests/test-qemu-opts.c |  4 ++--
>   util/qemu-option.c     | 27 +++++++++++++++++++--------
>   2 files changed, 21 insertions(+), 10 deletions(-)
> 
> diff --git a/tests/test-qemu-opts.c b/tests/test-qemu-opts.c
> index 0efe93b45e..27c24bb1a2 100644
> --- a/tests/test-qemu-opts.c
> +++ b/tests/test-qemu-opts.c
> @@ -500,10 +500,10 @@ static void test_opts_parse(void)
>       g_assert(!opts);
>       /* TODO Cover .merge_lists = true */
>   
> -    /* Buggy ID recognition */
> +    /* Buggy ID recognition (fixed) */
>       opts = qemu_opts_parse(&opts_list_03, "x=,,id=bar", false, &error_abort);
>       g_assert_cmpuint(opts_count(opts), ==, 1);
> -    g_assert_cmpstr(qemu_opts_id(opts), ==, "bar"); /* BUG */
> +    g_assert(!qemu_opts_id(opts));
>       g_assert_cmpstr(qemu_opt_get(opts, "x"), ==, ",id=bar");

Yay - that matches my intuition better about ,, handling.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


