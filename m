Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09E4AC433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 16:06:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C67CB20773
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 16:06:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W5+rnHE0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C67CB20773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52168 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDVHc-0001RN-Ts
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 12:06:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57922)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kDVDz-0004MR-PO
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 12:03:03 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27109
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kDVDx-0007gp-KO
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 12:03:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599062579;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9pup5H5RJ/wO7B2QxDWsNWlikDnu1V+9Ivs5S+VV4ic=;
 b=W5+rnHE0/cj3X3HkNuDo27LppttNr2g8u+EhUe83lyUOReOPAIt8FQExJGGXMVyJSbT2Ht
 MBX92LIooE0Cypq2UvjkYUripeBxWmdFQT6I4G2Nf5QTCMoW+hm/qE5FRmxb0oKaMl4bzx
 2jROWqrVISfcCSnOXwN0norBHi6fdXQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-216-NJnbsiKuNU-JB8yQflUUKA-1; Wed, 02 Sep 2020 12:02:49 -0400
X-MC-Unique: NJnbsiKuNU-JB8yQflUUKA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9BE661084C82;
 Wed,  2 Sep 2020 16:02:48 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-129.ams2.redhat.com [10.36.112.129])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 331CF19C59;
 Wed,  2 Sep 2020 16:02:47 +0000 (UTC)
Subject: Re: [PATCH 2/2] hw/core: Move hw_error() out of cpus.c
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20200901112323.94969-1-f4bug@amsat.org>
 <20200901112323.94969-3-f4bug@amsat.org>
 <6e4fd230-1515-f82e-67f4-87494898c6cd@redhat.com>
 <3d1b6cc7-5101-9885-8288-fa1a66037c1f@linaro.org>
 <514f8742-e817-556f-0029-ba0ef9ac5509@amsat.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <0ed6327b-9966-3704-2a56-471a72b4c282@redhat.com>
Date: Wed, 2 Sep 2020 18:02:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <514f8742-e817-556f-0029-ba0ef9ac5509@amsat.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=205.139.110.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 02:26:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.324, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Claudio Fontana <cfontana@suse.de>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 02/09/2020 17.59, Philippe Mathieu-Daudé wrote:
> On 9/2/20 5:38 PM, Richard Henderson wrote:
>> On 9/1/20 11:37 PM, Thomas Huth wrote:
>>> - Move the function as "static inline" into the header file
>>>   instead - it's not so big, so an inline function should be
>>>   ok here.
>>
>> stdarg and inline do not mix.
>>
>>> - Add a big fat warning comment to the header that this
>>>   function should not be used for new code anymore.
>>
>> But certainly this.
> 
> Will do, but this has been proven to not work well...

... or add a warning to checkpatch.pl ?

 Thomas


