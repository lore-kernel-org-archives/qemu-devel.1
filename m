Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BA19C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 21:03:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE8612078B
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 21:03:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D+4UA/yr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE8612078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47498 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbsLe-0001uL-0E
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 17:03:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49254)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jbsKj-00015J-Ha
 for qemu-devel@nongnu.org; Thu, 21 May 2020 17:02:29 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35361
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jbsKi-0003vy-9B
 for qemu-devel@nongnu.org; Thu, 21 May 2020 17:02:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590094947;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9W39yA5woSudHcx12vLNAWYFrhRLbtsXUB4K1sSXUH0=;
 b=D+4UA/yrILntWm1fBzmu0Y9TJcAVfVZcIPCkvqSyL4ZWuTaZqEZ/qfqROcwlZZskipgVxK
 9vaFljsI6H07GLNXfS+FMlL4excESIfsSDKtKveiyQ3iMeBOgKZeZdAFifQtYbK/4+3lSn
 g2o9TTSgzZH894wbC0BI5Vd3P1CY9GU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-137-Mv14D2N1MnaVWKTbUpn5iw-1; Thu, 21 May 2020 17:02:06 -0400
X-MC-Unique: Mv14D2N1MnaVWKTbUpn5iw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0368D107BEF9;
 Thu, 21 May 2020 21:02:05 +0000 (UTC)
Received: from [10.3.112.88] (ovpn-112-88.phx2.redhat.com [10.3.112.88])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D685D776F1;
 Thu, 21 May 2020 21:02:00 +0000 (UTC)
Subject: Re: [PATCH v3 4/7] migration/block-dirty-bitmap: fix bitmaps
 pre-blockdev migration during mirror job
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200515124024.3491-1-vsementsov@virtuozzo.com>
 <20200515124024.3491-5-vsementsov@virtuozzo.com>
 <5cd24411-55bf-92c9-b5fe-2030c2915d1a@redhat.com>
 <7dd23a01-96e7-b3c0-27b5-8c4b176a52d7@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <8574aab5-aec4-a638-3579-0857f62beaca@redhat.com>
Date: Thu, 21 May 2020 16:01:59 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <7dd23a01-96e7-b3c0-27b5-8c4b176a52d7@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/21 01:44:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: kwolf@redhat.com, fam@euphon.net, pavel.dovgaluk@ispras.ru,
 quintela@redhat.com, qemu-devel@nongnu.org, dgilbert@redhat.com,
 mreitz@redhat.com, stefanha@redhat.com, den@openvz.org, pbonzini@redhat.com,
 jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/19/20 5:51 AM, Vladimir Sementsov-Ogievskiy wrote:
> 18.05.2020 23:36, Eric Blake wrote:
>> On 5/15/20 7:40 AM, Vladimir Sementsov-Ogievskiy wrote:
>>> Important thing for bitmap migration is to select destination block
>>> node to obtain the migrated bitmap.
>>>

>>> +        /* Skip filters without bitmaos */
>>> +        while (bs && bs->drv && bs->drv->is_filter &&
>>> +               !bdrv_has_named_bitmaps(bs))
>>> +        {
>>> +            bs = bs->backing->bs ?: bs->file->bs;
>>
>> Is this correct, or should it be:
>>
>> bs = bs->backing ? bs->backing->bs : bs->file->bs;
> 
> Hmm, yes, otherwise it should crash on file-based filter :)
> 
>>
>> Otherwise looks reasonable, but I'm hesitant to include it in today's 
>> bitmap pull request in order to give it more review/testing time.  It 
>> should be ready for a pull request next week, though.

Can you post a v4, to make it easier for me to build?

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


