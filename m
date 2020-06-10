Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0712EC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 09:05:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF3462064C
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 09:05:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PlkW2/XS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF3462064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiwfX-0002uv-SU
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 05:05:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44574)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jiweR-0002E6-B8
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 05:04:03 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:30517
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jiweQ-0002XO-6X
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 05:04:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591779841;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=l8/+qVit4CGPLAz3Vn6xaxBgtqaYN7HTurCdSlZs49k=;
 b=PlkW2/XSEulpvGy6FAkYmc57TR/6KpXZ1hLFlSiyhtdyGb1byp6CPXfp4jdwHkZ6NY4bam
 XFD7/eEFHv5YnInssGNbhbuVy0ZSphieNTVv1v4Ht/FXABXOl7p/R0N0tTqQasVKs+qtOO
 M+28C7D/FDezjuriKQnZJqHStSL74Rs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-443-i0NCWRDxMK-ywvV2KcHJLQ-1; Wed, 10 Jun 2020 05:03:57 -0400
X-MC-Unique: i0NCWRDxMK-ywvV2KcHJLQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9BBD4805738;
 Wed, 10 Jun 2020 09:03:54 +0000 (UTC)
Received: from thuth.remote.csb (unknown [10.40.192.19])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AD2E31017CD3;
 Wed, 10 Jun 2020 09:03:41 +0000 (UTC)
Subject: Re: [PATCH] hw/vfio/pci-quirks: Fix broken legacy IGD passthrough
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, qemu-devel@nongnu.org
References: <20200610035102.20192-1-thuth@redhat.com>
 <706060db-46c4-2dee-d746-eba24e6b137d@redhat.com>
 <a8195883-fb78-0cc1-5e15-e100dcb807de@redhat.com>
 <fd82556f-297d-6634-1bb2-37c4da415a50@redhat.com>
 <c3f40a57-e511-6b31-1a13-01acb38b0843@redhat.com>
 <4bdc918a-a59c-a877-680a-2925c09fc736@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <04979308-3a35-4e40-35c7-836a36e47143@redhat.com>
Date: Wed, 10 Jun 2020 11:03:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <4bdc918a-a59c-a877-680a-2925c09fc736@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 23:22:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: qemu-trivial@nongnu.org, qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/06/2020 10.25, Philippe Mathieu-Daudé wrote:
> On 6/10/20 9:59 AM, Thomas Huth wrote:
>> On 10/06/2020 09.53, Philippe Mathieu-Daudé wrote:
>>> On 6/10/20 9:50 AM, Thomas Huth wrote:
>>>> On 10/06/2020 09.31, Philippe Mathieu-Daudé wrote:
>>>>> On 6/10/20 5:51 AM, Thomas Huth wrote:
>>>>>> The #ifdef CONFIG_VFIO_IGD in pci-quirks.c is not working since the
>>>>>> required header config-devices.h is not included, so that the legacy
>>>>>> IGD passthrough is currently broken. Let's include the right header
>>>>>> to fix this issue.
>>>>>>
>>>>>> Buglink: https://bugs.launchpad.net/qemu/+bug/1882784
>>>>>> Fixes: 29d62771c81d8fd244a67c14a1d968c268d3fb19
>>>>>>        ("hw/vfio: Move the IGD quirk code to a separate file")
>>>>>
>>>>> What about shorter tag?
>>>>>
>>>>> Fixes: 29d62771c81 ("vfio: Move the IGD quirk code to a separate file")
>>>>
>>>> I always forget whether to use the short or the long version for
>>>> "Fixes:" ... this can hopefully be fixed (if necessary) when the patch
>>>> gets picked up.
>>>>
>>>>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>>>>> ---
>>>>>>  hw/vfio/pci-quirks.c | 1 +
>>>>>>  1 file changed, 1 insertion(+)
>>>>>>
>>>>>> diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
>>>>>> index f2155ddb1d..3158390db1 100644
>>>>>> --- a/hw/vfio/pci-quirks.c
>>>>>> +++ b/hw/vfio/pci-quirks.c
>>>>>> @@ -11,6 +11,7 @@
>>>>>>   */
>>>>>>  
>>>>>>  #include "qemu/osdep.h"
>>>>>> +#include "config-devices.h"
>>>>>
>>>>> I've been wondering how we can avoid that mistake in the
>>>>> future, but can find anything beside human review.
>>>>
>>>> I think in the long term, we should include config-devices.h in osdep.h,
>>>> just like config-host.h and config-target.h is already included there.
>>>> Everything else is just too confusing. But then we should also add a
>>>> mechanism to poison the switches from config-devices.h in common code...
>>>
>>> We only need it for the files under hw/, right?
>>
>> qtest.c in the main directory includes it, too.
> 
> hw/ and qtests could include "hw/hw.h" instead of affecting all the
> codebase via "qemu/osdep.h".

I don't think that's a good idea - in that case, you have to make sure
to include hw/hw.h everywhere again, so you don't gain that much
compared to including config-devices.h directly everywhere. osdep.h is
our header that has to be included everywhere, so if we want to make
sure that these defines are available everywhere, we have to include it
from osdep.h.
Apart from that, hw/hw.h just contains one more prototype - which likely
should be renamed to cpu_hw_error() and moved to a cpu header instead,
so that we can finally delete hw/hw.h completely.

 Thomas


