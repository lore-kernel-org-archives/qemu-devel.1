Return-Path: <SRS0=7PPA=SN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28108C10F13
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 12:23:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA1EB2133D
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 12:23:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA1EB2133D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48072 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEYk2-0000k1-2Q
	for qemu-devel@archiver.kernel.org; Thu, 11 Apr 2019 08:23:42 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56935)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hEYh3-0007MR-Vd
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 08:20:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hEYh2-0002cf-Ua
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 08:20:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35624)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hEYh2-0002cU-O0
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 08:20:36 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 91A983089EF2;
	Thu, 11 Apr 2019 12:20:35 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-116.ams2.redhat.com
	[10.36.116.116])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 707C31001E7C;
	Thu, 11 Apr 2019 12:20:29 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 061481138648; Thu, 11 Apr 2019 14:20:28 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
References: <1554750276-19230-1-git-send-email-lidong.chen@oracle.com>
	<87mukziv48.fsf@dusky.pond.sub.org>
	<BN6PR2201MB125156A5AB0000731B85E76BC62D0@BN6PR2201MB1251.namprd22.prod.outlook.com>
	<cd833acf-4643-0d3c-78f5-7677d224954e@redhat.com>
	<20190411115216.GN3641@redhat.com>
Date: Thu, 11 Apr 2019 14:20:27 +0200
In-Reply-To: <20190411115216.GN3641@redhat.com> ("Daniel P. =?utf-8?Q?Berr?=
	=?utf-8?Q?ang=C3=A9=22's?=
	message of "Thu, 11 Apr 2019 12:52:16 +0100")
Message-ID: <87v9zkzqb8.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.45]);
	Thu, 11 Apr 2019 12:20:36 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] sd: Fix out-of-bounds assertions
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Peter Maydell <peter.maydell@linaro.org>,
	Aleksandar Rikalo <arikalo@wavecomp.com>, Jason Wang <jasowang@redhat.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"f4bug@amsat.org" <f4bug@amsat.org>, Lidong Chen <lidong.chen@oracle.com>,
	"darren.kenny@oracle.com" <darren.kenny@oracle.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Aleksandar Markovic <amarkovic@wavecomp.com>,
	Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
	Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	Aurelien Jarno <aurelien@aurel32.net>,
	David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190411122027.cVQ_7QCXYCvCrsfWZawM0-VAYHd2BRaIKXPPq4i1gvE@z>

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Tue, Apr 09, 2019 at 11:37:44AM +0200, Philippe Mathieu-Daud=C3=A9 wro=
te:
[...]
>> I remember this post from Daniel where he suggests sticking to GLib
>> G_N_ELEMENTS() (which looks similar to your suggestion):
>> https://lists.gnu.org/archive/html/qemu-devel/2018-11/msg02676.html
>>=20
>> $ git grep G_N_ELEMENTS|wc -l
>> 125
>> $ git grep ARRAY_SIZE|wc -l
>> 939
>>=20
>> Now it is not obvious to me to understand which GLib API we are
>> encouraged to use and which ones we shouldn't.
>
> We have a bunch of duplication that is essentially a historical
> artifact from before we used GLib in QEMU. IMHO, if GLib provides
> something that is equivalent with no functional downside that
> matters to QEMU, then there's no reason to keep QEMU's duplicate.
>
> IOW, I would always prefer GLib unless there's a compelling reason
> not to in order to minimize what we maintain ourselves

Without a tree-wide sweep, we won't ever stop maintaining ARRAY_SIZE().

As long as we maintain it anyway, I'd prefer it over G_N_ELEMENTS()
myself, because I consider latter name in poor taste: elements of
*what*?

