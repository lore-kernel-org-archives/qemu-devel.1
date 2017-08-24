Received: from eggs.gnu.org ([2001:4830:134:3::10]:48990)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dkxaE-0006Yq-E7
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 15:14:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dkxa6-0004DU-AM
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 15:14:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:4995)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dkxa5-0004Bc-Mh
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 15:14:18 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B3FE87E44A
	for <qemu-devel@nongnu.org>; Thu, 24 Aug 2017 19:14:16 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 24 Aug 2017 21:14:00 +0200
Message-Id: <1503602048-12268-9-git-send-email-armbru@redhat.com>
In-Reply-To: <1503602048-12268-1-git-send-email-armbru@redhat.com>
References: <1503602048-12268-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v2 08/16] qapi-schema: Collect UI stuff in
 qapi/ui.json
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, eblake@redhat.com, Gerd Hoffmann <kraxel@redhat.com>

UI stuff is remote desktop stuff (Spice, VNC) and input stuff (mouse,
keyboard).

Cc: Gerd Hoffmann <kraxel@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 MAINTAINERS      |   2 +
 Makefile         |   3 +-
 qapi-schema.json | 784 +-------------------------------------------
 qapi/event.json  | 175 ----------
 qapi/ui.json     | 977 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 982 insertions(+), 959 deletions(-)
 create mode 100644 qapi/ui.json

diff --git a/MAINTAINERS b/MAINTAINERS
index aecde65..24c5105 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1320,12 +1320,14 @@ F: include/ui/spice-display.h
 F: ui/spice-*.c
 F: audio/spiceaudio.c
 F: hw/display/qxl*
+F: qapi/ui.json
 
 Graphics
 M: Gerd Hoffmann <kraxel@redhat.com>
 S: Odd Fixes
 F: ui/
 F: include/ui/
+F: qapi/ui.json
 
 Cocoa graphics
 M: Peter Maydell <peter.maydell@linaro.org>
diff --git a/Makefile b/Makefile
index 75f3ffe..c7b6fd1 100644
--- a/Makefile
+++ b/Makefile
@@ -417,7 +417,8 @@ qapi-modules = $(SRC_PATH)/qapi-schema.json $(SRC_PATH)/qapi/common.json \
                $(SRC_PATH)/qapi/rocker.json \
                $(SRC_PATH)/qapi/run-state.json \
                $(SRC_PATH)/qapi/sockets.json \
-               $(SRC_PATH)/qapi/trace.json
+               $(SRC_PATH)/qapi/trace.json \
+               $(SRC_PATH)/qapi/ui.json
 
 qapi-types.c qapi-types.h :\
 $(qapi-modules) $(SRC_PATH)/scripts/qapi-types.py $(qapi-py)
diff --git a/qapi-schema.json b/qapi-schema.json
index e9b61eb..6a23f59 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -86,6 +86,7 @@
 { 'include': 'qapi/char.json' }
 { 'include': 'qapi/net.json' }
 { 'include': 'qapi/rocker.json' }
+{ 'include': 'qapi/ui.json' }
 { 'include': 'qapi/event.json' }
 { 'include': 'qapi/trace.json' }
 { 'include': 'qapi/introspect.json' }
@@ -1087,56 +1088,6 @@
 { 'command': 'x-colo-lost-heartbeat' }
 
 ##
-# @MouseInfo:
-#
-# Information about a mouse device.
-#
-# @name: the name of the mouse device
-#
-# @index: the index of the mouse device
-#
-# @current: true if this device is currently receiving mouse events
-#
-# @absolute: true if this device supports absolute coordinates as input
-#
-# Since: 0.14.0
-##
-{ 'struct': 'MouseInfo',
-  'data': {'name': 'str', 'index': 'int', 'current': 'bool',
-           'absolute': 'bool'} }
-
-##
-# @query-mice:
-#
-# Returns information about each active mouse device
-#
-# Returns: a list of @MouseInfo for each device
-#
-# Since: 0.14.0
-#
-# Example:
-#
-# -> { "execute": "query-mice" }
-# <- { "return": [
-#          {
-#             "name":"QEMU Microsoft Mouse",
-#             "index":0,
-#             "current":false,
-#             "absolute":false
-#          },
-#          {
-#             "name":"QEMU PS/2 Mouse",
-#             "index":1,
-#             "current":true,
-#             "absolute":true
-#          }
-#       ]
-#    }
-#
-##
-{ 'command': 'query-mice', 'returns': ['MouseInfo'] }
-
-##
 # @CpuInfoArch:
 #
 # An enumeration of cpu types that enable additional information during
@@ -1349,376 +1300,6 @@
 { 'command': 'query-iothreads', 'returns': ['IOThreadInfo'] }
 
 ##
