Received: from eggs.gnu.org ([2001:4830:134:3::10]:33883)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1co8V8-0001om-DK
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 08:58:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1co8Ur-0000M5-4q
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 08:58:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:12052)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1co8Uq-0000Ig-6f
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 08:57:45 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Wed, 15 Mar 2017 13:57:06 +0100
Message-Id: <1489582656-31133-18-git-send-email-armbru@redhat.com>
In-Reply-To: <1489582656-31133-1-git-send-email-armbru@redhat.com>
References: <1489582656-31133-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v2 for-2.9 17/47] qapi: The #optional tag is
 redundant, drop
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, eblake@redhat.com, mdroth@linux.vnet.ibm.com

We traditionally mark optional members #optional in the doc comment.
Before commit 3313b61, this was entirely manual.

Commit 3313b61 added some automation because its qapi2texi.py relied
on #optional to determine whether a member is optional.  This is no
longer the case since the previous commit: the only thing qapi2texi.py
still does with #optional is stripping it out.  We still reject bogus
qapi-schema.json and six places for qga/qapi-schema.json.

Thus, you can't actually rely on #optional to see whether something is
optional.  Yet we still make people add it manually.  That's just
busy-work.

Drop the code to check, fix up and strip out #optional, along with all
instances of #optional.  To keep it out, add code to reject it, to be
dropped again once the dust settles.

No change to generated documentation.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 docs/qapi-code-gen.txt              |  12 +-
 docs/writing-qmp-commands.txt       |   4 +-
 qapi-schema.json                    | 378 ++++++++++++++++-----------------
 qapi/block-core.json                | 412 ++++++++++++++++++------------------
 qapi/block.json                     |   8 +-
 qapi/crypto.json                    |  22 +-
 qapi/event.json                     |  10 +-
 qapi/introspect.json                |   6 +-
 qapi/rocker.json                    |  70 +++---
 qapi/trace.json                     |   6 +-
 qga/qapi-schema.json                |  38 ++--
 scripts/qapi.py                     |  23 +-
 scripts/qapi2texi.py                |   3 +-
 tests/Makefile.include              |   1 -
 tests/qapi-schema/doc-optional.err  |   1 -
 tests/qapi-schema/doc-optional.exit |   1 -
 tests/qapi-schema/doc-optional.json |   7 -
 tests/qapi-schema/doc-optional.out  |   0
 18 files changed, 486 insertions(+), 516 deletions(-)
 delete mode 100644 tests/qapi-schema/doc-optional.err
 delete mode 100644 tests/qapi-schema/doc-optional.exit
 delete mode 100644 tests/qapi-schema/doc-optional.json
 delete mode 100644 tests/qapi-schema/doc-optional.out

diff --git a/docs/qapi-code-gen.txt b/docs/qapi-code-gen.txt
index 03ab2a8..6467329 100644
--- a/docs/qapi-code-gen.txt
+++ b/docs/qapi-code-gen.txt
@@ -131,10 +131,8 @@ and optional tagged sections.
 
 FIXME: the parser accepts these things in almost any order.
 
-Optional arguments / members are tagged with the phrase '#optional',
-often with their default value; and extensions added after the
-expression was first released are also given a '(since x.y.z)'
-comment.
+Extensions added after the expression was first released carry a
+'(since x.y.z)' comment.
 
 A tagged section starts with one of the following words:
 "Note:"/"Notes:", "Since:", "Example"/"Examples", "Returns:", "TODO:".
@@ -150,10 +148,10 @@ For example:
 #
 # Statistics of a virtual block device or a block backing device.
 #
-# @device: #optional If the stats are for a virtual block device, the name
+# @device: If the stats are for a virtual block device, the name
 #          corresponding to the virtual block device.
 #
-# @node-name: #optional The node name of the device. (since 2.3)
+# @node-name: The node name of the device. (since 2.3)
 #
 # ... more members ...
 #
@@ -168,7 +166,7 @@ For example:
 #
 # Query the @BlockStats for all virtual block devices.
 #
-# @query-nodes: #optional If true, the command will query all the
+# @query-nodes: If true, the command will query all the
 #               block nodes ... explain, explain ...  (since 2.3)
 #
 # Returns: A list of @BlockStats for each virtual block devices.
diff --git a/docs/writing-qmp-commands.txt b/docs/writing-qmp-commands.txt
index 44c14db..1e63754 100644
--- a/docs/writing-qmp-commands.txt
+++ b/docs/writing-qmp-commands.txt
@@ -252,7 +252,7 @@ here goes "hello-world"'s new entry for the qapi-schema.json file:
 #
 # Print a client provided string to the standard output stream.
 #
-# @message: #optional string to be printed
+# @message: string to be printed
 #
 # Returns: Nothing on success.
 #
@@ -358,7 +358,7 @@ The best way to return that data is to create a new QAPI type, as shown below:
 #
 # @clock-name: The alarm clock method's name.
 #
-# @next-deadline: #optional The time (in nanoseconds) the next alarm will fire.
+# @next-deadline: The time (in nanoseconds) the next alarm will fire.
 #
 # Since: 1.0
 ##
diff --git a/qapi-schema.json b/qapi-schema.json
index 52141cd..d693033 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -150,10 +150,10 @@
 #
 # @fdname: file descriptor name previously passed via 'getfd' command
 #
-# @skipauth: #optional whether to skip authentication. Only applies
+# @skipauth: whether to skip authentication. Only applies
 #            to "vnc" and "spice" protocols
 #
-# @tls: #optional whether to perform TLS. Only applies to the "spice"
+# @tls: whether to perform TLS. Only applies to the "spice"
 #       protocol
 #
 # Returns: nothing on success.
@@ -176,7 +176,7 @@
 #
 # Guest name information.
 #
-# @name: #optional The name of the guest
+# @name: The name of the guest
 #
 # Since: 0.14.0
 ##
@@ -470,7 +470,7 @@
 #
 # @data: data to write
 #
-# @format: #optional data encoding (default 'utf8').
+# @format: data encoding (default 'utf8').
 #          - base64: data must be base64 encoded text.  Its binary
 #            decoding gets written.
 #          - utf8: data's UTF-8 encoding is written
@@ -503,7 +503,7 @@
 #
 # @size: how many bytes to read at most
 #
-# @format: #optional data encoding (default 'utf8').
+# @format: data encoding (default 'utf8').
 #          - base64: the data read is returned in base64 encoding.
 #          - utf8: the data read is interpreted as UTF-8.
 #            Bug: can screw up when the buffer contains invalid UTF-8
@@ -667,45 +667,45 @@
 #
 # Information about current migration process.
 #
-# @status: #optional @MigrationStatus describing the current migration status.
+# @status: @MigrationStatus describing the current migration status.
 #          If this field is not returned, no migration process
 #          has been initiated
 #
-# @ram: #optional @MigrationStats containing detailed migration
+# @ram: @MigrationStats containing detailed migration
 #       status, only returned if status is 'active' or
 #       'completed'(since 1.2)
 #
-# @disk: #optional @MigrationStats containing detailed disk migration
+# @disk: @MigrationStats containing detailed disk migration
 #        status, only returned if status is 'active' and it is a block
 #        migration
 #
-# @xbzrle-cache: #optional @XBZRLECacheStats containing detailed XBZRLE
+# @xbzrle-cache: @XBZRLECacheStats containing detailed XBZRLE
 #                migration statistics, only returned if XBZRLE feature is on and
 #                status is 'active' or 'completed' (since 1.2)
 #
-# @total-time: #optional total amount of milliseconds since migration started.
+# @total-time: total amount of milliseconds since migration started.
 #        If migration has ended, it returns the total migration
 #        time. (since 1.2)
 #
-# @downtime: #optional only present when migration finishes correctly
+# @downtime: only present when migration finishes correctly
 #        total downtime in milliseconds for the guest.
 #        (since 1.3)
 #
-# @expected-downtime: #optional only present while migration is active
+# @expected-downtime: only present while migration is active
 #        expected downtime in milliseconds for the guest in last walk
 #        of the dirty bitmap. (since 1.3)
 #
-# @setup-time: #optional amount of setup time in milliseconds _before_ the
+# @setup-time: amount of setup time in milliseconds _before_ the
 #        iterations begin but _after_ the QMP command is issued. This is designed
 #        to provide an accounting of any activities (such as RDMA pinning) which
 #        may be expensive, but do not actually occur during the iterative
 #        migration rounds themselves. (since 1.6)
 #
-# @cpu-throttle-percentage: #optional percentage of time guest cpus are being
+# @cpu-throttle-percentage: percentage of time guest cpus are being
 #        throttled during auto-converge. This is only present when auto-converge
 #        has started throttling guest cpus. (Since 2.7)
 #
-# @error-desc: #optional the human readable error description string, when
+# @error-desc: the human readable error description string, when
 #              @status is 'failed'. Clients should not attempt to parse the
 #              error strings. (Since 2.7)
 #
@@ -1038,21 +1038,21 @@
 # ('query-migrate-parameters'), with the exception of tls-creds and
 # tls-hostname.
 #
-# @compress-level: #optional compression level
+# @compress-level: compression level
 #
-# @compress-threads: #optional compression thread count
+# @compress-threads: compression thread count
 #
-# @decompress-threads: #optional decompression thread count
+# @decompress-threads: decompression thread count
 #
-# @cpu-throttle-initial: #optional Initial percentage of time guest cpus are
+# @cpu-throttle-initial: Initial percentage of time guest cpus are
 #                        throttledwhen migration auto-converge is activated.
 #                        The default value is 20. (Since 2.7)
 #
-# @cpu-throttle-increment: #optional throttle percentage increase each time
+# @cpu-throttle-increment: throttle percentage increase each time
 #                          auto-converge detects that migration is not making
 #                          progress. The default value is 10. (Since 2.7)
 #
-# @tls-creds: #optional ID of the 'tls-creds' object that provides credentials
+# @tls-creds: ID of the 'tls-creds' object that provides credentials
 #             for establishing a TLS connection over the migration data
 #             channel. On the outgoing side of the migration, the credentials
 #             must be for a 'client' endpoint, while for the incoming side the
@@ -1060,7 +1060,7 @@
 #             will enable TLS for all migrations. The default is unset,
 #             resulting in unsecured migration at the QEMU level. (Since 2.7)
 #
-# @tls-hostname: #optional hostname of the target host for the migration. This
+# @tls-hostname: hostname of the target host for the migration. This
 #                is required when using x509 based TLS credentials and the
 #                migration URI does not already include a hostname. For
 #                example if using fd: or exec: based migration, the
@@ -1125,9 +1125,9 @@
 #
 # @protocol:     must be "spice"
 # @hostname:     migration target hostname
-# @port:         #optional spice tcp port for plaintext channels
-# @tls-port:     #optional spice tcp port for tls-secured channels
-# @cert-subject: #optional server certificate subject
+# @port:         spice tcp port for plaintext channels
+# @tls-port:     spice tcp port for tls-secured channels
+# @cert-subject: server certificate subject
 #
 # Since: 0.14.0
 #
@@ -1547,7 +1547,7 @@
 #
 # The network connection information for server
 #
-# @auth: #optional authentication method used for
+# @auth: authentication method used for
 #        the plain (non-websocket) VNC server
 #
 # Since: 2.1
@@ -1561,10 +1561,10 @@
 #
 # Information about a connected VNC client.
 #
-# @x509_dname: #optional If x509 authentication is in use, the Distinguished
+# @x509_dname: If x509 authentication is in use, the Distinguished
 #              Name of the client.
 #
-# @sasl_username: #optional If SASL authentication is in use, the SASL username
+# @sasl_username: If SASL authentication is in use, the SASL username
 #                 used for authentication.
 #
 # Since: 0.14.0
@@ -1580,19 +1580,19 @@
 #
 # @enabled: true if the VNC server is enabled, false otherwise
 #
-# @host: #optional The hostname the VNC server is bound to.  This depends on
+# @host: The hostname the VNC server is bound to.  This depends on
 #        the name resolution on the host and may be an IP address.
 #
-# @family: #optional 'ipv6' if the host is listening for IPv6 connections
+# @family: 'ipv6' if the host is listening for IPv6 connections
 #                    'ipv4' if the host is listening for IPv4 connections
 #                    'unix' if the host is listening on a unix domain socket
 #                    'unknown' otherwise
 #
-# @service: #optional The service name of the server's port.  This may depends
+# @service: The service name of the server's port.  This may depends
 #           on the host system's service database so symbolic names should not
 #           be relied on.
 #
-# @auth: #optional the current authentication type used by the server
+# @auth: the current authentication type used by the server
 #        'none' if no authentication is being used
 #        'vnc' if VNC authentication is being used
 #        'vencrypt+plain' if VEncrypt is used with plain text authentication
@@ -1647,7 +1647,7 @@
 #
 # @auth: The current authentication type used by the servers
 #
-# @vencrypt: #optional The vencrypt sub authentication type used by the
+# @vencrypt: The vencrypt sub authentication type used by the
 #            servers, only specified in case auth == vencrypt.
 #
 # Since: 2.9
@@ -1675,10 +1675,10 @@
 #
 # @auth: The current authentication type used by the non-websockets servers
 #
-# @vencrypt: #optional The vencrypt authentication type used by the servers,
+# @vencrypt: The vencrypt authentication type used by the servers,
 #            only specified in case auth == vencrypt.
 #
-# @display: #optional The display device the vnc server is linked to.
+# @display: The display device the vnc server is linked to.
 #
 # Since: 2.3
 ##
@@ -1755,7 +1755,7 @@
 #
 # Information about a SPICE server
 #
