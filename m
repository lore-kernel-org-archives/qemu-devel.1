Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F19A2C2D0CE
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 13:54:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9EA921569
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 13:54:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="deQzd0AB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9EA921569
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54378 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ittzb-0003ma-7A
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 08:54:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33882)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1ittkT-0002Hd-9k
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 08:39:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1ittkR-0002SG-N2
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 08:39:17 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:53717
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ittkJ-0002NZ-VD
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 08:39:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579613947;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UNaqdG/kf6Aak5iOvVnZKMEuLm98y8RF9EOYvq0J7S8=;
 b=deQzd0AB7BvlABP/IjcZDIDeh1ZRhS1f2h4zAQszEPm1XemrlQ/7+IKExOP5/OdgKfOZjw
 cWE2kbmGQkuxlDn8kb8FGZ5srzpgyrKnsMNanpDrHJNK5colLpZ1Uo3bBqKeOuFE4Rp4Ki
 vRVvedyqaNZMxckUHkFWVqtizcLur04=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-79-uPOuSdQYOmil2C_jhNcbZQ-1; Tue, 21 Jan 2020 08:39:04 -0500
X-MC-Unique: uPOuSdQYOmil2C_jhNcbZQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CA6D0800D48;
 Tue, 21 Jan 2020 13:39:02 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-131.ams2.redhat.com
 [10.36.116.131])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 14E641001DE1;
 Tue, 21 Jan 2020 13:39:00 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id ABC0E1138600; Tue, 21 Jan 2020 14:38:58 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 1/2] pvpanic: introduce crashloaded for pvpanic
References: <20200110100634.491936-1-pizhenwei@bytedance.com>
 <20200110100634.491936-2-pizhenwei@bytedance.com>
 <87h80pi5hf.fsf@dusky.pond.sub.org>
 <247586dd-576a-a0c9-9c43-5d9a310a4ddc@redhat.com>
Date: Tue, 21 Jan 2020 14:38:58 +0100
In-Reply-To: <247586dd-576a-a0c9-9c43-5d9a310a4ddc@redhat.com> (Paolo
 Bonzini's message of "Tue, 21 Jan 2020 11:50:53 +0100")
Message-ID: <87sgk9c4jx.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: yelu@bytedance.com, libvir-list@redhat.com, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, zhenwei pi <pizhenwei@bytedance.com>,
 qemu-devel@nongnu.org, mprivozn@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 21/01/20 09:22, Markus Armbruster wrote:
>> zhenwei pi <pizhenwei@bytedance.com> writes:
>> 
>>> Add bit 1 for pvpanic. This bit means that guest hits a panic, but
>>> guest wants to handle error by itself. Typical case: Linux guest runs
>>> kdump in panic. It will help us to separate the abnormal reboot from
>>> normal operation.
>>>
>>> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
>>> ---
>>>  docs/specs/pvpanic.txt | 8 ++++++--
>>>  1 file changed, 6 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/docs/specs/pvpanic.txt b/docs/specs/pvpanic.txt
>>> index c7bbacc778..bdea68a430 100644
>>> --- a/docs/specs/pvpanic.txt
>>> +++ b/docs/specs/pvpanic.txt
>>> @@ -16,8 +16,12 @@ pvpanic exposes a single I/O port, by default 0x505. On read, the bits
>>>  recognized by the device are set. Software should ignore bits it doesn't
>>>  recognize. On write, the bits not recognized by the device are ignored.
>>>  Software should set only bits both itself and the device recognize.
>> 
>> Guest software, I presume.
>> 
>>> -Currently, only bit 0 is recognized, setting it indicates a guest panic
>>> -has happened.
>>> +
>>> +Bit Definition
>>> +--------------
>>> +bit 0: setting it indicates a guest panic has happened.
>>> +bit 1: named crashloaded. setting it indicates a guest panic and run
>>> +       kexec to handle error by guest itself.
>> 
>> Suggest to scratch "named crashloaded."
>
> bit 1: a guest panic has happened and will be handled by the guest;
>        the host should record it or report it, but should not affect
>        the execution of the guest.
>
> ?
>
> Paolo

Works for me, thanks!