-# @VncBasicInfo:
-#
-# The basic information for vnc network connection
-#
-# @host: IP address
-#
-# @service: The service name of the vnc port. This may depend on the host
-#           system's service database so symbolic names should not be relied
-#           on.
-#
-# @family: address family
-#
-# @websocket: true in case the socket is a websocket (since 2.3).
-#
-# Since: 2.1
-##
-{ 'struct': 'VncBasicInfo',
-  'data': { 'host': 'str',
-            'service': 'str',
-            'family': 'NetworkAddressFamily',
-            'websocket': 'bool' } }
-
-##
-# @VncServerInfo:
-#
-# The network connection information for server
-#
-# @auth: authentication method used for
-#        the plain (non-websocket) VNC server
-#
-# Since: 2.1
-##
-{ 'struct': 'VncServerInfo',
-  'base': 'VncBasicInfo',
-  'data': { '*auth': 'str' } }
-
-##
-# @VncClientInfo:
-#
-# Information about a connected VNC client.
-#
-# @x509_dname: If x509 authentication is in use, the Distinguished
-#              Name of the client.
-#
-# @sasl_username: If SASL authentication is in use, the SASL username
-#                 used for authentication.
-#
-# Since: 0.14.0
-##
-{ 'struct': 'VncClientInfo',
-  'base': 'VncBasicInfo',
-  'data': { '*x509_dname': 'str', '*sasl_username': 'str' } }
-
-##
-# @VncInfo:
-#
-# Information about the VNC session.
-#
-# @enabled: true if the VNC server is enabled, false otherwise
-#
-# @host: The hostname the VNC server is bound to.  This depends on
-#        the name resolution on the host and may be an IP address.
-#
-# @family: 'ipv6' if the host is listening for IPv6 connections
-#                    'ipv4' if the host is listening for IPv4 connections
-#                    'unix' if the host is listening on a unix domain socket
-#                    'unknown' otherwise
-#
-# @service: The service name of the server's port.  This may depends
-#           on the host system's service database so symbolic names should not
-#           be relied on.
-#
-# @auth: the current authentication type used by the server
-#        'none' if no authentication is being used
-#        'vnc' if VNC authentication is being used
-#        'vencrypt+plain' if VEncrypt is used with plain text authentication
-#        'vencrypt+tls+none' if VEncrypt is used with TLS and no authentication
-#        'vencrypt+tls+vnc' if VEncrypt is used with TLS and VNC authentication
-#        'vencrypt+tls+plain' if VEncrypt is used with TLS and plain text auth
-#        'vencrypt+x509+none' if VEncrypt is used with x509 and no auth
-#        'vencrypt+x509+vnc' if VEncrypt is used with x509 and VNC auth
-#        'vencrypt+x509+plain' if VEncrypt is used with x509 and plain text auth
-#        'vencrypt+tls+sasl' if VEncrypt is used with TLS and SASL auth
-#        'vencrypt+x509+sasl' if VEncrypt is used with x509 and SASL auth
-#
-# @clients: a list of @VncClientInfo of all currently connected clients
-#
-# Since: 0.14.0
-##
-{ 'struct': 'VncInfo',
-  'data': {'enabled': 'bool', '*host': 'str',
-           '*family': 'NetworkAddressFamily',
-           '*service': 'str', '*auth': 'str', '*clients': ['VncClientInfo']} }
-
-##
-# @VncPrimaryAuth:
-#
-# vnc primary authentication method.
-#
-# Since: 2.3
-##
-{ 'enum': 'VncPrimaryAuth',
-  'data': [ 'none', 'vnc', 'ra2', 'ra2ne', 'tight', 'ultra',
-            'tls', 'vencrypt', 'sasl' ] }
-
-##
-# @VncVencryptSubAuth:
-#
-# vnc sub authentication method with vencrypt.
-#
-# Since: 2.3
-##
-{ 'enum': 'VncVencryptSubAuth',
-  'data': [ 'plain',
-            'tls-none',  'x509-none',
-            'tls-vnc',   'x509-vnc',
-            'tls-plain', 'x509-plain',
-            'tls-sasl',  'x509-sasl' ] }
-
-
-##
-# @VncServerInfo2:
-#
-# The network connection information for server
-#
-# @auth: The current authentication type used by the servers
-#
-# @vencrypt: The vencrypt sub authentication type used by the
-#            servers, only specified in case auth == vencrypt.
-#
-# Since: 2.9
-##
-{ 'struct': 'VncServerInfo2',
-  'base': 'VncBasicInfo',
-  'data': { 'auth'      : 'VncPrimaryAuth',
-            '*vencrypt' : 'VncVencryptSubAuth' } }
-
-
-##
-# @VncInfo2:
-#
-# Information about a vnc server
-#
-# @id: vnc server name.
-#
-# @server: A list of @VncBasincInfo describing all listening sockets.
-#          The list can be empty (in case the vnc server is disabled).
-#          It also may have multiple entries: normal + websocket,
-#          possibly also ipv4 + ipv6 in the future.
-#
-# @clients: A list of @VncClientInfo of all currently connected clients.
-#           The list can be empty, for obvious reasons.
-#
-# @auth: The current authentication type used by the non-websockets servers
-#
-# @vencrypt: The vencrypt authentication type used by the servers,
-#            only specified in case auth == vencrypt.
-#
-# @display: The display device the vnc server is linked to.
-#
-# Since: 2.3
-##
-{ 'struct': 'VncInfo2',
-  'data': { 'id'        : 'str',
-            'server'    : ['VncServerInfo2'],
-            'clients'   : ['VncClientInfo'],
-            'auth'      : 'VncPrimaryAuth',
-            '*vencrypt' : 'VncVencryptSubAuth',
-            '*display'  : 'str' } }
-
-##
-# @query-vnc:
-#
-# Returns information about the current VNC server
-#
-# Returns: @VncInfo
-#
-# Since: 0.14.0
-#
-# Example:
-#
-# -> { "execute": "query-vnc" }
-# <- { "return": {
-#          "enabled":true,
-#          "host":"0.0.0.0",
-#          "service":"50402",
-#          "auth":"vnc",
-#          "family":"ipv4",
-#          "clients":[
-#             {
-#                "host":"127.0.0.1",
-#                "service":"50401",
-#                "family":"ipv4"
-#             }
-#          ]
-#       }
-#    }
-#
-##
-{ 'command': 'query-vnc', 'returns': 'VncInfo' }
-
-##
-# @query-vnc-servers:
-#
-# Returns a list of vnc servers.  The list can be empty.
-#
-# Returns: a list of @VncInfo2
-#
-# Since: 2.3
-##
-{ 'command': 'query-vnc-servers', 'returns': ['VncInfo2'] }
-
-##
-# @SpiceBasicInfo:
-#
-# The basic information for SPICE network connection
-#
-# @host: IP address
-#
-# @port: port number
-#
-# @family: address family
-#
-# Since: 2.1
-##
-{ 'struct': 'SpiceBasicInfo',
-  'data': { 'host': 'str',
-            'port': 'str',
-            'family': 'NetworkAddressFamily' } }
-
-##
-# @SpiceServerInfo:
-#
-# Information about a SPICE server
-#
-# @auth: authentication method
-#
-# Since: 2.1
-##
-{ 'struct': 'SpiceServerInfo',
-  'base': 'SpiceBasicInfo',
-  'data': { '*auth': 'str' } }
-
-##
-# @SpiceChannel:
-#
-# Information about a SPICE client channel.
-#
-# @connection-id: SPICE connection id number.  All channels with the same id
-#                 belong to the same SPICE session.
-#
-# @channel-type: SPICE channel type number.  "1" is the main control
-#                channel, filter for this one if you want to track spice
-#                sessions only
-#
-# @channel-id: SPICE channel ID number.  Usually "0", might be different when
-#              multiple channels of the same type exist, such as multiple
-#              display channels in a multihead setup
-#
-# @tls: true if the channel is encrypted, false otherwise.
-#
-# Since: 0.14.0
-##
-{ 'struct': 'SpiceChannel',
-  'base': 'SpiceBasicInfo',
-  'data': {'connection-id': 'int', 'channel-type': 'int', 'channel-id': 'int',
-           'tls': 'bool'} }
-
-##
-# @SpiceQueryMouseMode:
-#
-# An enumeration of Spice mouse states.
-#
-# @client: Mouse cursor position is determined by the client.
-#
-# @server: Mouse cursor position is determined by the server.
-#
-# @unknown: No information is available about mouse mode used by
-#           the spice server.
-#
-# Note: spice/enums.h has a SpiceMouseMode already, hence the name.
-#
-# Since: 1.1
-##
-{ 'enum': 'SpiceQueryMouseMode',
-  'data': [ 'client', 'server', 'unknown' ] }
-
-##
-# @SpiceInfo:
-#
-# Information about the SPICE session.
-#
-# @enabled: true if the SPICE server is enabled, false otherwise
-#
-# @migrated: true if the last guest migration completed and spice
-#            migration had completed as well. false otherwise. (since 1.4)
-#
-# @host: The hostname the SPICE server is bound to.  This depends on
-#        the name resolution on the host and may be an IP address.
-#
-# @port: The SPICE server's port number.
-#
-# @compiled-version: SPICE server version.
-#
-# @tls-port: The SPICE server's TLS port number.
-#
-# @auth: the current authentication type used by the server
-#        'none'  if no authentication is being used
-#        'spice' uses SASL or direct TLS authentication, depending on command
-#                line options
-#
-# @mouse-mode: The mode in which the mouse cursor is displayed currently. Can
-#              be determined by the client or the server, or unknown if spice
-#              server doesn't provide this information. (since: 1.1)
-#
-# @channels: a list of @SpiceChannel for each active spice channel
-#
-# Since: 0.14.0
-##
-{ 'struct': 'SpiceInfo',
-  'data': {'enabled': 'bool', 'migrated': 'bool', '*host': 'str', '*port': 'int',
-           '*tls-port': 'int', '*auth': 'str', '*compiled-version': 'str',
-           'mouse-mode': 'SpiceQueryMouseMode', '*channels': ['SpiceChannel']} }
-
-##
-# @query-spice:
-#
-# Returns information about the current SPICE server
-#
-# Returns: @SpiceInfo
-#
-# Since: 0.14.0
-#
-# Example:
-#
-# -> { "execute": "query-spice" }
-# <- { "return": {
-#          "enabled": true,
-#          "auth": "spice",
-#          "port": 5920,
-#          "tls-port": 5921,
-#          "host": "0.0.0.0",
-#          "channels": [
-#             {
-#                "port": "54924",
-#                "family": "ipv4",
-#                "channel-type": 1,
-#                "connection-id": 1804289383,
-#                "host": "127.0.0.1",
-#                "channel-id": 0,
-#                "tls": true
-#             },
-#             {
-#                "port": "36710",
-#                "family": "ipv4",
-#                "channel-type": 4,
-#                "connection-id": 1804289383,
-#                "host": "127.0.0.1",
-#                "channel-id": 0,
-#                "tls": false
-#             },
-#             [ ... more channels follow ... ]
-#          ]
-#       }
-#    }
-#
-##
-{ 'command': 'query-spice', 'returns': 'SpiceInfo' }
-
-##
 # @BalloonInfo:
 #
 # Information about the guest balloon device.
@@ -2685,83 +2266,6 @@
   'data': { 'path': 'str', 'property': 'str', 'value': 'any' } }
 
 ##
