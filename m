Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9840EC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 16:05:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 645352557E
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 16:05:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PmsDlOhn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 645352557E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpwHU-0005LW-J6
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 12:05:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43644)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jpwEg-0002z1-NP
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 12:02:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24846
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jpwEd-0008Uu-Os
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 12:02:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593446538;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JikpwdincU9eGl4vMSWUhRx6reoO/JheifFIfcaIzB4=;
 b=PmsDlOhnLkytt7/ruA/sj7ozpVJ92vM0aXQHQahquJd9/l0Dr2tqrZqO0fEC8A+tQekGu1
 njEy8Ku1PXJ/J3Aleq2G7BmIUTk/Niut6hwarUtDs8QBkly+cu2o9eJ+LMbIzLaeFaga/+
 uXOXBDL+5tdA5N+ybM/Wl88STbokwJw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-496-o45Bfvl7PaKs_2iwaBsHFg-1; Mon, 29 Jun 2020 12:01:55 -0400
X-MC-Unique: o45Bfvl7PaKs_2iwaBsHFg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C0087100AA2F;
 Mon, 29 Jun 2020 16:01:54 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-121.ams2.redhat.com
 [10.36.112.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 75E3660BEC;
 Mon, 29 Jun 2020 16:01:54 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id DD75611384A6; Mon, 29 Jun 2020 18:01:52 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PULL v2 25/31] osdep: Make MIN/MAX evaluate arguments only once
References: <20200626135608.6920-1-pbonzini@redhat.com>
 <20200626135608.6920-3-pbonzini@redhat.com>
 <CAFEAcA9DOyivMUS1gAE_BPcmO7yf6J8d-_YZ8W=Ox8U_O0QcBg@mail.gmail.com>
Date: Mon, 29 Jun 2020 18:01:52 +0200
In-Reply-To: <CAFEAcA9DOyivMUS1gAE_BPcmO7yf6J8d-_YZ8W=Ox8U_O0QcBg@mail.gmail.com>
 (Peter Maydell's message of "Sat, 27 Jun 2020 22:35:21 +0100")
Message-ID: <87366dn9n3.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=205.139.110.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/29 01:10:03
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud?= =?utf-8?Q?=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> writes:

> On Fri, 26 Jun 2020 at 14:57, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>
>> From: Eric Blake <eblake@redhat.com>
>>
>> I'm not aware of any immediate bugs in qemu where a second runtime
>> evaluation of the arguments to MIN() or MAX() causes a problem, but
>> proactively preventing such abuse is easier than falling prey to an
>> unintended case down the road.  At any rate, here's the conversation
>> that sparked the current patch:
>> https://lists.gnu.org/archive/html/qemu-devel/2018-12/msg05718.html
>
> Hi; the changes in this patch seem to confuse Coverity.
>
>> +#undef MIN
>> +#define MIN(a, b)                                       \
>> +    ({                                                  \
>> +        typeof(1 ? (a) : (b)) _a = (a), _b = (b);       \
>> +        _a < _b ? _a : _b;                              \
>> +    })
>> +#define MIN_CONST(a, b)                                         \
>> +    __builtin_choose_expr(                                      \
>> +        __builtin_constant_p(a) && __builtin_constant_p(b),     \
>> +        (a) < (b) ? (a) : (b),                                  \
>> +        ((void)0))
>> +#undef MAX
>> +#define MAX(a, b)                                       \
>> +    ({                                                  \
>> +        typeof(1 ? (a) : (b)) _a = (a), _b = (b);       \
>> +        _a > _b ? _a : _b;                              \
>> +    })
>> +#define MAX_CONST(a, b)                                         \
>> +    __builtin_choose_expr(                                      \
>> +        __builtin_constant_p(a) && __builtin_constant_p(b),     \
>> +        (a) > (b) ? (a) : (b),                                  \
>> +        ((void)0))
>
> In particular, where MIN_CONST or MAX_CONST are used to
> define values that must be const, eg in qemu-file.c:
>  50    DECLARE_BITMAP(may_free, MAX_IOV_SIZE);
> or in hcd-xhci.h:
> 217    USBPort  uports[MAX_CONST(MAXPORTS_2, MAXPORTS_3)];
>
> Coverity reports:
>
> CID 1429992 (#1 of 1): Unrecoverable parse warning (PARSE_ERROR)1.
> expr_not_constant: expression must have a constant value
>
> Can we do something (eg providing fallback less-intelligent
> versions of the macro ifdef __COVERITY__) to help it?

Perhaps we can solve the issue with scripts/coverity-model.c.
Unfortunately, I can't spare the time to try right now.

> (This is the cause of CID 1429992, 1429995, 1429997,
> 1429999. Parse errors are unfortunate because Coverity
> abandons analysis of the affected function entirely,
> and analysis of its callers is also limited.)

Bummer.  I recommend to revert until we figure out how not to break
Coverity.


