Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8661C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 15:32:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57B7820786
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 15:32:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57B7820786
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45042 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k83bY-0002dC-IC
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 11:32:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44104)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1k8307-0006zc-EY; Tue, 18 Aug 2020 10:54:11 -0400
Received: from smtpout1.mo529.mail-out.ovh.net ([178.32.125.2]:33739)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1k8304-0004lm-PH; Tue, 18 Aug 2020 10:54:11 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.109.138.118])
 by mo529.mail-out.ovh.net (Postfix) with ESMTPS id 2653451A5A21;
 Tue, 18 Aug 2020 16:54:04 +0200 (CEST)
Received: from kaod.org (37.59.142.97) by DAG4EX1.mxp5.local (172.16.2.31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Tue, 18 Aug
 2020 16:54:03 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-97G0016fd625c3-67b8-4adb-8c8b-dbfd4e1a221c,
 5D4690BFF1A8204198846400511E4593F3B91EAC) smtp.auth=clg@kaod.org
Subject: Re: [PATCH for-5.2 14/19] ftgmac100: Fix integer overflow in
 ftgmac100_do_tx()
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200806132106.747414-1-clg@kaod.org>
 <20200806132106.747414-15-clg@kaod.org>
 <CAFEAcA_rAre03ATda5rxgear4wsoef2-qD5SyAjunH8QW65W2A@mail.gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <7a6f7515-9a5f-3160-6187-675032ce8c75@kaod.org>
Date: Tue, 18 Aug 2020 16:54:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_rAre03ATda5rxgear4wsoef2-qD5SyAjunH8QW65W2A@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.97]
X-ClientProxiedBy: DAG1EX2.mxp5.local (172.16.2.2) To DAG4EX1.mxp5.local
 (172.16.2.31)
X-Ovh-Tracer-GUID: 1c83fb85-4045-4084-9bc1-a70a9dc7ffbb
X-Ovh-Tracer-Id: 16972941096381811564
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedruddtiedgjedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfhisehtkeertddtfeejnecuhfhrohhmpeevrogurhhitggpnfgvpgfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepheeutdehgefhvdehtdeuleetgedvfeeukedtfeeihfffffeiuddutdduhffgvedtnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucfkpheptddrtddrtddrtddpfeejrdehledrudegvddrleejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepmhigphhlrghnhedrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopehpvghtvghrrdhmrgihuggvlhhlsehlihhnrghrohdrohhrgh
Received-SPF: pass client-ip=178.32.125.2; envelope-from=clg@kaod.org;
 helo=smtpout1.mo529.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/18 10:54:05
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
Cc: Mauro Matteo Cascella <mcascell@redhat.com>,
 Frederic Konrad <konrad.frederic@yahoo.fr>, Andrew Jeffery <andrew@aj.id.au>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 Joel Stanley <joel@jms.id.au>, Ziming Zhang <ezrakiez@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/11/20 2:39 PM, Peter Maydell wrote:
> On Thu, 6 Aug 2020 at 14:21, Cédric Le Goater <clg@kaod.org> wrote:
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
> 
> If you want to be picky, this will unnecessarily fail for the case of
> a packet that is big enough for the vlan header but which has been
> split up into multiple tx descriptors such that the first one is
> smaller than the size of the eth_header. You could fix that by
> doing the insertion of the vlan tag when you process the TXDES0_LTS
> descriptor rather than when you process the TXDES0_FTS one. (We
> already save the des1 info where the INS_VLANTAG flag is in the
> 'flags' variable, so we have that available for the LTS descriptor code.)

yes. Good idea. The code is cleaner and the driver can even survive 
a bogus frame.

I will send a new version, without the Tested and Reviewed tags.

To reproduce, I have created a little kernel module tester based 
on the POC proposed by Ziming, which was for another MAC.

	https://github.com/legoater/ftgmac100-test

Thanks,

C. 
 


