Return-Path: <SRS0=4gpF=3O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99A2EC35241
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2020 08:43:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CB622071E
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2020 08:43:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GW7uuOjh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CB622071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ivH22-0000Be-D2
	for qemu-devel@archiver.kernel.org; Sat, 25 Jan 2020 03:43:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43354)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1ivH1J-0007kj-71
 for qemu-devel@nongnu.org; Sat, 25 Jan 2020 03:42:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1ivH1E-00059C-3T
 for qemu-devel@nongnu.org; Sat, 25 Jan 2020 03:42:18 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33642
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ivH1D-00056q-Sk
 for qemu-devel@nongnu.org; Sat, 25 Jan 2020 03:42:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579941733;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MBXaUR/5j8rdNSyQRyTIEXHBnvpRXWI3J2MkTwJURnU=;
 b=GW7uuOjhHPKrd+d9dj9hUuxuEt70g4nTFfgxCjdagz7VAe9tlHOCkfKvcpnpW81z8lztbR
 S5Pt5TB55j+zTAyymDTCMJH0W765IPaIznSakKUHp/iscw3py0mc3AWD9Z6VyaCnbG91lT
 RL1r/JjECD1di70M9RP9XubwcxPfYnw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-341-U5jSwVlcMU-xk1l1_yxTzw-1; Sat, 25 Jan 2020 03:42:09 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7D77C19057A0;
 Sat, 25 Jan 2020 08:42:07 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-131.ams2.redhat.com
 [10.36.116.131])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 933BF5C1D4;
 Sat, 25 Jan 2020 08:42:06 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id DE8881138600; Sat, 25 Jan 2020 09:42:04 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Subject: Re: [RFC] migration: Remove old compression code
References: <20200123121628.37539-1-quintela@redhat.com>
Date: Sat, 25 Jan 2020 09:42:04 +0100
In-Reply-To: <20200123121628.37539-1-quintela@redhat.com> (Juan Quintela's
 message of "Thu, 23 Jan 2020 13:16:28 +0100")
Message-ID: <87iml0x6zn.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: U5jSwVlcMU-xk1l1_yxTzw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, liang.z.li@intel.com,
 xiaoguangrong@tencent.com, qemu-devel@nongnu.org,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, richardw.yang@linux.intel.com,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc'ing like David did, plus Eric and Mike for additional QAPI expertise.

Juan Quintela <quintela@redhat.com> writes:

> Hi
>
> There are several problems with the old compression code:
> * it compress one page at a time (i.e. 4KB)
>
> * it has to copy all the page to the compression thread, the
>   compression thread compress it, it copies back the compressed data
>   to the main thread and it sends it there (equivalent for decompress).
>
> * It is really slow (both the setup of it, and the compression of each pa=
ge)
>
> You can see that in the previous series, I added compression to multifd, =
its advantages are:
> * We compress "chunks" of 128 pages at a time
> * We don't copy anything, we just compress everything that is sent throug=
h the channel
> * We don't send data over the main channel, so we have less overhead
> * I added zstd support, that
>   o  Compress much more
>   o  It is way faster
>
> * Using the migration-test values (best option for compressors, as we
>   only change one byte on each page):
>   * zstd is around the same latency than no compression (i.e. it takes th=
e same time)
>   * zlib needs 2500 bytes to send 128 pages compressed (remember 1
>     byte changed in each page, rest are zeros)
>   * zstd needs 52 bytes for the same packets (yes, I checked several
>     times, it appears that its use of dictionaries is good here)
>
> This is an RFC, you will ask why?
> There are several questions:
> * How to proceed to remove this?
>    - Deprecate it into the future?
>      Has the advantage that customers can continue using it.
>      But it is not so stable to use it.
>    - Remove it now?
>      Has the advantage of much less code, but ....
> * Statistics:
>   Several of the statistics are already only printed when compression is
>   being used. My understanding is that we ase safe removing this ones.
> * But whan about the migration_parameters?  Should we leave them
>   alone, and just don't care about them? Should we remove them?
> * What to do with migration.json changes?  I will apprecciate comments he=
re.
>
> Thanks, Juan.
>
> PD.  You can see from the previous series that putting compression on
>      top of multifd + splitting the code in different files + making it o=
ptional:
>      around 1040 new lines of code.
>      Removing this ~ 960 lines of code.
>
> Signed-off-by: Juan Quintela <quintela@redhat.com>
[...]

