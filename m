Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DATE_IN_PAST_12_24,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E9C8C43461
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 12:33:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD9632224A
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 12:33:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="auLFRneY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD9632224A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45468 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIWd5-0002cI-Sa
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 08:33:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34264)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kIWOX-0002kC-5c
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 08:18:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:51120)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kIWOU-00040Q-Aq
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 08:18:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600258717;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sGVWoFRRNIJjaEFjSCQuZV4/kPlzBlxwBNKlkQWqWq4=;
 b=auLFRneYCiLqdyqN2QaMa6qsnTB9RM0kLMRRD17ML5f8C466fas/k/axnaaTfzySHqx/Et
 zIe3ktXpsqkH+9H7SumWnzWr0SMM4TpF6gPQnc3VWTn1XFvjm0UiViLB2yQQHYt697koGN
 PSVCNBxJd8xSYgmi4L/BYsAMeptSkcE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-302-6wdkQkF6OJWFdGKMYnbfHQ-1; Wed, 16 Sep 2020 08:18:30 -0400
X-MC-Unique: 6wdkQkF6OJWFdGKMYnbfHQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2385E1084C81;
 Wed, 16 Sep 2020 12:18:29 +0000 (UTC)
Received: from [10.3.113.91] (ovpn-113-91.phx2.redhat.com [10.3.113.91])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 733681002388;
 Wed, 16 Sep 2020 12:18:28 +0000 (UTC)
Subject: Re: [PATCH v2] qemu-img: Support bitmap --merge into backing image
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
References: <20200914191009.644842-1-eblake@redhat.com>
 <f4d640aa-6aec-7dbc-69ae-5a2a6921447d@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <07832208-dcc8-8e33-c7e7-05f9c891fec3@redhat.com>
Date: Tue, 15 Sep 2020 08:31:09 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <f4d640aa-6aec-7dbc-69ae-5a2a6921447d@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=63.128.21.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 02:35:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIMWL_WL_HIGH=-2.999, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.062, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: kwolf@redhat.com, eshenitz@redhat.com, vsementsov@virtuozzo.com,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/15/20 3:57 AM, Max Reitz wrote:
> On 14.09.20 21:10, Eric Blake wrote:
>> If you have the chain 'base.qcow2 <- top.qcow2' and want to merge a
>> bitmap from top into base, qemu-img was failing with:
>>
>> qemu-img: Could not open 'top.qcow2': Could not open backing file: Failed to get shared "write" lock
>> Is another process using the image [base.qcow2]?
>>
>> The easiest fix is to not open the entire backing chain of either
>> image (source or destination); after all, the point of 'qemu-img
>> bitmap' is solely to manipulate bitmaps directly within a single qcow2
>> image, and this is made more precise if we don't pay attention to
>> other images in the chain that may happen to have a bitmap by the same
>> name.
>>
>> However, note that during normal usage, it is a feature that qemu will
>> allow a bitmap from a backing image to be exposed by an overlay BDS;
>> doing so makes it easier to perform incremental backup, where we have:
>>
>> Base <- Active <- temporrary
> 
> *temporary
> 
> (Also it’s a bit strange that “Base” and “Active” are capitalized, but
> “temporary” isn’t)
> 
>>            \--block job ->/
>>
>> with temporary being fed by a block-copy 'sync' job; when exposing
> 
> s/block-copy 'sync'/backup 'sync=none'/?

Will fix both.

> 
>> temporary over NBD, referring to a bitmap that lives only in Active is
>> less effort than having to copy a bitmap into temporary [1].  So the
>> testsuite additions in this patch check both where bitmaps get
>> allocated (the qemu-img info output), and, when NOT using 'qemu-img
>> bitmap', that bitmaps are indeed visible through a backing chain.
> 
> Well.  It is useful over NBD but I would doubt that it isn’t useful in
> general.  For example, the QMP commands that refer to bitmaps always do
> so through a node-name + bitmap-name combination, and they require that
> the given bitmap is exactly on the given node.
> 
> So I think this is a very much a case-by-case question.  (And in
> practice, NBD seems to be the outlier, not qemu-img bitmap.)
> 

I'm happy to reword slightly to give that caveat.

>> [1] Full disclosure: prior to the recent commit 374eedd1c4 and
>> friends, we were NOT able to see bitmaps through filters, which meant
>> that we actually did not have nice clean semantics for uniformly being
>> able to pick up bitmaps from anywhere in the backing chain (seen as a
>> change in behavior between qemu 4.1 and 4.2 at commit 00e30f05de, when
>> block-copy swapped from a one-off to a filter).  Which means libvirt
>> was already coded to copy bitmaps around for the sake of older qemu,
>> even though modern qemu no longer needs it.  Oh well.
>>
>> Fixes: http://bugzilla.redhat.com/1877209
>> Reported-by: Eyal Shenitzky <eshenitz@redhat.com>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>> ---
>>
>> In v2:
>> - also use BDRV_O_NO_BACKING on source [Max]
>> - improved commit message [Max]
>>
>>   qemu-img.c                 | 11 ++++++--
>>   tests/qemu-iotests/291     | 12 ++++++++
>>   tests/qemu-iotests/291.out | 56 ++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 76 insertions(+), 3 deletions(-)
> 
> The code looks good to me, but I wonder whether in the commit message it
> should be noted that we don’t want to let bitmaps from deeper nodes
> shine through by default everywhere, but just in specific cases where
> that’s useful (i.e. only NBD so far AFAIA).

So is this a Reviewed-by?  I'm happy to queue it through my bitmaps 
tree, if so.


-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


