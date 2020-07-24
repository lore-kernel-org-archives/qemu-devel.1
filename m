Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38023C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 09:44:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00D5920714
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 09:44:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RbsWNYJO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00D5920714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42966 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyuFb-0008BP-8H
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 05:44:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57364)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jyuEh-0007LW-5p
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 05:43:27 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36477
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jyuEf-0000nr-K4
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 05:43:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595583805;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=uFfGSQbdnhBlkOBQ0NI35je9VGHlQMa/XLM85/Kln2U=;
 b=RbsWNYJOREnqTHPEzT0dSGhoKKwNbfpENlw0RCCNxuNt9X1HGLRgB3ELqaEXddWHrFXRmz
 6bkkhHYouq5NPOeLnR8dwZHQYQbHvFaCfjICmzmiqyzG9BqT1yWNrRKfipddw1un5IyKBA
 i9vQhsP0J3bffiQd+9gvoeJtvGsSoqI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-83-RFjw_LciO7eR-Fy-3rGq-g-1; Fri, 24 Jul 2020 05:43:23 -0400
X-MC-Unique: RFjw_LciO7eR-Fy-3rGq-g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EB1138017FB;
 Fri, 24 Jul 2020 09:43:21 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-77.ams2.redhat.com [10.36.112.77])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E06E65D9D3;
 Fri, 24 Jul 2020 09:43:20 +0000 (UTC)
Subject: Re: [RFC PATCH] buildsys: Only build capstone if softmmu/user mode is
 enabled
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200724071657.21508-1-f4bug@amsat.org>
 <5d8ade29-c085-9f6d-b896-fda48c1f5666@redhat.com>
 <0ce8f279-1ef0-6d93-5fff-032783fba2b6@amsat.org>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <ba80991e-0c0e-ceb0-4258-963484b1ec1b@redhat.com>
Date: Fri, 24 Jul 2020 11:43:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <0ce8f279-1ef0-6d93-5fff-032783fba2b6@amsat.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/24 00:01:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 24/07/2020 11.38, Philippe Mathieu-Daudé wrote:
> On 7/24/20 9:56 AM, Thomas Huth wrote:
>> On 24/07/2020 09.16, Philippe Mathieu-Daudé wrote:
>>> At least one of softmmu or user mode has to be enabled to use
>>> capstone. If not, don't clone/built it.
>>>
>>> This save CI time for the tools/documentation-only build jobs.
>>>
>>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>>> ---
>>>  configure | 4 ++++
>>>  1 file changed, 4 insertions(+)
>>>
>>> diff --git a/configure b/configure
>>> index 4bd80ed507..bc5757159a 100755
>>> --- a/configure
>>> +++ b/configure
>>> @@ -5381,6 +5381,10 @@ fi
>>>  ##########################################
>>>  # capstone
>>>  
>>> +if test -z "$capstone" && test $tcg = 'no' ; then # !tcg implies !softmmu
>>> +  capstone="no"
>>> +fi
>>
>> I don't think this is right. You could have a KVM-only build where you
>> still want to use the disassembler for the human monitor.
> 
> I had the same question with KVM, I agree this is unclear, this is why
> I added RFC.
> 
> Don't we have !softmmu implies !kvm?

Yes. You can not use KVM with linux-user builds.

But I think it's wrong to test for accelerators here. You could still
build a QEMU binary with HVF or HAX and still want to have disassembler
support in there.

 Thomas