Let's have a look at the changes to the stable external interface.

> diff --git a/qapi/migration.json b/qapi/migration.json
> index 65db85970e..5477d4d20b 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -79,27 +79,6 @@
>             'cache-miss': 'int', 'cache-miss-rate': 'number',
>             'overflow': 'int' } }
> =20
> -##
> -# @CompressionStats:
> -#
> -# Detailed migration compression statistics
> -#
> -# @pages: amount of pages compressed and transferred to the target VM
> -#
> -# @busy: count of times that no free thread was available to compress da=
ta
> -#
> -# @busy-rate: rate of thread busy
> -#
> -# @compressed-size: amount of bytes after compression
> -#
> -# @compression-rate: rate of compressed size
> -#
> -# Since: 3.1
> -##
> -{ 'struct': 'CompressionStats',
> -  'data': {'pages': 'int', 'busy': 'int', 'busy-rate': 'number',
> -=09   'compressed-size': 'int', 'compression-rate': 'number' } }
> -

Only user is MigrationInfo, which is next.

>  ##
>  # @MigrationStatus:
>  #
> @@ -200,9 +179,6 @@
   ##
   # @MigrationInfo:
[...]
>  #           only present when the postcopy-blocktime migration capabilit=
y
>  #           is enabled. (Since 3.0)
>  #
> -# @compression: migration compression statistics, only returned if compr=
ession
> -#           feature is on and status is 'active' or 'completed' (Since 3=
.1)
> -#
>  # @socket-address: Only used for tcp, to know what the real port is (Sin=
ce 4.0)
>  #
>  # Since: 0.14.0
> @@ -219,7 +195,6 @@
>             '*error-desc': 'str',
>             '*postcopy-blocktime' : 'uint32',
>             '*postcopy-vcpu-blocktime': ['uint32'],
> -           '*compression': 'CompressionStats',
>             '*socket-address': ['SocketAddress'] } }

MigrationInfo is returned by  query-migrate.  No other users.

Doc comment gives us wiggle room: "only returned if compression feature
is on".  Can it be on after this patch?

If no, the member can go without breaking query-migrate compatibility.

query-qmp-schema shows the change, though.  Could conceivably affect
users, but it seems unlikely.

Eric, Mike, we might want to grant ourselves explicit license to change
query-qmp-schema in such ways, by having qapi-code-gen.txt state
optional members may be removed when they can't be present anymore.
What do you think?

Alternatively, keep the member, hardcode value to whatever is returned
before the patch when compression is off, deprecate, remove after grace
period.  A bit more work, but safer.  Worthwhile?  Not for me to decide.

> =20
>  ##
> @@ -364,14 +339,6 @@
   ##
   # @MigrationCapability:
[...]
>  #          to enable the capability on the source VM. The feature is dis=
abled by
>  #          default. (since 1.6)
>  #
> -# @compress: Use multiple compression threads to accelerate live migrati=
on.
> -#          This feature can help to reduce the migration traffic, by sen=
ding
> -#          compressed pages. Please note that if compress and xbzrle are=
 both
> -#          on, compress only takes effect in the ram bulk stage, after t=
hat,
> -#          it will be disabled and only xbzrle takes effect, this can he=
lp to
> -#          minimize migration traffic. The feature is disabled by defaul=
t.
> -#          (since 2.4 )
> -#
>  # @events: generate events for each migration state change
>  #          (since 2.4 )
>  #
> @@ -425,7 +392,7 @@
>  ##
>  { 'enum': 'MigrationCapability',
>    'data': ['xbzrle', 'rdma-pin-all', 'auto-converge', 'zero-blocks',
> -           'compress', 'events', 'postcopy-ram', 'x-colo', 'release-ram'=
,
> +           'events', 'postcopy-ram', 'x-colo', 'release-ram',
>             'block', 'return-path', 'pause-before-switchover', 'multifd',
>             'dirty-bitmaps', 'postcopy-blocktime', 'late-block-activate',
>             'x-ignore-shared', 'validate-uuid' ] }

Only users are migrate-set-capabilities and query-migrate-capabilities,
via MigrationCapabilityStatus, which are next.

