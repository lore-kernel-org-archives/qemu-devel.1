Received: from eggs.gnu.org ([2001:4830:134:3::10]:35076)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eslcC-0004LJ-Dv
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 03:37:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eslc9-0004MT-BC
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 03:37:00 -0500
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:41770)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1eslc9-0004M3-4Y
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 03:36:57 -0500
Received: by mail-wr0-x244.google.com with SMTP id f14so16269606wre.8
	for <qemu-devel@nongnu.org>; Mon, 05 Mar 2018 00:36:56 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  5 Mar 2018 09:36:48 +0100
Message-Id: <20180305083655.6186-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 0/7] memory: address_space_to_flatview needs
 RCU lock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>, Alexey Kardashevskiy <aik@ozlabs.ru>

I noticed that the introduction of flatview_{read,write} placed
address_space_to_flatview outside the RCU lock.  This is wrong and has
to be fixed, because address_space_to_flatview does an atomic_rcu_read.
These patches fix this one function at a time.

Paolo Bonzini (7):
  openpic_kvm: drop address_space_to_flatview call
  memory: inline some performance-sensitive accessors
  address_space_write: address_space_to_flatview needs RCU lock
  address_space_read: address_space_to_flatview needs RCU lock
  address_space_access_valid: address_space_to_flatview needs RCU lock
  address_space_map: address_space_to_flatview needs RCU lock
  address_space_rw: address_space_to_flatview needs RCU lock

 exec.c                         | 90 +++++++++++++++++++++++++-----------------
 hw/intc/openpic_kvm.c          |  4 --
 include/exec/memory-internal.h | 13 ++++--
 include/exec/memory.h          | 47 ++++++++++++++--------
 memory.c                       | 30 --------------
 5 files changed, 93 insertions(+), 91 deletions(-)

-- 
2.14.3
