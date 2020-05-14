Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B96D3C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 18:30:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7ACDC2054F
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 18:30:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BkePE7xF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7ACDC2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33508 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZIcb-00012A-Nb
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 14:30:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48870)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jZIbi-0007gM-17
 for qemu-devel@nongnu.org; Thu, 14 May 2020 14:29:22 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:33200
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jZIbg-0002zX-Ij
 for qemu-devel@nongnu.org; Thu, 14 May 2020 14:29:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589480959;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+N9CjBMLLoI9lVw+zuDUt4jjNlaG7QZ55QrLColBzTY=;
 b=BkePE7xFbKwXurcYTPiUJxv55H0uh8MngCDEWtVCeau926Vvje0um/Ue0ORChPTRPX9QaB
 DtK+rrmOEa0pQb6+0NTlOhaM3ZWKbgULkR3O+7Ad974J1fpRT4JdfjFXG4UdbV4kEiNrlr
 L6JsDxYfwQhjpK2Jn58t57sgin43Etk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-210-mVjo3tVcObi9OtDSGo-gsw-1; Thu, 14 May 2020 14:29:13 -0400
X-MC-Unique: mVjo3tVcObi9OtDSGo-gsw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 07353107ACF9;
 Thu, 14 May 2020 18:29:12 +0000 (UTC)
Received: from [10.3.116.145] (ovpn-116-145.phx2.redhat.com [10.3.116.145])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 164BF2E170;
 Thu, 14 May 2020 18:29:11 +0000 (UTC)
Subject: Re: [PATCH v2 0/5] fix migration with bitmaps and mirror
To: Peter Krempa <pkrempa@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
References: <20191219085106.22309-1-vsementsov@virtuozzo.com>
 <20191219103638.GJ4914@andariel.pipo.sk>
 <a5015250-46f4-c6ed-92b9-779f885e8a4a@virtuozzo.com>
 <20200403112358.GV578401@andariel.pipo.sk>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <c25fb60b-9072-294f-847b-9b650292171b@redhat.com>
Date: Thu, 14 May 2020 13:29:10 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200403112358.GV578401@andariel.pipo.sk>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/14 11:41:05
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
Cc: fam@euphon.net, kwolf@redhat.com, qemu-block@nongnu.org,
 quintela@redhat.com, qemu-devel@nongnu.org, dgilbert@redhat.com,
 stefanha@redhat.com, den@openvz.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

reviving this thread...

On 4/3/20 6:23 AM, Peter Krempa wrote:
> On Fri, Apr 03, 2020 at 14:02:47 +0300, Vladimir Sementsov-Ogievskiy wrote:
>> 19.12.2019 13:36, Peter Krempa wrote:
>>> On Thu, Dec 19, 2019 at 11:51:01 +0300, Vladimir Sementsov-Ogievskiy wrote:
>>>> Hi all!
>>>>
>>>> It's a continuation for
>>>> "bitmap migration bug with -drive while block mirror runs"
>>>> <315cff78-dcdb-a3ce-2742-da3cc9f0ca97@redhat.com>
>>>> https://lists.gnu.org/archive/html/qemu-devel/2019-09/msg07241.html
>>>>
>>>> The problem is that bitmaps migrated to node with same node-name or
>>>> blk-parent name. And currently only the latter actually work in libvirt.
>>>> And with mirror-top filter it doesn't work, because
>>>> bdrv_get_device_or_node_name don't go through filters.
>>>
>>> I want to point out that since libvirt-5.10 we use -blockdev to
>>> configure the backend of storage devices with qemu-4.2 and later. This
>>> means unfortunately that the BlockBackend of the drive does not have a
>>> name any more and thus the above will not work even if you make the
>>> lookup code to see through filters.
>>
>> Not that this series doesn't make things worse, as it loops through named
>> block backends when trying to use their name for migration. So with these
>> patches applied, qemu will just work in more possible scenarios.
> 
> Okay, if that's so it's fair enough in this case.
> 
> I'm just very firmly against baking in the assumption that
> node names mean the same thing accross migration, because that will
> create a precedent situation and more stuff may be baked in on top of
> this in the future. It seems that it has already happened though and
> it's wrong. And the worst part is that it's never mentioned that this
> might occur. But again, don't do that and preferrably remove the
> matching of node names for bitmaps altogether until we can control it
> arbitrarily.
> 
> We've also seen this already before with the backend name of memory
> devices being baked in to the migration stream which creates an unwanted
> dependancy.

Max is trying to tackle the node-name issue:
https://lists.gnu.org/archive/html/qemu-devel/2020-05/msg03358.html

And trying to apply that patch after staging this series hits a conflict 
in mnigration/block-dirty-bitmap.c.  Which one should go in first?

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


