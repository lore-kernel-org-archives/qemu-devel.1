Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDA84C33CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 08:41:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7F5620702
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 08:41:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IVvz1XM3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7F5620702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42752 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwiuz-0003Oj-Rw
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 03:41:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54720)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iwipN-00027a-DT
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 03:36:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iwipB-00006W-BL
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 03:35:52 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53164
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iwipB-0008Lv-6G
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 03:35:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580286947;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K/eOHNBeH18dbLQQpaXeOvQ7t9yH74sOrS037FfoFtc=;
 b=IVvz1XM3ifYy3adC9cREKBFImt4IB/2nKEAJz4IBaCx/rngykUgZ/EuJ2fPB+9ub6aEbnM
 /plSAhm+jHau4IGf6tdBaIVGhKx4Kb8fEdkwDynHALlevtOyFWtQFEPb8QjNMc/RX5IV90
 pLhsZsW/Xx4CRIhcoAk54MaJy6ys0D0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-53-KRQ3twP3P8q_hFqf8WgEvQ-1; Wed, 29 Jan 2020 03:35:44 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2639A1B18BCD;
 Wed, 29 Jan 2020 08:35:43 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-131.ams2.redhat.com
 [10.36.116.131])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 984CD48;
 Wed, 29 Jan 2020 08:35:42 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0D1F61138404; Wed, 29 Jan 2020 09:35:41 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH v2 2/4] qapi: Create module 'control'
References: <20200128175211.30007-1-kwolf@redhat.com>
 <20200128175211.30007-3-kwolf@redhat.com>
Date: Wed, 29 Jan 2020 09:35:41 +0100
In-Reply-To: <20200128175211.30007-3-kwolf@redhat.com> (Kevin Wolf's message
 of "Tue, 28 Jan 2020 18:52:09 +0100")
Message-ID: <8736by4q3m.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: KRQ3twP3P8q_hFqf8WgEvQ-1
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Kevin Wolf <kwolf@redhat.com> writes:

> misc.json contains definitions that are related to the system emulator,
> so it can't be used for other tools like the storage daemon. This patch
> moves basic functionality that is shared between all tools (and mostly
> related to the monitor itself) into a new control.json, which could be
> used in tools as well.
>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  qapi/control.json          | 218 +++++++++++++++++++++++++++++++++++++
>  qapi/misc.json             | 212 ------------------------------------
>  qapi/qapi-schema.json      |   1 +
>  monitor/monitor-internal.h |   1 +
>  monitor/hmp-cmds.c         |   1 +
>  monitor/misc.c             |   1 +
>  monitor/qmp-cmds.c         |   1 +
>  monitor/qmp.c              |   2 +-
>  tests/qtest/qmp-test.c     |   2 +-
>  ui/gtk.c                   |   1 +
>  qapi/Makefile.objs         |   6 +-
>  11 files changed, 229 insertions(+), 217 deletions(-)
>  create mode 100644 qapi/control.json
>
> diff --git a/qapi/control.json b/qapi/control.json
> new file mode 100644
> index 0000000000..a82a18da1a
> --- /dev/null
> +++ b/qapi/control.json
> @@ -0,0 +1,218 @@
> +# -*- Mode: Python -*-
> +#
> +

Let's add a copyright notice:

   # Copyright (C) 2011-2020 Red Hat, Inc.
   #
   # This work is licensed under the terms of the GNU GPL, version 2 or lat=
er.
   # See the COPYING file in the top-level directory.

> +##
> +# =3D Monitor definitions (shared between system emulator and tools)
> +##

This comment does double-duty: it's for readers of this source file, and
for readers of generated docs/interop/qemu-qmp-ref.*.  It's okay for
the former, but not the latter, as the resulting table of contents
shows:

    1 API Reference
      1.1 Introduction
      1.2 Stability Considerations
      1.3 QMP errors
      1.4 Common data types
      1.5 Socket data types
      1.6 VM run state
      1.7 Cryptography
      1.8 Block devices
        1.8.1 Block core (VM unrelated)
        1.8.2 Background jobs
        1.8.3 Additional block stuff (VM related)
      1.9 Character devices
      1.10 Dump guest memory
      1.11 Net devices
      1.12 RDMA device
      1.13 Rocker switch device
      1.14 TPM (trusted platform module) devices
      1.15 Remote desktop
        1.15.1 Spice
        1.15.2 VNC
      1.16 Input
      1.17 Migration
      1.18 Transactions
      1.19 Tracing
      1.20 QMP introspection
      1.21 QEMU Object Model (QOM)
      1.22 Device infrastructure (qdev)
      1.23 Machines
      1.24 Monitor definitions (shared between system emulator and tools)
      1.25 Miscellanea
    Commands and Events Index
    Data Types Index

