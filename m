Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99DF9C4742C
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 09:49:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B72B22277
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 09:49:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XOE0L/+p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B72B22277
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZWSa-0007k7-1f
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 04:49:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48408)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1kZWOv-0003Tu-3V
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 04:45:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60816)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1kZWOs-0005Pv-BC
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 04:45:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604310317;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I/Eyz92Eot+z49L+ud/LYdaMlxJ3vlqhx7/HL17WbtQ=;
 b=XOE0L/+p4Xz0B8enMMzxa/nXm3yWTlIZYX751KjTwiam0SWcpqXJhYOu7XxMN/z744OR6h
 zJSh1gZMN7AogRr2EI1DgZ4EfX6PRoVOtz6uCZCPdAKKQGqgMoiUGFP9kmg94HenJcohOi
 UZ6nYQomN0auVlskrCnFjBbSQeAjvbg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-401-IlzBQPJpMNC_uE6xjkRj6w-1; Mon, 02 Nov 2020 04:45:14 -0500
X-MC-Unique: IlzBQPJpMNC_uE6xjkRj6w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D66158015A8;
 Mon,  2 Nov 2020 09:45:12 +0000 (UTC)
Received: from [10.36.113.163] (ovpn-113-163.ams2.redhat.com [10.36.113.163])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C251F5C1BB;
 Mon,  2 Nov 2020 09:45:11 +0000 (UTC)
Subject: Re: [PATCH v2] target/s390x: fix execution with icount
To: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>, qemu-devel@nongnu.org
References: <160430921917.21500.1486722139653938240.stgit@pasha-ThinkPad-X280>
 <af2ae869-08fc-540f-2829-89bc3fa4f5ae@redhat.com>
 <15e1e4ab-cbed-f641-2ad8-4823011bf40a@ispras.ru>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <22561df3-6a2b-47bb-2223-3257660b503e@redhat.com>
Date: Mon, 2 Nov 2020 10:45:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <15e1e4ab-cbed-f641-2ad8-4823011bf40a@ispras.ru>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/02 01:33:03
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: thuth@redhat.com, cohuck@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 02.11.20 10:41, Pavel Dovgalyuk wrote:
> On 02.11.2020 12:34, David Hildenbrand wrote:
>> On 02.11.20 10:26, Pavel Dovgalyuk wrote:
>>> This patch adds some gen_io_start() calls to allow execution
>>> of s390x targets in icount mode with -smp 1.
>>> It enables deterministic timers and record/replay features.
>>
>> Why do we have to set it for SIGP?
> 
> Timer-related instructions obviously needed IO.
> But I'm not familiar with s390, therefore also added IO
> for the instructions that lock iothread mutex, because they
> probably can access some virtual hardware and change the timers.
> But maybe this is not related to SIGP and it takes the mutex
> for other reasons.

SIGP does IPI but also triggers CPU reset, so it deals with timers in 
some sense (reset). So looks like the right thing to do. Thanks!

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb


