Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DEA9C2D0EC
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 15:54:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D156920775
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 15:54:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MZxKzfrz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D156920775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55790 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHUpe-0007QF-06
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 11:54:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56658)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jHUoy-0006rT-Aw
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 11:53:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jHUox-0001Nh-Bq
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 11:53:28 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:49618)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jHUox-0001NU-8v
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 11:53:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585238006;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x/zXO+n74YzsO5/pThLGvvYQUfSeLJ4CuDdRpKY9vQI=;
 b=MZxKzfrzdKtHAIqprfTAjPKPbAiPR+Qg8eiKOe4pElIIDue/o5iiN+H2zwkxOMtqFT88VT
 6ZJsuEZQhG06onKV+WQdiKvviUgHS06F9ijkqTkix7eTFjfBgvLsA+sXNdSW/qezk/C7WT
 DAvJAcdE5b8oHo4+WHN42NKk1+JkWdk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-391-ELAV1qffP56O9U9u2dQ7bA-1; Thu, 26 Mar 2020 11:53:22 -0400
X-MC-Unique: ELAV1qffP56O9U9u2dQ7bA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8E73213F7;
 Thu, 26 Mar 2020 15:53:21 +0000 (UTC)
Received: from [10.3.113.103] (ovpn-113-103.phx2.redhat.com [10.3.113.103])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2855019C69;
 Thu, 26 Mar 2020 15:53:21 +0000 (UTC)
Subject: Re: [PATCH v2 0/2] mirror: Fix hang (operation waiting for
 itself/circular dependency)
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20200326153628.4869-1-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <3c799e1c-2a59-eac9-4f13-30d3415b24c7@redhat.com>
Date: Thu, 26 Mar 2020 10:53:20 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200326153628.4869-1-kwolf@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: jsnow@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/26/20 10:36 AM, Kevin Wolf wrote:
> The recent fix didn't actually fix the whole problem. Operations can't
> only wait for themselves, but we can also end up with circular
> dependencies like two operations waiting for each other to complete.
> 
> This reverts the first fix and implements another approach.
> 
> v2:
> - Mark active mirror operations as in-flight, too
> 
> Kevin Wolf (2):
>    Revert "mirror: Don't let an operation wait for itself"
>    mirror: Wait only for in-flight operations

Series:
Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