Let's examine the file's contents to find a better description:

* qmp_capabilities
* QMPCapability

  QMP capabilities negotiation.  This is about the QMP monitor.  I
  figure few users of QMP need to know about it.  No need to complicate
  this patch to put it in the ideal spot (assuming there are ideal
  spots).

* query-version
* VersionInfo
* VersionTriple

  QMP query-version, QMP greeting, HMP info version

  Losely related to introspection, QMP capabilities negotiation (the
  greeting includes query-version output), and "process" below.

  The HMP use is an implementation detail.

* query-commands
* CommandInfo
* query-events
* EventInfo

  Legacy QMP introspection.  query-events is deprecated in favor of
  query-qmp-schema.  query-commands probably should be.

  Ideally, these go into or next to section 1.20 QMP introspection.
  Let's deprecate and put them wherever is easiest for the grace period.

* quit

  You move this here because like everything else you move here, you
  expect this to be present in any QMP monitor.  I expect that, too.

  It's not really about the QMP monitor, it's about controlling the
  process that provides the QMP monitor.

Proposed header:

    # =3D QMP monitor control

This files @quit under monitor control, which isn't quite right, but
it'll do.  Moving it away from @stop & friends is a bit unfortunate (see
patch to misc.json below).  If that bothers us, we need to split
control.json.  I'm not demanding such a split.

> +
> +##
> +# @qmp_capabilities:
> +#
> +# Enable QMP capabilities.
> +#
> +# Arguments:
> +#
> +# @enable:   An optional list of QMPCapability values to enable.  The
> +#            client must not enable any capability that is not
> +#            mentioned in the QMP greeting message.  If the field is not
> +#            provided, it means no QMP capabilities will be enabled.
> +#            (since 2.12)
> +#
> +# Example:
> +#
> +# -> { "execute": "qmp_capabilities",
> +#      "arguments": { "enable": [ "oob" ] } }
> +# <- { "return": {} }
> +#
> +# Notes: This command is valid exactly when first connecting: it must be
> +# issued before any other command will be accepted, and will fail once t=
he
> +# monitor is accepting other commands. (see qemu docs/interop/qmp-spec.t=
xt)
> +#
> +# The QMP client needs to explicitly enable QMP capabilities, otherwise
> +# all the QMP capabilities will be turned off by default.
> +#
> +# Since: 0.13
> +#
> +##
> +{ 'command': 'qmp_capabilities',
> +  'data': { '*enable': [ 'QMPCapability' ] },
> +  'allow-preconfig': true }
> +
> +##
> +# @QMPCapability:
> +#
> +# Enumeration of capabilities to be advertised during initial client
> +# connection, used for agreeing on particular QMP extension behaviors.
> +#
> +# @oob:   QMP ability to support out-of-band requests.
> +#         (Please refer to qmp-spec.txt for more information on OOB)
> +#
> +# Since: 2.12
> +#
> +##
> +{ 'enum': 'QMPCapability',
> +  'data': [ 'oob' ] }
> +
> +##
> +# @VersionTriple:
> +#
> +# A three-part version number.
> +#
> +# @major:  The major version number.
> +#
> +# @minor:  The minor version number.
> +#
> +# @micro:  The micro version number.
> +#
> +# Since: 2.4
> +##
> +{ 'struct': 'VersionTriple',
> +  'data': {'major': 'int', 'minor': 'int', 'micro': 'int'} }
> +
> +
> +##
> +# @VersionInfo:
> +#
> +# A description of QEMU's version.
> +#
> +# @qemu:        The version of QEMU.  By current convention, a micro
> +#               version of 50 signifies a development branch.  A micro v=
ersion
> +#               greater than or equal to 90 signifies a release candidat=
e for
> +#               the next minor version.  A micro version of less than 50
> +#               signifies a stable release.
> +#
> +# @package:     QEMU will always set this field to an empty string.  Dow=
nstream
> +#               versions of QEMU should set this to a non-empty string. =
 The
