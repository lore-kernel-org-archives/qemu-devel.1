Received: from eggs.gnu.org ([2001:4830:134:3::10]:48958)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dkxaA-0006Ve-L0
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 15:14:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dkxa3-0004Ab-UJ
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 15:14:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49086)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dkxa3-00049u-HH
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 15:14:15 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 90908285B5
	for <qemu-devel@nongnu.org>; Thu, 24 Aug 2017 19:14:14 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 24 Aug 2017 21:13:59 +0200
Message-Id: <1503602048-12268-8-git-send-email-armbru@redhat.com>
In-Reply-To: <1503602048-12268-1-git-send-email-armbru@redhat.com>
References: <1503602048-12268-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v2 07/16] qapi-schema: Collect net device stuff
 in qapi/net.json
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, eblake@redhat.com, Jason Wang <jasowang@redhat.com>

Cc: Jason Wang <jasowang@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 MAINTAINERS      |   1 +
 Makefile         |   1 +
 qapi-schema.json | 675 +---------------------------------------------------
 qapi/event.json  |  24 --
 qapi/net.json    | 706 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 709 insertions(+), 698 deletions(-)
 create mode 100644 qapi/net.json

diff --git a/MAINTAINERS b/MAINTAINERS
index 6a808d3..aecde65 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1356,6 +1356,7 @@ S: Maintained
 F: net/
 F: include/net/
 T: git git://github.com/jasowang/qemu.git net
+F: qapi/net.json
 
 Netmap network backend
 M: Luigi Rizzo <rizzo@iet.unipi.it>
diff --git a/Makefile b/Makefile
index 59ef46c..75f3ffe 100644
--- a/Makefile
+++ b/Makefile
@@ -413,6 +413,7 @@ qapi-modules = $(SRC_PATH)/qapi-schema.json $(SRC_PATH)/qapi/common.json \
                $(SRC_PATH)/qapi/char.json \
                $(SRC_PATH)/qapi/crypto.json \
                $(SRC_PATH)/qapi/event.json $(SRC_PATH)/qapi/introspect.json \
+               $(SRC_PATH)/qapi/net.json \
                $(SRC_PATH)/qapi/rocker.json \
                $(SRC_PATH)/qapi/run-state.json \
                $(SRC_PATH)/qapi/sockets.json \
diff --git a/qapi-schema.json b/qapi-schema.json
index 4f30d21..e9b61eb 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -84,6 +84,7 @@
 { 'include': 'qapi/crypto.json' }
 { 'include': 'qapi/block.json' }
 { 'include': 'qapi/char.json' }
+{ 'include': 'qapi/net.json' }
 { 'include': 'qapi/rocker.json' }
 { 'include': 'qapi/event.json' }
 { 'include': 'qapi/trace.json' }
@@ -2276,33 +2277,6 @@
 { 'command': 'inject-nmi' }
 
 ##
-# @set_link:
-#
-# Sets the link status of a virtual network adapter.
-#
-# @name: the device name of the virtual network adapter
-#
-# @up: true to set the link status to be up
-#
-# Returns: Nothing on success
-#          If @name is not a valid network device, DeviceNotFound
-#
-# Since: 0.14.0
-#
-# Notes: Not all network adapters support setting link status.  This command
-#        will succeed even if the network adapter does not support link status
-#        notification.
-#
-# Example:
-#
-# -> { "execute": "set_link",
-#      "arguments": { "name": "e1000.0", "up": false } }
-# <- { "return": {} }
-#
-##
-{ 'command': 'set_link', 'data': {'name': 'str', 'up': 'bool'} }
-
-##
 # @balloon:
 #
 # Request the balloon driver to change its balloon size.
@@ -3272,60 +3246,6 @@
   'data': { 'filename': 'str' } }
 
 ##
-# @netdev_add:
-#
-# Add a network backend.
-#
-# @type: the type of network backend.  Current valid values are 'user', 'tap',
-#        'vde', 'socket', 'dump' and 'bridge'
-#
-# @id: the name of the new network backend
-#
-# Additional arguments depend on the type.
-#
-# TODO: This command effectively bypasses QAPI completely due to its
-# "additional arguments" business.  It shouldn't have been added to
-# the schema in this form.  It should be qapified properly, or
-# replaced by a properly qapified command.
-#
-# Since: 0.14.0
-#
-# Returns: Nothing on success
-#          If @type is not a valid network backend, DeviceNotFound
-#
-# Example:
-#
-# -> { "execute": "netdev_add",
-#      "arguments": { "type": "user", "id": "netdev1",
-#                     "dnssearch": "example.org" } }
-# <- { "return": {} }
-#
-##
-{ 'command': 'netdev_add',
-  'data': {'type': 'str', 'id': 'str'},
-  'gen': false }                # so we can get the additional arguments
-
-##
-# @netdev_del:
-#
-# Remove a network backend.
-#
-# @id: the name of the network backend to remove
-#
-# Returns: Nothing on success
-#          If @id is not a valid network backend, DeviceNotFound
-#
-# Since: 0.14.0
-#
-# Example:
-#
-# -> { "execute": "netdev_del", "arguments": { "id": "netdev1" } }
-# <- { "return": {} }
-#
-##
-{ 'command': 'netdev_del', 'data': {'id': 'str'} }
-
-##
 # @object-add:
 #
 # Create a QOM object.
@@ -3373,491 +3293,6 @@
 { 'command': 'object-del', 'data': {'id': 'str'} }
 
 ##
