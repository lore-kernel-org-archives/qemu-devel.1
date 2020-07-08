Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22636C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 21:45:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD59A206A1
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 21:45:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LY1dHPeF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD59A206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33684 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtHsQ-0001eG-1D
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 17:45:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34776)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jtHdq-0003Pj-7j
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 17:30:10 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:52087
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jtHdo-0002KI-CC
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 17:30:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594243807;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DHNaDP30Y0z64Qau1BQkfPRIFI8A6468tSSeYZ3almU=;
 b=LY1dHPeF07+qkydq9vH7BRfR6wzPnY9hRYJKyRn1OwpofbkhfHVfXI9N4Rce56hw9+LuH9
 wdBwVus6+2jUqq7atkCfcJ33ypVMvvaycVRtAqMIKLW5sunngW2U06mYQ4oC8OIiq4fOiL
 TkRzIYR62nMKeyNbRexOHxglrcCqiZ8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-449-TPcfYAm3MmmdNIduf44Qnw-1; Wed, 08 Jul 2020 05:24:47 -0400
X-MC-Unique: TPcfYAm3MmmdNIduf44Qnw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7A99310059BA;
 Wed,  8 Jul 2020 09:24:46 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2946B60E1C;
 Wed,  8 Jul 2020 09:24:45 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 704C61132FD2; Wed,  8 Jul 2020 11:24:44 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: Slow down with: 'Make "info qom-tree" show children sorted'
References: <20200527084754.7531-1-armbru@redhat.com>
 <20200527084754.7531-3-armbru@redhat.com>
 <49bea110-0a3d-5a40-6647-67b116fb41b5@redhat.com>
 <20200707094006.GE2649462@redhat.com>
Date: Wed, 08 Jul 2020 11:24:44 +0200
In-Reply-To: <20200707094006.GE2649462@redhat.com> ("Daniel P. =?utf-8?Q?B?=
 =?utf-8?Q?errang=C3=A9=22's?=
 message of "Tue, 7 Jul 2020 10:40:06 +0100")
Message-ID: <87tuyi2wbn.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 17:25:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 ehabkost@redhat.com, philmd@redhat.com, mark.cave-ayland@ilande.co.uk,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Greg Kurz <groug@kaod.org>, =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 pbonzini@redhat.com, David Gibson <dgibson@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Tue, Jul 07, 2020 at 06:45:57AM +0200, Thomas Huth wrote:
>> On 27/05/2020 10.47, Markus Armbruster wrote:
>> > "info qom-tree" prints children in unstable order.  This is a pain
>> > when diffing output for different versions to find change.  Print it
>> > sorted.
>> >=20
>> > Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> > ---
>> >  qom/qom-hmp-cmds.c | 24 ++++++++++++++++--------
>> >  1 file changed, 16 insertions(+), 8 deletions(-)
>>=20
>>  Hi Markus,
>>=20
>> this patch causes a slow down of the qtests which becomes quite massive
>> when e.g. using the ppc64 and thourough testing. When I'm running
>>=20
>> QTEST_QEMU_BINARY=3D"ppc64-softmmu/qemu-system-ppc64" time \
>> ./tests/qtest/device-introspect-test -m slow | tail -n 10
>>=20
>> the test runs for ca. 6m40s here before the patch got applied, and for
>> mor than 20 minutes after the patch got applied!
>
> I think the test case itself could be optimized. Currently it does
> approx
>
>    for each device type
>       info qom-tree
>       device_addr type,help
>       info qom-tree
>
> it compares the before/after qom-tree to look for stray objects or
> to try to trigger crashes.
>
> The info qom-tree calls could be pushed outside the loop
>
>    info qom-tree
>    for each device type
>       device_addr type,help
>    info qom-tree
>
> Taking /x86_64/device/introspect/concrete/defaults/pc-q35-5.1 as a
> example, this change is the difference between 20 seconds running and
> 3 seconds running.

Patch?

> Reverting Markus' change actually didn't make much difference, only
> reducing the 20 seconds to 17 seconds.

I found and plugged a memory leak.  I haven't checked its impact on test
performance.

> The downside is that if there is a stray object/crash, it would not
> immediately associate with the device type. I'm not sure that's a
> real problem though. Especially if we are running this as pre-merge
> CI we'll only need to look at the patch series to find the broken
> device. If this is quick enough that we can run it as standard,
> instead of only with -m slow, then its a net win I think.

Easier investigation of failures is a valid argument, but not at this
price.  Our "make check" is painfully slow.