-# @auth: #optional authentication method
+# @auth: authentication method
 #
 # Since: 2.1
 ##
@@ -1817,16 +1817,16 @@
 # @migrated: true if the last guest migration completed and spice
 #            migration had completed as well. false otherwise. (since 1.4)
 #
-# @host: #optional The hostname the SPICE server is bound to.  This depends on
+# @host: The hostname the SPICE server is bound to.  This depends on
 #        the name resolution on the host and may be an IP address.
 #
-# @port: #optional The SPICE server's port number.
+# @port: The SPICE server's port number.
 #
-# @compiled-version: #optional SPICE server version.
+# @compiled-version: SPICE server version.
 #
-# @tls-port: #optional The SPICE server's TLS port number.
+# @tls-port: The SPICE server's TLS port number.
 #
-# @auth: #optional the current authentication type used by the server
+# @auth: the current authentication type used by the server
 #        'none'  if no authentication is being used
 #        'spice' uses SASL or direct TLS authentication, depending on command
 #                line options
@@ -1951,9 +1951,9 @@
 #
 # @size: memory size
 #
-# @prefetch: #optional if @type is 'memory', true if the memory is prefetchable
+# @prefetch: if @type is 'memory', true if the memory is prefetchable
 #
-# @mem_type_64: #optional if @type is 'memory', true if the BAR is 64-bit
+# @mem_type_64: if @type is 'memory', true if the BAR is 64-bit
 #
 # Since: 0.14.0
 ##
@@ -2009,7 +2009,7 @@
 #
 # Information about the Class of a PCI device
 #
-# @desc: #optional a string description of the device's class
+# @desc: a string description of the device's class
 #
 # @class: the class code of the device
 #
@@ -2047,7 +2047,7 @@
 #
 # @id: the PCI device id
 #
-# @irq: #optional if an IRQ is assigned to the device, the IRQ number
+# @irq: if an IRQ is assigned to the device, the IRQ number
 #
 # @qdev_id: the device name of the PCI device
 #
@@ -2337,7 +2337,7 @@
 #
 # @filename: the file to save the memory to as binary data
 #
-# @cpu-index: #optional the index of the virtual CPU to use for translating the
+# @cpu-index: the index of the virtual CPU to use for translating the
 #                       virtual address (defaults to CPU 0)
 #
 # Returns: Nothing on success
@@ -2566,7 +2566,7 @@
 #
 # Optional arguments to modify the behavior of a Transaction.
 #
-# @completion-mode: #optional Controls how jobs launched asynchronously by
+# @completion-mode: Controls how jobs launched asynchronously by
 #                   Actions will complete or fail as a group.
 #                   See @ActionCompletionMode for details.
 #
@@ -2610,7 +2610,7 @@
 # @actions: List of @TransactionAction;
 #           information needed for the respective operations.
 #
-# @properties: #optional structure of additional options to control the
+# @properties: structure of additional options to control the
 #              execution of the transaction. See @TransactionProperties
 #              for additional detail.
 #
@@ -2659,7 +2659,7 @@
 #
 # @command-line: the command to execute in the human monitor
 #
-# @cpu-index: #optional The CPU to use for commands that require an implicit CPU
+# @cpu-index: The CPU to use for commands that require an implicit CPU
 #
 # Returns: the output of the command as a string
 #
@@ -2895,7 +2895,7 @@
 #
 # @password: the new password
 #
-# @connected: #optional how to handle existing clients when changing the
+# @connected: how to handle existing clients when changing the
 #                       password.  If nothing is specified, defaults to `keep'
 #                       `fail' to fail the command if clients are connected
 #                       `disconnect' to disconnect existing clients
@@ -3054,7 +3054,7 @@
 #
 # @name: the name of the property
 # @type: the typename of the property
-# @description: #optional if specified, the description of the property.
+# @description: if specified, the description of the property.
 #               (since 2.2)
 #
 # Since: 1.2
@@ -3084,9 +3084,9 @@
 #
 # @uri: the Uniform Resource Identifier of the destination VM
 #
-# @blk: #optional do block migration (full disk copy)
+# @blk: do block migration (full disk copy)
 #
-# @inc: #optional incremental disk copy migration
+# @inc: incremental disk copy migration
 #
 # @detach: this argument exists only for compatibility reasons and
 #          is ignored by QEMU
@@ -3195,9 +3195,9 @@
 #
 # @driver: the name of the new device's driver
 #
-# @bus: #optional the device's parent bus (device tree path)
+# @bus: the device's parent bus (device tree path)
 #
-# @id: #optional the device's ID, must be unique
+# @id: the device's ID, must be unique
 #
 # Additional arguments depend on the type.
 #
@@ -3310,17 +3310,17 @@
 #            2. fd: the protocol starts with "fd:", and the following string
 #               is the fd's name.
 #
-# @detach: #optional if true, QMP will return immediately rather than
+# @detach: if true, QMP will return immediately rather than
 #          waiting for the dump to finish. The user can track progress
 #          using "query-dump". (since 2.6).
 #
-# @begin: #optional if specified, the starting physical address.
+# @begin: if specified, the starting physical address.
 #
-# @length: #optional if specified, the memory size, in bytes. If you don't
+# @length: if specified, the memory size, in bytes. If you don't
 #          want to dump all guest's memory, please specify the start @begin
 #          and @length
 #
-# @format: #optional if specified, the format of guest memory dump. But non-elf
+# @format: if specified, the format of guest memory dump. But non-elf
 #          format is conflict with paging and filter, ie. @paging, @begin and
 #          @length is not allowed to be specified with non-elf @format at the
 #          same time (since 2.0)
@@ -3512,7 +3512,7 @@
 #
 # @id: the name of the new object
 #
-# @props: #optional a dictionary of properties to be passed to the backend
+# @props: a dictionary of properties to be passed to the backend
 #
 # Returns: Nothing on success
 #          Error if @qom-type is not a valid class name
@@ -3565,15 +3565,15 @@
 #
 # Create a new Network Interface Card.
 #
-# @netdev: #optional id of -netdev to connect to
+# @netdev: id of -netdev to connect to
 #
-# @macaddr: #optional MAC address
+# @macaddr: MAC address
 #
-# @model: #optional device model (e1000, rtl8139, virtio etc.)
+# @model: device model (e1000, rtl8139, virtio etc.)
 #
-# @addr: #optional PCI device address
+# @addr: PCI device address
 #
-# @vectors: #optional number of MSI-x vectors, 0 to disable MSI-X
+# @vectors: number of MSI-x vectors, 0 to disable MSI-X
 #
 # Since: 1.2
 ##
@@ -3602,57 +3602,57 @@
 # Use the user mode network stack which requires no administrator privilege to
 # run.
 #
-# @hostname: #optional client hostname reported by the builtin DHCP server
+# @hostname: client hostname reported by the builtin DHCP server
 #
-# @restrict: #optional isolate the guest from the host
+# @restrict: isolate the guest from the host
 #
-# @ipv4: #optional whether to support IPv4, default true for enabled
+# @ipv4: whether to support IPv4, default true for enabled
 #        (since 2.6)
 #
-# @ipv6: #optional whether to support IPv6, default true for enabled
+# @ipv6: whether to support IPv6, default true for enabled
 #        (since 2.6)
 #
-# @ip: #optional legacy parameter, use net= instead
+# @ip: legacy parameter, use net= instead
 #
-# @net: #optional IP network address that the guest will see, in the
+# @net: IP network address that the guest will see, in the
 #       form addr[/netmask] The netmask is optional, and can be
 #       either in the form a.b.c.d or as a number of valid top-most
 #       bits. Default is 10.0.2.0/24.
 #
-# @host: #optional guest-visible address of the host
+# @host: guest-visible address of the host
 #
-# @tftp: #optional root directory of the built-in TFTP server
+# @tftp: root directory of the built-in TFTP server
 #
-# @bootfile: #optional BOOTP filename, for use with tftp=
+# @bootfile: BOOTP filename, for use with tftp=
 #
-# @dhcpstart: #optional the first of the 16 IPs the built-in DHCP server can
+# @dhcpstart: the first of the 16 IPs the built-in DHCP server can
 #             assign
 #
-# @dns: #optional guest-visible address of the virtual nameserver
+# @dns: guest-visible address of the virtual nameserver
 #
-# @dnssearch: #optional list of DNS suffixes to search, passed as DHCP option
+# @dnssearch: list of DNS suffixes to search, passed as DHCP option
 #             to the guest
 #
-# @ipv6-prefix: #optional IPv6 network prefix (default is fec0::) (since
+# @ipv6-prefix: IPv6 network prefix (default is fec0::) (since
 #               2.6). The network prefix is given in the usual
 #               hexadecimal IPv6 address notation.
 #
-# @ipv6-prefixlen: #optional IPv6 network prefix length (default is 64)
+# @ipv6-prefixlen: IPv6 network prefix length (default is 64)
 #                  (since 2.6)
 #
-# @ipv6-host: #optional guest-visible IPv6 address of the host (since 2.6)
+# @ipv6-host: guest-visible IPv6 address of the host (since 2.6)
 #
-# @ipv6-dns: #optional guest-visible IPv6 address of the virtual
+# @ipv6-dns: guest-visible IPv6 address of the virtual
 #            nameserver (since 2.6)
 #
-# @smb: #optional root directory of the built-in SMB server
+# @smb: root directory of the built-in SMB server
 #
-# @smbserver: #optional IP address of the built-in SMB server
+# @smbserver: IP address of the built-in SMB server
 #
-# @hostfwd: #optional redirect incoming TCP or UDP host connections to guest
+# @hostfwd: redirect incoming TCP or UDP host connections to guest
 #           endpoints
 #
-# @guestfwd: #optional forward guest TCP connections
+# @guestfwd: forward guest TCP connections
 #
 # Since: 1.2
 ##
@@ -3684,37 +3684,37 @@
 #
 # Connect the host TAP network interface name to the VLAN.
 #
-# @ifname: #optional interface name
+# @ifname: interface name
 #
-# @fd: #optional file descriptor of an already opened tap
+# @fd: file descriptor of an already opened tap
 #
-# @fds: #optional multiple file descriptors of already opened multiqueue capable
+# @fds: multiple file descriptors of already opened multiqueue capable
 # tap
 #
-# @script: #optional script to initialize the interface
+# @script: script to initialize the interface
 #
-# @downscript: #optional script to shut down the interface
+# @downscript: script to shut down the interface
 #
-# @br: #optional bridge name (since 2.8)
+# @br: bridge name (since 2.8)
 #
-# @helper: #optional command to execute to configure bridge
+# @helper: command to execute to configure bridge
 #
-# @sndbuf: #optional send buffer limit. Understands [TGMKkb] suffixes.
+# @sndbuf: send buffer limit. Understands [TGMKkb] suffixes.
 #
-# @vnet_hdr: #optional enable the IFF_VNET_HDR flag on the tap interface
+# @vnet_hdr: enable the IFF_VNET_HDR flag on the tap interface
 #
-# @vhost: #optional enable vhost-net network accelerator
+# @vhost: enable vhost-net network accelerator
 #
-# @vhostfd: #optional file descriptor of an already opened vhost net device
+# @vhostfd: file descriptor of an already opened vhost net device
 #
-# @vhostfds: #optional file descriptors of multiple already opened vhost net
+# @vhostfds: file descriptors of multiple already opened vhost net
 # devices
 #
-# @vhostforce: #optional vhost on for non-MSIX virtio guests
+# @vhostforce: vhost on for non-MSIX virtio guests
 #
-# @queues: #optional number of queues to be created for multiqueue capable tap
+# @queues: number of queues to be created for multiqueue capable tap
 #
-# @poll-us: #optional maximum number of microseconds that could
+# @poll-us: maximum number of microseconds that could
 # be spent on busy polling for tap (since 2.7)
 #
 # Since: 1.2
@@ -3743,17 +3743,17 @@
 # Connect the VLAN to a remote VLAN in another QEMU virtual machine using a TCP
 # socket connection.
 #
-# @fd: #optional file descriptor of an already opened socket
+# @fd: file descriptor of an already opened socket
 #
-# @listen: #optional port number, and optional hostname, to listen on
+# @listen: port number, and optional hostname, to listen on
 #
-# @connect: #optional port number, and optional hostname, to connect to
+# @connect: port number, and optional hostname, to connect to
 #
-# @mcast: #optional UDP multicast address and port number
+# @mcast: UDP multicast address and port number
 #
-# @localaddr: #optional source address and port for multicast and udp packets
+# @localaddr: source address and port for multicast and udp packets
 #
-# @udp: #optional UDP unicast address and port number
+# @udp: UDP unicast address and port number
 #
 # Since: 1.2
 ##
@@ -3775,32 +3775,32 @@
 #
 # @dst: destination address
 #
-# @srcport: #optional source port - mandatory for udp, optional for ip
+# @srcport: source port - mandatory for udp, optional for ip
 #
-# @dstport: #optional destination port - mandatory for udp, optional for ip
+# @dstport: destination port - mandatory for udp, optional for ip
 #
-# @ipv6: #optional force the use of ipv6
+# @ipv6: force the use of ipv6
 #
-# @udp: #optional use the udp version of l2tpv3 encapsulation
+# @udp: use the udp version of l2tpv3 encapsulation
 #
-# @cookie64: #optional use 64 bit coookies
+# @cookie64: use 64 bit coookies
 #
-# @counter: #optional have sequence counter
+# @counter: have sequence counter
 #
-# @pincounter: #optional pin sequence counter to zero -
+# @pincounter: pin sequence counter to zero -
 #              workaround for buggy implementations or
 #              networks with packet reorder
 #