-# @NetdevNoneOptions:
-#
-# Use it alone to have zero network devices.
-#
-# Since: 1.2
-##
-{ 'struct': 'NetdevNoneOptions',
-  'data': { } }
-
-##
-# @NetLegacyNicOptions:
-#
-# Create a new Network Interface Card.
-#
-# @netdev: id of -netdev to connect to
-#
-# @macaddr: MAC address
-#
-# @model: device model (e1000, rtl8139, virtio etc.)
-#
-# @addr: PCI device address
-#
-# @vectors: number of MSI-x vectors, 0 to disable MSI-X
-#
-# Since: 1.2
-##
-{ 'struct': 'NetLegacyNicOptions',
-  'data': {
-    '*netdev':  'str',
-    '*macaddr': 'str',
-    '*model':   'str',
-    '*addr':    'str',
-    '*vectors': 'uint32' } }
-
-##
-# @NetdevUserOptions:
-#
-# Use the user mode network stack which requires no administrator privilege to
-# run.
-#
-# @hostname: client hostname reported by the builtin DHCP server
-#
-# @restrict: isolate the guest from the host
-#
-# @ipv4: whether to support IPv4, default true for enabled
-#        (since 2.6)
-#
-# @ipv6: whether to support IPv6, default true for enabled
-#        (since 2.6)
-#
-# @ip: legacy parameter, use net= instead
-#
-# @net: IP network address that the guest will see, in the
-#       form addr[/netmask] The netmask is optional, and can be
-#       either in the form a.b.c.d or as a number of valid top-most
-#       bits. Default is 10.0.2.0/24.
-#
-# @host: guest-visible address of the host
-#
-# @tftp: root directory of the built-in TFTP server
-#
-# @bootfile: BOOTP filename, for use with tftp=
-#
-# @dhcpstart: the first of the 16 IPs the built-in DHCP server can
-#             assign
-#
-# @dns: guest-visible address of the virtual nameserver
-#
-# @dnssearch: list of DNS suffixes to search, passed as DHCP option
-#             to the guest
-#
-# @ipv6-prefix: IPv6 network prefix (default is fec0::) (since
-#               2.6). The network prefix is given in the usual
-#               hexadecimal IPv6 address notation.
-#
-# @ipv6-prefixlen: IPv6 network prefix length (default is 64)
-#                  (since 2.6)
-#
-# @ipv6-host: guest-visible IPv6 address of the host (since 2.6)
-#
-# @ipv6-dns: guest-visible IPv6 address of the virtual
-#            nameserver (since 2.6)
-#
-# @smb: root directory of the built-in SMB server
-#
-# @smbserver: IP address of the built-in SMB server
-#
-# @hostfwd: redirect incoming TCP or UDP host connections to guest
-#           endpoints
-#
-# @guestfwd: forward guest TCP connections
-#
-# Since: 1.2
-##
-{ 'struct': 'NetdevUserOptions',
-  'data': {
-    '*hostname':  'str',
-    '*restrict':  'bool',
-    '*ipv4':      'bool',
-    '*ipv6':      'bool',
-    '*ip':        'str',
-    '*net':       'str',
-    '*host':      'str',
-    '*tftp':      'str',
-    '*bootfile':  'str',
-    '*dhcpstart': 'str',
-    '*dns':       'str',
-    '*dnssearch': ['String'],
-    '*ipv6-prefix':      'str',
-    '*ipv6-prefixlen':   'int',
-    '*ipv6-host':        'str',
-    '*ipv6-dns':         'str',
-    '*smb':       'str',
-    '*smbserver': 'str',
-    '*hostfwd':   ['String'],
-    '*guestfwd':  ['String'] } }
-
-##
-# @NetdevTapOptions:
-#
-# Connect the host TAP network interface name to the VLAN.
-#
-# @ifname: interface name
-#
-# @fd: file descriptor of an already opened tap
-#
-# @fds: multiple file descriptors of already opened multiqueue capable
-# tap
-#
-# @script: script to initialize the interface
-#
-# @downscript: script to shut down the interface
-#
-# @br: bridge name (since 2.8)
-#
-# @helper: command to execute to configure bridge
-#
-# @sndbuf: send buffer limit. Understands [TGMKkb] suffixes.
-#
-# @vnet_hdr: enable the IFF_VNET_HDR flag on the tap interface
-#
-# @vhost: enable vhost-net network accelerator
-#
-# @vhostfd: file descriptor of an already opened vhost net device
-#
-# @vhostfds: file descriptors of multiple already opened vhost net
-# devices
-#
-# @vhostforce: vhost on for non-MSIX virtio guests
-#
-# @queues: number of queues to be created for multiqueue capable tap
-#
-# @poll-us: maximum number of microseconds that could
-# be spent on busy polling for tap (since 2.7)
-#
-# Since: 1.2
-##
-{ 'struct': 'NetdevTapOptions',
-  'data': {
-    '*ifname':     'str',
-    '*fd':         'str',
-    '*fds':        'str',
-    '*script':     'str',
-    '*downscript': 'str',
-    '*br':         'str',
-    '*helper':     'str',
-    '*sndbuf':     'size',
-    '*vnet_hdr':   'bool',
-    '*vhost':      'bool',
-    '*vhostfd':    'str',
-    '*vhostfds':   'str',
-    '*vhostforce': 'bool',
-    '*queues':     'uint32',
-    '*poll-us':    'uint32'} }
-
-##
-# @NetdevSocketOptions:
-#
-# Connect the VLAN to a remote VLAN in another QEMU virtual machine using a TCP
-# socket connection.
-#
-# @fd: file descriptor of an already opened socket
-#
-# @listen: port number, and optional hostname, to listen on
-#
-# @connect: port number, and optional hostname, to connect to
-#
-# @mcast: UDP multicast address and port number
-#
-# @localaddr: source address and port for multicast and udp packets
-#
-# @udp: UDP unicast address and port number
-#
-# Since: 1.2
-##
-{ 'struct': 'NetdevSocketOptions',
-  'data': {
-    '*fd':        'str',
-    '*listen':    'str',
-    '*connect':   'str',
-    '*mcast':     'str',
-    '*localaddr': 'str',
-    '*udp':       'str' } }
-
-##
-# @NetdevL2TPv3Options:
-#
-# Connect the VLAN to Ethernet over L2TPv3 Static tunnel
-#
-# @src: source address
-#
-# @dst: destination address
-#
-# @srcport: source port - mandatory for udp, optional for ip
-#
-# @dstport: destination port - mandatory for udp, optional for ip
-#
-# @ipv6: force the use of ipv6
-#
-# @udp: use the udp version of l2tpv3 encapsulation
-#
-# @cookie64: use 64 bit coookies
-#
-# @counter: have sequence counter
-#
-# @pincounter: pin sequence counter to zero -
-#              workaround for buggy implementations or
-#              networks with packet reorder
-#
-# @txcookie: 32 or 64 bit transmit cookie
-#
-# @rxcookie: 32 or 64 bit receive cookie
-#
-# @txsession: 32 bit transmit session
-#
-# @rxsession: 32 bit receive session - if not specified
-#             set to the same value as transmit
-#
-# @offset: additional offset - allows the insertion of
-#          additional application-specific data before the packet payload
-#
-# Since: 2.1
-##
-{ 'struct': 'NetdevL2TPv3Options',
-  'data': {
-    'src':          'str',
-    'dst':          'str',
-    '*srcport':     'str',
-    '*dstport':     'str',
-    '*ipv6':        'bool',
-    '*udp':         'bool',
-    '*cookie64':    'bool',
-    '*counter':     'bool',
-    '*pincounter':  'bool',
-    '*txcookie':    'uint64',
-    '*rxcookie':    'uint64',
-    'txsession':    'uint32',
-    '*rxsession':   'uint32',
-    '*offset':      'uint32' } }
-
-##
-# @NetdevVdeOptions:
-#
-# Connect the VLAN to a vde switch running on the host.
-#
-# @sock: socket path
-#
-# @port: port number
-#
-# @group: group owner of socket
-#
-# @mode: permissions for socket
-#
-# Since: 1.2
-##
-{ 'struct': 'NetdevVdeOptions',
-  'data': {
-    '*sock':  'str',
-    '*port':  'uint16',
-    '*group': 'str',
-    '*mode':  'uint16' } }
-
-##
-# @NetdevDumpOptions:
-#
-# Dump VLAN network traffic to a file.
-#
-# @len: per-packet size limit (64k default). Understands [TGMKkb]
-# suffixes.
-#
-# @file: dump file path (default is qemu-vlan0.pcap)
-#
-# Since: 1.2
-##
-{ 'struct': 'NetdevDumpOptions',
-  'data': {
-    '*len':  'size',
-    '*file': 'str' } }
-
-##
-# @NetdevBridgeOptions:
-#
-# Connect a host TAP network interface to a host bridge device.
-#
-# @br: bridge name
-#
-# @helper: command to execute to configure bridge
-#
-# Since: 1.2
-##
-{ 'struct': 'NetdevBridgeOptions',
-  'data': {
-    '*br':     'str',
-    '*helper': 'str' } }
-
-##
-# @NetdevHubPortOptions:
-#
-# Connect two or more net clients through a software hub.
-#
-# @hubid: hub identifier number
-#
-# Since: 1.2
-##
-{ 'struct': 'NetdevHubPortOptions',
-  'data': {
-    'hubid':     'int32' } }
-
-##
-# @NetdevNetmapOptions:
-#
-# Connect a client to a netmap-enabled NIC or to a VALE switch port
-#
-# @ifname: Either the name of an existing network interface supported by
-#          netmap, or the name of a VALE port (created on the fly).
-#          A VALE port name is in the form 'valeXXX:YYY', where XXX and
-#          YYY are non-negative integers. XXX identifies a switch and
-#          YYY identifies a port of the switch. VALE ports having the
-#          same XXX are therefore connected to the same switch.
-#
-# @devname: path of the netmap device (default: '/dev/netmap').
-#
-# Since: 2.0
-##
-{ 'struct': 'NetdevNetmapOptions',
-  'data': {
-    'ifname':     'str',
-    '*devname':    'str' } }
-
-##
-# @NetdevVhostUserOptions:
-#
-# Vhost-user network backend
-#
-# @chardev: name of a unix socket chardev
-#
-# @vhostforce: vhost on for non-MSIX virtio guests (default: false).
-#
-# @queues: number of queues to be created for multiqueue vhost-user
-#          (default: 1) (Since 2.5)
-#
-# Since: 2.1
-##
-{ 'struct': 'NetdevVhostUserOptions',
-  'data': {
-    'chardev':        'str',
-    '*vhostforce':    'bool',
-    '*queues':        'int' } }
-
-##
-# @NetClientDriver:
-#
-# Available netdev drivers.
-#
-# Since: 2.7
-##
-{ 'enum': 'NetClientDriver',
-  'data': [ 'none', 'nic', 'user', 'tap', 'l2tpv3', 'socket', 'vde', 'dump',
-            'bridge', 'hubport', 'netmap', 'vhost-user' ] }
-
-##
-# @Netdev:
-#
-# Captures the configuration of a network device.
-#
-# @id: identifier for monitor commands.
-#
-# @type: Specify the driver used for interpreting remaining arguments.
-#
-# Since: 1.2
-#
-# 'l2tpv3' - since 2.1
-##
-{ 'union': 'Netdev',
-  'base': { 'id': 'str', 'type': 'NetClientDriver' },
-  'discriminator': 'type',
-  'data': {
-    'none':     'NetdevNoneOptions',
-    'nic':      'NetLegacyNicOptions',
-    'user':     'NetdevUserOptions',
-    'tap':      'NetdevTapOptions',
-    'l2tpv3':   'NetdevL2TPv3Options',
-    'socket':   'NetdevSocketOptions',
-    'vde':      'NetdevVdeOptions',
-    'dump':     'NetdevDumpOptions',
-    'bridge':   'NetdevBridgeOptions',
-    'hubport':  'NetdevHubPortOptions',
-    'netmap':   'NetdevNetmapOptions',
-    'vhost-user': 'NetdevVhostUserOptions' } }
-
-##
-# @NetLegacy:
-#
-# Captures the configuration of a network device; legacy.
-#
-# @vlan: vlan number
-#
-# @id: identifier for monitor commands
-#
-# @name: identifier for monitor commands, ignored if @id is present
-#
-# @opts: device type specific properties (legacy)
-#
-# Since: 1.2
-##
-{ 'struct': 'NetLegacy',
-  'data': {
-    '*vlan': 'int32',
-    '*id':   'str',
-    '*name': 'str',
-    'opts':  'NetLegacyOptions' } }
-
-##
-# @NetLegacyOptionsType:
-#
-# Since: 1.2
-##
-{ 'enum': 'NetLegacyOptionsType',
-  'data': ['none', 'nic', 'user', 'tap', 'l2tpv3', 'socket', 'vde',
-           'dump', 'bridge', 'netmap', 'vhost-user'] }
-
-##
-# @NetLegacyOptions:
-#
-# Like Netdev, but for use only by the legacy command line options
-#
-# Since: 1.2
-##
-{ 'union': 'NetLegacyOptions',
-  'base': { 'type': 'NetLegacyOptionsType' },
-  'discriminator': 'type',
-  'data': {
-    'none':     'NetdevNoneOptions',
-    'nic':      'NetLegacyNicOptions',
-    'user':     'NetdevUserOptions',
-    'tap':      'NetdevTapOptions',
-    'l2tpv3':   'NetdevL2TPv3Options',
-    'socket':   'NetdevSocketOptions',
-    'vde':      'NetdevVdeOptions',
-    'dump':     'NetdevDumpOptions',
-    'bridge':   'NetdevBridgeOptions',
-    'netmap':   'NetdevNetmapOptions',
-    'vhost-user': 'NetdevVhostUserOptions' } }
-
-##
-# @NetFilterDirection:
-#
-# Indicates whether a netfilter is attached to a netdev's transmit queue or
-# receive queue or both.
-#
-# @all: the filter is attached both to the receive and the transmit
-#       queue of the netdev (default).
-#
-# @rx: the filter is attached to the receive queue of the netdev,
-#      where it will receive packets sent to the netdev.
-#
-# @tx: the filter is attached to the transmit queue of the netdev,
-#      where it will receive packets sent by the netdev.
-#
-# Since: 2.5
-##
-{ 'enum': 'NetFilterDirection',
-  'data': [ 'all', 'rx', 'tx' ] }
-
-##
 # @getfd:
 #
 # Receive a file descriptor via SCM rights and assign it a name
