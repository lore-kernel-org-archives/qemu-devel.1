Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ED31C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:19:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C8C3204FD
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:19:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RlVN2BB8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C8C3204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47096 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3Yvb-0000Ya-FE
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 01:58:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33524)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1k3Yuy-0008UW-Vi
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 01:58:20 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:54179
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1k3Yuv-0007Sy-HU
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 01:58:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596693496;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qgLL9cOcH7qQV82RklRs31aBdoozROk3oS0LYNFlklI=;
 b=RlVN2BB8nrGgIH6+0UfQVtsQe/rfiDTplb+wDSqbUni4QMDQc2jiHJ5JlWPsLrzWfpHl/C
 SBC9VzHE9aH5y5sKJPYto1dBy0JScLFHs96SFBlyCWbBIFl941yRfxmdXEeIcRr2TWwK9c
 rA+S+TB4rjGv5tMTDUeVyPQEoelR7zM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-394-Q0cE0pSMPcSYkiJS_Cn_lg-1; Thu, 06 Aug 2020 01:58:12 -0400
X-MC-Unique: Q0cE0pSMPcSYkiJS_Cn_lg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5EE56800475;
 Thu,  6 Aug 2020 05:58:11 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F41725F21A;
 Thu,  6 Aug 2020 05:58:07 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 787DC1132801; Thu,  6 Aug 2020 07:58:06 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: [PATCH] ide: Get rid of IDEDrive struct
References: <20200805194812.1735218-1-ehabkost@redhat.com>
 <CAFEAcA8-REfRgq=713Tq9PfSNmRPZVzBKmLzoWLauZjqF5q5eQ@mail.gmail.com>
 <20200805221417.GC1700540@habkost.net>
Date: Thu, 06 Aug 2020 07:58:06 +0200
In-Reply-To: <20200805221417.GC1700540@habkost.net> (Eduardo Habkost's message
 of "Wed, 5 Aug 2020 18:14:17 -0400")
Message-ID: <877ducb9jl.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/06 00:07:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Gerd Hoffmann <kraxel@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Eduardo Habkost <ehabkost@redhat.com> writes:

> On Wed, Aug 05, 2020 at 09:41:25PM +0100, Peter Maydell wrote:
>> On Wed, 5 Aug 2020 at 20:49, Eduardo Habkost <ehabkost@redhat.com> wrote:
>> >
>> > The struct had a single field (IDEDevice dev), and is only used
>> > in the QOM type declarations and property lists.  We can simply
>> > use the IDEDevice struct directly instead.
>> >
>> > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
>> > @@ -327,7 +323,6 @@ static void ide_hd_class_init(ObjectClass *klass, void *data)
>> >  static const TypeInfo ide_hd_info = {
>> >      .name          = "ide-hd",
>> >      .parent        = TYPE_IDE_DEVICE,
>> > -    .instance_size = sizeof(IDEDrive),
>> >      .class_init    = ide_hd_class_init,
>> >  };
>> 
>> This is one of those areas where this change works and reduces
>> amount of code, but on the other hand it means the QOM type
>> doesn't follow the common pattern for a leaf type of:
>>  * it has a struct
>>  * it has cast macros that cast to that struct
>>  * the typeinfo instance_size is the size of that struct
>> (it wasn't exactly following this pattern before, of course).
>
> Is this really a pattern that exists and we want to follow?
> I don't see why that pattern would be useful for simple leaf
> types.

I think the pattern exists, but we deviate from it in quite a few
places, probably just because it's so much boilerplate.

Related: Daniel's "[PATCH 0/4] qom: reduce boilerplate required for
declaring and defining objects".  Perhaps Daniel has an opinion on
taking shortcuts with leaf types.

> Also, in this case the code wasn't even following that pattern:
> it was using the same IDEDrive struct for all TYPE_IDE_DEVICE
> subtypes.

Rule of thumb: hw/ide/ is a bad example.  I don't mean to belittle the
efforts of quite a few people over the years.  It used to be worse.

>> We define in https://wiki.qemu.org/Documentation/QOMConventions
>> (in the 'When to create class types and macros' bit at the bottom)
>> what we expect for whether to provide class cast macros/a
>> class struct/class_size in the TypeInfo, essentially recommending
>> that types follow one of two patterns (simple leaf class with no
>> methods or class members, vs everything else) even if in a
>> particular case you could take a short-cut and not define
>> everything. We haven't really defined similar "this is the
>> standard pattern, provide it all even if you don't strictly
>> need it" rules for the instance struct/macros. Maybe we should?
>
> I think we should include the instance struct/macros in the
> recommendations there, but I would expect those recommendations
> to apply only to non-leaf types.

I'm fine with having a separate convention for leaf types if that helps,
but please let's have a convention.  I like my QOM boilerplate
uncreative.

>> Just a thought, not a nak; I know we have quite a number
>> of types that take this kind of "we don't really need to
>> provide all the standard QOM macros/structs/etc" approach
>> (some of which I wrote!).
>> 
>> thanks
>> -- PMM
>> 


