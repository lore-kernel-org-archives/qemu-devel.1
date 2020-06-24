Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F484C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 17:22:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08C2B2078D
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 17:22:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HTew5hNr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08C2B2078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35196 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jo96m-0008BO-AY
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 13:22:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58446)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1jo8oT-0004k7-Bt
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 13:03:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32538
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1jo8oR-0005Zj-50
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 13:03:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593018230;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SLEatqVNlkcqB3fjCKJjp7utMUgjc7lJx9oB9/HGCF8=;
 b=HTew5hNrOsbSFY7vc3wMX3GVpyGjjM5L1fdoZX+cwqkU6ea2/kaGio0QHSh1I2DIbsSZ1Y
 UVk0pK4CZgVmXltg8Uz1LnWmSPtaKqXi4umlZ5Xm85zD2nL35zA4A9fw7fIIw+0MR52aph
 45ZEVOO1ZokoF96o4aLBlY4BbpWlDMQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-148-9OarDQkzNuiaOuEIGSRt_g-1; Wed, 24 Jun 2020 13:03:47 -0400
X-MC-Unique: 9OarDQkzNuiaOuEIGSRt_g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0E853805EE1;
 Wed, 24 Jun 2020 17:03:47 +0000 (UTC)
Received: from [10.36.114.197] (ovpn-114-197.ams2.redhat.com [10.36.114.197])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 470D410190DF;
 Wed, 24 Jun 2020 17:03:36 +0000 (UTC)
Subject: Re: [PATCH v2 1/2] qom: Introduce object_property_try_add_child()
To: Paolo Bonzini <pbonzini@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, berrange@redhat.com, ehabkost@redhat.com,
 armbru@redhat.com
References: <20200624124301.7112-1-eric.auger@redhat.com>
 <20200624124301.7112-2-eric.auger@redhat.com>
 <1a144355-27bd-a26f-752e-00c2751d3a1f@redhat.com>
 <2bf606dd-4ed3-ec65-3dc2-72089bc7cef5@redhat.com>
 <430f6b32-8456-ac1d-72b3-85e0e59ae9b5@redhat.com>
 <3f1aafa9-aedb-b067-7eb7-5d9bc7ce49d1@redhat.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <2aeae131-38e3-7106-0175-b38b7c50f70d@redhat.com>
Date: Wed, 24 Jun 2020 19:03:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <3f1aafa9-aedb-b067-7eb7-5d9bc7ce49d1@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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

On 6/24/20 6:16 PM, Paolo Bonzini wrote:
> On 24/06/20 18:02, Auger Eric wrote:
>> Hi Paolo,
>>
>> On 6/24/20 4:17 PM, Auger Eric wrote:
>>> Hi Paolo,
>>>
>>> On 6/24/20 4:12 PM, Paolo Bonzini wrote:
>>>> On 24/06/20 14:43, Eric Auger wrote:
>>>>> +    op = object_property_try_add(obj, name, type, object_get_child_property,
>>>>> +                                 NULL, object_finalize_child_property,
>>>>> +                                 child, errp);
>>>>> +    if (!op) {
>>>>> +        goto out;
>>>>> +    }
>>>>>      op->resolve = object_resolve_child_property;
>>>>> +out:
>>>>>      object_ref(child);
>>>>>      child->parent = obj;
>>>>>      return op;
>>>>
>>>> I think if there's an error you need to return NULL without ref-ing
>>>> child, shouldn't you?
>>> hum yes you're fully right, the out label is badly placed.
>> Looks the unref is done in user_creatable_add_type() in case of error.
> 
> There are two references involved:
> 
> - a reference returned from object_new.  user_creatable_add_type()
> passes it back to the caller.  The object_unref() you found is done
> before returning NULL, because in that case nothing is being passed to
> the caller
> 
> - a reference stored in child->parent.  In case of error that reference
> is dropped with object_property_del before returning NULL.

> object_property_try_add_child must not store anything in child->parent
> in case of error, and therefore it need not add that reference either.
> 
> I hope this is clearer.

Yes it helps. Thank you for the clarifications.

Eric
> 
> Thanks,
> 
> Paolo
> 
>> Isn't it the corresponding one? Anyway I think it is better to avoid
>> getting the ref here as you suggest (and also free type) and don't unref
>> in user_creatable_add_type.
>>
>> Thanks
>>
>> Eric
>>>>
>>>> You can then add another test that object_property_add_child succeeds
>>>> after object_property_try_add_child fails.
>>> OK
>>>
>>> Thanks
>>>
>>> Eric
>>>>
>>>> Paolo
>>>>
>>
> 
> 


