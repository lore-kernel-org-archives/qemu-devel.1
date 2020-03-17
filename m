Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3D7EC2BB1D
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 20:37:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEA9B20714
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 20:37:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CKK9FdtE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEA9B20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41076 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEIyD-0007sl-QR
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 16:37:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54029)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jEIxO-00070E-BZ
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 16:36:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jEIxM-0005Hu-M7
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 16:36:57 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:49097)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jEIxM-0005DS-H0
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 16:36:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584477416;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jHZl9QrxyF0cBJjriHUNqKkZr2K1a1FK5PtvK/DZiDk=;
 b=CKK9FdtEi/ROEGRN1dIIq+0OPnfGaFP95Mw0ePaA1d16AdOFmok1W9uIpntRBDDxXOSSqW
 sNvCehDPpdUvRe7CgwO8kFd2K+7JSZUpx4Y7PPuqIZh8BHcZE4oqQRYHb3n1HEOhB5QEw9
 FSuEW5+FetBTx55vke/hvBatuEery6Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-333-ugrd8N1QPxa0znhkFm0rYw-1; Tue, 17 Mar 2020 16:36:54 -0400
X-MC-Unique: ugrd8N1QPxa0znhkFm0rYw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5140B477;
 Tue, 17 Mar 2020 20:36:53 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-130.ams2.redhat.com
 [10.36.112.130])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1CC0260BEE;
 Tue, 17 Mar 2020 20:36:53 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C00131138404; Tue, 17 Mar 2020 21:36:51 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v2 1/2] net: Complete qapi-fication of netdev_add
References: <20200317201711.322764-1-eblake@redhat.com>
 <20200317201711.322764-2-eblake@redhat.com>
Date: Tue, 17 Mar 2020 21:36:51 +0100
In-Reply-To: <20200317201711.322764-2-eblake@redhat.com> (Eric Blake's message
 of "Tue, 17 Mar 2020 15:17:10 -0500")
Message-ID: <87d09ak9b0.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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
> into the proper "ipv6-prefix" and "ipv6-prefixlen".  Undocumented
> misfeature, introduced in commit 7aac531ef2 "qapi-schema, qemu-options
> & slirp: Adding Qemu options for IPv6 addresses", v2.6.0.
>
> -  {'execute':'netdev_add',
>      'arguments':{'id':'net2', 'type':'hubport', 'hubid':"2"}}
>    {"error": {"class": "GenericError", "desc": "Invalid parameter type fo=
r 'hubid', expected: integer"}}
> Used to succeed: since our command line treats everything as strings,
> our not-so-round-trip conversion from QAPI -> QemuOpts -> QAPI lost
> the original typing and turned everything into a string; now that we
> skip the QemuOpts, the JSON input has to match the exact QAPI type.
> But this stricter QMP is desirable, and introspection is sufficient
> for any affected applications to make sure they use it correctly.
>
> In qmp_netdev_add(), we still have to create a QemuOpts object so that
> qmp_netdev_del() will be able to remove a hotplugged network device;
> but the opts->head remains empty since we now manage all parsing
> through the QAPI object rather than QemuOpts; a separate patch will
> address the abuse of QemuOpts as a witness for whether a
> NetClientState is a netdev.  In the meantime, our argument that we are
> okay requires auditing all uses of option group "netdev":
>
> - qemu_netdev_opts: option group definition, empty .desc[]
> - CLI (CLI netdev parsing ends before monitors start, so while
>   monitors can mess with CLI netdevs, CLI cannot mess with
>   monitor netdevs):
>   - main() case QEMU_OPTION_netdev: store CLI definition
>   - main() case QEMU_OPTION_readconfig, case QEMU_OPTION_writeconfig:
>   similar, dealing only with CLI
>   - net_init_clients(): Pass CLI to net_client_init()
> - Monitor:
>   - hmp_netdev_add(): straightforward parse into net_client_init()
>   - qmp_netdev_add(): subject of this patch, used to add full
>   object to option group, now just adds bare-bones id
>   - qmp_netdev_del(), netdev_del_completion(): check the option group
>   solely for id, as a 'is this a netdev' predicate
>
> Reported-by: Alex Kirillov <lekiravi@yandex-team.ru>
> Signed-off-by: Eric Blake <eblake@redhat.com>

Thanks for the nice commit message.

Reviewed-by: Markus Armbruster <armbru@redhat.com>


