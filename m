Return-Path: <SRS0=xVqP=Z2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17C7FC43603
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 13:31:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D757920675
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 13:31:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dUTzt/Os"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D757920675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38908 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icUkB-0000WR-2A
	for qemu-devel@archiver.kernel.org; Wed, 04 Dec 2019 08:31:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60892)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1icUjD-0008Mb-4b
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 08:30:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1icUjB-0007Ta-Sb
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 08:30:03 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39359
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1icUjB-0007TM-Pf
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 08:30:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575466201;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=rRLjYxlhZes/kzF4zBZOobG0hp8DyG9ry/28Q215LlM=;
 b=dUTzt/OsIp7KUV1w+SEugoY7JFebp193xRq96ktxkV/8RIY1itXjhdcWAa7nC55lM2+zDA
 CzFdcLSBJK6hpH7J+HzhGgQfJv/CoEU+r8HFkoYqAS7Dg5hcQyJCljZczQB4vQ6YPehKdf
 hKmtjuji9FVCzCwBxRV5bxejzf7+9u8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-203-O7neUIikOVK1vfdKpJBgdw-1; Wed, 04 Dec 2019 08:29:57 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4895A8005B6;
 Wed,  4 Dec 2019 13:29:56 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-117-39.ams2.redhat.com [10.36.117.39])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0386260BE0;
 Wed,  4 Dec 2019 13:29:45 +0000 (UTC)
Subject: Re: virtiofsd: Where should it live?
To: Kevin Wolf <kwolf@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
References: <20191126102600.GG556568@redhat.com>
 <20191126121416.GE2928@work-vm>
 <CAFEAcA9Ln2uwg4f4s8oS6VeQk83W3BErmH9cHeyDJy7v-4gNxw@mail.gmail.com>
 <87k17ekhs9.fsf@dusky.pond.sub.org>
 <fef0eaaf-149a-f8a8-02c5-821d2d42becd@redhat.com>
 <20191203105341.GB3078@work-vm>
 <CAFEAcA8bjGAs7JSTNYYYwCH1yF06i0v0r9wjKXqZGZg_Sqy0VA@mail.gmail.com>
 <20191203111949.GB267814@redhat.com> <87o8wofsda.fsf@dusky.pond.sub.org>
 <20191204081726.md3qakjtszftnuag@sirius.home.kraxel.org>
 <20191204132810.GB20250@dhcp-200-226.str.redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <7fd86048-ae06-14df-fb68-b0b04b8545ec@redhat.com>
Date: Wed, 4 Dec 2019 14:29:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191204132810.GB20250@dhcp-200-226.str.redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: O7neUIikOVK1vfdKpJBgdw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, mszeredi@redhat.com, Jason Wang <jasowang@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 vgoyal@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Max Reitz <mreitz@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 04/12/2019 14.28, Kevin Wolf wrote:
> Am 04.12.2019 um 09:17 hat Gerd Hoffmann geschrieben:
>>   Hi,
>>
>>>>     |   ...
>>>>     +- qemu-edid
>>>
>>> Has its own MAINTAINERS section, together with hw/display/edit* and
>>> include/hw/display/edid.h.  I'm not sure moving it hw/display/ is a good
>>> idea.  Gerd?
>>
>> Sort-of makes sense.  My personal preference would be a tools/ directory
>> for all those small utilities though.
> 
> I think I would like that better than throwing tools into block/ where
> currently mostly just block drivers live.

+1 for tools/

 Thomas