-# @txcookie: #optional 32 or 64 bit transmit cookie
+# @txcookie: 32 or 64 bit transmit cookie
 #
-# @rxcookie: #optional 32 or 64 bit receive cookie
+# @rxcookie: 32 or 64 bit receive cookie
 #
 # @txsession: 32 bit transmit session
 #
-# @rxsession: #optional 32 bit receive session - if not specified
+# @rxsession: 32 bit receive session - if not specified
 #             set to the same value as transmit
 #
-# @offset: #optional additional offset - allows the insertion of
+# @offset: additional offset - allows the insertion of
 #          additional application-specific data before the packet payload
 #
 # Since: 2.1
@@ -3827,13 +3827,13 @@
 #
 # Connect the VLAN to a vde switch running on the host.
 #
-# @sock: #optional socket path
+# @sock: socket path
 #
-# @port: #optional port number
+# @port: port number
 #
-# @group: #optional group owner of socket
+# @group: group owner of socket
 #
-# @mode: #optional permissions for socket
+# @mode: permissions for socket
 #
 # Since: 1.2
 ##
@@ -3849,10 +3849,10 @@
 #
 # Dump VLAN network traffic to a file.
 #
-# @len: #optional per-packet size limit (64k default). Understands [TGMKkb]
+# @len: per-packet size limit (64k default). Understands [TGMKkb]
 # suffixes.
 #
-# @file: #optional dump file path (default is qemu-vlan0.pcap)
+# @file: dump file path (default is qemu-vlan0.pcap)
 #
 # Since: 1.2
 ##
@@ -3866,9 +3866,9 @@
 #
 # Connect a host TAP network interface to a host bridge device.
 #
-# @br: #optional bridge name
+# @br: bridge name
 #
-# @helper: #optional command to execute to configure bridge
+# @helper: command to execute to configure bridge
 #
 # Since: 1.2
 ##
@@ -3902,7 +3902,7 @@
 #          YYY identifies a port of the switch. VALE ports having the
 #          same XXX are therefore connected to the same switch.
 #
-# @devname: #optional path of the netmap device (default: '/dev/netmap').
+# @devname: path of the netmap device (default: '/dev/netmap').
 #
 # Since: 2.0
 ##
@@ -3918,9 +3918,9 @@
 #
 # @chardev: name of a unix socket chardev
 #
-# @vhostforce: #optional vhost on for non-MSIX virtio guests (default: false).
+# @vhostforce: vhost on for non-MSIX virtio guests (default: false).
 #
-# @queues: #optional number of queues to be created for multiqueue vhost-user
+# @queues: number of queues to be created for multiqueue vhost-user
 #          (default: 1) (Since 2.5)
 #
 # Since: 2.1
@@ -3977,11 +3977,11 @@
 #
 # Captures the configuration of a network device; legacy.
 #
-# @vlan: #optional vlan number
+# @vlan: vlan number
 #
-# @id: #optional identifier for monitor commands
+# @id: identifier for monitor commands
 #
-# @name: #optional identifier for monitor commands, ignored if @id is present
+# @name: identifier for monitor commands, ignored if @id is present
 #
 # @opts: device type specific properties (legacy)
 #
@@ -4055,17 +4055,15 @@
 #
 # @port: port part of the address, or lowest port if @to is present
 #
-# @numeric: #optional true if the host/port are guaranteed to be numeric,
+# @numeric: true if the host/port are guaranteed to be numeric,
 #           false if name resolution should be attempted. Defaults to false.
 #           (Since 2.9)
 #
 # @to: highest port to try
 #
 # @ipv4: whether to accept IPv4 addresses, default try both IPv4 and IPv6
-#        #optional
 #
 # @ipv6: whether to accept IPv6 addresses, default try both IPv4 and IPv6
-#        #optional
 #
 # Since: 1.3
 ##
@@ -4213,9 +4211,9 @@
 #
 # @name: the name of the machine
 #
-# @alias: #optional an alias for the machine name
+# @alias: an alias for the machine name
 #
-# @is-default: #optional whether the machine is default
+# @is-default: whether the machine is default
 #
 # @cpu-max: maximum number of CPUs supported by the machine type
 #           (since 1.5.0)
@@ -4247,7 +4245,7 @@
 #
 # @name: the name of the CPU definition
 #
-# @migration-safe: #optional whether a CPU definition can be safely used for
+# @migration-safe: whether a CPU definition can be safely used for
 #                  migration in combination with a QEMU compatibility machine
 #                  when migrating between different QMU versions and between
 #                  hosts with different sets of (hardware or software)
@@ -4259,7 +4257,7 @@
 #          QEMU version, machine type, machine options and accelerator options.
 #          A static model is always migration-safe. (since 2.8)
 #
-# @unavailable-features: #optional List of properties that prevent
+# @unavailable-features: List of properties that prevent
 #                        the CPU model from running in the current
 #                        host. (since 2.8)
 # @typename: Type name that can be used as argument to @device-list-properties,
@@ -4310,7 +4308,7 @@
 # However, if required, architectures can expose relevant properties.
 #
 # @name: the name of the CPU definition the model is based on
-# @props: #optional a dictionary of QOM properties to be applied
+# @props: a dictionary of QOM properties to be applied
 #
 # Since: 2.8.0
 ##
@@ -4559,9 +4557,9 @@
 #
 # Add a file descriptor, that was passed via SCM rights, to an fd set.
 #
-# @fdset-id: #optional The ID of the fd set to add the file descriptor to.
+# @fdset-id: The ID of the fd set to add the file descriptor to.
 #
-# @opaque: #optional A free-form string that can be used to describe the fd.
+# @opaque: A free-form string that can be used to describe the fd.
 #
 # Returns: @AddfdInfo on success
 #
@@ -4591,7 +4589,7 @@
 #
 # @fdset-id: The ID of the fd set that the file descriptor belongs to.
 #
-# @fd: #optional The file descriptor that is to be removed.
+# @fd: The file descriptor that is to be removed.
 #
 # Returns: Nothing on success
 #          If @fdset-id or @fd is not found, FdNotFound
@@ -4618,7 +4616,7 @@
 #
 # @fd: The file descriptor value.
 #
-# @opaque: #optional A free-form string that can be used to describe the fd.
+# @opaque: A free-form string that can be used to describe the fd.
 #
 # Since: 1.2.0
 ##
@@ -4769,7 +4767,7 @@
 #        directly to the guest, while @KeyValue.qcode must be a valid
 #        @QKeyCode value
 #
-# @hold-time: #optional time to delay key up events, milliseconds. Defaults
+# @hold-time: time to delay key up events, milliseconds. Defaults
 #             to 100
 #
 # Returns: Nothing on success
@@ -4815,8 +4813,8 @@
 #
 # Configuration shared across all chardev backends
 #
-# @logfile: #optional The name of a logfile to save output
-# @logappend: #optional true to append instead of truncate
+# @logfile: The name of a logfile to save output
+# @logappend: true to append instead of truncate
 #             (default to false to truncate)
 #
 # Since: 2.6
@@ -4829,9 +4827,9 @@
 #
 # Configuration info for file chardevs.
 #
-# @in:  #optional The name of the input file
+# @in:  The name of the input file
 # @out: The name of the output file
-# @append: #optional Open the file in append mode (default false to
+# @append: Open the file in append mode (default false to
 #          truncate) (Since 2.6)
 #
 # Since: 1.4
@@ -4861,14 +4859,14 @@
 #
 # @addr: socket address to listen on (server=true)
 #        or connect to (server=false)
-# @tls-creds: #optional the ID of the TLS credentials object (since 2.6)
-# @server: #optional create server socket (default: true)
-# @wait: #optional wait for incoming connection on server
+# @tls-creds: the ID of the TLS credentials object (since 2.6)
+# @server: create server socket (default: true)
+# @wait: wait for incoming connection on server
 #        sockets (default: false).
-# @nodelay: #optional set TCP_NODELAY socket option (default: false)
-# @telnet: #optional enable telnet protocol on server
+# @nodelay: set TCP_NODELAY socket option (default: false)
+# @telnet: enable telnet protocol on server
 #          sockets (default: false)
-# @reconnect: #optional For a client socket, if a socket is disconnected,
+# @reconnect: For a client socket, if a socket is disconnected,
 #          then attempt a reconnect after the given number of seconds.
 #          Setting this to zero disables this function. (default: 0)
 #          (Since: 2.2)
@@ -4890,7 +4888,7 @@
 # Configuration info for datagram socket chardevs.
 #
 # @remote: remote address
-# @local: #optional local address
+# @local: local address
 #
 # Since: 1.5
 ##
@@ -4915,7 +4913,7 @@
 #
 # Configuration info for stdio chardevs.
 #
-# @signal: #optional Allow signals (such as SIGINT triggered by ^C)
+# @signal: Allow signals (such as SIGINT triggered by ^C)
 #          be delivered to qemu.  Default: true in -nographic mode,
 #          false otherwise.
 #
@@ -4972,7 +4970,7 @@
 #
 # Configuration info for ring buffer chardevs.
 #
-# @size: #optional ring buffer size, must be power of two, default is 65536
+# @size: ring buffer size, must be power of two, default is 65536
 #
 # Since: 1.5
 ##
@@ -5013,7 +5011,7 @@
 #
 # Return info about the chardev backend just created.
 #
-# @pty: #optional name of the slave pseudoterminal device, present if
+# @pty: name of the slave pseudoterminal device, present if
 #       and only if a chardev of type 'pty' was created
 #
 # Since: 1.4
@@ -5135,9 +5133,9 @@
 #
 # Information about the TPM passthrough type
 #
-# @path: #optional string describing the path used for accessing the TPM device
+# @path: string describing the path used for accessing the TPM device
 #
-# @cancel-path: #optional string showing the TPM's sysfs cancel file
+# @cancel-path: string showing the TPM's sysfs cancel file
 #               for cancellation of TPM commands while they are executing
 #
 # Since: 1.5
@@ -5223,28 +5221,28 @@
 # String fields are copied into the matching ACPI member from lowest address
 # upwards, and silently truncated / NUL-padded to length.
 #
-# @sig: #optional table signature / identifier (4 bytes)
+# @sig: table signature / identifier (4 bytes)
 #
-# @rev: #optional table revision number (dependent on signature, 1 byte)
+# @rev: table revision number (dependent on signature, 1 byte)
 #
-# @oem_id: #optional OEM identifier (6 bytes)
+# @oem_id: OEM identifier (6 bytes)
 #
-# @oem_table_id: #optional OEM table identifier (8 bytes)
+# @oem_table_id: OEM table identifier (8 bytes)
 #
-# @oem_rev: #optional OEM-supplied revision number (4 bytes)
+# @oem_rev: OEM-supplied revision number (4 bytes)
 #
-# @asl_compiler_id: #optional identifier of the utility that created the table
+# @asl_compiler_id: identifier of the utility that created the table
 #                   (4 bytes)
 #
-# @asl_compiler_rev: #optional revision number of the utility that created the
+# @asl_compiler_rev: revision number of the utility that created the
 #                    table (4 bytes)
 #
-# @file: #optional colon (:) separated list of pathnames to load and
+# @file: colon (:) separated list of pathnames to load and
 #        concatenate as table data. The resultant binary blob is expected to
 #        have an ACPI table header. At least one file is required. This field
 #        excludes @data.
 #
-# @data: #optional colon (:) separated list of pathnames to load and
+# @data: colon (:) separated list of pathnames to load and
 #        concatenate as table data. The resultant binary blob must not have an
 #        ACPI table header. At least one file is required. This field excludes
 #        @file.
@@ -5291,9 +5289,9 @@
 #
 # @type: parameter @CommandLineParameterType
 #
-# @help: #optional human readable text string, not suitable for parsing.
+# @help: human readable text string, not suitable for parsing.
 #
-# @default: #optional default value string (since 2.1)
+# @default: default value string (since 2.1)
 #
 # Since: 1.5
 ##
@@ -5322,7 +5320,7 @@
 #
 # Query command line option schema.
 #
-# @option: #optional option name
+# @option: option name
 #
 # Returns: list of @CommandLineOptionInfo for all options (or for the given
 #          @option).  Returns an error if the given @option doesn't exist.
@@ -5371,7 +5369,7 @@
 #
 # @cpuid-input-eax: Input EAX value for CPUID instruction for that feature word
 #
-# @cpuid-input-ecx: #optional Input ECX value for CPUID instruction for that
+# @cpuid-input-ecx: Input ECX value for CPUID instruction for that
 #                   feature word
 #
 # @cpuid-register: Output register containing the feature bits
@@ -5463,7 +5461,7 @@
 #
 # Return rx-filter information for all NICs (or for the given NIC).
 #
-# @name: #optional net client name
+# @name: net client name
 #
 # Returns: list of @RxFilterInfo for all NICs (or for the given NIC).
 #          Returns an error if the given @name doesn't exist, or given
@@ -5597,8 +5595,8 @@
 #
 # Send input event(s) to guest.
 #
-# @device: #optional display device to send event(s) to.
-# @head: #optional head to send event(s) to, in case the
+# @device: display device to send event(s) to.
+# @head: head to send event(s) to, in case the
 #        display device supports multiple scanouts.
 # @events: List of InputEvent union.
 #
@@ -5690,16 +5688,16 @@
 #
 # Create a guest NUMA node. (for OptsVisitor)
 #
-# @nodeid: #optional NUMA node ID (increase by 1 from 0 if omitted)
+# @nodeid: NUMA node ID (increase by 1 from 0 if omitted)
 #