@@ -4854,114 +4289,6 @@
 
 
 ##
-# @RxState:
-#
-# Packets receiving state
-#
-# @normal: filter assigned packets according to the mac-table
-#
-# @none: don't receive any assigned packet
-#
-# @all: receive all assigned packets
-#
-# Since: 1.6
-##
-{ 'enum': 'RxState', 'data': [ 'normal', 'none', 'all' ] }
-
-##
-# @RxFilterInfo:
-#
-# Rx-filter information for a NIC.
-#
-# @name: net client name
-#
-# @promiscuous: whether promiscuous mode is enabled
-#
-# @multicast: multicast receive state
-#
-# @unicast: unicast receive state
-#
-# @vlan: vlan receive state (Since 2.0)
-#
-# @broadcast-allowed: whether to receive broadcast
-#
-# @multicast-overflow: multicast table is overflowed or not
-#
-# @unicast-overflow: unicast table is overflowed or not
-#
-# @main-mac: the main macaddr string
-#
-# @vlan-table: a list of active vlan id
-#
-# @unicast-table: a list of unicast macaddr string
-#
-# @multicast-table: a list of multicast macaddr string
-#
-# Since: 1.6
-##
-{ 'struct': 'RxFilterInfo',
-  'data': {
-    'name':               'str',
-    'promiscuous':        'bool',
-    'multicast':          'RxState',
-    'unicast':            'RxState',
-    'vlan':               'RxState',
-    'broadcast-allowed':  'bool',
-    'multicast-overflow': 'bool',
-    'unicast-overflow':   'bool',
-    'main-mac':           'str',
-    'vlan-table':         ['int'],
-    'unicast-table':      ['str'],
-    'multicast-table':    ['str'] }}
-
-##
-# @query-rx-filter:
-#
-# Return rx-filter information for all NICs (or for the given NIC).
-#
-# @name: net client name
-#
-# Returns: list of @RxFilterInfo for all NICs (or for the given NIC).
-#          Returns an error if the given @name doesn't exist, or given
-#          NIC doesn't support rx-filter querying, or given net client
-#          isn't a NIC.
-#
-# Since: 1.6
-#
-# Example:
-#
-# -> { "execute": "query-rx-filter", "arguments": { "name": "vnet0" } }
-# <- { "return": [
-#         {
-#             "promiscuous": true,
-#             "name": "vnet0",
-#             "main-mac": "52:54:00:12:34:56",
-#             "unicast": "normal",
-#             "vlan": "normal",
-#             "vlan-table": [
-#                 4,
-#                 0
-#             ],
-#             "unicast-table": [
-#             ],
-#             "multicast": "normal",
-#             "multicast-overflow": false,
-#             "unicast-overflow": false,
-#             "multicast-table": [
-#                 "01:00:5e:00:00:01",
-#                 "33:33:00:00:00:01",
-#                 "33:33:ff:12:34:56"
-#             ],
-#             "broadcast-allowed": false
-#         }
-#       ]
-#    }
-#
-##
-{ 'command': 'query-rx-filter', 'data': { '*name': 'str' },
-  'returns': ['RxFilterInfo'] }
-
-##
 # @InputButton:
 #
 # Button of a pointer input device (mouse, tablet).
