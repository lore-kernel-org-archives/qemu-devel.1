Return-Path: <SRS0=xVqP=Z2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEEE2C43603
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 14:37:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A05C205F4
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 14:37:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pk08aSpV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A05C205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39818 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icVmt-0004NZ-Kr
	for qemu-devel@archiver.kernel.org; Wed, 04 Dec 2019 09:37:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44590)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1icVlS-00031U-SW
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 09:36:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1icVlR-0004NE-OF
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 09:36:26 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53579
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1icVlR-0004Mx-J5
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 09:36:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575470185;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wXo36HgzlbTfTaQKoAHPr3/cD5/dZ7/sHcvhO/TIFo4=;
 b=Pk08aSpVVnt322+iGAUnZCSmD9G8/kgmp119xLXF1a7gtSg3Aun5vj4GlGD4j4LaeVOJ5X
 fgqZHdTwvMDRQohVnCX9IRYsO7/1OaRD5bkJEBgOgoUOFsJZnjfmtjNdi1T1TTJWuKUTge
 a/+uVMmkMCVcs4WuuIvIhKN1EZJa26c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-275-wHK5jtmaOnu0l_1a7dMO_A-1; Wed, 04 Dec 2019 09:36:22 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 834F4911FA;
 Wed,  4 Dec 2019 14:36:21 +0000 (UTC)
Received: from [10.3.116.171] (ovpn-116-171.phx2.redhat.com [10.3.116.171])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 98B8C5D6B7;
 Wed,  4 Dec 2019 14:36:12 +0000 (UTC)
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
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <02eec949-f768-dd42-fb46-284489c1a964@redhat.com>
Date: Wed, 4 Dec 2019 08:36:12 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191204132810.GB20250@dhcp-200-226.str.redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: wHK5jtmaOnu0l_1a7dMO_A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, mszeredi@redhat.com, Jason Wang <jasowang@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 vgoyal@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Max Reitz <mreitz@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/4/19 7:28 AM, Kevin Wolf wrote:
> Am 04.12.2019 um 09:17 hat Gerd Hoffmann geschrieben:
>>    Hi,
>>
>>>>      |   ...
>>>>      +- qemu-edid
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

Ooh, I should have read this sub-thread before writing my reply at the 
top level.  Yes, I like the idea of tools/ for qemu-img, qemu-io, and 
qemu-nbd better than block/.

> 
> Or, if we want to move the tools there, we'd need another directory
> level inside block/ to keep things reasonably organised.

Separating drivers from executables sounds worthwhile either way, 
whether that division is by a new tools/ or by a subdirectory in block/.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