-# @cpus: #optional VCPUs belonging to this node (assign VCPUS round-robin
+# @cpus: VCPUs belonging to this node (assign VCPUS round-robin
 #         if omitted)
 #
-# @mem: #optional memory size of this node; mutually exclusive with @memdev.
+# @mem: memory size of this node; mutually exclusive with @memdev.
 #       Equally divide total memory among nodes if both @mem and @memdev are
 #       omitted.
 #
-# @memdev: #optional memory backend object.  If specified for one node,
+# @memdev: memory backend object.  If specified for one node,
 #          it must be specified for all nodes.
 #
 # Since: 2.1
@@ -5736,7 +5734,7 @@
 #
 # Information about memory backend
 #
-# @id: #optional backend's ID if backend has 'id' property (since 2.9)
+# @id: backend's ID if backend has 'id' property (since 2.9)
 #
 # @size: memory backend size
 #
@@ -5803,7 +5801,7 @@
 #
 # PCDIMMDevice state information
 #
-# @id: #optional device's ID
+# @id: device's ID
 #
 # @addr: physical address, where device is mapped
 #
@@ -5882,7 +5880,7 @@
 # For description of possible values of @source and @status fields
 # see "_OST (OSPM Status Indication)" chapter of ACPI5.0 spec.
 #
-# @device: #optional device ID associated with slot
+# @device: device ID associated with slot
 #
 # @slot: slot ID, unique per slot of a given @slot-type
 #
@@ -6080,7 +6078,7 @@
 #
 # @primary: true for primary or false for secondary.
 #
-# @failover: #optional true to do failover, false to stop. but cannot be
+# @failover: true to do failover, false to stop. but cannot be
 #            specified if 'enable' is true. default value is false.
 #
 # Returns: nothing.
@@ -6103,7 +6101,7 @@
 #
 # @error: true if an error happened, false if replication is normal.
 #
-# @desc: #optional the human readable error description string, when
+# @desc: the human readable error description string, when
 #        @error is 'true'.
 #
 # Since: 2.9
@@ -6194,10 +6192,10 @@
 # it should be passed by management with device_add command when
 # a CPU is being hotplugged.
 #
-# @node-id: #optional NUMA node ID the CPU belongs to
-# @socket-id: #optional socket number within node/board the CPU belongs to
-# @core-id: #optional core number within socket the CPU belongs to
-# @thread-id: #optional thread number within core the CPU belongs to
+# @node-id: NUMA node ID the CPU belongs to
+# @socket-id: socket number within node/board the CPU belongs to
+# @core-id: core number within socket the CPU belongs to
+# @thread-id: thread number within core the CPU belongs to
 #
 # Note: currently there are 4 properties that could be present
 # but management should be prepared to pass through other
@@ -6221,7 +6219,7 @@
 # @type: CPU object type for usage with device_add command
 # @props: list of properties to be used for hotplugging CPU
 # @vcpus-count: number of logical VCPU threads @HotpluggableCPU provides
-# @qom-path: #optional link to existing CPU object if CPU is present or
+# @qom-path: link to existing CPU object if CPU is present or
 #            omitted if CPU is not present.
 #
 # Since: 2.7
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 786b39e..1be1ec5 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -37,9 +37,9 @@
 #
 # @compat: compatibility level
 #
-# @lazy-refcounts: #optional on or off; only valid for compat >= 1.1
+# @lazy-refcounts: on or off; only valid for compat >= 1.1
 #
-# @corrupt: #optional true if the image has been marked corrupt; only valid for
+# @corrupt: true if the image has been marked corrupt; only valid for
 #           compat >= 1.1 (since 2.2)
 #
 # @refcount-bits: width of a refcount entry in bits (since 2.3)
@@ -103,27 +103,27 @@
 #
 # @virtual-size: maximum capacity in bytes of the image
 #
-# @actual-size: #optional actual size on disk in bytes of the image
+# @actual-size: actual size on disk in bytes of the image
 #
-# @dirty-flag: #optional true if image is not cleanly closed
+# @dirty-flag: true if image is not cleanly closed
 #
-# @cluster-size: #optional size of a cluster in bytes
+# @cluster-size: size of a cluster in bytes
 #
-# @encrypted: #optional true if the image is encrypted
+# @encrypted: true if the image is encrypted
 #
-# @compressed: #optional true if the image is compressed (Since 1.7)
+# @compressed: true if the image is compressed (Since 1.7)
 #
-# @backing-filename: #optional name of the backing file
+# @backing-filename: name of the backing file
 #
-# @full-backing-filename: #optional full path of the backing file
+# @full-backing-filename: full path of the backing file
 #
-# @backing-filename-format: #optional the format of the backing file
+# @backing-filename-format: the format of the backing file
 #
-# @snapshots: #optional list of VM snapshots
+# @snapshots: list of VM snapshots
 #
-# @backing-image: #optional info of the backing image (since 1.6)
+# @backing-image: info of the backing image (since 1.6)
 #
-# @format-specific: #optional structure supplying additional format-specific
+# @format-specific: structure supplying additional format-specific
 # information (since 1.7)
 #
 # Since: 1.3
@@ -149,31 +149,31 @@
 #
 # @check-errors: number of unexpected errors occurred during check
 #
-# @image-end-offset: #optional offset (in bytes) where the image ends, this
+# @image-end-offset: offset (in bytes) where the image ends, this
 #                    field is present if the driver for the image format
 #                    supports it
 #
-# @corruptions: #optional number of corruptions found during the check if any
+# @corruptions: number of corruptions found during the check if any
 #
-# @leaks: #optional number of leaks found during the check if any
+# @leaks: number of leaks found during the check if any
 #
-# @corruptions-fixed: #optional number of corruptions fixed during the check
+# @corruptions-fixed: number of corruptions fixed during the check
 #                     if any
 #
-# @leaks-fixed: #optional number of leaks fixed during the check if any
+# @leaks-fixed: number of leaks fixed during the check if any
 #
-# @total-clusters: #optional total number of clusters, this field is present
+# @total-clusters: total number of clusters, this field is present
 #                  if the driver for the image format supports it
 #
-# @allocated-clusters: #optional total number of allocated clusters, this
+# @allocated-clusters: total number of allocated clusters, this
 #                      field is present if the driver for the image format
 #                      supports it
 #
-# @fragmented-clusters: #optional total number of fragmented clusters, this
+# @fragmented-clusters: total number of fragmented clusters, this
 #                       field is present if the driver for the image format
 #                       supports it
 #
-# @compressed-clusters: #optional total number of compressed clusters, this
+# @compressed-clusters: total number of compressed clusters, this
 #                       field is present if the driver for the image format
 #                       supports it
 #
@@ -202,9 +202,9 @@
 #
 # @depth: the depth of the mapping
 #
-# @offset: #optional the offset in file that the virtual sectors are mapped to
+# @offset: the offset in file that the virtual sectors are mapped to
 #
-# @filename: #optional filename that is referred to by @offset
+# @filename: filename that is referred to by @offset
 #
 # Since: 2.6
 #
@@ -237,7 +237,7 @@
 #
 # @file: the filename of the backing device
 #
-# @node-name: #optional the name of the block driver node (Since 2.0)
+# @node-name: the name of the block driver node (Since 2.0)
 #
 # @ro: true if the backing device was open read-only
 #
@@ -253,7 +253,7 @@
 #       2.8: 'replication' added, 'tftp' dropped
 #       2.9: 'archipelago' dropped
 #
-# @backing_file: #optional the name of the backing file (for copy-on-write)
+# @backing_file: the name of the backing file (for copy-on-write)
 #
 # @backing_file_depth: number of files in the backing file chain (since: 1.2)
 #
@@ -278,45 +278,45 @@
 #
 # @image: the info of image used (since: 1.6)
 #
-# @bps_max: #optional total throughput limit during bursts,
+# @bps_max: total throughput limit during bursts,
 #                     in bytes (Since 1.7)
 #
-# @bps_rd_max: #optional read throughput limit during bursts,
+# @bps_rd_max: read throughput limit during bursts,
 #                        in bytes (Since 1.7)
 #
-# @bps_wr_max: #optional write throughput limit during bursts,
+# @bps_wr_max: write throughput limit during bursts,
 #                        in bytes (Since 1.7)
 #
-# @iops_max: #optional total I/O operations per second during bursts,
+# @iops_max: total I/O operations per second during bursts,
 #                      in bytes (Since 1.7)
 #
-# @iops_rd_max: #optional read I/O operations per second during bursts,
+# @iops_rd_max: read I/O operations per second during bursts,
 #                         in bytes (Since 1.7)
 #
-# @iops_wr_max: #optional write I/O operations per second during bursts,
+# @iops_wr_max: write I/O operations per second during bursts,
 #                         in bytes (Since 1.7)
 #
-# @bps_max_length: #optional maximum length of the @bps_max burst
+# @bps_max_length: maximum length of the @bps_max burst
 #                            period, in seconds. (Since 2.6)
 #
-# @bps_rd_max_length: #optional maximum length of the @bps_rd_max
+# @bps_rd_max_length: maximum length of the @bps_rd_max
 #                               burst period, in seconds. (Since 2.6)
 #
-# @bps_wr_max_length: #optional maximum length of the @bps_wr_max
+# @bps_wr_max_length: maximum length of the @bps_wr_max
 #                               burst period, in seconds. (Since 2.6)
 #
-# @iops_max_length: #optional maximum length of the @iops burst
+# @iops_max_length: maximum length of the @iops burst
 #                             period, in seconds. (Since 2.6)
 #
-# @iops_rd_max_length: #optional maximum length of the @iops_rd_max
+# @iops_rd_max_length: maximum length of the @iops_rd_max
 #                                burst period, in seconds. (Since 2.6)
 #
-# @iops_wr_max_length: #optional maximum length of the @iops_wr_max
+# @iops_wr_max_length: maximum length of the @iops_wr_max
 #                                burst period, in seconds. (Since 2.6)
 #
-# @iops_size: #optional an I/O size in bytes (Since 1.7)
+# @iops_size: an I/O size in bytes (Since 1.7)
 #
-# @group: #optional throttle group name (Since 2.4)
+# @group: throttle group name (Since 2.4)
 #
 # @cache: the cache mode used for the block device (since: 2.3)
 #
@@ -411,7 +411,7 @@
 #
 # Block dirty bitmap information.
 #
-# @name: #optional the name of the dirty bitmap (Since 2.4)
+# @name: the name of the dirty bitmap (Since 2.4)
 #
 # @count: number of dirty bytes according to the dirty bitmap
 #
@@ -441,17 +441,17 @@
 # @locked: True if the guest has locked this device from having its media
 #          removed
 #
-# @tray_open: #optional True if the device's tray is open
+# @tray_open: True if the device's tray is open
 #             (only present if it has a tray)
 #
-# @dirty-bitmaps: #optional dirty bitmaps information (only present if the
+# @dirty-bitmaps: dirty bitmaps information (only present if the
 #                 driver has one or more dirty bitmaps) (Since 2.0)
 #
-# @io-status: #optional @BlockDeviceIoStatus. Only present if the device
+# @io-status: @BlockDeviceIoStatus. Only present if the device
 #             supports it and the VM is configured to stop on errors
 #             (supported device models: virtio-blk, ide, scsi-disk)
 #
-# @inserted: #optional @BlockDeviceInfo describing the device if media is
+# @inserted: @BlockDeviceInfo describing the device if media is
 #            present
 #
 # Since:  0.14.0
@@ -640,7 +640,7 @@
 # @wr_merged: Number of write requests that have been merged into another
 #             request (Since 2.3).
 #
-# @idle_time_ns: #optional Time since the last I/O operation, in
+# @idle_time_ns: Time since the last I/O operation, in
 #                nanoseconds. If the field is absent it means that
 #                there haven't been any operations yet (Since 2.5).
 #
@@ -690,19 +690,19 @@
 #
 # Statistics of a virtual block device or a block backing device.
 #
-# @device: #optional If the stats are for a virtual block device, the name
+# @device: If the stats are for a virtual block device, the name
 #          corresponding to the virtual block device.
 #
-# @node-name: #optional The node name of the device. (Since 2.3)
+# @node-name: The node name of the device. (Since 2.3)
 #
 # @stats:  A @BlockDeviceStats for the device.
 #
-# @parent: #optional This describes the file block device if it has one.
+# @parent: This describes the file block device if it has one.
 #          Contains recursively the statistics of the underlying
 #          protocol (e.g. the host file for a qcow2 image). If there is
 #          no underlying protocol, this field is omitted
 #
-# @backing: #optional This describes the backing block device if it has one.
+# @backing: This describes the backing block device if it has one.
 #           (Since 2.0)
 #
 # Since: 0.14.0
@@ -718,7 +718,7 @@
 #
 # Query the @BlockStats for all virtual block devices.
 #
-# @query-nodes: #optional If true, the command will query all the block nodes
+# @query-nodes: If true, the command will query all the block nodes
 #               that have a node name, in a list which will include "parent"
 #               information, but not "backing".
 #               If false or omitted, the behavior is as before - query all the
@@ -957,9 +957,9 @@
 #
 # Either @device or @node-name must be set but not both.
 #
-# @device: #optional the name of the block backend device to set the password on
+# @device: the name of the block backend device to set the password on
 #
-# @node-name: #optional graph node name to set the password on (Since 2.0)
+# @node-name: graph node name to set the password on (Since 2.0)
 #
 # @password: the password to use for the device
 #
@@ -990,9 +990,9 @@
 #
 # Either @device or @node-name must be set but not both.
 #
-# @device: #optional the name of the device to get the image resized
+# @device: the name of the device to get the image resized
 #