-# @set_password:
-#
-# Sets the password of a remote display session.
-#
-# @protocol: `vnc' to modify the VNC server password
-#            `spice' to modify the Spice server password
-#
-# @password: the new password
-#
-# @connected: how to handle existing clients when changing the
-#                       password.  If nothing is specified, defaults to `keep'
-#                       `fail' to fail the command if clients are connected
-#                       `disconnect' to disconnect existing clients
-#                       `keep' to maintain existing clients
-#
-# Returns: Nothing on success
-#          If Spice is not enabled, DeviceNotFound
-#
-# Since: 0.14.0
-#
-# Example:
-#
-# -> { "execute": "set_password", "arguments": { "protocol": "vnc",
-#                                                "password": "secret" } }
-# <- { "return": {} }
-#
-##
-{ 'command': 'set_password',
-  'data': {'protocol': 'str', 'password': 'str', '*connected': 'str'} }
-
-##
-# @expire_password:
-#
-# Expire the password of a remote display server.
-#
-# @protocol: the name of the remote display protocol `vnc' or `spice'
-#
-# @time: when to expire the password.
-#        `now' to expire the password immediately
-#        `never' to cancel password expiration
-#        `+INT' where INT is the number of seconds from now (integer)
-#        `INT' where INT is the absolute time in seconds
-#
-# Returns: Nothing on success
-#          If @protocol is `spice' and Spice is not active, DeviceNotFound
-#
-# Since: 0.14.0
-#
-# Notes: Time is relative to the server and currently there is no way to
-#        coordinate server time with client time.  It is not recommended to
-#        use the absolute time version of the @time parameter unless you're
-#        sure you are on the same machine as the QEMU instance.
-#
-# Example:
-#
-# -> { "execute": "expire_password", "arguments": { "protocol": "vnc",
-#                                                   "time": "+60" } }
-# <- { "return": {} }
-#
-##
-{ 'command': 'expire_password', 'data': {'protocol': 'str', 'time': 'str'} }
-
-##
-# @change-vnc-password:
-#
-# Change the VNC server password.
-#
-# @password:  the new password to use with VNC authentication
-#
-# Since: 1.1
-#
-# Notes:  An empty password in this command will set the password to the empty
-#         string.  Existing clients are unaffected by executing this command.
-##
-{ 'command': 'change-vnc-password', 'data': {'password': 'str'} }
-
-##
 # @change:
 #
 # This command is multiple commands multiplexed together.
@@ -3839,133 +3343,6 @@
 { 'command': 'query-target', 'returns': 'TargetInfo' }
 
 ##
-# @QKeyCode:
-#
-# An enumeration of key name.
-#
-# This is used by the @send-key command.
-#
-# @unmapped: since 2.0
-# @pause: since 2.0
-# @ro: since 2.4
-# @kp_comma: since 2.4
-# @kp_equals: since 2.6
-# @power: since 2.6
-# @hiragana: since 2.9
-# @henkan: since 2.9
-# @yen: since 2.9
-#
-# @sleep: since 2.10
-# @wake: since 2.10
-# @audionext: since 2.10
-# @audioprev: since 2.10
-# @audiostop: since 2.10
-# @audioplay: since 2.10
-# @audiomute: since 2.10
-# @volumeup: since 2.10
-# @volumedown: since 2.10
-# @mediaselect: since 2.10
-# @mail: since 2.10
-# @calculator: since 2.10
-# @computer: since 2.10
-# @ac_home: since 2.10
-# @ac_back: since 2.10
-# @ac_forward: since 2.10
-# @ac_refresh: since 2.10
-# @ac_bookmarks: since 2.10
-# altgr, altgr_r: dropped in 2.10
-#
-# Since: 1.3.0
-#
-##
-{ 'enum': 'QKeyCode',
-  'data': [ 'unmapped',
-            'shift', 'shift_r', 'alt', 'alt_r', 'ctrl',
-            'ctrl_r', 'menu', 'esc', '1', '2', '3', '4', '5', '6', '7', '8',
-            '9', '0', 'minus', 'equal', 'backspace', 'tab', 'q', 'w', 'e',
-            'r', 't', 'y', 'u', 'i', 'o', 'p', 'bracket_left', 'bracket_right',
-            'ret', 'a', 's', 'd', 'f', 'g', 'h', 'j', 'k', 'l', 'semicolon',
-            'apostrophe', 'grave_accent', 'backslash', 'z', 'x', 'c', 'v', 'b',
-            'n', 'm', 'comma', 'dot', 'slash', 'asterisk', 'spc', 'caps_lock',
-            'f1', 'f2', 'f3', 'f4', 'f5', 'f6', 'f7', 'f8', 'f9', 'f10',
-            'num_lock', 'scroll_lock', 'kp_divide', 'kp_multiply',
-            'kp_subtract', 'kp_add', 'kp_enter', 'kp_decimal', 'sysrq', 'kp_0',
-            'kp_1', 'kp_2', 'kp_3', 'kp_4', 'kp_5', 'kp_6', 'kp_7', 'kp_8',
-            'kp_9', 'less', 'f11', 'f12', 'print', 'home', 'pgup', 'pgdn', 'end',
-            'left', 'up', 'down', 'right', 'insert', 'delete', 'stop', 'again',
-            'props', 'undo', 'front', 'copy', 'open', 'paste', 'find', 'cut',
-            'lf', 'help', 'meta_l', 'meta_r', 'compose', 'pause',
-            'ro', 'hiragana', 'henkan', 'yen',
-            'kp_comma', 'kp_equals', 'power', 'sleep', 'wake',
-            'audionext', 'audioprev', 'audiostop', 'audioplay', 'audiomute',
-            'volumeup', 'volumedown', 'mediaselect',
-            'mail', 'calculator', 'computer',
-            'ac_home', 'ac_back', 'ac_forward', 'ac_refresh', 'ac_bookmarks' ] }
-
-##
-# @KeyValue:
-#
-# Represents a keyboard key.
-#
-# Since: 1.3.0
-##
-{ 'union': 'KeyValue',
-  'data': {
-    'number': 'int',
-    'qcode': 'QKeyCode' } }
-
-##
-# @send-key:
-#
-# Send keys to guest.
-#
-# @keys: An array of @KeyValue elements. All @KeyValues in this array are
-#        simultaneously sent to the guest. A @KeyValue.number value is sent
-#        directly to the guest, while @KeyValue.qcode must be a valid
-#        @QKeyCode value
-#
-# @hold-time: time to delay key up events, milliseconds. Defaults
-#             to 100
-#
-# Returns: Nothing on success
-#          If key is unknown or redundant, InvalidParameter
-#
-# Since: 1.3.0
-#
-# Example:
-#
-# -> { "execute": "send-key",
-#      "arguments": { "keys": [ { "type": "qcode", "data": "ctrl" },
-#                               { "type": "qcode", "data": "alt" },
-#                               { "type": "qcode", "data": "delete" } ] } }
-# <- { "return": {} }
-#
-##
-{ 'command': 'send-key',
-  'data': { 'keys': ['KeyValue'], '*hold-time': 'int' } }
-
-##
-# @screendump:
-#
-# Write a PPM of the VGA screen to a file.
-#
-# @filename: the path of a new PPM file to store the image
-#
-# Returns: Nothing on success
-#
-# Since: 0.14.0
-#
-# Example:
-#
-# -> { "execute": "screendump",
-#      "arguments": { "filename": "/tmp/image" } }
-# <- { "return": {} }
-#
-##
-{ 'command': 'screendump', 'data': {'filename': 'str'} }
-
-
-##
 # @TpmModel:
 #
 # An enumeration of TPM models
@@ -4289,165 +3666,6 @@
 
 
 ##