> +#               exact format depends on the downstream however it highly
> +#               recommended that a unique name is used.
> +#
> +# Since: 0.14.0
> +##
> +{ 'struct': 'VersionInfo',
> +  'data': {'qemu': 'VersionTriple', 'package': 'str'} }
> +
> +##
> +# @query-version:
> +#
> +# Returns the current version of QEMU.
> +#
> +# Returns:  A @VersionInfo object describing the current version of QEMU=
.
> +#
> +# Since: 0.14.0
> +#
> +# Example:
> +#
> +# -> { "execute": "query-version" }
> +# <- {
> +#       "return":{
> +#          "qemu":{
> +#             "major":0,
> +#             "minor":11,
> +#             "micro":5
> +#          },
> +#          "package":""
> +#       }
> +#    }
> +#
> +##
> +{ 'command': 'query-version', 'returns': 'VersionInfo',
> +  'allow-preconfig': true }
> +
> +##
> +# @CommandInfo:
> +#
> +# Information about a QMP command
> +#
> +# @name: The command name
> +#
> +# Since: 0.14.0
> +##
> +{ 'struct': 'CommandInfo', 'data': {'name': 'str'} }
> +
> +##
> +# @query-commands:
> +#
> +# Return a list of supported QMP commands by this server
> +#
> +# Returns: A list of @CommandInfo for all supported commands
> +#
> +# Since: 0.14.0
> +#
> +# Example:
> +#
> +# -> { "execute": "query-commands" }
> +# <- {
> +#      "return":[
> +#         {
> +#            "name":"query-balloon"
> +#         },
> +#         {
> +#            "name":"system_powerdown"
> +#         }
> +#      ]
> +#    }
> +#
> +# Note: This example has been shortened as the real response is too long=
.
> +#
> +##
> +{ 'command': 'query-commands', 'returns': ['CommandInfo'],
> +  'allow-preconfig': true }
> +
> +##
> +# @EventInfo:
> +#
> +# Information about a QMP event
> +#
> +# @name: The event name
> +#
> +# Since: 1.2.0
> +##
> +{ 'struct': 'EventInfo', 'data': {'name': 'str'} }
> +
> +##
> +# @query-events:
> +#
> +# Return information on QMP events.
> +#
> +# Returns: A list of @EventInfo.
> +#
> +# Since: 1.2.0
> +#
> +# Note: This command is deprecated, because its output doesn't reflect
> +# compile-time configuration.  Use query-qmp-schema instead.
> +#
> +# Example:
> +#
> +# -> { "execute": "query-events" }
> +# <- {
> +#      "return": [
> +#          {
> +#             "name":"SHUTDOWN"
> +#          },
> +#          {
> +#             "name":"RESET"
> +#          }
> +#       ]
> +#    }
> +#
> +# Note: This example has been shortened as the real response is too long=
.
> +#
> +##
> +{ 'command': 'query-events', 'returns': ['EventInfo'] }
> +
> +##
> +# @quit:
> +#
> +# This command will cause the QEMU process to exit gracefully.  While ev=
ery
> +# attempt is made to send the QMP response before terminating, this is n=
ot
> +# guaranteed.  When using this interface, a premature EOF would not be
> +# unexpected.
> +#
> +# Since: 0.14.0
> +#
> +# Example:
> +#
> +# -> { "execute": "quit" }
> +# <- { "return": {} }
> +##
> +{ 'command': 'quit' }
> diff --git a/qapi/misc.json b/qapi/misc.json
> index 33b94e3589..cf656e9d4b 100644
> --- a/qapi/misc.json
> +++ b/qapi/misc.json
> @@ -7,159 +7,6 @@
> =20
>  { 'include': 'common.json' }
> =20
> -##
> -# @qmp_capabilities:
> -#
> -# Enable QMP capabilities.
> -#
> -# Arguments:
> -#
> -# @enable:   An optional list of QMPCapability values to enable.  The
> -#            client must not enable any capability that is not
> -#            mentioned in the QMP greeting message.  If the field is not
> -#            provided, it means no QMP capabilities will be enabled.
> -#            (since 2.12)
> -#
> -# Example:
> -#
> -# -> { "execute": "qmp_capabilities",
> -#      "arguments": { "enable": [ "oob" ] } }
> -# <- { "return": {} }
> -#
> -# Notes: This command is valid exactly when first connecting: it must be
> -# issued before any other command will be accepted, and will fail once t=
he
> -# monitor is accepting other commands. (see qemu docs/interop/qmp-spec.t=
xt)
> -#
> -# The QMP client needs to explicitly enable QMP capabilities, otherwise
> -# all the QMP capabilities will be turned off by default.
> -#
> -# Since: 0.13
> -#
> -##
> -{ 'command': 'qmp_capabilities',
> -  'data': { '*enable': [ 'QMPCapability' ] },
> -  'allow-preconfig': true }
> -
> -##
> -# @QMPCapability:
> -#
> -# Enumeration of capabilities to be advertised during initial client
> -# connection, used for agreeing on particular QMP extension behaviors.
> -#
> -# @oob:   QMP ability to support out-of-band requests.
> -#         (Please refer to qmp-spec.txt for more information on OOB)
> -#
> -# Since: 2.12
> -#
> -##
> -{ 'enum': 'QMPCapability',
> -  'data': [ 'oob' ] }
> -
> -##
> -# @VersionTriple:
> -#
> -# A three-part version number.
> -#
> -# @major:  The major version number.
> -#
> -# @minor:  The minor version number.
> -#
> -# @micro:  The micro version number.
> -#
> -# Since: 2.4
> -##
> -{ 'struct': 'VersionTriple',
> -  'data': {'major': 'int', 'minor': 'int', 'micro': 'int'} }
> -
> -
> -##
> -# @VersionInfo:
> -#
> -# A description of QEMU's version.
> -#
> -# @qemu:        The version of QEMU.  By current convention, a micro
> -#               version of 50 signifies a development branch.  A micro v=
ersion
> -#               greater than or equal to 90 signifies a release candidat=
e for
> -#               the next minor version.  A micro version of less than 50
> -#               signifies a stable release.
> -#
> -# @package:     QEMU will always set this field to an empty string.  Dow=
nstream
> -#               versions of QEMU should set this to a non-empty string. =
 The
