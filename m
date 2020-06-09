Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CCAAC433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 16:21:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11A92206A4
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 16:21:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ADizKlDv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11A92206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42196 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jih0D-0006Gk-1P
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 12:21:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46316)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jigym-0005F5-LO
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 12:20:00 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:29853
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jigyl-0007ji-7c
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 12:20:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591719597;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SyhfPKerh7BFn3BTRSnCQaLrCiEcxl0Ns1kmXdVRSrg=;
 b=ADizKlDvzaYmDeAEL98yJU9nr7Ix/px1/WGT7Cl8gsx/QOS+f/PxJaprUFO9ClGvL8/cLX
 vmOmZXHPml1wnK4Q4CVUEWb1go/ERRX/WqJTZ+3xOEszZyMs8ZDSK3HnCxkVqL7YmxgVQg
 4A4C7bf28yTUlk+3Z7DbcUBG4uiabAo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-220-KbuBlZEHN_CTJrRx1xXEHA-1; Tue, 09 Jun 2020 12:19:52 -0400
X-MC-Unique: KbuBlZEHN_CTJrRx1xXEHA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 111BD1B18BC2;
 Tue,  9 Jun 2020 16:19:51 +0000 (UTC)
Received: from [10.3.113.22] (ovpn-113-22.phx2.redhat.com [10.3.113.22])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 65E6310190A7;
 Tue,  9 Jun 2020 16:19:50 +0000 (UTC)
Subject: Re: [PATCH] qcow2: Reduce write_zeroes size in handle_alloc_space()
To: Kevin Wolf <kwolf@redhat.com>
References: <20200609140859.142230-1-kwolf@redhat.com>
 <02e24dca-99da-873d-8425-09a07571e675@virtuozzo.com>
 <042f0b8f-dd51-acc3-8498-ac9a5532df15@redhat.com>
 <20200609151810.GD11003@linux.fritz.box>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <b2c59302-2c14-474b-3bb8-3b48806f2689@redhat.com>
Date: Tue, 9 Jun 2020 11:19:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200609151810.GD11003@linux.fritz.box>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 02:41:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com,
 anton.nefedov@virtuozzo.com, "Denis V. Lunev" <den@openvz.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/9/20 10:18 AM, Kevin Wolf wrote:

>>>> -        ret = bdrv_co_pwrite_zeroes(s->data_file, m->alloc_offset,
>>>> -                                    m->nb_clusters * s->cluster_size,
>>>> +        ret = bdrv_co_pwrite_zeroes(s->data_file, start, len,
>>>>                                        BDRV_REQ_NO_FALLBACK);
>>
>> Good point.  If we weren't using BDRV_REQ_NO_FALLBACK, then avoiding a
>> pre-zero pass over the middle is essential.  But since we are insisting that
>> the pre-zero pass be fast or else immediately fail, the time spent in
>> pre-zeroing should not be a concern.  Do you have benchmark numbers stating
>> otherwise?
> 
> I stumbled across this behaviour (write_zeros for 2 MB, then overwrite
> almost everything) in the context of a different bug, and it just didn't
> make much sense to me. Is there really a file system where fragmentation
> is introduced by not zeroing the area first and then overwriting it?
> 
> I'm not insisting on making this change because the behaviour is
> harmless if odd, but if we think that writing twice to some blocks is an
> optimisation, maybe we should actually measure and document this.
> 
> 
> Anyway, let's talk about the reported bug that made me look at the
> strace that showed this behaviour because I feel it supports my last
> point. It's a bit messy, but anyway:
> 
>      https://bugzilla.redhat.com/show_bug.cgi?id=1666864
> 
> So initially, bad performance on a fragmented image file was reported.
> Not much to do there, but then in comment 16, QA reported a performance
> regression in this case between 4.0 and 4.2. And this change caused by
> c8bb23cbdbe, i.e. the commit that introduced handle_alloc_space().
> 
> Turns out that BDRV_REQ_NO_FALLBACK doesn't always guarantee that it's
> _really_ fast. fallocate(FALLOC_FL_ZERO_RANGE) causes some kind of flush
> on XFS and buffered writes don't. So with the old code, qemu-img convert
> to a file on a very full filesystem that will cause fragmentation, was
> much faster with writing a zero buffer than with write_zeroes (because
> it didn't flush the result).

Wow. That makes it sound like we should NOT attempt 
fallocate(FALLOC_FL_ZERO_RANGE) on the fast path, because we don't have 
guarantees that it is fast.

I really wish the kernel would give us 
fallocate(FALLOC_FL_ZERO_RANGE|FALLOC_FL_NO_FALLBACK) which would fail 
fast rather than doing a flush or other slow fallback.

> 
> I don't fully understand why this is and hope that XFS can do something
> about it. I also don't really think we should revert the change in QEMU,
> though I'm not completely sure. But I just wanted to share this to show
> that "obvious" characteristics of certain types of requests aren't
> always true and doing obscure optimisations based on what we think
> filesystems may do can actually achieve the opposite in some cases.

It also goes to show us that the kernel does NOT yet give us enough 
fine-grained control over what we really want (which is: 'pre-zero this 
if it is fast, but don't waste time if it is not).  Most of the kernel 
interfaces end up being 'pre-zero this, and it might be fast, fail fast, 
or even fall back to something safe but slow, and you can't tell the 
difference short of trying'.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


