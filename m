Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF53CC43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 19:21:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86110218AC
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 19:21:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JCqE7RYA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86110218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59368 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihesp-0004r6-LZ
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 14:21:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36587)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1ihery-0004Ld-1S
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 14:20:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iherv-0007T1-Mk
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 14:20:25 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33303
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iherv-0007Np-CI
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 14:20:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576696822;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YrfSoGkv8JHowPFvHvMQvoV8Gyv86v4gXCToNxKJ/Q4=;
 b=JCqE7RYAoVFRsfcE7r1tCyiz3kTjDbocZkK7FEP9Q6WaNLntA+8KHe+PDDcr+GUglGUnvt
 dvtEbojjZrwzX9pdlPQ28KD8UDWGz5mwlUTQbP9xQMmflI+RecUT0+FUv5T61OmSFUfwUU
 +6D2mPNbPw3m858e8B5zY8AtnvY9lB0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-132-6E4AFZIIN_Saj1yqvXRRtQ-1; Wed, 18 Dec 2019 14:20:17 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0921B801336;
 Wed, 18 Dec 2019 19:20:16 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-42.ams2.redhat.com
 [10.36.116.42])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7F8E65D9E2;
 Wed, 18 Dec 2019 19:20:15 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id EDE7411386A7; Wed, 18 Dec 2019 20:20:13 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH 2/4] qapi: Create module 'monitor'
References: <20191218161952.10202-1-kwolf@redhat.com>
 <20191218161952.10202-3-kwolf@redhat.com>
Date: Wed, 18 Dec 2019 20:20:13 +0100
In-Reply-To: <20191218161952.10202-3-kwolf@redhat.com> (Kevin Wolf's message
 of "Wed, 18 Dec 2019 17:19:50 +0100")
Message-ID: <87eex1zbiq.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: 6E4AFZIIN_Saj1yqvXRRtQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
> so it can't be used for the storage daemon. This patch moves basic
> functionality that is related to the monitor itself into a new
> monitor.json, which could be used in tools as well.
>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  qapi/misc.json             | 212 ------------------------------------
>  qapi/monitor.json          | 218 +++++++++++++++++++++++++++++++++++++
>  qapi/qapi-schema.json      |   1 +
>  monitor/monitor-internal.h |   1 +
>  monitor/hmp-cmds.c         |   1 +
>  monitor/qmp-cmds.c         |   1 +
>  monitor/qmp.c              |   2 +-
>  tests/qmp-test.c           |   2 +-
>  ui/gtk.c                   |   1 +
>  qapi/Makefile.objs         |   4 +-
>  10 files changed, 227 insertions(+), 216 deletions(-)
>  create mode 100644 qapi/monitor.json
>
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
> diff --git a/qapi/monitor.json b/qapi/monitor.json
> new file mode 100644
> index 0000000000..a82a18da1a
> --- /dev/null
> +++ b/qapi/monitor.json
> @@ -0,0 +1,218 @@
> +# -*- Mode: Python -*-
> +#
> +
> +##
> +# =3D Monitor definitions (shared between system emulator and tools)
> +##
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

Borderline.  I guess you move query-version (along with VersionInfo,
VersionTriple) because qmp_greeting() uses it.

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

Borderline.

Perhaps it's just a matter of naming.  monitor.json suggests it's about
the monitor.  It's in fact about QMP, plus whatever else any program
sporting a QMP monitor has.  Can we find a name for that?  Hmm...
control.json?

[...]
> diff --git a/qapi/Makefile.objs b/qapi/Makefile.objs
> index dd3f5e6f94..519b6f1a8e 100644
> --- a/qapi/Makefile.objs
> +++ b/qapi/Makefile.objs
> @@ -6,8 +6,8 @@ util-obj-y +=3D qmp-event.o
>  util-obj-y +=3D qapi-util.o
> =20
>  QAPI_COMMON_MODULES =3D audio authz block-core block char common crypto
> -QAPI_COMMON_MODULES +=3D dump error introspect job machine migration mis=
c net
> -QAPI_COMMON_MODULES +=3D qdev qom rdma rocker run-state sockets tpm
> +QAPI_COMMON_MODULES +=3D dump error introspect job machine migration mis=
c monitor

Long line.

> +QAPI_COMMON_MODULES +=3D net qdev qom rdma rocker run-state sockets tpm
>  QAPI_COMMON_MODULES +=3D trace transaction ui
>  QAPI_TARGET_MODULES =3D machine-target misc-target
>  QAPI_MODULES =3D $(QAPI_COMMON_MODULES) $(QAPI_TARGET_MODULES)


