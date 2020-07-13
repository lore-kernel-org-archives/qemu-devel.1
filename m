Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D63EC433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 09:12:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 667CD2067D
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 09:12:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 667CD2067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60258 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juuVt-0000fa-OH
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 05:12:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54646)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1juuV1-0008Eu-Dl
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 05:11:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:49964)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1juuUz-0004NY-Fo
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 05:11:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id EF943AD87;
 Mon, 13 Jul 2020 09:11:45 +0000 (UTC)
Subject: Re: migration: broken snapshot saves appear on s390 when small fields
 in migration stream removed
To: Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>, 
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
References: <8bbafdec-836d-b7de-cab8-7a325b6e238d@suse.de>
 <55c406cd-b9ca-4e9b-0acd-d33cfe2a70e3@redhat.com>
From: Claudio Fontana <cfontana@suse.de>
Message-ID: <bf074240-8cc3-96ff-e95e-bd301822b756@suse.de>
Date: Mon, 13 Jul 2020 11:11:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <55c406cd-b9ca-4e9b-0acd-d33cfe2a70e3@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=195.135.220.15; envelope-from=cfontana@suse.de;
 helo=mx2.suse.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 00:02:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
Cc: "Jason J. Herne" <jjherne@linux.ibm.com>, Fam Zheng <fam@euphon.net>,
 Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Paolo,

On 7/12/20 6:11 PM, Paolo Bonzini wrote:
> On 12/07/20 12:00, Claudio Fontana wrote:
>> Note: only the === -blockdev with a backing file === part of test 267 fails. -blockdev with NBD is ok, like all the rest.
>>
>>
>> Interesting facts about s390 in particular: its save/load code includes the transfer of "storage keys",
>> which include a buffer of 32768 bytes of keydata in the stream.
>>
>> The code (hw/s390x/s390-skeys.c),
>> is modeled similarly to RAM transfer (like in migration/ram.c), with an EOS (end of stream) marker.
>>
>> Countrary to RAM transfer code though, after qemu_put_be64(f, EOS), the s390 code does not qemu_fflush(f).
> 
> 1) Are there unexpected differences in the migration stream?  That is,
> you could modify qcow2.c to fopen/fwrite/fclose the bytes as they're
> written and read, and see if something does not match.

I hooked qcow2_co_pwritev_task and qcow2_co_preadv_task to also write to an external file using your suggestion.

I am seeing very interesting differences with and without the reproducer patch (ie, forcing icount_state_needed to 0 or not):

* without the reproducer patch, everything past the s390-skeys data field is in order: there is the EOS, and then the next idstr follows ("cpu_common").

* with the reproducer patch, every single byte past the s390-skeys data field is ZERO. There is no EOS, there is no next idstr "cpu_common", there is absolutely nothing else than zeroes until the end of the file.


> 
> 2) If it matches, are there unexpected differences other than the lack
> of icount section when you apply the reproducer patch?

they do not match at all.


> 
> The fflush part makes me put more hope in the first, but both could help
> you debug it.
> 
> Thanks,
> 
> Paolo
> 

Thanks,

Claudio