> -#               exact format depends on the downstream however it highly
> -#               recommended that a unique name is used.
> -#
> -# Since: 0.14.0
> -##
> -{ 'struct': 'VersionInfo',
> -  'data': {'qemu': 'VersionTriple', 'package': 'str'} }
> -
> -##
> -# @query-version:
> -#
> -# Returns the current version of QEMU.
> -#
> -# Returns:  A @VersionInfo object describing the current version of QEMU=
.
> -#
> -# Since: 0.14.0
> -#
> -# Example:
> -#
> -# -> { "execute": "query-version" }
> -# <- {
> -#       "return":{
> -#          "qemu":{
> -#             "major":0,
> -#             "minor":11,
> -#             "micro":5
> -#          },
> -#          "package":""
> -#       }
> -#    }
> -#
> -##
> -{ 'command': 'query-version', 'returns': 'VersionInfo',
> -  'allow-preconfig': true }
> -
> -##
> -# @CommandInfo:
> -#
> -# Information about a QMP command
> -#
> -# @name: The command name
> -#
> -# Since: 0.14.0
> -##
> -{ 'struct': 'CommandInfo', 'data': {'name': 'str'} }
> -
> -##
> -# @query-commands:
> -#
> -# Return a list of supported QMP commands by this server
> -#
> -# Returns: A list of @CommandInfo for all supported commands
> -#
> -# Since: 0.14.0
> -#
> -# Example:
> -#
> -# -> { "execute": "query-commands" }
> -# <- {
> -#      "return":[
> -#         {
> -#            "name":"query-balloon"
> -#         },
> -#         {
> -#            "name":"system_powerdown"
> -#         }
> -#      ]
> -#    }
> -#
> -# Note: This example has been shortened as the real response is too long=
.
> -#
> -##
> -{ 'command': 'query-commands', 'returns': ['CommandInfo'],
> -  'allow-preconfig': true }
> -
>  ##
>  # @LostTickPolicy:
>  #
> @@ -300,48 +147,6 @@
>  ##
>  { 'command': 'query-uuid', 'returns': 'UuidInfo', 'allow-preconfig': tru=
e }
> =20
> -##
> -# @EventInfo:
> -#
> -# Information about a QMP event
> -#
> -# @name: The event name
> -#
> -# Since: 1.2.0
> -##
> -{ 'struct': 'EventInfo', 'data': {'name': 'str'} }
> -
> -##
> -# @query-events:
> -#
> -# Return information on QMP events.
> -#
> -# Returns: A list of @EventInfo.
> -#
> -# Since: 1.2.0
> -#
> -# Note: This command is deprecated, because its output doesn't reflect
> -# compile-time configuration.  Use query-qmp-schema instead.
> -#
> -# Example:
> -#
> -# -> { "execute": "query-events" }
> -# <- {
> -#      "return": [
> -#          {
> -#             "name":"SHUTDOWN"
> -#          },
> -#          {
> -#             "name":"RESET"
> -#          }
> -#       ]
> -#    }
> -#
> -# Note: This example has been shortened as the real response is too long=
.
> -#
> -##
> -{ 'command': 'query-events', 'returns': ['EventInfo'] }
> -
>  ##
>  # @IOThreadInfo:
>  #
> @@ -764,23 +569,6 @@
>  ##
>  { 'command': 'query-pci', 'returns': ['PciInfo'] }
> =20
> -##
> -# @quit:
> -#
> -# This command will cause the QEMU process to exit gracefully.  While ev=
ery
> -# attempt is made to send the QMP response before terminating, this is n=
ot
> -# guaranteed.  When using this interface, a premature EOF would not be
> -# unexpected.
> -#
> -# Since: 0.14.0
> -#
> -# Example:
> -#
> -# -> { "execute": "quit" }
> -# <- { "return": {} }
> -##
> -{ 'command': 'quit' }
> -
>  ##
>  # @stop:
>  #
> diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json
> index 9751b11f8f..61fd91ede7 100644
> --- a/qapi/qapi-schema.json
> +++ b/qapi/qapi-schema.json
> @@ -103,6 +103,7 @@
>  { 'include': 'qdev.json' }
>  { 'include': 'machine.json' }
>  { 'include': 'machine-target.json' }
> +{ 'include': 'control.json' }
>  { 'include': 'misc.json' }
>  { 'include': 'misc-target.json' }
>  { 'include': 'audio.json' }

