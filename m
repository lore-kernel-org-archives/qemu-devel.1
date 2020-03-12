Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 352FDC10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 21:27:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF165206BE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 21:27:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fhC7et2M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF165206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50674 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCVMr-0005zD-6H
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 17:27:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52771)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jCVLs-0001XA-7B
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 17:26:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jCVLq-0005j7-KI
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 17:26:47 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:29730
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jCVLq-0005i9-FH
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 17:26:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584048405;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WsC4BN1ohg3HbdCvRh3gngJCagIyuzhQ32CCrRHw554=;
 b=fhC7et2MqeeHSlBa2jzmhun2DCYOf8OvsHrDaJ8cC/7Cv2oJSPrG9pah5+NJv6GMe9og5T
 CZLzTuJ8z7DP0QxixX2gn0UTZ77vwsq88tAoh69DwBvTiWowhrQB3F7PJjg0DiBZAgfgbc
 ENt4NrtUAyACJFQ8z9o9YCCLSb6ZCsU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-79-oGWpbxzNO76Prubo4H0kGA-1; Thu, 12 Mar 2020 17:26:40 -0400
X-MC-Unique: oGWpbxzNO76Prubo4H0kGA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E13D58017CC;
 Thu, 12 Mar 2020 21:26:38 +0000 (UTC)
Received: from [10.3.116.177] (ovpn-116-177.phx2.redhat.com [10.3.116.177])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5F4E192D1C;
 Thu, 12 Mar 2020 21:26:38 +0000 (UTC)
Subject: Re: QMP netdev_add multiple dnssearch values
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>,
 Alex Kirillov <lekiravi@yandex-team.ru>
References: <713881571320392@iva8-147456c4bd40.qloud-c.yandex.net>
 <87d0elmmdt.fsf@dusky.pond.sub.org>
 <2137591572344429@sas1-eb34c5849710.qloud-c.yandex.net>
 <87zhgha1lt.fsf@dusky.pond.sub.org>
 <d1f5421a-8a94-2869-4c96-24485cd17afd@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <1819f914-1b88-d227-6a7b-b79ecb74679f@redhat.com>
Date: Thu, 12 Mar 2020 16:26:37 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <d1f5421a-8a94-2869-4c96-24485cd17afd@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: "jasowang@redhat.com" <jasowang@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "yc-core@yandex-team.ru" <yc-core@yandex-team.ru>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/27/19 9:49 AM, Eric Blake wrote:
> On 11/27/19 7:30 AM, Markus Armbruster wrote:
>=20
>> "Good enough" was true back then.=C2=A0 It wasn't true when we reused it=
 for
>> netdev_add: hostfwd and guestfwd are list-valued.
>>
>> We did define a QAPI schema a few months later (14aa0c2de0 "qapi schema:
>> add Netdev types").=C2=A0 net_client_init() uses it to convert from Qemu=
Opts
>> to QAPI type Netdev.=C2=A0 This took us to the crazy pipeline we still u=
se
>> today:
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 CLI, HMP
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (k=
ey=3Dvalue,...)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 v
>> =C2=A0=C2=A0=C2=A0=C2=A0 QMP (JSON) -> QDict -> QemuOpts -> Netdev
>>
>> We should instead use:
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 CLI, HMP
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (key=3Dvalue,.=
..)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 v
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 QemuOpts
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 v
>> =C2=A0=C2=A0=C2=A0=C2=A0 QMP (JSON) -> QDict -> Netdev
>>
>> Back in 2016, Eric (cc'ed) posted patches to get us to this pipeline.
>> They got stuck on backward compatibility worries: the old code accepts
>> all parameters as JSON strings in addition to their proper type, the new
>> code doesn't.=C2=A0 Undocumented misfeature, but we chickened out anyway=
.
>=20
> That was before we had a deprecation process.=C2=A0 Now we do.=C2=A0 If w=
e are=20
> still worried about it, then we should start the deprecation clock=20
> (squeezing it into 4.2-rc3 is risky, more likely is starting it in 5.0,=
=20
> so that we get rid of string support in 5.2).=C2=A0 If we are not worried=
=20
> about it, then we can just kill the misfeature in 5.0.

I'm leaning towards just killing the misfeature (it's a lot of glue code=20
to add to support the misfeature for 5.0 and 5.1, if we're just going to=20
rip it back out for 5.2), especially since introspection is enough for=20
any affected clients to learn about the stricter behavior.

>=20
>>
>> Let's reconsider.=C2=A0 Eric's patches break interface misuse that may o=
r may
>> not exist in the field.=C2=A0 They fix a correct use of interface people=
 want
>> to use (or Alex wouldn't have reported this bug), and they make QMP
>> introspection work for netdev_add.
>>
>> Eric, what do you think?
>=20
> Yes, it's time to revive that work (I have no idea if my patches from=20
> back then will still rebase nicely, though).

Now posted:
https://lists.gnu.org/archive/html/qemu-devel/2020-03/msg03842.html

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


