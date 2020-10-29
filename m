Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A1CEC4363A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 18:48:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F04920756
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 18:48:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MfZ9m2G/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F04920756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYCy1-0008KD-FT
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 14:48:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58752)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kYCx7-0007ii-9T
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 14:47:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:35486)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kYCx4-0007Fy-Fj
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 14:47:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603997229;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dqCjsV/uQP3EnA88ukXiyecZX781nxq/6UXhLHohBqk=;
 b=MfZ9m2G//weVka6pq2fCvIajI8X1/X0Fv/0OcoufYI7kTmEIM6SlDUKAfAzyfpVDTQ0qYR
 +Fm4phsq+86YNJwd7119a5QnggzufftVm3/0baVqrzL1mgF6TLH4z2th63WvzyitsvpCLm
 vbzrpXZuIHIw1QKFWn7hQB5VboAoLHw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-106-c7lwqqsQMhWGExdvV3auvg-1; Thu, 29 Oct 2020 14:47:07 -0400
X-MC-Unique: c7lwqqsQMhWGExdvV3auvg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4FD1864150;
 Thu, 29 Oct 2020 18:47:06 +0000 (UTC)
Received: from [10.3.112.145] (ovpn-112-145.phx2.redhat.com [10.3.112.145])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AE4C060C17;
 Thu, 29 Oct 2020 18:47:02 +0000 (UTC)
Subject: Re: Our abstract UNIX domain socket support is a mess
To: Kevin Wolf <kwolf@redhat.com>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?=
 <berrange@redhat.com>
References: <87o8kmwmjh.fsf@dusky.pond.sub.org>
 <20201029140242.GE27369@redhat.com> <20201029160744.GB6271@merkur.fritz.box>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <c52b8cd0-feea-a7ca-fe95-47112a4c36b1@redhat.com>
Date: Thu, 29 Oct 2020 13:47:02 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201029160744.GB6271@merkur.fritz.box>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/29 01:47:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.261, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: xiaoqiang zhao <zxq_yx_007@163.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/29/20 11:07 AM, Kevin Wolf wrote:

>>>
>>> QEMU's interface is differently messy.
>>>
>>> Our equivalent to struct sockaddr_un is QAPI type UnixSocketAddress:
>>>
>>>     { 'struct': 'UnixSocketAddress',
>>>       'data': {
>>>         'path': 'str' }
>>>
>>> @path corresponds to sockaddr_un member sun_path.  sun_family = AF_UNIX
>>> and socklen_t sizeof(sockaddr_un) are implied.
>>>
>>> We didn't repurpose @path for abstract sockets like the Linux kernel did
>>> with sun_path.  Instead, we added a flag @abstract (default false).
>>> When it's on, we make a binary blob by prefixing @path with a 0 byte,
>>> and pad it with more 0 bytes.
>>>
>>> We added a second flag @tight (default true) to optionally cut the
>>> socklen_t to the end of the string (the terminating 0 byte is not
>>> included).
>>>

> Using magic characters in strings to distinguish different types of
> objects is always wrong in QAPI. If we interpreted leading '@' this way,
> you wouldn't be able to specify a relative filename starting with '@'
> any more.
> 
>> Or, just or by having  explicit flags "abstract" and "tight" to
>> control the behaviour.  The latter is what 'socat' does to allow
>> use of abstract sockets.
>>
>> For QEMU the former approach gives broad interoperabiltiy with
>> userspace applications, so made more sense than using magic "@".
> 
> Boolean flags to distinguish different types are better than parsing
> strings, but still not optimal. Documentation like "only matters for
> abstract sockets" is another hint that we're treating things the same
> that aren't the same.

But why two boolean flags for three sensible states (where it is unclear
if the fourth combination that makes no sense is silently accepted or
loudly rejected), instead of a single tri-state-valued enum?

> 
> The proper way to distinguish two different types is unions. So I think
> the ideal interface would be another SocketAddress variant that could
> then also use base64 instead of str to represent arbitrary blobs, like
> Markus suggested below.
> 
> Probably too late now.

Sadly, you are probably right that we are a bit late to be rethinking
what we expose, since 5.1 is released.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


