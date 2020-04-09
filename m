Return-Path: <SRS0=qpXq=5Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EB5EC2BA19
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 17:45:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06BCB20769
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 17:45:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C7nxcXfX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06BCB20769
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53450 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMbFA-00023g-5d
	for qemu-devel@archiver.kernel.org; Thu, 09 Apr 2020 13:45:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40660)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jMbEB-0000mr-Cj
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 13:44:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jMbEA-0008M9-8s
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 13:44:35 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40253
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jMbEA-0008Lq-3p
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 13:44:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586454273;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ctcZQOPSxqOMbWBJWHXIApGBTS8/auFOqg9mso5cTjQ=;
 b=C7nxcXfXAVQJbsGHTbcGRl1Z3mbTIdqNQ6rxe5sbBqb6pRzXliymMgvKFFBwEm2KbnaFBR
 0Q9AnOtx8xfVjN4f7i9QTCHhTjA3V7WKxAQhrTX9d85vkCpEmiDsCT0ltyaEYTfS7clQwG
 F8Trxpz7RIcabOJZca+tGEzv5knIz8k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-144-EMVpPRJxPx2wQf5ixl9rNg-1; Thu, 09 Apr 2020 13:44:28 -0400
X-MC-Unique: EMVpPRJxPx2wQf5ixl9rNg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8AB9B800D5C;
 Thu,  9 Apr 2020 17:44:27 +0000 (UTC)
Received: from [10.3.114.49] (ovpn-114-49.phx2.redhat.com [10.3.114.49])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 189D15C1BB;
 Thu,  9 Apr 2020 17:44:27 +0000 (UTC)
Subject: Re: [PATCH for-5.1 0/8] qemu-option: Fix corner cases and clean up
To: qemu-devel@nongnu.org, armbru@redhat.com
References: <158645218790.18042.4891276831001916938@39012742ff91>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <61902667-8412-3d94-c298-ac89963d4f7f@redhat.com>
Date: Thu, 9 Apr 2020 12:44:26 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <158645218790.18042.4891276831001916938@39012742ff91>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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

On 4/9/20 12:09 PM, no-reply@patchew.org wrote:
> Patchew URL: https://patchew.org/QEMU/20200409153041.17576-1-armbru@redhat.com/
> 
> 
> 
> Hi,
> 
> This series seems to have some coding style problems. See output below for
> more information:
> 

> === OUTPUT BEGIN ===
> 1/8 Checking commit 2e003109273b (tests-qemu-opts: Cover has_help_option(), qemu_opt_has_help_opt())
> WARNING: Block comments use a leading /* on a separate line
> #37: FILE: tests/test-qemu-opts.c:747:
> +        { "a,b,,help", false /* BUG */, true, true },

Annoying, but I don't mind ignoring it (especially since we fix the bug 
later in the series).

> 
> total: 0 errors, 1 warnings, 50 lines checked
> 
> Patch 1/8 has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> 2/8 Checking commit 8bb805dd3730 (qemu-options: Factor out get_opt_name_value() helper)
> 3/8 Checking commit b3630a346906 (qemu-option: Fix sloppy recognition of "id=..." after ", , ")
> 4/8 Checking commit 5c1b2db0b7ad (qemu-option: Avoid has_help_option() in qemu_opts_parse_noisily())
> 5/8 Checking commit 6845c29bee11 (qemu-option: Fix has_help_option()'s sloppy parsing)
> 6/8 Checking commit b7fcaaeeeb6f (test-qemu-opts: Simplify test_has_help_option() after bug fix)
> 7/8 Checking commit b164930d4c8d (qemu-img: Factor out accumulate_options() helper)
> 8/8 Checking commit 505f5f389855 (qemu-option: Move is_valid_option_list() to qemu-img.c and rewrite)
> ERROR: suspect code indent for conditional statements (4, 4)
> #61: FILE: qemu-img.c:243:
> +    for (i = len; i > 0 && optarg[i - 1] == ','; i--) {
> +    }

False positive. Maybe you can shut up the checker by:
     for (...) {
         /* nothing further to do */
     }

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


