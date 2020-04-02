Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB612C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 14:34:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86E552073B
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 14:34:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cGRL9e40"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86E552073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jK0vi-0001T3-Mt
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 10:34:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33353)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jK0uo-0000Mt-IY
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 10:33:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jK0un-00013e-L4
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 10:33:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43940
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jK0un-00013L-GH
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 10:33:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585838032;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dPyiKY2RFW7sWHbuE2bRTqYuhuWzOCTpoU1Dir9iUkw=;
 b=cGRL9e401vf3hFR3yLb4gLBCDPbtSXjdse2qCSEyRzohYWV4+2MsaBCBTqbGn3fcCMTVTd
 1gTt4uD0WkCekiKYGHd4a7zfapQd8NmAB5PWUOYZdSHf4qP1TeBM+ExdG+9KylVNfSos2k
 ig2P0WywCmCTrGbf3Kt+PNw7JCjQBYI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-72-yYt-B2LHPwWHNJglcA-9DA-1; Thu, 02 Apr 2020 10:33:50 -0400
X-MC-Unique: yYt-B2LHPwWHNJglcA-9DA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ABCDA1005513;
 Thu,  2 Apr 2020 14:33:49 +0000 (UTC)
Received: from [10.3.113.246] (ovpn-113-246.phx2.redhat.com [10.3.113.246])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DEB1F5D9C9;
 Thu,  2 Apr 2020 14:33:48 +0000 (UTC)
Subject: Re: Questionable aspects of QEMU Error's design
To: Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <87o8sblgto.fsf@dusky.pond.sub.org>
 <CAFEAcA_b1gZ-B4NaEdQS2zffdvobW=FUx4ysEgXVAz+=cZ+R3Q@mail.gmail.com>
 <87sghmbfgc.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <e36dbbe6-e1ce-e0ab-f257-9b4b0cece03e@redhat.com>
Date: Thu, 2 Apr 2020 09:33:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <87sghmbfgc.fsf@dusky.pond.sub.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/2/20 12:54 AM, Markus Armbruster wrote:
> Peter Maydell <peter.maydell@linaro.org> writes:

> It's a small improvement.  A bigger one is
> 
>          if (object_property_set_link(cpuobj, OBJECT(&s->cpu_container[i]),
>                                       "memory", errp)) {
>              return;
>          }
>          if (object_property_set_link(cpuobj, OBJECT(s), "idau", errp)) {
>              return;
>          }
>          if (object_property_set_bool(cpuobj, true, "realized", errp)) {
>              return;
>          }

Or even:

if (object_property_set_link(cpuobj, OBJECT(&s->cpu_container[i]),
                                       "memory", errp) ||
     object_property_set_link(cpuobj, OBJECT(s), "idau", errp) ||
     object_property_set_bool(cpuobj, true, "realized", errp)) {
         return;
}

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


