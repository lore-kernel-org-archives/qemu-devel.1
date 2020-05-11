Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C747C47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 18:35:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 388B6206E6
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 18:35:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SzaExRSD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 388B6206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59100 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYDGq-0006O5-Bh
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 14:35:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44604)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jYDFp-0005Tb-UR
 for qemu-devel@nongnu.org; Mon, 11 May 2020 14:34:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39780
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jYDFp-0004ii-3u
 for qemu-devel@nongnu.org; Mon, 11 May 2020 14:34:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589222056;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MwlzU6xCj13L8bEE7RUzz3/MeSgpo4bI0dEJ6cF8a4c=;
 b=SzaExRSDL+gE59DMilQab15EhpIh48RoElVfN0I5il2MscZxjBk9H+EH3zTlDhj++7pSBI
 eC4IEawV+cPa7umIiDJtS8b4MyLW625/liX2+oS777/KDRho34k1SgzPk+plQPMjXlSf40
 P1t7qKEcB7YTkpGlU8dxyivjiuwGlzY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-248-2gD6wHylNWamZ9V9WFVEiw-1; Mon, 11 May 2020 14:34:12 -0400
X-MC-Unique: 2gD6wHylNWamZ9V9WFVEiw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 96C05835B4A;
 Mon, 11 May 2020 18:34:10 +0000 (UTC)
Received: from [10.3.116.145] (ovpn-116-145.phx2.redhat.com [10.3.116.145])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7C89C64443;
 Mon, 11 May 2020 18:34:02 +0000 (UTC)
Subject: Re: [PATCH v3 05/17] block/io: support int64_t bytes in
 bdrv_co_do_pwrite_zeroes()
To: Alberto Garcia <berto@igalia.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200430111033.29980-1-vsementsov@virtuozzo.com>
 <20200430111033.29980-6-vsementsov@virtuozzo.com>
 <w513686o0gq.fsf@maestria.local.igalia.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <7b5f7192-9a03-da06-1583-039b671c1e81@redhat.com>
Date: Mon, 11 May 2020 13:34:01 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <w513686o0gq.fsf@maestria.local.igalia.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/11 00:05:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: kwolf@redhat.com, fam@euphon.net, integration@gluster.org,
 sheepdog@lists.wpkg.org, pavel.dovgaluk@ispras.ru, dillaman@redhat.com,
 qemu-devel@nongnu.org, sw@weilnetz.de, pl@kamp.de, ronniesahlberg@gmail.com,
 mreitz@redhat.com, den@openvz.org, stefanha@redhat.com, namei.unix@gmail.com,
 pbonzini@redhat.com, jsnow@redhat.com, ari@tuxera.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/11/20 12:17 PM, Alberto Garcia wrote:
> On Thu 30 Apr 2020 01:10:21 PM CEST, Vladimir Sementsov-Ogievskiy wrote:
>>      compute 'int tail' via % 'int alignment' - safe
> 
>      tail = (offset + bytes) % alignment;
> 
> both are int64_t, no chance of overflow here?

Good question - I know several places check that offset+bytes does not 
overflow, but did not specifically audit if this one does.  Adding an 
assert() in this function may be easier than trying to prove all callers 
pass in safe values.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


