Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90321C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 14:32:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 069E221D46
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 14:32:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QVJKQd9M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 069E221D46
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFeg2-0007nv-3R
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 10:32:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39976)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kFefB-0006ss-H8
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 10:32:01 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:54130
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kFef9-0007wF-T1
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 10:32:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599575519;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=igBA7uzjClF/snq6JC+W95Yx3DxrtSnVfy6pvPcdg3Q=;
 b=QVJKQd9Mp8NxdtlptlqTSsjFcmBMeSyWTNodzEstY0P42XvAYUgJqeByhThILMSEsglmac
 MiulPPJhSgMV+OG8YziKiOb1fozotAbm2EmFMsm957l8ls3OGKDX08tON0O+2iolkesXGk
 zpwUkE8LRr7UfwJLoiilE24Kim5aZAU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-313-LFkZ-k5fMPq28jFgZk3SEg-1; Tue, 08 Sep 2020 10:31:57 -0400
X-MC-Unique: LFkZ-k5fMPq28jFgZk3SEg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5146C1005E6A;
 Tue,  8 Sep 2020 14:31:55 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-68.ams2.redhat.com
 [10.36.113.68])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6362327BC3;
 Tue,  8 Sep 2020 14:31:51 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id EA39F113865F; Tue,  8 Sep 2020 16:31:49 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v3 1/4] qapi: net: Add query-netdevs command
References: <20200901182326.59633-1-lekiravi@yandex-team.ru>
 <20200901182326.59633-2-lekiravi@yandex-team.ru>
 <87lfhsjubv.fsf@dusky.pond.sub.org>
 <37711599469320@mail.yandex-team.ru>
 <871rjdrca0.fsf@dusky.pond.sub.org>
 <b632d444-bdf9-648b-9d55-a9e72efb8fbc@redhat.com>
Date: Tue, 08 Sep 2020 16:31:49 +0200
In-Reply-To: <b632d444-bdf9-648b-9d55-a9e72efb8fbc@redhat.com> (Eric Blake's
 message of "Tue, 8 Sep 2020 07:36:47 -0500")
Message-ID: <87tuw8731m.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/08 03:00:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
 Vincenzo Maffione <v.maffione@gmail.com>,
 "yc-core@yandex-team.ru" <yc-core@yandex-team.ru>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Alexey Kirillov <lekiravi@yandex-team.ru>, Paolo Bonzini <pbonzini@redhat.com>,
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>, Luigi Rizzo <rizzo@iet.unipi.it>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Eric Blake <eblake@redhat.com> writes:

> On 9/7/20 7:39 AM, Markus Armbruster wrote:
>
>>>>
>>>> This is union Netdev plus a common member @peer-id, less the variant
>>>> members for NetClientDriver values 'nic' and 'hubport'.
>>>>
>>>> Can 'type: 'nic' and 'type': 'hubport' occur?
>>>
>>> No, it can't. We don't support NIC/hubport in query-netdevs, so we neither create this
>>> structure for them, nor store config.
>> Same for 'none', I guess.
>> As defined, NetdevInfo allows types 'none', 'nic', and 'hubport', it
>> just has no variant members for them.  The fact that they can't occur is
>> not coded into the type, and therefore not visible in introspection.
>> To make introspection more precise, we'd have to define a new enum
>> type.
>> How much that would complicate the C code is unclear.
>> Do we need it to be more precise?  Eric, got an opinion?
>
> Is the problem that a new enum would be duplicating things?

Enumerating network drivers twice is mildly annoying.  I worry more
about having to convert between the two enumerations in C.

My actual question: do we need query-qmp-schema report the precise set
of 'type' values?  As is, it reports a few that can't actually occur.

>                                                              Is it
> worth allowing one enum to have a 'base':'OtherEnum' in the schema to
> reduce some of the duplication?

We could then generate functions (or macros) to convert from base enum
to extended enum, and back, where the latter can fail.

Worthwhile only if we have sufficient use for it.


