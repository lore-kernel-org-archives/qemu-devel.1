Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DE5CC10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 06:19:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29AAE20663
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 06:19:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EwtKFmro"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29AAE20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53344 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jE5Ze-0004WU-Cl
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 02:19:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35358)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jasowang@redhat.com>) id 1jE5Z5-00047r-Kt
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 02:19:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1jE5Z4-00024P-8u
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 02:18:59 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:54669)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1jE5Z4-0001yh-44
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 02:18:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584425937;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g5eQSCyU4514TIIFgx9azWuicVfb1qIILB358vbEJsA=;
 b=EwtKFmro3iZjWcFvIwIcwLiTAWbOMKuxvhGPcPsHvlsH8PKeILvea5Ib/H0P2qYhFvZyp9
 P7FxnRdc3i6/bA/CIe00sHkd/TLtC2vAtQuk1HeQ4Jtfq7WnTlMZKeHA+3xj0DUphdd6rv
 3XRYG2LJjwXDKAPJU9Fjf3fTzG+MwgE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-102-tBGC4NE1O3SJv5oiLIlQEw-1; Tue, 17 Mar 2020 02:18:55 -0400
X-MC-Unique: tBGC4NE1O3SJv5oiLIlQEw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 723F21005510;
 Tue, 17 Mar 2020 06:18:54 +0000 (UTC)
Received: from [10.72.12.89] (ovpn-12-89.pek2.redhat.com [10.72.12.89])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 32BD39CA3;
 Tue, 17 Mar 2020 06:18:52 +0000 (UTC)
Subject: Re: [PATCH v2] Fixed integer overflow in e1000e
To: Dmitry Fleytman <dmitry.fleytman@gmail.com>, andrew@daynix.com
References: <20200304142058.52458-1-andrew@daynix.com>
 <92C546EB-320E-43D8-8D9D-E2964E910324@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <9845981f-c2d2-0418-e04d-920f7a8e0c05@redhat.com>
Date: Tue, 17 Mar 2020 14:18:51 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <92C546EB-320E-43D8-8D9D-E2964E910324@gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/3/5 =E4=B8=8B=E5=8D=885:17, Dmitry Fleytman wrote:
>
>> On 4 Mar 2020, at 16:20, andrew@daynix.com wrote:
>>
>> From: Andrew Melnychenko <andrew@daynix.com>
>>
>> Fixes: 6f3fbe4ed06
>> Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=3D1737400
>> Fixed setting max_queue_num if there are no peers in NICConf. qemu_new_n=
ic() creates NICState with 1 NetClientState(index 0) without peers, set max=
_queue_num to 0 - It prevents undefined behavior and possible crashes, espe=
cially during pcie hotplug.
>>
>> Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
> Reviewed-by: Dmitry Fleytman <dmitry.fleytman@gmail.com>


Applied.

Thanks


>
>> ---
>> hw/net/e1000e.c | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/hw/net/e1000e.c b/hw/net/e1000e.c
>> index a91dbdca3c..f2cc1552c5 100644
>> --- a/hw/net/e1000e.c
>> +++ b/hw/net/e1000e.c
>> @@ -328,7 +328,7 @@ e1000e_init_net_peer(E1000EState *s, PCIDevice *pci_=
dev, uint8_t *macaddr)
>>      s->nic =3D qemu_new_nic(&net_e1000e_info, &s->conf,
>>          object_get_typename(OBJECT(s)), dev->id, s);
>>
>> -    s->core.max_queue_num =3D s->conf.peers.queues - 1;
>> +    s->core.max_queue_num =3D s->conf.peers.queues ? s->conf.peers.queu=
es - 1 : 0;
>>
>>      trace_e1000e_mac_set_permanent(MAC_ARG(macaddr));
>>      memcpy(s->core.permanent_mac, macaddr, sizeof(s->core.permanent_mac=
));
>> --=20
>> 2.24.1
>>


