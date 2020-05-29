Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B964C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 15:14:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A682206A4
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 15:14:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f7j9/6lJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A682206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48576 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jegio-0005sL-7z
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 11:14:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43980)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jeghj-0004pb-Ee
 for qemu-devel@nongnu.org; Fri, 29 May 2020 11:13:51 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:45442
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jeghi-0003sX-1j
 for qemu-devel@nongnu.org; Fri, 29 May 2020 11:13:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590765228;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LJmqZAdt6Y9UUl9i4xGRAfQ693UchT1RYX7j/tNNsgc=;
 b=f7j9/6lJGAMjPu15qxh3NRMuVCUJzrmK5e/yV3XhIYXixkcE/RKlc23k4SLAX1cYULYwII
 8BjgBg45AP6gua/e+5PJjmGP3Re7LSj6/LRN+O4p70Ya6kIdensAj0B/9MMTxwdPBfcLFw
 Q6aiTckLg3zX0/jYYS7VDfN6oAnC4Bw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-399-_UnNlZZ6PkCBaPXBIPvbXw-1; Fri, 29 May 2020 11:13:41 -0400
X-MC-Unique: _UnNlZZ6PkCBaPXBIPvbXw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9792219057A4;
 Fri, 29 May 2020 15:13:39 +0000 (UTC)
Received: from [10.3.112.88] (ovpn-112-88.phx2.redhat.com [10.3.112.88])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D3CA57A8BA;
 Fri, 29 May 2020 15:13:38 +0000 (UTC)
Subject: Re: [PATCH v7 32/32] iotests: Add tests for qcow2 images with
 extended L2 entries
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
References: <cover.1590429901.git.berto@igalia.com>
 <117ba99f5a1fbea62cfed60fe74a460cc628948f.1590429902.git.berto@igalia.com>
 <c2bb44f3-bb7e-7bb0-dbbf-ef1d3273802d@redhat.com>
 <w51v9kevkyu.fsf@maestria.local.igalia.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <6f702f6f-ba17-0a09-29e0-3b77cef5ff6e@redhat.com>
Date: Fri, 29 May 2020 10:13:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <w51v9kevkyu.fsf@maestria.local.igalia.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/29 01:27:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Derek Su <dereksu@qnap.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/29/20 10:07 AM, Alberto Garcia wrote:
> On Wed 27 May 2020 08:30:06 PM CEST, Eric Blake wrote:
>>> +    offset=$(($offset + 8))
>>> +    bitmap=`peek_file_be "$TEST_IMG" $offset 8`
>>> +
>>> +    expected_bitmap=0
>>> +    for bit in $expected_alloc; do
>>> +        expected_bitmap=$(($expected_bitmap | (1 << $bit)))
>>> +    done
>>> +    for bit in $expected_zero; do
>>> +        expected_bitmap=$(($expected_bitmap | (1 << (32 + $bit))))
>>> +    done
>>> +    expected_bitmap=`printf "%llu" $expected_bitmap`
>>
>> Dead statement - expected_bitmap is already a 64-bit decimal number
>> without reprinting it to itself.
> 
> Not quite... it seems that simply expanding the variable treats the
> value as signed so echo $((1 << 63)) returns INT64_MIN. The printf call
> makes it unsigned,

Ah, yes, then that makes sense.  Still, you could shave a fork or 
comment the action by doing:

printf -v expected_bitmap %llu $expected_bitmap # convert to unsigned

> but even though I tried that in a 32-bit system and
> it works now I'm actually wondering about the portability of the whole
> thing.

Bash supports 64-bit numbers even on 32-bit platforms, and has done for 
years.  Since we are running the test only under bash, that's all the 
more we have to worry about.

> 
> Looking at the source it seems that bash uses intmax_t:
> 
>     https://git.savannah.gnu.org/cgit/bash.git/tree/variables.h?h=bash-5.0#n68
> 
> But if this is a problem then peek_file_* would also be affected, it
> also uses printf %llu and a few iotests are already reading 64bit values
> (grep 'peek_file_.* 8').

In cases where a negative number is read but the 64-bit pattern is the 
same, it doesn't matter; but here, you are using it for output, and so 
you do want the unsigned representation instead of bash's default signed 
representation.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


