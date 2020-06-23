Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2CBAC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 15:17:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D4072073E
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 15:17:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I3thIC+y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D4072073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40586 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnkfi-0008TV-Mh
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 11:17:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43000)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jnkeN-0007H4-H6
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 11:15:51 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:55021
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jnkeJ-0000Rv-LQ
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 11:15:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592925346;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nNji3fnmV0Yr7TVzEVLMLP+ZFv2zrXLWKeKJ2u2GAAg=;
 b=I3thIC+yVMp8QNu/nEysmymMYOQyCXBwdKLbGBq4YATLMdi2Z7bYWc9EpooTY4Ny5O3E0t
 L7o1gE+/vgS90EcCD3x5jVuZcp2dhWYtm9BKQpM+RqGgnj7OvYj45ttI7NLpOgcq5g7lrb
 EOfnfKk1fkzLmGZzYLhXn93BJuGMzCM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-148-NUv1OQRDObyPD8f760ifzA-1; Tue, 23 Jun 2020 11:15:44 -0400
X-MC-Unique: NUv1OQRDObyPD8f760ifzA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3F204107ACCA;
 Tue, 23 Jun 2020 15:15:43 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-121.ams2.redhat.com
 [10.36.112.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 76E075D9E7;
 Tue, 23 Jun 2020 15:15:34 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id F07E4113846D; Tue, 23 Jun 2020 17:15:32 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH v3 1/5] qdev: Introduce DEFINE_PROP_RESERVED_REGION
References: <20200611151209.22547-1-eric.auger@redhat.com>
 <20200611151209.22547-2-eric.auger@redhat.com>
 <87k0zzz6nt.fsf@dusky.pond.sub.org>
 <f0ec7470-d683-1bfd-103d-54c57ebd3863@redhat.com>
Date: Tue, 23 Jun 2020 17:15:32 +0200
In-Reply-To: <f0ec7470-d683-1bfd-103d-54c57ebd3863@redhat.com> (Auger Eric's
 message of "Tue, 23 Jun 2020 10:22:47 +0200")
Message-ID: <87imfhhkyz.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/23 01:55:08
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
Cc: peter.maydell@linaro.org, jean-philippe@linaro.org, mst@redhat.com,
 qemu-devel@nongnu.org, peterx@redhat.com, qemu-arm@nongnu.org,
 pbonzini@redhat.com, bbhushan2@marvell.com, eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Auger Eric <eric.auger@redhat.com> writes:

> Hi Markus,
>
> On 6/22/20 1:22 PM, Markus Armbruster wrote:
>> Eric Auger <eric.auger@redhat.com> writes:
>> 
>>> Introduce a new property defining a reserved region:
>>> <low address>, <high address>, <type>.
[...]
>> I dimly remember discussing the wisdom of numeric type here, dig, dig,
>> ..., aha:
>> 
>>     Subject: Re: [PATCH for-5.0 v11 12/20] qapi: Introduce DEFINE_PROP_INTERVAL
>>     Date: Fri, 13 Dec 2019 11:03:02 +0100
>>     Message-ID: <87y2vg4k6h.fsf@dusky.pond.sub.org>
>> 
>>     >> So the "label" part of "<low address>,<high address>,label" is a number?
>>     > yes it is.
>>     >> 
>>     >> Is a number appropriate for your use case, or would an enum be better?
>>     > I think a number is OK. There might be other types of reserved regions
>>     > in the future. Also if we want to allow somebody else to reuse that
>>     > property in another context, I would rather leave it open?
>> 
>>     I'd prioritize the user interface over possible reuse (which might never
>>     happen).  Mind, I'm not telling you using numbers is a bad user
>>     interface.  In general, enums are nicer, but I don't know enough about
>>     this particular case.
> Yep I remember too ;-) I left as it was because I think this property
> could be used for other use cases.

YAGNI :)

A string would work, too, wouldn't it?

[...]


