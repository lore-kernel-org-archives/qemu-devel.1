Received: from eggs.gnu.org ([2001:4830:134:3::10]:40816)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fWGhA-0008TZ-Gm
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 03:41:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fWGh5-0006Ku-Gu
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 03:41:24 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52666 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1fWGh5-0006Kk-BJ
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 03:41:19 -0400
From: David Hildenbrand <david@redhat.com>
Message-ID: <c7c8dfc5-d7b3-a22e-586c-4436214c7b9f@redhat.com>
Date: Fri, 22 Jun 2018 09:41:15 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [Question] inconsistent memory amount statistics
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vadim Galitsyn <vadim.galitsyn@profitbricks.com>, Eugene Crosser <evgenii.cherkashin@profitbricks.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Eric Blake <eblake@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

Starting qemu with and querying some outputs:

[...]
-m 4G,maxmem=3D20G,slots=3D2 \
-numa node,nodeid=3D0,cpus=3D0-1 -numa node,nodeid=3D1,cpus=3D2-3 \
[...]
-device virtio-balloon \
-object memory-backend-ram,id=3Dmem0,size=3D8G \
-device pc-dimm,id=3Ddimm0,memdev=3Dmem0 \
-object memory-backend-ram,id=3Dmem1,size=3D8G \
-device nvdimm,id=3Ddimm1,memdev=3Dmem1,node=3D1

(qemu) info numa
info numa
2 nodes
node 0 cpus: 0 1
node 0 size: 10240 MB
node 0 plugged: 0 MB
node 1 cpus: 2 3
node 1 size: 10240 MB
node 1 plugged: 0 MB


(qemu) info memory_size_summary
info memory_size_summary
base memory: 4294967296
plugged memory: 17179869184

(qemu) info memory-devices
info memory-devices
Memory device [dimm]: "dimm0"
  addr: 0x140000000
  slot: 0
  node: 0
  size: 8589934592
  memdev: /objects/mem0
  hotplugged: false
  hotpluggable: true
Memory device [nvdimm]: "dimm1"
  addr: 0x340000000
  slot: 1
  node: 1
  size: 8589934592
  memdev: /objects/mem1
  hotplugged: false
  hotpluggable: true


(qemu) info balloon
info balloon
balloon: actual=3D12288


1. "info numa"
- considers both, pc-dimm and nvdimm
- "-device ..." are considered as "!plugged" although it could be
  theoretically "unplugged"
- device_add devices are considered as "plugged"

2. "info memory_size_summary"
- considers both, pc-dimm and nvdimm
- "-device ..." are considered as "plugged"
- device_add devices are considered as "plugged"

3. "info balloon"
- does not consider nvdimm devices to calculate "actual"
-- actual =3D get_current_ram_size() - inflated
-- get_current_ram_size() does not consider nvdimm

So we have some inconsistency in regards of
1. What is considered memory and what not (pc-dimm vs nvdimm)
2. What is considered plugged memory (-device vs. device_add)


Is this what we expect? I think we should make up our mind

a) what "plugged" means
b) which stats should consider "nvdimm" and which not.

I would have guessed that "nvdimms" might be memory devices but should
never count towards memory statistics ("not actually ram" - they might
be OK).

Especially "info memory_size_summary" ... "plugged-memory - amount of
memory that was hot-plugged" - this seems to be wrong. And I wonder if
we should exclude nvdimm from that.

--=20

Thanks,

David / dhildenb
