Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDB98C2D0BF
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 18:28:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FC1220716
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 18:28:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PfMeHsS5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FC1220716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihe3H-0001rs-N8
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 13:28:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49193)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1ihe2I-0001NI-9l
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 13:27:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1ihe2D-0005nK-Aa
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 13:26:59 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:49831
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ihe2B-0005iM-UV
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 13:26:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576693610;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KlgzqueGNMAR/MZHjCHRvYMDnbvpW4UvSMoQ9ly0dIw=;
 b=PfMeHsS52Q+3mXokdphzYOZAV4fwv1RXesnsCMdN+9O+AxV3hzbaXk/VNOC9wXTYRPB7Lp
 YklbDJHLk2g8wMa958cOj0u5VDjZ8ddu5dsQGP4itBymn2zUlyUacWUfpseJdOemOAgEbA
 HRVvGHn3C/tDB0Dv6PRWZMo3MlUAPMI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-134-UTCAWv0-MuSXf0JhD3lQJw-1; Wed, 18 Dec 2019 13:26:47 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 42C6C80257F;
 Wed, 18 Dec 2019 18:26:46 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-42.ams2.redhat.com
 [10.36.116.42])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F147B5C1D4;
 Wed, 18 Dec 2019 18:26:45 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7BAD511386A7; Wed, 18 Dec 2019 19:26:44 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Tao Xu <tao3.xu@intel.com>
Subject: Re: [PATCH] util/cutils: Expand do_strtosz parsing precision to 64
 bits
References: <20191205021459.29920-1-tao3.xu@intel.com>
 <87a786sse9.fsf@dusky.pond.sub.org>
 <b7c442e3-cc7e-155e-5370-db9a371928a6@intel.com>
 <87y2vbgsf0.fsf@dusky.pond.sub.org>
 <e731445a-4461-3212-c08d-05dc7ad2b742@intel.com>
 <52a11f3a-f2c8-26e9-b823-0093cfe91fdc@intel.com>
Date: Wed, 18 Dec 2019 19:26:44 +0100
In-Reply-To: <52a11f3a-f2c8-26e9-b823-0093cfe91fdc@intel.com> (Tao Xu's
 message of "Wed, 18 Dec 2019 13:26:32 +0800")
Message-ID: <87y2v9zdzv.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: UTCAWv0-MuSXf0JhD3lQJw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: "mdroth@linux.vnet.ibm.com" <mdroth@linux.vnet.ibm.com>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Tao Xu <tao3.xu@intel.com> writes:

> On 12/18/2019 9:33 AM, Tao Xu wrote:
>> On 12/17/2019 6:25 PM, Markus Armbruster wrote:
[...]
>>> Also fun: for "0123", we use uint64_t 83, not double 123.0.=C2=A0 But f=
or
>>> "0123.", we use 123.0, not 83.
>>>
>>> Do we really want to accept octal and hexadecimal integers?
>>>
>>
>> Thank you for reminding me. Octal and hexadecimal may bring more
>> confusion. I will use qemu_strtou64(nptr, &suffixu, 10, &valu) and
>> add test for input like "0123".
>>
>
> Hi Markus,
>
> After I use qemu_strtou64(nptr, &suffixu, 10, &valu), it cause another
> question. Because qemu_strtod_finite support hexadecimal input, so in
> this situation, it will parsed as double. It will also let large
> hexadecimal integers be rounded. So there may be two solution:
>
> 1: use qemu_strtou64(nptr, &suffixu, 0, &valu) and parse octal as
> decimal. This will keep hexadecimal valid as now.
>
> "0123" --> 123; "0x123" --> 291

How would you make qemu_strtou64() parse octal as decimal?

> 2: use qemu_strtou64(nptr, &suffixu, 10, &valu) and reject octal and
> decimal.
>
> "0123" --> Error; "0x123" --> Error

How would you reject the 0x prefix?


