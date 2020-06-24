Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83BC5C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 14:21:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 500B72072E
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 14:21:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HfAAocpX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 500B72072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40364 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jo6HF-0003Bl-J7
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 10:21:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35084)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1jo6DX-0004xE-8r
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 10:17:35 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38437
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1jo6DT-0007s2-HW
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 10:17:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593008250;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SUeNPmjIjuEXiKXFTxyuFJ1oBBZ0LYUOBP3n1hqvpOA=;
 b=HfAAocpXHBMgkdo1mLTIHSmjBKzpF/QnEvFoLGpPsmyv43/EHwCfvB+HRFqSd4apzX8uFV
 oRMUPr+qLs/2PSvdpvP1V7x4fqmLGraKNzf6kP3nwaatd0pybbxqp2+Vb0SQrrFmw8094f
 X9FjkuyXKpOYw/OLD38nfpn/qV+ztkI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-24-ZemPtcDWNsKe9h03Nl4sjg-1; Wed, 24 Jun 2020 10:17:25 -0400
X-MC-Unique: ZemPtcDWNsKe9h03Nl4sjg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E3A4819057A9;
 Wed, 24 Jun 2020 14:17:24 +0000 (UTC)
Received: from [10.36.114.197] (ovpn-114-197.ams2.redhat.com [10.36.114.197])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 720D510023A6;
 Wed, 24 Jun 2020 14:17:23 +0000 (UTC)
Subject: Re: [PATCH v2 1/2] qom: Introduce object_property_try_add_child()
To: Paolo Bonzini <pbonzini@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, berrange@redhat.com, ehabkost@redhat.com,
 armbru@redhat.com
References: <20200624124301.7112-1-eric.auger@redhat.com>
 <20200624124301.7112-2-eric.auger@redhat.com>
 <1a144355-27bd-a26f-752e-00c2751d3a1f@redhat.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <2bf606dd-4ed3-ec65-3dc2-72089bc7cef5@redhat.com>
Date: Wed, 24 Jun 2020 16:17:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1a144355-27bd-a26f-752e-00c2751d3a1f@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eric.auger@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/24 03:27:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Paolo,

On 6/24/20 4:12 PM, Paolo Bonzini wrote:
> On 24/06/20 14:43, Eric Auger wrote:
>> +    op = object_property_try_add(obj, name, type, object_get_child_property,
>> +                                 NULL, object_finalize_child_property,
>> +                                 child, errp);
>> +    if (!op) {
>> +        goto out;
>> +    }
>>      op->resolve = object_resolve_child_property;
>> +out:
>>      object_ref(child);
>>      child->parent = obj;
>>      return op;
> 
> I think if there's an error you need to return NULL without ref-ing
> child, shouldn't you?
hum yes you're fully right, the out label is badly placed.
> 
> You can then add another test that object_property_add_child succeeds
> after object_property_try_add_child fails.
OK

Thanks

Eric
> 
> Paolo
> 