This determines position within docs/interop/qemu-qmp-ref.*.  Next to
misc.json is the least change.  Perhaps putting it next to
introspect.json would be better.

If we split @quit off control.json, then we could include the .json
providing @quit next to @stop & friends.  Again, I'm not demanding such
a split.

> diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
> index d78f5ca190..4d402ded85 100644
> --- a/monitor/monitor-internal.h
> +++ b/monitor/monitor-internal.h
> @@ -27,6 +27,7 @@
> =20
>  #include "chardev/char-fe.h"
>  #include "monitor/monitor.h"
> +#include "qapi/qapi-types-control.h"
>  #include "qapi/qmp/dispatch.h"
>  #include "qapi/qmp/json-parser.h"
>  #include "qemu/readline.h"
> diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
> index d0e0af893a..abb052836b 100644
> --- a/monitor/hmp-cmds.c
> +++ b/monitor/hmp-cmds.c
> @@ -33,6 +33,7 @@
>  #include "qapi/qapi-commands-char.h"
>  #include "qapi/qapi-commands-migration.h"
>  #include "qapi/qapi-commands-misc.h"
> +#include "qapi/qapi-commands-control.h"
>  #include "qapi/qapi-commands-net.h"
>  #include "qapi/qapi-commands-rocker.h"
>  #include "qapi/qapi-commands-run-state.h"

Please keep the qapi/qapi-commands-* sorted, like you do ...

