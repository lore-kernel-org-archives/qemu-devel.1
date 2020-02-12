Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41108C2BA83
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 12:11:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08AA920714
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 12:11:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gdd1ryeK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08AA920714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36586 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1qrZ-0004jA-8Q
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 07:11:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53398)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1j1qqj-0003nX-Ru
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 07:10:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1j1qqi-0000qG-Q4
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 07:10:37 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23498
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1j1qqi-0000pK-N8
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 07:10:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581509435;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tLV24/2UEf0YcaZFpJzK+2j4vH7zIuaX96zqIER5Ef0=;
 b=gdd1ryeKnDg9usUZTryAN6nwxPDynjkL1X+ogmnsgcAWhXgmfwXBtAd3SQGh0ZIf2P5Cur
 gcy9mi7tZVhWWzXif0vppoLDAv+Mr8cUl3wMivZ+GgtJO0y5wpZxSLDeivCOz/+FesUHcf
 /e6n8+SkCs9hQ8SKuQ1s4Op8yGLnumE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-397-_Ge6vZ8SNmuaHx56YKYeiA-1; Wed, 12 Feb 2020 07:10:32 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C2238CF989;
 Wed, 12 Feb 2020 12:10:30 +0000 (UTC)
Received: from [10.3.116.180] (ovpn-116-180.phx2.redhat.com [10.3.116.180])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4FBBC89E6F;
 Wed, 12 Feb 2020 12:10:30 +0000 (UTC)
Subject: Re: [PATCH] nbd: Fix regression with multiple meta contexts
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
References: <20200206173832.130004-1-eblake@redhat.com>
 <f498beb4-dfd0-a7dc-33f8-5c62d3738c1b@vivier.eu>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <3a92e3c5-0506-6970-098b-019f9752dcc1@redhat.com>
Date: Wed, 12 Feb 2020 06:10:29 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <f498beb4-dfd0-a7dc-33f8-5c62d3738c1b@vivier.eu>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: _Ge6vZ8SNmuaHx56YKYeiA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: qemu-trivial@nongnu.org, pannengyuan@huawei.com, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/12/20 3:24 AM, Laurent Vivier wrote:
> Le 06/02/2020 =C3=A0 18:38, Eric Blake a =C3=A9crit=C2=A0:
>> Detected by a hang in the libnbd testsuite.  If a client requests
>> multiple meta contexts (both base:allocation and qemu:dirty-bitmap:x)
>> at the same time, our attempt to silence a false-positive warning
>> about a potential uninitialized variable introduced botched logic: we
>> were short-circuiting the second context, and never sending the
>> NBD_REPLY_FLAG_DONE.  Combining two 'if' into one 'if/else' in
>> bdf200a55 was wrong (I'm a bit embarrassed that such a change was my
>> initial suggestion after the v1 patch, then I did not review the v2
>> patch that actually got committed). Revert that, and instead silence
>> the false positive warning by replacing 'return ret' with 'return 0'
>> (the value it always has at that point in the code, even though it
>> eluded the deduction abilities of the robot that reported the false
>> positive).
>>
>> Fixes: bdf200a5535
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>> ---
>>
>> It's never fun when a regression is caused by a patch taken through
>> qemu-trivial, proving that the patch was not trivial after all.
>=20
> Do you want this one be merged using the trivial branch?

Up to you; I'm also fine taking it through my NBD tree as I have a few=20
other NBD patches landing soon.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