diff --git a/qapi/event.json b/qapi/event.json
index b9aa6ed..4b32773 100644
--- a/qapi/event.json
+++ b/qapi/event.json
@@ -51,30 +51,6 @@
   'data': { '*device': 'str', 'path': 'str' } }
 
 ##
-# @NIC_RX_FILTER_CHANGED:
-#
-# Emitted once until the 'query-rx-filter' command is executed, the first event
-# will always be emitted
-#
-# @name: net client name
-#
-# @path: device path
-#
-# Since: 1.6
-#
-# Example:
-#
-# <- { "event": "NIC_RX_FILTER_CHANGED",
-#      "data": { "name": "vnet0",
-#                "path": "/machine/peripheral/vnet0/virtio-backend" },
-#      "timestamp": { "seconds": 1368697518, "microseconds": 326866 } }
-#    }
-#
-##
-{ 'event': 'NIC_RX_FILTER_CHANGED',
-  'data': { '*name': 'str', 'path': 'str' } }
-
-##
 # @VNC_CONNECTED:
 #
 # Emitted when a VNC client establishes a connection
diff --git a/qapi/net.json b/qapi/net.json
new file mode 100644
index 0000000..4beff5d
--- /dev/null
+++ b/qapi/net.json
@@ -0,0 +1,706 @@
+# -*- Mode: Python -*-
+#
+
+##
+# = Net devices
+##
+
+{ 'include': 'common.json' }
+
+##
+# @set_link:
+#
+# Sets the link status of a virtual network adapter.
+#
+# @name: the device name of the virtual network adapter
+#
+# @up: true to set the link status to be up
+#
+# Returns: Nothing on success
+#          If @name is not a valid network device, DeviceNotFound
+#
+# Since: 0.14.0
+#
+# Notes: Not all network adapters support setting link status.  This command
+#        will succeed even if the network adapter does not support link status
+#        notification.
+#
+# Example:
+#
+# -> { "execute": "set_link",
+#      "arguments": { "name": "e1000.0", "up": false } }
+# <- { "return": {} }
+#
+##
+{ 'command': 'set_link', 'data': {'name': 'str', 'up': 'bool'} }
+
+##
+# @netdev_add:
+#
+# Add a network backend.
+#
+# @type: the type of network backend.  Current valid values are 'user', 'tap',
+#        'vde', 'socket', 'dump' and 'bridge'
+#
+# @id: the name of the new network backend
+#
+# Additional arguments depend on the type.
+#
+# TODO: This command effectively bypasses QAPI completely due to its
+# "additional arguments" business.  It shouldn't have been added to
+# the schema in this form.  It should be qapified properly, or
+# replaced by a properly qapified command.
+#
+# Since: 0.14.0
+#
+# Returns: Nothing on success
+#          If @type is not a valid network backend, DeviceNotFound
+#
+# Example:
+#
+# -> { "execute": "netdev_add",
+#      "arguments": { "type": "user", "id": "netdev1",
+#                     "dnssearch": "example.org" } }
+# <- { "return": {} }
+#
+##
+{ 'command': 'netdev_add',
+  'data': {'type': 'str', 'id': 'str'},
+  'gen': false }                # so we can get the additional arguments
+
+##
+# @netdev_del:
+#
+# Remove a network backend.
+#
+# @id: the name of the network backend to remove
+#
+# Returns: Nothing on success
+#          If @id is not a valid network backend, DeviceNotFound
+#
+# Since: 0.14.0
+#
+# Example:
+#
+# -> { "execute": "netdev_del", "arguments": { "id": "netdev1" } }
+# <- { "return": {} }
+#
+##
+{ 'command': 'netdev_del', 'data': {'id': 'str'} }
+
+##
+# @NetdevNoneOptions:
+#
+# Use it alone to have zero network devices.
+#
+# Since: 1.2
+##
+{ 'struct': 'NetdevNoneOptions',
+  'data': { } }
+
+##
+# @NetLegacyNicOptions:
+#
+# Create a new Network Interface Card.
+#
+# @netdev: id of -netdev to connect to
+#
+# @macaddr: MAC address
+#
+# @model: device model (e1000, rtl8139, virtio etc.)
+#
+# @addr: PCI device address
+#
+# @vectors: number of MSI-x vectors, 0 to disable MSI-X
+#
+# Since: 1.2
+##
+{ 'struct': 'NetLegacyNicOptions',
+  'data': {
+    '*netdev':  'str',
+    '*macaddr': 'str',
+    '*model':   'str',
+    '*addr':    'str',
+    '*vectors': 'uint32' } }
+
+##
+# @NetdevUserOptions:
+#
+# Use the user mode network stack which requires no administrator privilege to
+# run.
+#
+# @hostname: client hostname reported by the builtin DHCP server
+#
+# @restrict: isolate the guest from the host
+#
+# @ipv4: whether to support IPv4, default true for enabled
+#        (since 2.6)
+#
+# @ipv6: whether to support IPv6, default true for enabled
+#        (since 2.6)
+#
+# @ip: legacy parameter, use net= instead
+#
+# @net: IP network address that the guest will see, in the
+#       form addr[/netmask] The netmask is optional, and can be
+#       either in the form a.b.c.d or as a number of valid top-most
+#       bits. Default is 10.0.2.0/24.
+#
+# @host: guest-visible address of the host
+#
+# @tftp: root directory of the built-in TFTP server
+#
+# @bootfile: BOOTP filename, for use with tftp=
+#
+# @dhcpstart: the first of the 16 IPs the built-in DHCP server can
+#             assign
+#
+# @dns: guest-visible address of the virtual nameserver
+#
+# @dnssearch: list of DNS suffixes to search, passed as DHCP option
+#             to the guest
+#
+# @ipv6-prefix: IPv6 network prefix (default is fec0::) (since
+#               2.6). The network prefix is given in the usual
+#               hexadecimal IPv6 address notation.
+#
+# @ipv6-prefixlen: IPv6 network prefix length (default is 64)
+#                  (since 2.6)
+#
+# @ipv6-host: guest-visible IPv6 address of the host (since 2.6)
+#
+# @ipv6-dns: guest-visible IPv6 address of the virtual
+#            nameserver (since 2.6)
+#
+# @smb: root directory of the built-in SMB server
+#
+# @smbserver: IP address of the built-in SMB server
+#
+# @hostfwd: redirect incoming TCP or UDP host connections to guest
+#           endpoints
+#
+# @guestfwd: forward guest TCP connections
+#
+# Since: 1.2
+##
+{ 'struct': 'NetdevUserOptions',
+  'data': {
+    '*hostname':  'str',
+    '*restrict':  'bool',
+    '*ipv4':      'bool',
+    '*ipv6':      'bool',
+    '*ip':        'str',
+    '*net':       'str',
+    '*host':      'str',
+    '*tftp':      'str',
+    '*bootfile':  'str',
+    '*dhcpstart': 'str',
+    '*dns':       'str',
+    '*dnssearch': ['String'],
+    '*ipv6-prefix':      'str',
+    '*ipv6-prefixlen':   'int',
+    '*ipv6-host':        'str',
+    '*ipv6-dns':         'str',
+    '*smb':       'str',
+    '*smbserver': 'str',
+    '*hostfwd':   ['String'],
+    '*guestfwd':  ['String'] } }
+
+##
+# @NetdevTapOptions:
+#
+# Connect the host TAP network interface name to the VLAN.
+#
+# @ifname: interface name
+#
+# @fd: file descriptor of an already opened tap
+#
+# @fds: multiple file descriptors of already opened multiqueue capable
+# tap
+#
+# @script: script to initialize the interface
+#
+# @downscript: script to shut down the interface
+#
+# @br: bridge name (since 2.8)
+#
+# @helper: command to execute to configure bridge
+#
+# @sndbuf: send buffer limit. Understands [TGMKkb] suffixes.
+#
+# @vnet_hdr: enable the IFF_VNET_HDR flag on the tap interface
+#
+# @vhost: enable vhost-net network accelerator
+#
+# @vhostfd: file descriptor of an already opened vhost net device
+#
+# @vhostfds: file descriptors of multiple already opened vhost net
+# devices
+#
+# @vhostforce: vhost on for non-MSIX virtio guests
+#
+# @queues: number of queues to be created for multiqueue capable tap
+#
+# @poll-us: maximum number of microseconds that could
+# be spent on busy polling for tap (since 2.7)
+#
+# Since: 1.2
+##
+{ 'struct': 'NetdevTapOptions',
+  'data': {
+    '*ifname':     'str',
+    '*fd':         'str',
+    '*fds':        'str',
+    '*script':     'str',
+    '*downscript': 'str',
+    '*br':         'str',
+    '*helper':     'str',
+    '*sndbuf':     'size',
+    '*vnet_hdr':   'bool',
+    '*vhost':      'bool',
+    '*vhostfd':    'str',
+    '*vhostfds':   'str',
+    '*vhostforce': 'bool',
+    '*queues':     'uint32',
+    '*poll-us':    'uint32'} }
+
+##
+# @NetdevSocketOptions:
+#
+# Connect the VLAN to a remote VLAN in another QEMU virtual machine using a TCP
+# socket connection.
+#
+# @fd: file descriptor of an already opened socket
+#
+# @listen: port number, and optional hostname, to listen on
+#
+# @connect: port number, and optional hostname, to connect to
+#
+# @mcast: UDP multicast address and port number
+#
+# @localaddr: source address and port for multicast and udp packets
+#
+# @udp: UDP unicast address and port number
+#
+# Since: 1.2
+##
+{ 'struct': 'NetdevSocketOptions',
+  'data': {
+    '*fd':        'str',
+    '*listen':    'str',
+    '*connect':   'str',
+    '*mcast':     'str',
+    '*localaddr': 'str',
+    '*udp':       'str' } }
+
+##
+# @NetdevL2TPv3Options:
+#
+# Connect the VLAN to Ethernet over L2TPv3 Static tunnel
+#
+# @src: source address
+#
+# @dst: destination address
+#
+# @srcport: source port - mandatory for udp, optional for ip
+#
+# @dstport: destination port - mandatory for udp, optional for ip
+#
+# @ipv6: force the use of ipv6
+#
+# @udp: use the udp version of l2tpv3 encapsulation
+#
+# @cookie64: use 64 bit coookies
+#
+# @counter: have sequence counter
+#
+# @pincounter: pin sequence counter to zero -
+#              workaround for buggy implementations or
+#              networks with packet reorder
+#
+# @txcookie: 32 or 64 bit transmit cookie
+#
+# @rxcookie: 32 or 64 bit receive cookie
+#
+# @txsession: 32 bit transmit session
+#
+# @rxsession: 32 bit receive session - if not specified
+#             set to the same value as transmit
+#
+# @offset: additional offset - allows the insertion of
+#          additional application-specific data before the packet payload
+#
+# Since: 2.1
+##
+{ 'struct': 'NetdevL2TPv3Options',
+  'data': {
+    'src':          'str',
+    'dst':          'str',
+    '*srcport':     'str',
+    '*dstport':     'str',
+    '*ipv6':        'bool',
+    '*udp':         'bool',
+    '*cookie64':    'bool',
+    '*counter':     'bool',
+    '*pincounter':  'bool',
+    '*txcookie':    'uint64',
+    '*rxcookie':    'uint64',
+    'txsession':    'uint32',
+    '*rxsession':   'uint32',
+    '*offset':      'uint32' } }
+
+##
+# @NetdevVdeOptions:
+#
+# Connect the VLAN to a vde switch running on the host.
+#
+# @sock: socket path
+#
+# @port: port number
+#
+# @group: group owner of socket
+#
+# @mode: permissions for socket
+#
+# Since: 1.2
+##
+{ 'struct': 'NetdevVdeOptions',
+  'data': {
+    '*sock':  'str',
+    '*port':  'uint16',
+    '*group': 'str',
+    '*mode':  'uint16' } }
+
+##
+# @NetdevDumpOptions:
+#
+# Dump VLAN network traffic to a file.
+#
+# @len: per-packet size limit (64k default). Understands [TGMKkb]
+# suffixes.
+#
+# @file: dump file path (default is qemu-vlan0.pcap)
+#
+# Since: 1.2
+##
+{ 'struct': 'NetdevDumpOptions',
+  'data': {
+    '*len':  'size',
+    '*file': 'str' } }
+
+##
+# @NetdevBridgeOptions:
+#
+# Connect a host TAP network interface to a host bridge device.
+#
+# @br: bridge name
+#
+# @helper: command to execute to configure bridge
+#
+# Since: 1.2
+##
+{ 'struct': 'NetdevBridgeOptions',
+  'data': {
+    '*br':     'str',
+    '*helper': 'str' } }
+
+##
+# @NetdevHubPortOptions:
+#
+# Connect two or more net clients through a software hub.
+#
+# @hubid: hub identifier number
+#
+# Since: 1.2
+##
+{ 'struct': 'NetdevHubPortOptions',
+  'data': {
+    'hubid':     'int32' } }
+
+##
+# @NetdevNetmapOptions:
+#
+# Connect a client to a netmap-enabled NIC or to a VALE switch port
+#
+# @ifname: Either the name of an existing network interface supported by
+#          netmap, or the name of a VALE port (created on the fly).
+#          A VALE port name is in the form 'valeXXX:YYY', where XXX and
+#          YYY are non-negative integers. XXX identifies a switch and
+#          YYY identifies a port of the switch. VALE ports having the
+#          same XXX are therefore connected to the same switch.
+#
+# @devname: path of the netmap device (default: '/dev/netmap').
+#
+# Since: 2.0
+##
+{ 'struct': 'NetdevNetmapOptions',
+  'data': {
+    'ifname':     'str',
+    '*devname':    'str' } }
+
+##
+# @NetdevVhostUserOptions:
+#
+# Vhost-user network backend
+#
+# @chardev: name of a unix socket chardev
+#
+# @vhostforce: vhost on for non-MSIX virtio guests (default: false).
+#
+# @queues: number of queues to be created for multiqueue vhost-user
+#          (default: 1) (Since 2.5)
+#
+# Since: 2.1
+##
+{ 'struct': 'NetdevVhostUserOptions',
+  'data': {
+    'chardev':        'str',
+    '*vhostforce':    'bool',
+    '*queues':        'int' } }
+
+##
+# @NetClientDriver:
+#
+# Available netdev drivers.
+#
+# Since: 2.7
+##
+{ 'enum': 'NetClientDriver',
+  'data': [ 'none', 'nic', 'user', 'tap', 'l2tpv3', 'socket', 'vde', 'dump',
+            'bridge', 'hubport', 'netmap', 'vhost-user' ] }
+
+##
+# @Netdev:
+#
+# Captures the configuration of a network device.
+#
+# @id: identifier for monitor commands.
+#
+# @type: Specify the driver used for interpreting remaining arguments.
+#
+# Since: 1.2
+#
+# 'l2tpv3' - since 2.1
+##
+{ 'union': 'Netdev',
+  'base': { 'id': 'str', 'type': 'NetClientDriver' },
+  'discriminator': 'type',
+  'data': {
+    'none':     'NetdevNoneOptions',
+    'nic':      'NetLegacyNicOptions',
+    'user':     'NetdevUserOptions',
+    'tap':      'NetdevTapOptions',
+    'l2tpv3':   'NetdevL2TPv3Options',
+    'socket':   'NetdevSocketOptions',
+    'vde':      'NetdevVdeOptions',
+    'dump':     'NetdevDumpOptions',
+    'bridge':   'NetdevBridgeOptions',
+    'hubport':  'NetdevHubPortOptions',
+    'netmap':   'NetdevNetmapOptions',
+    'vhost-user': 'NetdevVhostUserOptions' } }
+
+##
+# @NetLegacy:
+#
+# Captures the configuration of a network device; legacy.
+#
+# @vlan: vlan number
+#
+# @id: identifier for monitor commands
+#
+# @name: identifier for monitor commands, ignored if @id is present
+#
+# @opts: device type specific properties (legacy)
+#
+# Since: 1.2
+##
+{ 'struct': 'NetLegacy',
+  'data': {
+    '*vlan': 'int32',
+    '*id':   'str',
+    '*name': 'str',
+    'opts':  'NetLegacyOptions' } }
+
+##
+# @NetLegacyOptionsType:
+#
+# Since: 1.2
+##
+{ 'enum': 'NetLegacyOptionsType',
+  'data': ['none', 'nic', 'user', 'tap', 'l2tpv3', 'socket', 'vde',
+           'dump', 'bridge', 'netmap', 'vhost-user'] }
+
+##
+# @NetLegacyOptions:
+#
+# Like Netdev, but for use only by the legacy command line options
+#
+# Since: 1.2
+##
+{ 'union': 'NetLegacyOptions',
+  'base': { 'type': 'NetLegacyOptionsType' },
+  'discriminator': 'type',
+  'data': {
+    'none':     'NetdevNoneOptions',
+    'nic':      'NetLegacyNicOptions',
+    'user':     'NetdevUserOptions',
+    'tap':      'NetdevTapOptions',
+    'l2tpv3':   'NetdevL2TPv3Options',
+    'socket':   'NetdevSocketOptions',
+    'vde':      'NetdevVdeOptions',
+    'dump':     'NetdevDumpOptions',
+    'bridge':   'NetdevBridgeOptions',
+    'netmap':   'NetdevNetmapOptions',
+    'vhost-user': 'NetdevVhostUserOptions' } }
+
+##
+# @NetFilterDirection:
+#
+# Indicates whether a netfilter is attached to a netdev's transmit queue or
+# receive queue or both.
+#
+# @all: the filter is attached both to the receive and the transmit
+#       queue of the netdev (default).
+#
+# @rx: the filter is attached to the receive queue of the netdev,
+#      where it will receive packets sent to the netdev.
+#
+# @tx: the filter is attached to the transmit queue of the netdev,
+#      where it will receive packets sent by the netdev.
+#
+# Since: 2.5
+##
+{ 'enum': 'NetFilterDirection',
+  'data': [ 'all', 'rx', 'tx' ] }
+
+##
+# @RxState:
+#
+# Packets receiving state
+#
+# @normal: filter assigned packets according to the mac-table
+#
+# @none: don't receive any assigned packet
+#
+# @all: receive all assigned packets
+#
+# Since: 1.6
+##
+{ 'enum': 'RxState', 'data': [ 'normal', 'none', 'all' ] }
+
+##
+# @RxFilterInfo:
+#
+# Rx-filter information for a NIC.
+#
+# @name: net client name
+#
+# @promiscuous: whether promiscuous mode is enabled
+#
+# @multicast: multicast receive state
+#
+# @unicast: unicast receive state
+#
+# @vlan: vlan receive state (Since 2.0)
+#
+# @broadcast-allowed: whether to receive broadcast
+#
+# @multicast-overflow: multicast table is overflowed or not
+#
+# @unicast-overflow: unicast table is overflowed or not
+#
+# @main-mac: the main macaddr string
+#
+# @vlan-table: a list of active vlan id
+#
+# @unicast-table: a list of unicast macaddr string
+#
+# @multicast-table: a list of multicast macaddr string
+#
+# Since: 1.6
+##
+{ 'struct': 'RxFilterInfo',
+  'data': {
+    'name':               'str',
+    'promiscuous':        'bool',
+    'multicast':          'RxState',
+    'unicast':            'RxState',
+    'vlan':               'RxState',
+    'broadcast-allowed':  'bool',
+    'multicast-overflow': 'bool',
+    'unicast-overflow':   'bool',
+    'main-mac':           'str',
+    'vlan-table':         ['int'],
+    'unicast-table':      ['str'],
+    'multicast-table':    ['str'] }}
+
+##
+# @query-rx-filter:
+#
+# Return rx-filter information for all NICs (or for the given NIC).
+#
+# @name: net client name
+#
+# Returns: list of @RxFilterInfo for all NICs (or for the given NIC).
+#          Returns an error if the given @name doesn't exist, or given
+#          NIC doesn't support rx-filter querying, or given net client
+#          isn't a NIC.
+#
+# Since: 1.6
+#
+# Example:
+#
+# -> { "execute": "query-rx-filter", "arguments": { "name": "vnet0" } }
+# <- { "return": [
+#         {
+#             "promiscuous": true,
+#             "name": "vnet0",
+#             "main-mac": "52:54:00:12:34:56",
+#             "unicast": "normal",
+#             "vlan": "normal",
+#             "vlan-table": [
+#                 4,
+#                 0
+#             ],
+#             "unicast-table": [
+#             ],
+#             "multicast": "normal",
+#             "multicast-overflow": false,
+#             "unicast-overflow": false,
+#             "multicast-table": [
+#                 "01:00:5e:00:00:01",
+#                 "33:33:00:00:00:01",
+#                 "33:33:ff:12:34:56"
+#             ],
+#             "broadcast-allowed": false
+#         }
+#       ]
+#    }
+#
+##
+{ 'command': 'query-rx-filter', 'data': { '*name': 'str' },
+  'returns': ['RxFilterInfo'] }
+
+##
+# @NIC_RX_FILTER_CHANGED:
+#
+# Emitted once until the 'query-rx-filter' command is executed, the first event
+# will always be emitted
+#
+# @name: net client name
+#
+# @path: device path
+#
+# Since: 1.6
+#
+# Example:
+#
+# <- { "event": "NIC_RX_FILTER_CHANGED",
+#      "data": { "name": "vnet0",
+#                "path": "/machine/peripheral/vnet0/virtio-backend" },
+#      "timestamp": { "seconds": 1368697518, "microseconds": 326866 } }
+#    }
+#
+##
+{ 'event': 'NIC_RX_FILTER_CHANGED',
+  'data': { '*name': 'str', 'path': 'str' } }
-- 
2.7.5
