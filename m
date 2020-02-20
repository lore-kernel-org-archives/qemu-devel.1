Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9174C11D0C
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 16:49:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8506A20801
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 16:49:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T9AaO51L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8506A20801
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45896 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4p0n-0002st-MC
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 11:49:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33653)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1j4p08-0002PT-KB
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 11:48:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1j4p07-0001i5-Cp
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 11:48:36 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:60166
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1j4p07-0001hq-9E
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 11:48:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582217313;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SAnZAr0WigsBJL5TcioMjE9SddAUeB4U6gqtxuiJk8g=;
 b=T9AaO51L4NujppJygSdrPJLizVYmBUsliN7FeFTlK9K48FXgK4G8vu0R+rMv2R8A/pdn3u
 VQRi2+eCDdbvx2tWFZG98KfTqWWhpbK3NZsdJwB9ENKgBjRkyMkCfNL+OAPKhIA6KkAt99
 LkMPJBVaPiX8hJHLCbY0IsZj4ls88Lo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-337-BHX9Y56MPW6LKPRUQBBQgw-1; Thu, 20 Feb 2020 11:48:29 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6A69E1005516;
 Thu, 20 Feb 2020 16:48:27 +0000 (UTC)
Received: from [10.3.116.180] (ovpn-116-180.phx2.redhat.com [10.3.116.180])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7778489F28;
 Thu, 20 Feb 2020 16:48:26 +0000 (UTC)
Subject: Re: [RFC PATCH v3 07/27] qcow2: Add subcluster-related fields to
 BDRVQcow2State
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
References: <cover.1577014346.git.berto@igalia.com>
 <b04e7e26cea16892a7f209b37d931c489ef17bd9.1577014346.git.berto@igalia.com>
 <bc469fab-244c-6b26-c5b4-55cc42a7d8cc@redhat.com>
 <w51blptb4lc.fsf@maestria.local.igalia.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <1471f80d-b289-713b-2525-29832720087b@redhat.com>
Date: Thu, 20 Feb 2020 10:48:25 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <w51blptb4lc.fsf@maestria.local.igalia.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: BHX9Y56MPW6LKPRUQBBQgw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Kevin Wolf <kwolf@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "Denis V . Lunev" <den@openvz.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/20/20 10:34 AM, Alberto Garcia wrote:
> On Thu 20 Feb 2020 04:28:07 PM CET, Eric Blake wrote:
>>> Images without subclusters are treated as if they had exactly one,
>>> with subcluster_size = cluster_size.
>>
>> The qcow2 spec changes earlier in the series made it sound like your
>> choices are exactly 1 or 32,
> 
>>> +#define QCOW_MAX_SUBCLUSTERS_PER_CLUSTER 32
>>> +
>>
>> ...but this name sounds like other values (2, 4, 8, 16) might be
>> possible?
> 
> I guess I didn't want to call it QCOW_SUBCLUSTERS_PER_CLUSTER because
> there's already BDRVQcow2State.subclusters_per_cluster. And that one can
> have two possible values (1 and 32) so 32 would be the maximum.
> 
> I get your point, however, and I'm open to suggestions.

Maybe QCOW_EXTL2_SUBCLUSTERS_PER_CLUSTER

since it is a hard-coded property of the EXTL2 feature.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


