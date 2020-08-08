Return-Path: <SRS0=zX6u=BS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 526E5C433E0
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Aug 2020 00:03:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B082214F1
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Aug 2020 00:03:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zfi5nsYc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B082214F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k4CKc-0002C1-9M
	for qemu-devel@archiver.kernel.org; Fri, 07 Aug 2020 20:03:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37712)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1k4CJD-0001DZ-Lz
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 20:01:59 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:50275
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1k4CJA-0001KP-Ht
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 20:01:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596844915;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IMElak0HyyUnQ2gNitKuCgijFqOgFceaR0wey9rXHLs=;
 b=Zfi5nsYceVSSxSavlQjHD5Zx6Ht2wMMo6e6ClRACrFZusdCfNLu6PU+eySmmzZniO9yodA
 YLDEs92ILa2PEYTvzqAZmFfPfROXlmNG1CaZ1n1KXy/YPCcthDnO2vrHI2x28hVY+falOb
 2RaltI7LWe2/N9usgYo+zTCPiSUd2zU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-135-QsbvqSDkO0OB7SwL5FB7Qg-1; Fri, 07 Aug 2020 20:01:49 -0400
X-MC-Unique: QsbvqSDkO0OB7SwL5FB7Qg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 43B081DE2;
 Sat,  8 Aug 2020 00:01:48 +0000 (UTC)
Received: from ibm-p8-OVS-01-fsp.mgmt.pnr.lab.eng.rdu2.redhat.com
 (ovpn-117-40.rdu2.redhat.com [10.10.117.40])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C30C865C9E;
 Sat,  8 Aug 2020 00:01:43 +0000 (UTC)
Subject: Re: [PATCH] ide: Get rid of IDEDrive struct
To: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>
References: <20200805194812.1735218-1-ehabkost@redhat.com>
 <CAFEAcA8-REfRgq=713Tq9PfSNmRPZVzBKmLzoWLauZjqF5q5eQ@mail.gmail.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <4c37a3ce-7018-931c-8c85-744622a97e08@redhat.com>
Date: Fri, 7 Aug 2020 20:01:43 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8-REfRgq=713Tq9PfSNmRPZVzBKmLzoWLauZjqF5q5eQ@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/07 20:01:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/5/20 4:41 PM, Peter Maydell wrote:
> On Wed, 5 Aug 2020 at 20:49, Eduardo Habkost <ehabkost@redhat.com> wrote:
>>
>> The struct had a single field (IDEDevice dev), and is only used
>> in the QOM type declarations and property lists.  We can simply
>> use the IDEDevice struct directly instead.
>>
>> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
>> @@ -327,7 +323,6 @@ static void ide_hd_class_init(ObjectClass *klass, void *data)
>>   static const TypeInfo ide_hd_info = {
>>       .name          = "ide-hd",
>>       .parent        = TYPE_IDE_DEVICE,
>> -    .instance_size = sizeof(IDEDrive),
>>       .class_init    = ide_hd_class_init,
>>   };
> 
> This is one of those areas where this change works and reduces
> amount of code, but on the other hand it means the QOM type
> doesn't follow the common pattern for a leaf type of:
>   * it has a struct
>   * it has cast macros that cast to that struct
>   * the typeinfo instance_size is the size of that struct
> (it wasn't exactly following this pattern before, of course).
> 
> We define in https://wiki.qemu.org/Documentation/QOMConventions
> (in the 'When to create class types and macros' bit at the bottom)
> what we expect for whether to provide class cast macros/a
> class struct/class_size in the TypeInfo, essentially recommending
> that types follow one of two patterns (simple leaf class with no
> methods or class members, vs everything else) even if in a
> particular case you could take a short-cut and not define
> everything. We haven't really defined similar "this is the
> standard pattern, provide it all even if you don't strictly
> need it" rules for the instance struct/macros. Maybe we should?
> 
> Just a thought, not a nak; I know we have quite a number
> of types that take this kind of "we don't really need to
> provide all the standard QOM macros/structs/etc" approach
> (some of which I wrote!).
> 

I'll defer to your judgment here. The IDE stuff is very confusing, but I 
don't know the best way to wrangle it to make it less confusing.

I assume at some point migration compatibility gets in the way of any 
REAL refactoring that might start to make this code make more sense.

Open to suggestions.

--js


