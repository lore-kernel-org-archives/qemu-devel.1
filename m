Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D221DC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 12:40:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A102A206E3
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 12:40:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B6nnmbN9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A102A206E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43244 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxrZk-0001G2-Q8
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 08:40:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34544)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jxrYe-0000Qc-Us
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 08:39:45 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:42637
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jxrYd-0004l1-3M
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 08:39:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595335182;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aaPDlRD9lXu/KlfIv+P6J4JCWblBdUGvb118uSpXkp4=;
 b=B6nnmbN9OuMObRX2o/MphGXIaHVpstnTuNgElSEfuXdD4ay48EzTItZKz+au9OnOc6EDwk
 r9yo6P03Tt74UIuY0Coa0NJmieFE1WtQGrbSRr7wier7lTg+BG1sDP/rXOnUvg31yyNpuT
 QkHsb2og2HCqONjcJCUMVPWyncMRBHM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-329--eY9s_vKMbO5cHZz5x3WYA-1; Tue, 21 Jul 2020 08:39:40 -0400
X-MC-Unique: -eY9s_vKMbO5cHZz5x3WYA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5B2DA1005510;
 Tue, 21 Jul 2020 12:39:39 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 184BF7B400;
 Tue, 21 Jul 2020 12:39:39 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A8179111CA27; Tue, 21 Jul 2020 14:39:37 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Li Qiang <liq3ea@gmail.com>
Subject: Re: [PATCH for-5.1] qapi: Fix visit_type_STRUCT() not to fail for
 null object
References: <20200716150617.4027356-1-armbru@redhat.com>
 <CAKXe6S+BKQtmPfciz5f5NoWnw=PT-wgB1t447=eFgPCjsONkKQ@mail.gmail.com>
Date: Tue, 21 Jul 2020 14:39:37 +0200
In-Reply-To: <CAKXe6S+BKQtmPfciz5f5NoWnw=PT-wgB1t447=eFgPCjsONkKQ@mail.gmail.com>
 (Li Qiang's message of "Fri, 17 Jul 2020 00:20:37 +0800")
Message-ID: <871rl582k6.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/21 03:39:19
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
Cc: Li Qiang <liq3ea@163.com>, Qemu Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Li Qiang <liq3ea@gmail.com> writes:

> Markus Armbruster <armbru@redhat.com> =E4=BA=8E2020=E5=B9=B47=E6=9C=8816=
=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=8811:07=E5=86=99=E9=81=93=EF=BC=
=9A
>>
>> To make deallocating partially constructed objects work, the
>> visit_type_STRUCT() need to succeed without doing anything when passed
>> a null object.
>>
>> Commit cdd2b228b9 "qapi: Smooth visitor error checking in generated
>> code" broke that.  To reproduce, run tests/test-qobject-input-visitor
>> with AddressSanitizer:
>>
>>     =3D=3D4353=3D=3DERROR: LeakSanitizer: detected memory leaks
>>
>>     Direct leak of 16 byte(s) in 1 object(s) allocated from:
>>         #0 0x7f192d0c5d28 in __interceptor_calloc (/usr/lib/x86_64-linux=
-gnu/libasan.so.4+0xded28)
>>         #1 0x7f192cd21b10 in g_malloc0 (/usr/lib/x86_64-linux-gnu/libgli=
b-2.0.so.0+0x51b10)
>>         #2 0x556725f6bbee in visit_next_list qapi/qapi-visit-core.c:86
>>         #3 0x556725f49e15 in visit_type_UserDefOneList tests/test-qapi-v=
isit.c:474
>>         #4 0x556725f4489b in test_visitor_in_fail_struct_in_list tests/t=
est-qobject-input-visitor.c:1086
>>         #5 0x7f192cd42f29  (/usr/lib/x86_64-linux-gnu/libglib-2.0.so.0+0=
x72f29)
>>
>>     SUMMARY: AddressSanitizer: 16 byte(s) leaked in 1 allocation(s).
>>
>> Test case /visitor/input/fail/struct-in-list feeds a list with a bad
>> element to the QObject input visitor.  Visiting that element duly
>> fails, and aborts the visit with the list only partially constructed:
>> the faulty object is null.  Cleaning up the partially constructed list
>> visits that null object, fails, and aborts the visit before the list
>> node gets freed.
>>
>> Fix the the generated visit_type_STRUCT() to succeed for null objects.
>>
>> Fixes: cdd2b228b973d2a29edf7696ef6e8b08ec329019
>> Reported-by: Li Qiang <liq3ea@163.com>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>
> Oh, I also sent this too.
> Not matter, just ignore my patch.
>
> Tested-by: Li Qiang <liq3ea@gmail.com>
> Reviewed-by: Li Qiang <liq3ea@gmail.com>

Thanks!

Queued for 5.1.


