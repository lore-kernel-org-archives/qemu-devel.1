Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42E95C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 06:17:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D2252065D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 06:17:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B1y/EWXP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D2252065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60638 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7uvi-0006g9-8h
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 02:17:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43670)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k7uuz-0006CI-21
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 02:16:21 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:57314
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k7uut-0003VN-Hs
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 02:16:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597731374;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zNAWR8Db7iky2PfhhKyqyzQvo8/JAP8HRK4XLQpqp7Q=;
 b=B1y/EWXPRuvK8W04VK9N1Rn0VmOK7jTeOF6iC8DsHA6OCay7w6kFfHxuqDyiijdXhWWTa0
 1PZ1cg2oPTZokElYDujQpdZ5xF0CcbqqMtjhoh/JrlrjrPaRdHM3/QI/M+Bfnzqr5SS/Ji
 3mwg/t2AerhHMG5uDDVwoRyWOIwj840=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-241-m-Kd8du9PRmMEOSUCEazcQ-1; Tue, 18 Aug 2020 02:16:12 -0400
X-MC-Unique: m-Kd8du9PRmMEOSUCEazcQ-1
Received: by mail-wr1-f72.google.com with SMTP id l14so7833156wrp.9
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 23:16:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=zNAWR8Db7iky2PfhhKyqyzQvo8/JAP8HRK4XLQpqp7Q=;
 b=KqV+ErNMeH4aOnpLPDqv3uAYRqZIBLF1+S4mwpvWcFw52fe4Mvopq6snNk6247K49H
 atHvsqp/t+LfXI6uM2UYch7Hu17gPhcGQus4h0moLFlOZFuy3w55ahVgbnuaVcWTp12Z
 9d5WvISutCeLNbpp7nvxY7+EiSbkvAgkuKgR4YGgJEz/wTLtV7xqeUk8BxinmZm2ZpHN
 0BNcSd4QMJfzhLLAwu5LyKvpw0hVHY3YvLOdwRfryCeI+QVTcUM8ZqtxpyQgOGt82RG1
 Rh7mSm3BGHnDSgK0uVTPLs0X66UX/xszUCG8QzPhwU/1Qb97MKmvcHwVIckppmqPCG8A
 LN4Q==
X-Gm-Message-State: AOAM532uqI7Wla99fV2MbcexvVkswyJiNsGL9KAtpW+XomZmLJL2rZ54
 AYEhcuEkYLuXv95C+Zn1EMIO1J8mKyoMoyWXh/1hWSUfDLmmaTDcrESv5boDFAUyIPV2yKGAaqr
 1X6fBOa/1+0wEUdE=
X-Received: by 2002:a5d:6284:: with SMTP id k4mr19629976wru.372.1597731371098; 
 Mon, 17 Aug 2020 23:16:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxj/bImW0Yb5Ijxp6LB/yDbbZIY88X54R+KgF198iJjIMemSR7pN2UP2s/j5xobdW/eVeICoQ==
X-Received: by 2002:a5d:6284:: with SMTP id k4mr19629957wru.372.1597731370791; 
 Mon, 17 Aug 2020 23:16:10 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:a0d1:fc42:c610:f977?
 ([2001:b07:6468:f312:a0d1:fc42:c610:f977])
 by smtp.gmail.com with ESMTPSA id w132sm35052813wma.32.2020.08.17.23.16.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Aug 2020 23:16:10 -0700 (PDT)
Subject: Re: What is bs->reqs_lock for?
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu block <qemu-block@nongnu.org>
References: <ebea1375-8bc0-2b0a-051f-28b2afa02a1c@virtuozzo.com>
 <2c237be3-7e28-f61a-d339-5765089fe65c@redhat.com>
 <e6d75774-300d-c38d-3f07-0cbc39aff54e@virtuozzo.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8d337bc3-e3a7-d941-aa70-642f9ce0fcbe@redhat.com>
Date: Tue, 18 Aug 2020 08:16:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <e6d75774-300d-c38d-3f07-0cbc39aff54e@virtuozzo.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/18 02:16:14
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 13/08/20 18:34, Vladimir Sementsov-Ogievskiy wrote:
> I thought bs is attached to one aio context and aio context attached to
> one iothread.

For now yes, but with multiqueue there would be many iothreads sending
requests to the AioContext.  The BDS would still have a "home"
aiocontext to request socket readiness events, but
io_uring/linux_aio/threadpool requests could be issued from any iothread.

> And all normal request processing of the bs is done in this one iothread.
> And when we need to access bs externally, we do it in
> aio_context_acquire / aio_context_release, which protects from parallel
> access to BlockDriverState fields...
> 
> But you say, that block/io.c is not protected by AioContext lock..
> Does it mean that everything must be thread-safe in block/io.c and all
> block drivers?

Yes.

> 
> Are tracked_requests different from other fields? A lot of other
> BlockDriverState
> fields are not protected by any mutex.. For example: total_sectors,
> file, backing..

Rules are documented in include/block/block_int.h.  It seems however
that never_freeze was blindly added at the end.

Paolo

> Could you give an example of parallel access to tracked_requests?
> 


