Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05E97C4332B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 18:40:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C66B420739
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 18:40:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PUNWPuSW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C66B420739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57660 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFMYr-0008QH-Rk
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 14:40:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46091)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jFMXl-0007af-Il
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 14:38:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jFMXj-0007Yq-Pu
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 14:38:52 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:58787)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jFMXj-0007Yd-HE
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 14:38:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584729530;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J2jbYCYdauWN2Xf5KOvKo5QlHLFGs95eAP3XKdE869w=;
 b=PUNWPuSWWZMf5wJeBk5oExXdR2wpHjIdj4S9fpk5tKrjLEg1YXYporoZz7ObjMPlNrNUJy
 8PozDI6+W48o1lN7MKoz3opBCY+SmWpSpuGtWeOFxL9AqWta5OqnmC4xlAb0+kKYggd0fM
 1Rs6keBJG8yIbskZmSfjkPGl02Or0wo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-214-4L2o98QRMdGtIOaUf2aShg-1; Fri, 20 Mar 2020 14:38:40 -0400
X-MC-Unique: 4L2o98QRMdGtIOaUf2aShg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 30DC6107ACC4;
 Fri, 20 Mar 2020 18:38:39 +0000 (UTC)
Received: from [10.3.112.193] (ovpn-112-193.phx2.redhat.com [10.3.112.193])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8857419756;
 Fri, 20 Mar 2020 18:38:38 +0000 (UTC)
Subject: Re: [Qemu-devel] [PULL 3/4] qcow2: Add list of bitmaps to
 ImageInfoSpecificQCow2
To: Peter Maydell <peter.maydell@linaro.org>
References: <20190211205128.27146-1-eblake@redhat.com>
 <20190211205128.27146-4-eblake@redhat.com>
 <CAFEAcA9wDiKKfL67B7cH1X=Wm_ayDJb6b0L-Pgiqcp2SkDNBAw@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <b902c895-7ba9-9825-69cf-f8277ce26d05@redhat.com>
Date: Fri, 20 Mar 2020 13:38:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9wDiKKfL67B7cH1X=Wm_ayDJb6b0L-Pgiqcp2SkDNBAw@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "open list:qcow2" <qemu-block@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Max Reitz <mreitz@redhat.com>,
 Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/20/20 12:57 PM, Peter Maydell wrote:
> On Mon, 11 Feb 2019 at 20:57, Eric Blake <eblake@redhat.com> wrote:
>>
>> From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
>>
>> In the 'Format specific information' section of the 'qemu-img info'
>> command output, the supplemental information about existing QCOW2
>> bitmaps will be shown, such as a bitmap name, flags and granularity:
> 
> Hi; Coverity has just noticed an issue (CID 1421894) with this change:
> 

>> +        Qcow2BitmapInfoList *bitmaps;
>> +        bitmaps = qcow2_get_bitmap_info_list(bs, &local_err);
>> +        if (local_err) {
>> +            error_propagate(errp, local_err);
>> +            qapi_free_ImageInfoSpecific(spec_info);
>> +            return NULL;
> 
> If we take this error-exit codepath, then we never free the
> memory allocated by the earlier call to qcrypto_block_get_info().

Fix sent.

Hmm - it would be nice if the QAPI generator could declare all QAPI 
types as g_autoptr compatible, so we could simplify our cleanup paths to 
not have to worry about calling qapi_free_FOO() on all paths.  But while 
the memory leak fix is a one-liner safe for 5.0, switching to g_autoptr 
is a bigger task that would be 5.1 material.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


