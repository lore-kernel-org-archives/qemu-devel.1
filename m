Received: from eggs.gnu.org ([2001:4830:134:3::10]:53519)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <junyan.he@gmx.com>) id 1fH2MI-0003ei-PL
	for qemu-devel@nongnu.org; Fri, 11 May 2018 03:20:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <junyan.he@gmx.com>) id 1fH2MF-0001VP-Ga
	for qemu-devel@nongnu.org; Fri, 11 May 2018 03:20:54 -0400
Received: from mout.gmx.net ([212.227.17.22]:48503)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <junyan.he@gmx.com>) id 1fH2MF-0001Uo-5k
	for qemu-devel@nongnu.org; Fri, 11 May 2018 03:20:51 -0400
MIME-Version: 1.0
Message-ID: <trinity-efbc57e1-aec1-49d7-92d1-28c83e7f47f5-1526023227306@3c-app-mailcom-bs02>
From: "Junyan He" <junyan.he@gmx.com>
Content-Type: text/plain; charset=UTF-8
Date: Fri, 11 May 2018 09:20:27 +0200
In-Reply-To: <20180510210810.GA28333@kermit-br-ibm-com>
References: <1525918138-6189-1-git-send-email-junyan.he@gmx.com>
	<1525918138-6189-2-git-send-email-junyan.he@gmx.com>
	<20180510210810.GA28333@kermit-br-ibm-com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/9 V5] memory,
 exec: switch file ram allocation functions to 'flags' parameters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
Cc: Haozhong Zhang <haozhong.zhang@intel.com>, xiaoguangrong.eric@gmail.com, crosthwaite.peter@gmail.com, mst@redhat.com, qemu-devel@nongnu.org, dgilbert@redhat.com, quintela@redhat.com, Junyan
	He <junyan.he@intel.com>, stefanha@redhat.com, imammedo@redhat.com, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com

>
>=C2=A0
>=C2=A0
>
>Sent:=C2=A0Friday, May 11, 2018 at 5:08 AM
>From:=C2=A0"Murilo Opsfelder Araujo" <muriloo@linux=2Eibm=2Ecom>
>To:=C2=A0junyan=2Ehe@gmx=2Ecom
>Cc:=C2=A0"Haozhong Zhang" <haozhong=2Ezhang@intel=2Ecom>, xiaoguangrong=
=2Eeric@gmail=2Ecom, crosthwaite=2Epeter@gmail=2Ecom, mst@redhat=2Ecom, qem=
u-devel@nongnu=2Eorg, dgilbert@redhat=2Ecom, quintela@redhat=2Ecom, "Junyan=
 He" <junyan=2Ehe@intel=2Ecom>, stefanha@redhat=2Ecom, imammedo@redhat=2Eco=
m, pbonzini@redhat=2Ecom, rth@twiddle=2Enet, ehabkost@redhat=2Ecom
>Subject:=C2=A0Re: [Qemu-devel] [PATCH 1/9 V5] memory, exec: switch file r=
am allocation functions to 'flags' parameters
>On Thu, May 10, 2018 at 10:08:50AM +0800, junyan=2Ehe@gmx=2Ecom wrote:
>> From: Junyan He <junyan=2Ehe@intel=2Ecom>
>>
>> As more flag parameters besides the existing 'share' are going to be
>> added to following functions
>> memory_region_init_ram_from_file
>> qemu_ram_alloc_from_fd
>> qemu_ram_alloc_from_file
>> let's switch them to use the 'flags' parameters so as to ease future
>> flag additions=2E
>>
>> The existing 'share' flag is converted to the QEMU_RAM_SHARE bit in
>> flags, and other flag bits are ignored by above functions right now=2E
>>
>> Signed-off-by: Haozhong Zhang <haozhong=2Ezhang@intel=2Ecom>
>> ---
>> backends/hostmem-file=2Ec | 3 ++-
>> exec=2Ec | 7 ++++---
>> include/exec/memory=2Eh | 10 ++++++++--
>> include/exec/ram_addr=2Eh | 25 +++++++++++++++++++++++--
>> memory=2Ec | 8 +++++---
>> numa=2Ec | 2 +-
>> 6 files changed, 43 insertions(+), 12 deletions(-)
>>
>> diff --git a/backends/hostmem-file=2Ec b/backends/hostmem-file=2Ec
>> index 134b08d=2E=2E30df843 100644
>> --- a/backends/hostmem-file=2Ec
>> +++ b/backends/hostmem-file=2Ec
>> @@ -58,7 +58,8 @@ file_backend_memory_alloc(HostMemoryBackend *backend,=
 Error **errp)
