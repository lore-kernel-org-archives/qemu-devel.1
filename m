Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE820C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 06:33:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 799B12070A
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 06:33:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D2R7BCEE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 799B12070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57148 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1javoe-0006Ve-Mm
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 02:33:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40436)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1javm4-0005B1-Da
 for qemu-devel@nongnu.org; Tue, 19 May 2020 02:30:48 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51427
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1javm1-0005Iq-W7
 for qemu-devel@nongnu.org; Tue, 19 May 2020 02:30:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589869844;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tdnGsjubL6Kabkz2MuTvwYWKZurp6T4fRYFqXAg73w0=;
 b=D2R7BCEEc8A96y+Hd/Y1/tSa0g0a6TYtUIq8//axdWGpGXhfqu9oqFC8iaxDHJrrO7h+L7
 3hTqP26V4VOiZA85tN8kura9dDEgCqg/CPjnlL333nB5pH+k7s6A9QQxHt1jUiro3p5wQk
 TSJ46DrM+ihmMmuDFa26VAwPMBT+v3c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-84-n7WUZrzDP4OV_YSXVu9qGg-1; Tue, 19 May 2020 02:30:43 -0400
X-MC-Unique: n7WUZrzDP4OV_YSXVu9qGg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D680D107B265;
 Tue, 19 May 2020 06:30:41 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-32.ams2.redhat.com
 [10.36.112.32])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9F86B82A0D;
 Tue, 19 May 2020 06:30:41 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4AB4811358BC; Tue, 19 May 2020 08:30:40 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
Subject: Re: [PATCH 18/24] display/sm501 display/ati: Fix to realize "i2c-ddc"
References: <20200518050408.4579-1-armbru@redhat.com>
 <20200518050408.4579-19-armbru@redhat.com>
 <alpine.BSF.2.22.395.2005181228030.5961@zero.eik.bme.hu>
Date: Tue, 19 May 2020 08:30:40 +0200
In-Reply-To: <alpine.BSF.2.22.395.2005181228030.5961@zero.eik.bme.hu> (BALATON
 Zoltan's message of "Mon, 18 May 2020 12:32:26 +0200 (CEST)")
Message-ID: <87y2po4esv.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=205.139.110.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/18 23:56:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: berrange@redhat.com, ehabkost@redhat.com,
 Magnus Damm <magnus.damm@gmail.com>,
 Philippe =?utf-8?Q?Math?= =?utf-8?Q?ieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org, Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 qemu-ppc@nongnu.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

BALATON Zoltan <balaton@eik.bme.hu> writes:

> On Mon, 18 May 2020, Markus Armbruster wrote:
>> sm501_init() and ati_vga_realize() create an "i2c-ddc" device, but
>> neglect to realize it.  Affects machines sam460ex, shix, r2d, and
>> fulong2e.
>>
>> I wonder how this ever worked.  If the "device becomes real only on
>> realize" thing actually works, then we've always been missing the
>> device, yet nobody noticed.
>
> No idea why it worked but guests can read EDID info fine with or
> without this patch, so
>
> Tested-by: BALATON Zoltan <balaton@eik.bme.hu>

Thanks!

> Maybe device is created and working after init as it has nothing
> special to do at realize (it doesn't even have a realize method) so
> all realize would do is to link it in qtree?

Plausible.


