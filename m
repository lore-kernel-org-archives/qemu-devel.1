Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B616BC388F7
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 15:56:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B418206D8
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 15:56:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eeWnmlCF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B418206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39316 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kc9WS-00023M-3n
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 10:56:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38832)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kc9U6-0000Vl-2R
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 10:53:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47851)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kc9U3-0005v6-EZ
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 10:53:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604937210;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0H4GgmRganqhrt02uQ3Zlw3La8h24ueQEO6LTvo4WRo=;
 b=eeWnmlCFSdssatAUUZTcIJmGBpLWShXRAL4DGr7LIGXOhw4FYSBTo3Ne+8PR9QdSVR3Aqu
 vmcCa6LFa3vRrn0km070nthhu1mYfXC8qYNjjcvypeF1nqtGZZubwY+hekd+RV02dBIXF5
 dcFkjSxL7NoHMtGtIko26yrcy7lJyo4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-547-VCiehG7ZMuuW31DoxQx1dQ-1; Mon, 09 Nov 2020 10:53:26 -0500
X-MC-Unique: VCiehG7ZMuuW31DoxQx1dQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B600B6D245;
 Mon,  9 Nov 2020 15:53:24 +0000 (UTC)
Received: from [10.3.112.154] (ovpn-112-154.phx2.redhat.com [10.3.112.154])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6DC2019931;
 Mon,  9 Nov 2020 15:53:23 +0000 (UTC)
Subject: Re: [PATCH V2 1/2] plugins: Fix resource leak in connect_socket()
To: AlexChen <alex.chen@huawei.com>
References: <5FA4AE11.6060701@huawei.com>
 <37c069f2-b137-b68d-9fb5-45a98b84aa0c@redhat.com>
 <5FA8FBE4.7000504@huawei.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <e8b2bb7c-3809-4437-7903-300d6d3bc7bf@redhat.com>
Date: Mon, 9 Nov 2020 09:53:22 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <5FA8FBE4.7000504@huawei.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/09 00:04:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Cc: zhang.zhanghailiang@huawei.com, QEMU Trivial <qemu-trivial@nongnu.org>,
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 QEMU <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/9/20 2:20 AM, AlexChen wrote:
> On 2020/11/6 21:17, Eric Blake wrote:
>> On 11/5/20 7:59 PM, AlexChen wrote:
>>> Close the fd when the connect() fails.
>>>
>>> Reported-by: Euler Robot <euler.robot@huawei.com>
>>> Signed-off-by: Alex Chen <alex.chen@huawei.com>
>>
>> Your From: line ("AlexChen") is spelled differently than your S-o-b:
>> line ("Alex Chen").  While this is not fatal to the patch, it is
>> confusing, so you may want to update your git settings to produce mail
>> spelled in the same manner as the S-o-b.
>>
> 
> Hi Eric,
> 
> Thanks for you suggestion, I will modify the user.name of git to "Alex Chen".
> 
>> Also, although you did manage to send a 0/2 letter, you did not thread
>> things:
>> 0/2 Message-ID: <5FA4AE0B.1000007@huawei.com>
>> 1/2 Message-ID: Message-ID: <5FA4AE11.6060701@huawei.com>, but no
>> In-Reply-To: or References: headers, which means it is a new top-level
>> thread.  You may want to figure out why your mail setup is not
>> preserving threading.
>>
> 
> This may be my email settings is wrong, I try to modify the setting and send a patch v3.

Thanks for the rapid turnaround - I can confirm that v3 is indeed nicer
to read.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


