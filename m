Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A6E8C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 20:09:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63A4F206F7
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 20:09:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eqM9qZ7s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63A4F206F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jj72J-00031Q-LU
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 16:09:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41762)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jj710-0001of-Qg
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 16:08:02 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:29582
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jj710-0001g0-4q
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 16:08:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591819681;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IRzETK7NJ8uZIxE3sp8FMgeqvLftL/4TC5KUR4yEsUk=;
 b=eqM9qZ7s+dTNgV0apHVjQfah8sXX9EQjqZb+ECOoYo/zxmSJbTB1nr0P/CXV9S55xUM4j2
 a3JaiERNLhUezicLwNm1+hJzkJ0zBrRDPkANoMDu3yZaZzjEPpjp9jqh/DQkh0nlG5vQ/F
 SXSs+hI/M0stw+E/ewGjGbtEtYMI9UM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-154-L6mWDHYhM6OSOzgvlVbf5Q-1; Wed, 10 Jun 2020 16:07:54 -0400
X-MC-Unique: L6mWDHYhM6OSOzgvlVbf5Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C2535108BD0A;
 Wed, 10 Jun 2020 20:07:51 +0000 (UTC)
Received: from [10.3.113.22] (ovpn-113-22.phx2.redhat.com [10.3.113.22])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 040AD10013C1;
 Wed, 10 Jun 2020 20:07:49 +0000 (UTC)
Subject: Re: [PATCH v8 00/34] Add subcluster allocation to qcow2
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
References: <cover.1591801197.git.berto@igalia.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <5e89c08e-0629-e2dd-b285-d2eb45ea35f8@redhat.com>
Date: Wed, 10 Jun 2020 15:07:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <cover.1591801197.git.berto@igalia.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 23:51:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Derek Su <dereksu@qnap.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/10/20 10:02 AM, Alberto Garcia wrote:
> Hi,
> 
> here's the new version of the patches to add subcluster allocation
> support to qcow2.
> 
> Please refer to the cover letter of the first version for a full
> description of the patches:
> 
>     https://lists.gnu.org/archive/html/qemu-block/2019-10/msg00983.html
> 
> The big change here is that now when an image is preallocated then the
> requested clusters are allocated but the L2 bitmap is left untouched.
> This makes it possible to preallocate an image that has a backing
> file.
> 
> If you want to test this series make sure to apply this patch first:
> 
>     https://lists.gnu.org/archive/html/qemu-block/2020-06/msg00504.html

Let's spell that the way patchew can recognize:
Based-on: <20200610094600.4029-1-berto@igalia.com>

> 
> Berto
> 
> v8:
> - Patch 30: New patch
> - Patch 31: Update test expectations after commit cf2d1203dc
> - Patch 32: New patch
> - Patch 34: New tests, fixes and general refactoring of the code
> 


-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


