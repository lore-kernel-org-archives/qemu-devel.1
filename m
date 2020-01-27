Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC8D0C2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 14:07:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B30152071E
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 14:07:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vqf/WhQm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B30152071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45810 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iw53Q-0003CL-Tm
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 09:07:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57945)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1iw517-0007Zi-LD
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 09:05:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1iw515-0003MF-M7
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 09:05:29 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:24839
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1iw515-0003KX-Ci
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 09:05:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580133925;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Lb+Hn+PfNwFSRujzYdFW0woJbX0LR+7aW8INU2wmgYo=;
 b=Vqf/WhQm57szDEVrTr0wSclXnNonBNEtx9MQWTKquq0sXvpegvub99kACWA/n4Th//r+EO
 C6H3MChKU1ElPqP6bMgLZlWpqP2Pk4JPzhRfEkNyMcmyWr2hLHEnxRMWTviKdS3w0zxGzP
 ONir4lxHk6Po97PZSzel1LfOBmk4R18=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-256-OyCdI_cmN_WlvEyA73paZQ-1; Mon, 27 Jan 2020 09:05:21 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 08FD7184BBAC;
 Mon, 27 Jan 2020 14:05:20 +0000 (UTC)
Received: from redhat.com (ovpn-116-91.ams2.redhat.com [10.36.116.91])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 10F695C1D6;
 Mon, 27 Jan 2020 14:05:18 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [RFC] migration: Remove old compression code
In-Reply-To: <87iml0x6zn.fsf@dusky.pond.sub.org> (Markus Armbruster's message
 of "Sat, 25 Jan 2020 09:42:04 +0100")
References: <20200123121628.37539-1-quintela@redhat.com>
 <87iml0x6zn.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Date: Mon, 27 Jan 2020 15:05:16 +0100
Message-ID: <87blqp2dwj.fsf@secure.laptop>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: OyCdI_cmN_WlvEyA73paZQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Reply-To: quintela@redhat.com
Cc: Eduardo Habkost <ehabkost@redhat.com>, liang.z.li@intel.com,
 xiaoguangrong@tencent.com, qemu-devel@nongnu.org,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, richardw.yang@linux.intel.com,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Markus Armbruster <armbru@redhat.com> wrote:
> Cc'ing like David did, plus Eric and Mike for additional QAPI expertise.

Thanks.

>> diff --git a/qapi/migration.json b/qapi/migration.json
>> index 65db85970e..5477d4d20b 100644
>> --- a/qapi/migration.json
>> +++ b/qapi/migration.json
>> @@ -79,27 +79,6 @@
>>             'cache-miss': 'int', 'cache-miss-rate': 'number',
>>             'overflow': 'int' } }
>> =20
>> -##
>> -# @CompressionStats:
>> -#
>> -# Detailed migration compression statistics
>> -#
>> -# @pages: amount of pages compressed and transferred to the target VM
>> -#
>> -# @busy: count of times that no free thread was available to compress d=
ata
>> -#
>> -# @busy-rate: rate of thread busy
>> -#
>> -# @compressed-size: amount of bytes after compression
>> -#
>> -# @compression-rate: rate of compressed size
>> -#
>> -# Since: 3.1
>> -##
>> -{ 'struct': 'CompressionStats',
>> -  'data': {'pages': 'int', 'busy': 'int', 'busy-rate': 'number',
>> -=09   'compressed-size': 'int', 'compression-rate': 'number' } }
>> -
>
> Only user is MigrationInfo, which is next.
>
>>  ##
>>  # @MigrationStatus:
>>  #
>> @@ -200,9 +179,6 @@
>    ##
>    # @MigrationInfo:
> [...]
>>  #           only present when the postcopy-blocktime migration capabili=
ty
>>  #           is enabled. (Since 3.0)
>>  #
>> -# @compression: migration compression statistics, only returned if comp=
ression
>> -#           feature is on and status is 'active' or 'completed' (Since =
3.1)
>> -#
>>  # @socket-address: Only used for tcp, to know what the real port is (Si=
nce 4.0)
>>  #
>>  # Since: 0.14.0
>> @@ -219,7 +195,6 @@
>>             '*error-desc': 'str',
>>             '*postcopy-blocktime' : 'uint32',
>>             '*postcopy-vcpu-blocktime': ['uint32'],
>> -           '*compression': 'CompressionStats',
>>             '*socket-address': ['SocketAddress'] } }
>
> MigrationInfo is returned by  query-migrate.  No other users.
>
> Doc comment gives us wiggle room: "only returned if compression feature
> is on".  Can it be on after this patch?
>
> If no, the member can go without breaking query-migrate compatibility.

We can't setup it anymore.
Notice that even if we don't agree in this patch, I would change this to
compile out compression method, so it is going to be the same.