> @@ -479,7 +446,6 @@
   ##
   # @MigrationCapabilityStatus:
   #
   # Migration capability information
   #
   # @capability: capability enum
   #
   # @state: capability state bool
   #
   # Since: 1.2
   ##
   { 'struct': 'MigrationCapabilityStatus',
     'data': { 'capability' : 'MigrationCapability', 'state' : 'bool' } }

   ##
   # @migrate-set-capabilities:
   #
   # Enable/Disable the following migration capabilities (like xbzrle)
   #
   # @capabilities: json array of capability modifications to make
   #
   # Since: 1.2
   #
   # Example:
   #
   # -> { "execute": "migrate-set-capabilities" , "arguments":
   #      { "capabilities": [ { "capability": "xbzrle", "state": true } ] }=
 }
   #
   ##
   { 'command': 'migrate-set-capabilities',
     'data': { 'capabilities': ['MigrationCapabilityStatus'] } }

With MigrationCapability @compress gone, attempting to set it with
migrate-set-capabilities fails with GenericError, "desc": "Invalid
parameter 'compress'".

Setting capability "compress" can fail before this patch, but only when
you do it in the middle of a migration, so this is actually a new error.

Adding errors is explicitly permitted in docs/interop/qmp-spec.txt
section "Compatibility Considerations":

    However, Clients must not assume any particular:
    [...]
    - Amount of errors generated by a command, that is, new errors can be a=
dded
      to any existing command in newer versions of the Server

We're good.

   ##
   # @query-migrate-capabilities:
   #
   # Returns information about the current migration capabilities status
   #
   # Returns: @MigrationCapabilitiesStatus
   #
   # Since: 1.2
   #
   # Example:
   #
   # -> { "execute": "query-migrate-capabilities" }
   # <- { "return": [
   #       {"state": false, "capability": "xbzrle"},
