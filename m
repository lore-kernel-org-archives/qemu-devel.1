Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE585C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 05:17:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D141E2224D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 05:17:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CHH0xMDM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D141E2224D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUk1z-0000eS-Mp
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 01:17:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34506)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kUjzx-0007L1-4v
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 01:15:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:42520)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kUjzu-000765-Gn
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 01:15:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603170943;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yeg4FPsi+ILf6rHdN3kURpf5rsjylJsezC2Uisk+y6M=;
 b=CHH0xMDMrEzmiqOb+PDUxDgWL7CkpWmi0UYHmWly7Z3kvkchZL9eM2aUALh9vEB4dlDpeW
 pUlr5KDHNWQ/YOCjzFnqXdmYaiW4wGUAO4VBs36s/Uj1QqNZCLnpSqaWzfoSC6G9cDIsj5
 qIbyotIeFSHtU8hNez2NOWhkIWse7rA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-240-f9J-wYYsP2eLRsOwEHt1TA-1; Tue, 20 Oct 2020 01:15:38 -0400
X-MC-Unique: f9J-wYYsP2eLRsOwEHt1TA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1031A1084D62;
 Tue, 20 Oct 2020 05:15:37 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-107.ams2.redhat.com [10.36.112.107])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5498C5D9D2;
 Tue, 20 Oct 2020 05:15:33 +0000 (UTC)
Subject: Re: [PATCH v2 2/9] configure: cross-compiling without cross_prefix
To: Joelle van Dyne <j@getutm.app>, BALATON Zoltan <balaton@eik.bme.hu>
References: <20201019013928.72770-1-j@getutm.app>
 <20201019013928.72770-3-j@getutm.app>
 <9a68e856-cb97-bf44-eef6-52d7cbca9884@redhat.com>
 <ec63904c-f0d2-b37b-9f9f-8f2109f1335a@redhat.com>
 <1f92b68-6d6c-d125-c034-7cbe414b198e@eik.bme.hu>
 <CA+E+eSCjkYf-6GYbJUQ=gpmQHH2zAH3g1JN+-2kjy2rUnwk3fA@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <d27c852c-b982-9b58-fbff-1bfc3d075e94@redhat.com>
Date: Tue, 20 Oct 2020 07:15:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CA+E+eSCjkYf-6GYbJUQ=gpmQHH2zAH3g1JN+-2kjy2rUnwk3fA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 01:15:43
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 20/10/2020 00.24, Joelle van Dyne wrote:
> Correct me if I'm wrong but wouldn't the following test still fail
> with --cross-prefix=""
> 
> if test -n "$cross_prefix"; then
> ...
> 
> That was my main reason for making this change.

That's why I wrote "still introduce the cross_compile=yes variable" ... that
change is certainly required anyway.

>>>>> @@ -456,6 +457,11 @@ for opt do
>>>>>    optarg=$(expr "x$opt" : 'x[^=]*=\(.*\)')
>>>>>    case "$opt" in
>>>>>    --cross-prefix=*) cross_prefix="$optarg"
>>>>> +                    cross_compile="yes"
>>>>> +  ;;
>>>>> +  --enable-cross-compile) cross_compile="yes"
>>>>> +  ;;
>>>>> +  --disable-cross-compile) cross_compile="no"
>>>>
>>>> Can't you simply use --cros-prefix="" instead?
>>>
>>> I mean, still introduce the "cross_compile=yes" variable, just omit the new
>>> options.
>>
>> That seems less intuitive for people trying to find this option. If --help
>> lists --enable-cross-compile I can guess what that means but there's no
>> way I could guess --cros-prefix="" unless I've been told or searched and
>> stumbled upon it. So unless it's a big problem I like the explicit options
>> better. Or is that a convention in other projects to use empty prefix to
>> enable cross compile that I don't know about?

I don't think that --cross-prefix is a "standard" option... Most other
(GNU-tools related) projects use "--build" and "--host" instead... so I
guess we're free to chose here. Let's see whether other people here have an
opionion on this...

 Thomas


