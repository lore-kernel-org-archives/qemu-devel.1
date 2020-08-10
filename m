Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49987C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 18:18:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B57C207FF
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 18:18:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B57C207FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49142 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5CNL-0005M8-9R
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 14:18:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47572)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1k5BNv-00072T-JH; Mon, 10 Aug 2020 13:14:55 -0400
Received: from smtpout1.mo804.mail-out.ovh.net ([79.137.123.220]:52391)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1k5BNs-0003Wv-G9; Mon, 10 Aug 2020 13:14:55 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.109.143.188])
 by mo804.mail-out.ovh.net (Postfix) with ESMTPS id 440D655C7B1C;
 Mon, 10 Aug 2020 19:14:41 +0200 (CEST)
Received: from kaod.org (37.59.142.98) by DAG4EX1.mxp5.local (172.16.2.31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Mon, 10 Aug
 2020 19:14:40 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-98R002007a2343-7b21-4e05-83e1-b3e7fd5f5712,
 EF638D8D103391F16F38E39CF07A17906BAD491E) smtp.auth=clg@kaod.org
Subject: Re: [PATCH for-5.2 14/19] ftgmac100: Fix integer overflow in
 ftgmac100_do_tx()
To: Mauro Matteo Cascella <mcascell@redhat.com>
References: <20200806132106.747414-1-clg@kaod.org>
 <20200806132106.747414-15-clg@kaod.org>
 <CAA8xKjVfG8cp_g6FDNxUCQ6dqiMHnf17eMNCE2Wz+Vr+grAprw@mail.gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <b0e8e4d3-5250-ec81-7ce5-146bba1d5130@kaod.org>
Date: Mon, 10 Aug 2020 19:14:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAA8xKjVfG8cp_g6FDNxUCQ6dqiMHnf17eMNCE2Wz+Vr+grAprw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.98]
X-ClientProxiedBy: DAG2EX1.mxp5.local (172.16.2.11) To DAG4EX1.mxp5.local
 (172.16.2.31)
X-Ovh-Tracer-GUID: fd7484c1-1046-4760-984b-f3fd4e2d3832
X-Ovh-Tracer-Id: 9259682312313932652
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedrkeekgdduuddvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfhisehtkeertddtfeejnecuhfhrohhmpeevrogurhhitggpnfgvpgfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepjeekudeuudevleegudeugeekleffveeludejteffiedvledvgfekueefudehheefnecukfhppedtrddtrddtrddtpdefjedrheelrddugedvrdelkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehmgihplhgrnhehrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepmhgtrghstggvlhhlsehrvgguhhgrthdrtghomh
Received-SPF: pass client-ip=79.137.123.220; envelope-from=clg@kaod.org;
 helo=smtpout1.mo804.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/10 13:14:42
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Frederic Konrad <konrad.frederic@yahoo.fr>, Andrew Jeffery <andrew@aj.id.au>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 Joel Stanley <joel@jms.id.au>, Ziming Zhang <ezrakiez@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/10/20 3:43 PM, Mauro Matteo Cascella wrote:
> On Thu, Aug 6, 2020 at 3:21 PM Cédric Le Goater <clg@kaod.org> wrote:
>>
>> When inserting the VLAN tag in packets, memmove() can generate an
>> integer overflow for packets whose length is less than 12 bytes.
>>
>> Check length against the size of the ethernet header (14 bytes) to
>> avoid the crash and return FTGMAC100_INT_XPKT_LOST status. This seems
>> like a good modeling choice even if Aspeed does not specify anything
>> in that case.
>>
>> Cc: Frederic Konrad <konrad.frederic@yahoo.fr>
>> Cc: Mauro Matteo Cascella <mcascell@redhat.com>
>> Reported-by: Ziming Zhang <ezrakiez@gmail.com>
>> Signed-off-by: Cédric Le Goater <clg@kaod.org>
>> ---
>>  hw/net/ftgmac100.c | 19 +++++++++++++++----
>>  1 file changed, 15 insertions(+), 4 deletions(-)
>>
>> diff --git a/hw/net/ftgmac100.c b/hw/net/ftgmac100.c
>> index 280aa3d3a1e2..987b843fabc4 100644
>> --- a/hw/net/ftgmac100.c
>> +++ b/hw/net/ftgmac100.c
>> @@ -540,10 +540,21 @@ static void ftgmac100_do_tx(FTGMAC100State *s, uint32_t tx_ring,
>>                  s->isr |= FTGMAC100_INT_XPKT_LOST;
>>                  len =  sizeof(s->frame) - frame_size - 4;
>>              }
>> -            memmove(ptr + 16, ptr + 12, len - 12);
>> -            stw_be_p(ptr + 12, ETH_P_VLAN);
>> -            stw_be_p(ptr + 14, bd.des1);
>> -            len += 4;
>> +
>> +            if (len < sizeof(struct eth_header)) {
>> +                qemu_log_mask(LOG_GUEST_ERROR,
>> +                         "%s: frame too small for VLAN insertion : %d bytes\n",
>> +                         __func__, len);
>> +                s->isr |= FTGMAC100_INT_XPKT_LOST;
>> +            } else {
>> +                uint8_t *vlan_hdr = ptr + (ETH_ALEN * 2);
>> +                uint8_t *payload = vlan_hdr + sizeof(struct vlan_header);
>> +
>> +                memmove(payload, vlan_hdr, len - (ETH_ALEN * 2));
>> +                stw_be_p(vlan_hdr, ETH_P_VLAN);
>> +                stw_be_p(vlan_hdr + 2, FTGMAC100_TXDES1_VLANTAG_CI(bd.des1));
>> +                len += sizeof(struct vlan_header);
>> +            }
>>          }
>>
>>          ptr += len;
>> --
>> 2.25.4
>>
> 
> I can confirm that I can't reproduce the issue with the above patch. Thank you.
> 

Can I count that as a Tested-by ? 

Thanks,

C. 



