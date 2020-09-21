Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B26B1C43469
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 14:43:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E5FE235FC
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 14:43:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="emgf+YMr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E5FE235FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKN2g-0005Wh-5p
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 10:43:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52422)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kKN1U-0004Ni-TT
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 10:42:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:41738)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kKN1S-0005tF-UM
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 10:42:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600699350;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xoMAFBwb8ptKT6pJ90YzaJr1+KGeRrVDE4llFWuUbuE=;
 b=emgf+YMr1kG6FiOtg/66k/1C7zzKrJJZVd+4GApyexlVB8eggHAK6k53MUiCsODmajZ4O+
 pN1+hqlppCYfUVfIadP1yy6cet+SxfYpi0AILP9athzWAEdR7cPEO4khUQH86kvxB8nj9u
 ZRQOwf7aLwmTX1d6TmPBcjwenC8hFcE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-520-3RemWG0HMmiD6-sZ0D8sUQ-1; Mon, 21 Sep 2020 10:42:27 -0400
X-MC-Unique: 3RemWG0HMmiD6-sZ0D8sUQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E018010082E5;
 Mon, 21 Sep 2020 14:42:26 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-114-66.ams2.redhat.com
 [10.36.114.66])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B337478823;
 Mon, 21 Sep 2020 14:42:26 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4F5771132E9A; Mon, 21 Sep 2020 16:42:25 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v5 8/8] qapi: New -compat deprecated-input=crash
References: <20200914084802.4185028-1-armbru@redhat.com>
 <20200914084802.4185028-9-armbru@redhat.com>
 <e1c94dc7-b97f-4919-0210-fe3c0e19e93f@redhat.com>
Date: Mon, 21 Sep 2020 16:42:25 +0200
In-Reply-To: <e1c94dc7-b97f-4919-0210-fe3c0e19e93f@redhat.com> (Eric Blake's
 message of "Mon, 14 Sep 2020 10:58:55 -0500")
Message-ID: <87d02f199q.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=63.128.21.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/21 01:44:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: marcandre.lureau@gmail.com, qemu-devel@nongnu.org,
 mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Eric Blake <eblake@redhat.com> writes:

> On 9/14/20 3:48 AM, Markus Armbruster wrote:
>> Policy "crash" calls abort() when deprecated input is received.
>> Bugs in integration tests may mask the error from policy "reject".
>> Provide a larger hammer: crash outright.  Masking that seems unlikely.
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>
>> +++ b/qemu-options.hx
>> @@ -3392,7 +3392,7 @@ DEFHEADING()
>>   DEFHEADING(Debug/Expert options:)
>>     DEF("compat", HAS_ARG, QEMU_OPTION_compat,
>> -    "-compat [deprecated-input=accept|reject][,deprecated-output=accept|hide]\n"
>> +    "-compat [deprecated-input=accept|reject|crash][,deprecated-output=accept|hide]\n"
>>       "                Policy for handling deprecated management interfaces\n",
>>       QEMU_ARCH_ALL)
>>   SRST
>> @@ -3403,6 +3403,8 @@ SRST
>>           Accept deprecated commands and arguments
>>       ``deprecated-input=reject``
>>           Reject deprecated commands and arguments
>> +    ``deprecated-input=crash``
>> +        Crash on deprecated command
>
> Missing 'and arguments'?

Yes.

> Otherwise,
> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!


