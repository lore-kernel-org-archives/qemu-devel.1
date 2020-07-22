Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78C81C433F8
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 14:40:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46AAF207CD
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 14:40:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q3Urpl9Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46AAF207CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37386 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyFvR-0008JA-Dp
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 10:40:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59798)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dinechin@redhat.com>)
 id 1jyFuX-0007rX-9n
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 10:39:57 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58514
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dinechin@redhat.com>)
 id 1jyFuU-00030u-Jb
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 10:39:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595428792;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EZf68w8/FbemYIOSby2PYckdA3zPWlrm19apHs2CFxw=;
 b=Q3Urpl9Yu7U8a5xX3ct9BtFJk4CPAiKweq/gxtWRRREv5rOAAuuo/3KCYoN1pfbOZyym47
 ZHA1jCAcyvBxVYRRd3wxet/Mhj2PU1LKf9LBxPH9qru2/2mzQxiyzSfznceHUvPD3MSp3u
 PAhGSE2xtyi7aLC1kmY9aprAK7dw70A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-406-L6ynU8XLPHmvmJ4BWIdTOQ-1; Wed, 22 Jul 2020 10:39:51 -0400
X-MC-Unique: L6ynU8XLPHmvmJ4BWIdTOQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3676D57
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2020 14:39:50 +0000 (UTC)
Received: from titinator (ovpn-113-160.ams2.redhat.com [10.36.113.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 121FB88D40;
 Wed, 22 Jul 2020 14:39:42 +0000 (UTC)
References: <20200624131045.14512-1-kraxel@redhat.com>
 <20200624131045.14512-4-kraxel@redhat.com>
 <7hft9mmfg6.fsf@turbo.dinechin.lan>
 <20200721142753.v2be4d2mdh435gtv@sirius.home.kraxel.org>
 <ly365kht40.fsf@redhat.com>
 <20200722110549.utfggzytjvedjmoo@sirius.home.kraxel.org>
User-agent: mu4e 1.5.2; emacs 26.3
From: Christophe de Dinechin <dinechin@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v5 03/10] qdev: device module support
In-reply-to: <20200722110549.utfggzytjvedjmoo@sirius.home.kraxel.org>
Date: Wed, 22 Jul 2020 16:39:41 +0200
Message-ID: <lyo8o7havm.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=205.139.110.120; envelope-from=dinechin@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/21 23:27:14
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr?= =?utf-8?Q?=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020-07-22 at 13:05 CEST, Gerd Hoffmann wrote...
> On Wed, Jul 22, 2020 at 10:05:51AM +0200, Christophe de Dinechin wrote:
>>
>> On 2020-07-21 at 16:27 CEST, Gerd Hoffmann wrote...
>> >   Hi,
>> >
>> >> >  DeviceState *qdev_new(const char *name)
>> >> >  {
>> >> > +    if (!object_class_by_name(name)) {
>> >> > +        module_load_qom_one(name);
>> >> > +    }
>> >>
>> >> Curious why you don't you call module_object_class_by_name here?
>> >
>> > Because object_new() wants a name not an ObjectClass ...
>>
>> I'm talking about the two lines above.
>>
>>     if (!object_class_by_name(name)) {
>>         module_load_qom_one(name);
>>     }
>>
>> Thi9s code looks very similar to the code below:
>>
>>     ObjectClass *module_object_class_by_name(const char *typename)
>>     {
>>         ObjectClass *oc;
>>
>>         oc = object_class_by_name(typename);
>>     #ifdef CONFIG_MODULES
>>         if (!oc) {
>>             module_load_qom_one(typename);
>>             oc = object_class_by_name(typename);
>>         }
>>     #endif
>>         return oc;
>>     }
>>
>> Both call module_load_qom_one and object_class_by_name using the name as
>> input, so I don't see the difference (except for the order).
>
> Yes, calling module_object_class_by_name then throw away the result
> would work too.  I don't like the idea to hide the module loading
> though.

Why do you consider calling a function called "module_object_class_by_name"
as hiding the module loading?

More importantly, why is it better to have two ways to do the same thing
that are slightly different? The reason for the slight difference is really
unclear to me. If we later do a change to module_object_class_by_name, are
there cases where we won't need the same change in qdev_new?

>
> take care,
>   Gerd


--
Cheers,
Christophe de Dinechin (IRC c3d)


