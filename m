Return-Path: <SRS0=u80H=ZS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 722EFC432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 09:49:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41EC82075C
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 09:49:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DBN/J3nQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41EC82075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZXTA-0005Es-3y
	for qemu-devel@archiver.kernel.org; Tue, 26 Nov 2019 04:49:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54188)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iZXOZ-0001HH-29
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 04:44:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iZXDo-00028f-6N
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 04:33:25 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:23409
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iZXDo-000283-2m
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 04:33:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574760803;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JdxPR3DfDC/fczZATl4yU9hYalGVovNuf+OS5GIZ2AQ=;
 b=DBN/J3nQR8UxSPNCYH3X85tbnJIFZyXIdplT6QVHQBCO+40F5QntI6VsMPwIVCmShVkju3
 CIkczrewzUeLUh0ir54RlwdjdIjs4CHdKudqEPdb4BVRRsL1X8v10VD4Tf3YErXgz6Tmr2
 iKCyOhv5kRzpqtDb0h7wlzflrVdQlTI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-96-n5nQLcM6NCWasNl98fcqwA-1; Tue, 26 Nov 2019 04:33:19 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 747DE1801B9A;
 Tue, 26 Nov 2019 09:33:18 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-134.ams2.redhat.com
 [10.36.116.134])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BB7735D6BE;
 Tue, 26 Nov 2019 09:33:14 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3FFFD1138606; Tue, 26 Nov 2019 10:33:13 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Tao Xu <tao3.xu@intel.com>
Subject: Re: [PATCH v17 02/14] util/cutils: Use qemu_strtold_finite to parse
 size
References: <20191122074826.1373-1-tao3.xu@intel.com>
 <20191122074826.1373-3-tao3.xu@intel.com>
 <87tv6sjvfi.fsf@dusky.pond.sub.org>
 <b1615683-76bf-6d61-9698-b9f6be2c71b3@intel.com>
Date: Tue, 26 Nov 2019 10:33:13 +0100
In-Reply-To: <b1615683-76bf-6d61-9698-b9f6be2c71b3@intel.com> (Tao Xu's
 message of "Tue, 26 Nov 2019 16:31:56 +0800")
Message-ID: <87h82r9e3q.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: n5nQLcM6NCWasNl98fcqwA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain
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
Cc: "lvivier@redhat.com" <lvivier@redhat.com>,
 "thuth@redhat.com" <thuth@redhat.com>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "sw@weilnetz.de" <sw@weilnetz.de>, "Du, Fan" <fan.du@intel.com>,
 "mdroth@linux.vnet.ibm.com" <mdroth@linux.vnet.ibm.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "imammedo@redhat.com" <imammedo@redhat.com>, "Liu,
 Jingqi" <jingqi.liu@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Tao Xu <tao3.xu@intel.com> writes:

> On 11/25/2019 2:56 PM, Markus Armbruster wrote:
>> Tao Xu <tao3.xu@intel.com> writes:
>>
>>> Support full 64bit precision, modify related test cases.
>>
>> That's not true in general: long double need not be any wider than
>> double.
>>
>> It might be true on the host machines we support, but I don't know.  If
>> we decide to rely on it, we better make the build fail when the host
>> machine doesn't meet our expectations, preferably in configure.
>>
> [...]
>>> -    if ((val * mul >=3D 0xfffffffffffffc00) || val < 0) {
>>> +    /* Values > UINT64_MAX overflow uint64_t */
>>> +    if ((val * mul > UINT64_MAX) || val < 0) {
>>>           retval =3D -ERANGE;
>>>           goto out;
>>>       }
>>
>> Not portable.  If it was, we'd have made this changd long ago :)
>>
>
> OK. So the suitable solution is what you suggested in v14?
>
> "A possible alternative is to parse the numeric part both as a double
> and as a 64 bit unsigned integer, then use whatever consumes more
> characters.  This enables providing full 64 bits unless you actually
> use
> a fraction."

Yes, that bypasses the portability issue.

> I will try this way.

Go ahead.


