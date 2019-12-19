Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4606C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 08:56:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E2502465E
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 08:56:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KWcZxLvf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E2502465E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihrbk-0005At-Lo
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 03:56:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37878)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pkrempa@redhat.com>) id 1ihrZj-0003Aw-08
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 03:54:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pkrempa@redhat.com>) id 1ihrZh-0003If-FX
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 03:54:26 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:49385
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pkrempa@redhat.com>) id 1ihrZh-0003Du-9l
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 03:54:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576745664;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hfc+w8TtODHWpvcfoHMiFH4S0UNQbWWh5W25WzleJLk=;
 b=KWcZxLvfQTSfJ31bQDTTzqXsfRBy1hLGXoBiz9MF/qBWJ2FRJukUZN1C/bmx6olMh1/ntD
 caqM5aCwNfg0tDwlKg35B4ZMnGDbU4Tja8B8V8o83x39+VIRxyriRopU/4tfMnlmdM6yfC
 a1/Z9o1uXsUEmrIf5wKDedZzQbqmN5Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-334-16LyNk0tMDufNG_-wIWKrg-1; Thu, 19 Dec 2019 03:54:21 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4F9A68024DB;
 Thu, 19 Dec 2019 08:54:20 +0000 (UTC)
Received: from andariel.pipo.sk (ovpn-205-6.brq.redhat.com [10.40.205.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8482F5C28F;
 Thu, 19 Dec 2019 08:54:18 +0000 (UTC)
Date: Thu, 19 Dec 2019 09:54:15 +0100
From: Peter Krempa <pkrempa@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH RFC] qapi: Allow getting flat output from
 'query-named-block-nodes'
Message-ID: <20191219085415.GI4914@andariel.pipo.sk>
References: <42dae98e1f6a9f444f48a20192f45195337824f0.1576246045.git.pkrempa@redhat.com>
 <836c1a18-b67d-0426-2137-8f464e4e5c9b@redhat.com>
 <87lfrbjtdu.fsf@dusky.pond.sub.org>
 <fa269c43-f966-54a7-6589-46f28138ea15@redhat.com>
 <87k16vaswm.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
In-Reply-To: <87k16vaswm.fsf@dusky.pond.sub.org>
X-PGP-Key-ID: 0xD018682B
X-PGP-Key-Fingerprint: D294 FF38 A6A2 BF40 6C75  5DEF 36EC 16AC D018 682B
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: 16LyNk0tMDufNG_-wIWKrg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Dec 17, 2019 at 16:11:37 +0100, Markus Armbruster wrote:
> Eric Blake <eblake@redhat.com> writes:
>=20
> > On 12/17/19 1:36 AM, Markus Armbruster wrote:
> >
> >> Un-snipping the QAPI schema change:
> >
> > Sorry about that...
> >
> >>
> >>>> diff --git a/qapi/block-core.json b/qapi/block-core.json
> >>>> index 0cf68fea14..bd651106bd 100644
> >>>> --- a/qapi/block-core.json
> >>>> +++ b/qapi/block-core.json
> >>>> @@ -1752,6 +1752,8 @@
> >>>>   #
> >>>>   # Get the named block driver list
> >>>>   #
> >>>> +# @flat: don't recurse into backing images if true. Default is fals=
e (Since 5.0)
> >>>> +#
> >>>>   # Returns: the list of BlockDeviceInfo
> >>>>   #
> >>>>   # Since: 2.0
> >>
> >> What does it mean not to recurse?  Sounds like flat: false asks for a
> >> subset of the full set.  How exactly is the subset defined?
> >
> > Bike-shedding:
> >
> > Would it be easier to explain as:
> >
> > @recurse: If true, include child information in each node (note that
> > this can result in redundant output). Default is true (since 5.0)
> >
> > and then pass false when you don't want recursion, with it being more
> > obvious that using the new flag results in more compact output with no
> > loss of information.
>=20
> Adds a bit of information, namely that the information suppressed by
> recurse: false is actually redundant.
>=20
> The command's doc comment is weak: it doesn't really specify what
> exactly is returned.  Simply omitting redundant information always
> should still conform to this weak spec.  Of course, what really counts
> isn't spec conformance, but meeting client expectations.  I don't even
> understand what exactly gets returned, let alone how clients use it.

Well I by default expect that if the top level array has data for all
node names the nesting which repeats the information (partially) should
not be there because you can just look elsewhere for a more detailed
output.

Said that two years ago I wrote some code which detects the node names
from running qemu because at that time it was the only way to use the
block write threshold event. This code needs to extract the nesting
topology somehow but I don't remember nor fancy re-understanding the
algorithm for the detection during the hollidays. The only thing I can
say that the nesting is extracted either from the output of query-block
or from query-named-block nodes as both these outputs are fed to that
algorithm.

With blockdev that piece of code thankfully is unused, but unfortunately
I can't say that the nested output of query-named-block-nodes doesn't
have it's use.


