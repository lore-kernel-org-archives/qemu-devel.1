Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10A01C43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 21:19:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D10E32053B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 21:19:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nc4GkIAn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D10E32053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33600 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiPgL-00084c-PL
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 16:19:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36584)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iiPfU-00070l-E6
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 16:18:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iiPfT-0000Gk-Bo
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 16:18:40 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34623
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1iiPfT-0000Ch-6u
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 16:18:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576876718;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l4azdl7XUxdhDKK745rFe5LKT/LLcVGMlTEqAMl93CQ=;
 b=Nc4GkIAnfdG9ttm9Eq+XmWgt+SCATaeC4ENqxC/i5Z7t1w8XPzcTkMYE0aVMn9I/C35OQr
 qL5RXsclueetQWMVq2LHAr9ZDSdAG/KyRe2jUQVfQln2Be+S0lCuZwb8jaCHR0s5iOj3Xd
 7GLrzgmoj5auxxcjE7jeI0FmHIkXwuo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-52-GesS9bwtORyqx_ZfXwISsQ-1; Fri, 20 Dec 2019 16:18:35 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 30DED1883520;
 Fri, 20 Dec 2019 21:18:34 +0000 (UTC)
Received: from [10.3.116.246] (ovpn-116-246.phx2.redhat.com [10.3.116.246])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BC7DC19C68;
 Fri, 20 Dec 2019 21:18:33 +0000 (UTC)
Subject: Re: [PATCH 02/18] fuse: Allow exporting BDSs via FUSE
To: Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>
References: <20191219143818.1646168-1-mreitz@redhat.com>
 <20191219143818.1646168-3-mreitz@redhat.com>
 <20191220102656.GD4019@dhcp-200-226.str.redhat.com>
 <1812e968-1197-523e-7039-caf29e3bbc4b@redhat.com>
 <20191220112402.GE4019@dhcp-200-226.str.redhat.com>
 <87pngjgo2h.fsf@dusky.pond.sub.org>
 <20191220125839.GG4019@dhcp-200-226.str.redhat.com>
 <877e2rf7sh.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <931c2067-fe6d-d65d-cc60-d0b20385e84b@redhat.com>
Date: Fri, 20 Dec 2019 15:18:33 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <877e2rf7sh.fsf@dusky.pond.sub.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: GesS9bwtORyqx_ZfXwISsQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/20/19 7:25 AM, Markus Armbruster wrote:

>>
>> I suppose moving a field between a union base and all variants does
>> still result in different introspection even though the accepted inputs
>> are the same.
> 
> Correct.  A common member (whether it's local or from the base) is in
> SchemaInfoObject.members[].  Moving it to all the variants moves it to
> the variant types' .members[].
> 
>>                Is this kind of movement still allowed unconditionally or
>> should we be more careful with something like this?
> 
> QMP's backward compatibility promise does not include "introspection
> value won't change".  Still, such changes can conceivably confuse
> clients.  Care is advisable.  But it's not a hard "no".

And libvirt already correctly handles movements like this (so there are 
existing clients aware of the potential confusion).

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