-# @node-name: #optional graph node name to get the image resized (Since 2.0)
+# @node-name: graph node name to get the image resized (Since 2.0)
 #
 # @size:  new image size in bytes
 #
@@ -1034,19 +1034,19 @@
 #
 # Either @device or @node-name must be set but not both.
 #
-# @device: #optional the name of the device to generate the snapshot from.
+# @device: the name of the device to generate the snapshot from.
 #
-# @node-name: #optional graph node name to generate the snapshot from (Since 2.0)
+# @node-name: graph node name to generate the snapshot from (Since 2.0)
 #
 # @snapshot-file: the target of the new image. If the file exists, or
 # if it is a device, the snapshot will be created in the existing
 # file/device. Otherwise, a new file will be created.
 #
-# @snapshot-node-name: #optional the graph node name of the new image (Since 2.0)
+# @snapshot-node-name: the graph node name of the new image (Since 2.0)
 #
-# @format: #optional the format of the snapshot image, default is 'qcow2'.
+# @format: the format of the snapshot image, default is 'qcow2'.
 #
-# @mode: #optional whether and how QEMU should create a new image, default is
+# @mode: whether and how QEMU should create a new image, default is
 #        'absolute-paths'.
 ##
 { 'struct': 'BlockdevSnapshotSync',
@@ -1072,7 +1072,7 @@
 ##
 # @DriveBackup:
 #
-# @job-id: #optional identifier for the newly-created block job. If
+# @job-id: identifier for the newly-created block job. If
 #          omitted, the device name will be used. (Since 2.7)
 #
 # @device: the device name or node-name of a root node which should be copied.
@@ -1081,30 +1081,30 @@
 #          is a device, the existing file/device will be used as the new
 #          destination.  If it does not exist, a new file will be created.
 #
-# @format: #optional the format of the new destination, default is to
+# @format: the format of the new destination, default is to
 #          probe if @mode is 'existing', else the format of the source
 #
 # @sync: what parts of the disk image should be copied to the destination
 #        (all the disk, only the sectors allocated in the topmost image, from a
 #        dirty bitmap, or only new I/O).
 #
-# @mode: #optional whether and how QEMU should create a new image, default is
+# @mode: whether and how QEMU should create a new image, default is
 #        'absolute-paths'.
 #
-# @speed: #optional the maximum speed, in bytes per second
+# @speed: the maximum speed, in bytes per second
 #
-# @bitmap: #optional the name of dirty bitmap if sync is "incremental".
+# @bitmap: the name of dirty bitmap if sync is "incremental".
 #          Must be present if sync is "incremental", must NOT be present
 #          otherwise. (Since 2.4)
 #
-# @compress: #optional true to compress data, if the target format supports it.
+# @compress: true to compress data, if the target format supports it.
 #            (default: false) (since 2.8)
 #
-# @on-source-error: #optional the action to take on an error on the source,
+# @on-source-error: the action to take on an error on the source,
 #                   default 'report'.  'stop' and 'enospc' can only be used
 #                   if the block device supports io-status (see BlockInfo).
 #
-# @on-target-error: #optional the action to take on an error on the target,
+# @on-target-error: the action to take on an error on the target,
 #                   default 'report' (no limitations, since this applies to
 #                   a different block device than @device).
 #
@@ -1124,7 +1124,7 @@
 ##
 # @BlockdevBackup:
 #
-# @job-id: #optional identifier for the newly-created block job. If
+# @job-id: identifier for the newly-created block job. If
 #          omitted, the device name will be used. (Since 2.7)
 #
 # @device: the device name or node-name of a root node which should be copied.
@@ -1135,17 +1135,17 @@
 #        (all the disk, only the sectors allocated in the topmost image, or
 #        only new I/O).
 #
-# @speed: #optional the maximum speed, in bytes per second. The default is 0,
+# @speed: the maximum speed, in bytes per second. The default is 0,
 #         for unlimited.
 #
-# @compress: #optional true to compress data, if the target format supports it.
+# @compress: true to compress data, if the target format supports it.
 #            (default: false) (since 2.8)
 #
-# @on-source-error: #optional the action to take on an error on the source,
+# @on-source-error: the action to take on an error on the source,
 #                   default 'report'.  'stop' and 'enospc' can only be used
 #                   if the block device supports io-status (see BlockInfo).
 #
-# @on-target-error: #optional the action to take on an error on the target,
+# @on-target-error: the action to take on an error on the target,
 #                   default 'report' (no limitations, since this applies to
 #                   a different block device than @device).
 #
@@ -1262,19 +1262,19 @@
 # Live commit of data from overlay image nodes into backing nodes - i.e.,
 # writes data between 'top' and 'base' into 'base'.
 #
-# @job-id: #optional identifier for the newly-created block job. If
+# @job-id: identifier for the newly-created block job. If
 #          omitted, the device name will be used. (Since 2.7)
 #
 # @device:  the device name or node-name of a root node
 #
-# @base:   #optional The file name of the backing image to write data into.
+# @base:   The file name of the backing image to write data into.
 #                    If not specified, this is the deepest backing image.
 #
-# @top:    #optional The file name of the backing image within the image chain,
+# @top:    The file name of the backing image within the image chain,
 #                    which contains the topmost data to be committed down. If
 #                    not specified, this is the active layer.
 #
-# @backing-file:  #optional The backing file string to write into the overlay
+# @backing-file:  The backing file string to write into the overlay
 #                           image of 'top'.  If 'top' is the active layer,
 #                           specifying a backing file string is an error. This
 #                           filename is not validated.
@@ -1303,9 +1303,9 @@
 #                    size of the smaller top, you can safely truncate it
 #                    yourself once the commit operation successfully completes.
 #
-# @speed:  #optional the maximum speed, in bytes per second
+# @speed:  the maximum speed, in bytes per second
 #
-# @filter-node-name: #optional the node name that should be assigned to the
+# @filter-node-name: the node name that should be assigned to the
 #                    filter driver that the commit job inserts into the graph
 #                    above @top. If this option is not given, a node name is
 #                    autogenerated. (Since: 2.9)
@@ -1483,7 +1483,7 @@
 #
 # A set of parameters describing drive mirror setup.
 #
-# @job-id: #optional identifier for the newly-created block job. If
+# @job-id: identifier for the newly-created block job. If
 #          omitted, the device name will be used. (Since 2.7)
 #
 # @device:  the device name or node-name of a root node whose writes should be
@@ -1493,41 +1493,41 @@
 #          is a device, the existing file/device will be used as the new
 #          destination.  If it does not exist, a new file will be created.
 #
-# @format: #optional the format of the new destination, default is to
+# @format: the format of the new destination, default is to
 #          probe if @mode is 'existing', else the format of the source
 #
-# @node-name: #optional the new block driver state node name in the graph
+# @node-name: the new block driver state node name in the graph
 #             (Since 2.1)
 #
-# @replaces: #optional with sync=full graph node name to be replaced by the new
+# @replaces: with sync=full graph node name to be replaced by the new
 #            image when a whole image copy is done. This can be used to repair
 #            broken Quorum files. (Since 2.1)
 #
-# @mode: #optional whether and how QEMU should create a new image, default is
+# @mode: whether and how QEMU should create a new image, default is
 #        'absolute-paths'.
 #
-# @speed:  #optional the maximum speed, in bytes per second
+# @speed:  the maximum speed, in bytes per second
 #
 # @sync: what parts of the disk image should be copied to the destination
 #        (all the disk, only the sectors allocated in the topmost image, or
 #        only new I/O).
 #
-# @granularity: #optional granularity of the dirty bitmap, default is 64K
+# @granularity: granularity of the dirty bitmap, default is 64K
 #               if the image format doesn't have clusters, 4K if the clusters
 #               are smaller than that, else the cluster size.  Must be a
 #               power of 2 between 512 and 64M (since 1.4).
 #
-# @buf-size: #optional maximum amount of data in flight from source to
+# @buf-size: maximum amount of data in flight from source to
 #            target (since 1.4).
 #
-# @on-source-error: #optional the action to take on an error on the source,
+# @on-source-error: the action to take on an error on the source,
 #                   default 'report'.  'stop' and 'enospc' can only be used
 #                   if the block device supports io-status (see BlockInfo).
 #
-# @on-target-error: #optional the action to take on an error on the target,
+# @on-target-error: the action to take on an error on the target,
 #                   default 'report' (no limitations, since this applies to
 #                   a different block device than @device).
-# @unmap: #optional Whether to try to unmap target sectors where source has
+# @unmap: Whether to try to unmap target sectors where source has
 #         only zero. If true, and target unallocated sectors will read as zero,
 #         target image sectors will be unmapped; otherwise, zeroes will be
 #         written. Both will result in identical contents.
@@ -1563,7 +1563,7 @@
 #
 # @name: name of the dirty bitmap
 #
-# @granularity: #optional the bitmap granularity, default is 64k for
+# @granularity: the bitmap granularity, default is 64k for
 #               block-dirty-bitmap-add
 #
 # Since: 2.4
@@ -1643,7 +1643,7 @@
 #
 # Start mirroring a block device's writes to a new destination.
 #
-# @job-id: #optional identifier for the newly-created block job. If
+# @job-id: identifier for the newly-created block job. If
 #          omitted, the device name will be used. (Since 2.7)
 #
 # @device: The device name or node-name of a root node whose writes should be
@@ -1652,33 +1652,33 @@
 # @target: the id or node-name of the block device to mirror to. This mustn't be
 #          attached to guest.
 #
-# @replaces: #optional with sync=full graph node name to be replaced by the new
+# @replaces: with sync=full graph node name to be replaced by the new
 #            image when a whole image copy is done. This can be used to repair
 #            broken Quorum files.
 #
-# @speed:  #optional the maximum speed, in bytes per second
+# @speed:  the maximum speed, in bytes per second
 #
 # @sync: what parts of the disk image should be copied to the destination
 #        (all the disk, only the sectors allocated in the topmost image, or
 #        only new I/O).
 #
-# @granularity: #optional granularity of the dirty bitmap, default is 64K
+# @granularity: granularity of the dirty bitmap, default is 64K
 #               if the image format doesn't have clusters, 4K if the clusters
 #               are smaller than that, else the cluster size.  Must be a
 #               power of 2 between 512 and 64M
 #
-# @buf-size: #optional maximum amount of data in flight from source to
+# @buf-size: maximum amount of data in flight from source to
 #            target
 #
-# @on-source-error: #optional the action to take on an error on the source,
+# @on-source-error: the action to take on an error on the source,
 #                   default 'report'.  'stop' and 'enospc' can only be used
 #                   if the block device supports io-status (see BlockInfo).
 #
-# @on-target-error: #optional the action to take on an error on the target,
+# @on-target-error: the action to take on an error on the target,
 #                   default 'report' (no limitations, since this applies to
 #                   a different block device than @device).
 #
-# @filter-node-name: #optional the node name that should be assigned to the
+# @filter-node-name: the node name that should be assigned to the
 #                    filter driver that the mirror job inserts into the graph
 #                    above @device. If this option is not given, a node name is
 #                    autogenerated. (Since: 2.9)
@@ -1766,9 +1766,9 @@
 #
 # A set of parameters describing block throttling.
 #
-# @device: #optional Block device name (deprecated, use @id instead)
+# @device: Block device name (deprecated, use @id instead)
 #
-# @id: #optional The name or QOM path of the guest device (since: 2.8)
+# @id: The name or QOM path of the guest device (since: 2.8)
 #
 # @bps: total throughput limit in bytes per second
 #
@@ -1782,57 +1782,57 @@
 #
 # @iops_wr: write I/O operations per second
 #
-# @bps_max: #optional total throughput limit during bursts,
+# @bps_max: total throughput limit during bursts,
 #                     in bytes (Since 1.7)
 #
-# @bps_rd_max: #optional read throughput limit during bursts,
+# @bps_rd_max: read throughput limit during bursts,
 #                        in bytes (Since 1.7)
 #
-# @bps_wr_max: #optional write throughput limit during bursts,
+# @bps_wr_max: write throughput limit during bursts,
 #                        in bytes (Since 1.7)
 #
-# @iops_max: #optional total I/O operations per second during bursts,
+# @iops_max: total I/O operations per second during bursts,
 #                      in bytes (Since 1.7)
 #
-# @iops_rd_max: #optional read I/O operations per second during bursts,
+# @iops_rd_max: read I/O operations per second during bursts,
 #                         in bytes (Since 1.7)
 #
-# @iops_wr_max: #optional write I/O operations per second during bursts,
+# @iops_wr_max: write I/O operations per second during bursts,
 #                         in bytes (Since 1.7)
 #
-# @bps_max_length: #optional maximum length of the @bps_max burst
+# @bps_max_length: maximum length of the @bps_max burst
 #                            period, in seconds. It must only
 #                            be set if @bps_max is set as well.
 #                            Defaults to 1. (Since 2.6)
 #
-# @bps_rd_max_length: #optional maximum length of the @bps_rd_max
+# @bps_rd_max_length: maximum length of the @bps_rd_max
 #                               burst period, in seconds. It must only
 #                               be set if @bps_rd_max is set as well.
 #                               Defaults to 1. (Since 2.6)
 #
-# @bps_wr_max_length: #optional maximum length of the @bps_wr_max
+# @bps_wr_max_length: maximum length of the @bps_wr_max
 #                               burst period, in seconds. It must only
 #                               be set if @bps_wr_max is set as well.
 #                               Defaults to 1. (Since 2.6)
 #
-# @iops_max_length: #optional maximum length of the @iops burst
+# @iops_max_length: maximum length of the @iops burst
 #                             period, in seconds. It must only
 #                             be set if @iops_max is set as well.
 #                             Defaults to 1. (Since 2.6)
 #
-# @iops_rd_max_length: #optional maximum length of the @iops_rd_max
+# @iops_rd_max_length: maximum length of the @iops_rd_max
 #                                burst period, in seconds. It must only
 #                                be set if @iops_rd_max is set as well.
 #                                Defaults to 1. (Since 2.6)
 #
-# @iops_wr_max_length: #optional maximum length of the @iops_wr_max
+# @iops_wr_max_length: maximum length of the @iops_wr_max
 #                                burst period, in seconds. It must only
 #                                be set if @iops_wr_max is set as well.
 #                                Defaults to 1. (Since 2.6)
 #
-# @iops_size: #optional an I/O size in bytes (Since 1.7)
+# @iops_size: an I/O size in bytes (Since 1.7)
 #
-# @group: #optional throttle group name (Since 2.4)
+# @group: throttle group name (Since 2.4)
 #
 # Since: 1.1
 ##
@@ -1873,18 +1873,18 @@
 # On successful completion the image file is updated to drop the backing file
 # and the BLOCK_JOB_COMPLETED event is emitted.
 #
-# @job-id: #optional identifier for the newly-created block job. If
+# @job-id: identifier for the newly-created block job. If
 #          omitted, the device name will be used. (Since 2.7)
 #
 # @device: the device or node name of the top image
 #
-# @base:   #optional the common backing file name.
+# @base:   the common backing file name.
 #                    It cannot be set if @base-node is also set.
 #
-# @base-node: #optional the node name of the backing file.
+# @base-node: the node name of the backing file.
 #                       It cannot be set if @base is also set. (Since 2.8)
 #
-# @backing-file: #optional The backing file string to write into the top
+# @backing-file: The backing file string to write into the top
 #                          image. This filename is not validated.
 #
 #                          If a pathname string is such that it cannot be
@@ -1899,9 +1899,9 @@
 #                          protocol.
 #                          (Since 2.1)
 #
-# @speed:  #optional the maximum speed, in bytes per second
+# @speed:  the maximum speed, in bytes per second
 #
-# @on-error: #optional the action to take on an error (default report).
+# @on-error: the action to take on an error (default report).
 #            'stop' and 'enospc' can only be used if the block device
 #            supports io-status (see BlockInfo).  Since 1.3.
 #
@@ -1968,7 +1968,7 @@
 #          the name of the parameter), but since QEMU 2.7 it can have
 #          other values.
 #
-# @force: #optional whether to allow cancellation of a paused job (default
+# @force: whether to allow cancellation of a paused job (default
 #         false).  Since 1.3.
 #
 # Returns: Nothing on success
@@ -2100,9 +2100,9 @@
 #
 # Includes cache-related options for block devices
 #
-# @direct:      #optional enables use of O_DIRECT (bypass the host page cache;
+# @direct:      enables use of O_DIRECT (bypass the host page cache;
 #               default: false)
-# @no-flush:    #optional ignore any flush requests for the device (default:
+# @no-flush:    ignore any flush requests for the device (default:
 #               false)
 #
 # Since: 1.7
@@ -2143,7 +2143,7 @@
 # Driver specific block device options for the file backend.
 #
 # @filename:    path to the image file
-# @aio:         #optional AIO backend (default: threads) (since: 2.8)
+# @aio:         AIO backend (default: threads) (since: 2.8)
 #
 # Since: 1.7
 ##
@@ -2156,8 +2156,8 @@
 #
 # Driver specific block device options for the null backend.
 #
-# @size:    #optional size of the device in bytes.
-# @latency-ns: #optional emulated latency (in nanoseconds) in processing
+# @size:    size of the device in bytes.
+# @latency-ns: emulated latency (in nanoseconds) in processing
 #              requests. Default to zero which completes requests immediately.
 #              (Since 2.4)
 #
@@ -2172,14 +2172,14 @@
 # Driver specific block device options for the vvfat protocol.
 #
 # @dir:         directory to be exported as FAT image
-# @fat-type:    #optional FAT type: 12, 16 or 32
-# @floppy:      #optional whether to export a floppy image (true) or
+# @fat-type:    FAT type: 12, 16 or 32
+# @floppy:      whether to export a floppy image (true) or
 #               partitioned hard disk (false; default)
-# @label:       #optional set the volume label, limited to 11 bytes. FAT16 and
+# @label:       set the volume label, limited to 11 bytes. FAT16 and
 #               FAT32 traditionally have some restrictions on labels, which are
 #               ignored by most operating systems. Defaults to "QEMU VVFAT".
 #               (since 2.4)
-# @rw:          #optional whether to allow write operations (default: false)
+# @rw:          whether to allow write operations (default: false)
 #
 # Since: 1.7
 ##
@@ -2205,7 +2205,7 @@
 #
 # Driver specific block device options for LUKS.
 #
-# @key-secret: #optional the ID of a QCryptoSecret object providing
+# @key-secret: the ID of a QCryptoSecret object providing
 #              the decryption key (since 2.6). Mandatory except when
 #              doing a metadata-only probe of the image.
 #
@@ -2222,7 +2222,7 @@
 # Driver specific block device options for image format that have no option
 # besides their data source and an optional backing file.
 #
-# @backing:     #optional reference to or definition of the backing file block
+# @backing:     reference to or definition of the backing file block
 #               device (if missing, taken from the image file content). It is
 #               allowed to pass an empty string here in order to disable the
 #               default backing file.
@@ -2298,33 +2298,33 @@
 #
 # Driver specific block device options for qcow2.
 #
-# @lazy-refcounts:        #optional whether to enable the lazy refcounts
+# @lazy-refcounts:        whether to enable the lazy refcounts
 #                         feature (default is taken from the image file)
 #
-# @pass-discard-request:  #optional whether discard requests to the qcow2
+# @pass-discard-request:  whether discard requests to the qcow2
 #                         device should be forwarded to the data source
 #
-# @pass-discard-snapshot: #optional whether discard requests for the data source
+# @pass-discard-snapshot: whether discard requests for the data source
 #                         should be issued when a snapshot operation (e.g.
 #                         deleting a snapshot) frees clusters in the qcow2 file
 #
-# @pass-discard-other:    #optional whether discard requests for the data source
+# @pass-discard-other:    whether discard requests for the data source
 #                         should be issued on other occasions where a cluster
 #                         gets freed
 #
-# @overlap-check:         #optional which overlap checks to perform for writes
+# @overlap-check:         which overlap checks to perform for writes
 #                         to the image, defaults to 'cached' (since 2.2)
 #
-# @cache-size:            #optional the maximum total size of the L2 table and
+# @cache-size:            the maximum total size of the L2 table and
 #                         refcount block caches in bytes (since 2.2)
 #
-# @l2-cache-size:         #optional the maximum size of the L2 table cache in
+# @l2-cache-size:         the maximum size of the L2 table cache in
 #                         bytes (since 2.2)
 #
-# @refcount-cache-size:   #optional the maximum size of the refcount block cache
+# @refcount-cache-size:   the maximum size of the refcount block cache
 #                         in bytes (since 2.2)
 #
-# @cache-clean-interval:  #optional clean unused entries in the L2 and refcount
+# @cache-clean-interval:  clean unused entries in the L2 and refcount
 #                         caches. The interval is in seconds. The default value
 #                         is 0 and it disables this feature (since 2.5)
 #
@@ -2350,7 +2350,7 @@
 #
 # @path:                path to the image on the host
 #
-# @user:                #optional user as which to connect, defaults to current
+# @user:                user as which to connect, defaults to current
 #                       local user name
 #
 # TODO: Expose the host_key_check option in QMP
@@ -2393,20 +2393,20 @@
 #
 # @event:       trigger event
 #
-# @state:       #optional the state identifier blkdebug needs to be in to
+# @state:       the state identifier blkdebug needs to be in to
 #               actually trigger the event; defaults to "any"
 #
-# @errno:       #optional error identifier (errno) to be returned; defaults to
+# @errno:       error identifier (errno) to be returned; defaults to
 #               EIO
 #
-# @sector:      #optional specifies the sector index which has to be affected
+# @sector:      specifies the sector index which has to be affected
 #               in order to actually trigger the event; defaults to "any
 #               sector"
 #
-# @once:        #optional disables further events after this one has been
+# @once:        disables further events after this one has been
 #               triggered; defaults to false
 #
-# @immediately: #optional fail immediately; defaults to false
+# @immediately: fail immediately; defaults to false
 #
 # Since: 2.0
 ##
@@ -2425,7 +2425,7 @@
 #
 # @event:       trigger event
 #
-# @state:       #optional the current state identifier blkdebug needs to be in;
+# @state:       the current state identifier blkdebug needs to be in;
 #               defaults to "any"
 #
 # @new_state:   the state identifier blkdebug is supposed to assume if
@@ -2445,14 +2445,14 @@
 #
 # @image:           underlying raw block device (or image file)
 #
-# @config:          #optional filename of the configuration file
+# @config:          filename of the configuration file
 #
-# @align:           #optional required alignment for requests in bytes,
+# @align:           required alignment for requests in bytes,
 #                   must be power of 2, or 0 for default
 #
-# @inject-error:    #optional array of error injection descriptions
+# @inject-error:    array of error injection descriptions
 #
-# @set-state:       #optional array of state-change descriptions
+# @set-state:       array of state-change descriptions
 #
 # Since: 2.0
 ##
@@ -2496,17 +2496,17 @@
 #
 # Driver specific block device options for Quorum
 #
-# @blkverify:      #optional true if the driver must print content mismatch
+# @blkverify:      true if the driver must print content mismatch
 #                  set to false by default
 #
 # @children:       the children block devices to use
 #
 # @vote-threshold: the vote limit under which a read will fail
 #
-# @rewrite-corrupted: #optional rewrite corrupted data when quorum is reached
+# @rewrite-corrupted: rewrite corrupted data when quorum is reached
 #                     (Since 2.1)
 #
-# @read-pattern: #optional choose read pattern and set to quorum by default
+# @read-pattern: choose read pattern and set to quorum by default
 #                (Since 2.2)
 #
 # Since: 2.0
@@ -2529,10 +2529,10 @@
 #
 # @server:      gluster servers description
 #
-# @debug:       #optional libgfapi log level (default '4' which is Error)
+# @debug:       libgfapi log level (default '4' which is Error)
 #               (Since 2.8)
 #
-# @logfile:     #optional libgfapi log file (default /dev/stderr) (Since 2.8)
+# @logfile:     libgfapi log file (default /dev/stderr) (Since 2.8)
 #
 # Since: 2.7
 ##
@@ -2573,23 +2573,23 @@
 #
 # @target:          The target iqn name
 #
-# @lun:             #optional LUN to connect to. Defaults to 0.
+# @lun:             LUN to connect to. Defaults to 0.
 #
-# @user:            #optional User name to log in with. If omitted, no CHAP
+# @user:            User name to log in with. If omitted, no CHAP
 #                   authentication is performed.
 #
-# @password-secret: #optional The ID of a QCryptoSecret object providing
+# @password-secret: The ID of a QCryptoSecret object providing
 #                   the password for the login. This option is required if
 #                   @user is specified.
 #
-# @initiator-name:  #optional The iqn name we want to identify to the target
+# @initiator-name:  The iqn name we want to identify to the target
 #                   as. If this option is not specified, an initiator name is
 #                   generated automatically.
 #
-# @header-digest:   #optional The desired header digest. Defaults to
+# @header-digest:   The desired header digest. Defaults to
 #                   none-crc32c.
 #
-# @timeout:         #optional Timeout in seconds after which a request will
+# @timeout:         Timeout in seconds after which a request will
 #                   timeout. 0 means no timeout and is the default.
 #
 # Driver specific block device options for iscsi
@@ -2636,20 +2636,20 @@
 #
 # @image:              Image name in the Ceph pool.
 #
-# @conf:               #optional path to Ceph configuration file.  Values
+# @conf:               path to Ceph configuration file.  Values
 #                      in the configuration file will be overridden by
 #                      options specified via QAPI.
 #
-# @snapshot:           #optional Ceph snapshot name.
+# @snapshot:           Ceph snapshot name.
 #
-# @user:               #optional Ceph id name.
+# @user:               Ceph id name.
 #
-# @server:             #optional Monitor host address and port.  This maps
+# @server:             Monitor host address and port.  This maps
 #                      to the "mon_host" Ceph option.
 #
-# @auth-supported:     #optional Authentication supported.
+# @auth-supported:     Authentication supported.
 #
-# @password-secret:    #optional The ID of a QCryptoSecret object providing
+# @password-secret:    The ID of a QCryptoSecret object providing
 #                      the password for the login.
 #
 # Since: 2.9
@@ -2704,7 +2704,7 @@
 #
 # @mode: the replication mode
 #
-# @top-id: #optional In secondary mode, node name or device ID of the root
+# @top-id: In secondary mode, node name or device ID of the root
 #          node who owns the replication node chain. Must not be given in
 #          primary mode.
 #
@@ -2751,24 +2751,24 @@
 #
 # @path:                    path of the image on the host
 #
-# @user:                    #optional UID value to use when talking to the
+# @user:                    UID value to use when talking to the
 #                           server (defaults to 65534 on Windows and getuid()
 #                           on unix)
 #
-# @group:                   #optional GID value to use when talking to the
+# @group:                   GID value to use when talking to the
 #                           server (defaults to 65534 on Windows and getgid()
 #                           in unix)
 #
-# @tcp-syn-count:           #optional number of SYNs during the session
+# @tcp-syn-count:           number of SYNs during the session
 #                           establishment (defaults to libnfs default)
 #
-# @readahead-size:          #optional set the readahead size in bytes (defaults
+# @readahead-size:          set the readahead size in bytes (defaults
 #                           to libnfs default)
 #
-# @page-cache-size:         #optional set the pagecache size in bytes (defaults
+# @page-cache-size:         set the pagecache size in bytes (defaults
 #                           to libnfs default)
 #
-# @debug:                   #optional set the NFS debug level (max 2) (defaults
+# @debug:                   set the NFS debug level (max 2) (defaults
 #                           to libnfs default)
 #
 # Since: 2.8
@@ -2802,9 +2802,9 @@
 #
 # @server:      NBD server address
 #
-# @export:      #optional export name
+# @export:      export name
 #
-# @tls-creds:   #optional TLS credentials ID
+# @tls-creds:   TLS credentials ID
 #
 # Since: 2.8
 ##
@@ -2818,8 +2818,8 @@
 #
 # Driver specific block device options for the raw driver.
 #
-# @offset:      #optional position where the block device starts
-# @size:        #optional the assumed size of the device
+# @offset:      position where the block device starts
+# @size:        the assumed size of the device
 #
 # Since: 2.8
 ##
@@ -2834,13 +2834,13 @@
 # block devices, independent of the block driver:
 #
 # @driver:        block driver name
-# @node-name:     #optional the node name of the new node (Since 2.0).
+# @node-name:     the node name of the new node (Since 2.0).
 #                 This option is required on the top level of blockdev-add.
-# @discard:       #optional discard-related options (default: ignore)
-# @cache:         #optional cache-related options
-# @read-only:     #optional whether the block device should be read-only
+# @discard:       discard-related options (default: ignore)
+# @cache:         cache-related options
+# @read-only:     whether the block device should be read-only
 #                 (default: false)
-# @detect-zeroes: #optional detect and optimize zero writes (Since 2.1)
+# @detect-zeroes: detect and optimize zero writes (Since 2.1)
 #                 (default: off)
 #
 # Remaining options are determined by the block driver.
@@ -3021,11 +3021,11 @@
 #   to it
 # - if the guest device does not have an actual tray
 #
-# @device: #optional Block device name (deprecated, use @id instead)
+# @device: Block device name (deprecated, use @id instead)
 #
-# @id:     #optional The name or QOM path of the guest device (since: 2.8)
+# @id:     The name or QOM path of the guest device (since: 2.8)
 #
-# @force:  #optional if false (the default), an eject request will be sent to
+# @force:  if false (the default), an eject request will be sent to
 #          the guest if it has locked the tray (and the tray will not be opened
 #          immediately); if true, the tray will be opened regardless of whether
 #          it is locked
@@ -3061,9 +3061,9 @@
 #
 # If the tray was already closed before, this will be a no-op.
 #
-# @device:  #optional Block device name (deprecated, use @id instead)
+# @device:  Block device name (deprecated, use @id instead)
 #
-# @id:      #optional The name or QOM path of the guest device (since: 2.8)
+# @id:      The name or QOM path of the guest device (since: 2.8)
 #
 # Since: 2.5
 #
@@ -3095,9 +3095,9 @@
 #
 # If the tray is open and there is no medium inserted, this will be a no-op.
 #
-# @device: #optional Block device name (deprecated, use @id instead)
+# @device: Block device name (deprecated, use @id instead)
 #
-# @id:     #optional The name or QOM path of the guest device (since: 2.8)
+# @id:     The name or QOM path of the guest device (since: 2.8)
 #
 # Note: This command is still a work in progress and is considered experimental.
 # Stay away from it unless you want to help with its development.
@@ -3141,9 +3141,9 @@
 # device's tray must currently be open (unless there is no attached guest
 # device) and there must be no medium inserted already.
 #
-# @device:    #optional Block device name (deprecated, use @id instead)
+# @device:    Block device name (deprecated, use @id instead)
 #
-# @id:        #optional The name or QOM path of the guest device (since: 2.8)
+# @id:        The name or QOM path of the guest device (since: 2.8)
 #
 # @node-name: name of a node in the block driver state graph
 #
@@ -3202,17 +3202,17 @@
 # combines blockdev-open-tray, x-blockdev-remove-medium,
 # x-blockdev-insert-medium and blockdev-close-tray).
 #
-# @device:          #optional Block device name (deprecated, use @id instead)
+# @device:          Block device name (deprecated, use @id instead)
 #
-# @id:              #optional The name or QOM path of the guest device
+# @id:              The name or QOM path of the guest device
 #                   (since: 2.8)
 #
 # @filename:        filename of the new image to be loaded
 #
-# @format:          #optional format to open the new image with (defaults to
+# @format:          format to open the new image with (defaults to
 #                   the probed format)
 #
-# @read-only-mode:  #optional change the read-only mode of the device; defaults
+# @read-only-mode:  change the read-only mode of the device; defaults
 #                   to 'retain'
 #
 # Since: 2.5
@@ -3285,16 +3285,16 @@
 #          reasons, but it can be empty ("") if the image does not
 #          have a device name associated.
 #
-# @node-name: #optional node name (Since: 2.4)
+# @node-name: node name (Since: 2.4)
 #
 # @msg: informative message for human consumption, such as the kind of
 #       corruption being detected. It should not be parsed by machine as it is
 #       not guaranteed to be stable
 #
-# @offset: #optional if the corruption resulted from an image access, this is
+# @offset: if the corruption resulted from an image access, this is
 #          the host's access offset into the image
 #
-# @size: #optional if the corruption resulted from an image access, this is
+# @size: if the corruption resulted from an image access, this is
 #        the access size
 #
 # @fatal: if set, the image is marked corrupt and therefore unusable after this
@@ -3339,7 +3339,7 @@
 #
 # @action: action that has been taken
 #
-# @nospace: #optional true if I/O error was caused due to a no-space
+# @nospace: true if I/O error was caused due to a no-space
 #           condition. This key is only present if query-block's
 #           io-status is present, please see query-block documentation
 #           for more information (since: 2.2)
@@ -3385,7 +3385,7 @@
 #
 # @speed: rate limit, bytes per second
 #
-# @error: #optional error message. Only present on failure. This field
+# @error: error message. Only present on failure. This field
 #         contains a human-readable error message. There are no semantics
 #         other than that streaming has failed and clients should not try to
 #         interpret the error string
@@ -3594,9 +3594,9 @@
 #
 # @parent: the id or name of the parent node.
 #
-# @child: #optional the name of a child under the given parent node.
+# @child: the name of a child under the given parent node.
 #
-# @node: #optional the name of the node that will be added.
+# @node: the name of the node that will be added.
 #
 # Note: this command is experimental, and its API is not stable. It
 # does not support all kinds of operations, all kinds of children, nor
diff --git a/qapi/block.json b/qapi/block.json
index 22da914..46fca0e 100644
--- a/qapi/block.json
+++ b/qapi/block.json
@@ -163,11 +163,11 @@
 #
 # Ejects a device from a removable drive.
 #
-# @device:  #optional Block device name (deprecated, use @id instead)
+# @device:  Block device name (deprecated, use @id instead)
 #
-# @id:      #optional The name or QOM path of the guest device (since: 2.8)
+# @id:      The name or QOM path of the guest device (since: 2.8)
 #
-# @force:   #optional If true, eject regardless of whether the drive is locked.
+# @force:   If true, eject regardless of whether the drive is locked.
 #           If not specified, the default value is false.
 #
 # Returns:  Nothing on success
@@ -215,7 +215,7 @@
 # @device: The device name or node name of the node to be exported
 #
 # @writable: Whether clients should be able to write to the device via the
-#     NBD connection (default false). #optional
+#     NBD connection (default false).
 #
 # Returns: error if the device is already marked for export.
 #
diff --git a/qapi/crypto.json b/qapi/crypto.json
index 93a0474..6b6fde3 100644
--- a/qapi/crypto.json
+++ b/qapi/crypto.json
@@ -152,7 +152,7 @@
 #
 # The options that apply to QCow/QCow2 AES-CBC encryption format
 #
-# @key-secret: #optional the ID of a QCryptoSecret object providing the
+# @key-secret: the ID of a QCryptoSecret object providing the
 #              decryption key. Mandatory except when probing image for
 #              metadata only.
 #
@@ -166,7 +166,7 @@
 #
 # The options that apply to LUKS encryption format
 #
-# @key-secret: #optional the ID of a QCryptoSecret object providing the
+# @key-secret: the ID of a QCryptoSecret object providing the
 #              decryption key. Mandatory except when probing image for
 #              metadata only.
 # Since: 2.6
@@ -180,17 +180,17 @@
 #
 # The options that apply to LUKS encryption format initialization
 #
-# @cipher-alg: #optional the cipher algorithm for data encryption
+# @cipher-alg: the cipher algorithm for data encryption
 #              Currently defaults to 'aes'.
-# @cipher-mode: #optional the cipher mode for data encryption
+# @cipher-mode: the cipher mode for data encryption
 #               Currently defaults to 'cbc'
-# @ivgen-alg: #optional the initialization vector generator
+# @ivgen-alg: the initialization vector generator
 #             Currently defaults to 'essiv'
-# @ivgen-hash-alg: #optional the initialization vector generator hash
+# @ivgen-hash-alg: the initialization vector generator hash
 #                  Currently defaults to 'sha256'
-# @hash-alg: #optional the master key hash algorithm
+# @hash-alg: the master key hash algorithm
 #            Currently defaults to 'sha256'
-# @iter-time: #optional number of milliseconds to spend in
+# @iter-time: number of milliseconds to spend in
 #             PBKDF passphrase processing. Currently defaults
 #             to 2000. (since 2.8)
 # Since: 2.6
@@ -257,8 +257,8 @@
 #
 # @active: whether the key slot is currently in use
 # @key-offset: offset to the key material in bytes
-# @iters: #optional number of PBKDF2 iterations for key material
-# @stripes: #optional number of stripes for splitting key material
+# @iters: number of PBKDF2 iterations for key material
+# @stripes: number of stripes for splitting key material
 #
 # Since: 2.7
 ##
@@ -277,7 +277,7 @@
 # @cipher-alg: the cipher algorithm for data encryption
 # @cipher-mode: the cipher mode for data encryption
 # @ivgen-alg: the initialization vector generator
-# @ivgen-hash-alg: #optional the initialization vector generator hash
+# @ivgen-hash-alg: the initialization vector generator hash
 # @hash-alg: the master key hash algorithm
 # @payload-offset: offset to the payload data in bytes
 # @master-key-iters: number of PBKDF2 iterations for key material
diff --git a/qapi/event.json b/qapi/event.json
index e02852c..e80f3f4 100644
--- a/qapi/event.json
+++ b/qapi/event.json
@@ -186,7 +186,7 @@
 # At this point, it's safe to reuse the specified device ID. Device removal can
 # be initiated by the guest or by HMP/QMP commands.
 #
-# @device: #optional device name
+# @device: device name
 #
 # @path: device path
 #
@@ -209,7 +209,7 @@
 # Emitted once until the 'query-rx-filter' command is executed, the first event
 # will always be emitted
 #
-# @name: #optional net client name
+# @name: net client name
 #
 # @path: device path
 #
@@ -488,7 +488,7 @@
 #
 # @action: action that has been taken, currently always "pause"
 #
-# @info: #optional information about a panic (since 2.9)
+# @info: information about a panic (since 2.9)
 #
 # Since: 1.5
 #
@@ -533,7 +533,7 @@
 #
 # @type: quorum operation type (Since 2.6)
 #
-# @error: #optional error message. Only present on failure. This field
+# @error: error message. Only present on failure. This field
 #         contains a human-readable error message. There are no semantics other
 #         than that the block layer reported an error and clients should not
 #         try to interpret the error string.
@@ -620,7 +620,7 @@
 #
 # @result: DumpQueryResult type described in qapi-schema.json.
 #
-# @error: #optional human-readable error string that provides
+# @error: human-readable error string that provides
 #         hint on why dump failed. Only presents on failure. The
 #         user should not try to interpret the error string.
 #
diff --git a/qapi/introspect.json b/qapi/introspect.json
index f6adc43..1dbaef5 100644
--- a/qapi/introspect.json
+++ b/qapi/introspect.json
@@ -163,10 +163,10 @@
 #
 # @members: the object type's (non-variant) members, in no particular order.
 #
-# @tag: #optional the name of the member serving as type tag.
+# @tag: the name of the member serving as type tag.
 #       An element of @members with this name must exist.
 #
-# @variants: #optional variant members, i.e. additional members that
+# @variants: variant members, i.e. additional members that
 #            depend on the type tag's value.  Present exactly when
 #            @tag is present.  The variants are in no particular order,
 #            and may even differ from the order of the values of the
@@ -190,7 +190,7 @@
 #
 # @type: the name of the member's type.
 #
-# @default: #optional default when used as command parameter.
+# @default: default when used as command parameter.
 #           If absent, the parameter is mandatory.
 #           If present, the value must be null.  The parameter is
 #           optional, and behavior when it's missing is not specified
diff --git a/qapi/rocker.json b/qapi/rocker.json
index f374038..3587661 100644
--- a/qapi/rocker.json
+++ b/qapi/rocker.json
@@ -121,23 +121,23 @@
 #
 # @tbl-id: flow table ID
 #
-# @in-pport: #optional physical input port
+# @in-pport: physical input port
 #
-# @tunnel-id: #optional tunnel ID
+# @tunnel-id: tunnel ID
 #
-# @vlan-id: #optional VLAN ID
+# @vlan-id: VLAN ID
 #
-# @eth-type: #optional Ethernet header type
+# @eth-type: Ethernet header type
 #
-# @eth-src: #optional Ethernet header source MAC address
+# @eth-src: Ethernet header source MAC address
 #
-# @eth-dst: #optional Ethernet header destination MAC address
+# @eth-dst: Ethernet header destination MAC address
 #
-# @ip-proto: #optional IP Header protocol field
+# @ip-proto: IP Header protocol field
 #
-# @ip-tos: #optional IP header TOS field
+# @ip-tos: IP header TOS field
 #
-# @ip-dst: #optional IP header destination address
+# @ip-dst: IP header destination address
 #
 # Note: optional members may or may not appear in the flow key
 # depending if they're relevant to the flow key.
@@ -155,19 +155,19 @@
 #
 # Rocker switch OF-DPA flow mask
 #
-# @in-pport: #optional physical input port
+# @in-pport: physical input port
 #
-# @tunnel-id: #optional tunnel ID
+# @tunnel-id: tunnel ID
 #
-# @vlan-id: #optional VLAN ID
+# @vlan-id: VLAN ID
 #
-# @eth-src: #optional Ethernet header source MAC address
+# @eth-src: Ethernet header source MAC address
 #
-# @eth-dst: #optional Ethernet header destination MAC address
+# @eth-dst: Ethernet header destination MAC address
 #
-# @ip-proto: #optional IP Header protocol field
+# @ip-proto: IP Header protocol field
 #
-# @ip-tos: #optional IP header TOS field
+# @ip-tos: IP header TOS field
 #
 # Note: optional members may or may not appear in the flow mask
 # depending if they're relevant to the flow mask.
@@ -184,17 +184,17 @@
 #
 # Rocker switch OF-DPA flow action
 #
-# @goto-tbl: #optional next table ID
+# @goto-tbl: next table ID
 #
-# @group-id: #optional group ID
+# @group-id: group ID
 #
-# @tunnel-lport: #optional tunnel logical port ID
+# @tunnel-lport: tunnel logical port ID
 #
-# @vlan-id: #optional VLAN ID
+# @vlan-id: VLAN ID
 #
-# @new-vlan-id: #optional new VLAN ID
+# @new-vlan-id: new VLAN ID
 #
-# @out-pport: #optional physical output port
+# @out-pport: physical output port
 #
 # Note: optional members may or may not appear in the flow action
 # depending if they're relevant to the flow action.
@@ -234,7 +234,7 @@
 #
 # @name: switch name
 #
-# @tbl-id: #optional flow table ID.  If tbl-id is not specified, returns
+# @tbl-id: flow table ID.  If tbl-id is not specified, returns
 # flow information for all tables.
 #
 # Returns: rocker OF-DPA flow information
@@ -268,27 +268,27 @@
 #
 # @type: group type
 #
-# @vlan-id: #optional VLAN ID
+# @vlan-id: VLAN ID
 #
-# @pport: #optional physical port number
+# @pport: physical port number
 #
-# @index: #optional group index, unique with group type
+# @index: group index, unique with group type
 #
-# @out-pport: #optional output physical port number
+# @out-pport: output physical port number
 #
-# @group-id: #optional next group ID
+# @group-id: next group ID
 #
-# @set-vlan-id: #optional VLAN ID to set
+# @set-vlan-id: VLAN ID to set
 #
-# @pop-vlan: #optional pop VLAN headr from packet
+# @pop-vlan: pop VLAN headr from packet
 #
-# @group-ids: #optional list of next group IDs
+# @group-ids: list of next group IDs
 #
-# @set-eth-src: #optional set source MAC address in Ethernet header
+# @set-eth-src: set source MAC address in Ethernet header
 #
-# @set-eth-dst: #optional set destination MAC address in Ethernet header
+# @set-eth-dst: set destination MAC address in Ethernet header
 #
-# @ttl-check: #optional perform TTL check
+# @ttl-check: perform TTL check
 #
 # Note: optional members may or may not appear in the group depending
 # if they're relevant to the group type.
@@ -310,7 +310,7 @@
 #
 # @name: switch name
 #
-# @type: #optional group type.  If type is not specified, returns
+# @type: group type.  If type is not specified, returns
 # group information for all group types.
 #
 # Returns: rocker OF-DPA group information
diff --git a/qapi/trace.json b/qapi/trace.json
index 2bfda7a..de6588d 100644
--- a/qapi/trace.json
+++ b/qapi/trace.json
@@ -48,7 +48,7 @@
 # Query the state of events.
 #
 # @name: Event name pattern (case-sensitive glob).
-# @vcpu: #optional The vCPU to query (any by default; since 2.7).
+# @vcpu: The vCPU to query (any by default; since 2.7).
 #
 # Returns: a list of @TraceEventInfo for the matching events
 #
@@ -81,8 +81,8 @@
 #
 # @name: Event name pattern (case-sensitive glob).
 # @enable: Whether to enable tracing.
-# @ignore-unavailable: #optional Do not match unavailable events with @name.
-# @vcpu: #optional The vCPU to act upon (all by default; since 2.7).
+# @ignore-unavailable: Do not match unavailable events with @name.
+# @vcpu: The vCPU to act upon (all by default; since 2.7).
 #
 # An event's state is modified if:
 # - its name matches the @name pattern, and
diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index a8e4bda..a02dbf2 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -144,7 +144,7 @@
 # If that's the case users are advised to always pass a
 # value.
 #
-# @time: #optional time of nanoseconds, relative to the Epoch
+# @time: time of nanoseconds, relative to the Epoch
 #        of 1970-01-01 in UTC.
 #
 # Returns: Nothing on success.
@@ -203,7 +203,7 @@
 # Initiate guest-activated shutdown. Note: this is an asynchronous
 # shutdown request, with no guarantee of successful shutdown.
 #
-# @mode: #optional "halt", "powerdown" (default), or "reboot"
+# @mode: "halt", "powerdown" (default), or "reboot"
 #
 # This command does NOT return a response on success. Success condition
 # is indicated by the VM exiting with a zero exit status or, when
@@ -222,7 +222,7 @@
 #
 # @path: Full path to the file in the guest to open.
 #
-# @mode: #optional open mode, as per fopen(), "r" is the default.
+# @mode: open mode, as per fopen(), "r" is the default.
 #
 # Returns: Guest file handle on success.
 #
@@ -270,7 +270,7 @@
 #
 # @handle: filehandle returned by guest-file-open
 #
-# @count: #optional maximum number of bytes to read (default is 4KB)
+# @count: maximum number of bytes to read (default is 4KB)
 #
 # Returns: @GuestFileRead on success.
 #
@@ -304,7 +304,7 @@
 #
 # @buf-b64: base64-encoded string representing data to be written
 #
-# @count: #optional bytes to write (actual bytes, after base64-decode),
+# @count: bytes to write (actual bytes, after base64-decode),
 #         default is all content in buf-b64 buffer after base64 decoding
 #
 # Returns: @GuestFileWrite on success.
@@ -441,7 +441,7 @@
 #
 # Sync and freeze specified guest filesystems
 #
-# @mountpoints: #optional an array of mountpoints of filesystems to be frozen.
+# @mountpoints: an array of mountpoints of filesystems to be frozen.
 #               If omitted, every mounted filesystem is frozen.
 #
 # Returns: Number of file systems currently frozen. On error, all filesystems
@@ -670,7 +670,7 @@
 #
 # @online: Whether the VCPU is enabled.
 #
-# @can-offline: #optional Whether offlining the VCPU is possible. This member
+# @can-offline: Whether offlining the VCPU is possible. This member
 #               is always filled in by the guest agent when the structure is
 #               returned, and always ignored on input (hence it can be omitted
 #               then).
@@ -858,7 +858,7 @@
 #
 # @online: Whether the MEMORY BLOCK is enabled in guest.
 #
-# @can-offline: #optional Whether offlining the MEMORY BLOCK is possible.
+# @can-offline: Whether offlining the MEMORY BLOCK is possible.
 #               This member is always filled in by the guest agent when the
 #               structure is returned, and always ignored on input (hence it
 #               can be omitted then).
@@ -911,7 +911,7 @@
 #
 # @response: the result of memory block operation.
 #
-# @error-code: #optional the error number.
+# @error-code: the error number.
 #               When memory block operation fails, we assign the value of
 #               'errno' to this member, it indicates what goes wrong.
 #               When the operation succeeds, it will be omitted.
@@ -979,16 +979,16 @@
 # @GuestExecStatus:
 #
 # @exited: true if process has already terminated.
-# @exitcode: #optional process exit code if it was normally terminated.
-# @signal: #optional signal number (linux) or unhandled exception code
+# @exitcode: process exit code if it was normally terminated.
+# @signal: signal number (linux) or unhandled exception code
 #       (windows) if the process was abnormally terminated.
-# @out-data: #optional base64-encoded stdout of the process
-# @err-data: #optional base64-encoded stderr of the process
+# @out-data: base64-encoded stdout of the process
+# @err-data: base64-encoded stderr of the process
 #       Note: @out-data and @err-data are present only
 #       if 'capture-output' was specified for 'guest-exec'
-# @out-truncated: #optional true if stdout was not fully captured
+# @out-truncated: true if stdout was not fully captured
 #       due to size limitation.
-# @err-truncated: #optional true if stderr was not fully captured
+# @err-truncated: true if stderr was not fully captured
 #       due to size limitation.
 #
 # Since: 2.5
@@ -1028,10 +1028,10 @@
 # Execute a command in the guest
 #
 # @path: path or executable name to execute
-# @arg: #optional argument list to pass to executable
-# @env: #optional environment variables to pass to executable
-# @input-data: #optional data to be passed to process stdin (base64 encoded)
-# @capture-output: #optional bool flag to enable capture of
+# @arg: argument list to pass to executable
+# @env: environment variables to pass to executable
+# @input-data: data to be passed to process stdin (base64 encoded)
+# @capture-output: bool flag to enable capture of
 #                  stdout/stderr of running process. defaults to false.
 #
 # Returns: PID on success.
diff --git a/scripts/qapi.py b/scripts/qapi.py
index f4c8eac..748d7ad 100644
--- a/scripts/qapi.py
+++ b/scripts/qapi.py
@@ -219,6 +219,10 @@ class QAPIDoc(object):
         if (in_arg or not self.section.name
                 or not self.section.name.startswith("Example")):
             line = line.strip()
+        # TODO Drop this once the dust has settled
+        if (isinstance(self.section, QAPIDoc.ArgSection)
+                and '#optional' in line):
+            raise QAPISemError(self.info, "Please drop the #optional tag")
         self.section.append(line)
 
     def connect_member(self, member):
@@ -985,25 +989,6 @@ def check_definition_doc(doc, expr, info):
             or (meta == 'union' and not expr.get('discriminator'))):
         args.append('type')
 