> diff --git a/monitor/misc.c b/monitor/misc.c
> index 4752150a67..ce89cdb282 100644
> --- a/monitor/misc.c
> +++ b/monitor/misc.c
> @@ -67,6 +67,7 @@
>  #include "qemu/thread.h"
>  #include "block/qapi.h"
>  #include "qapi/qapi-commands-char.h"
> +#include "qapi/qapi-commands-control.h"
>  #include "qapi/qapi-commands-migration.h"
>  #include "qapi/qapi-commands-misc.h"
>  #include "qapi/qapi-commands-qom.h"

... here.

> diff --git a/monitor/qmp-cmds.c b/monitor/qmp-cmds.c
> index c6faa3eaf0..263b39e700 100644
> --- a/monitor/qmp-cmds.c
> +++ b/monitor/qmp-cmds.c
> @@ -34,6 +34,7 @@
>  #include "qapi/qapi-commands-block-core.h"
>  #include "qapi/qapi-commands-machine.h"
>  #include "qapi/qapi-commands-misc.h"
> +#include "qapi/qapi-commands-control.h"
>  #include "qapi/qapi-commands-ui.h"
>  #include "qapi/qmp/qerror.h"
>  #include "hw/mem/memory-device.h"

Likewise.

> diff --git a/monitor/qmp.c b/monitor/qmp.c
> index 54c06ba824..8379c8f96e 100644
> --- a/monitor/qmp.c
> +++ b/monitor/qmp.c
> @@ -27,7 +27,7 @@
>  #include "chardev/char-io.h"
>  #include "monitor-internal.h"
>  #include "qapi/error.h"
> -#include "qapi/qapi-commands-misc.h"
> +#include "qapi/qapi-commands-control.h"
>  #include "qapi/qmp/qdict.h"
>  #include "qapi/qmp/qjson.h"
>  #include "qapi/qmp/qlist.h"
> diff --git a/tests/qtest/qmp-test.c b/tests/qtest/qmp-test.c
> index 1b0eb69832..1a8876b6ca 100644
> --- a/tests/qtest/qmp-test.c
> +++ b/tests/qtest/qmp-test.c
> @@ -13,7 +13,7 @@
>  #include "qemu/osdep.h"
>  #include "libqtest.h"
>  #include "qapi/error.h"
> -#include "qapi/qapi-visit-misc.h"
> +#include "qapi/qapi-visit-control.h"
>  #include "qapi/qmp/qdict.h"
>  #include "qapi/qmp/qlist.h"
>  #include "qapi/qobject-input-visitor.h"
> diff --git a/ui/gtk.c b/ui/gtk.c
> index d18892d1de..8ebbebe4ec 100644
> --- a/ui/gtk.c
> +++ b/ui/gtk.c
> @@ -33,6 +33,7 @@
>  #include "qemu/osdep.h"
>  #include "qapi/error.h"
>  #include "qapi/qapi-commands-misc.h"
> +#include "qapi/qapi-commands-control.h"
>  #include "qemu/cutils.h"
> =20
>  #include "ui/console.h"
> diff --git a/qapi/Makefile.objs b/qapi/Makefile.objs
> index a8f1f4c35e..20fcc37c2c 100644
> --- a/qapi/Makefile.objs
> +++ b/qapi/Makefile.objs
> @@ -5,9 +5,9 @@ util-obj-y +=3D opts-visitor.o qapi-clone-visitor.o
>  util-obj-y +=3D qmp-event.o
>  util-obj-y +=3D qapi-util.o
> =20
> -QAPI_COMMON_MODULES =3D audio authz block-core block char common crypto
> -QAPI_COMMON_MODULES +=3D dump error introspect job machine migration mis=
c net
> -QAPI_COMMON_MODULES +=3D qdev qom rdma rocker run-state sockets tpm
> +QAPI_COMMON_MODULES =3D audio authz block-core block char common control=
 crypto
> +QAPI_COMMON_MODULES +=3D dump error introspect job machine migration mis=
c
> +QAPI_COMMON_MODULES +=3D net qdev qom rdma rocker run-state sockets tpm
>  QAPI_COMMON_MODULES +=3D trace transaction ui
>  QAPI_TARGET_MODULES =3D machine-target misc-target
>  QAPI_MODULES =3D $(QAPI_COMMON_MODULES) $(QAPI_TARGET_MODULES)

With the comments and the include directives tidied up:
Reviewed-by: Markus Armbruster <armbru@redhat.com>


