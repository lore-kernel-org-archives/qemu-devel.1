Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63128C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 17:52:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34984206D8
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 17:52:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YkCNKdm1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34984206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40550 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZeVR-0007ZZ-BC
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 13:52:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48266)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jZeUf-0006dY-Kx
 for qemu-devel@nongnu.org; Fri, 15 May 2020 13:51:33 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21090
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jZeUe-0007ul-V1
 for qemu-devel@nongnu.org; Fri, 15 May 2020 13:51:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589565092;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=geh9uD9wS6WIiJl/ZAJXka1NMUWOLj7YSfxNLu3JX3E=;
 b=YkCNKdm1u1XYOAt6pGMlR4JCoK7g3hVhL+nAoZjnsMlBthIIA2j7UC9RlnN8nPxoca8iFm
 Tcu2BbaAP5UJwzg+E7/UM+EDNnWVyUWKWOi7shV3ssSQMH2STw5Fzq5voiyfjQLbiZUw1E
 VBDxD/TcziZJX72p/qcsIh/zCAi5rrA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-285-QE8fN7YeMlecd-P-O5Tfqw-1; Fri, 15 May 2020 13:51:14 -0400
X-MC-Unique: QE8fN7YeMlecd-P-O5Tfqw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A54A2100A8EE;
 Fri, 15 May 2020 17:51:13 +0000 (UTC)
Received: from [10.3.114.84] (ovpn-114-84.phx2.redhat.com [10.3.114.84])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C23496E9E2;
 Fri, 15 May 2020 17:51:09 +0000 (UTC)
Subject: Re: [PATCH v2 0/5] fix migration with bitmaps and mirror
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Peter Krempa <pkrempa@redhat.com>
References: <20191219085106.22309-1-vsementsov@virtuozzo.com>
 <20191219103638.GJ4914@andariel.pipo.sk>
 <a5015250-46f4-c6ed-92b9-779f885e8a4a@virtuozzo.com>
 <20200403112358.GV578401@andariel.pipo.sk>
 <c25fb60b-9072-294f-847b-9b650292171b@redhat.com>
 <738cbfd7-9ec8-7043-923a-0510929e73e2@virtuozzo.com>
 <acecd801-9486-6dea-d06c-19b7ce6d77b3@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <5dfecf7a-0da8-d9da-dc7f-cd684710353b@redhat.com>
Date: Fri, 15 May 2020 12:51:09 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <acecd801-9486-6dea-d06c-19b7ce6d77b3@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/14 22:56:02
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
Cc: fam@euphon.net, kwolf@redhat.com, qemu-block@nongnu.org,
 quintela@redhat.com, qemu-devel@nongnu.org, dgilbert@redhat.com,
 stefanha@redhat.com, den@openvz.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/15/20 6:15 AM, Vladimir Sementsov-Ogievskiy wrote:

>>> Max is trying to tackle the node-name issue:
>>> https://lists.gnu.org/archive/html/qemu-devel/2020-05/msg03358.html
>>>
>>> And trying to apply that patch after staging this series hits a 
>>> conflict in mnigration/block-dirty-bitmap.c.  Which one should go in 
>>> first?
>>>
>>
>> My patches are needed to fix migration for the pre-blockdev 
>> configuration with mirror-top filter.
>>
>> We ofcrouse need them in Virtuozzo, but it's not hard to keep the in 
>> downstream-only.. And it will be not simple to use new command from 
>> Max in pre-blockdev libvirt configuration, with auto-generated 
>> node-names.

Carrying a downstream fork forever is more work on you.  If the patch is 
easy enough to maintain, incorporating it upstream is best all around, 
even if libvirt has moved on to the point of no longer caring since it 
no longer uses pre-blockdev.

>>
>> How much we care about pre-blockdev libvirt now in upstream Qemu?
>>
>> If we don't care, than these series are only for downstreams, and we 
>> don't need to apply them upstream..

Eventually, we may want to deprecate pre-blockdev, but I don't think we 
are there yet, and even when it does happen, it will be two more 
releases with it being deprecated before it is gone, so we might as well 
make it work correctly in the meantime.

>>
>> On the other hand, Max have to resend anyway, to handle old code, 
>> which uses device name instead of node-name. And if we don't want to 
>> drop now the code which can use device name (needed for old libvirt), 
>> why not to apply the series, which just make old code better?
>>
>> ====
>>
>> In other words: do we still support pre-blockdev libvirt (and any 
>> other pre-blockdev users)?
>>
>> If we support, than, as I said somewhere, I need to resend these 
>> series as I have updated version in our downstream. And I think, I can 
>> rebase Max's patch by myself and send together with this all, if no 
>> objections.
>>
> 
> I'm going to resend the series today, let's look at it.
> 

Sounds reasonable.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


