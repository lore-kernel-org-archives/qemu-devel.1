Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 311E5C10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 06:21:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E927820663
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 06:21:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VUpWbw9U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E927820663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53364 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jE5bB-0005TZ-5F
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 02:21:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37131)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jasowang@redhat.com>) id 1jE5aU-0004yY-0e
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 02:20:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1jE5aQ-0000be-GF
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 02:20:24 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:55063)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1jE5aQ-0000Uq-AY
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 02:20:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584426021;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jl6demKH9SvSnvLbM3mkwilnRhF8DiqbvJWIoMWWGk0=;
 b=VUpWbw9U+1hopCkJ48V7KLJv6vMh7hbk8gYlh4NjzhgFiSMdKKhBiF0G9thqcmuK9TLbUa
 TqSb144rVisYvz/4yMBzBKe+M8W9CrrRQTan2VetoKN1Bm2Z9ufO6V2IBvpsLwMSOClqib
 kZ9IX9A4IhdXoc5sFnbyMuvr6LGuQmI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-453--ECXxBMzPG23upjgfOBXoQ-1; Tue, 17 Mar 2020 02:20:15 -0400
X-MC-Unique: -ECXxBMzPG23upjgfOBXoQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 21E8E100726D;
 Tue, 17 Mar 2020 06:20:14 +0000 (UTC)
Received: from [10.72.12.89] (ovpn-12-89.pek2.redhat.com [10.72.12.89])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A5EA019C7F;
 Tue, 17 Mar 2020 06:20:12 +0000 (UTC)
Subject: Re: [PATCH v2] Fixed integer overflow in e1000e
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 andrew@daynix.com, dmitry.fleytman@gmail.com
References: <20200304142058.52458-1-andrew@daynix.com>
 <badcfed3-94e4-b411-667d-616d790b28b3@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <a3170863-fe9f-4627-11f7-a507423d7213@redhat.com>
Date: Tue, 17 Mar 2020 14:20:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <badcfed3-94e4-b411-667d-616d790b28b3@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/3/4 =E4=B8=8B=E5=8D=8811:41, Philippe Mathieu-Daud=C3=A9 wrote:
> On 3/4/20 3:20 PM, andrew@daynix.com wrote:
>> From: Andrew Melnychenko <andrew@daynix.com>
>>
>> Fixes: 6f3fbe4ed06
>> Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=3D1737400
>> Fixed setting max_queue_num if there are no peers in NICConf.=20
>> qemu_new_nic() creates NICState with 1 NetClientState(index 0)=20
>> without peers, set max_queue_num to 0 - It prevents undefined=20
>> behavior and possible crashes, especially during pcie hotplug.
>
> Hoping the maintainer taking this can reformat the commit description=20
> a bit nicer... (moving the tags down), then for the code part:


Yes, I tweak the log.

Thanks


> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>
>>
>> Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
>> ---
>> =C2=A0 hw/net/e1000e.c | 2 +-
>> =C2=A0 1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/hw/net/e1000e.c b/hw/net/e1000e.c
>> index a91dbdca3c..f2cc1552c5 100644
>> --- a/hw/net/e1000e.c
>> +++ b/hw/net/e1000e.c
>> @@ -328,7 +328,7 @@ e1000e_init_net_peer(E1000EState *s, PCIDevice=20
>> *pci_dev, uint8_t *macaddr)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->nic =3D qemu_new_nic(&net_e1000e_info,=
 &s->conf,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 object_get_typena=
me(OBJECT(s)), dev->id, s);
>> =C2=A0 -=C2=A0=C2=A0=C2=A0 s->core.max_queue_num =3D s->conf.peers.queue=
s - 1;
>> +=C2=A0=C2=A0=C2=A0 s->core.max_queue_num =3D s->conf.peers.queues ?=20
>> s->conf.peers.queues - 1 : 0;
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 trace_e1000e_mac_set_permanent(MAC=
_ARG(macaddr));
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 memcpy(s->core.permanent_mac, macaddr,=20
>> sizeof(s->core.permanent_mac));
>>
>
>


