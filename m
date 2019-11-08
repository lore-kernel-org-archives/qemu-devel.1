Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 517F9C17440
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 22:59:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B685214DB
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 22:59:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZjSlU6iC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B685214DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iTDDu-0005lb-8V
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 17:59:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40923)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1iTDCt-0004zb-Q9
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 17:58:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1iTDCr-00065S-SU
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 17:58:18 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:55875
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1iTDCr-00065K-PU
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 17:58:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573253897;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u/DJ05jUqZGuG8XqVbeeR7hecFT0ihnRwbt4aF074N8=;
 b=ZjSlU6iCMPCqZG6zvIGrzwSZvpsHSnnttz03cl2R9J+yfg6pPaJHenustq15xERfxJYAMi
 8he61dqVrGFbgiW/TanjeFT1JXOsS0Rzd87nq90VWgIdEpFSAo1FfVEPSWCSoTISf1eINT
 IR717jRA+617pxMDR6AQ1qrb9118zKg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-255-dCw8KMztMjCmYaLPg6T3xA-1; Fri, 08 Nov 2019 17:58:14 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BFF08800C72;
 Fri,  8 Nov 2019 22:58:12 +0000 (UTC)
Received: from [10.36.116.65] (ovpn-116-65.ams2.redhat.com [10.36.116.65])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9111860BE1;
 Fri,  8 Nov 2019 22:58:09 +0000 (UTC)
Subject: Re: [PATCH v1 0/2] s390x/cpumodel: Introduce "best" model variants
To: Eduardo Habkost <ehabkost@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20191108110714.7475-1-david@redhat.com>
 <CAFEAcA-mD3-Zg2JunGpMqbcaT1qboCenhqEFytZD0FmFcL2i9Q@mail.gmail.com>
 <5dd613c0-6d9e-b943-b64d-7ba1791cbefe@redhat.com>
 <CAFEAcA-4r53vM-K24WYr1OFSOufhZ7hDHeZBhnywyaJ0gpMO1g@mail.gmail.com>
 <20191108191057.GZ3812@habkost.net>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <2ad063d7-7434-a55c-9994-a3d4d3622e0b@redhat.com>
Date: Fri, 8 Nov 2019 23:58:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191108191057.GZ3812@habkost.net>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: dCw8KMztMjCmYaLPg6T3xA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Janosch Frank <frankja@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 qemu-s390x <qemu-s390x@nongnu.org>, Michael Mueller <mimu@linux.ibm.com>,
 Jiri Denemark <jdenemar@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 08.11.19 20:10, Eduardo Habkost wrote:
> On Fri, Nov 08, 2019 at 01:02:28PM +0000, Peter Maydell wrote:
>> On Fri, 8 Nov 2019 at 12:46, David Hildenbrand <david@redhat.com> wrote:
>>> There is a small but important difference between "max"/"host" and
>>> "best". Max really means "all features", including deprecated ones.
>>> "best", however, can disable experimental or deprecated features. Or an=
y
>>> other features we don't want to be enabled when somebody selects a mode=
l
>>> manually.
>=20
> On x86, this is implemented by "host".  "max" gives you the full
> set of features that can be enabled by the user.  "host" gives
> you a reasonable set of features you will want to see enabled by
> default when the user says "use the host CPU".

Interesting. Maybe for s390x we might want to split host/max at one=20
time, too. E.g., exclude deprecated features from "host". Thanks for=20
that info.

--=20

Thanks,

David / dhildenb


