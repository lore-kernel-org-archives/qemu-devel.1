Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3991C52D2E
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 14:14:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C32F24691
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 14:14:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CTMZqpGO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C32F24691
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60612 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7Jvm-0006J2-O0
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 09:14:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44369)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1j7Jui-0004as-9S
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 09:13:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1j7Juh-0007To-7A
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 09:13:20 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28462
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1j7Juh-0007TP-3E
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 09:13:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582812798;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KIwencxeEA1LGwtdVzi1RLbFsA+etlSuQJnXsVzPJDQ=;
 b=CTMZqpGO5eyiahfNmFyO0vRm9brV+jRmmt/B28hpZ8pZfUoJKZ9P6VoTks0Wc1j174kAxD
 dd947856/34ICK6Qiph41JTKl73aiYHoDgBGjqDUSEAnnfPt/YHukCbz8UcH0MEdANQjod
 wkYt2gLgFiUfFH7weBShpbFs5j1RoCY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-163-EkICpJqkME26mC5EU9hITw-1; Thu, 27 Feb 2020 09:13:16 -0500
X-MC-Unique: EkICpJqkME26mC5EU9hITw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DCDD318C8C00;
 Thu, 27 Feb 2020 14:13:14 +0000 (UTC)
Received: from [10.3.116.57] (ovpn-116-57.phx2.redhat.com [10.3.116.57])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 57A7F63147;
 Thu, 27 Feb 2020 14:13:14 +0000 (UTC)
Subject: Re: [PATCH v1 1/8] qcow2: introduce compression type feature
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Denis Plotnikov <dplotnikov@virtuozzo.com>, qemu-devel@nongnu.org
References: <20200227072953.25445-1-dplotnikov@virtuozzo.com>
 <20200227072953.25445-2-dplotnikov@virtuozzo.com>
 <501fde69-f116-a3b9-0356-05708f0b78b7@redhat.com>
 <78aa28c9-49a4-ac0a-51c5-e3587f46603d@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <e93ca287-07c0-c6f9-c490-31954bcde274@redhat.com>
Date: Thu, 27 Feb 2020 08:13:13 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <78aa28c9-49a4-ac0a-51c5-e3587f46603d@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: kwolf@redhat.com, armbru@redhat.com, qemu-block@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/27/20 7:59 AM, Vladimir Sementsov-Ogievskiy wrote:

>> Hmm - I think it may be worth a tweak to qcow2.txt to call out:
>>
>> 104: compression_type
>> 105 - 111: padding, must be 0
>>
>> or else call out:
>>
>> 104-111: compression type
>>
>> and just blindly use all 8 bytes for the value even though really only=
=20
>> 1 or two values will ever be defined.=A0 Of course, that moves the byte=
=20
>> in question from 104 to 111, thanks to our big endian encoding, but as=
=20
>> this series is the first one installing a non-zero value in those 8=20
>> bytes, and as we just finished documenting that the header length must=
=20
>> be a multiple of 8, there is no real impact - we can make such tweaks=20
>> up until the 5.0 release.
>=20
> But what is the benefit? We have already documented padding in the spec,=
=20
> and discussed it so much time... What is the problem with padding? And=20
> why to add 8 bytes for every new feature which needs only one byte?

Okay, so requiring an 8-byte field is not necessary.  But still, at=20
least mentioning padding bytes (that may be assigned meanings later) is=20
consistent with the rest of the document (for example, we have padding=20
bits documented for the compatible/incompatible/autoclear feature bits),=20
and reminds implementers to keep size rounded to a multiple of 8.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