-    for arg in args:
-        if arg[0] == '*':
-            opt = True
-            desc = doc.args.get(arg[1:])
-        else:
-            opt = False
-            desc = doc.args.get(arg)
-        if not desc:
-            continue
-        desc.optional = opt
-        desc_opt = "#optional" in str(desc)
-        if desc_opt and not opt:
-            raise QAPISemError(info, "Description has #optional, "
-                               "but the declaration doesn't")
-        if not desc_opt and opt:
-            # TODO either fix the schema and make this an error,
-            # or drop #optional entirely
-            pass
-
     doc_args = set(doc.args.keys())
     args = set([name.strip('*') for name in args])
     if not doc_args.issubset(args):
diff --git a/scripts/qapi2texi.py b/scripts/qapi2texi.py
index 6d4e757..4583477 100755
--- a/scripts/qapi2texi.py
+++ b/scripts/qapi2texi.py
@@ -145,8 +145,7 @@ def texi_members(doc, member_func, show_undocumented):
     for section in doc.args.itervalues():
         if not section.content and not show_undocumented:
             continue          # Undocumented TODO require doc and drop
-        desc = re.sub(r'^ *#optional *\n?|\n? *#optional *$|#optional',
-                      '', str(section))
+        desc = str(section)
         items += member_func(section.member) + texi_format(desc) + '\n'
     if not items:
         return ''
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 3e640a8..00b02fd 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -385,7 +385,6 @@ qapi-schema += doc-missing.json
 qapi-schema += doc-missing-colon.json
 qapi-schema += doc-missing-expr.json
 qapi-schema += doc-missing-space.json
