Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DE1AC433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 11:29:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF763221E5
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 11:29:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZDi4EhOF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF763221E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45650 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIVd4-0006Mz-TK
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 07:29:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49042)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kIVcJ-0005WL-5o
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 07:28:51 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:40638
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kIVcH-0005LX-Ej
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 07:28:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600255725;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8vujpt6WjS6pXBFD9WUvkTZK20hVGPt0cDoW+nMAiWM=;
 b=ZDi4EhOFnBF8Wbl7h6PF/9V4VOZ4lqDpUE9Cx0ybvZgaM/4xtKp/3zdcGSlFMyuCxJJ9Lj
 SKjrWn/QEtOb3DmDGGum9pyzqyS+rvFMuX7vNydgfidjbq9YAO7E/SW2GOJNUoBmyx6Zcd
 xheGLTZOJYXiVyYL9FThfbxo/g4KkcU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-389-aoxuEYk8NGemAvse3xHnhg-1; Wed, 16 Sep 2020 07:28:41 -0400
X-MC-Unique: aoxuEYk8NGemAvse3xHnhg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 39F7D100746D;
 Wed, 16 Sep 2020 11:28:39 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-114-66.ams2.redhat.com
 [10.36.114.66])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 38B0060CCC;
 Wed, 16 Sep 2020 11:28:34 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 78B78113864A; Wed, 16 Sep 2020 13:28:33 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Alexey Kirillov <lekiravi@yandex-team.ru>
Subject: Re: [PATCH v3 1/4] qapi: net: Add query-netdevs command
References: <20200901182326.59633-1-lekiravi@yandex-team.ru>
 <20200901182326.59633-2-lekiravi@yandex-team.ru>
 <87lfhsjubv.fsf@dusky.pond.sub.org>
 <37711599469320@mail.yandex-team.ru>
 <871rjdrca0.fsf@dusky.pond.sub.org>
 <b632d444-bdf9-648b-9d55-a9e72efb8fbc@redhat.com>
 <87tuw8731m.fsf@dusky.pond.sub.org>
 <32031600248373@mail.yandex-team.ru>
Date: Wed, 16 Sep 2020 13:28:33 +0200
In-Reply-To: <32031600248373@mail.yandex-team.ru> (Alexey Kirillov's message
 of "Wed, 16 Sep 2020 12:37:27 +0300")
Message-ID: <87mu1qot9a.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 02:41:36
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Jason Wang <jasowang@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Vincenzo Maffione <v.maffione@gmail.com>, Luigi Rizzo <rizzo@iet.unipi.it>,
 "yc-core@yandex-team.ru" <yc-core@yandex-team.ru>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Alexey Kirillov <lekiravi@yandex-team.ru> writes:

> 08.09.2020, 17:32, "Markus Armbruster" <armbru@redhat.com>:
>> Eric Blake <eblake@redhat.com> writes:
>>
>>> =C2=A0On 9/7/20 7:39 AM, Markus Armbruster wrote:
>>>
>>>>>> =C2=A0This is union Netdev plus a common member @peer-id, less the v=
ariant
>>>>>> =C2=A0members for NetClientDriver values 'nic' and 'hubport'.
>>>>>>
>>>>>> =C2=A0Can 'type: 'nic' and 'type': 'hubport' occur?
>>>>>
>>>>> =C2=A0No, it can't. We don't support NIC/hubport in query-netdevs, so=
 we neither create this
>>>>> =C2=A0structure for them, nor store config.
>>>> =C2=A0Same for 'none', I guess.
>>>> =C2=A0As defined, NetdevInfo allows types 'none', 'nic', and 'hubport'=
, it
>>>> =C2=A0just has no variant members for them. The fact that they can't o=
ccur is
>>>> =C2=A0not coded into the type, and therefore not visible in introspect=
ion.
>>>> =C2=A0To make introspection more precise, we'd have to define a new en=
um
>>>> =C2=A0type.
>>>> =C2=A0How much that would complicate the C code is unclear.
>>>> =C2=A0Do we need it to be more precise? Eric, got an opinion?
>>>
>>> =C2=A0Is the problem that a new enum would be duplicating things?
>>
>> Enumerating network drivers twice is mildly annoying. I worry more
>> about having to convert between the two enumerations in C.
>>
>> My actual question: do we need query-qmp-schema report the precise set
>> of 'type' values? As is, it reports a few that can't actually occur.
>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0Is it
>>> =C2=A0worth allowing one enum to have a 'base':'OtherEnum' in the schem=
a to
>>> =C2=A0reduce some of the duplication?
>>
>> We could then generate functions (or macros) to convert from base enum
>> to extended enum, and back, where the latter can fail.
>>
>> Worthwhile only if we have sufficient use for it.
>
> I'm sorry, did I understand correctly that at the moment I don't need any
> additional changes in the patch yet?

Depends on how we answer my question: do we need query-qmp-schema report
the precise set of 'type' values?  As is, it reports a few that can't
actually occur.

If we need it to be precise, you have to define a suitable enum.

Else, you may define such an enum, or reuse NetClientDriver.

If no clear answer emerges, the decision devolves to the maintainer in
charge (Jason, I think).

In my opinion, defining a suitable enum is the more prudent choice.

It partially duplicates NetClientDriver.  No big deal for the schema, as
you already duplicate most of Netdev.  Possibly awkward in C, but to
know for sure, we'd have to try.

> If that is, I will continue using NetClientDriver as a discriminator.


