Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 622E8C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 12:42:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8F5D2087D
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 12:42:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8F5D2087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46724 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kItF3-0004JG-Qh
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 08:42:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39698)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>)
 id 1kItDm-000311-N9; Thu, 17 Sep 2020 08:41:06 -0400
Received: from smtpout1.mo529.mail-out.ovh.net ([178.32.125.2]:45399)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>)
 id 1kItDk-0005rr-8W; Thu, 17 Sep 2020 08:41:06 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.109.146.241])
 by mo529.mail-out.ovh.net (Postfix) with ESMTPS id 7F9285C19013;
 Thu, 17 Sep 2020 14:41:00 +0200 (CEST)
Received: from kaod.org (37.59.142.103) by DAG8EX1.mxp5.local (172.16.2.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2044.4; Thu, 17 Sep
 2020 14:41:00 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-103G0051453eb26-7ba2-471e-8540-048e502fffdc,
 CCC0D77BD3F1F8C36E09B026C91493862201CFF2) smtp.auth=groug@kaod.org
Date: Thu, 17 Sep 2020 14:40:58 +0200
From: Greg Kurz <groug@kaod.org>
To: "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>
Subject: Re: [PATCH 14/15] spapr: Simplify error handling in
 spapr_memory_plug()
Message-ID: <20200917144058.3075e5ac@bahia.lan>
In-Reply-To: <20200917121851.GA1597829@redhat.com>
References: <20200914123505.612812-1-groug@kaod.org>
 <20200914123505.612812-15-groug@kaod.org>
 <11f0dcb7-7923-0164-df69-4911b3293663@virtuozzo.com>
 <20200915134340.0cc3f9eb@bahia.lan>
 <20200917011525.GI5258@yekko.fritz.box>
 <87lfh8g8dy.fsf@dusky.pond.sub.org>
 <20200917120437.6ab60ca4@bahia.lan>
 <87ft7g1uee.fsf@dusky.pond.sub.org>
 <20200917121851.GA1597829@redhat.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [37.59.142.103]
X-ClientProxiedBy: DAG4EX1.mxp5.local (172.16.2.31) To DAG8EX1.mxp5.local
 (172.16.2.71)
X-Ovh-Tracer-GUID: 5e765845-a1e2-4518-8036-58db5d91190a
X-Ovh-Tracer-Id: 6439021568538810662
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedujedrtdeggdehiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtgfgihesthhqredtredtjeenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepveelhfdtudffhfeiveehhfelgeellefgteffteekudegheejfffghefhfeeuudffnecukfhppedtrddtrddtrddtpdefjedrheelrddugedvrddutdefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepmhigphhlrghnhedrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopegurghvihgusehgihgsshhonhdrughrohhpsggvrghrrdhiugdrrghu
Received-SPF: pass client-ip=178.32.125.2; envelope-from=groug@kaod.org;
 helo=smtpout1.mo529.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/17 08:41:01
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-ppc@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 17 Sep 2020 13:18:51 +0100
Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:

> On Thu, Sep 17, 2020 at 02:04:41PM +0200, Markus Armbruster wrote:
> > Greg Kurz <groug@kaod.org> writes:
> >=20
> > > $ git grep object_property_get_uint -- :^{include,qom/object.c} | wc =
-l
> > > 60
> > >
> > > Manual inspecting the output of
> > >
> > > $ git grep -W object_property_get_uint -- :^{include,qom/object.c}
> > > ...
> > >
> > > seems to be showing that most users simply ignore errors (ie. pass NU=
LL
> > > as 3rd argument). Then some users pass &error_abort and only a few
> > > pass a &err or errp.
> > >
> > > Assuming that users know what they're doing, I guess my proposal
> > > wouldn't bring much to the code base in the end... I'm not even
> > > sure now that it's worth changing the contract.
> >=20
> > We'd change
> >=20
> >     val =3D object_property_get_uint(obj, name, &error_abort);
> >=20
> > to
> >=20
> >     object_property_get_uint(obj, name, &val, &error_abort);
> >=20
> > which is not an improvement.
> >=20
> > Most of the ones passing NULL should probably pass &error_abort
> > instead.  Doesn't change the argument.
>=20
> I wonder if we actually need to have an Error  parameter at all for
> the getters. IIUC the only valid runtime error  is probably the case
> where the property has not been set, and even then, I think properties
> usually have a default value that would be returned.  All the other
> errors look like programmer errors.
>=20
> IOW, can we remove the Error parameter and have all the o_p_get*
> method impls use error_abort.
>=20
> In the rare case where a caller needs to handle a property not
> being set, they can use object_property_find() as a test before
> invoking the getter.
>=20

I tend to agree.

> Of course requires someone motivated to audit all the case that
> are not using NULL or error_abort and decide whether the attempt
> at passing a local errp was actually justified or not.
>=20

Since I've open the can of worms, I'm volunteering to do that if
we have a consensus on the fact that "the only valid runtime
error os the case the property has not been set".

Cheers,

--
Greg

> Regards,
> Daniel


