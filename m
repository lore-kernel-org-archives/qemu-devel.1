Return-Path: <SRS0=s40H=2U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED721C2D0CE
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Dec 2019 09:36:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B91AD2071E
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Dec 2019 09:36:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OzyPg3oh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B91AD2071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59856 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ilrTW-0005DR-Ru
	for qemu-devel@archiver.kernel.org; Mon, 30 Dec 2019 04:36:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49931)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mprivozn@redhat.com>) id 1ilrSo-0004nh-LP
 for qemu-devel@nongnu.org; Mon, 30 Dec 2019 04:35:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mprivozn@redhat.com>) id 1ilrSl-0001ot-7w
 for qemu-devel@nongnu.org; Mon, 30 Dec 2019 04:35:48 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51403
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mprivozn@redhat.com>) id 1ilrSl-0001oD-45
 for qemu-devel@nongnu.org; Mon, 30 Dec 2019 04:35:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577698546;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8dDc5VA02/974QSwotBy0uUSvjLviWjQ5nKER5bMnNE=;
 b=OzyPg3ohTY8qZfl2qVtnih+4PcNoaOBTEoSSs+TVuCnqL+bG7uuiZqtiQWoT896Mjq0iwZ
 KXpb8JHfvhtTEHTDRP3DkowkkB8Xha4KsTpgtKimC7Nsv8pkEhlNXXof8STRN+4VVlEqcv
 B7JVV7PasmVmAwk1lLcZ+nRkPl3ikRg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-272-p3G0awtrMES6n64h6zuekQ-1; Mon, 30 Dec 2019 04:35:45 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3826E8017DF
 for <qemu-devel@nongnu.org>; Mon, 30 Dec 2019 09:35:44 +0000 (UTC)
Received: from [10.40.204.31] (ovpn-204-31.brq.redhat.com [10.40.204.31])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6A69B5C1B0;
 Mon, 30 Dec 2019 09:35:37 +0000 (UTC)
Subject: Re: [PATCH] x86: Check for machine state object class before
 typecasting it
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <7cc91bab3191bfd7e071bdd3fdf7fe2a2991deb0.1577692822.git.mprivozn@redhat.com>
 <bda93e70-f737-4384-0422-3901767b6330@redhat.com>
From: =?UTF-8?B?TWljaGFsIFByw612b3puw61r?= <mprivozn@redhat.com>
Message-ID: <e70937bd-15e9-aa75-d894-b32b43052b6a@redhat.com>
Date: Mon, 30 Dec 2019 10:35:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <bda93e70-f737-4384-0422-3901767b6330@redhat.com>
Content-Language: sk-SK
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: p3G0awtrMES6n64h6zuekQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: pbonzini@redhat.com, mtosatti@redhat.com, Sergio Lopez <slp@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/30/19 9:41 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> On 12/30/19 9:00 AM, Michal Privoznik wrote:
>> In v4.2.0-246-ged9e923c3c the SMM property was moved from PC
>=20
> Typo v4.2.0-246-ged9e923c3c -> ed9e923c3c.

This depends on how you format the hash :-)
I've used 'git describe ed9e923c3c' because I find it more readable for
us humans (at least we see what version the commit was introduced in).
But I don't know what the praxis is in qemu.

>=20
>> machine class to x86 machine class. Makes sense, but the change
>> was too aggressive: in target/i386/kvm.c:kvm_arch_init() it
>> altered check which sets SMRAM if given machine has SMM enabled.
>> The line that detects whether given machine object is class of
>> PC_MACHINE was removed from the check. This makes qemu try to
>> enable SMRAM for all machine types, which is not what we want.
>>
>=20
> Fixes: ed9e923c3c
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Thanks,
Michal


