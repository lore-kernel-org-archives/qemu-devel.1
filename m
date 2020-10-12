Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DF43C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 10:46:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1565208FE
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 10:46:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jPy19Bjy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1565208FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39626 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRvLP-0000T4-FF
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 06:46:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58088)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kRvKK-00084Y-Fk
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 06:45:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:27487)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kRvKD-0000iK-7N
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 06:45:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602499503;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4DgQyBUKHO9uEFcEOkapjV+Catm7VjAWQNj1RQiFJtk=;
 b=jPy19BjyOpOZd+RyTvVCVNqiuOMSR0YfGPPRAr+owGPVf/I2dLrXOQYS6+7Cu7FnyZfCie
 kwo0cwn+a5AsbdQ/UaO9yxPn0WvqPQ/+9QS+YI2mfieyQO0F63WgVLpc4M3/p79WTV51uX
 ENuZMf8NpAaESa/m63ahYx/5/lmXyBM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-584-ZW2fJnqYOBqhrvNTQZRzJg-1; Mon, 12 Oct 2020 06:45:00 -0400
X-MC-Unique: ZW2fJnqYOBqhrvNTQZRzJg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 74B841868403;
 Mon, 12 Oct 2020 10:44:59 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-113-22.ams2.redhat.com [10.36.113.22])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8936C19C78;
 Mon, 12 Oct 2020 10:44:57 +0000 (UTC)
Subject: Re: [PATCH] hw/net: move allocation to the heap due to very large
 stack frame
To: David Gibson <david@gibson.dropbear.id.au>,
 Elena Afanasova <eafanasova@gmail.com>
References: <8f07132478469b35fb50a4706691e2b56b10a67b.camel@gmail.com>
 <20201010060745.GK1025389@yekko.fritz.box>
 <f505c80b88ee665a62883a69bed9d614f6ba2a66.camel@gmail.com>
 <20201012053001.GD4787@yekko.fritz.box>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <38d5993e-8a10-0fb1-5263-6531a356fefd@redhat.com>
Date: Mon, 12 Oct 2020 12:44:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201012053001.GD4787@yekko.fritz.box>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/12 02:58:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
Cc: qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 jasowang@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/10/2020 07.30, David Gibson wrote:
> On Sat, Oct 10, 2020 at 08:53:00AM -0700, Elena Afanasova wrote:
>> On Sat, 2020-10-10 at 17:07 +1100, David Gibson wrote:
>>> On Fri, Oct 09, 2020 at 07:02:56AM -0700, Elena Afanasova wrote:
>>>>> From 09905773a00e417d3a37c12350d9e55466fdce8a Mon Sep 17 00:00:00
>>>>> 2001
>>>> From: Elena Afanasova <eafanasova@gmail.com>
>>>> Date: Fri, 9 Oct 2020 06:41:36 -0700
>>>> Subject: [PATCH] hw/net: move allocation to the heap due to very
>>>> large stack
>>>>  frame
>>>
>>> Patch looks fine, but some more details of the motivation would be
>>> nice.  I wouldn't have thought that the size of a network packet
>>> counted as a "very large" stack frame by userspace standards.
>>>
>>
>> gcc with wstack-usage warns that stack frame size may be ~65Kbytes
> 
> AFAICT, -Wstack-usage takes a parameter giving what size it will
> complain about.  What was that value, and what was the rationale for
> choosing it?

I think this is one of the tasks from:

 https://wiki.qemu.org/Contribute/BiteSizedTasks#Compiler-driven_cleanups

It has been added by Paolo in 2016:

 https://wiki.qemu.org/index.php?title=Contribute/BiteSizedTasks&diff=5368&oldid=5367

... so maybe Paolo can comment on the size that has been chosen here...?

 Thomas


