Return-Path: <SRS0=CqNf=4L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23A4CC35670
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Feb 2020 23:46:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD2E9206E0
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Feb 2020 23:46:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P9UTsj8f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD2E9206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j60xE-0007HX-W9
	for qemu-devel@archiver.kernel.org; Sun, 23 Feb 2020 18:46:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39351)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gshan@redhat.com>) id 1j60wL-0006jw-70
 for qemu-devel@nongnu.org; Sun, 23 Feb 2020 18:45:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <gshan@redhat.com>) id 1j60wJ-0004c9-R0
 for qemu-devel@nongnu.org; Sun, 23 Feb 2020 18:45:36 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:29893
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <gshan@redhat.com>) id 1j60wJ-0004ap-Ka
 for qemu-devel@nongnu.org; Sun, 23 Feb 2020 18:45:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582501534;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/rAMJ3kGj3lDsn30R3lXQuL9ztKKnhTKEoy5EuYoFpM=;
 b=P9UTsj8fu3Pw0eu5RxfS0FeTuqJ4QjK+AHSFbV4T7DYkz47cEgY/GcK1l/zfYriTGbVisg
 eyhKKRT7bxGCZkRLN3mP70KQCUjU1xc7H1eOkmts+qT7OV6gsVERi99iycRIhnheBGP6jo
 /aCJyIhQCInuiguSNekOoeUmjs5qt1k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-316-8Ri1HQzVPC6nhtNo6E7qfA-1; Sun, 23 Feb 2020 18:45:33 -0500
X-MC-Unique: 8Ri1HQzVPC6nhtNo6E7qfA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A900D107ACC5;
 Sun, 23 Feb 2020 23:45:31 +0000 (UTC)
Received: from localhost.localdomain (vpn2-54-48.bne.redhat.com [10.64.54.48])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2E68A90797;
 Sun, 23 Feb 2020 23:45:28 +0000 (UTC)
Subject: Re: [PATCH] hw/char/pl011: Output characters using best-effort mode
To: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20200220060108.143668-1-gshan@redhat.com>
 <f3c8adba729d050ba2144cc9c834fe82@kernel.org>
 <CAFEAcA8inLO75XOcCO3bUiiJQyZT+nqmp1be+z6ZtQx2a=68+g@mail.gmail.com>
 <fda602ae-43d5-728c-a5bb-f607f0acd3df@redhat.com>
 <CAFEAcA-VB1t2XDuAHgq_p2Fz8NQ+3HFgyNOzRjk8BjixNJb0qg@mail.gmail.com>
 <eedbac05-5a17-82e6-3cdc-c3b21983545b@redhat.com>
 <CAFEAcA-bHCLQGkFucY5RAY-mw9wFdDeOqCkcv0xgSRg-EYh9ew@mail.gmail.com>
 <fe7f3a60-5d90-ea3c-44d1-119f8b45b15c@redhat.com>
 <CAFEAcA-1UWOfbvhEOhOvozT8RwGoPgRwn2+Lh-UzP3WH8Vw+Kg@mail.gmail.com>
 <1ae86c0b-d4ab-8063-747b-ebea4950e76d@redhat.com>
From: Gavin Shan <gshan@redhat.com>
Message-ID: <ffbb0513-e24c-d41b-d511-a4bd2340d90a@redhat.com>
Date: Mon, 24 Feb 2020 10:45:26 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <1ae86c0b-d4ab-8063-747b-ebea4950e76d@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Reply-To: Gavin Shan <gshan@redhat.com>
Cc: Marc Zyngier <maz@kernel.org>, qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Shan Gavin <shan.gavin@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/22/20 5:15 AM, Paolo Bonzini wrote:
> On 21/02/20 14:14, Peter Maydell wrote:
>> The initial case reported by Gavin in this thread is
>> "-serial tcp:127.0.0.1:50900" with the other end being a program which
>> listens on TCP port 50900 and then sleeps without accepting any incoming
>> connections, which blocks the serial port output and effectively blocks
>> the guest bootup. If you want to insulate the guest from badly
>> behaved consumers like that (or the related consumer who accepts
>> the connection and then just doesn't read data from it) you probably
>> need to deal with more than just POLLHUP. But I'm not sure how much
>> we should care about these cases as opposed to just telling users
>> not to do that...
> 
> No, I think we don't do anything (on purpose; that is, it was considered
> the lesser evil) for x86 in that case.
> 

Paolo and Peter, thanks for your time on the discussion. So I think the
conclusion is we don't do anything for pl011 either? :)

Actually, the issue was reported by libvirt developer. A VM is started
with serial on tcp socket, which is never accepted on server side. It
practically blocks the VM to boot up. I will tell the libvirt developer
to hack their code to avoid the race if we don't do anything in qemu.

Thanks,
Gavin



