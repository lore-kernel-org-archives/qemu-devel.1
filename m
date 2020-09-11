Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CE7CC2BC11
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 15:15:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E74520770
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 15:15:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TlYeASC4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E74520770
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGklj-0000Ny-I4
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 11:15:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40798)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kGkkt-0007yB-3p
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 11:14:27 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:49021
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kGkkp-0004jT-3z
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 11:14:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599837260;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Fz0LnUYgO8Jg6scCK96TLjXta0dNJ9k+SKpIX3fRaj4=;
 b=TlYeASC4DeDU5SR/0jZEgNYVJVUeEPtyih74wuTZX6vNspalRhPTTZJf5N/LDLKJFgBfxS
 kIrCHsORWeCI4lOkFSQWeCjjxrDI2iV7S++86Y9vMnd9P7yLtilTHmKofVrtO82OuKKtJR
 hvuoMWVDRpyVilKmHhY9+yCNA1scCIQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-494-BcFO-JQ6OXCG-H9XFwosEw-1; Fri, 11 Sep 2020 11:14:17 -0400
X-MC-Unique: BcFO-JQ6OXCG-H9XFwosEw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7534A425D4;
 Fri, 11 Sep 2020 15:14:15 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-115-1.ams2.redhat.com [10.36.115.1])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 79D093C89;
 Fri, 11 Sep 2020 15:14:06 +0000 (UTC)
Subject: Re: [PATCH v5 8/8] s390: guest support for diagnose 0x318
From: Thomas Huth <thuth@redhat.com>
To: Collin Walling <walling@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
References: <20200910093655.255774-1-walling@linux.ibm.com>
 <20200910093655.255774-9-walling@linux.ibm.com>
 <6707d734-772d-0a34-0980-6d8e71873238@redhat.com>
Message-ID: <9a802d40-11ce-879c-9a2d-672f01aaedf2@redhat.com>
Date: Fri, 11 Sep 2020 17:14:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <6707d734-772d-0a34-0980-6d8e71873238@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=205.139.110.61; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/11 03:40:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.469, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: frankja@linux.ibm.com, david@redhat.com, cohuck@redhat.com,
 pasic@linux.ibm.com, borntraeger@de.ibm.com, mst@redhat.com,
 pbonzini@redhat.com, sumanthk@linux.ibm.com, mihajlov@linux.ibm.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/09/2020 17.08, Thomas Huth wrote:
> On 10/09/2020 11.36, Collin Walling wrote:
>> DIAGNOSE 0x318 (diag318) is an s390 instruction that allows the storage
>> of diagnostic information that is collected by the firmware in the case
>> of hardware/firmware service events.
>>
>> QEMU handles the instruction by storing the info in the CPU state. A
>> subsequent register sync will communicate the data to the hypervisor.
>>
>> QEMU handles the migration via a VM State Description.
>>
>> This feature depends on the Extended-Length SCCB (els) feature. If
>> els is not present, then a warning will be printed and the SCLP bit
>> that allows the Linux kernel to execute the instruction will not be
>> set.
>>
>> Availability of this instruction is determined by byte 134 (aka fac134)
>> bit 0 of the SCLP Read Info block. This coincidentally expands into the
>> space used for CPU entries, which means VMs running with the diag318
>> capability may not be able to read information regarding all CPUs
>> unless the guest kernel supports an extended-length SCCB.
>>
>> This feature is not supported in protected virtualization mode.
>>
>> Signed-off-by: Collin Walling <walling@linux.ibm.com>
>> Acked-by: Janosch Frank <frankja@linux.ibm.com>
>> ---
>>  hw/s390x/sclp.c                     |  5 +++++
>>  include/hw/s390x/sclp.h             |  3 +++
>>  target/s390x/cpu.h                  |  2 ++
>>  target/s390x/cpu_features.h         |  1 +
>>  target/s390x/cpu_features_def.h.inc |  3 +++
>>  target/s390x/cpu_models.c           |  1 +
>>  target/s390x/gen-features.c         |  1 +
>>  target/s390x/kvm.c                  | 31 +++++++++++++++++++++++++++++
>>  target/s390x/machine.c              | 17 ++++++++++++++++
>>  9 files changed, 64 insertions(+)
>>
>> diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
>> index 87d468087b..ad5d70e14d 100644
>> --- a/hw/s390x/sclp.c
>> +++ b/hw/s390x/sclp.c
>> @@ -139,6 +139,11 @@ static void read_SCP_info(SCLPDevice *sclp, SCCB *sccb)
>>      s390_get_feat_block(S390_FEAT_TYPE_SCLP_CONF_CHAR_EXT,
>>                           read_info->conf_char_ext);
>>  
>> +    if (s390_has_feat(S390_FEAT_EXTENDED_LENGTH_SCCB)) {
>> +        s390_get_feat_block(S390_FEAT_TYPE_SCLP_FAC134,
>> +                            &read_info->fac134);
>> +    }
> 
> Wasn't this feature also possible if there are less than 240 CPUs? Or do
> I mix that up with something else? ... well, maybe it's best anyway if
> we only allow this when ELS is enabled.

Hmmm, looking at the location of fac134 (i.e. offset 134) and the
previous location of the CPU entries (i.e. offset 128), I think I just
mixed this up with something different. So please never mind this question.

 Thomas


