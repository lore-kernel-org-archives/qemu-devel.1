Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C27EC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 14:03:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 662022065C
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 14:03:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dV6Xt6TA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 662022065C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyyIL-00086y-NT
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 10:03:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36236)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jyyH9-0006pl-43
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 10:02:15 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:51538
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jyyH6-0007xm-O7
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 10:02:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595599331;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pEr37XSVcsDb4mMIcNzPelbQ99LJcUitGdQmyJlm/Sw=;
 b=dV6Xt6TAuVHEqePHuoWv7uCWtdIsenYFYhe9eN7nq/24xe6fBRED2Tea0CM2bAGWk5jxxe
 VPDnj1bOGotqacGkJq8+JuU7TTWp842xy3PcEzidOaIUvQOH6vdboiJ2L8aA0rb5soMfeg
 0gJN+KNLlyQnNbV1YOHAuIwOUQS0H5w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-91-7JAzXhOpNVaIgDwq9Ho6tw-1; Fri, 24 Jul 2020 10:02:09 -0400
X-MC-Unique: 7JAzXhOpNVaIgDwq9Ho6tw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 681B680046B;
 Fri, 24 Jul 2020 14:02:08 +0000 (UTC)
Received: from [10.3.112.130] (ovpn-112-130.phx2.redhat.com [10.3.112.130])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B08F35D9D3;
 Fri, 24 Jul 2020 14:02:05 +0000 (UTC)
Subject: Re: [PATCH v3 2/4] util: introduce qemu_open and qemu_create with
 error reporting
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
References: <20200724132510.3250311-1-berrange@redhat.com>
 <20200724132510.3250311-3-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <611703da-8c04-8e33-5610-5e15e6d49941@redhat.com>
Date: Fri, 24 Jul 2020 09:02:03 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200724132510.3250311-3-berrange@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/24 00:00:27
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
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/24/20 8:25 AM, Daniel P. Berrangé wrote:
> This introduces two new helper metohds
> 
>    int qemu_open(const char *name, int flags, Error **errp);
>    int qemu_create(const char *name, int flags, mode_t mode, Error **errp);
> 
> Note that with this design we no longer require or even accept the
> O_CREAT flag. Avoiding overloading the two distinct operations
> means we can avoid variable arguments which would prevent 'errp' from
> being the last argument. It also gives us a guarantee that the 'mode' is
> given when creating files, avoiding a latent security bug.

I like it.

> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   include/qemu/osdep.h |  6 ++++
>   util/osdep.c         | 78 ++++++++++++++++++++++++++++++++++++--------
>   2 files changed, 71 insertions(+), 13 deletions(-)
> 
> diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
> index 3a16e58932..ca24ebe211 100644
> --- a/include/qemu/osdep.h
> +++ b/include/qemu/osdep.h
> @@ -494,7 +494,13 @@ int qemu_madvise(void *addr, size_t len, int advice);
>   int qemu_mprotect_rwx(void *addr, size_t size);
>   int qemu_mprotect_none(void *addr, size_t size);
>   
> +/*
> + * Don't introduce new usage of this function, prefer the following
> + * qemu_open/qemu_create that take a "Error **errp"

s/a /an /

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


