Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4D9EC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 13:30:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65391206BE
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 13:30:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q8pR07BM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65391206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jblHK-0002m6-Ko
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 09:30:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55676)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jblGQ-00023j-87
 for qemu-devel@nongnu.org; Thu, 21 May 2020 09:29:34 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:50342
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jblGP-0004S7-8w
 for qemu-devel@nongnu.org; Thu, 21 May 2020 09:29:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590067771;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I+bmoK/QqWbo14nOG3+nceW4gvPm/gJnulwKZ5ouUu0=;
 b=Q8pR07BMJUthdJdre4cRPPsO0OAU4qM4O9cVRjmhkuyuNXLKe+Yy2ekl/ChFW4VlgNnnlY
 WoFhHH9nZTu+Fgm0JZLhBZ2KtK3MSWK0beB1cenzUZMrmfXj7ZEnO1A5c7l2GLLhgQ0Pls
 RdN7WiJnqdqz4vYJt2YSLs4mcNpkW0A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-294-7wjhSNxnMs6g_Ekhn_ziLg-1; Thu, 21 May 2020 09:29:30 -0400
X-MC-Unique: 7wjhSNxnMs6g_Ekhn_ziLg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 08DB31853C61;
 Thu, 21 May 2020 13:29:29 +0000 (UTC)
Received: from [10.3.112.88] (ovpn-112-88.phx2.redhat.com [10.3.112.88])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 62E245EE0E;
 Thu, 21 May 2020 13:29:28 +0000 (UTC)
Subject: Re: [PATCH v5 2/5] qcow2: Expose bitmaps' size during measure
To: Nir Soffer <nsoffer@redhat.com>
References: <20200520220118.1037094-1-eblake@redhat.com>
 <20200520220118.1037094-3-eblake@redhat.com>
 <CAMRbyytCZ5KuqPLXkv_kw1Fbgw-w05s0iApmhP69ev_q3VjOnA@mail.gmail.com>
 <69fec648-ec51-6a0d-1703-4017db901119@redhat.com>
 <CAMRbyyu5v_RverJzkNVfV56VViKVyUE=STVyz=--EfVG-bo74A@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <f6663977-69c6-eaaf-ef6b-042e6245cf9a@redhat.com>
Date: Thu, 21 May 2020 08:29:27 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAMRbyyu5v_RverJzkNVfV56VViKVyUE=STVyz=--EfVG-bo74A@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/21 01:47:40
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block <qemu-block@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/21/20 8:17 AM, Nir Soffer wrote:

>>> I'm ok with both options, can we have only one?
>>
>> That was the crux of the conversation after v3, where we were trying to
>> figure out what interface you actually needed.  I implemented both to
>> show the difference, but if you want only one, then my preference is to
>> delete the --bitmaps option and only expose the optional 'bitmaps size'
>> field in all cases where bitmaps can be copied.
> 
> I'm fine with this approach - but the bitmaps optional field should be displayed
> even if there are no bitmaps in the source, so I can tell if tihs
> version of qemu-img
> supports measuring/copying bitmaps.

The optional field appears when both source and destination have 
bitmaps.  That is, the field is present in all cases in which 'qemu-img 
convert --bitmaps' will succeed, even when the field is 0 because there 
is nothing to copy.

> If measure reports bitmaps size we will create a large enough disk and
> copy the bitmaps,
> and if not we will have to drop the relevant backup history for this
> vm, since the copy
> will not include the bitmaps. The next backup for this vm will have to
> be a full backup.

If you are always using qcow2 v3 images for both source and destination, 
then the field will be present, even when it is 0.  It will only be 
absent when there is nothing to copy (either the source or destination 
format is not qcow2, or you used measure on a size rather than on a 
source image).

> 
>> Here's the diff that would accomplish that:
> 
> Diff does not eliminate the "bitmaps: 0" outputs, so it looks good.

Okay, I'll revise the patch to get rid of the extra option (that is, 
getting it back to what it was in v3, before we had the discussion that 
prompted the addition of --bitmaps for comparison).  (I also have to 
touch up the iotests here and in 5/5)

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


