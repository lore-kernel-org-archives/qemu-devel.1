Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60003C432C1
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 04:21:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33EAB21D7E
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 04:21:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33EAB21D7E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45248 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCyoA-0007Og-7A
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 00:21:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50833)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jasowang@redhat.com>) id 1iCynJ-0006tT-C8
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 00:20:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1iCynH-0002Md-Vq
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 00:20:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55936)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1iCynH-0002MD-NU
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 00:20:47 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4198D18C891A;
 Wed, 25 Sep 2019 04:20:46 +0000 (UTC)
Received: from [10.72.12.148] (ovpn-12-148.pek2.redhat.com [10.72.12.148])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D6FF9600C8;
 Wed, 25 Sep 2019 04:20:41 +0000 (UTC)
Subject: Re: [PATCH] COLO-compare: Fix incorrect `if` logic
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Fan Yang <Fan_Yang@sjtu.edu.cn>, qemu-devel@nongnu.org,
 Zhang Chen <chen.zhang@intel.com>, Li Zhijian <lizhijian@cn.fujitsu.com>
References: <m2y2yd9482.fsf@Fans-Air.ipads-lab.se.sjtu.edu.cn>
 <6d23190f-e68a-3000-c288-84f2e0d50b07@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <413e09c6-9376-5021-bf69-c3797237ae9d@redhat.com>
Date: Wed, 25 Sep 2019 12:20:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <6d23190f-e68a-3000-c288-84f2e0d50b07@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.70]); Wed, 25 Sep 2019 04:20:46 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2019/9/24 =E4=B8=8B=E5=8D=8811:35, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi Fan,
>
> you forgot to Cc the maintainers (doing that for you):
>
> ./scripts/get_maintainer.pl -f net/colo-compare.c
> Zhang Chen <chen.zhang@intel.com> (supporter:COLO Proxy)
> Li Zhijian <lizhijian@cn.fujitsu.com> (supporter:COLO Proxy)
> Jason Wang <jasowang@redhat.com> (maintainer:Network device ba...)
> qemu-devel@nongnu.org (open list:All patches CC here)
>
> On 9/24/19 4:08 PM, Fan Yang wrote:
>> 'colo_mark_tcp_pkt' should return 'true' when packets are the same, an=
d
>> 'false' otherwise.  However, it returns 'true' when
>> 'colo_compare_packet_payload' returns non-zero while
>> 'colo_compare_packet_payload' is just a 'memcmp'.  The result is that
>> COLO-compare reports inconsistent TCP packets when they are actually
>> the same.
>>
> Fixes: f449c9e549c
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


Applied.

Thanks


>
>> Signed-off-by: Fan Yang <Fan_Yang@sjtu.edu.cn>
>> ---
>>  net/colo-compare.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/net/colo-compare.c b/net/colo-compare.c
>> index 7489840bde..7ee17f2cf8 100644
>> --- a/net/colo-compare.c
>> +++ b/net/colo-compare.c
>> @@ -319,7 +319,7 @@ static bool colo_mark_tcp_pkt(Packet *ppkt, Packet=
 *spkt,
>>      *mark =3D 0;
>> =20
>>      if (ppkt->tcp_seq =3D=3D spkt->tcp_seq && ppkt->seq_end =3D=3D sp=
kt->seq_end) {
>> -        if (colo_compare_packet_payload(ppkt, spkt,
>> +        if (!colo_compare_packet_payload(ppkt, spkt,
>>                                          ppkt->header_size, spkt->head=
er_size,
>>                                          ppkt->payload_size)) {
>>              *mark =3D COLO_COMPARE_FREE_SECONDARY | COLO_COMPARE_FREE=
_PRIMARY;
>> @@ -329,7 +329,7 @@ static bool colo_mark_tcp_pkt(Packet *ppkt, Packet=
 *spkt,
>> =20
>>      /* one part of secondary packet payload still need to be compared=
 */
>>      if (!after(ppkt->seq_end, spkt->seq_end)) {
>> -        if (colo_compare_packet_payload(ppkt, spkt,
>> +        if (!colo_compare_packet_payload(ppkt, spkt,
>>                                          ppkt->header_size + ppkt->off=
set,
>>                                          spkt->header_size + spkt->off=
set,
>>                                          ppkt->payload_size - ppkt->of=
fset)) {
>> @@ -348,7 +348,7 @@ static bool colo_mark_tcp_pkt(Packet *ppkt, Packet=
 *spkt,
>>          /* primary packet is longer than secondary packet, compare
>>           * the same part and mark the primary packet offset
>>           */
>> -        if (colo_compare_packet_payload(ppkt, spkt,
>> +        if (!colo_compare_packet_payload(ppkt, spkt,
>>                                          ppkt->header_size + ppkt->off=
set,
>>                                          spkt->header_size + spkt->off=
set,
>>                                          spkt->payload_size - spkt->of=
fset)) {
>>

