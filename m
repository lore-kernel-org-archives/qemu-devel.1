Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD7B4C282DD
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 13:21:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C58E2073A
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 13:21:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C58E2073A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43686 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipBHM-0005TF-Qn
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 08:21:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35016)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1ipBGa-0004eV-1I
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 08:20:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1ipBGY-0002RT-TA
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 08:20:55 -0500
Received: from 5.mo179.mail-out.ovh.net ([46.105.43.140]:37284)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1ipBGY-0002Qe-NK
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 08:20:54 -0500
Received: from player759.ha.ovh.net (unknown [10.108.57.50])
 by mo179.mail-out.ovh.net (Postfix) with ESMTP id 72D491552BC
 for <qemu-devel@nongnu.org>; Wed,  8 Jan 2020 14:20:52 +0100 (CET)
Received: from kaod.org (lfbn-tou-1-1227-223.w90-76.abo.wanadoo.fr
 [90.76.50.223]) (Authenticated sender: clg@kaod.org)
 by player759.ha.ovh.net (Postfix) with ESMTPSA id 47266E018CB8;
 Wed,  8 Jan 2020 13:20:46 +0000 (UTC)
Subject: Re: [PATCH 2/2] pnv/psi: Consolidate some duplicated code in
 pnv_psi_realize()
To: Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>
References: <157841289975.66386.6463139590245180762.stgit@bahia.tlslab.ibm.com>
 <157841476667.66386.13659183399113837990.stgit@bahia.tlslab.ibm.com>
 <56272b35-c0ed-65de-310d-f97090e2b8c1@redhat.com>
 <20200108005453.GD2137@umbus.fritz.box> <20200108115845.07f10453@bahia.lan>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <da8ae351-d4fe-061d-a9f3-d275d3ba456c@kaod.org>
Date: Wed, 8 Jan 2020 14:20:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200108115845.07f10453@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 15507019418628361024
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrvdehkedgheduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfesthekredttdefjeenucfhrhhomhepveorughrihgtpgfnvggpifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpledtrdejiedrhedtrddvvdefnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejheelrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghenucevlhhushhtvghrufhiiigvpedt
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.43.140
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
Cc: qemu-ppc@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/8/20 11:58 AM, Greg Kurz wrote:
> On Wed, 8 Jan 2020 11:54:53 +1100
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
>> On Tue, Jan 07, 2020 at 07:32:03PM +0100, Philippe Mathieu-Daud=C3=A9 =
wrote:
>>> Hi Greg,
>>>
>>> On 1/7/20 5:32 PM, Greg Kurz wrote:
>>>> The proper way to do that would be to use device_class_set_parent_re=
alize(),
>>>> but defining a Pnv8PsiClass and a Pnv9PsiClass types with a parent_r=
ealize
>>>> pointer adds a fair amount of code. Calling pnv_psi_realize() explic=
itely
>>>> is fine for now.
>>>>
>>>> This should probably be achieved with a device realize hook in the
>>>> PSI base class and device_class_set_parent_realize() in the children
>>>> classes.
>>>
>=20
> I realize that this last paragraph is a leftover. First paragraph alrea=
dy
> mentions device_class_set_parent_realize() as being the "proper way".
>=20
> David,
>=20
> Can you remove it in your tree ? No big deal if you can't.
>=20
>>> Can you add a note explaining why the POWER10 PSI doesn't need it?
>>
>> For now, POWER10 uses the Pnv9PsiClass, I believe, so the question
>> doesn't arise.
>>
>=20
> This is correct and also a bit confusing, as proves Philippe's remark.
> Maybe we should come up with a PnvXivePsiClass and specialize it for
> POWER9 and POWER10.

Yes. I think this is the way to go.=20

P8 has a PSI device using the XICS interrupt interface. P9 and P10 use=20
the XIVE interface.

C.

