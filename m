Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A32DC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 13:49:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58ACE206E6
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 13:49:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qy/LHjoV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58ACE206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48702 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhCiR-0007Re-J8
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 09:48:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42108)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jhChR-0006f6-5z
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 09:47:57 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36108
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jhChQ-0000YT-4G
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 09:47:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591364875;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PNoe017W9xk4CqlDd8+LTi1NDLu4LCuGUWhE/5s7rBI=;
 b=Qy/LHjoV65yksftPF7k8T5duMIMfzYBUbtj5ftlqnNsl5aIL5jpnXkVUX1r2j8RJhYkX5B
 /wf/jbd53eWYy6iPwTqnxjOcHqGYcWwyGwzDaUnsf0KNqYcMyrZcG3Th85apke3NlxpUHo
 YHW5IhhVm3vZysw02pnVBOuXLmHqzMw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-25-_-R8i-ClN-mrWEj--ZqGrg-1; Fri, 05 Jun 2020 09:47:50 -0400
X-MC-Unique: _-R8i-ClN-mrWEj--ZqGrg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 44E8A8B19C1;
 Fri,  5 Jun 2020 13:47:49 +0000 (UTC)
Received: from [10.3.113.22] (ovpn-113-22.phx2.redhat.com [10.3.113.22])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 673C97B5F6;
 Fri,  5 Jun 2020 13:47:48 +0000 (UTC)
Subject: Re: [PATCH 1/2] Introduce (x86) CPU model deprecation API
To: Robert Hoo <robert.hu@linux.intel.com>, pbonzini@redhat.com,
 rth@twiddle.net, ehabkost@redhat.com, armbru@redhat.com
References: <1591184823-140846-1-git-send-email-robert.hu@linux.intel.com>
 <70e5d2d1-8bd0-5582-4f8f-066824a7d263@redhat.com>
 <f4ea936819b698c88773ec69cf9d535fb7c32a4a.camel@linux.intel.com>
 <c0c1643d-ff3c-919b-7684-dac14f0d5229@redhat.com>
 <f43f253883e448edbf4cc4e7d685cbf66256f743.camel@linux.intel.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <26e46d40-2e87-9427-40fd-6278caf30546@redhat.com>
Date: Fri, 5 Jun 2020 08:47:47 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <f43f253883e448edbf4cc4e7d685cbf66256f743.camel@linux.intel.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 03:07:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: robert.hu@intel.com, xiaoyao.li@intel.com, qemu-devel@nongnu.org,
 chenyi.qiang@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/4/20 9:47 PM, Robert Hoo wrote:
> On Thu, 2020-06-04 at 06:59 -0500, Eric Blake wrote:
>> On 6/4/20 3:07 AM, Robert Hoo wrote:
>>
>>>>> +++ b/qapi/machine-target.json
>>>>> @@ -309,7 +309,8 @@
>>>>>                 'static': 'bool',
>>>>>                 '*unavailable-features': [ 'str' ],
>>>>>                 'typename': 'str',
>>>>> -            '*alias-of' : 'str' },
>>>>> +            '*alias-of' : 'str',
>>>>> +            'deprecated' : 'bool' },
>>>>
>>>> Missing documentation of the new member.  Should it be optional
>>>> (present
>>>> only when true)?
>>>
>>> Which document do you mean?
> 
> Thanks Eric:)
> 
>>
>> A few lines earlier is '@alias-of: ...'; you'll need to add a
>> similar
>> line for '@deprecated', mentioning it is '(since 5.1)'.
>>
>>> How to make it optional?
> 
> How about not making it optional? refer to Machineinfo::deprecated.

Always providing it doesn't hurt.  If there is precedence for not making 
it optional, mentioning that precedence in the commit message can't hurt.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


