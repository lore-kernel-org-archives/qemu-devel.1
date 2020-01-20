Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3306EC32771
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 19:13:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3BF422525
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 19:13:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cIkA8px4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3BF422525
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43218 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itcUQ-0000Yc-4J
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 14:13:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34745)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1itcTU-0008Mr-NX
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 14:12:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1itcTT-00034M-IR
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 14:12:36 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20144
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1itcTT-000343-EE
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 14:12:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579547554;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ls9daiy/8ydkF9/5+TzGDaIcFwkF4HhDVoZ2BRh4OSI=;
 b=cIkA8px4JbMpuxCa8SSvx7xWJIk/Y2y8fwDsfDEqCTLHZVatdPm7XQabky7tvH05J9U3kb
 7b/LN9npE5b05Xaj/Fa50nGqC7oBmpmqFeliCZZ0FqmCstyskpFU1P3DBQeD2yTBBVqn9V
 H5pOUb84Eu97mSJ7y8hxqsnsUvN2evg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-307-jMdFXIhjOcqQQHl922PICw-1; Mon, 20 Jan 2020 14:12:33 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 71D43804707;
 Mon, 20 Jan 2020 19:12:32 +0000 (UTC)
Received: from [10.3.117.16] (ovpn-117-16.phx2.redhat.com [10.3.117.16])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C3E7D86CC2;
 Mon, 20 Jan 2020 19:12:31 +0000 (UTC)
Subject: Re: [PATCH 2/2] pvpanic: implement crashloaded event handling
To: zhenwei pi <pizhenwei@bytedance.com>, pbonzini@redhat.com
References: <20200114023102.612548-1-pizhenwei@bytedance.com>
 <20200114023102.612548-3-pizhenwei@bytedance.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <a26476fd-cbc7-7019-3762-67caa1c65b5a@redhat.com>
Date: Mon, 20 Jan 2020 13:12:31 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200114023102.612548-3-pizhenwei@bytedance.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: jMdFXIhjOcqQQHl922PICw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252; format=flowed
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
Cc: mprivozn@redhat.com, gregkh@linuxfoundation.org, qemu-devel@nongnu.org,
 yelu@bytedance.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/13/20 8:31 PM, zhenwei pi wrote:
> Handle bit 1 write, then post event to monitor.
> 
> Suggested by Paolo, declear a new event, using GUEST_PANICKED could
> cause upper layers to react by shutting down or rebooting the guest.
> 
> In advance for extention, add GuestPanicInformation in event message.
> 
> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
> ---

> +++ b/qapi/run-state.json
> @@ -357,6 +357,26 @@
>     'data': { 'action': 'GuestPanicAction', '*info': 'GuestPanicInformation' } }
>   
>   ##
> +# @GUEST_CRASHLOADED:
> +#
> +# Emitted when guest OS crash loaded is detected
> +#
> +# @action: action that has been taken, currently always "run"
> +#
> +# @info: information about a panic (since 2.9)
> +#
> +# Since: 5.0

Paolo already caught that the 'since 2.9' makes no sense if the 
interface itself is since 5.0.

> +#
> +# Example:
> +#
> +# <- { "event": "GUEST_CRASHLOADED",
> +#      "data": { "action": "run" } }
> +#
> +##
> +{ 'event': 'GUEST_CRASHLOADED',
> +  'data': { 'action': 'GuestPanicAction', '*info': 'GuestPanicInformation' } }
> +
> +##
>   # @GuestPanicAction:
>   #
>   # An enumeration of the actions taken when guest OS panic is detected
> @@ -366,7 +386,7 @@
>   # Since: 2.1 (poweroff since 2.8)
>   ##
>   { 'enum': 'GuestPanicAction',
> -  'data': [ 'pause', 'poweroff' ] }
> +  'data': [ 'pause', 'poweroff', 'run' ] }

But the comment here could be updated to mention 'run' since 5.0, 
alongside poweroff since 2.8.  Not the end of the world if we don't 
annotate it, though, since instrospection still shows the difference.


-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


