Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 408F4C433E3
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 11:50:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E012206E3
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 11:50:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pg4bL9Ji"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E012206E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45230 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyZkL-0004Z0-8z
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 07:50:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47730)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jyZjT-0003mR-M6
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 07:49:51 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:54308
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jyZjS-0004Ti-15
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 07:49:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595504988;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y8BT1WagpjDthPqobkRoSrP8FhsHfuzNW6QIHjCp+8g=;
 b=Pg4bL9JiUWUKX7vyoMR9yvZjTMcPRfGtb8vi4J4TV91jgrg5xhVkOkWj8HJsPqfGdgVwEn
 UYTEqVI+uGtMBNTqTwxy1rMzLYwWU11xgROCTmc7rqOeRN306aonVZT1KDJJd8+QxNVRZi
 33t9GhVIqEsiPtwfqDY/ZOf8uQlpoc4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-186-rVpAI-lRMQOyZIqE7bXcCA-1; Thu, 23 Jul 2020 07:49:46 -0400
X-MC-Unique: rVpAI-lRMQOyZIqE7bXcCA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CEF7E8014D7;
 Thu, 23 Jul 2020 11:49:45 +0000 (UTC)
Received: from [10.3.112.189] (ovpn-112-189.phx2.redhat.com [10.3.112.189])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7E70A5F7D8;
 Thu, 23 Jul 2020 11:49:45 +0000 (UTC)
Subject: Re: [PATCH] qapi: enable use of g_autoptr with QAPI types
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
References: <20200723111250.2650203-1-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <781b8043-bce5-9f64-bc5f-4f2f740c6a6d@redhat.com>
Date: Thu, 23 Jul 2020 06:49:44 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200723111250.2650203-1-berrange@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/23 02:33:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Markus Armbruster <armbru@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/23/20 6:12 AM, Daniel P. Berrangé wrote:
> Currently QAPI generates a type and function for free'ing it:
> 
>    typedef struct QCryptoBlockCreateOptions QCryptoBlockCreateOptions;
>    void qapi_free_QCryptoBlockCreateOptions(QCryptoBlockCreateOptions *obj);
> 

> The above code example now becomes
> 
>    g_autoptr(QCryptoBlockCreateOptions) opts = NULL;
> 
>    opts = g_new0(QCryptoBlockCreateOptions, 1);
> 
>    ....do stuff with opts...
> 
> Note, if the local pointer needs to live beyond the scope holding the
> variable, then g_steal_pointer can be used. This is useful to return the
> pointer to the caller in the success codepath, while letting it be freed
> in all error codepaths.
> 
>    return g_steal_pointer(&opts);
> 

Yep, the idea makes sense!

> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   include/crypto/block.h | 2 --
>   scripts/qapi/types.py  | 1 +
>   2 files changed, 1 insertion(+), 2 deletions(-)

Missing a counterpart change to docs/devel/qapi-code-gen.txt.  And it 
might be nice to make this a series with at least one followup patch 
using the new capability, or at least so 'make check' coverage.  But 
otherwise on the right track.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


