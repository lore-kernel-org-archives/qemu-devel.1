Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27815C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 15:34:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDDCA205CB
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 15:34:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F34NGvAI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDDCA205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51882 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgVPa-0004m6-6B
	for qemu-devel@archiver.kernel.org; Wed, 03 Jun 2020 11:34:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40824)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jgVOV-0003dI-Hj
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 11:33:31 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46808
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jgVOU-0002x9-NO
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 11:33:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591198409;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=55/CCbgGpWnJLossJNwJLXxnSZpNVU0ndAqO6ByXS5w=;
 b=F34NGvAIJso7ax0jAvO8j2ZCaW5ZKD/trR93Gf69am8IsBiITDww5MsQLmcPkKvmDHLxHc
 p2KmB7RXSoqS7ZMFh5/j/lzBmcv7m7Ese3N6lwwictOu+j9CXTzpY8YMAKKM3/mP/3z+qU
 uPp/O6lsHiaehHPi7+vYoJNG3I7VIY0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-506-Yr75ZX2TPVis1N3TVdf0wA-1; Wed, 03 Jun 2020 11:33:26 -0400
X-MC-Unique: Yr75ZX2TPVis1N3TVdf0wA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 25B038018A6;
 Wed,  3 Jun 2020 15:33:25 +0000 (UTC)
Received: from [10.3.113.22] (ovpn-113-22.phx2.redhat.com [10.3.113.22])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A64025D9E8;
 Wed,  3 Jun 2020 15:33:17 +0000 (UTC)
Subject: Re: [PATCH v3] osdep: Make MIN/MAX evaluate arguments only once
From: Eric Blake <eblake@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20200603013603.2400199-1-eblake@redhat.com>
 <03a13d47-fe7d-88e5-b92e-3c396591f9c7@linaro.org>
 <ecef14ce-47ca-749e-25b4-8e3ee378bd34@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <3eabc6a8-159f-5a01-0ec7-90cda9520a6f@redhat.com>
Date: Wed, 3 Jun 2020 10:33:16 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <ecef14ce-47ca-749e-25b4-8e3ee378bd34@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/03 01:04:35
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>, quintela@redhat.com,
 crosthwaite.peter@gmail.com, dgilbert@redhat.com, f4bug@amsat.org,
 kraxel@redhat.com, dirty.ice.hu@gmail.com, pbonzini@redhat.com,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/2/20 9:29 PM, Eric Blake wrote:

>>> +++ b/accel/tcg/translate-all.c
>>> @@ -2565,9 +2565,9 @@ int page_check_range(target_ulong start, 
>>> target_ulong len, int flags)
>>>       /* This function should never be called with addresses outside the
>>>          guest address space.  If this assert fires, it probably 
>>> indicates
>>>          a missing call to h2g_valid.  */
>>> -#if TARGET_ABI_BITS > L1_MAP_ADDR_SPACE_BITS
>>> -    assert(start < ((target_ulong)1 << L1_MAP_ADDR_SPACE_BITS));
>>> -#endif
>>> +    if (TARGET_ABI_BITS > L1_MAP_ADDR_SPACE_BITS) {
>>> +        assert(start < ((target_ulong)1 << L1_MAP_ADDR_SPACE_BITS));
>>> +    }
>>
>> IIRC the ifdef is required for clang warnings vs the shift.
>> Have you tested that?
> 
> I have not yet tested with clang.  We'll see if the CLI bots get to that 
> before I do...  But if clang isn't happy, I may have to introduce yet a 
> third macro, MIN_PP, safe for use in preprocessor statements.

I've now run a clang build over the entire tree (using clang 10.0.0 from 
Fedora 32, which required other pending patches mentioned on the list to 
work around unrelated warnings), the entire tree built without issue. 
So at least one version of clang compiled my rewrite of this hunk just 
fine, although it does not rule out what older versions might do.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