>> path =3D object_get_canonical_path(OBJECT(backend));
>> memory_region_init_ram_from_file(&backend->mr, OBJECT(backend),
>> path,
>> - backend->size, fb->align, backend->share,
>> + backend->size, fb->align,
>> + backend->share ? QEMU_RAM_SHARE : 0,
>> fb->mem_path, errp);
>> g_free(path);
>> }
>> diff --git a/exec=2Ec b/exec=2Ec
>> index c7fcefa=2E=2Efa33c29 100644
>> --- a/exec=2Ec
>> +++ b/exec=2Ec
>> @@ -2030,12 +2030,13 @@ static void ram_block_add(RAMBlock *new_block, =
Error **errp, bool shared)
>>
>> #ifdef __linux__
>> RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
>> - bool share, int fd,
>> + uint64_t flags, int fd,
>> Error **errp)
>> {
>> RAMBlock *new_block;
>> Error *local_err =3D NULL;
>> int64_t file_size;
>> + bool share =3D flags & QEMU_RAM_SHARE;
>>
>> if (xen_enabled()) {
>> error_setg(errp, "-mem-path not supported with Xen");
>> @@ -2091,7 +2092,7 @@ RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size,=
 MemoryRegion *mr,
>>
>>
>> RAMBlock *qemu_ram_alloc_from_file(ram_addr_t size, MemoryRegion *mr,
>> - bool share, const char *mem_path,
>> + uint64_t flags, const char *mem_path,
>> Error **errp)
>> {
>> int fd;
>> @@ -2103,7 +2104,7 @@ RAMBlock *qemu_ram_alloc_from_file(ram_addr_t siz=
e, MemoryRegion *mr,
>> return NULL;
>> }
>>
>> - block =3D qemu_ram_alloc_from_fd(size, mr, share, fd, errp);
>> + block =3D qemu_ram_alloc_from_fd(size, mr, flags, fd, errp);
>> if (!block) {
>> if (created) {
>> unlink(mem_path);
>> diff --git a/include/exec/memory=2Eh b/include/exec/memory=2Eh
>> index 31eae0a=2E=2E0460313 100644
>> --- a/include/exec/memory=2Eh
>> +++ b/include/exec/memory=2Eh
>> @@ -507,6 +507,9 @@ void memory_region_init_resizeable_ram(MemoryRegion=
 *mr,
>> void *host),
>> Error **errp);
>> #ifdef __linux__
>> +
>> +#define QEMU_RAM_SHARE (1UL << 0)
>> +
>
>Hi, Junyan=2E
>
>How does this differ from RAM_SHARED in exec=2Ec?
>
Yes, they are really the same meaning=2E
But this one is for memory object backend while the RAM_SHARED in exec=2Ec=
 is used for
memory block=2E I think we need it here=2E


>> /**
>> * memory_region_init_ram_from_file: Initialize RAM memory region with a
>> * mmap-ed backend=2E
>> @@ -518,7 +521,10 @@ void memory_region_init_resizeable_ram(MemoryRegio=
n *mr,
>> * @size: size of the region=2E
>> * @align: alignment of the region base address; if 0, the default align=
ment
>> * (getpagesize()) will be used=2E
>> - * @share: %true if memory must be mmaped with the MAP_SHARED flag
>> + * @flags: specify properties of this memory region, which can be one =
or bit-or
>> + * of following values:
>> + * - QEMU_RAM_SHARE: memory must be mmaped with the MAP_SHARED flag
>> + * Other bits are ignored=2E
>> * @path: the path in which to allocate the RAM=2E
>> * @errp: pointer to Error*, to store an error if it happens=2E
>> *
>> @@ -530,7 +536,7 @@ void memory_region_init_ram_from_file(MemoryRegion =
*mr,
>> const char *name,
>> uint64_t size,
>> uint64_t align,
>> - bool share,
>> + uint64_t flags,
>> const char *path,
>> Error **errp);
>>
>> diff --git a/include/exec/ram_addr=2Eh b/include/exec/ram_addr=2Eh
>> index cf2446a=2E=2Eb8b01d1 100644
>> --- a/include/exec/ram_addr=2Eh
>> +++ b/include/exec/ram_addr=2Eh
>> @@ -72,12 +72,33 @@ static inline unsigned long int ramblock_recv_bitma=
p_offset(void *host_addr,
>>
>> long qemu_getrampagesize(void);
>> unsigned long last_ram_page(void);
>> +
>> +/**
>> + * qemu_ram_alloc_from_file,
>> + * qemu_ram_alloc_from_fd: Allocate a ram block from the specified bac=
k
>> + * file or device
>> + *
>> + * Parameters:
>> + * @size: the size in bytes of the ram block
>> + * @mr: the memory region where the ram block is
>> + * @flags: specify the properties of the ram block, which can be one
>> + * or bit-or of following values
>> + * - QEMU_RAM_SHARE: mmap the back file or device with MAP_SHARED
>> + * Other bits are ignored=2E
>> + * @mem_path or @fd: specify the back file or device
>> + * @errp: pointer to Error*, to store an error if it happens
>> + *
>> + * Return:
>> + * On success, return a pointer to the ram block=2E
>> + * On failure, return NULL=2E
>> + */
>> RAMBlock *qemu_ram_alloc_from_file(ram_addr_t size, MemoryRegion *mr,
>> - bool share, const char *mem_path,
>> + uint64_t flags, const char *mem_path,
>> Error **errp);
>> RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
>> - bool share, int fd,
>> + uint64_t flags, int fd,
>> Error **errp);
>> +
>> RAMBlock *qemu_ram_alloc_from_ptr(ram_addr_t size, void *host,
>> MemoryRegion *mr, Error **errp);
>> RAMBlock *qemu_ram_alloc(ram_addr_t size, bool share, MemoryRegion *mr,
>> diff --git a/memory=2Ec b/memory=2Ec
>> index e70b64b=2E=2E3522518 100644
>> --- a/memory=2Ec
>> +++ b/memory=2Ec
>> @@ -1552,7 +1552,7 @@ void memory_region_init_ram_from_file(MemoryRegio=
n *mr,
>> const char *name,
>> uint64_t size,
>> uint64_t align,
>> - bool share,
>> + uint64_t flags,
>> const char *path,
>> Error **errp)
>> {
>> @@ -1561,7 +1561,7 @@ void memory_region_init_ram_from_file(MemoryRegio=
n *mr,
>> mr->terminates =3D true;
>> mr->destructor =3D memory_region_destructor_ram;
>> mr->align =3D align;
>> - mr->ram_block =3D qemu_ram_alloc_from_file(size, mr, share, path, err=
p);
>> + mr->ram_block =3D qemu_ram_alloc_from_file(size, mr, flags, path, err=
p);
>> mr->dirty_log_mask =3D tcg_enabled() ? (1 << DIRTY_MEMORY_CODE) : 0;
>> }
>>
>> @@ -1577,7 +1577,9 @@ void memory_region_init_ram_from_fd(MemoryRegion =
*mr,
>> mr->ram =3D true;
>> mr->terminates =3D true;
>> mr->destructor =3D memory_region_destructor_ram;
>> - mr->ram_block =3D qemu_ram_alloc_from_fd(size, mr, share, fd, errp);
>> + mr->ram_block =3D qemu_ram_alloc_from_fd(size, mr,
>> + share ? QEMU_RAM_SHARE : 0,
>> + fd, errp);
>> mr->dirty_log_mask =3D tcg_enabled() ? (1 << DIRTY_MEMORY_CODE) : 0;
>> }
>> #endif
>> diff --git a/numa=2Ec b/numa=2Ec
>> index 78a869e=2E=2Ed5b1578 100644
>> --- a/numa=2Ec
>> +++ b/numa=2Ec
>> @@ -457,7 +457,7 @@ static void allocate_system_memory_nonnuma(MemoryRe=
gion *mr, Object *owner,
>> if (mem_path) {
>> #ifdef __linux__
>> Error *err =3D NULL;
>> - memory_region_init_ram_from_file(mr, owner, name, ram_size, 0, false,
>> + memory_region_init_ram_from_file(mr, owner, name, ram_size, 0, 0,
>> mem_path, &err);
>> if (err) {
>> error_report_err(err);
>> --
>> 2=2E7=2E4
>>
>>
>
>--
>Murilo