>
> query-qmp-schema shows the change, though.  Could conceivably affect
> users, but it seems unlikely.
>
> Eric, Mike, we might want to grant ourselves explicit license to change
> query-qmp-schema in such ways, by having qapi-code-gen.txt state
> optional members may be removed when they can't be present anymore.
> What do you think?
>
> Alternatively, keep the member, hardcode value to whatever is returned
> before the patch when compression is off, deprecate, remove after grace
> period.  A bit more work, but safer.  Worthwhile?  Not for me to decide.
>
>> =20
>>  ##
>> @@ -364,14 +339,6 @@
>    ##
>    # @MigrationCapability:
> [...]
>>  #          to enable the capability on the source VM. The feature is di=
sabled by
>>  #          default. (since 1.6)
>>  #
>> -# @compress: Use multiple compression threads to accelerate live migrat=
ion.
>> -#          This feature can help to reduce the migration traffic, by se=
nding
>> -#          compressed pages. Please note that if compress and xbzrle ar=
e both
>> -#          on, compress only takes effect in the ram bulk stage, after =
that,
>> -#          it will be disabled and only xbzrle takes effect, this can h=
elp to
>> -#          minimize migration traffic. The feature is disabled by defau=
lt.
>> -#          (since 2.4 )
>> -#
>>  # @events: generate events for each migration state change
>>  #          (since 2.4 )
>>  #
>> @@ -425,7 +392,7 @@
>>  ##
>>  { 'enum': 'MigrationCapability',
>>    'data': ['xbzrle', 'rdma-pin-all', 'auto-converge', 'zero-blocks',
>> -           'compress', 'events', 'postcopy-ram', 'x-colo', 'release-ram=
',
>> +           'events', 'postcopy-ram', 'x-colo', 'release-ram',
>>             'block', 'return-path', 'pause-before-switchover', 'multifd'=
,
>>             'dirty-bitmaps', 'postcopy-blocktime', 'late-block-activate'=
,
>>             'x-ignore-shared', 'validate-uuid' ] }
>
> Only users are migrate-set-capabilities and query-migrate-capabilities,
> via MigrationCapabilityStatus, which are next.
>
>> @@ -479,7 +446,6 @@
>    ##
>    # @MigrationCapabilityStatus:
>    #
>    # Migration capability information
>    #
>    # @capability: capability enum
>    #
>    # @state: capability state bool
>    #
>    # Since: 1.2
>    ##
>    { 'struct': 'MigrationCapabilityStatus',
>      'data': { 'capability' : 'MigrationCapability', 'state' : 'bool' } }
>
>    ##
>    # @migrate-set-capabilities:
>    #
>    # Enable/Disable the following migration capabilities (like xbzrle)
>    #
>    # @capabilities: json array of capability modifications to make
>    #
>    # Since: 1.2
>    #
>    # Example:
>    #
>    # -> { "execute": "migrate-set-capabilities" , "arguments":
>    #      { "capabilities": [ { "capability": "xbzrle", "state": true } ]=
 } }
>    #
>    ##
>    { 'command': 'migrate-set-capabilities',
>      'data': { 'capabilities': ['MigrationCapabilityStatus'] } }
>
> With MigrationCapability @compress gone, attempting to set it with
> migrate-set-capabilities fails with GenericError, "desc": "Invalid
> parameter 'compress'".
>
> Setting capability "compress" can fail before this patch, but only when
> you do it in the middle of a migration, so this is actually a new error.
>
> Adding errors is explicitly permitted in docs/interop/qmp-spec.txt
> section "Compatibility Considerations":
>
>     However, Clients must not assume any particular:
>     [...]
>     - Amount of errors generated by a command, that is, new errors can be=
 added
>       to any existing command in newer versions of the Server
>
> We're good.
>
>    ##
>    # @query-migrate-capabilities:
>    #
>    # Returns information about the current migration capabilities status
>    #
>    # Returns: @MigrationCapabilitiesStatus
>    #
>    # Since: 1.2
>    #
>    # Example:
>    #
>    # -> { "execute": "query-migrate-capabilities" }
>    # <- { "return": [
>    #       {"state": false, "capability": "xbzrle"},
>>  #       {"state": false, "capability": "rdma-pin-all"},
>>  #       {"state": false, "capability": "auto-converge"},
>>  #       {"state": false, "capability": "zero-blocks"},
>> -#       {"state": false, "capability": "compress"},
>>  #       {"state": true, "capability": "events"},
>>  #       {"state": false, "capability": "postcopy-ram"},
>>  #       {"state": false, "capability": "x-colo"}
>    #    ]}
>    #
>    ##
>    { 'command': 'query-migrate-capabilities', 'returns':   ['MigrationCap=
abilityStatus']}
>
> What capabilties are returned when is not specified.
>
> Aside: it should be, shouldn't it?
>
> qmp_query_migrate_capabilities() returns them all, except it skips
> "block" when !defined CONFIG_LIVE_BLOCK_MIGRATION.  De facto ABI due to
> the gap in the documented ABI.
>
> Removing capability "compress" is a break of this de facto ABI.
> Acceptable when we're confident the ABI's users don't care.
>
> Alternatively, keep them, hardcode value to false, deprecate, remove
> after grace period.
>
> Aside: you might want to make MigrationCapability @block conditional like

Yeap, that is what I was searching for.  How to move from here O;-)

[...]
>
> MigrateSetParameters is returned by query-migrate-parameters.  No other
> users.
>
> Even thought the members are optional, the doc comment specifies all are
> returned.  qmp_query_migrate_parameters() does.
>
> Removing the parameters breaks this promise.  Acceptable when we're
> confident the ABI's users don't care.
>
> Alternatively, keep them, hardcode value to whatever is returned before
> the patch when compression is off, deprecate, remove after grace period.
>
> Questions?

Ok with me.

Let's other people get in.

Thanks a lot, Juan.