>  #       {"state": false, "capability": "rdma-pin-all"},
>  #       {"state": false, "capability": "auto-converge"},
>  #       {"state": false, "capability": "zero-blocks"},
> -#       {"state": false, "capability": "compress"},
>  #       {"state": true, "capability": "events"},
>  #       {"state": false, "capability": "postcopy-ram"},
>  #       {"state": false, "capability": "x-colo"}
   #    ]}
   #
   ##
   { 'command': 'query-migrate-capabilities', 'returns':   ['MigrationCapab=
ilityStatus']}

What capabilties are returned when is not specified.

Aside: it should be, shouldn't it?

qmp_query_migrate_capabilities() returns them all, except it skips
"block" when !defined CONFIG_LIVE_BLOCK_MIGRATION.  De facto ABI due to
the gap in the documented ABI.

Removing capability "compress" is a break of this de facto ABI.
Acceptable when we're confident the ABI's users don't care.

Alternatively, keep them, hardcode value to false, deprecate, remove
after grace period.

Aside: you might want to make MigrationCapability @block conditional like

   { 'enum': 'MigrationCapability',
     'data': ['xbzrle', 'rdma-pin-all', 'auto-converge', 'zero-blocks',
              'compress', 'events', 'postcopy-ram', 'x-colo', 'release-ram'=
,
              { 'name': 'block',
                'if': 'defined(CONFIG_LIVE_BLOCK_MIGRATION)' },
              'return-path', 'pause-before-switchover', 'multifd',
              'dirty-bitmaps', 'postcopy-blocktime', 'late-block-activate',
              'x-ignore-shared', 'validate-uuid' ] }

> @@ -523,20 +489,6 @@
   ##
   # @MigrationParameter:
[...]
>  #          no compression, 1 means the best compression speed, and 9 mea=
ns best
>  #          compression ratio which will consume more CPU.
>  #
> -# @compress-threads: Set compression thread count to be used in live mig=
ration,
> -#          the compression thread count is an integer between 1 and 255.
> -#
> -# @compress-wait-thread: Controls behavior when all compression threads =
are
> -#                        currently busy. If true (default), wait for a f=
ree
> -#                        compression thread to become available; otherwi=
se,
> -#                        send the page uncompressed. (Since 3.1)
> -#
> -# @decompress-threads: Set decompression thread count to be used in live
> -#          migration, the decompression thread count is an integer betwe=
en 1
> -#          and 255. Usually, decompression is at least 4 times as fast a=
s
> -#          compression, so set the decompress-threads to the number abou=
t 1/4
> -#          of compress-threads is adequate.
> -#
>  # @cpu-throttle-initial: Initial percentage of time guest cpus are throt=
tled
>  #                        when migration auto-converge is activated. The
>  #                        default value is 20. (Since 2.7)
> @@ -607,8 +559,7 @@
>  { 'enum': 'MigrationParameter',
>    'data': ['announce-initial', 'announce-max',
>             'announce-rounds', 'announce-step',
> -           'compress-level', 'compress-threads', 'decompress-threads',
> -           'compress-wait-thread',
> +           'compress-level',
>             'cpu-throttle-initial', 'cpu-throttle-increment',
>             'tls-creds', 'tls-hostname', 'tls-authz', 'max-bandwidth',
>             'downtime-limit', 'x-checkpoint-delay', 'block-incremental',

Used internally; not part of the external interface.  Okay.

> @@ -633,15 +584,6 @@
   ##
   # @MigrateSetParameters:
[...]
>  #
>  # @compress-level: compression level
>  #
> -# @compress-threads: compression thread count
> -#
> -# @compress-wait-thread: Controls behavior when all compression threads =
are
> -#                        currently busy. If true (default), wait for a f=
ree
> -#                        compression thread to become available; otherwi=
se,
> -#                        send the page uncompressed. (Since 3.1)
> -#
> -# @decompress-threads: decompression thread count
> -#
>  # @cpu-throttle-initial: Initial percentage of time guest cpus are
>  #                        throttled when migration auto-converge is activ=
ated.
>  #                        The default value is 20. (Since 2.7)
> @@ -717,9 +659,6 @@
>              '*announce-rounds': 'size',
>              '*announce-step': 'size',
>              '*compress-level': 'int',
> -            '*compress-threads': 'int',
> -            '*compress-wait-thread': 'bool',
> -            '*decompress-threads': 'int',
>              '*cpu-throttle-initial': 'int',
>              '*cpu-throttle-increment': 'int',
>              '*tls-creds': 'StrOrNull',

MigrateSetParameters is the (boxed) argument of migrate-set-parameters.
No other users.

With these optional members, attempting to use them with
migrate-set-parameters fails with GenericError, "desc": "Invalid
parameter 'NAME'".

Same argument as for migrate-set-capabilities above.  Good.

> @@ -770,15 +709,6 @@
   ##
   # @MigrationParameters:
   #
   # The optional members aren't actually optional.
[...]
>  # @compress-level: compression level
>  #
> -# @compress-threads: compression thread count
> -#
> -# @compress-wait-thread: Controls behavior when all compression threads =
are
> -#                        currently busy. If true (default), wait for a f=
ree
> -#                        compression thread to become available; otherwi=
se,
> -#                        send the page uncompressed. (Since 3.1)
> -#
> -# @decompress-threads: decompression thread count
> -#
>  # @cpu-throttle-initial: Initial percentage of time guest cpus are
>  #                        throttled when migration auto-converge is activ=
ated.
>  #                        (Since 2.7)
> @@ -854,9 +784,6 @@
>              '*announce-rounds': 'size',
>              '*announce-step': 'size',
>              '*compress-level': 'uint8',
> -            '*compress-threads': 'uint8',
> -            '*compress-wait-thread': 'bool',
> -            '*decompress-threads': 'uint8',
>              '*cpu-throttle-initial': 'uint8',
>              '*cpu-throttle-increment': 'uint8',
>              '*tls-creds': 'str',
> @@ -885,9 +812,7 @@
>  #
>  # -> { "execute": "query-migrate-parameters" }
>  # <- { "return": {
> -#          "decompress-threads": 2,
>  #          "cpu-throttle-increment": 10,
> -#          "compress-threads": 8,
>  #          "compress-level": 1,
>  #          "cpu-throttle-initial": 20,
>  #          "max-bandwidth": 33554432,

MigrateSetParameters is returned by query-migrate-parameters.  No other
users.

Even thought the members are optional, the doc comment specifies all are
returned.  qmp_query_migrate_parameters() does.

Removing the parameters breaks this promise.  Acceptable when we're
confident the ABI's users don't care.

Alternatively, keep them, hardcode value to whatever is returned before
the patch when compression is off, deprecate, remove after grace period.

Questions?


