Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E60D8C32771
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 19:54:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B080F22525
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 19:54:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZsKi8nwa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B080F22525
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43592 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itd7s-0004Hz-Ri
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 14:54:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38933)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1itd7F-0003ZA-BW
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 14:53:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1itd7E-0006n9-15
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 14:53:41 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:48382
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1itd7D-0006mo-UP
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 14:53:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579550019;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VX9wjso7N7U8LeIgD6dkgcuNDGBqC0JEwEQoGz3MIaM=;
 b=ZsKi8nwaAzzEG5cx251GEYUey5+kL6oP0NB7AnKRwi+4bnjh1xXewuRDM8eQlNU0Ib4+JW
 jnQvLTIztNupdY/m3rgzIQvCIcEwA1a83FNb0v5Gfl4iw3qxbVJU9PUCHq56f3exfGHxuO
 0mgtGILdMW78XwiOFH/IqmC8gEechhY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-313-8J0o4n6xN8aXoTGDHWkedw-1; Mon, 20 Jan 2020 14:53:34 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 02BADDB60;
 Mon, 20 Jan 2020 19:53:33 +0000 (UTC)
Received: from [10.3.117.16] (ovpn-117-16.phx2.redhat.com [10.3.117.16])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CB99260BF4;
 Mon, 20 Jan 2020 19:53:29 +0000 (UTC)
Subject: Re: [PATCH v3 04/10] hbitmap: drop meta bitmaps as they are unused
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
References: <20191219100348.24827-1-vsementsov@virtuozzo.com>
 <20191219100348.24827-5-vsementsov@virtuozzo.com>
 <a42037d5-0d62-d916-a814-ba755b6ad9a4@redhat.com>
 <e6d654fb-7c04-c709-6b2a-3801ae1008d6@virtuozzo.com>
 <0cf94b1f-e7cb-081a-34ab-63a7d9ba80ce@redhat.com>
 <3b4f3ef4-adc7-1fda-44cc-b16b497cb110@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <166c4439-58cb-072b-b3b0-e51d4952673a@redhat.com>
Date: Mon, 20 Jan 2020 13:53:29 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <3b4f3ef4-adc7-1fda-44cc-b16b497cb110@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: 8J0o4n6xN8aXoTGDHWkedw-1
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>,
 "jsnow@redhat.com" <jsnow@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Denis Lunev <den@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/20/20 11:28 AM, Vladimir Sementsov-Ogievskiy wrote:

>>> I'm a bit not follow what you mean. I can just note, that dirty-bitmap.c
>>> part of meta bitmaps was recently removed, and hbitmap.c part I forgot to
>>> remove...
>>
>> Yes, but who used that dirty-bitmap.c interface?  As far as I can tell,
>> nobody.
> 
> Yes, as far as I know, nobody and never.
> 
>>
>>> Meta bitmaps were intended to control live migration of bitmaps and to
>>> implement something like partial sync of bitmaps (write to qcow2 only
>>> changed part of bitmap), but migration implemented in other way
>>> (postcopy) and the second thing was not implemented.
>>
>> OK.  I was wondering why they were implemented without ever having been
>> used (as far as I can tell).
>>
> 
> It was too optimistic preparatory series.

Matches my recollection (we had several ideas about how to tackle it; 
meta-bitmaps was proposed as one idea and this code landed, but we never 
actually finished that idea before a better one was actually coded, so 
this has always been dead code).

> 
> (I can never finally understand, series - who a they or what is it?
>    Plural or singular?

English is funny; "series" is one of the few words that works as both 
singular and plural (another example is "sheep").

> They were too optimistic series? Sounds weird..

My spin: "The original series was too optimistic."

>    And if one series is series, than what about several serieses?
>    OK, let's say, it was too optimistic preparatory patch set :)
> 
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