-qapi-schema += doc-optional.json
 qapi-schema += double-data.json
 qapi-schema += double-type.json
 qapi-schema += duplicate-key.json
diff --git a/tests/qapi-schema/doc-optional.err b/tests/qapi-schema/doc-optional.err
deleted file mode 100644
index 20d405a..0000000
--- a/tests/qapi-schema/doc-optional.err
+++ /dev/null
@@ -1 +0,0 @@
-tests/qapi-schema/doc-optional.json:3: Description has #optional, but the declaration doesn't
diff --git a/tests/qapi-schema/doc-optional.exit b/tests/qapi-schema/doc-optional.exit
deleted file mode 100644
index d00491f..0000000
--- a/tests/qapi-schema/doc-optional.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/doc-optional.json b/tests/qapi-schema/doc-optional.json
deleted file mode 100644
index 06c855e..0000000
--- a/tests/qapi-schema/doc-optional.json
+++ /dev/null
@@ -1,7 +0,0 @@
-# Description #optional should match declaration
-
-##
-# @foo:
-# @a: a #optional
-##
-{ 'command': 'foo', 'data': {'a': 'int'} }
diff --git a/tests/qapi-schema/doc-optional.out b/tests/qapi-schema/doc-optional.out
deleted file mode 100644
index e69de29..0000000
-- 
2.7.4
