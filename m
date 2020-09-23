Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4E48C2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 18:07:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40D7720791
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 18:07:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NxJAPki5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40D7720791
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48348 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kL9BG-0008Ls-UM
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 14:07:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49956)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kL99y-0007ix-Fb
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 14:06:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48972)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kL99w-0006Hw-QR
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 14:06:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600884387;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8BcfDeNAk++Lhssk7XhkShNU1t9TqY8E1RSZ7TLXnyk=;
 b=NxJAPki5KsdylFoFdxoQvh9iS5xWuelyhS16kH3kGG2QIVhT1s1rHk+cAMrYHqlF8niu5L
 iYZuRuWE9Vvq/xE89O2OOIl7rSRZO2xFlDvY/6uQxij9ULvjePfcsUBFuCbPXt+VgWEHJQ
 5327e2GpFkblOQ4pgRiD9FO9911WmTI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-89-TrSno8gnMg6yzoZAthcdgQ-1; Wed, 23 Sep 2020 14:06:20 -0400
X-MC-Unique: TrSno8gnMg6yzoZAthcdgQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 83ECA84E242;
 Wed, 23 Sep 2020 18:06:19 +0000 (UTC)
Received: from [10.3.114.2] (ovpn-114-2.phx2.redhat.com [10.3.114.2])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DF8A2100164C;
 Wed, 23 Sep 2020 18:06:15 +0000 (UTC)
Subject: Re: [PATCH] virtio: vdpa: omit check return of g_malloc
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Li Qiang <liq3ea@gmail.com>
References: <20200819144309.67579-1-liq3ea@163.com>
 <2a946eec-5158-0bca-e9c9-b7c81d557b1b@redhat.com>
 <CAKXe6S+0D-jnrq602X-cNHuC7PZXGqpqJM0qXQ8jPe3pRtOSjg@mail.gmail.com>
 <87r1qzw7nz.fsf@linaro.org>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <a5d9d78c-fd3e-38a9-62b6-d0d7b1081549@redhat.com>
Date: Wed, 23 Sep 2020 13:06:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <87r1qzw7nz.fsf@linaro.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 23:02:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.228,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Li Qiang <liq3ea@163.com>,
 qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/18/20 8:12 AM, Alex Bennée wrote:
> 
> Li Qiang <liq3ea@gmail.com> writes:
> 
>> Philippe Mathieu-Daudé <philmd@redhat.com> 于2020年8月19日周三 下午11:07写道：
>>>
>>> On 8/19/20 4:43 PM, Li Qiang wrote:
>>>> If g_malloc fails, the application will be terminated.
>>>
>>> Which we don't want... better to use g_try_malloc() instead?
>>
>> I don't think so. If g_malloc return NULL it means a critical
>> situation I think terminate the application
>> is OK. Though I don't find any rule/practices the qemu code base uses
>> g_malloc far more than
>> g_try_malloc.
> 
> g_try_malloc is only for cases you could recover from, by either
> deferring or doing something else. A straight out of memory failure is
> fatal.
> 
> Arguably a bunch of the try_malloc's in the code base should be straight
> mallocs. The ELF loaders load_symbols does it because I guess having the
> symbols is a bonus and you could still run the program if a) there was
> enough memory to run and b) your symbol table was very large.

If the amount of memory being allocated is under user control (such as 
from an elf header or qcow2 image), you want g_try_malloc() to prevent 
against malicious users requesting outrageous amounts.  But if it is 
solely under programmer control, where the maximum amount requested is 
not going to be a problem unless you are already truly out of memory for 
other reasons, g_malloc() is appropriate.  A potential rule of thumb 
might be that if you know it is less than 1M of memory, it's not worth 
trying to recover from.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


