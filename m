Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C3C3C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 20:00:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E3BD206A5
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 20:00:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q7cWA1ko"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E3BD206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVhFx-0004B9-8S
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 16:00:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52036)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jVhFN-0003hG-DT
 for qemu-devel@nongnu.org; Mon, 04 May 2020 15:59:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20882
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jVhFM-00089i-Il
 for qemu-devel@nongnu.org; Mon, 04 May 2020 15:59:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588622363;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EdMnj4h07MrJGAN47ujqqZbpQ3tdzfadMfzAgedyUik=;
 b=Q7cWA1kovYD/3q0quzqu3SBS83qiYQls5Z628pM75T1mX6cdrOLXoUI9HzOO1Upnipqs37
 bAH3EiEKNOuJNwiuBuP/9ANsXXpDQki/fUrJejs7+FdUTaiOY85xTxlwGvIkq6Vl3+K+Kr
 jiud0EW6SmkVS7CGz2VNx93ssBhgQzA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-514-JSznQM_BPjqXeVrLSU_-8g-1; Mon, 04 May 2020 15:59:12 -0400
X-MC-Unique: JSznQM_BPjqXeVrLSU_-8g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 157B6EC1A3;
 Mon,  4 May 2020 19:59:11 +0000 (UTC)
Received: from [10.3.114.73] (ovpn-114-73.phx2.redhat.com [10.3.114.73])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 476AA63F89;
 Mon,  4 May 2020 19:59:06 +0000 (UTC)
Subject: Re: [PATCH v2 2/6] block/nbd-client: drop max_block restriction from
 discard
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200401150112.9557-1-vsementsov@virtuozzo.com>
 <20200401150112.9557-3-vsementsov@virtuozzo.com>
 <e3253b06-4bff-970d-9b9b-32da6bf652b8@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <ffae80d5-0302-f719-8934-21bb4a7eacca@redhat.com>
Date: Mon, 4 May 2020 14:59:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <e3253b06-4bff-970d-9b9b-32da6bf652b8@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 04:24:57
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
Cc: kwolf@redhat.com, fam@euphon.net, qemu-devel@nongnu.org, mreitz@redhat.com,
 stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/21/20 4:56 PM, Eric Blake wrote:
> On 4/1/20 10:01 AM, Vladimir Sementsov-Ogievskiy wrote:
>> NBD spec is updated, so that max_block doesn't relate to
>> NBD_CMD_TRIM. So, drop the restriction.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>> =A0 block/nbd.c | 2 +-
>> =A0 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> Reviewed-by: Eric Blake <eblake@redhat.com>
>=20
> I might tweak the commit message of 1/6 and here to call out the NBD=20
> spec commit id (nbd.git 9f30fedb), but that doesn't change the patch=20
> proper.

I'm queuing 1 and 2 through my NBD tree now; the rest involve more of=20
the block layer and go in tandem with your other work on cleaning up=20
64-bit operations throughout, and I still need to give that a better review=
.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


