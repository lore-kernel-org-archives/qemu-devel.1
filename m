Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19857C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 06:36:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBEB620709
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 06:36:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bRfpO2NQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBEB620709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59554 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1javre-0007kN-4B
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 02:36:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40786)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1javql-0007Dh-TD
 for qemu-devel@nongnu.org; Tue, 19 May 2020 02:35:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57835
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1javql-0006BN-8A
 for qemu-devel@nongnu.org; Tue, 19 May 2020 02:35:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589870138;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r2O32gC9uA6066YhYwTw+WPF6Meohyj6ez/n0lmrs9g=;
 b=bRfpO2NQkoiAuGwimBFUtjX9Q+snVqyN+grjjpAuT8x7i52Y331QNV4cj9oNNXgQtGTOX8
 tryXhZS4FIKZIARL3UcIwfCPBXZ6SiCrRJQDx8tqopdt8ZToaH/dLj6SAxqAz97hhA2vhG
 9ttAgwuRAPFmUwk7FreQg5kT6E2Pids=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-447-mDfaVhTVMSKxDgZD4T4mvg-1; Tue, 19 May 2020 02:35:34 -0400
X-MC-Unique: mDfaVhTVMSKxDgZD4T4mvg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 80F19A0BDC;
 Tue, 19 May 2020 06:35:33 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-32.ams2.redhat.com
 [10.36.112.32])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3054A10013D9;
 Tue, 19 May 2020 06:35:33 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B405C11358BC; Tue, 19 May 2020 08:35:31 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH 18/24] display/sm501 display/ati: Fix to realize "i2c-ddc"
References: <20200518050408.4579-1-armbru@redhat.com>
 <20200518050408.4579-19-armbru@redhat.com>
 <alpine.BSF.2.22.395.2005181238010.5961@zero.eik.bme.hu>
 <43c11226-9bbd-103d-4f9c-4b94c5d95f99@redhat.com>
Date: Tue, 19 May 2020 08:35:31 +0200
In-Reply-To: <43c11226-9bbd-103d-4f9c-4b94c5d95f99@redhat.com> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Mon, 18 May 2020 12:45:57
 +0200")
Message-ID: <87tv0c4eks.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/19 00:34:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>, berrange@redhat.com,
 ehabkost@redhat.com, Magnus Damm <magnus.damm@gmail.com>,
 qemu-devel@nongnu.org, Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 qemu-ppc@nongnu.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> On 5/18/20 12:39 PM, BALATON Zoltan wrote:
>> On Mon, 18 May 2020, Markus Armbruster wrote:
>>> sm501_init() and ati_vga_realize() create an "i2c-ddc" device, but
>>> neglect to realize it.=C2=A0 Affects machines sam460ex, shix, r2d, and
>>> fulong2e.
>>>
>>> I wonder how this ever worked.=C2=A0 If the "device becomes real only o=
n
>>> realize" thing actually works, then we've always been missing the
>>> device, yet nobody noticed.
>>>
>>> Fix by realizing it right away.=C2=A0 Visible in "info qom-tree"; here'=
s
>>> the change for sam460ex:
>>>
>>> =C2=A0=C2=A0=C2=A0 /machine (sam460ex-machine)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [...]
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /unattached (container)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [...]
>>> =C2=A0=C2=A0 -=C2=A0=C2=A0=C2=A0 /device[14] (sii3112)
>>> =C2=A0=C2=A0 +=C2=A0=C2=A0=C2=A0 /device[14] (i2c-ddc)
>>> =C2=A0=C2=A0 +=C2=A0=C2=A0=C2=A0 /device[15] (sii3112)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [rest of device[*] renumbere=
d...]
>>>
>>> Fixes: 4a1f253adb45ac6019971193d5077c4d5d55886a
>>> Fixes: 4a1f253adb45ac6019971193d5077c4d5d55886a
>>
>> One of these is probably meant to be
>> c82c7336de58876862e6b4dccbda29e9240fd388

Pasto, thanks!

> :)
>
>> although I'm not sure having a Fixes tag makes sense for this commit.
>
> AFAIK the 'Fixes' tag is not well defined in QEMU.

True.

> I personally find it handy to navigate between commits in gitk, not
> having to go via unrelated commits, which is why I use it.
> Linux kernel seems to have a stricter approach, only using it for
> security bug fixes. For this QEMU uses 'Cc: qemu-stable'.

We cc: qemu-stable for show-stoppers without security impact, too.

> Do we need to clarify its use on the wiki?

If we can build rough consensus on how we want it used, yes.


