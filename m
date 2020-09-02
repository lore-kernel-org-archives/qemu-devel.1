Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5627C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 07:57:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9869C207EA
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 07:57:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SBEj85w6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9869C207EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51198 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDNdn-0007e6-Qd
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 03:57:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37756)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kDNc8-0005Yw-Hh
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 03:55:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23554
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kDNc6-0008Sa-NG
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 03:55:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599033325;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DxQgPFcTL4vKIMbI98p9f7zZejRHCoAe15da5QXgub4=;
 b=SBEj85w6fUhU6Mjn7CvRWiItEdvwbeBYE6fLpC5lg4stig9e4iCiVSRmWwxdmmmiY0K4X/
 LTxGv7u91KuY55zv4ExedKtQIbrdm92P/RI5BAGuWczhLvNnXdUtALJLgVddwDydap4DnC
 WRkNnRDlLtFAI26M/I2A7SFNq7GXbj8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-264-6io4XFokOzKniVzmDsIVNg-1; Wed, 02 Sep 2020 03:55:23 -0400
X-MC-Unique: 6io4XFokOzKniVzmDsIVNg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9B4952FD00;
 Wed,  2 Sep 2020 07:55:22 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-68.ams2.redhat.com
 [10.36.113.68])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E6CA819C71;
 Wed,  2 Sep 2020 07:55:18 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6BAB0113C418; Wed,  2 Sep 2020 09:55:17 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH v8 1/8] Introduce yank feature
References: <cover.1598951375.git.lukasstraub2@web.de>
 <ab5c04766f270d53e90f17f76c0af7e5b66f8623.1598951375.git.lukasstraub2@web.de>
 <874kohsgsp.fsf@dusky.pond.sub.org>
 <20200901152259.GO345480@redhat.com>
Date: Wed, 02 Sep 2020 09:55:17 +0200
In-Reply-To: <20200901152259.GO345480@redhat.com> ("Daniel P. =?utf-8?Q?Be?=
 =?utf-8?Q?rrang=C3=A9=22's?=
 message of "Tue, 1 Sep 2020 16:22:59 +0100")
Message-ID: <87a6y8oboa.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 02:26:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Kevin Wolf <kwolf@redhat.com>, Lukas Straub <lukasstraub2@web.de>,
 qemu-block <qemu-block@nongnu.org>, Juan Quintela <quintela@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Tue, Sep 01, 2020 at 04:38:46PM +0200, Markus Armbruster wrote:
>> One more question...
>>=20
>> Lukas Straub <lukasstraub2@web.de> writes:
>>=20
>> > The yank feature allows to recover from hanging qemu by "yanking"
>> > at various parts. Other qemu systems can register themselves and
>> > multiple yank functions. Then all yank functions for selected
>> > instances can be called by the 'yank' out-of-band qmp command.
>> > Available instances can be queried by a 'query-yank' oob command.
>> >
>> > Signed-off-by: Lukas Straub <lukasstraub2@web.de>
>> > Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
>> [...]
>> > diff --git a/qapi/misc.json b/qapi/misc.json
>> > index 9d32820dc1..7de330416a 100644
>> > --- a/qapi/misc.json
>> > +++ b/qapi/misc.json
>> > @@ -1615,3 +1615,65 @@
>> >  ##
>> >  { 'command': 'query-vm-generation-id', 'returns': 'GuidInfo' }
>> >
>> > +##
>> > +# @YankInstances:
>> > +#
>> > +# @instances: List of yank instances.
>> > +#
>> > +# A yank instance can be yanked with the "yank" qmp command to recove=
r from a
>> > +# hanging qemu.
>> > +#
>> > +# Yank instances are named after the following schema:
>> > +# "blockdev:<node-name>" refers to a block device. Currently only nbd=
 block
>> > +# devices are implemented.
>> > +# "chardev:<chardev-name>" refers to a chardev. Currently only socket=
 chardevs
>> > +# are implemented.
>> > +# "migration" refers to the migration currently in progress.
>> > +#
>> > +# Currently implemented yank instances:
>> > +#  -nbd block device:
>> > +#   Yanking it will shutdown the connection to the nbd server without
>> > +#   attempting to reconnect.
>> > +#  -socket chardev:
>> > +#   Yanking it will shutdown the connected socket.
>> > +#  -migration:
>> > +#   Yanking it will shutdown all migration connections.
>>=20
>> How is yanking migration related to command migrate_cancel?
>
> migrate_cancel will do a shutdown() on the primary migration socket only.
> In addition it will toggle the migration state.
>
> Yanking will do a shutdown on all migration sockets (important for
> multifd), but won't touch migration state or any other aspect of QEMU
> code.
>
> Overall yanking has less potential for things to go wrong than the
> migrate_cancel method, as it doesn't try to do any kind of cleanup
> or migration.

Thanks.  Would it make sense to work this into the documentation?


