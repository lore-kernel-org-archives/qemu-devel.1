Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A22BBC3F2CD
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 03:57:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68F8920714
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 03:57:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Py4wR/Oi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68F8920714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGED1-0003td-Hy
	for qemu-devel@archiver.kernel.org; Sun, 22 Mar 2020 23:57:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53738)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jasowang@redhat.com>) id 1jGECQ-0003Tu-M8
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 23:56:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1jGECP-0001s2-Fd
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 23:56:26 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:34334)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1jGECP-0001rm-CT
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 23:56:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584935784;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sDMosB0TjqHQjPY7K7BSRcgcAIPbUUh8/sUB0Z1shNw=;
 b=Py4wR/OibXzuqsAjpUzm/rtlrn7IP61KNXIwankl8LGd7FfBJXdRVZFbywwhtnRUJRdcrv
 sUUPSlRTY/gBIkCQodNvartaS+wqLGlFJyIH6YJNrfOsBuDLuyW0967kct8yN3bVHt+6zU
 LD76ASEmeIF3XpQ2Q8xYsurhngLeSs4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-425-EBkVVjpWOaG5OVTimqAayQ-1; Sun, 22 Mar 2020 23:56:21 -0400
X-MC-Unique: EBkVVjpWOaG5OVTimqAayQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 03B618017CC;
 Mon, 23 Mar 2020 03:56:20 +0000 (UTC)
Received: from [10.72.12.74] (ovpn-12-74.pek2.redhat.com [10.72.12.74])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C61DB94975;
 Mon, 23 Mar 2020 03:56:16 +0000 (UTC)
Subject: Re: [PATCH v5 0/3] net: tulip: add checks to avoid OOB access
From: Jason Wang <jasowang@redhat.com>
To: P J P <ppandit@redhat.com>, Li Qiang <pangpei.lq@antfin.com>
References: <20200319174050.759794-1-ppandit@redhat.com>
 <20f29d89-6d52-2edc-ef7e-13124908256a@redhat.com>
Message-ID: <26c0091a-89f1-c956-efba-d1b2e4a13d76@redhat.com>
Date: Mon, 23 Mar 2020 11:56:15 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20f29d89-6d52-2edc-ef7e-13124908256a@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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
Cc: Prasad J Pandit <pjp@fedoraproject.org>,
 Stefan Hajnoczi <stefanha@gmail.com>, Sven Schnelle <svens@stackframe.org>,
 Qemu Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Ziming Zhang <ezrakiez@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/3/23 =E4=B8=8A=E5=8D=8811:43, Jason Wang wrote:
>
> On 2020/3/20 =E4=B8=8A=E5=8D=881:40, P J P wrote:
>> From: Prasad J Pandit <pjp@fedoraproject.org>
>>
>> Hello,
>>
>> * This series adds checks to avoid potential OOB access and infinite=20
>> loop
>> =C2=A0=C2=A0 issues while processing rx/tx data.
>>
>> * Tulip tx descriptors are capped at 128 to avoid infinite loop in
>> =C2=A0=C2=A0 tulip_xmit_list_update(), wrt Tulip kernel driver
>> =C2=A0=C2=A0 ->=20
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
drivers/net/ethernet/dec/tulip/tulip.h#n319
>>
>> * Update v3: add .can_receive routine
>> =C2=A0=C2=A0 ->=20
>> https://lists.gnu.org/archive/html/qemu-devel/2020-02/msg06275.html
>>
>> * Update v4: flush queued packets once they are received
>> =C2=A0=C2=A0 ->=20
>> https://lists.gnu.org/archive/html/qemu-devel/2020-03/msg05868.html
>>
>> * Update v5: fixed a typo in patch commit message
>> =C2=A0=C2=A0 ->=20
>> https://lists.gnu.org/archive/html/qemu-devel/2020-03/msg06209.html
>>
>> Thank you.
>
>
> Looks good to me.
>
> Qiang, any change to give a test with your reproducer?
>
> Thanks


Ok, I get this:

hw/net/tulip.c:305:20: error: initialization of =E2=80=98_Bool=20
(*)(NetClientState *)=E2=80=99 {aka =E2=80=98_Bool (*)(struct NetClientStat=
e *)=E2=80=99} from=20
incompatible pointer type =E2=80=98int (*)(NetClientState *)=E2=80=99 {aka =
=E2=80=98int=20
(*)(struct NetClientState *)=E2=80=99} [-Werror=3Dincompatible-pointer-type=
s]
 =C2=A0=C2=A0=C2=A0=C2=A0 .can_receive =3D tulip_can_receive,
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^~~~~~~~~~~~~~~~~

Prasad, please fix this and post a new version.

While at it, I prefer to squash patch 3 into patch 2 since patch 3 fixes=20
the issue introduced by patch 2.

Thanks


>
>
>> --=20
>> Prasad J Pandit (3):
>> =C2=A0=C2=A0 net: tulip: check frame size and r/w data length
>> =C2=A0=C2=A0 net: tulip: add .can_receive routine
>> =C2=A0=C2=A0 net: tulip: flush queued packets post receive
>>
>> =C2=A0 hw/net/tulip.c | 51 +++++++++++++++++++++++++++++++++++++++++----=
-----
>> =C2=A0 1 file changed, 42 insertions(+), 9 deletions(-)
>>
>> --=20
>> 2.25.1
>>
>>