-# @InputButton:
-#
-# Button of a pointer input device (mouse, tablet).
-#
-# @side: front side button of a 5-button mouse (since 2.9)
-#
-# @extra: rear side button of a 5-button mouse (since 2.9)
-#
-# Since: 2.0
-##
-{ 'enum'  : 'InputButton',
-  'data'  : [ 'left', 'middle', 'right', 'wheel-up', 'wheel-down', 'side',
-  'extra' ] }
-
-##
-# @InputAxis:
-#
-# Position axis of a pointer input device (mouse, tablet).
-#
-# Since: 2.0
-##
-{ 'enum'  : 'InputAxis',
-  'data'  : [ 'x', 'y' ] }
-
-##
-# @InputKeyEvent:
-#
-# Keyboard input event.
-#
-# @key:    Which key this event is for.
-# @down:   True for key-down and false for key-up events.
-#
-# Since: 2.0
-##
-{ 'struct'  : 'InputKeyEvent',
-  'data'  : { 'key'     : 'KeyValue',
-              'down'    : 'bool' } }
-
-##
-# @InputBtnEvent:
-#
-# Pointer button input event.
-#
-# @button: Which button this event is for.
-# @down:   True for key-down and false for key-up events.
-#
-# Since: 2.0
-##
-{ 'struct'  : 'InputBtnEvent',
-  'data'  : { 'button'  : 'InputButton',
-              'down'    : 'bool' } }
-
-##
-# @InputMoveEvent:
-#
-# Pointer motion input event.
-#
-# @axis:   Which axis is referenced by @value.
-# @value:  Pointer position.  For absolute coordinates the
-#          valid range is 0 -> 0x7ffff
-#
-# Since: 2.0
-##
-{ 'struct'  : 'InputMoveEvent',
-  'data'  : { 'axis'    : 'InputAxis',
-              'value'   : 'int' } }
-
-##
-# @InputEvent:
-#
-# Input event union.
-#
-# @type: the input type, one of:
-#  - 'key': Input event of Keyboard
-#  - 'btn': Input event of pointer buttons
-#  - 'rel': Input event of relative pointer motion
-#  - 'abs': Input event of absolute pointer motion
-#
-# Since: 2.0
-##
-{ 'union' : 'InputEvent',
-  'data'  : { 'key'     : 'InputKeyEvent',
-              'btn'     : 'InputBtnEvent',
-              'rel'     : 'InputMoveEvent',
-              'abs'     : 'InputMoveEvent' } }
-
-##
-# @input-send-event:
-#
-# Send input event(s) to guest.
-#
-# @device: display device to send event(s) to.
-# @head: head to send event(s) to, in case the
-#        display device supports multiple scanouts.
-# @events: List of InputEvent union.
-#
-# Returns: Nothing on success.
-#
-# The @device and @head parameters can be used to send the input event
-# to specific input devices in case (a) multiple input devices of the
-# same kind are added to the virtual machine and (b) you have
-# configured input routing (see docs/multiseat.txt) for those input
-# devices.  The parameters work exactly like the device and head
-# properties of input devices.  If @device is missing, only devices
-# that have no input routing config are admissible.  If @device is
-# specified, both input devices with and without input routing config
-# are admissible, but devices with input routing config take
-# precedence.
-#
-# Since: 2.6
-#
-# Note: The consoles are visible in the qom tree, under
-# /backend/console[$index]. They have a device link and head property,
-# so it is possible to map which console belongs to which device and
-# display.
-#
-# Example:
-#
-# 1. Press left mouse button.
-#
-# -> { "execute": "input-send-event",
-#     "arguments": { "device": "video0",
-#                    "events": [ { "type": "btn",
-#                    "data" : { "down": true, "button": "left" } } ] } }
-# <- { "return": {} }
-#
-# -> { "execute": "input-send-event",
-#     "arguments": { "device": "video0",
-#                    "events": [ { "type": "btn",
-#                    "data" : { "down": false, "button": "left" } } ] } }
-# <- { "return": {} }
-#
-# 2. Press ctrl-alt-del.
-#
-# -> { "execute": "input-send-event",
-#      "arguments": { "events": [
-#         { "type": "key", "data" : { "down": true,
-#           "key": {"type": "qcode", "data": "ctrl" } } },
-#         { "type": "key", "data" : { "down": true,
-#           "key": {"type": "qcode", "data": "alt" } } },
-#         { "type": "key", "data" : { "down": true,
-#           "key": {"type": "qcode", "data": "delete" } } } ] } }
-# <- { "return": {} }
-#
-# 3. Move mouse pointer to absolute coordinates (20000, 400).
-#
-# -> { "execute": "input-send-event" ,
-#   "arguments": { "events": [
-#                { "type": "abs", "data" : { "axis": "x", "value" : 20000 } },
-#                { "type": "abs", "data" : { "axis": "y", "value" : 400 } } ] } }
-# <- { "return": {} }
-#
-##
-{ 'command': 'input-send-event',
-  'data': { '*device': 'str',
-            '*head'  : 'int',
-            'events' : [ 'InputEvent' ] } }
-
-##
 # @NumaOptionsType:
 #
 # @node: NUMA nodes configuration
diff --git a/qapi/event.json b/qapi/event.json
index 4b32773..f49bd3d 100644
--- a/qapi/event.json
+++ b/qapi/event.json
@@ -51,181 +51,6 @@
   'data': { '*device': 'str', 'path': 'str' } }
 
 ##
-# @VNC_CONNECTED:
-#
-# Emitted when a VNC client establishes a connection
-#
-# @server: server information
-#
-# @client: client information
-#
-# Note: This event is emitted before any authentication takes place, thus
-# the authentication ID is not provided
-#
-# Since: 0.13.0
-#
-# Example:
-#
-# <- { "event": "VNC_CONNECTED",
-#      "data": {
-#            "server": { "auth": "sasl", "family": "ipv4",
-#                        "service": "5901", "host": "0.0.0.0" },
-#            "client": { "family": "ipv4", "service": "58425",
-#                        "host": "127.0.0.1" } },
-#      "timestamp": { "seconds": 1262976601, "microseconds": 975795 } }
-#
-##
-{ 'event': 'VNC_CONNECTED',
-  'data': { 'server': 'VncServerInfo',
-            'client': 'VncBasicInfo' } }
-
-##
-# @VNC_INITIALIZED:
-#
-# Emitted after authentication takes place (if any) and the VNC session is
-# made active
-#
-# @server: server information
-#
-# @client: client information
-#
-# Since: 0.13.0
-#
-# Example:
-#
-# <-  { "event": "VNC_INITIALIZED",
-#       "data": {
-#            "server": { "auth": "sasl", "family": "ipv4",
-#                        "service": "5901", "host": "0.0.0.0"},
-#            "client": { "family": "ipv4", "service": "46089",
-#                        "host": "127.0.0.1", "sasl_username": "luiz" } },
-#       "timestamp": { "seconds": 1263475302, "microseconds": 150772 } }
-#
-##
-{ 'event': 'VNC_INITIALIZED',
-  'data': { 'server': 'VncServerInfo',
-            'client': 'VncClientInfo' } }
-
-##
-# @VNC_DISCONNECTED:
-#
-# Emitted when the connection is closed
-#
-# @server: server information
-#
-# @client: client information
-#
-# Since: 0.13.0
-#
-# Example:
-#
-# <- { "event": "VNC_DISCONNECTED",
-#      "data": {
-#            "server": { "auth": "sasl", "family": "ipv4",
-#                        "service": "5901", "host": "0.0.0.0" },
-#            "client": { "family": "ipv4", "service": "58425",
-#                        "host": "127.0.0.1", "sasl_username": "luiz" } },
-#      "timestamp": { "seconds": 1262976601, "microseconds": 975795 } }
-#
-##
-{ 'event': 'VNC_DISCONNECTED',
-  'data': { 'server': 'VncServerInfo',
-            'client': 'VncClientInfo' } }
-
-##
-# @SPICE_CONNECTED:
-#
-# Emitted when a SPICE client establishes a connection
-#
-# @server: server information
-#
-# @client: client information
-#
-# Since: 0.14.0
-#
-# Example:
-#
-# <- { "timestamp": {"seconds": 1290688046, "microseconds": 388707},
-#      "event": "SPICE_CONNECTED",
-#      "data": {
-#        "server": { "port": "5920", "family": "ipv4", "host": "127.0.0.1"},
-#        "client": {"port": "52873", "family": "ipv4", "host": "127.0.0.1"}
-#    }}
-#
-##
-{ 'event': 'SPICE_CONNECTED',
-  'data': { 'server': 'SpiceBasicInfo',
-            'client': 'SpiceBasicInfo' } }
-
-##
-# @SPICE_INITIALIZED:
-#
-# Emitted after initial handshake and authentication takes place (if any)
-# and the SPICE channel is up and running
-#
-# @server: server information
-#
-# @client: client information
-#
-# Since: 0.14.0
-#
-# Example:
-#
-# <- { "timestamp": {"seconds": 1290688046, "microseconds": 417172},
-#      "event": "SPICE_INITIALIZED",
-#      "data": {"server": {"auth": "spice", "port": "5921",
-#                          "family": "ipv4", "host": "127.0.0.1"},
-#               "client": {"port": "49004", "family": "ipv4", "channel-type": 3,
-#                          "connection-id": 1804289383, "host": "127.0.0.1",
-#                          "channel-id": 0, "tls": true}
-#    }}
-#
-##
-{ 'event': 'SPICE_INITIALIZED',
-  'data': { 'server': 'SpiceServerInfo',
-            'client': 'SpiceChannel' } }
-
-##
-# @SPICE_DISCONNECTED:
-#
-# Emitted when the SPICE connection is closed
-#
-# @server: server information
-#
-# @client: client information
-#
-# Since: 0.14.0
-#
-# Example:
-#
-# <- { "timestamp": {"seconds": 1290688046, "microseconds": 388707},
-#      "event": "SPICE_DISCONNECTED",
-#      "data": {
-#        "server": { "port": "5920", "family": "ipv4", "host": "127.0.0.1"},
-#        "client": {"port": "52873", "family": "ipv4", "host": "127.0.0.1"}
-#    }}
-#
-##
-{ 'event': 'SPICE_DISCONNECTED',
-  'data': { 'server': 'SpiceBasicInfo',
-            'client': 'SpiceBasicInfo' } }
-
-##
-# @SPICE_MIGRATE_COMPLETED:
-#
-# Emitted when SPICE migration has completed
-#
-# Since: 1.3
-#
-# Example:
-#
-# <- { "timestamp": {"seconds": 1290688046, "microseconds": 417172},
-#      "event": "SPICE_MIGRATE_COMPLETED" }
-#
-##
-{ 'event': 'SPICE_MIGRATE_COMPLETED' }
-
-##
 # @MIGRATION:
 #
 # Emitted when a migration event happens
