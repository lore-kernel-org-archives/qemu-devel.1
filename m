Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DB51C5ACD9
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 20:50:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C30B20714
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 20:50:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i7Jat+XC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C30B20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEJAu-0007DL-BH
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 16:50:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41938)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jEJAA-0006Tp-AY
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 16:50:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jEJA8-0000ex-Sy
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 16:50:09 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:30531)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jEJA8-0000W9-NF
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 16:50:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584478208;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Dy0ZYq+/y0iBG8cvZCDv7/5u3hyjA6OCSoNzTgMVKLI=;
 b=i7Jat+XChrbb2HyIS4kebYYv4oub5XZ8r0kydF5l8I3m1TTEmFmJXJdj+nh/Jmd+rePe5B
 CAmKW9XLB/z2O5gHSxsSqo6QaWzAnA5BgOjUfXjQVENA56xQZada9ELGQgP/xoIceb0QOm
 pUCYCpR+nIONXAZF8QAD27btG2BoI4Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-343-mfXLFBXBMESAKcXIu4Sq9Q-1; Tue, 17 Mar 2020 16:50:06 -0400
X-MC-Unique: mfXLFBXBMESAKcXIu4Sq9Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 257C81005514;
 Tue, 17 Mar 2020 20:50:05 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-130.ams2.redhat.com
 [10.36.112.130])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7CF2594949;
 Tue, 17 Mar 2020 20:50:04 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E29001138404; Tue, 17 Mar 2020 21:50:02 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v2 1/2] net: Complete qapi-fication of netdev_add
References: <20200317201711.322764-1-eblake@redhat.com>
 <20200317201711.322764-2-eblake@redhat.com>
Date: Tue, 17 Mar 2020 21:50:02 +0100
In-Reply-To: <20200317201711.322764-2-eblake@redhat.com> (Eric Blake's message
 of "Tue, 17 Mar 2020 15:17:10 -0500")
Message-ID: <87pndaiu4l.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: lekiravi@yandex-team.ru, jasowang@redhat.com, qemu-devel@nongnu.org,
 dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Eric Blake <eblake@redhat.com> writes:

> We've had all the required pieces for doing a type-safe representation
> of netdev_add as a flat union for quite some time now (since
> 0e55c381f6 in v2.7.0, released in 2016), but did not make the final
> switch to using it because of concern about whether a command-line
> regression in accepting "1" in place of 1 for integer arguments would
> be problematic.  Back then, we did not have the deprecation cycle to
> allow us to make progress.  But now that we have waited so long, other
> problems have crept in: for example, our desire to add
> qemu-storage-daemon is hampered by the inability to express net
> objects, and we are unable to introspect what we actually accept.
> Additionally, our round-trip through QemuOpts silently eats any
> argument that expands to an array, rendering dnssearch, hostfwd, and
> guestfwd useless through QMP:
>
> {"execute": "netdev_add", "arguments": { "id": "netdev0",
>   "type": "user", "dnssearch": [
>     { "str": "8.8.8.8" }, { "str": "8.8.4.4" }
>   ]}}
>
> So without further ado, let's turn on proper QAPI.  netdev_add() was a
> trivial wrapper around net_client_init(), which did a few steps prior
> to calling net_client_init1(); with this patch, we now skip directly
> to net_client_init1().  In addition to fixing array parameters, the
> following additional differences occur:
>
> -  {"execute": "netdev_add", "arguments": {"type": "help"}}
> no longer attempts to print help to stdout and exit.  Bug fix, broken
> in 547203ead4 'net: List available netdevs with "-netdev help"',
> v2.12.0.
>
> -  {"execute": "netdev_add", "arguments': {... "ip6-net": "..." }}
> no longer attempts to desugar the undocumented ip6-net magic string

s/ip6-net/ipv6-net/ two times.  Will fix in my tree.

> into the proper "ipv6-prefix" and "ipv6-prefixlen".  Undocumented
> misfeature, introduced in commit 7aac531ef2 "qapi-schema, qemu-options
> & slirp: Adding Qemu options for IPv6 addresses", v2.6.0.
[...]


