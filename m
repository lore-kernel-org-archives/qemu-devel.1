Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFBF7C433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 21:47:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE42520791
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 21:47:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MXAGf38u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE42520791
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46436 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUd04-0000As-LC
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 17:47:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48256)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kUcyZ-0007w1-Sb
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 17:45:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:45151)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kUcyU-0004nT-0r
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 17:45:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603143946;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yx0ifzoiBNXirQFyYRoFmZyz5bk6a2wNJc2ttyCPQT8=;
 b=MXAGf38ufLYwPaoj9xwqqAyHvjkWIREqY78Qvzm7QnswJ0TXONScihv6NwCy8sqmdXWL13
 nAWs89h6eDRAl6Am6PVrxjY+bDILB4SuFhLACSXujdItOkK672AojS+EotTs/s8XZ+OdgL
 HeI2CIwtoMP4R62GKs/tURUVj9vgoho=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-32-GaeU-PNKPsuv_crDpDsHuA-1; Mon, 19 Oct 2020 17:45:42 -0400
X-MC-Unique: GaeU-PNKPsuv_crDpDsHuA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 426A11084D62;
 Mon, 19 Oct 2020 21:45:41 +0000 (UTC)
Received: from [10.3.112.28] (ovpn-112-28.phx2.redhat.com [10.3.112.28])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 411015C1A3;
 Mon, 19 Oct 2020 21:45:37 +0000 (UTC)
Subject: Re: [PATCH v4 4/7] nbd: Update qapi to support exporting multiple
 bitmaps
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
References: <20201009215533.1194742-1-eblake@redhat.com>
 <20201009215533.1194742-5-eblake@redhat.com>
 <6ee3ac4f-65c3-fdfd-9adb-9bea5f5739e3@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <56b413b5-2213-1b4e-5cac-865d8f0e0689@redhat.com>
Date: Mon, 19 Oct 2020 16:45:36 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <6ee3ac4f-65c3-fdfd-9adb-9bea5f5739e3@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/19 02:32:01
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, rjones@redhat.com, stefanha@redhat.com,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/14/20 7:15 AM, Vladimir Sementsov-Ogievskiy wrote:
> 10.10.2020 00:55, Eric Blake wrote:
>> Since 'nbd-server-add' is deprecated, and 'block-export-add' is new to
>> 5.2, we can still tweak the interface.  Allowing 'bitmaps':['str'] is
>> nicer than 'bitmap':'str'.  This wires up the qapi and qemu-nbd
>> changes to permit passing multiple bitmaps as distinct metadata
>> contexts that the NBD client may request, but the actual support for
>> more than one will require a further patch to the server.
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>> ---
> 
> [..]
> 
>>               break;
>>           case 'B':
>> -            bitmap = optarg;
>> +            tmp = g_new(strList, 1);
>> +            tmp->value = g_strdup(optarg);
>> +            tmp->next = bitmaps;
>> +            bitmaps = tmp;
> 
> If publish QAPI_LIST_ADD, defined in block.c, it would look like:
> 
>      QAPI_LIST_ADD(bitmaps, g_strdup(optarg));

#define QAPI_LIST_ADD(list, element) do { \
     typeof(list) _tmp = g_new(typeof(*(list)), 1); \
     _tmp->value = (element); \
     _tmp->next = (list); \
     (list) = _tmp; \
} while (0)


Markus, thoughts on if we should publish this macro, and if so, which 
header would be best?


> 
> anyway:
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


