Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ABB6C5517A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 08:49:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D3EF21775
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 08:49:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G1fSMuGY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D3EF21775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVWHb-0004ZK-L7
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 04:49:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56134)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1kVWGY-0003lu-5b
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 04:48:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54389)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1kVWGV-0005w1-O8
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 04:48:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603356486;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1z2bcFFkWXgGTmpH1glgTv2wZaCPV2wb5/If5QS4pXA=;
 b=G1fSMuGYfrifQ7X/dm9VZzO8Gw9kcQKGmDcCmsfIdmHXi6qmoihdIAmqUA9XVFWK53JKwX
 Yu88oLtpk9Tyju3V8ugpl8CWbiD625DSNOVDvsaBNMAHHe2k4oBx/fkdmV883qLQkeGiOa
 zz9n7G9R5nHg4/BXDfk5wTshzDvvX5U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-291-YM0up_rDNbqHME-6Sa-JxA-1; Thu, 22 Oct 2020 04:48:04 -0400
X-MC-Unique: YM0up_rDNbqHME-6Sa-JxA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E0917188C12A;
 Thu, 22 Oct 2020 08:48:02 +0000 (UTC)
Received: from [10.36.113.152] (ovpn-113-152.ams2.redhat.com [10.36.113.152])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E75F75D9F1;
 Thu, 22 Oct 2020 08:48:00 +0000 (UTC)
Subject: Re: [PATCH] s390x: pv: Fix diag318 PV fencing
To: Janosch Frank <frankja@linux.ibm.com>, qemu-devel@nongnu.org
References: <74c4631b-735c-e5ad-77a3-0bbd9c63c4db@redhat.com>
 <20201022082312.124708-1-frankja@linux.ibm.com>
 <3c2d61a4-1312-14a9-ac99-c562dfedcf31@redhat.com>
 <74499bb4-b873-1191-e8ca-cf64303e3970@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <7c10d6f4-8f95-470b-5c1e-9487dcf2cad8@redhat.com>
Date: Thu, 22 Oct 2020 10:47:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <74499bb4-b873-1191-e8ca-cf64303e3970@linux.ibm.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/22 00:54:46
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
Cc: thuth@redhat.com, cohuck@redhat.com, walling@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@de.ibm.com, qemu-s390x@nongnu.org,
 mhartmay@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 22.10.20 10:39, Janosch Frank wrote:
> On 10/22/20 10:32 AM, David Hildenbrand wrote:
>> On 22.10.20 10:23, Janosch Frank wrote:
>>> Diag318 fencing needs to be determined on the current VM PV state and
>>> not on the state that the VM has when we create the CPU model.
>>>
>>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>>> Reported-by: Marc Hartmayer <mhartmay@linux.ibm.com>
>>> Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
>>> Fixes: fabdada935 ("s390: guest support for diagnose 0x318")
>>> ---
>>>
>>> If you're sure that this is what you want, then I'll send a v2 of the
>>> patch set.
>>
>> So that's going to be the first CPU feature that gets suppressed in PC
>> mode - which seems to be what we want.
>>
>> diag318_needed() will return false, resulting in vmstate_diag318() not
>> being included in the migration stream (I know, we don't support
>> migration yet for PV).
> 
> Well either you have it and need to migrate it or you don't.
> As it doesn't persist over IPLs, that should not be a problem, no?

Okay, was confused by no finding a proper reset from our central reset
handler. So this feels like the right thing to do.


-- 
Thanks,

David / dhildenb


