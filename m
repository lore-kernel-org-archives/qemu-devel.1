Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC204C433E9
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 13:37:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E95E2072A
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 13:37:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E95E2072A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57258 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDpQg-00082H-Mf
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 09:37:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45206)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.gruenbichler@proxmox.com>)
 id 1kDpPy-0006mA-Bl; Thu, 03 Sep 2020 09:36:46 -0400
Received: from proxmox-new.maurer-it.com ([212.186.127.180]:20598)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.gruenbichler@proxmox.com>)
 id 1kDpPw-00009A-3h; Thu, 03 Sep 2020 09:36:45 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 8A820449DA;
 Thu,  3 Sep 2020 15:36:40 +0200 (CEST)
Date: Thu, 03 Sep 2020 15:36:30 +0200
From: Fabian =?iso-8859-1?q?Gr=FCnbichler?= <f.gruenbichler@proxmox.com>
Subject: Re: [RFC qemu 0/6] mirror: implement incremental and bitmap modes
To: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>
References: <20200218100740.2228521-1-f.gruenbichler@proxmox.com>
 <d35a76de-78d5-af56-0b34-f7bd2bbd3733@redhat.com>
 <1599127031.9uxdp5h9o2.astroid@nora.none>
 <ef545f46-7cbb-43f0-2ab8-f3d49643d1e6@redhat.com>
 <20200903123850.GB8835@linux.fritz.box>
 <ec747431-b2fa-2e67-984b-3cf70e0c79e4@redhat.com>
 <20200903132343.GD8835@linux.fritz.box>
In-Reply-To: <20200903132343.GD8835@linux.fritz.box>
MIME-Version: 1.0
User-Agent: astroid/0.15.0 (https://github.com/astroidmail/astroid)
Message-Id: <1599140071.n44h532eeu.astroid@nora.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=212.186.127.180;
 envelope-from=f.gruenbichler@proxmox.com; helo=proxmox-new.maurer-it.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 09:36:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On September 3, 2020 3:23 pm, Kevin Wolf wrote:
> Am 03.09.2020 um 14:57 hat Max Reitz geschrieben:
>> On 03.09.20 14:38, Kevin Wolf wrote:
>> > Am 03.09.2020 um 13:04 hat Max Reitz geschrieben:
>> >> On 03.09.20 12:13, Fabian Gr=C3=BCnbichler wrote:
>> >>> On August 21, 2020 3:03 pm, Max Reitz wrote:
>> >>>> On 18.02.20 11:07, Fabian Gr=C3=BCnbichler wrote:
>> >>> I am not sure how=20
>> >>> the S-O-B by John is supposed to enter the mix - should I just inclu=
de=20
>> >>> it in the squashed patch (which would be partly authored, but=20
>> >>> not-yet-signed-off by him otherwise?)?
>> >>
>> >> I=E2=80=99m not too sure on the proceedings, actually.  I think it sh=
ould be
>> >> fine if you put his S-o-b there, as long as your patch is somehow bas=
ed
>> >> on a patch that he sent earlier with his S-o-b underneath.  But I=E2=
=80=99m not
>> >> sure.
>> >=20
>> > Signed-off-by means that John certifies the DCO for the patch (at leas=
t
>> > the original version that you possibly modified), so you cannot just a=
dd
>> > it without asking him.
>>=20
>> But what if you take a patch from someone and heavily modify it =E2=80=
=93
>> wouldn=E2=80=99t you keep the original S-o-b and explain the modificatio=
ns in
>> the commit message?
>=20
> Ah, if that patch already had a S-o-b, then yes. You keep it not only to
> show who touched the patch, but also because your own S-o-b depends on
> the one from the original author (you only have the rights to contribute
> it because the original author had them and could pass them on to you).
>=20
> I thought it was based on a patch that came without S-o-b.

it is (taken from John's git, with his approval, and implicit admission=20
that S-O-B is just missing because it was a WIP branch/tree that I=20
started from). that was also the reason why I kept that patch unmodified=20
and sent my modifications as patches on-top, to make it easier for John=20
to verify that that one patch is his original WIP one and add this=20
missing S-O-B ;)
=


