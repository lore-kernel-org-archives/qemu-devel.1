Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 610A5CA90AF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 14:20:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BBD5204EA
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 14:20:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ig97InbE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BBD5204EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58478 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYsEx-00049v-8c
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 10:20:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53894)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jYsDB-0000qO-Rz
 for qemu-devel@nongnu.org; Wed, 13 May 2020 10:18:17 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:55085
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jYsDB-0006wj-2x
 for qemu-devel@nongnu.org; Wed, 13 May 2020 10:18:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589379496;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gXGdSORgwy0YhV9ke/TpJnkGKmr4elIO9TcGH0MaN7M=;
 b=ig97InbEE84S9f38oPi9L0HU3szmhPyYSiBTZQ3RYjkLXcpnm/0kD+nqxzYo3AgNl3GWmj
 Nu0VdG81GS2lV2ui0SoCRe/Dnas3JEvF2OWO09fADV4S9oEmXWtza3NpbUyPlsxNXTb50T
 mWC6/CK/OrVIG7I65KI+ZujBoitKajE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-459-XdHzdVXdP5CQoY9a-lV-Kg-1; Wed, 13 May 2020 10:18:12 -0400
X-MC-Unique: XdHzdVXdP5CQoY9a-lV-Kg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 69FFF18FF66C;
 Wed, 13 May 2020 14:18:11 +0000 (UTC)
Received: from [10.3.116.145] (ovpn-116-145.phx2.redhat.com [10.3.116.145])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 62EEF619B1;
 Wed, 13 May 2020 14:18:05 +0000 (UTC)
Subject: Re: [PATCH 0/5] Introduce 'yank' oob qmp command to recover from
 hanging qemu
To: Kevin Wolf <kwolf@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
References: <20200511121714.GL1135885@redhat.com>
 <20200511154645.GI2811@work-vm> <20200512113206.62836e44@luklap>
 <20200512094337.GK1191162@redhat.com> <20200513103245.GD6202@linux.fritz.box>
 <20200513105359.GF3225@work-vm> <20200513111320.GE6202@linux.fritz.box>
 <20200513125624.GJ3225@work-vm> <20200513130849.GD1253949@redhat.com>
 <20200513134856.GK3225@work-vm> <20200513140650.GH6202@linux.fritz.box>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <e96cb70a-8156-55bb-44d7-81772bb77b4b@redhat.com>
Date: Wed, 13 May 2020 09:18:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200513140650.GH6202@linux.fritz.box>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 04:17:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: Lukas Straub <lukasstraub2@web.de>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-block <qemu-block@nongnu.org>, Juan Quintela <quintela@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/13/20 9:06 AM, Kevin Wolf wrote:

>>>>> One more thing to consider is, what if a single object has multiple
>>>>> connections? In the case of node-names, we have a limited set of allowed
>>>>> characters, so we can use one of the remaining characters as a separator
>>>>> and then suffix a counter. In other places, the identifier isn't
>>>>> restricted, so suffixing doesn't work. Maybe prefixing does, but it
>>>>> would have to be there from the beginning then.
>>>>
>>>> Yeh I worry about whether on nbd if you can have multiple nbd
>>>> connections to one block device.
>>>
>>> The kernel NBD driver now supports multiple parallel connections.
>>> QEMU hasn't implemented this in its NBD code yet, but I certainly
>>> see that being in scope for future.
>>
>> It's not parallel for performance that worries me, it's more about
>> separateq connections for separate uses - e.g. if we're serving the same
>> read-only disk to multiple separate things.
> 
> That would be a concern for the NBD server. I'm not sure if anything in
> QEMU ever waits for NBD servers (except for the client on the other side
> of the connection, of course), so there might be no use case for yanking
> their connections.
> 
> Anyway, here we were talking about the NBD client, which always accesses
> one disk. If you access a second disk, you have a second NBD block node.

Ah, right, that's the other direction.  No, we do not currently support 
a single qemu block node backed by multiple NBD clients to one (or more, 
if they are serving identical content in a failover scenario) NBD 
servers.  Performance could indeed be potentially improved by doing 
that, but for now, every time qemu behaves as a new NBD client, it is 
via an additional block node.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


