Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2E96C34047
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 13:37:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D98A20801
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 13:37:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UGOSGM/e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D98A20801
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4PXQ-00052s-Mh
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 08:37:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40337)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1j4PWo-0004Hd-6o
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 08:36:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1j4PWn-00025Y-2j
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 08:36:38 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:25078
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1j4PWm-00025A-UB
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 08:36:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582119396;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=35605hvCqFOb0sXOAmr/SzpwnKw4GdCFhnUiMZbLPZM=;
 b=UGOSGM/eRPCZyLrdjcj5U/1yElXyPljETF0JrCV4ldXU9IWZDcR3BHIzWw5/bFDDG1UHkn
 FYjc7Nu2c3g/F/Lxbd4aFxTRA+bJzmjxQGYAgeAw5MEDV6v4cgCpARi3bs+IqNassmojoA
 XMM63DpYZwudcB0tO1Jj+sl6ZV7WMM8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-361-ih6DST4fPhKU1zArX1F8zg-1; Wed, 19 Feb 2020 08:36:28 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 48B24107B270;
 Wed, 19 Feb 2020 13:36:27 +0000 (UTC)
Received: from [10.3.116.180] (ovpn-116-180.phx2.redhat.com [10.3.116.180])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 51DC38ED01;
 Wed, 19 Feb 2020 13:36:23 +0000 (UTC)
Subject: Re: [PATCH v2 00/22] Fix error handling during bitmap postcopy
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
References: <20200217150246.29180-1-vsementsov@virtuozzo.com>
 <33fa0ba7-714f-c78d-8ca5-1e15dcef5ac4@virtuozzo.com>
 <f44bfdb9-0ddc-3b1a-0279-7e9ebd9f399f@redhat.com>
 <b0e67ac9-987b-811e-f0ac-7a9c92a2771a@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <633ea62c-dad6-9cd6-1490-7a827f036417@redhat.com>
Date: Wed, 19 Feb 2020 07:36:22 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <b0e67ac9-987b-811e-f0ac-7a9c92a2771a@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: ih6DST4fPhKU1zArX1F8zg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 quintela@redhat.com, qemu-stable@nongnu.org, dgilbert@redhat.com,
 Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/19/20 7:25 AM, Andrey Shinkevich wrote:
> 
> 
> On 18/02/2020 23:57, Eric Blake wrote:
>> On 2/18/20 2:02 PM, Andrey Shinkevich wrote:
>>> qemu-iotests:$ ./check -qcow2
>>> PASSED
>>> (except always failed 261 and 272)
>>
>> Have you reported those failures on the threads that introduced those 
>> tests?
>>
> 
> Not yet unfortunately. I have not investigated the case.
> "$ ./check -qcow2 261" dumps
> 
> +od: unrecognized option '--endian=big'
> +Try 'od --help' for more information.
> +od: invalid -N argument '--endian=big'
> +qemu-img: Could not open 'TEST_DIR/t.IMGFMT': IMGFMT header exceeds 
> cluster size

Which version of od are you using?  I do recall wondering whether 
reliance on the GNU coreutils extension --endian=big was going to cause 
problems later - well, here we are, it's later :)

https://lists.gnu.org/archive/html/qemu-devel/2019-07/msg06781.html

> 
> and "$ ./check -qcow2 272" dumps
> 
> +od: unrecognized option '--endian=big'
> +Try 'od --help' for more information.
> +od: invalid -N argument '--endian=big'

Yay, same problem for both tests.  Fix common.rc once, and both tests 
should start working for you.

> +qemu-io: can't open device .../qemu/tests/qemu-iotests/scratch/t.qcow2: 
> Image is not in qcow2 format
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


