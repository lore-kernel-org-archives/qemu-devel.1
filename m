Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9BAFC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 06:21:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8117C206DC
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 06:21:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LVaA+hrt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8117C206DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgjFR-0000gM-MU
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 02:21:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37976)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jgjEP-0008KT-TS
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 02:20:02 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:27946
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jgjEN-0004Dj-LR
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 02:20:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591251597;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=zpbcGVUCNteZ9/Y7kbTuY5UyfsuVP7suSkfOm4CTvbY=;
 b=LVaA+hrt1oAxNwFJB0UjLxHq+mveImV9JrYYqY7Sa7SmSuxvygPDDa1bU6BVOhtvC7Keur
 d2UrqmCyrnuN0zcqN/aj0w3DiaOTVkGkxquUe9tpig9Cr2vn/C4GHJ1DWRGDD+7T0UAPrF
 lQ2yoJd8+HWEpplnUTGJNTsTZuea6iU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-331--DWPUyhSO5uo2Vlrk2ly3g-1; Thu, 04 Jun 2020 02:19:51 -0400
X-MC-Unique: -DWPUyhSO5uo2Vlrk2ly3g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D3CDD107ACCA;
 Thu,  4 Jun 2020 06:19:49 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-105.ams2.redhat.com [10.36.112.105])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B275810013D7;
 Thu,  4 Jun 2020 06:19:43 +0000 (UTC)
Subject: Re: [RFC v2 14/18] guest memory protection: Rework the
 "memory-encryption" property
To: David Gibson <david@gibson.dropbear.id.au>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20200521034304.340040-1-david@gibson.dropbear.id.au>
 <20200521034304.340040-15-david@gibson.dropbear.id.au>
 <4061fcf0-ba76-5124-74eb-401a0b91d900@linaro.org>
 <20200604055638.GF228651@umbus.fritz.box>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <18d57013-e17d-18c0-25b5-af2b2554f029@redhat.com>
Date: Thu, 4 Jun 2020 08:19:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200604055638.GF228651@umbus.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Received-SPF: pass client-ip=207.211.31.81; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/04 01:31:23
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: pair@us.ibm.com, brijesh.singh@amd.com,
 Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, cohuck@redhat.com,
 qemu-devel@nongnu.org, dgilbert@redhat.com, frankja@linux.ibm.com,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 mdroth@linux.vnet.ibm.com, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 04/06/2020 07.56, David Gibson wrote:
> On Mon, Jun 01, 2020 at 08:54:42PM -0700, Richard Henderson wrote:
>> On 5/20/20 8:43 PM, David Gibson wrote:
>>> +++ b/include/hw/boards.h
>>> @@ -12,6 +12,8 @@
>>>  #include "qom/object.h"
>>>  #include "hw/core/cpu.h"
>>>  
>>> +typedef struct GuestMemoryProtection GuestMemoryProtection;
>>> +
>>
>> I think this needs to be in include/qemu/typedefs.h,
>> and the other typedef in patch 10 needs to be moved there.
>>
>> IIRC, clang warns about duplicate typedefs.
> 
> Not, apparently, with the clang version I have, but I've made the
> change anyway.

FWIW, we got rid of that duplicated typedef problem in commit
e6e90feedb706b1b92, no need to worry about that anymore.

 Thomas


