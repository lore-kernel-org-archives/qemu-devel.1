Return-Path: <SRS0=3KIA=4V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7301C3F2D1
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 08:20:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7007120732
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 08:20:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QGSCujz+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7007120732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58750 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9PG7-0005L3-I4
	for qemu-devel@archiver.kernel.org; Wed, 04 Mar 2020 03:20:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60538)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1j9PF8-0004gI-Qt
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 03:19:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1j9PF5-0008Gh-8g
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 03:19:02 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32488
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1j9PF5-0008BE-0A
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 03:18:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583309937;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dY/YJdq/cdWXkdGRjY9AhijAgrzwX2PSzjsss8z+1qM=;
 b=QGSCujz+bE11oU4p/vIzr2ZjXUdKCxNhDjKBTRQtzDeMFnO9iC7XzVeEBToWQruy9q89GG
 c0/UD70L9cMBd/dQw6Qf5Fwctxt7I5gKOGjVrxBdjO5qP52wKq9QoqJJUxva7cxRZXSXMU
 +B85MlZ/s6+c0kSJkLW/Xle6HwTmY8k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-235-WDj3OzlVPSKWladcTWmKZg-1; Wed, 04 Mar 2020 03:18:53 -0500
X-MC-Unique: WDj3OzlVPSKWladcTWmKZg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8E312A0CC8;
 Wed,  4 Mar 2020 08:18:52 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-129.ams2.redhat.com
 [10.36.116.129])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1D7295DA2C;
 Wed,  4 Mar 2020 08:18:49 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9778311386A6; Wed,  4 Mar 2020 09:18:47 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v2 00/30] Configurable policy for handling deprecated
 interfaces
References: <20200303163505.32041-1-armbru@redhat.com>
 <CAFEAcA_g=ghK1OO0dTdEoYL2Gon4gPff4pfj5kEo8C1v8N4=wA@mail.gmail.com>
