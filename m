Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB6FCC4727D
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 22:09:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D197218AC
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 22:09:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LyNjUSbw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D197218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKTzn-0007DQ-9t
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 18:09:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58284)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kKTzD-0006jh-OE
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 18:08:39 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:54728
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kKTzB-00015X-EC
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 18:08:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600726115;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sPS2o5syYAO8T0Dw2Znt/h4AOtKkJqe3XLDdD+tU3gk=;
 b=LyNjUSbwhcqiZ5BZh/EyQn33AqGidt+CPqj4j57YcyLJ7NcAdJR4Oar34a1FlVC5+Gm8Ht
 aOXvIHcbBHhdTpFXreze0Z42dKzpy13vNuuJgOPMdRJ3crAA0oz/Wn+MP0bwx/gFksFpMc
 WsOv58zNz5CmhlseS0d8lmJQlIojrvw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-404-X6pV5FDeOYaHLwXDayImYA-1; Mon, 21 Sep 2020 18:08:31 -0400
X-MC-Unique: X6pV5FDeOYaHLwXDayImYA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 12F82909CB7;
 Mon, 21 Sep 2020 22:08:30 +0000 (UTC)
Received: from [10.3.113.127] (ovpn-113-127.phx2.redhat.com [10.3.113.127])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0884773684;
 Mon, 21 Sep 2020 22:08:28 +0000 (UTC)
Subject: Re: [PATCH v2] qemu-img: Support bitmap --merge into backing image
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
References: <20200914191009.644842-1-eblake@redhat.com>
 <f4d640aa-6aec-7dbc-69ae-5a2a6921447d@redhat.com>
 <07832208-dcc8-8e33-c7e7-05f9c891fec3@redhat.com>
 <6b3e7ba5-06fc-c733-f635-c1cc41178eea@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <c8dfe463-e73d-1497-bf97-de7a0df9bf3f@redhat.com>
Date: Mon, 21 Sep 2020 17:08:28 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <6b3e7ba5-06fc-c733-f635-c1cc41178eea@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=205.139.110.61; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/21 16:17:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 9/17/20 5:19 AM, Max Reitz wrote:

>>>> temporary over NBD, referring to a bitmap that lives only in Active is
>>>> less effort than having to copy a bitmap into temporary [1].  So the
>>>> testsuite additions in this patch check both where bitmaps get
>>>> allocated (the qemu-img info output), and, when NOT using 'qemu-img
>>>> bitmap', that bitmaps are indeed visible through a backing chain.
>>>
>>> Well.  It is useful over NBD but I would doubt that it isn’t useful in
>>> general.  For example, the QMP commands that refer to bitmaps always do
>>> so through a node-name + bitmap-name combination, and they require that
>>> the given bitmap is exactly on the given node.
>>>
>>> So I think this is a very much a case-by-case question.  (And in
>>> practice, NBD seems to be the outlier, not qemu-img bitmap.)
>>>
>>
>> I'm happy to reword slightly to give that caveat.
>>

>>> The code looks good to me, but I wonder whether in the commit message it
>>> should be noted that we don’t want to let bitmaps from deeper nodes
>>> shine through by default everywhere, but just in specific cases where
>>> that’s useful (i.e. only NBD so far AFAIA).
>>
>> So is this a Reviewed-by?  I'm happy to queue it through my bitmaps
>> tree, if so.
> 
> It wasn’t meant as an R-b, because my R-b depends on how the commit
> message addresses the question of when exactly bitmaps from the backing
> chain should be visible on the top image.  Whether qemu-img bitmap is an
> exception, or whether this is really a case-by-case question.
> 
> (I wanted to know whether you agree on including it.  Normally, I’m
> happy to give an R-b on the basis of “with that done”, but in this case
> I wasn’t entirely sure whether my request was reasonable, but I also
> felt that in case it was, it wasn’t optional, given that you do have an
> entire paragraph in the commit message dedicated to why the backing
> image’s bitmap is visible on an image exported over NBD.)

Here's my rewording:

However, note that on a case-by-case analysis, there _are_ times where
we treat it as a feature that we can access a bitmap from a backing
layer in association with an overlay BDS.  A demonstration of this is
using NBD to expose both an overlay BDS (for constant contents) and a
bitmap (for learning which blocks are interesting) during an
incremental backup:

Base <- Active <- Temporary
           \--block job ->/

where Temporary is being fed by a backup 'sync=none' job.  When
exposing Temporary over NBD, referring to a bitmap that lives only in
Active is less effort than having to copy a bitmap into Temporary [1].
So the testsuite additions in this patch check both where bitmaps get
allocated (the qemu-img info output), and that qemu-nbd is indeed able
to access a bitmap inherited from the backing chain since it is a
different use case than 'qemu-img bitmap'.

> 
> I have to say I would like to see how you do phrase it in the end, but
> given that you do agree on including it, I can give a
> 
> Reviewed-by: Max Reitz <mreitz@redhat.com>
> 
> Now.

Okay, I think I've met your request, so I'll go ahead and send the pull 
request today.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


