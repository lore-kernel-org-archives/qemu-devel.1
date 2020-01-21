Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FD9DC2D0CE
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 10:45:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0250222522
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 10:45:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0250222522
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51304 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itr25-00036F-29
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 05:45:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37246)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1itr1I-0002EW-RJ
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 05:44:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1itr1H-0006DK-Dk
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 05:44:28 -0500
Received: from 1.mo179.mail-out.ovh.net ([178.33.111.220]:52986)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1itr1H-00068k-78
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 05:44:27 -0500
Received: from player739.ha.ovh.net (unknown [10.108.57.72])
 by mo179.mail-out.ovh.net (Postfix) with ESMTP id B89A01573D4
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2020 11:44:24 +0100 (CET)
Received: from kaod.org (82-64-250-170.subs.proxad.net [82.64.250.170])
 (Authenticated sender: clg@kaod.org)
 by player739.ha.ovh.net (Postfix) with ESMTPSA id 41640A6F73AC;
 Tue, 21 Jan 2020 10:44:15 +0000 (UTC)
Subject: Re: [PATCH 2/2] aspeed/i2c: Prevent uninitialized warning
To: Thomas Huth <thuth@redhat.com>, mrezanin@redhat.com, qemu-devel@nongnu.org
References: <cover.1579598240.git.mrezanin@redhat.com>
 <07957dcab31f65de3dd30efa91e6b9152ac79879.1579598240.git.mrezanin@redhat.com>
 <c1b01c90-e42c-b65f-c7b8-2a589510a7d0@redhat.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <fdc3e6c2-87e4-2e51-cbee-d9c7a008eec9@kaod.org>
Date: Tue, 21 Jan 2020 11:44:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <c1b01c90-e42c-b65f-c7b8-2a589510a7d0@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 15422576926850845675
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedrudekgddukecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefuvfhfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpeevrogurhhitggpnfgvpgfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdekvddrieegrddvhedtrddujedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeefledrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 178.33.111.220
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
Cc: Andrew Jeffery <andrew@aj.id.au>, peter.maydell@linaro.org,
 qemu-trivial@nongnu.org, Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/21/20 11:02 AM, Thomas Huth wrote:
> On 21/01/2020 10.28, mrezanin@redhat.com wrote:
>> From: Miroslav Rezanina <mrezanin@redhat.com>
>>
>> Compiler reports uninitialized warning for cmd_flags variable.
>>
>> Adding NULL initialization to prevent this warning.
>>
>> Signed-off-by: Miroslav Rezanina <mrezanin@redhat.com>
>> ---
>>  hw/i2c/aspeed_i2c.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c
>> index 2da04a4..445182a 100644
>> --- a/hw/i2c/aspeed_i2c.c
>> +++ b/hw/i2c/aspeed_i2c.c
>> @@ -400,7 +400,7 @@ static bool aspeed_i2c_check_sram(AspeedI2CBus *bus)
>>  
>>  static void aspeed_i2c_bus_cmd_dump(AspeedI2CBus *bus)
>>  {
>> -    g_autofree char *cmd_flags;
>> +    g_autofree char *cmd_flags = NULL;
>>      uint32_t count;
>>  
>>      if (bus->cmd & (I2CD_RX_BUFF_ENABLE | I2CD_RX_BUFF_ENABLE)) {
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> 
> ... maybe someone with enough Perl-foo (i.e. not me ;-)) should add a
> check to our check_patch.pl script so that it complains when new code is
> introduced that uses g_autofree without initializing the variable...

weird. The cmd_flags variable is assigned just after and used
in a trace. 

C.

