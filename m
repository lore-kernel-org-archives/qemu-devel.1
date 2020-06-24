Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87F81C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 16:18:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54EE420768
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 16:18:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MUZNAPkD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54EE420768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jo86I-0003lm-Js
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 12:18:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43582)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jo85K-00035Y-2S
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 12:17:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54627
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jo85A-0002SE-9z
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 12:17:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593015423;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FbM/CPvyt3jaOI2mSSud/c7XovERgJozOYDZ6NhmT0s=;
 b=MUZNAPkDs257y1U4pFGXIco1GYWRO48uffUrkYkVPstnM0xw3si8vNGL8QriGySiWDnPM4
 mZYQFHur0OqTt+e43gHlTOAJ+NISQQyLwU0SHuqGoKgyu7iMT8D69vLDRrXjCFEgYjjL5Y
 CNwMIgX5kC6jhF29djVAy9mfkWbYskA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-489-mQ2XzhrnO8yfaZYFdg-vMg-1; Wed, 24 Jun 2020 12:16:47 -0400
X-MC-Unique: mQ2XzhrnO8yfaZYFdg-vMg-1
Received: by mail-wm1-f71.google.com with SMTP id a21so2891750wmd.0
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2020 09:16:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=FbM/CPvyt3jaOI2mSSud/c7XovERgJozOYDZ6NhmT0s=;
 b=fqYNHwMGbHPI0/V8kWK2jd0oeHXcnTUbHBRwtvFDJIOYskOuPHecUQiLEmi4mG/kMK
 t2jzkqbpm3qdTNxHqe9yuSAm/HKCkdy1YX26eUit52FZLrqyxpQyWAcsIe6AqLzoOr4m
 o7FSjHVt3WT9SsAXY2iF6XYcaAxh1ZLw86Ox33ogQmUunKC4kNrBMwqGKYnl0qeT+Qm8
 fSNMY0tTx1xvo3x3l3LOlrt2W+a/jHUfM99U3UFPTyN6+iAe+H/+aL6PgimfRlWVjZES
 OAdJpYxaegxDeurI6CkoO+mcIhWWaIdJvdg9+ImI8IE70P6CfFXjP8BVwni4WenOwBOu
 uLgw==
X-Gm-Message-State: AOAM532hgBiI9yLAxZawuHdPtcb95s3M1EAeyd5SiNSDnK4lgW+0YiUK
 bmPjT7WcH5Y9Vmv5FMPDOF3+y1IdKtX5JRTI3zfa379fQ33wwn44uusfQymeS/AR8J527gT8jbT
 Kp6XGkdTOUNVamOQ=
X-Received: by 2002:a7b:cd07:: with SMTP id f7mr18696334wmj.115.1593015404982; 
 Wed, 24 Jun 2020 09:16:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyRYxgjfKwC/oSHU6TBpI0BaQq9ouY3aCu0VeZ8gxdc9NBD+RSWe0FDBKi6gPuNfbEBmoQmPA==
X-Received: by 2002:a7b:cd07:: with SMTP id f7mr18696307wmj.115.1593015404683; 
 Wed, 24 Jun 2020 09:16:44 -0700 (PDT)
Received: from [192.168.178.58] ([151.20.253.55])
 by smtp.gmail.com with ESMTPSA id c20sm24311547wrb.65.2020.06.24.09.16.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jun 2020 09:16:43 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] qom: Introduce object_property_try_add_child()
To: Auger Eric <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, berrange@redhat.com, ehabkost@redhat.com,
 armbru@redhat.com
References: <20200624124301.7112-1-eric.auger@redhat.com>
 <20200624124301.7112-2-eric.auger@redhat.com>
 <1a144355-27bd-a26f-752e-00c2751d3a1f@redhat.com>
 <2bf606dd-4ed3-ec65-3dc2-72089bc7cef5@redhat.com>
 <430f6b32-8456-ac1d-72b3-85e0e59ae9b5@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3f1aafa9-aedb-b067-7eb7-5d9bc7ce49d1@redhat.com>
Date: Wed, 24 Jun 2020 18:16:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <430f6b32-8456-ac1d-72b3-85e0e59ae9b5@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/24 02:33:25
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

On 24/06/20 18:02, Auger Eric wrote:
> Hi Paolo,
> 
> On 6/24/20 4:17 PM, Auger Eric wrote:
>> Hi Paolo,
>>
>> On 6/24/20 4:12 PM, Paolo Bonzini wrote:
>>> On 24/06/20 14:43, Eric Auger wrote:
>>>> +    op = object_property_try_add(obj, name, type, object_get_child_property,
>>>> +                                 NULL, object_finalize_child_property,
>>>> +                                 child, errp);
>>>> +    if (!op) {
>>>> +        goto out;
>>>> +    }
>>>>      op->resolve = object_resolve_child_property;
>>>> +out:
>>>>      object_ref(child);
>>>>      child->parent = obj;
>>>>      return op;
>>>
>>> I think if there's an error you need to return NULL without ref-ing
>>> child, shouldn't you?
>> hum yes you're fully right, the out label is badly placed.
> Looks the unref is done in user_creatable_add_type() in case of error.

There are two references involved:

- a reference returned from object_new.  user_creatable_add_type()
passes it back to the caller.  The object_unref() you found is done
before returning NULL, because in that case nothing is being passed to
the caller

- a reference stored in child->parent.  In case of error that reference
is dropped with object_property_del before returning NULL.
object_property_try_add_child must not store anything in child->parent
in case of error, and therefore it need not add that reference either.

I hope this is clearer.

Thanks,

Paolo

> Isn't it the corresponding one? Anyway I think it is better to avoid
> getting the ref here as you suggest (and also free type) and don't unref
> in user_creatable_add_type.
> 
> Thanks
> 
> Eric
>>>
>>> You can then add another test that object_property_add_child succeeds
>>> after object_property_try_add_child fails.
>> OK
>>
>> Thanks
>>
>> Eric
>>>
>>> Paolo
>>>
> 


