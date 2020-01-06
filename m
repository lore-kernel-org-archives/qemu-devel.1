Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1DEBC32771
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 07:26:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94D4520848
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 07:26:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94D4520848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48966 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioMmW-0004tu-Ob
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 02:26:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33559)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1ioMlw-00045z-FX
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 02:25:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1ioMlv-0006MN-Hh
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 02:25:56 -0500
Received: from 3.mo2.mail-out.ovh.net ([46.105.58.226]:47856)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1ioMlv-00063n-CC
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 02:25:55 -0500
Received: from player794.ha.ovh.net (unknown [10.108.16.238])
 by mo2.mail-out.ovh.net (Postfix) with ESMTP id 1BC041BD3CC
 for <qemu-devel@nongnu.org>; Mon,  6 Jan 2020 08:25:44 +0100 (CET)
Received: from kaod.org (lfbn-tou-1-1227-223.w90-76.abo.wanadoo.fr
 [90.76.50.223]) (Authenticated sender: clg@kaod.org)
 by player794.ha.ovh.net (Postfix) with ESMTPSA id DF7E6ADD7C44;
 Mon,  6 Jan 2020 07:25:40 +0000 (UTC)
Subject: Re: [PATCH 2/2] ppc/pnv: Use the CPU topology to compute the default
 number of chips
To: Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>
References: <157686069624.97184.12603452056634667288.stgit@bahia.lan>
 <157686070815.97184.16561911770080665569.stgit@bahia.lan>
 <20191221003906.GC15511@umbus.fritz.box> <20191221112849.68769d69@bahia.lan>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <2db93f13-2fa2-a569-d706-c92bc8adc06d@kaod.org>
Date: Mon, 6 Jan 2020 08:25:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191221112849.68769d69@bahia.lan>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 16210706861067766611
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrvdegledguddtjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefuvfhfhffkffgfgggjtgfgsehtjeertddtfeehnecuhfhrohhmpeevrogurhhitggpnfgvpgfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdeltddrjeeirdehtddrvddvfeenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeelgedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.58.226
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/21/19 11:28 AM, Greg Kurz wrote:
> On Sat, 21 Dec 2019 11:39:06 +1100
> David Gibson <david@gibson.dropbear.id.au> wrote:
> 
>> On Fri, Dec 20, 2019 at 05:51:48PM +0100, Greg Kurz wrote:
>>> Multi TCG mandates the CPU topology to be dimensioned to the actual
>>> number of CPUs, depending on the number of chips the user asked for.
>>> That is, '-machine num-chips=N' should always have a '-smp' companion
>>> with a topology that meats the resulting number of CPUs, typically
>>> '-smp sockets=N'.
>>>
>>> Simplify the command line for these setups by computing the default
>>> number of chips based on the CPU topology, ie. no need to explicitely
>>> set "num-chips" anymore. This must be done at machine init because
>>> smp_parse() is called after instance init.
>>>
>>> Signed-off-by: Greg Kurz <groug@kaod.org>
>>
>> Is there actually any reason to retain num-chips at all?  Or could we
>> just set the number of chips equal to the number of sockets, which
>> seems to make sense to me.
>>
> 
> I don't quite know why "num-chips" was introduced in the first place... so
> yes, if it turns out it isn't needed, I'll gladly drop the property.

I concur. We have some freedom on the PowerNV machine options. 
Let's replace "num-chips" with "sockets".

Thanks,

C. 

