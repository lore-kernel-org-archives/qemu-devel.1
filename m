Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0ADBC10DCE
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 14:44:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9714520770
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 14:44:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DkKToPyG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9714520770
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51748 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEZvb-000557-Ql
	for qemu-devel@archiver.kernel.org; Wed, 18 Mar 2020 10:44:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36185)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jEZql-000683-RG
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 10:39:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jEZqk-0004fq-Km
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 10:39:15 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:33701)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jEZqk-0004de-Gq
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 10:39:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584542354;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9kZQwjmQy0wRv9ytBq/y9fO7Pf7M8IAux1EHXGFKnvI=;
 b=DkKToPyGVnUQVkTFqXvPQgtZreA6cMzLVKDVE70TqLK0oBZPhh++sL2nWQFuzbnwiJEJGR
 w2wOrMdDfAWB5CjPjPS5VeXbU+sFisGFWQMdjSszPTBZJAsiZDe1En+73BbXziBjl0EWDI
 Z5rfzhY+soGlaqR0o/iofp1zMICy19U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-274-w0jYwtHWMiebnn8Lp-nlVA-1; Wed, 18 Mar 2020 10:39:07 -0400
X-MC-Unique: w0jYwtHWMiebnn8Lp-nlVA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 02AA818B9FC1;
 Wed, 18 Mar 2020 14:39:06 +0000 (UTC)
Received: from [10.3.112.193] (ovpn-112-193.phx2.redhat.com [10.3.112.193])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 637465D9E5;
 Wed, 18 Mar 2020 14:39:02 +0000 (UTC)
Subject: Re: [RFC (fix for 5.0?)] block/io: do not do pointer arithmetic on
 void *
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
References: <20200318142253.2809-1-vsementsov@virtuozzo.com>
 <20200318142654.GH2173309@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <bd88b8eb-d4d2-cd53-f61a-7fab95f28812@redhat.com>
Date: Wed, 18 Mar 2020 09:39:01 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200318142654.GH2173309@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: kwolf@redhat.com, fam@euphon.net, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/18/20 9:26 AM, Daniel P. Berrang=C3=A9 wrote:
> On Wed, Mar 18, 2020 at 05:22:53PM +0300, Vladimir Sementsov-Ogievskiy wr=
ote:
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>
>> Hi all!
>>
>> C standard doesn't allow pointer arithmetic on void *.
>> Still, gcc allows it as an extension:
>>   https://gcc.gnu.org/onlinedocs/gcc-4.8.0/gcc/Pointer-Arith.html
>>
>> I can create a series of patches like this. Do we need it?
>=20
> I don't think so, we only care about gcc & clang.

Still, if all supported compilers support the extension, then our=20
CODING_STYLE.rst should mention that it is safe to rely on the extension.

>=20
>> Also, where is documented which compilers are supported by Qemu?
>=20
> It is checked in configure - gcc 4.8 or clang 3.4 or xcode clang 5.1
>=20


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