Date: Wed, 04 Mar 2020 09:18:47 +0100
In-Reply-To: <CAFEAcA_g=ghK1OO0dTdEoYL2Gon4gPff4pfj5kEo8C1v8N4=wA@mail.gmail.com>
 (Peter Maydell's message of "Tue, 3 Mar 2020 17:21:22 +0000")
Message-ID: <87r1y8pm6w.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
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
Cc: Libvirt <libvir-list@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> writes:

> On Tue, 3 Mar 2020 at 16:37, Markus Armbruster <armbru@redhat.com> wrote:
>>
>> Based-on: <20200227144531.24309-1-armbru@redhat.com>
>>
>> This series extends QMP introspection to cover deprecation.
>> Additionally, new option -compat lets you configure what to do when
>> deprecated interfaces get used.  This is intended for testing users of
>> the management interfaces.  It is experimental.
>
> How much do you think this is likely to affect the
> generate-rst-from-qapi-docs series? I'd really like
> that to go in for this release, but this looks like
> it's shaping up to be a big conflict :-(

I paused reviewing your series to post this one, because "I'd really
like that to go in for this release" :)

My series touches 21 existing commented definitions in qapi/, six more
in tests/qapi-schema/doc-good.json, and adds new module
qapi/compat.json.  Consolidated diff appended.

Rule of thumb for reducing conflict resolution labor: the bigger manual
change goes first.  Yours is bigger, but I don't remember how manual it
is.

Let's try to get both series reviewed, then figure out together how to
get them merged with the least pain.



$ git-diff -p --stat master posted/qapi-features \*.json
 qapi/block-core.json                            | 69 +++++++++++++++++++--=
----
 qapi/block.json                                 |  9 ++--
 qapi/char.json                                  |  1 +
 qapi/compat.json                                | 52 +++++++++++++++++++
 qapi/control.json                               | 11 ++--
 qapi/introspect.json                            | 26 +++++-----
 qapi/machine.json                               | 34 ++++++------
 qapi/migration.json                             | 36 ++++++++-----
 qapi/misc.json                                  | 13 ++---
 qapi/qapi-schema.json                           |  1 +
 tests/qapi-schema/doc-good.json                 | 22 +++++++-
 tests/qapi-schema/features-deprecated-type.json |  3 ++
 tests/qapi-schema/qapi-schema-test.json         | 48 +++++++++++------
 13 files changed, 239 insertions(+), 86 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 85e27bb61f..bade02760c 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -297,7 +297,7 @@
 #
 # @encrypted: true if the backing device is encrypted
 #
-# @encryption_key_missing: Deprecated; always false
+# @encryption_key_missing: always false
 #
 # @detect_zeroes: detect and optimize zero writes (Since 2.1)
 #
@@ -363,13 +363,19 @@
 # @dirty-bitmaps: dirty bitmaps information (only present if node
 #                 has one or more dirty bitmaps) (Since 4.2)
 #
+# Features:
+# @deprecated: Member @encryption_key_missing is deprecated.  It is
+#     always false.
+#
 # Since: 0.14.0
 #
 ##
 { 'struct': 'BlockDeviceInfo',
   'data': { 'file': 'str', '*node-name': 'str', 'ro': 'bool', 'drv': 'str'=
,
             '*backing_file': 'str', 'backing_file_depth': 'int',
-            'encrypted': 'bool', 'encryption_key_missing': 'bool',
+            'encrypted': 'bool',
+            'encryption_key_missing': { 'type': 'bool',
+                                        'features': [ 'deprecated' ] },
             'detect_zeroes': 'BlockdevDetectZeroesOptions',
             'bps': 'int', 'bps_rd': 'int', 'bps_wr': 'int',
             'iops': 'int', 'iops_rd': 'int', 'iops_wr': 'int',
@@ -475,7 +481,7 @@
 #
 # @granularity: granularity of the dirty bitmap in bytes (since 1.4)
 #
-# @status: Deprecated in favor of @recording and @locked. (since 2.4)
+# @status: current status of the dirty bitmap (since 2.4)
 #
 # @recording: true if the bitmap is recording new writes from the guest.
 #             Replaces `active` and `disabled` statuses. (since 4.0)
@@ -492,11 +498,17 @@
 #                @busy to be false. This bitmap cannot be used. To remove
 #                it, use @block-dirty-bitmap-remove. (Since 4.0)
 #
+# Features:
+# @deprecated: Member @status is deprecated.  Use @recording and
+#     @locked instead.
+#
 # Since: 1.3
 ##
 { 'struct': 'BlockDirtyInfo',
   'data': {'*name': 'str', 'count': 'int', 'granularity': 'uint32',
-           'recording': 'bool', 'busy': 'bool', 'status': 'DirtyBitmapStat=
us',
+           'recording': 'bool', 'busy': 'bool',
+           'status': { 'type': 'DirtyBitmapStatus',
+                       'features': [ 'deprecated' ] },
            'persistent': 'bool', '*inconsistent': 'bool' } }
=20
 ##
@@ -659,7 +671,6 @@
 #
 # @dirty-bitmaps: dirty bitmaps information (only present if the
 #                 driver has one or more dirty bitmaps) (Since 2.0)
-#                 Deprecated in 4.2; see BlockDeviceInfo instead.
 #
 # @io-status: @BlockDeviceIoStatus. Only present if the device
 #             supports it and the VM is configured to stop on errors
@@ -669,13 +680,18 @@
 # @inserted: @BlockDeviceInfo describing the device if media is
 #            present
 #
+# Features:
+# @deprecated: Member @dirty-bitmaps is deprecated.  Use @inserted
+#     member @dirty-bitmaps instead.
+#
 # Since:  0.14.0
 ##
 { 'struct': 'BlockInfo',
   'data': {'device': 'str', '*qdev': 'str', 'type': 'str', 'removable': 'b=
ool',
            'locked': 'bool', '*inserted': 'BlockDeviceInfo',
            '*tray_open': 'bool', '*io-status': 'BlockDeviceIoStatus',
-           '*dirty-bitmaps': ['BlockDirtyInfo'] } }
+           '*dirty-bitmaps': { 'type': ['BlockDirtyInfo'],
+                               'features': [ 'deprecated' ] } } }
=20
 ##
 # @BlockMeasureInfo:
@@ -1616,7 +1632,7 @@
 # @base: Same as @base-node, except that it is a file name rather than a n=
ode
 #        name. This must be the exact filename string that was used to ope=
n the
 #        node; other strings, even if addressing the same file, are not
-#        accepted (deprecated, use @base-node instead)
+#        accepted
 #
 # @top-node: The node name of the backing image within the image chain
 #            which contains the topmost data to be committed down. If
@@ -1625,7 +1641,7 @@
 # @top: Same as @top-node, except that it is a file name rather than a nod=
e
 #       name. This must be the exact filename string that was used to open=
 the
 #       node; other strings, even if addressing the same file, are not
-#       accepted (deprecated, use @base-node instead)
+#       accepted
 #
 # @backing-file: The backing file string to write into the overlay
 #                image of 'top'.  If 'top' is the active layer,
@@ -1679,6 +1695,10 @@
 #                list without user intervention.
 #                Defaults to true. (Since 3.1)
 #
+# Features:
+# @deprecated: Members @base and @top are deprecated.  Use @base-node
+#     and @top-node instead.
+#
 # Returns: - Nothing on success
 #          - If @device does not exist, DeviceNotFound
 #          - Any other error returns a GenericError.
@@ -1695,7 +1715,9 @@
 ##
 { 'command': 'block-commit',
   'data': { '*job-id': 'str', 'device': 'str', '*base-node': 'str',
-            '*base': 'str', '*top-node': 'str', '*top': 'str',
+            '*base': { 'type': 'str', 'features': [ 'deprecated' ] },
+            '*top-node': 'str',
+            '*top': { 'type': 'str', 'features': [ 'deprecated' ] },
             '*backing-file': 'str', '*speed': 'int',
             '*on-error': 'BlockdevOnError',
             '*filter-node-name': 'str',
@@ -2433,7 +2455,7 @@
 #
 # A set of parameters describing block throttling.
 #
-# @device: Block device name (deprecated, use @id instead)
+# @device: Block device name
 #
 # @id: The name or QOM path of the guest device (since: 2.8)
 #
@@ -2501,10 +2523,14 @@
 #
 # @group: throttle group name (Since 2.4)
 #
+# Features:
+# @deprecated: Member @device is deprecated.  Use @id instead.
+#
 # Since: 1.1
 ##
 { 'struct': 'BlockIOThrottle',
-  'data': { '*device': 'str', '*id': 'str', 'bps': 'int', 'bps_rd': 'int',
+  'data': { '*device': { 'type': 'str', 'features': [ 'deprecated' ] },
+            '*id': 'str', 'bps': 'int', 'bps_rd': 'int',
             'bps_wr': 'int', 'iops': 'int', 'iops_rd': 'int', 'iops_wr': '=
int',
             '*bps_max': 'int', '*bps_rd_max': 'int',
             '*bps_wr_max': 'int', '*iops_max': 'int',
@@ -4776,7 +4802,7 @@
 #   to it
 # - if the guest device does not have an actual tray
 #
-# @device: Block device name (deprecated, use @id instead)
+# @device: Block device name
 #
 # @id: The name or QOM path of the guest device (since: 2.8)
 #
@@ -4785,6 +4811,9 @@
 #         immediately); if true, the tray will be opened regardless of whe=
ther
 #         it is locked
 #
+# Features:
+# @deprecated: Member @device is deprecated.  Use @id instead.
+#
 # Since: 2.5
 #
 # Example:
@@ -4803,7 +4832,7 @@
 #
 ##
 { 'command': 'blockdev-open-tray',
-  'data': { '*device': 'str',
+  'data': { '*device': { 'type': 'str', 'features': [ 'deprecated' ] },
             '*id': 'str',
             '*force': 'bool' } }
=20
@@ -4816,10 +4845,13 @@
 #
 # If the tray was already closed before, this will be a no-op.
 #
-# @device: Block device name (deprecated, use @id instead)
+# @device: Block device name
 #
 # @id: The name or QOM path of the guest device (since: 2.8)
 #
+# Features:
+# @deprecated: Member @device is deprecated.  Use @id instead.
+#
 # Since: 2.5
 #
 # Example:
@@ -4838,7 +4870,7 @@
 #
 ##
 { 'command': 'blockdev-close-tray',
-  'data': { '*device': 'str',
+  'data': { '*device': { 'type': 'str', 'features': [ 'deprecated' ] },
             '*id': 'str' } }
=20
 ##
@@ -4945,7 +4977,7 @@
 # combines blockdev-open-tray, blockdev-remove-medium, blockdev-insert-med=
ium
 # and blockdev-close-tray).
 #
-# @device: Block device name (deprecated, use @id instead)
+# @device: Block device name
 #
 # @id: The name or QOM path of the guest device
 #      (since: 2.8)
@@ -4958,6 +4990,9 @@
 # @read-only-mode: change the read-only mode of the device; defaults
 #                  to 'retain'
 #
+# Features:
+# @deprecated: Member @device is deprecated.  Use @id instead.
+#
 # Since: 2.5
 #
 # Examples:
@@ -4992,7 +5027,7 @@
 #
 ##
 { 'command': 'blockdev-change-medium',
-  'data': { '*device': 'str',
+  'data': { '*device': { 'type': 'str', 'features': [ 'deprecated' ] },
             '*id': 'str',
             'filename': 'str',
             '*format': 'str',
diff --git a/qapi/block.json b/qapi/block.json
index da19834db4..8314ef21d1 100644
--- a/qapi/block.json
+++ b/qapi/block.json
@@ -185,15 +185,18 @@
 ##
 # @eject:
 #
-# Ejects a device from a removable drive.
+# Ejects the medium from a removable block device.
 #
-# @device: Block device name (deprecated, use @id instead)
+# @device: Block device name
 #
 # @id: The name or QOM path of the guest device (since: 2.8)
 #
 # @force: If true, eject regardless of whether the drive is locked.
 #         If not specified, the default value is false.
 #
+# Features:
+# @deprecated: Member @device is deprecated.  Use @id instead.
+#
 # Returns: - Nothing on success
 #          - If @device is not a valid block device, DeviceNotFound
 # Notes:    Ejecting a device with no media results in success
@@ -206,7 +209,7 @@
 # <- { "return": {} }
 ##
 { 'command': 'eject',
-  'data': { '*device': 'str',
+  'data': { '*device': { 'type': 'str', 'features': [ 'deprecated' ] },
             '*id': 'str',
             '*force': 'bool' } }
=20
diff --git a/qapi/char.json b/qapi/char.json
index 6907b2bfdb..daceb20f84 100644
--- a/qapi/char.json
+++ b/qapi/char.json
@@ -258,6 +258,7 @@
 # @server: create server socket (default: true)
 # @wait: wait for incoming connection on server
 #        sockets (default: false).
+#        Silently ignored with server: false.  This use is deprecated.
 # @nodelay: set TCP_NODELAY socket option (default: false)
 # @telnet: enable telnet protocol on server
 #          sockets (default: false)
diff --git a/qapi/compat.json b/qapi/compat.json
new file mode 100644
index 0000000000..ec24567639
--- /dev/null
+++ b/qapi/compat.json
@@ -0,0 +1,52 @@
+# -*- Mode: Python -*-
+
+##
+# =3D Compatibility policy
+##
+
+##
+# @CompatPolicyInput:
+#
+# Policy for handling "funny" input.
+#
+# @accept: Accept silently
+# @reject: Reject with an error
+# @crash: abort() the process
+#
+# Since: 5.0
+##
+{ 'enum': 'CompatPolicyInput',
+  'data': [ 'accept', 'reject', 'crash' ] }
+
+##
+# @CompatPolicyOutput:
+#
+# Policy for handling "funny" output.
+#
+# @accept: Pass on unchanged
+# @hide: Filter out
+#
+# Since: 5.0
+##
+{ 'enum': 'CompatPolicyOutput',
+  'data': [ 'accept', 'hide' ] }
+
+##
+# @CompatPolicy:
+#
+# Policy for handling deprecated management interfaces.
+#
+# This is intended for testing users of the management interfaces.
+#
+# Limitation: covers only syntactic aspects of QMP, i.e. stuff tagged
+# with feature 'deprecated'.  We may want to extend it to cover
+# semantic aspects, CLI, and experimental features.
+#
+# @deprecated-input: how to handle deprecated input (default 'accept')
+# @deprecated-output: how to handle deprecated output (default 'accept')
+#
+# Since: 5.0
+##
+{ 'struct': 'CompatPolicy',
+  'data': { '*deprecated-input': 'CompatPolicyInput',
+            '*deprecated-output': 'CompatPolicyOutput' } }
diff --git a/qapi/control.json b/qapi/control.json
index 759c20e76f..cdb058eca0 100644
--- a/qapi/control.json
+++ b/qapi/control.json
@@ -174,13 +174,15 @@
 #
 # Return information on QMP events.
 #
+# Features:
+# @deprecated: This command is deprecated, because its output doesn't
+#     reflect compile-time configuration.  Use 'query-qmp-schema'
+#     instead.
+#
 # Returns: A list of @EventInfo.
 #
 # Since: 1.2.0
 #
-# Note: This command is deprecated, because its output doesn't reflect
-#       compile-time configuration.  Use query-qmp-schema instead.
-#
 # Example:
 #
 # -> { "execute": "query-events" }
@@ -198,7 +200,8 @@
 # Note: This example has been shortened as the real response is too long.
 #
 ##
-{ 'command': 'query-events', 'returns': ['EventInfo'] }
+{ 'command': 'query-events', 'returns': ['EventInfo'],
+  'features': [ 'deprecated' ] }
=20
 ##
 # @quit:
diff --git a/qapi/introspect.json b/qapi/introspect.json
index 8756e7920e..b1aabd4cfd 100644
--- a/qapi/introspect.json
+++ b/qapi/introspect.json
@@ -89,12 +89,18 @@
 #
 # @meta-type: the entity's meta type, inherited from @base.
 #
+# @features: names of features associated with the entity, in no
+#            particular order.
+#            (since 4.1 for object types, 4.2 for commands, 5.0 for
+#            the rest)
+#
 # Additional members depend on the value of @meta-type.
 #
 # Since: 2.5
 ##
 { 'union': 'SchemaInfo',
-  'base': { 'name': 'str', 'meta-type': 'SchemaMetaType' },
+  'base': { 'name': 'str', 'meta-type': 'SchemaMetaType',
+            '*features': [ 'str' ] },
   'discriminator': 'meta-type',
   'data': {
       'builtin': 'SchemaInfoBuiltin',
@@ -174,9 +180,6 @@
 #            and may even differ from the order of the values of the
 #            enum type of the @tag.
 #
-# @features: names of features associated with the type, in no particular
-#            order. (since: 4.1)
-#
 # Values of this type are JSON object on the wire.
 #
 # Since: 2.5
@@ -184,8 +187,7 @@
 { 'struct': 'SchemaInfoObject',
   'data': { 'members': [ 'SchemaInfoObjectMember' ],
             '*tag': 'str',
-            '*variants': [ 'SchemaInfoObjectVariant' ],
-            '*features': [ 'str' ] } }
+            '*variants': [ 'SchemaInfoObjectVariant' ] } }
=20
 ##
 # @SchemaInfoObjectMember:
@@ -204,11 +206,15 @@
 #           Future extension: if present and non-null, the parameter
 #           is optional, and defaults to this value.
 #
+# @features: names of features associated with the member, in no
+#            particular order.  (since 5.0)
+#
 # Since: 2.5
 ##
 { 'struct': 'SchemaInfoObjectMember',
-  'data': { 'name': 'str', 'type': 'str', '*default': 'any' } }
+  'data': { 'name': 'str', 'type': 'str', '*default': 'any',
 # @default's type must be null or match @type
+            '*features': [ 'str' ] } }
=20
 ##
 # @SchemaInfoObjectVariant:
@@ -266,17 +272,13 @@
 # @allow-oob: whether the command allows out-of-band execution,
 #             defaults to false (Since: 2.12)
 #
-# @features: names of features associated with the command, in no particul=
ar
-#            order. (since 4.2)
-#
 # TODO: @success-response (currently irrelevant, because it's QGA, not QMP=
)
 #
 # Since: 2.5
 ##
 { 'struct': 'SchemaInfoCommand',
   'data': { 'arg-type': 'str', 'ret-type': 'str',
-            '*allow-oob': 'bool',
-            '*features': [ 'str' ] } }
+            '*allow-oob': 'bool' } }
=20
 ##
 # @SchemaInfoEvent:
diff --git a/qapi/machine.json b/qapi/machine.json
index 6c11e3cf3a..0da3f3adc4 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -184,8 +184,11 @@
 # This command causes vCPU threads to exit to userspace, which causes
 # a small interruption to guest CPU execution. This will have a negative
 # impact on realtime guests and other latency sensitive guest workloads.
-# It is recommended to use @query-cpus-fast instead of this command to
-# avoid the vCPU interruption.
+#
+# Features:
+# @deprecated: This command is deprecated, because it interferes with
+#     the guest.  Use 'query-cpus-fast' instead to avoid the vCPU
+#     interruption.
 #
 # Returns: a list of @CpuInfo for each virtual CPU
 #
@@ -216,12 +219,9 @@
 #       ]
 #    }
 #
-# Notes: This interface is deprecated (since 2.12.0), and it is strongly
-#        recommended that you avoid using it. Use @query-cpus-fast to
-#        obtain information about virtual CPUs.
-#
 ##
-{ 'command': 'query-cpus', 'returns': ['CpuInfo'] }
+{ 'command': 'query-cpus', 'returns': ['CpuInfo'],
+  'features': [ 'deprecated' ] }
=20
 ##
 # @CpuInfoFast:
@@ -237,12 +237,14 @@
 # @props: properties describing to which node/socket/core/thread
 #         virtual CPU belongs to, provided if supported by board
 #
-# @arch: base architecture of the cpu; deprecated since 3.0.0 in favor
-#        of @target
+# @arch: base architecture of the cpu
 #
 # @target: the QEMU system emulation target, which determines which
 #          additional fields will be listed (since 3.0)
 #
+# Features:
+# @deprecated: Member @arch is deprecated.  Use @target instead.
+#
 # Since: 2.12
 #
 ##
@@ -251,7 +253,8 @@
                       'qom-path'     : 'str',
                       'thread-id'    : 'int',
                       '*props'       : 'CpuInstanceProperties',
-                      'arch'         : 'CpuInfoArch',
+                      'arch'         : { 'type': 'CpuInfoArch',
+                                         'features': [ 'deprecated' ] },
                       'target'       : 'SysEmuTarget' },
   'discriminator' : 'target',
   'data'          : { 's390x'        : 'CpuInfoS390' } }
@@ -307,21 +310,22 @@
 #
 # @id: ID of CPU to be created, valid values [0..max_cpus)
 #
+# Features:
+# @deprecated: This command is deprecated.  Use `device_add` instead.
+#     See the `query-hotpluggable-cpus` command for details.
+#
 # Returns: Nothing on success
 #
 # Since: 1.5
 #
-# Note: This command is deprecated.  The `device_add` command should be
-#       used instead.  See the `query-hotpluggable-cpus` command for
-#       details.
-#
 # Example:
 #
 # -> { "execute": "cpu-add", "arguments": { "id": 2 } }
 # <- { "return": {} }
 #
 ##
-{ 'command': 'cpu-add', 'data': {'id': 'int'} }
+{ 'command': 'cpu-add', 'data': {'id': 'int'},
+  'features': [ 'deprecated' ] }
=20
 ##
 # @MachineInfo:
diff --git a/qapi/migration.json b/qapi/migration.json
index d44d99cd78..b8b5eb195f 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -1196,9 +1196,11 @@
 #
 # @value: maximum downtime in seconds
 #
-# Returns: nothing on success
+# Features:
+# @deprecated: This command is deprecated.  Use
+#     'migrate-set-parameters' instead.
 #
-# Notes: This command is deprecated in favor of 'migrate-set-parameters'
+# Returns: nothing on success
 #
 # Since: 0.14.0
 #
@@ -1208,7 +1210,8 @@
 # <- { "return": {} }
 #
 ##
-{ 'command': 'migrate_set_downtime', 'data': {'value': 'number'} }
+{ 'command': 'migrate_set_downtime', 'data': {'value': 'number'},
+  'features': [ 'deprecated' ] }
=20
 ##
 # @migrate_set_speed:
@@ -1217,9 +1220,11 @@
 #
 # @value: maximum speed in bytes per second.
 #
-# Returns: nothing on success
+# Features:
+# @deprecated: This command is deprecated.  Use
+#     'migrate-set-parameters' instead.
 #
-# Notes: This command is deprecated in favor of 'migrate-set-parameters'
+# Returns: nothing on success
 #
 # Since: 0.14.0
 #
@@ -1229,7 +1234,8 @@
 # <- { "return": {} }
 #
 ##
-{ 'command': 'migrate_set_speed', 'data': {'value': 'int'} }
+{ 'command': 'migrate_set_speed', 'data': {'value': 'int'},
+  'features': [ 'deprecated' ] }
=20
 ##
 # @migrate-set-cache-size:
@@ -1238,13 +1244,15 @@
 #
 # @value: cache size in bytes
 #
+# Features:
+# @deprecated: This command is deprecated.  Use
+#     'migrate-set-parameters' instead.
+#
 # The size will be rounded down to the nearest power of 2.
 # The cache size can be modified before and during ongoing migration
 #
 # Returns: nothing on success
 #
-# Notes: This command is deprecated in favor of 'migrate-set-parameters'
-#
 # Since: 1.2
 #
 # Example:
@@ -1254,17 +1262,20 @@
 # <- { "return": {} }
 #
 ##
-{ 'command': 'migrate-set-cache-size', 'data': {'value': 'int'} }
+{ 'command': 'migrate-set-cache-size', 'data': {'value': 'int'},
+  'features': [ 'deprecated' ] }
=20
 ##
 # @query-migrate-cache-size:
 #
 # Query migration XBZRLE cache size
 #
+# Features:
+# @deprecated: This command is deprecated.  Use
+#     'query-migrate-parameters' instead.
+#
 # Returns: XBZRLE cache size in bytes
 #
-# Notes: This command is deprecated in favor of 'query-migrate-parameters'
-#
 # Since: 1.2
 #
 # Example:
@@ -1273,7 +1284,8 @@
 # <- { "return": 67108864 }
 #
 ##
-{ 'command': 'query-migrate-cache-size', 'returns': 'int' }
+{ 'command': 'query-migrate-cache-size', 'returns': 'int',
+  'features': [ 'deprecated' ] }
=20
 ##
 # @migrate:
diff --git a/qapi/misc.json b/qapi/misc.json
index c18fe681fb..99b90ac80b 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -872,14 +872,14 @@
 #       If @device is 'vnc' and @target is 'password', this is the new VNC
 #       password to set.  See change-vnc-password for additional notes.
 #
+# Features:
+# @deprecated: This command is deprecated.  For changing block
+#     devices, use 'blockdev-change-medium' instead; for changing VNC
+#     parameters, use 'change-vnc-password' instead.
+#
 # Returns: - Nothing on success.
 #          - If @device is not a valid block device, DeviceNotFound
 #
-# Notes: This interface is deprecated, and it is strongly recommended that=
 you
-#        avoid using it.  For changing block devices, use
-#        blockdev-change-medium; for changing VNC parameters, use
-#        change-vnc-password.
-#
 # Since: 0.14.0
 #
 # Example:
@@ -900,7 +900,8 @@
 #
 ##
 { 'command': 'change',
-  'data': {'device': 'str', 'target': 'str', '*arg': 'str'} }
+  'data': {'device': 'str', 'target': 'str', '*arg': 'str'},
+  'features': [ 'deprecated' ] }
=20
 ##
 # @xen-set-global-dirty-log:
diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json
index fe980ce437..fa800042e0 100644
--- a/qapi/qapi-schema.json
+++ b/qapi/qapi-schema.json
@@ -98,6 +98,7 @@
 { 'include': 'migration.json' }
 { 'include': 'transaction.json' }
 { 'include': 'trace.json' }
+{ 'include': 'compat.json' }
 { 'include': 'control.json' }
 { 'include': 'introspect.json' }
 { 'include': 'qom.json' }
diff --git a/tests/qapi-schema/doc-good.json b/tests/qapi-schema/doc-good.j=
son
index d992e713d9..ddd89d1233 100644
--- a/tests/qapi-schema/doc-good.json
+++ b/tests/qapi-schema/doc-good.json
@@ -53,10 +53,14 @@
 # @Enum:
 # @one: The _one_ {and only}
 #
+# Features:
+# @enum-feat: Also _one_ {and only}
+#
 # @two is undocumented
 ##
 { 'enum': 'Enum', 'data':
   [ { 'name': 'one', 'if': 'defined(IFONE)' }, 'two' ],
+  'features': [ 'enum-feat' ],
   'if': 'defined(IFCOND)' }
=20
 ##
@@ -74,10 +78,13 @@
 #
 # Features:
 # @variant1-feat: a feature
+# @member-feat: a member feature
 ##
 { 'struct': 'Variant1',
   'features': [ 'variant1-feat' ],
-  'data': { 'var1': { 'type': 'str', 'if': 'defined(IFSTR)' } } }
+  'data': { 'var1': { 'type': 'str',
+                      'features': [ 'member-feat' ],
+                      'if': 'defined(IFSTR)' } } }
=20
 ##
 # @Variant2:
@@ -86,24 +93,34 @@
=20
 ##
 # @Object:
+# Features:
+# @union-feat1: a feature
 ##
 { 'union': 'Object',
+  'features': [ 'union-feat1' ],
   'base': 'Base',
   'discriminator': 'base1',
   'data': { 'one': 'Variant1', 'two': { 'type': 'Variant2', 'if': 'IFTWO' =
} } }
=20
 ##
 # @SugaredUnion:
+# Features:
+# @union-feat2: a feature
 ##
 { 'union': 'SugaredUnion',
+  'features': [ 'union-feat2' ],
   'data': { 'one': 'Variant1', 'two': { 'type': 'Variant2', 'if': 'IFTWO' =
} } }
=20
 ##
 # @Alternate:
 # @i: an integer
 # @b is undocumented
+#
+# Features:
+# @alt-feat: a feature
 ##
 { 'alternate': 'Alternate',
+  'features': [ 'alt-feat' ],
   'data': { 'i': 'int', 'b': 'bool' } }
=20
 ##
@@ -160,6 +177,9 @@
=20
 ##
 # @EVT-BOXED:
+# Features:
+# @feat3: a feature
 ##
 { 'event': 'EVT-BOXED',  'boxed': true,
+  'features': [ 'feat3' ],
   'data': 'Object' }
diff --git a/tests/qapi-schema/features-deprecated-type.json b/tests/qapi-s=
chema/features-deprecated-type.json
new file mode 100644
index 0000000000..4b5bf5b86e
--- /dev/null
+++ b/tests/qapi-schema/features-deprecated-type.json
@@ -0,0 +1,3 @@
+# Feature 'deprecated' is not supported for types
+{ 'struct': 'S', 'data': {},
+  'features': [ 'deprecated' ] }
diff --git a/tests/qapi-schema/qapi-schema-test.json b/tests/qapi-schema/qa=
pi-schema-test.json
index 9abf175fe0..e4cce0d5b0 100644
--- a/tests/qapi-schema/qapi-schema-test.json
+++ b/tests/qapi-schema/qapi-schema-test.json
@@ -252,13 +252,13 @@
     'bar': { 'type': ['TestIfEnum'], 'if': 'defined(TEST_IF_EVT_BAR)' } },
   'if': 'defined(TEST_IF_EVT) && defined(TEST_IF_STRUCT)' }
=20
-# test 'features' for structs
+# test 'features'
=20
 { 'struct': 'FeatureStruct0',
   'data': { 'foo': 'int' },
   'features': [] }
 { 'struct': 'FeatureStruct1',
-  'data': { 'foo': 'int' },
+  'data': { 'foo': { 'type': 'int', 'features': [ 'deprecated' ] } },
   'features': [ 'feature1' ] }
 { 'struct': 'FeatureStruct2',
   'data': { 'foo': 'int' },
@@ -281,22 +281,35 @@
   'data': { 'foo': 'int' },
   'features': [ { 'name': 'feature1', 'if': [ 'defined(TEST_IF_COND_1)',
                                               'defined(TEST_IF_COND_2)'] }=
 ] }
-{ 'command': 'test-features',
-  'data': { 'fs0': 'FeatureStruct0',
-            'fs1': 'FeatureStruct1',
-            'fs2': 'FeatureStruct2',
-            'fs3': 'FeatureStruct3',
-            'fs4': 'FeatureStruct4',
-            'cfs1': 'CondFeatureStruct1',
-            'cfs2': 'CondFeatureStruct2',
-            'cfs3': 'CondFeatureStruct3' } }
-
-# test 'features' for command
-
-{ 'command': 'test-command-features0',
+
+{ 'enum': 'FeatureEnum1',
+  'data': [ 'eins', 'zwei', 'drei' ],
+  'features': [ 'feature1' ] }
+
+{ 'union': 'FeatureUnion1',
+  'base': { 'tag': 'FeatureEnum1' },
+  'discriminator': 'tag',
+  'data': { 'eins': 'FeatureStruct1' },
+  'features': [ 'feature1' ] }
+
+{ 'alternate': 'FeatureAlternate1',
+  'data': { 'eins': 'FeatureStruct1' },
+  'features': [ 'feature1' ] }
+
+{ 'command': 'test-features0',
+  'data': { '*fs0': 'FeatureStruct0',
+            '*fs1': 'FeatureStruct1',
+            '*fs2': 'FeatureStruct2',
+            '*fs3': 'FeatureStruct3',
+            '*fs4': 'FeatureStruct4',
+            '*cfs1': 'CondFeatureStruct1',
+            '*cfs2': 'CondFeatureStruct2',
+            '*cfs3': 'CondFeatureStruct3' },
+  'returns': 'FeatureStruct1',
   'features': [] }
+
 { 'command': 'test-command-features1',
-  'features': [ 'feature1' ] }
+  'features': [ 'deprecated' ] }
 { 'command': 'test-command-features3',
   'features': [ 'feature1', 'feature2' ] }
=20
@@ -308,3 +321,6 @@
 { 'command': 'test-command-cond-features3',
   'features': [ { 'name': 'feature1', 'if': [ 'defined(TEST_IF_COND_1)',
                                               'defined(TEST_IF_COND_2)'] }=
 ] }
+
+{ 'event': 'TEST-EVENT-FEATURES1',
+  'features': [ 'deprecated' ] }


