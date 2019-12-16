Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50FEEC43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 09:20:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A60A205ED
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 09:20:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bya9zbbN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A60A205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48940 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igmYh-0007rw-Di
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 04:20:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56664)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1igmY6-0007Lp-2b
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 04:20:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1igmY0-0006A9-3l
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 04:20:15 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:52546
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1igmY0-0006A4-0h
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 04:20:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576488011;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qwl97Alxo8sJFowOD7XKYUaloZ4HsrSdSRLgJZxOQ+o=;
 b=Bya9zbbNCLQrzBftWHxEsPwdGBWbQ+YH1jzcOTuklN4mcLXO1EQmXD8ptwfeDhsFVLITB0
 D1WdBn/hiFt5yviPATzmdSv+PtMKJ2yWQncQNXkxo92MIz6zJvxmKJPRbatBwOtRAsWcSb
 0IXBjQHrkqz9XLli8GBNO137goYix+Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-137-U0gZuiUEObW6w5VJb19WdA-1; Mon, 16 Dec 2019 04:20:09 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 57F058E1E8F;
 Mon, 16 Dec 2019 09:20:08 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-42.ams2.redhat.com
 [10.36.116.42])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0AAE263B80;
 Mon, 16 Dec 2019 09:20:05 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1842211386A7; Mon, 16 Dec 2019 10:20:04 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Corey Minyard <cminyard@mvista.com>
Subject: Re: [PATCH 11/21] hw/ipmi: Fix latent realize() error handling bugs
References: <20191130194240.10517-1-armbru@redhat.com>
 <20191130194240.10517-12-armbru@redhat.com>
 <20191201182234.GA18195@minyard.net>
Date: Mon, 16 Dec 2019 10:20:04 +0100
In-Reply-To: <20191201182234.GA18195@minyard.net> (Corey Minyard's message of
 "Sun, 1 Dec 2019 12:22:34 -0600")
Message-ID: <87mubsfwzf.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: U0gZuiUEObW6w5VJb19WdA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
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
Cc: vsementsov@virtuozzo.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Corey Minyard <cminyard@mvista.com> writes:

> On Sat, Nov 30, 2019 at 08:42:30PM +0100, Markus Armbruster wrote:
>> isa_ipmi_bt_realize(), ipmi_isa_realize(), pci_ipmi_bt_realize(), and
>> pci_ipmi_kcs_realize() crash when IPMIInterfaceClass method init()
>> fails and their @errp argument is null.  First messed up in commit
>> 0719029c47 "ipmi: Add an ISA KCS low-level interface", then imitated
>> in commit a9b74079cb "ipmi: Add a BT low-level interface" and commit
>> 12f983c6aa "ipmi: Add PCI IPMI interfaces".
>>=20
>> The bug can't bite as no caller actually passes null, and none of the
>> init() methods can actually fail.  Fix it anyway.
>
> Well, whatever.  It looks correct and is better style.  I've added this
> to my tree.

I've since posted v2 with a revamped commit message, and I'm ready to
post a pull request.  I really want the whole thing committed before the
Christmas break, so Vladimir can base on it more easily.  Options:

* You post a pull request before me.

* Ask me to drop this patch from my pull request, so you can take it
  through your tree at your leisure.

* Post your Reviewed-by or Acked-by for me to include in my pull
  request.

* Do nothing; I'll post my pull request later this week.


