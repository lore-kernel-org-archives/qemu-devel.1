Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0664C00A89
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 13:15:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00774206B5
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 13:15:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HKseqJIK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00774206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49330 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaf6u-00052Z-ED
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 08:15:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52716)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kaf5A-0004Tu-RE
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 08:13:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53189)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kaf58-00030Y-OV
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 08:13:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604582017;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CzBAMmIgNp5jTML2onJYu4GwXvl2RZLsvkea/auBgHg=;
 b=HKseqJIKwYYnhNplhryUVnmfZZAjFBOADIMjAblkHwo4kDTiqFzN7c0HRzJJ1V0DYQnhKd
 +JFInjFht7E+RcE19irEXmgTXEyIaQuTJt7qAKpek02mAiBAg6FgsR9aWWyKD0Lr6uFviS
 frteaDrQc/E04F+zKqso58rcTj7C1kc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-233-JxSZgQLkO1ysKH8YQF-F2A-1; Thu, 05 Nov 2020 08:13:34 -0500
X-MC-Unique: JxSZgQLkO1ysKH8YQF-F2A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1DB181084D74;
 Thu,  5 Nov 2020 13:13:33 +0000 (UTC)
Received: from [10.3.114.103] (ovpn-114-103.phx2.redhat.com [10.3.114.103])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 552205C88A;
 Thu,  5 Nov 2020 13:13:31 +0000 (UTC)
Subject: Re: [PATCH] block: Return the real error code in bdrv_getlength
To: Tuguoyi <tu.guoyi@h3c.com>, Kevin Wolf <kwolf@redhat.com>,
 Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
References: <62817854003b4a6398d7560fa8dad39c@h3c.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <63daf411-0f9a-7c62-b603-086394a89058@redhat.com>
Date: Thu, 5 Nov 2020 07:13:30 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <62817854003b4a6398d7560fa8dad39c@h3c.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/05 01:14:53
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/4/20 11:41 PM, Tuguoyi wrote:
> Sorry, please ignore this patch, it's not a right fix

What's not right about it?


>> +++ b/block.c
>> @@ -5082,6 +5082,10 @@ int64_t bdrv_getlength(BlockDriverState *bs)
>>  {
>>      int64_t ret = bdrv_nb_sectors(bs);
>>
>> +    if (ret < 0) {
>> +        return ret;
>> +    }
>> +
>>      ret = ret > INT64_MAX / BDRV_SECTOR_SIZE ? -EFBIG : ret;

You are correct that the old code was broken (since
INT64_MAX/BDRV_SECTOR_SIZE is unsigned, any negative ret is likewise
promoted to unsigned and we mistakenly return -EFBIG instead of the
original error).  But your new code works just fine: because we
guarantee with the early return above that ret is a positive value, it
doesn't matter that the rest of this ?: is performed in unsigned math.

>>      return ret < 0 ? ret : ret * BDRV_SECTOR_SIZE;

Of course, having two ?: in a row is odd; we could instead write:

if (ret < 0){
    return ret;
}
if (ret > INT64_MAX / BDRV_SECTOR_SIZE) {
    return -EFBIG;
}
return ret * BDRV_SECTOR_SIZE;

for the same result.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


