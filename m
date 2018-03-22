Received: from eggs.gnu.org ([2001:4830:134:3::10]:44710)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ez2ed-0003US-KR
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 12:01:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ez2eX-0000ak-N5
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 12:01:27 -0400
Received: from indium.canonical.com ([91.189.90.7]:35404)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1ez2eX-0000a5-Gv
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 12:01:21 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1ez2eV-0002ih-8E
	for <qemu-devel@nongnu.org>; Thu, 22 Mar 2018 16:01:19 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 20D4F2E8DB1
	for <qemu-devel@nongnu.org>; Thu, 22 Mar 2018 16:01:07 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Mar 2018 15:48:12 -0000
From: Thomas Jansen <1758091@bugs.launchpad.net>
Reply-To: Bug 1758091 <1758091@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <152173369238.18239.3128002656943169497.malonedeb@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1758091] [NEW] vmxnet3 unable to send IPv6 ESP
 packets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Public bug reported:

My vmxnet3 network driver (in a closed source custom OS) is unable to
send network packets that are structured as follows: Ethernet-
Header(IPv6-Header(ESP(encrypted data))). I can verify that the packet
is sent in the VM but is dropped in qemu. I first encountered this
problem on qemu 2.10.1 but master is affected as well. After some debug
printing in qemu I could identify the following call chain as being
problematic:

eth_is_ip6_extension_header_type
eth_parse_ipv6_hdr
net_tx_pkt_parse_headers
net_tx_pkt_parse
vmxnet3_process_tx_queue

The problem seems to be the definition of the ESP header
(https://en.wikipedia.org/wiki/IPsec#Encapsulating_Security_Payload)
that does not follow the standard IPv6 extension header format starting
with next type and length. Thus the parsed ext_hdr in eth_parse_ipv6_hdr
does not contain valid data, in particular the length will contain bogus
data and lead to a info->full_hdr_len that is larger than the packet
itself and the loop would then try to read beyond the end of the packet.

Using the e1000 driver I can send these packets. My guess is that the
net_tx_pkt_parse function is not called in that case.

My guess for a fix would be to remove "case IP6_ESP:" from
eth_is_ip6_extension_header_type and not regard the ESP header as a IPv6
extension header. In a quick test this seems to fix the problem. But
that should be verified by someone who is familiar with the code.

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1758091

Title:
  vmxnet3 unable to send IPv6 ESP packets

Status in QEMU:
  New

Bug description:
  My vmxnet3 network driver (in a closed source custom OS) is unable to
  send network packets that are structured as follows: Ethernet-
  Header(IPv6-Header(ESP(encrypted data))). I can verify that the packet
  is sent in the VM but is dropped in qemu. I first encountered this
  problem on qemu 2.10.1 but master is affected as well. After some
  debug printing in qemu I could identify the following call chain as
  being problematic:

  eth_is_ip6_extension_header_type
  eth_parse_ipv6_hdr
  net_tx_pkt_parse_headers
  net_tx_pkt_parse
  vmxnet3_process_tx_queue

  The problem seems to be the definition of the ESP header
  (https://en.wikipedia.org/wiki/IPsec#Encapsulating_Security_Payload)
  that does not follow the standard IPv6 extension header format
  starting with next type and length. Thus the parsed ext_hdr in
  eth_parse_ipv6_hdr does not contain valid data, in particular the
  length will contain bogus data and lead to a info->full_hdr_len that
  is larger than the packet itself and the loop would then try to read
  beyond the end of the packet.

  Using the e1000 driver I can send these packets. My guess is that the
  net_tx_pkt_parse function is not called in that case.

  My guess for a fix would be to remove "case IP6_ESP:" from
  eth_is_ip6_extension_header_type and not regard the ESP header as a
  IPv6 extension header. In a quick test this seems to fix the problem.
  But that should be verified by someone who is familiar with the code.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1758091/+subscriptions
