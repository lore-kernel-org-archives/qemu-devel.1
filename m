Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09709C4727C
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 14:34:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A9D12076B
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 14:34:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eauV+/66"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A9D12076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53686 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNdBn-0006wU-Gb
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 10:34:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53244)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kNdAh-0005Vz-2S
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 10:33:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26260)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kNdAd-0002KV-2J
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 10:33:29 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601476406;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RH+sSU4coBzNqjthpGR1fO6p1Yi9uvK4tmO3Dbm/fjw=;
 b=eauV+/66cTFqN6OQKNON7chgd5272aCZtuQy9TAj22Fit4xdU4N75Ay8+bImO/7M4T3+/8
 6GAGmfISgw7OR2MfXK0jDJFp3TMp04fOHC9yQBRufC6+GvwUOQk1ZDs28mawmNQhGCF4M0
 RzQ1XpDAJtuf/d8eTN0PPjZlpdjfB0g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-196--cWae-I-Nhu8udRyKdKYlQ-1; Wed, 30 Sep 2020 10:33:24 -0400
X-MC-Unique: -cWae-I-Nhu8udRyKdKYlQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8FC91802B47;
 Wed, 30 Sep 2020 14:33:23 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-101.ams2.redhat.com
 [10.36.112.101])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4772D1002C03;
 Wed, 30 Sep 2020 14:33:20 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C856B113864A; Wed, 30 Sep 2020 16:33:18 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v2 11/13] block/export: convert vhost-user-blk server to
 block export API
References: <20200924151549.913737-1-stefanha@redhat.com>
 <20200924151549.913737-12-stefanha@redhat.com>
 <87imbvj0it.fsf@dusky.pond.sub.org>
 <20200930094508.GE201070@stefanha-x1.localdomain>
Date: Wed, 30 Sep 2020 16:33:18 +0200
In-Reply-To: <20200930094508.GE201070@stefanha-x1.localdomain> (Stefan
 Hajnoczi's message of "Wed, 30 Sep 2020 10:45:08 +0100")
Message-ID: <87eemj72s1.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=63.128.21.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 00:31:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.469,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Coiby Xu <coiby.xu@gmail.com>, Max Reitz <mreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Stefan Hajnoczi <stefanha@redhat.com> writes:

> On Wed, Sep 30, 2020 at 07:28:58AM +0200, Markus Armbruster wrote:
>> Stefan Hajnoczi <stefanha@redhat.com> writes:
>> 
>> > Use the new QAPI block exports API instead of defining our own QOM
>> > objects.
>> >
>> > This is a large change because the lifecycle of VuBlockDev needs to
>> > follow BlockExportDriver. QOM properties are replaced by QAPI options
>> > objects.
>> >
>> > VuBlockDev is renamed VuBlkExport and contains a BlockExport field.
>> > Several fields can be dropped since BlockExport already has equivalents.
>> >
>> > The file names and meson build integration will be adjusted in a future
>> > patch. libvhost-user should probably be built as a static library that
>> > is linked into QEMU instead of as a .c file that results in duplicate
>> > compilation.
>> >
>> > The new command-line syntax is:
>> >
>> >   $ qemu-storage-daemon \
>> >       --blockdev file,node-name=drive0,filename=test.img \
>> >       --export vhost-user-blk,node-name=drive0,id=export0,unix-socket=/tmp/vhost-user-blk.sock
>> >
>> > Note that unix-socket is optional because we may wish to accept chardevs
>> > too in the future.
>> >
>> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>> > ---
>> > v2:
>> >  * Replace str unix-socket with SocketAddress addr to match NBD and
>> >    support file descriptor passing
>> >  * Make addr mandatory [Markus]
>> >  * Update vhost-user-blk-test.c to use --export syntax
>> > ---
>> >  qapi/block-export.json               |  21 +-
>> >  block/export/vhost-user-blk-server.h |  23 +-
>> >  block/export/export.c                |   8 +-
>> >  block/export/vhost-user-blk-server.c | 452 +++++++--------------------
>> >  tests/qtest/vhost-user-blk-test.c    |   2 +-
>> >  util/vhost-user-server.c             |  10 +-
>> >  block/export/meson.build             |   1 +
>> >  block/meson.build                    |   1 -
>> >  8 files changed, 158 insertions(+), 360 deletions(-)
>> >
>> > diff --git a/qapi/block-export.json b/qapi/block-export.json
>> > index ace0d66e17..2e44625bb1 100644
>> > --- a/qapi/block-export.json
>> > +++ b/qapi/block-export.json
>> > @@ -84,6 +84,21 @@
>> >    'data': { '*name': 'str', '*description': 'str',
>> >              '*bitmap': 'str' } }
>> >  
>> > +##
>> > +# @BlockExportOptionsVhostUserBlk:
>> > +#
>> > +# A vhost-user-blk block export.
>> > +#
>> > +# @addr: The vhost-user socket on which to listen. Both 'unix' and 'fd'
>> > +#        SocketAddress types are supported. Passed fds must be UNIX domain
>> > +#        sockets.
>> 
>> "addr.type must be 'unix' or 'fd'" is not visible in introspection.
>> Awkward.  Practical problem only if other addresses ever become
>> available here.  Is that possible?
>
> addr.type=fd itself has the same problem, because it is a file
> descriptor without type information. Therefore the QMP client cannot
> introspect which types of file descriptors can be passed.

Yes, but if introspection could tell us which which values of addr.type
are valid, then a client should figure out the address families, as
follows.  Any valid value other than 'fd' corresponds to an address
family.  The set of values valid for addr.type therefore corresponds to
a set of address families.  The address families in that set are all
valid with 'fd', aren't they?

> Two ideas:
>
> 1. Introduce per-address family fd types (SocketAddrFdTcpInet,
>    SocketAddrFdTcpInet6, SocketAddrFdUnix, etc) to express specific
>    address families in the QAPI schema.
>
>    Then use per-command unions to express the address families supported
>    by specific commands. For example,
>    BlockExportOptionsVhostUserBlkSocketAddr would only allow
>    SocketAddrUnix and SocketAddrFdUnix. That way new address families
>    can be supported in the future and introspection reports.

Awkward.  These types would have to differ structurally, or else they
are indistinguishable in introspection.

> 2. Use a side-channel (query-features, I think we discussed something
>    like this a while back) to report features that cannot be
>    introspected.

We implemented this in the form of QAPI feature flags, visible in
introspection.  You could do something like

  'addr': { 'type': 'SocketAddress',
            'features': [ 'unix' ] }

> I think the added complexity for achieving full introspection is not
> worth it. It becomes harder to define new QAPI commands, increases the
> chance of errors, and is more tedious to program for clients/servers.

Hence my question: is it possible that address families other than unix
become available here?

When that happens, we have an introspection problem of the sort we
common solve with a feature flag.

> Accepting any SocketAddr seems reasonable to me since vhost-user
> requires an address family that has file descriptor passing. Very few
> address families support this feature and we don't expect to add new
> ones often.

Your answer appears to be "yes in theory, quite unlikely in practice".
Correct?