diff --git a/qapi/ui.json b/qapi/ui.json
new file mode 100644
index 0000000..e5d6610
--- /dev/null
+++ b/qapi/ui.json
@@ -0,0 +1,977 @@
+# -*- Mode: Python -*-
+#
+
+##
+# = Remote desktop
+##
+
+{ 'include': 'sockets.json' }
+
+##
+# @set_password:
+#
+# Sets the password of a remote display session.
+#
+# @protocol: `vnc' to modify the VNC server password
+#            `spice' to modify the Spice server password
+#
+# @password: the new password
+#
+# @connected: how to handle existing clients when changing the
+#                       password.  If nothing is specified, defaults to `keep'
+#                       `fail' to fail the command if clients are connected
+#                       `disconnect' to disconnect existing clients
+#                       `keep' to maintain existing clients
+#
+# Returns: Nothing on success
+#          If Spice is not enabled, DeviceNotFound
+#
+# Since: 0.14.0
+#
+# Example:
+#
+# -> { "execute": "set_password", "arguments": { "protocol": "vnc",
+#                                                "password": "secret" } }
+# <- { "return": {} }
+#
+##
+{ 'command': 'set_password',
+  'data': {'protocol': 'str', 'password': 'str', '*connected': 'str'} }
+
+##
+# @expire_password:
+#
+# Expire the password of a remote display server.
+#
+# @protocol: the name of the remote display protocol `vnc' or `spice'
+#
+# @time: when to expire the password.
+#        `now' to expire the password immediately
+#        `never' to cancel password expiration
+#        `+INT' where INT is the number of seconds from now (integer)
+#        `INT' where INT is the absolute time in seconds
+#
+# Returns: Nothing on success
+#          If @protocol is `spice' and Spice is not active, DeviceNotFound
+#
+# Since: 0.14.0
+#
+# Notes: Time is relative to the server and currently there is no way to
+#        coordinate server time with client time.  It is not recommended to
+#        use the absolute time version of the @time parameter unless you're
+#        sure you are on the same machine as the QEMU instance.
+#
+# Example:
+#
+# -> { "execute": "expire_password", "arguments": { "protocol": "vnc",
+#                                                   "time": "+60" } }
+# <- { "return": {} }
+#
+##
+{ 'command': 'expire_password', 'data': {'protocol': 'str', 'time': 'str'} }
+
+##
+# @screendump:
+#
+# Write a PPM of the VGA screen to a file.
+#
+# @filename: the path of a new PPM file to store the image
+#
+# Returns: Nothing on success
+#
+# Since: 0.14.0
+#
+# Example:
+#
+# -> { "execute": "screendump",
+#      "arguments": { "filename": "/tmp/image" } }
+# <- { "return": {} }
+#
+##
+{ 'command': 'screendump', 'data': {'filename': 'str'} }
+
+##
+# == Spice
+##
+
+##
+# @SpiceBasicInfo:
+#
+# The basic information for SPICE network connection
+#
+# @host: IP address
+#
+# @port: port number
+#
+# @family: address family
+#
+# Since: 2.1
+##
+{ 'struct': 'SpiceBasicInfo',
+  'data': { 'host': 'str',
+            'port': 'str',
+            'family': 'NetworkAddressFamily' } }
+
+##
+# @SpiceServerInfo:
+#
+# Information about a SPICE server
+#
+# @auth: authentication method
+#
+# Since: 2.1
+##
+{ 'struct': 'SpiceServerInfo',
+  'base': 'SpiceBasicInfo',
+  'data': { '*auth': 'str' } }
+
+##
+# @SpiceChannel:
+#
+# Information about a SPICE client channel.
+#
+# @connection-id: SPICE connection id number.  All channels with the same id
+#                 belong to the same SPICE session.
+#
+# @channel-type: SPICE channel type number.  "1" is the main control
+#                channel, filter for this one if you want to track spice
+#                sessions only
+#
+# @channel-id: SPICE channel ID number.  Usually "0", might be different when
+#              multiple channels of the same type exist, such as multiple
+#              display channels in a multihead setup
+#
+# @tls: true if the channel is encrypted, false otherwise.
+#
+# Since: 0.14.0
+##
+{ 'struct': 'SpiceChannel',
+  'base': 'SpiceBasicInfo',
+  'data': {'connection-id': 'int', 'channel-type': 'int', 'channel-id': 'int',
+           'tls': 'bool'} }
+
+##
+# @SpiceQueryMouseMode:
+#
+# An enumeration of Spice mouse states.
+#
+# @client: Mouse cursor position is determined by the client.
+#
+# @server: Mouse cursor position is determined by the server.
+#
+# @unknown: No information is available about mouse mode used by
+#           the spice server.
+#
+# Note: spice/enums.h has a SpiceMouseMode already, hence the name.
+#
+# Since: 1.1
+##
+{ 'enum': 'SpiceQueryMouseMode',
+  'data': [ 'client', 'server', 'unknown' ] }
+
+##
+# @SpiceInfo:
+#
+# Information about the SPICE session.
+#
+# @enabled: true if the SPICE server is enabled, false otherwise
+#
+# @migrated: true if the last guest migration completed and spice
+#            migration had completed as well. false otherwise. (since 1.4)
+#
+# @host: The hostname the SPICE server is bound to.  This depends on
+#        the name resolution on the host and may be an IP address.
+#
+# @port: The SPICE server's port number.
+#
+# @compiled-version: SPICE server version.
+#
+# @tls-port: The SPICE server's TLS port number.
+#
+# @auth: the current authentication type used by the server
+#        'none'  if no authentication is being used
+#        'spice' uses SASL or direct TLS authentication, depending on command
+#                line options
+#
+# @mouse-mode: The mode in which the mouse cursor is displayed currently. Can
+#              be determined by the client or the server, or unknown if spice
+#              server doesn't provide this information. (since: 1.1)
+#
+# @channels: a list of @SpiceChannel for each active spice channel
+#
+# Since: 0.14.0
+##
+{ 'struct': 'SpiceInfo',
+  'data': {'enabled': 'bool', 'migrated': 'bool', '*host': 'str', '*port': 'int',
+           '*tls-port': 'int', '*auth': 'str', '*compiled-version': 'str',
+           'mouse-mode': 'SpiceQueryMouseMode', '*channels': ['SpiceChannel']} }
+
+##
+# @query-spice:
+#
+# Returns information about the current SPICE server
+#
+# Returns: @SpiceInfo
+#
+# Since: 0.14.0
+#
+# Example:
+#
+# -> { "execute": "query-spice" }
+# <- { "return": {
+#          "enabled": true,
+#          "auth": "spice",
+#          "port": 5920,
+#          "tls-port": 5921,
+#          "host": "0.0.0.0",
+#          "channels": [
+#             {
+#                "port": "54924",
+#                "family": "ipv4",
+#                "channel-type": 1,
+#                "connection-id": 1804289383,
+#                "host": "127.0.0.1",
+#                "channel-id": 0,
+#                "tls": true
+#             },
+#             {
+#                "port": "36710",
+#                "family": "ipv4",
+#                "channel-type": 4,
+#                "connection-id": 1804289383,
+#                "host": "127.0.0.1",
+#                "channel-id": 0,
+#                "tls": false
+#             },
+#             [ ... more channels follow ... ]
+#          ]
+#       }
+#    }
+#
+##
+{ 'command': 'query-spice', 'returns': 'SpiceInfo' }
+
+##
+# @SPICE_CONNECTED:
+#
+# Emitted when a SPICE client establishes a connection
+#
+# @server: server information
+#
+# @client: client information
+#
+# Since: 0.14.0
+#
+# Example:
+#
+# <- { "timestamp": {"seconds": 1290688046, "microseconds": 388707},
+#      "event": "SPICE_CONNECTED",
+#      "data": {
+#        "server": { "port": "5920", "family": "ipv4", "host": "127.0.0.1"},
+#        "client": {"port": "52873", "family": "ipv4", "host": "127.0.0.1"}
+#    }}
+#
+##
+{ 'event': 'SPICE_CONNECTED',
+  'data': { 'server': 'SpiceBasicInfo',
+            'client': 'SpiceBasicInfo' } }
+
+##
+# @SPICE_INITIALIZED:
+#
+# Emitted after initial handshake and authentication takes place (if any)
+# and the SPICE channel is up and running
+#
+# @server: server information
+#
+# @client: client information
+#
+# Since: 0.14.0
+#
+# Example:
+#
+# <- { "timestamp": {"seconds": 1290688046, "microseconds": 417172},
+#      "event": "SPICE_INITIALIZED",
+#      "data": {"server": {"auth": "spice", "port": "5921",
+#                          "family": "ipv4", "host": "127.0.0.1"},
+#               "client": {"port": "49004", "family": "ipv4", "channel-type": 3,
+#                          "connection-id": 1804289383, "host": "127.0.0.1",
+#                          "channel-id": 0, "tls": true}
+#    }}
+#
+##
+{ 'event': 'SPICE_INITIALIZED',
+  'data': { 'server': 'SpiceServerInfo',
+            'client': 'SpiceChannel' } }
+
+##
+# @SPICE_DISCONNECTED:
+#
+# Emitted when the SPICE connection is closed
+#
+# @server: server information
+#
+# @client: client information
+#
+# Since: 0.14.0
+#
+# Example:
+#
+# <- { "timestamp": {"seconds": 1290688046, "microseconds": 388707},
+#      "event": "SPICE_DISCONNECTED",
+#      "data": {
+#        "server": { "port": "5920", "family": "ipv4", "host": "127.0.0.1"},
+#        "client": {"port": "52873", "family": "ipv4", "host": "127.0.0.1"}
+#    }}
+#
+##
+{ 'event': 'SPICE_DISCONNECTED',
+  'data': { 'server': 'SpiceBasicInfo',
+            'client': 'SpiceBasicInfo' } }
+
+##
+# @SPICE_MIGRATE_COMPLETED:
+#
+# Emitted when SPICE migration has completed
+#
+# Since: 1.3
+#
+# Example:
+#
+# <- { "timestamp": {"seconds": 1290688046, "microseconds": 417172},
+#      "event": "SPICE_MIGRATE_COMPLETED" }
+#
+##
+{ 'event': 'SPICE_MIGRATE_COMPLETED' }
+
+##
+# == VNC
+##
+
+##
+# @VncBasicInfo:
+#
+# The basic information for vnc network connection
+#
+# @host: IP address
+#
+# @service: The service name of the vnc port. This may depend on the host
+#           system's service database so symbolic names should not be relied
+#           on.
+#
+# @family: address family
+#
+# @websocket: true in case the socket is a websocket (since 2.3).
+#
+# Since: 2.1
+##
+{ 'struct': 'VncBasicInfo',
+  'data': { 'host': 'str',
+            'service': 'str',
+            'family': 'NetworkAddressFamily',
+            'websocket': 'bool' } }
+
+##
+# @VncServerInfo:
+#
+# The network connection information for server
+#
+# @auth: authentication method used for
+#        the plain (non-websocket) VNC server
+#
+# Since: 2.1
+##
+{ 'struct': 'VncServerInfo',
+  'base': 'VncBasicInfo',
+  'data': { '*auth': 'str' } }
+
+##
+# @VncClientInfo:
+#
+# Information about a connected VNC client.
+#
+# @x509_dname: If x509 authentication is in use, the Distinguished
+#              Name of the client.
+#
+# @sasl_username: If SASL authentication is in use, the SASL username
+#                 used for authentication.
+#
+# Since: 0.14.0
+##
+{ 'struct': 'VncClientInfo',
+  'base': 'VncBasicInfo',
+  'data': { '*x509_dname': 'str', '*sasl_username': 'str' } }
+
+##
+# @VncInfo:
+#
+# Information about the VNC session.
+#
+# @enabled: true if the VNC server is enabled, false otherwise
+#
+# @host: The hostname the VNC server is bound to.  This depends on
+#        the name resolution on the host and may be an IP address.
+#
+# @family: 'ipv6' if the host is listening for IPv6 connections
+#                    'ipv4' if the host is listening for IPv4 connections
+#                    'unix' if the host is listening on a unix domain socket
+#                    'unknown' otherwise
+#
+# @service: The service name of the server's port.  This may depends
+#           on the host system's service database so symbolic names should not
+#           be relied on.
+#
+# @auth: the current authentication type used by the server
+#        'none' if no authentication is being used
+#        'vnc' if VNC authentication is being used
+#        'vencrypt+plain' if VEncrypt is used with plain text authentication
+#        'vencrypt+tls+none' if VEncrypt is used with TLS and no authentication
+#        'vencrypt+tls+vnc' if VEncrypt is used with TLS and VNC authentication
+#        'vencrypt+tls+plain' if VEncrypt is used with TLS and plain text auth
+#        'vencrypt+x509+none' if VEncrypt is used with x509 and no auth
+#        'vencrypt+x509+vnc' if VEncrypt is used with x509 and VNC auth
+#        'vencrypt+x509+plain' if VEncrypt is used with x509 and plain text auth
+#        'vencrypt+tls+sasl' if VEncrypt is used with TLS and SASL auth
+#        'vencrypt+x509+sasl' if VEncrypt is used with x509 and SASL auth
+#
+# @clients: a list of @VncClientInfo of all currently connected clients
+#
+# Since: 0.14.0
+##
+{ 'struct': 'VncInfo',
+  'data': {'enabled': 'bool', '*host': 'str',
+           '*family': 'NetworkAddressFamily',
+           '*service': 'str', '*auth': 'str', '*clients': ['VncClientInfo']} }
+
+##
+# @VncPrimaryAuth:
+#
+# vnc primary authentication method.
+#
+# Since: 2.3
+##
+{ 'enum': 'VncPrimaryAuth',
+  'data': [ 'none', 'vnc', 'ra2', 'ra2ne', 'tight', 'ultra',
+            'tls', 'vencrypt', 'sasl' ] }
+
+##
+# @VncVencryptSubAuth:
+#
+# vnc sub authentication method with vencrypt.
+#
+# Since: 2.3
+##
+{ 'enum': 'VncVencryptSubAuth',
+  'data': [ 'plain',
+            'tls-none',  'x509-none',
+            'tls-vnc',   'x509-vnc',
+            'tls-plain', 'x509-plain',
+            'tls-sasl',  'x509-sasl' ] }
+
+
+##
+# @VncServerInfo2:
+#
+# The network connection information for server
+#
+# @auth: The current authentication type used by the servers
+#
+# @vencrypt: The vencrypt sub authentication type used by the
+#            servers, only specified in case auth == vencrypt.
+#
+# Since: 2.9
+##
+{ 'struct': 'VncServerInfo2',
+  'base': 'VncBasicInfo',
+  'data': { 'auth'      : 'VncPrimaryAuth',
+            '*vencrypt' : 'VncVencryptSubAuth' } }
+
+
+##
+# @VncInfo2:
+#
+# Information about a vnc server
+#
+# @id: vnc server name.
+#
+# @server: A list of @VncBasincInfo describing all listening sockets.
+#          The list can be empty (in case the vnc server is disabled).
+#          It also may have multiple entries: normal + websocket,
+#          possibly also ipv4 + ipv6 in the future.
+#
+# @clients: A list of @VncClientInfo of all currently connected clients.
+#           The list can be empty, for obvious reasons.
+#
+# @auth: The current authentication type used by the non-websockets servers
+#
+# @vencrypt: The vencrypt authentication type used by the servers,
+#            only specified in case auth == vencrypt.
+#
+# @display: The display device the vnc server is linked to.
+#
+# Since: 2.3
+##
+{ 'struct': 'VncInfo2',
+  'data': { 'id'        : 'str',
+            'server'    : ['VncServerInfo2'],
+            'clients'   : ['VncClientInfo'],
+            'auth'      : 'VncPrimaryAuth',
+            '*vencrypt' : 'VncVencryptSubAuth',
+            '*display'  : 'str' } }
+
+##
+# @query-vnc:
+#
+# Returns information about the current VNC server
+#
+# Returns: @VncInfo
+#
+# Since: 0.14.0
+#
+# Example:
+#
+# -> { "execute": "query-vnc" }
+# <- { "return": {
+#          "enabled":true,
+#          "host":"0.0.0.0",
+#          "service":"50402",
+#          "auth":"vnc",
+#          "family":"ipv4",
+#          "clients":[
+#             {
+#                "host":"127.0.0.1",
+#                "service":"50401",
+#                "family":"ipv4"
+#             }
+#          ]
+#       }
+#    }
+#
+##
+{ 'command': 'query-vnc', 'returns': 'VncInfo' }
+
+##
+# @query-vnc-servers:
+#
+# Returns a list of vnc servers.  The list can be empty.
+#
+# Returns: a list of @VncInfo2
+#
+# Since: 2.3
+##
+{ 'command': 'query-vnc-servers', 'returns': ['VncInfo2'] }
+
+##
+# @change-vnc-password:
+#
+# Change the VNC server password.
+#
+# @password:  the new password to use with VNC authentication
+#
+# Since: 1.1
+#
+# Notes:  An empty password in this command will set the password to the empty
+#         string.  Existing clients are unaffected by executing this command.
+##
+{ 'command': 'change-vnc-password', 'data': {'password': 'str'} }
+
+##
+# @VNC_CONNECTED:
+#
+# Emitted when a VNC client establishes a connection
+#
+# @server: server information
+#
+# @client: client information
+#
+# Note: This event is emitted before any authentication takes place, thus
+# the authentication ID is not provided
+#
+# Since: 0.13.0
+#
+# Example:
+#
+# <- { "event": "VNC_CONNECTED",
+#      "data": {
+#            "server": { "auth": "sasl", "family": "ipv4",
+#                        "service": "5901", "host": "0.0.0.0" },
+#            "client": { "family": "ipv4", "service": "58425",
+#                        "host": "127.0.0.1" } },
+#      "timestamp": { "seconds": 1262976601, "microseconds": 975795 } }
+#
+##
+{ 'event': 'VNC_CONNECTED',
+  'data': { 'server': 'VncServerInfo',
+            'client': 'VncBasicInfo' } }
+
+##
+# @VNC_INITIALIZED:
+#
+# Emitted after authentication takes place (if any) and the VNC session is
+# made active
+#
+# @server: server information
+#
+# @client: client information
+#
+# Since: 0.13.0
+#
+# Example:
+#
+# <-  { "event": "VNC_INITIALIZED",
+#       "data": {
+#            "server": { "auth": "sasl", "family": "ipv4",
+#                        "service": "5901", "host": "0.0.0.0"},
+#            "client": { "family": "ipv4", "service": "46089",
+#                        "host": "127.0.0.1", "sasl_username": "luiz" } },
+#       "timestamp": { "seconds": 1263475302, "microseconds": 150772 } }
+#
+##
+{ 'event': 'VNC_INITIALIZED',
+  'data': { 'server': 'VncServerInfo',
+            'client': 'VncClientInfo' } }
+
+##
+# @VNC_DISCONNECTED:
+#
+# Emitted when the connection is closed
+#
+# @server: server information
+#
+# @client: client information
+#
+# Since: 0.13.0
+#
+# Example:
+#
+# <- { "event": "VNC_DISCONNECTED",
+#      "data": {
+#            "server": { "auth": "sasl", "family": "ipv4",
+#                        "service": "5901", "host": "0.0.0.0" },
+#            "client": { "family": "ipv4", "service": "58425",
+#                        "host": "127.0.0.1", "sasl_username": "luiz" } },
+#      "timestamp": { "seconds": 1262976601, "microseconds": 975795 } }
+#
+##
+{ 'event': 'VNC_DISCONNECTED',
+  'data': { 'server': 'VncServerInfo',
+            'client': 'VncClientInfo' } }
+
+##
+# = Input
+##
+
+##
+# @MouseInfo:
+#
+# Information about a mouse device.
+#
+# @name: the name of the mouse device
+#
+# @index: the index of the mouse device
+#
+# @current: true if this device is currently receiving mouse events
+#
+# @absolute: true if this device supports absolute coordinates as input
+#
+# Since: 0.14.0
+##
+{ 'struct': 'MouseInfo',
+  'data': {'name': 'str', 'index': 'int', 'current': 'bool',
+           'absolute': 'bool'} }
+
+##
+# @query-mice:
+#
+# Returns information about each active mouse device
+#
+# Returns: a list of @MouseInfo for each device
+#
+# Since: 0.14.0
+#
+# Example:
+#
+# -> { "execute": "query-mice" }
+# <- { "return": [
+#          {
+#             "name":"QEMU Microsoft Mouse",
+#             "index":0,
+#             "current":false,
+#             "absolute":false
+#          },
+#          {
+#             "name":"QEMU PS/2 Mouse",
+#             "index":1,
+#             "current":true,
+#             "absolute":true
+#          }
+#       ]
+#    }
+#
+##
+{ 'command': 'query-mice', 'returns': ['MouseInfo'] }
+
+##
+# @QKeyCode:
+#
+# An enumeration of key name.
+#
+# This is used by the @send-key command.
+#
+# @unmapped: since 2.0
+# @pause: since 2.0
+# @ro: since 2.4
+# @kp_comma: since 2.4
+# @kp_equals: since 2.6
+# @power: since 2.6
+# @hiragana: since 2.9
+# @henkan: since 2.9
+# @yen: since 2.9
+#
+# @sleep: since 2.10
+# @wake: since 2.10
+# @audionext: since 2.10
+# @audioprev: since 2.10
+# @audiostop: since 2.10
+# @audioplay: since 2.10
+# @audiomute: since 2.10
+# @volumeup: since 2.10
+# @volumedown: since 2.10
+# @mediaselect: since 2.10
+# @mail: since 2.10
+# @calculator: since 2.10
+# @computer: since 2.10
+# @ac_home: since 2.10
+# @ac_back: since 2.10
+# @ac_forward: since 2.10
+# @ac_refresh: since 2.10
+# @ac_bookmarks: since 2.10
+# altgr, altgr_r: dropped in 2.10
+#
+# Since: 1.3.0
+#
+##
+{ 'enum': 'QKeyCode',
+  'data': [ 'unmapped',
+            'shift', 'shift_r', 'alt', 'alt_r', 'ctrl',
+            'ctrl_r', 'menu', 'esc', '1', '2', '3', '4', '5', '6', '7', '8',
+            '9', '0', 'minus', 'equal', 'backspace', 'tab', 'q', 'w', 'e',
+            'r', 't', 'y', 'u', 'i', 'o', 'p', 'bracket_left', 'bracket_right',
+            'ret', 'a', 's', 'd', 'f', 'g', 'h', 'j', 'k', 'l', 'semicolon',
+            'apostrophe', 'grave_accent', 'backslash', 'z', 'x', 'c', 'v', 'b',
+            'n', 'm', 'comma', 'dot', 'slash', 'asterisk', 'spc', 'caps_lock',
+            'f1', 'f2', 'f3', 'f4', 'f5', 'f6', 'f7', 'f8', 'f9', 'f10',
+            'num_lock', 'scroll_lock', 'kp_divide', 'kp_multiply',
+            'kp_subtract', 'kp_add', 'kp_enter', 'kp_decimal', 'sysrq', 'kp_0',
+            'kp_1', 'kp_2', 'kp_3', 'kp_4', 'kp_5', 'kp_6', 'kp_7', 'kp_8',
+            'kp_9', 'less', 'f11', 'f12', 'print', 'home', 'pgup', 'pgdn', 'end',
+            'left', 'up', 'down', 'right', 'insert', 'delete', 'stop', 'again',
+            'props', 'undo', 'front', 'copy', 'open', 'paste', 'find', 'cut',
+            'lf', 'help', 'meta_l', 'meta_r', 'compose', 'pause',
+            'ro', 'hiragana', 'henkan', 'yen',
+            'kp_comma', 'kp_equals', 'power', 'sleep', 'wake',
+            'audionext', 'audioprev', 'audiostop', 'audioplay', 'audiomute',
+            'volumeup', 'volumedown', 'mediaselect',
+            'mail', 'calculator', 'computer',
+            'ac_home', 'ac_back', 'ac_forward', 'ac_refresh', 'ac_bookmarks' ] }
+
+##
+# @KeyValue:
+#
+# Represents a keyboard key.
+#
+# Since: 1.3.0
+##
+{ 'union': 'KeyValue',
+  'data': {
+    'number': 'int',
+    'qcode': 'QKeyCode' } }
+
+##
+# @send-key:
+#
+# Send keys to guest.
+#
+# @keys: An array of @KeyValue elements. All @KeyValues in this array are
+#        simultaneously sent to the guest. A @KeyValue.number value is sent
+#        directly to the guest, while @KeyValue.qcode must be a valid
+#        @QKeyCode value
+#
+# @hold-time: time to delay key up events, milliseconds. Defaults
+#             to 100
+#
+# Returns: Nothing on success
+#          If key is unknown or redundant, InvalidParameter
+#
+# Since: 1.3.0
+#
+# Example:
+#
+# -> { "execute": "send-key",
+#      "arguments": { "keys": [ { "type": "qcode", "data": "ctrl" },
+#                               { "type": "qcode", "data": "alt" },
+#                               { "type": "qcode", "data": "delete" } ] } }
+# <- { "return": {} }
+#
+##
+{ 'command': 'send-key',
+  'data': { 'keys': ['KeyValue'], '*hold-time': 'int' } }
+
+##
+# @InputButton:
+#
+# Button of a pointer input device (mouse, tablet).
+#
+# @side: front side button of a 5-button mouse (since 2.9)
+#
+# @extra: rear side button of a 5-button mouse (since 2.9)
+#
+# Since: 2.0
+##
+{ 'enum'  : 'InputButton',
+  'data'  : [ 'left', 'middle', 'right', 'wheel-up', 'wheel-down', 'side',
+  'extra' ] }
+
+##
+# @InputAxis:
+#
+# Position axis of a pointer input device (mouse, tablet).
+#
+# Since: 2.0
+##
+{ 'enum'  : 'InputAxis',
+  'data'  : [ 'x', 'y' ] }
+
+##
+# @InputKeyEvent:
+#
+# Keyboard input event.
+#
+# @key:    Which key this event is for.
+# @down:   True for key-down and false for key-up events.
+#
+# Since: 2.0
+##
+{ 'struct'  : 'InputKeyEvent',
+  'data'  : { 'key'     : 'KeyValue',
+              'down'    : 'bool' } }
+
+##
+# @InputBtnEvent:
+#
+# Pointer button input event.
+#
+# @button: Which button this event is for.
+# @down:   True for key-down and false for key-up events.
+#
+# Since: 2.0
+##
+{ 'struct'  : 'InputBtnEvent',
+  'data'  : { 'button'  : 'InputButton',
+              'down'    : 'bool' } }
+
+##
+# @InputMoveEvent:
+#
+# Pointer motion input event.
+#
+# @axis:   Which axis is referenced by @value.
+# @value:  Pointer position.  For absolute coordinates the
+#          valid range is 0 -> 0x7ffff
+#
+# Since: 2.0
+##
+{ 'struct'  : 'InputMoveEvent',
+  'data'  : { 'axis'    : 'InputAxis',
+              'value'   : 'int' } }
+
+##
+# @InputEvent:
+#
+# Input event union.
+#
+# @type: the input type, one of:
+#  - 'key': Input event of Keyboard
+#  - 'btn': Input event of pointer buttons
+#  - 'rel': Input event of relative pointer motion
+#  - 'abs': Input event of absolute pointer motion
+#
+# Since: 2.0
+##
+{ 'union' : 'InputEvent',
+  'data'  : { 'key'     : 'InputKeyEvent',
+              'btn'     : 'InputBtnEvent',
+              'rel'     : 'InputMoveEvent',
+              'abs'     : 'InputMoveEvent' } }
+
+##
+# @input-send-event:
+#
+# Send input event(s) to guest.
+#
+# @device: display device to send event(s) to.
+# @head: head to send event(s) to, in case the
+#        display device supports multiple scanouts.
+# @events: List of InputEvent union.
+#
+# Returns: Nothing on success.
+#
+# The @device and @head parameters can be used to send the input event
+# to specific input devices in case (a) multiple input devices of the
+# same kind are added to the virtual machine and (b) you have
+# configured input routing (see docs/multiseat.txt) for those input
+# devices.  The parameters work exactly like the device and head
+# properties of input devices.  If @device is missing, only devices
+# that have no input routing config are admissible.  If @device is
+# specified, both input devices with and without input routing config
+# are admissible, but devices with input routing config take
+# precedence.
+#
+# Since: 2.6
+#
+# Note: The consoles are visible in the qom tree, under
+# /backend/console[$index]. They have a device link and head property,
+# so it is possible to map which console belongs to which device and
+# display.
+#
+# Example:
+#
+# 1. Press left mouse button.
+#
+# -> { "execute": "input-send-event",
+#     "arguments": { "device": "video0",
+#                    "events": [ { "type": "btn",
+#                    "data" : { "down": true, "button": "left" } } ] } }
+# <- { "return": {} }
+#
+# -> { "execute": "input-send-event",
+#     "arguments": { "device": "video0",
+#                    "events": [ { "type": "btn",
+#                    "data" : { "down": false, "button": "left" } } ] } }
+# <- { "return": {} }
+#
+# 2. Press ctrl-alt-del.
+#
+# -> { "execute": "input-send-event",
+#      "arguments": { "events": [
+#         { "type": "key", "data" : { "down": true,
+#           "key": {"type": "qcode", "data": "ctrl" } } },
+#         { "type": "key", "data" : { "down": true,
+#           "key": {"type": "qcode", "data": "alt" } } },
+#         { "type": "key", "data" : { "down": true,
+#           "key": {"type": "qcode", "data": "delete" } } } ] } }
+# <- { "return": {} }
+#
+# 3. Move mouse pointer to absolute coordinates (20000, 400).
+#
+# -> { "execute": "input-send-event" ,
+#   "arguments": { "events": [
+#                { "type": "abs", "data" : { "axis": "x", "value" : 20000 } },
+#                { "type": "abs", "data" : { "axis": "y", "value" : 400 } } ] } }
+# <- { "return": {} }
+#
+##
+{ 'command': 'input-send-event',
+  'data': { '*device': 'str',
+            '*head'  : 'int',
+            'events' : [ 'InputEvent' ] } }
-- 
2.7.5
