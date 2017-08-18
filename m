Received: from eggs.gnu.org ([2001:4830:134:3::10]:47336)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dia0N-0004ac-Gg
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 01:39:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dia0I-0004So-05
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 01:39:35 -0400
Received: from mail-pg0-x22f.google.com ([2607:f8b0:400e:c05::22f]:36722)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1dia0H-0004Ri-Ho
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 01:39:29 -0400
Received: by mail-pg0-x22f.google.com with SMTP id i12so57323754pgr.3
	for <qemu-devel@nongnu.org>; Thu, 17 Aug 2017 22:39:27 -0700 (PDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <283a2a27-7fb5-5fa7-4921-60ba91f13666@ozlabs.ru>
Date: Fri, 18 Aug 2017 15:39:20 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] Memory use with >100 virtio devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: David Gibson <david@gibson.dropbear.id.au>

Hi!

We have received a report that qemu cannot handle hundreds of virtio
devices and crashes. I tried qemu with 150 virtio-block devices, 1 CPU and
and 2GB RAM (the exact command line is at the end) and found that it took
more than 5.5GB resident and 9GB virtual memory. Bit weird, I tried
valgrind and from what I see, most memory was lost in enormous amount of
realloc()s.

~700 devices was my maximum on a 128GB host, QEMU with more than that would
be killed by kernel's OOM.	

It does not sound like a problem which needs an urgent attention but I am
still curious - is there a way to tell libc's allocator to be smarter?




==94451== Parent PID: 94138
==94451==
==94451==
==94451== ======== SUMMARY STATISTICS ========
==94451==
==94451== guest_insns:  17,414,575,724
==94451==
==94451== max_live:     8,103,226,799 in 1,288,978 blocks
==94451==
==94451== tot_alloc:    9,256,734,636 in 1,474,121 blocks
==94451==
==94451== insns per allocated byte: 1
==94451==
==94451==
==94451== ======== ORDERED BY decreasing "max-bytes-live": top 10
allocators ========
==94451==
==94451== -------------------- 1 of 10 --------------------
==94451== max-live:    3,805,483,008 in 77,462 blocks
==94451== tot-alloc:   3,805,483,008 in 77,462 blocks (avg size 49127.09)
==94451== deaths:      77,309, at avg age 10,068,510,919 (57.81% of prog
lifetime)
==94451== acc-ratios:  0.29 rd, 0.24 wr  (1,135,549,612 b-read, 950,066,280
b-written)
==94451==    at 0x48920C4: malloc (in
/usr/lib/valgrind/vgpreload_exp-dhat-ppc64le-linux.so)
==94451==    by 0x4895517: realloc (in
/usr/lib/valgrind/vgpreload_exp-dhat-ppc64le-linux.so)
==94451==    by 0x59E7393: g_realloc (in
/lib/powerpc64le-linux-gnu/libglib-2.0.so.0.5000.2)
==94451==    by 0x59E7757: g_realloc_n (in
/lib/powerpc64le-linux-gnu/libglib-2.0.so.0.5000.2)
==94451==    by 0x3A785B: phys_map_node_reserve (exec.c:251)
==94451==    by 0x3A7CE3: phys_page_set (exec.c:307)
==94451==    by 0x3AAF27: register_multipage (exec.c:1345)
==94451==    by 0x3AB31F: mem_add (exec.c:1376)
==94451==    by 0x437F53: address_space_update_topology_pass (memory.c:855)
==94451==    by 0x4382C3: address_space_update_topology (memory.c:889)
==94451==    by 0x438503: memory_region_transaction_commit (memory.c:925)
==94451==    by 0x43D07F: memory_region_update_container_subregions
(memory.c:2136)
==94451==
==94451== -------------------- 2 of 10 --------------------
==94451== max-live:    1,332,215,808 in 27,104 blocks
==94451== tot-alloc:   1,332,215,808 in 27,104 blocks (avg size 49152.00)
==94451== deaths:      27,104, at avg age 2,360,954,537 (13.55% of prog
lifetime)
==94451== acc-ratios:  0.30 rd, 0.25 wr  (399,684,736 b-read, 333,887,488
b-written)
==94451==    at 0x48920C4: malloc (in
/usr/lib/valgrind/vgpreload_exp-dhat-ppc64le-linux.so)
==94451==    by 0x4895517: realloc (in
/usr/lib/valgrind/vgpreload_exp-dhat-ppc64le-linux.so)
==94451==    by 0x59E7393: g_realloc (in
/lib/powerpc64le-linux-gnu/libglib-2.0.so.0.5000.2)
==94451==    by 0x59E7757: g_realloc_n (in
/lib/powerpc64le-linux-gnu/libglib-2.0.so.0.5000.2)
==94451==    by 0x3A785B: phys_map_node_reserve (exec.c:251)
==94451==    by 0x3A7CE3: phys_page_set (exec.c:307)
==94451==    by 0x3AAF27: register_multipage (exec.c:1345)
==94451==    by 0x3AB31F: mem_add (exec.c:1376)
==94451==    by 0x437F53: address_space_update_topology_pass (memory.c:855)
==94451==    by 0x4382C3: address_space_update_topology (memory.c:889)
==94451==    by 0x438503: memory_region_transaction_commit (memory.c:925)
==94451==    by 0x43D3CF: memory_region_set_enabled (memory.c:2186)
==94451==
==94451== -------------------- 3 of 10 --------------------
==94451== max-live:    1,229,537,280 in 25,026 blocks
==94451== tot-alloc:   1,229,537,280 in 25,026 blocks (avg size 49130.39)
==94451== deaths:      25,026, at avg age 10,091,400,121 (57.94% of prog
lifetime)
==94451== acc-ratios:  0.29 rd, 0.24 wr  (366,871,968 b-read, 306,940,392
b-written)
==94451==    at 0x48920C4: malloc (in
/usr/lib/valgrind/vgpreload_exp-dhat-ppc64le-linux.so)
==94451==    by 0x4895517: realloc (in
/usr/lib/valgrind/vgpreload_exp-dhat-ppc64le-linux.so)
==94451==    by 0x59E7393: g_realloc (in
/lib/powerpc64le-linux-gnu/libglib-2.0.so.0.5000.2)
==94451==    by 0x59E7757: g_realloc_n (in
/lib/powerpc64le-linux-gnu/libglib-2.0.so.0.5000.2)
==94451==    by 0x3A785B: phys_map_node_reserve (exec.c:251)
==94451==    by 0x3A7CE3: phys_page_set (exec.c:307)
==94451==    by 0x3AAF27: register_multipage (exec.c:1345)
==94451==    by 0x3AB31F: mem_add (exec.c:1376)
==94451==    by 0x437F53: address_space_update_topology_pass (memory.c:855)
==94451==    by 0x4382C3: address_space_update_topology (memory.c:889)
==94451==    by 0x438503: memory_region_transaction_commit (memory.c:925)
==94451==    by 0x43F017: address_space_init (memory.c:2596)
==94451==
==94451== -------------------- 4 of 10 --------------------
==94451== max-live:    314,649,600 in 150 blocks
==94451== tot-alloc:   314,649,600 in 150 blocks (avg size 2097664.00)
==94451== deaths:      none (none of these blocks were freed)
==94451== acc-ratios:  0.00 rd, 0.00 wr  (0 b-read, 0 b-written)
==94451==    at 0x4895600: memalign (in
/usr/lib/valgrind/vgpreload_exp-dhat-ppc64le-linux.so)
==94451==    by 0x48957E7: posix_memalign (in
/usr/lib/valgrind/vgpreload_exp-dhat-ppc64le-linux.so)
==94451==    by 0xB744AB: qemu_try_memalign (oslib-posix.c:106)
==94451==    by 0xA92053: qemu_try_blockalign (io.c:2493)
==94451==    by 0xA34DDF: qcow2_do_open (qcow2.c:1365)
==94451==    by 0xA35627: qcow2_open (qcow2.c:1526)
==94451==    by 0x9FB94F: bdrv_open_driver (block.c:1109)
==94451==    by 0x9FC413: bdrv_open_common (block.c:1365)
==94451==    by 0x9FF823: bdrv_open_inherit (block.c:2542)
==94451==    by 0x9FFC17: bdrv_open (block.c:2626)
==94451==    by 0xA71027: blk_new_open (block-backend.c:267)
==94451==    by 0x6D3E6B: blockdev_init (blockdev.c:588)
==94451==
==94451== -------------------- 5 of 10 --------------------
==94451== max-live:    314,649,600 in 150 blocks
==94451== tot-alloc:   314,649,600 in 150 blocks (avg size 2097664.00)
==94451== deaths:      none (none of these blocks were freed)
==94451== acc-ratios:  0.00 rd, 0.00 wr  (0 b-read, 0 b-written)
==94451==    at 0x4895600: memalign (in
/usr/lib/valgrind/vgpreload_exp-dhat-ppc64le-linux.so)
==94451==    by 0x48957E7: posix_memalign (in
/usr/lib/valgrind/vgpreload_exp-dhat-ppc64le-linux.so)
==94451==    by 0xB744AB: qemu_try_memalign (oslib-posix.c:106)
==94451==    by 0xA92053: qemu_try_blockalign (io.c:2493)
==94451==    by 0xA34DDF: qcow2_do_open (qcow2.c:1365)
==94451==    by 0xA35627: qcow2_open (qcow2.c:1526)
==94451==    by 0x9FB94F: bdrv_open_driver (block.c:1109)
==94451==    by 0x9FC413: bdrv_open_common (block.c:1365)
==94451==    by 0x9FF823: bdrv_open_inherit (block.c:2542)
==94451==    by 0x9FFC17: bdrv_open (block.c:2626)
==94451==    by 0x9FEF73: bdrv_append_temp_snapshot (block.c:2336)
==94451==    by 0x9FF9BF: bdrv_open_inherit (block.c:2585)
==94451==
==94451== -------------------- 6 of 10 --------------------
==94451== max-live:    314,572,800 in 300 blocks
==94451== tot-alloc:   629,145,600 in 600 blocks (avg size 1048576.00)
==94451== deaths:      300, at avg age 755,507 (0.00% of prog lifetime)
==94451== acc-ratios:  0.00 rd, 0.00 wr  (0 b-read, 0 b-written)
==94451==    at 0x4895600: memalign (in
/usr/lib/valgrind/vgpreload_exp-dhat-ppc64le-linux.so)
==94451==    by 0x48957E7: posix_memalign (in
/usr/lib/valgrind/vgpreload_exp-dhat-ppc64le-linux.so)
==94451==    by 0xB744AB: qemu_try_memalign (oslib-posix.c:106)
==94451==    by 0xA92053: qemu_try_blockalign (io.c:2493)
==94451==    by 0xA503F3: qcow2_cache_create (qcow2-cache.c:124)
==94451==    by 0xA3351B: qcow2_update_options_prepare (qcow2.c:878)
==94451==    by 0xA33FAF: qcow2_update_options (qcow2.c:1077)
==94451==    by 0xA34D77: qcow2_do_open (qcow2.c:1358)
==94451==    by 0xA35627: qcow2_open (qcow2.c:1526)
==94451==    by 0x9FB94F: bdrv_open_driver (block.c:1109)
==94451==    by 0x9FC413: bdrv_open_common (block.c:1365)
==94451==    by 0x9FF823: bdrv_open_inherit (block.c:2542)
==94451==
==94451== -------------------- 7 of 10 --------------------
==94451== max-live:    155,589,632 in 1 blocks
==94451== tot-alloc:   155,589,632 in 1 blocks (avg size 155589632.00)
==94451== deaths:      none (none of these blocks were freed)
==94451== acc-ratios:  1.00 rd, 1.00 wr  (155,589,632 b-read, 155,589,632
b-written)
==94451==    at 0x4895158: calloc (in
/usr/lib/valgrind/vgpreload_exp-dhat-ppc64le-linux.so)
==94451==    by 0x59E72DF: g_malloc0 (in
/lib/powerpc64le-linux-gnu/libglib-2.0.so.0.5000.2)
==94451==    by 0x79C4D3: rom_add_file (loader.c:930)
==94451==    by 0x797307: load_image_targphys_as (loader.c:153)
==94451==    by 0x79725F: load_image_targphys (loader.c:139)
==94451==    by 0x515707: ppc_spapr_init (spapr.c:2451)
==94451==    by 0x79669B: machine_run_board_init (machine.c:760)
==94451==    by 0x6F5AD3: main (vl.c:4630)
==94451==
==94451== -------------------- 8 of 10 --------------------
==94451== max-live:    105,603,072 in 103,128 blocks
==94451== tot-alloc:   105,603,072 in 103,128 blocks (avg size 1024.00)
==94451== deaths:      103,128, at avg age 10,097,736,363 (57.98% of prog
lifetime)
==94451== acc-ratios:  0.04 rd, 0.36 wr  (4,761,696 b-read, 38,093,568
b-written)
==94451==    at 0x48920C4: malloc (in
/usr/lib/valgrind/vgpreload_exp-dhat-ppc64le-linux.so)
==94451==    by 0x4895517: realloc (in
/usr/lib/valgrind/vgpreload_exp-dhat-ppc64le-linux.so)
==94451==    by 0x59E7393: g_realloc (in
/lib/powerpc64le-linux-gnu/libglib-2.0.so.0.5000.2)
==94451==    by 0x59E7757: g_realloc_n (in
/lib/powerpc64le-linux-gnu/libglib-2.0.so.0.5000.2)
==94451==    by 0x3AA99F: phys_section_add (exec.c:1275)
==94451==    by 0x3AF087: dummy_section (exec.c:2644)
==94451==    by 0x3AF307: mem_begin (exec.c:2680)
==94451==    by 0x4384C7: memory_region_transaction_commit (memory.c:922)
==94451==    by 0x43D07F: memory_region_update_container_subregions
(memory.c:2136)
==94451==    by 0x43D11F: memory_region_add_subregion_common (memory.c:2146)
==94451==    by 0x43D187: memory_region_add_subregion (memory.c:2154)
==94451==    by 0x92D63B: virtio_pci_modern_region_map (virtio-pci.c:1526)
==94451==
==94451== Aggregated access counts by offset:
==94451==
==94451== [   0]  206256 206256 206256 206256 206256 206256 206256 206256
103128 103128 103128 103128 103128 103128 103128 103128
==94451== [  16]  103128 103128 103128 103128 103128 103128 103128 103128
103128 103128 103128 103128 103128 103128 103128 103128
==94451== [  32]  103128 103128 103128 103128 103128 103128 103128 103128
103128 103128 103128 103128 103128 103128 103128 103128
==94451== [  48]  103128 103128 103128 103128 103128 103128 103128 103128
103128 103128 103128 103128 103128 103128 103128 103128
==94451== [  64]  206256 206256 206256 206256 206256 206256 206256 206256
103128 103128 103128 103128 103128 103128 103128 103128
==94451== [  80]  103128 103128 103128 103128 103128 103128 103128 103128
103128 103128 103128 103128 103128 103128 103128 103128
==94451== [  96]  103128 103128 103128 103128 103128 103128 103128 103128
103128 103128 103128 103128 103128 103128 103128 103128
==94451== [ 112]  103128 103128 103128 103128 103128 103128 103128 103128
103128 103128 103128 103128 103128 103128 103128 103128
==94451== [ 128]  206256 206256 206256 206256 206256 206256 206256 206256
103128 103128 103128 103128 103128 103128 103128 103128
==94451== [ 144]  103128 103128 103128 103128 103128 103128 103128 103128
103128 103128 103128 103128 103128 103128 103128 103128
==94451== [ 160]  103128 103128 103128 103128 103128 103128 103128 103128
103128 103128 103128 103128 103128 103128 103128 103128
==94451== [ 176]  103128 103128 103128 103128 103128 103128 103128 103128
103128 103128 103128 103128 103128 103128 103128 103128
==94451== [ 192]  206256 206256 206256 206256 206256 206256 206256 206256
103128 103128 103128 103128 103128 103128 103128 103128
==94451== [ 208]  103128 103128 103128 103128 103128 103128 103128 103128
103128 103128 103128 103128 103128 103128 103128 103128
==94451== [ 224]  103128 103128 103128 103128 103128 103128 103128 103128
103128 103128 103128 103128 103128 103128 103128 103128
==94451== [ 240]  103128 103128 103128 103128 103128 103128 103128 103128
103128 103128 103128 103128 103128 103128 103128 103128
==94451== [ 256]  95400 95400 95400 95400 95400 95400 95400 95400 47700
47700 47700 47700 47700 47700 47700 47700
==94451== [ 272]  47700 47700 47700 47700 47700 47700 47700 47700 47700
47700 47700 47700 47700 47700 47700 47700
==94451== [ 288]  47700 47700 47700 47700 47700 47700 47700 47700 47700
47700 47700 47700 47700 47700 47700 47700
==94451== [ 304]  47700 47700 47700 47700 47700 47700 47700 47700 47700
47700 47700 47700 47700 47700 47700 47700
==94451== [ 320]  90300 90300 90300 90300 90300 90300 90300 90300 45150
45150 45150 45150 45150 45150 45150 45150
==94451== [ 336]  45150 45150 45150 45150 45150 45150 45150 45150 45150
45150 45150 45150 45150 45150 45150 45150
==94451== [ 352]  45150 45150 45150 45150 45150 45150 45150 45150 45150
45150 45150 45150 45150 45150 45150 45150
==94451== [ 368]  45150 45150 45150 45150 45150 45150 45150 45150 45150
45150 45150 45150 45150 45150 45150 45150
==94451== [ 384]  90000 90000 90000 90000 90000 90000 90000 90000 45000
45000 45000 45000 45000 45000 45000 45000
==94451== [ 400]  45000 45000 45000 45000 45000 45000 45000 45000 45000
45000 45000 45000 45000 45000 45000 45000
==94451== [ 416]  45000 45000 45000 45000 45000 45000 45000 45000 45000
45000 45000 45000 45000 45000 45000 45000
==94451== [ 432]  45000 45000 45000 45000 45000 45000 45000 45000 45000
45000 45000 45000 45000 45000 45000 45000
==94451== [ 448]  89700 89700 89700 89700 89700 89700 89700 89700 44850
44850 44850 44850 44850 44850 44850 44850
==94451== [ 464]  44850 44850 44850 44850 44850 44850 44850 44850 44850
44850 44850 44850 44850 44850 44850 44850
==94451== [ 480]  44850 44850 44850 44850 44850 44850 44850 44850 44850
44850 44850 44850 44850 44850 44850 44850
==94451== [ 496]  44850 44850 44850 44850 44850 44850 44850 44850 44850
44850 44850 44850 44850 44850 44850 44850
==94451== [ 512]  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
==94451== [ 528]  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
==94451== [ 544]  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
==94451== [ 560]  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
==94451== [ 576]  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
==94451== [ 592]  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
==94451== [ 608]  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
==94451== [ 624]  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
==94451== [ 640]  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
==94451== [ 656]  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
==94451== [ 672]  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
==94451== [ 688]  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
==94451== [ 704]  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
==94451== [ 720]  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
==94451== [ 736]  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
==94451== [ 752]  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
==94451== [ 768]  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
==94451== [ 784]  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
==94451== [ 800]  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
==94451== [ 816]  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
==94451== [ 832]  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
==94451== [ 848]  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
==94451== [ 864]  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
==94451== [ 880]  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
==94451== [ 896]  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
==94451== [ 912]  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
==94451== [ 928]  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
==94451== [ 944]  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
==94451== [ 960]  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
==94451== [ 976]  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
==94451== [ 992]  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
==94451== [1008]  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
==94451==
==94451== -------------------- 9 of 10 --------------------
==94451== max-live:    78,643,200 in 300 blocks
==94451== tot-alloc:   157,286,400 in 600 blocks (avg size 262144.00)
==94451== deaths:      300, at avg age 755,346 (0.00% of prog lifetime)
==94451== acc-ratios:  0.06 rd, 0.06 wr  (9,832,800 b-read, 9,831,600
b-written)
==94451==    at 0x4895600: memalign (in
/usr/lib/valgrind/vgpreload_exp-dhat-ppc64le-linux.so)
==94451==    by 0x48957E7: posix_memalign (in
/usr/lib/valgrind/vgpreload_exp-dhat-ppc64le-linux.so)
==94451==    by 0xB744AB: qemu_try_memalign (oslib-posix.c:106)
==94451==    by 0xA92053: qemu_try_blockalign (io.c:2493)
==94451==    by 0xA503F3: qcow2_cache_create (qcow2-cache.c:124)
==94451==    by 0xA3353F: qcow2_update_options_prepare (qcow2.c:879)
==94451==    by 0xA33FAF: qcow2_update_options (qcow2.c:1077)
==94451==    by 0xA34D77: qcow2_do_open (qcow2.c:1358)
==94451==    by 0xA35627: qcow2_open (qcow2.c:1526)
==94451==    by 0x9FB94F: bdrv_open_driver (block.c:1109)
==94451==    by 0x9FC413: bdrv_open_common (block.c:1365)
==94451==    by 0x9FF823: bdrv_open_inherit (block.c:2542)
==94451==
==94451== -------------------- 10 of 10 --------------------
==94451== max-live:    59,473,920 in 58,080 blocks
==94451== tot-alloc:   59,473,920 in 58,080 blocks (avg size 1024.00)
==94451== deaths:      58,080, at avg age 2,365,618,267 (13.58% of prog
lifetime)
==94451== acc-ratios:  0.04 rd, 0.36 wr  (2,708,992 b-read, 21,671,936
b-written)
==94451==    at 0x48920C4: malloc (in
/usr/lib/valgrind/vgpreload_exp-dhat-ppc64le-linux.so)
==94451==    by 0x4895517: realloc (in
/usr/lib/valgrind/vgpreload_exp-dhat-ppc64le-linux.so)
==94451==    by 0x59E7393: g_realloc (in
/lib/powerpc64le-linux-gnu/libglib-2.0.so.0.5000.2)
==94451==    by 0x59E7757: g_realloc_n (in
/lib/powerpc64le-linux-gnu/libglib-2.0.so.0.5000.2)
==94451==    by 0x3AA99F: phys_section_add (exec.c:1275)
==94451==    by 0x3AF087: dummy_section (exec.c:2644)
==94451==    by 0x3AF307: mem_begin (exec.c:2680)
==94451==    by 0x4384C7: memory_region_transaction_commit (memory.c:922)
==94451==    by 0x43D3CF: memory_region_set_enabled (memory.c:2186)
==94451==    by 0x855E33: pci_init_bus_master (pci.c:92)
==94451==    by 0x855F0B: pcibus_machine_done (pci.c:104)
==94451==    by 0xB8E7D7: notifier_list_notify (notify.c:40)
==94451==
==94451== Aggregated access counts by offset:
==94451==
==94451== [   0]  116160 116160 116160 116160 116160 116160 116160 116160
58080 58080 58080 58080 58080 58080 58080 58080
==94451== [  16]  58080 58080 58080 58080 58080 58080 58080 58080 58080
58080 58080 58080 58080 58080 58080 58080
==94451== [  32]  58080 58080 58080 58080 58080 58080 58080 58080 58080
58080 58080 58080 58080 58080 58080 58080
==94451== [  48]  58080 58080 58080 58080 58080 58080 58080 58080 58080
58080 58080 58080 58080 58080 58080 58080
==94451== [  64]  116160 116160 116160 116160 116160 116160 116160 116160
58080 58080 58080 58080 58080 58080 58080 58080
==94451== [  80]  58080 58080 58080 58080 58080 58080 58080 58080 58080
58080 58080 58080 58080 58080 58080 58080
==94451== [  96]  58080 58080 58080 58080 58080 58080 58080 58080 58080
58080 58080 58080 58080 58080 58080 58080
==94451== [ 112]  58080 58080 58080 58080 58080 58080 58080 58080 58080
58080 58080 58080 58080 58080 58080 58080
==94451== [ 128]  116160 116160 116160 116160 116160 116160 116160 116160
58080 58080 58080 58080 58080 58080 58080 58080
==94451== [ 144]  58080 58080 58080 58080 58080 58080 58080 58080 58080
58080 58080 58080 58080 58080 58080 58080
==94451== [ 160]  58080 58080 58080 58080 58080 58080 58080 58080 58080
58080 58080 58080 58080 58080 58080 58080
==94451== [ 176]  58080 58080 58080 58080 58080 58080 58080 58080 58080
58080 58080 58080 58080 58080 58080 58080
==94451== [ 192]  116160 116160 116160 116160 116160 116160 116160 116160
58080 58080 58080 58080 58080 58080 58080 58080
==94451== [ 208]  58080 58080 58080 58080 58080 58080 58080 58080 58080
58080 58080 58080 58080 58080 58080 58080
==94451== [ 224]  58080 58080 58080 58080 58080 58080 58080 58080 58080
58080 58080 58080 58080 58080 58080 58080
==94451== [ 240]  58080 58080 58080 58080 58080 58080 58080 58080 58080
58080 58080 58080 58080 58080 58080 58080
==94451== [ 256]  54208 54208 54208 54208 54208 54208 54208 54208 27104
27104 27104 27104 27104 27104 27104 27104
==94451== [ 272]  27104 27104 27104 27104 27104 27104 27104 27104 27104
27104 27104 27104 27104 27104 27104 27104
==94451== [ 288]  27104 27104 27104 27104 27104 27104 27104 27104 27104
27104 27104 27104 27104 27104 27104 27104
==94451== [ 304]  27104 27104 27104 27104 27104 27104 27104 27104 27104
27104 27104 27104 27104 27104 27104 27104
==94451== [ 320]  52800 52800 52800 52800 52800 52800 52800 52800 26400
26400 26400 26400 26400 26400 26400 26400
==94451== [ 336]  26400 26400 26400 26400 26400 26400 26400 26400 26400
26400 26400 26400 26400 26400 26400 26400
==94451== [ 352]  26400 26400 26400 26400 26400 26400 26400 26400 26400
26400 26400 26400 26400 26400 26400 26400
==94451== [ 368]  26400 26400 26400 26400 26400 26400 26400 26400 26400
26400 26400 26400 26400 26400 26400 26400
==94451== [ 384]  52800 52800 52800 52800 52800 52800 52800 52800 26400
26400 26400 26400 26400 26400 26400 26400
==94451== [ 400]  26400 26400 26400 26400 26400 26400 26400 26400 26400
26400 26400 26400 26400 26400 26400 26400
==94451== [ 416]  26400 26400 26400 26400 26400 26400 26400 26400 26400
26400 26400 26400 26400 26400 26400 26400
==94451== [ 432]  26400 26400 26400 26400 26400 26400 26400 26400 26400
26400 26400 26400 26400 26400 26400 26400
==94451== [ 448]  52800 52800 52800 52800 52800 52800 52800 52800 26400
26400 26400 26400 26400 26400 26400 26400
==94451== [ 464]  26400 26400 26400 26400 26400 26400 26400 26400 26400
26400 26400 26400 26400 26400 26400 26400
==94451== [ 480]  26400 26400 26400 26400 26400 26400 26400 26400 26400
26400 26400 26400 26400 26400 26400 26400
==94451== [ 496]  26400 26400 26400 26400 26400 26400 26400 26400 26400
26400 26400 26400 26400 26400 26400 26400
==94451== [ 512]  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
==94451== [ 528]  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
==94451== [ 544]  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
==94451== [ 560]  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
==94451== [ 576]  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
==94451== [ 592]  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
==94451== [ 608]  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
==94451== [ 624]  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
==94451== [ 640]  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
==94451== [ 656]  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
==94451== [ 672]  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
==94451== [ 688]  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
==94451== [ 704]  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
==94451== [ 720]  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
==94451== [ 736]  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
==94451== [ 752]  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
==94451== [ 768]  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
==94451== [ 784]  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
==94451== [ 800]  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
==94451== [ 816]  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
==94451== [ 832]  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
==94451== [ 848]  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
==94451== [ 864]  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
==94451== [ 880]  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
==94451== [ 896]  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
==94451== [ 912]  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
==94451== [ 928]  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
==94451== [ 944]  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
==94451== [ 960]  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
==94451== [ 976]  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
==94451== [ 992]  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
==94451== [1008]  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
==94451==
==94451==
==94451==
==94451== ==============================================================
==94451==
==94451== Some hints: (see --help for command line option details):
==94451==
==94451== * summary stats for whole program are at the top of this output
==94451==
==94451== * --show-top-n=  controls how many alloc points are shown.
==94451==                  You probably want to set it much higher than
==94451==                  the default value (10)
==94451==
==94451== * --sort-by=     specifies the sort key for output.
==94451==                  See --help for details.
==94451==
==94451== * Each allocation stack, by default 12 frames, counts as
==94451==   a separate alloc point.  This causes the data to be spread out
==94451==   over far too many alloc points.  I strongly suggest using
==94451==   --num-callers=4 or some such, to reduce the spreading.
==94451==




The command line:

valgrind --tool=exp-dhat --log-file=./qemu-vg-dhat.log --tool=memcheck \
--log-file=./qemu-vg-memcheck.log --error-limit=no \
--run-libc-freeres=yes --tool=massif \
--massif-out-file=./qemu-vg-massiv.out \
./qemu-mtrace/ppc64-softmmu/qemu-system-ppc64 -nodefaults \
-chardev stdio,id=STDIO0,signal=off,mux=on \
-device spapr-vty,id=svty0,chardev=STDIO0,reg=0x71000100 \
-mon id=MON0,chardev=STDIO0,mode=readline -nographic -vga none -m 2G \
-smp 1 \
-kernel /home/aik/t/vml4120le \
-initrd /home/aik/t/le.cpio -snapshot \
-device pci-bridge,id=pci.1,bus=pci.0,addr=1.0,chassis_nr=1 \
-device pci-bridge,id=pci.2,bus=pci.0,addr=2.0,chassis_nr=2 \
-device pci-bridge,id=pci.3,bus=pci.0,addr=3.0,chassis_nr=3 \
-device pci-bridge,id=pci.4,bus=pci.0,addr=4.0,chassis_nr=4 \
-device pci-bridge,id=pci.5,bus=pci.0,addr=5.0,chassis_nr=5 \
-device pci-bridge,id=pci.6,bus=pci.0,addr=6.0,chassis_nr=6 \
-device pci-bridge,id=pci.7,bus=pci.0,addr=7.0,chassis_nr=7 \
-device pci-bridge,id=pci.8,bus=pci.1,addr=1.0,chassis_nr=8 \
-drive id=DRIVE0,if=none,file=img/1gb.qcow2,format=qcow2 \
-device virtio-blk-pci,id=vblk0,drive=DRIVE0,bus=pci.8,addr=1.0 \
-drive id=DRIVE1,if=none,file=img/1gb.qcow2,format=qcow2 \
-device virtio-blk-pci,id=vblk1,drive=DRIVE1,bus=pci.8,addr=2.0 \
-drive id=DRIVE2,if=none,file=img/1gb.qcow2,format=qcow2 \
-device virtio-blk-pci,id=vblk2,drive=DRIVE2,bus=pci.8,addr=3.0 \
-drive id=DRIVE3,if=none,file=img/1gb.qcow2,format=qcow2 \
-device virtio-blk-pci,id=vblk3,drive=DRIVE3,bus=pci.8,addr=4.0 \
-drive id=DRIVE4,if=none,file=img/1gb.qcow2,format=qcow2 \
-device virtio-blk-pci,id=vblk4,drive=DRIVE4,bus=pci.8,addr=5.0 \
-drive id=DRIVE5,if=none,file=img/1gb.qcow2,format=qcow2 \
-device virtio-blk-pci,id=vblk5,drive=DRIVE5,bus=pci.8,addr=6.0 \
-drive id=DRIVE6,if=none,file=img/1gb.qcow2,format=qcow2 \
-device virtio-blk-pci,id=vblk6,drive=DRIVE6,bus=pci.8,addr=7.0 \
-drive id=DRIVE7,if=none,file=img/1gb.qcow2,format=qcow2 \
-device virtio-blk-pci,id=vblk7,drive=DRIVE7,bus=pci.8,addr=8.0 \
-device pci-bridge,id=pci.9,bus=pci.1,addr=2.0,chassis_nr=9 \
-drive id=DRIVE8,if=none,file=img/1gb.qcow2,format=qcow2 \
-device virtio-blk-pci,id=vblk8,drive=DRIVE8,bus=pci.9,addr=1.0 \
-drive id=DRIVE9,if=none,file=img/1gb.qcow2,format=qcow2 \
-device virtio-blk-pci,id=vblk9,drive=DRIVE9,bus=pci.9,addr=2.0 \
-drive id=DRIVE10,if=none,file=img/1gb.qcow2,format=qcow2 \
-device virtio-blk-pci,id=vblk10,drive=DRIVE10,bus=pci.9,addr=3.0 \
-drive id=DRIVE11,if=none,file=img/1gb.qcow2,format=qcow2 \
-device virtio-blk-pci,id=vblk11,drive=DRIVE11,bus=pci.9,addr=4.0 \
-drive id=DRIVE12,if=none,file=img/1gb.qcow2,format=qcow2 \
-device virtio-blk-pci,id=vblk12,drive=DRIVE12,bus=pci.9,addr=5.0 \
-drive id=DRIVE13,if=none,file=img/1gb.qcow2,format=qcow2 \
-device virtio-blk-pci,id=vblk13,drive=DRIVE13,bus=pci.9,addr=6.0 \
-drive id=DRIVE14,if=none,file=img/1gb.qcow2,format=qcow2 \
-device virtio-blk-pci,id=vblk14,drive=DRIVE14,bus=pci.9,addr=7.0 \
-drive id=DRIVE15,if=none,file=img/1gb.qcow2,format=qcow2 \
-device virtio-blk-pci,id=vblk15,drive=DRIVE15,bus=pci.9,addr=8.0 \
-device pci-bridge,id=pci.10,bus=pci.1,addr=3.0,chassis_nr=10 \
-drive id=DRIVE16,if=none,file=img/1gb.qcow2,format=qcow2 \
-device virtio-blk-pci,id=vblk16,drive=DRIVE16,bus=pci.10,addr=1.0 \
-drive id=DRIVE17,if=none,file=img/1gb.qcow2,format=qcow2 \
-device virtio-blk-pci,id=vblk17,drive=DRIVE17,bus=pci.10,addr=2.0 \
-drive id=DRIVE18,if=none,file=img/1gb.qcow2,format=qcow2 \
-device virtio-blk-pci,id=vblk18,drive=DRIVE18,bus=pci.10,addr=3.0 \
-drive id=DRIVE19,if=none,file=img/1gb.qcow2,format=qcow2 \
-device virtio-blk-pci,id=vblk19,drive=DRIVE19,bus=pci.10,addr=4.0 \
-drive id=DRIVE20,if=none,file=img/1gb.qcow2,format=qcow2 \
-device virtio-blk-pci,id=vblk20,drive=DRIVE20,bus=pci.10,addr=5.0 \
-drive id=DRIVE21,if=none,file=img/1gb.qcow2,format=qcow2 \
-device virtio-blk-pci,id=vblk21,drive=DRIVE21,bus=pci.10,addr=6.0 \
-drive id=DRIVE22,if=none,file=img/1gb.qcow2,format=qcow2 \
-device virtio-blk-pci,id=vblk22,drive=DRIVE22,bus=pci.10,addr=7.0 \
-drive id=DRIVE23,if=none,file=img/1gb.qcow2,format=qcow2 \
-device virtio-blk-pci,id=vblk23,drive=DRIVE23,bus=pci.10,addr=8.0 \
-device pci-bridge,id=pci.11,bus=pci.1,addr=4.0,chassis_nr=11 \
-drive id=DRIVE24,if=none,file=img/1gb.qcow2,format=qcow2 \
-device virtio-blk-pci,id=vblk24,drive=DRIVE24,bus=pci.11,addr=1.0 \
-drive id=DRIVE25,if=none,file=img/1gb.qcow2,format=qcow2 \
-device virtio-blk-pci,id=vblk25,drive=DRIVE25,bus=pci.11,addr=2.0 \
-drive id=DRIVE26,if=none,file=img/1gb.qcow2,format=qcow2 \
-device virtio-blk-pci,id=vblk26,drive=DRIVE26,bus=pci.11,addr=3.0 \
-drive id=DRIVE27,if=none,file=img/1gb.qcow2,format=qcow2 \
-device virtio-blk-pci,id=vblk27,drive=DRIVE27,bus=pci.11,addr=4.0 \
-drive id=DRIVE28,if=none,file=img/1gb.qcow2,format=qcow2 \
-device virtio-blk-pci,id=vblk28,drive=DRIVE28,bus=pci.11,addr=5.0 \
-drive id=DRIVE29,if=none,file=img/1gb.qcow2,format=qcow2 \
-device virtio-blk-pci,id=vblk29,drive=DRIVE29,bus=pci.11,addr=6.0 \
-drive id=DRIVE30,if=none,file=img/1gb.qcow2,format=qcow2 \
-device virtio-blk-pci,id=vblk30,drive=DRIVE30,bus=pci.11,addr=7.0 \
-drive id=DRIVE31,if=none,file=img/1gb.qcow2,format=qcow2 \
-device virtio-blk-pci,id=vblk31,drive=DRIVE31,bus=pci.11,addr=8.0 \
-device pci-bridge,id=pci.12,bus=pci.1,addr=5.0,chassis_nr=12 \
-drive id=DRIVE32,if=none,file=img/1gb.qcow2,format=qcow2 \
-device virtio-blk-pci,id=vblk32,drive=DRIVE32,bus=pci.12,addr=1.0 \
-drive id=DRIVE33,if=none,file=img/1gb.qcow2,format=qcow2 \
-device virtio-blk-pci,id=vblk33,drive=DRIVE33,bus=pci.12,addr=2.0 \
-drive id=DRIVE34,if=none,file=img/1gb.qcow2,format=qcow2 \
-device virtio-blk-pci,id=vblk34,drive=DRIVE34,bus=pci.12,addr=3.0 \
-drive id=DRIVE35,if=none,file=img/1gb.qcow2,format=qcow2 \
-device virtio-blk-pci,id=vblk35,drive=DRIVE35,bus=pci.12,addr=4.0 \
-drive id=DRIVE36,if=none,file=img/1gb.qcow2,format=qcow2 \
-device virtio-blk-pci,id=vblk36,drive=DRIVE36,bus=pci.12,addr=5.0 \
-drive id=DRIVE37,if=none,file=img/1gb.qcow2,format=qcow2 \
-device virtio-blk-pci,id=vblk37,drive=DRIVE37,bus=pci.12,addr=6.0 \
-drive id=DRIVE38,if=none,file=img/1gb.qcow2,format=qcow2 \
-device virtio-blk-pci,id=vblk38,drive=DRIVE38,bus=pci.12,addr=7.0 \
-drive id=DRIVE39,if=none,file=img/1gb.qcow2,format=qcow2 \
-device virtio-blk-pci,id=vblk39,drive=DRIVE39,bus=pci.12,addr=8.0 \
-device pci-bridge,id=pci.13,bus=pci.1,addr=6.0,chassis_nr=13 \
-drive id=DRIVE40,if=none,file=img/1gb.qcow2,format=qcow2 \
-device virtio-blk-pci,id=vblk40,drive=DRIVE40,bus=pci.13,addr=1.0 \
-drive id=DRIVE41,if=none,file=img/1gb.qcow2,format=qcow2 \
-device virtio-blk-pci,id=vblk41,drive=DRIVE41,bus=pci.13,addr=2.0 \
-drive id=DRIVE42,if=none,file=img/1gb.qcow2,format=qcow2 \
-device virtio-blk-pci,id=vblk42,drive=DRIVE42,bus=pci.13,addr=3.0 \
-drive id=DRIVE43,if=none,file=img/1gb.qcow2,format=qcow2 \
-device virtio-blk-pci,id=vblk43,drive=DRIVE43,bus=pci.13,addr=4.0 \
-drive id=DRIVE44,if=none,file=img/1gb.qcow2,format=qcow2 \
-device virtio-blk-pci,id=vblk44,drive=DRIVE44,bus=pci.13,addr=5.0 \
-drive id=DRIVE45,if=none,file=img/1gb.qcow2,format=qcow2 \
-device virtio-blk-pci,id=vblk45,drive=DRIVE45,bus=pci.13,addr=6.0 \
-drive id=DRIVE46,if=none,file=img/1gb.qcow2,format=qcow2 \
-device virtio-blk-pci,id=vblk46,drive=DRIVE46,bus=pci.13,addr=7.0 \
-drive id=DRIVE47,if=none,file=img/1gb.qcow2,format=qcow2 \
-device virtio-blk-pci,id=vblk47,drive=DRIVE47,bus=pci.13,addr=8.0 \
-device pci-bridge,id=pci.14,bus=pci.1,addr=7.0,chassis_nr=14 \
-drive id=DRIVE48,if=none,file=img/1gb.qcow2,format=qcow2 \
-device virtio-blk-pci,id=vblk48,drive=DRIVE48,bus=pci.14,addr=1.0 \
-drive id=DRIVE49,if=none,file=img/1gb.qcow2,format=qcow2 \
-device virtio-blk-pci,id=vblk49,drive=DRIVE49,bus=pci.14,addr=2.0 \
-drive id=DRIVE50,if=none,file=img/1gb.qcow2,format=qcow2 \
-device virtio-blk-pci,id=vblk50,drive=DRIVE50,bus=pci.14,addr=3.0 \
-drive id=DRIVE51,if=none,file=img/1gb.qcow2,format=qcow2 \
-device virtio-blk-pci,id=vblk51,drive=DRIVE51,bus=pci.14,addr=4.0 \
-drive id=DRIVE52,if=none,file=img/1gb.qcow2,format=qcow2 \
-device virtio-blk-pci,id=vblk52,drive=DRIVE52,bus=pci.14,addr=5.0 \
-drive id=DRIVE53,if=none,file=img/1gb.qcow2,format=qcow2 \
-device virtio-blk-pci,id=vblk53,drive=DRIVE53,bus=pci.14,addr=6.0 \
-drive id=DRIVE54,if=none,file=img/1gb.qcow2,format=qcow2 \
-device virtio-blk-pci,id=vblk54,drive=DRIVE54,bus=pci.14,addr=7.0 \
-drive id=DRIVE55,if=none,file=img/1gb.qcow2,format=qcow2 \
-device virtio-blk-pci,id=vblk55,drive=DRIVE55,bus=pci.14,addr=8.0 \
-device pci-bridge,id=pci.15,bus=pci.2,addr=1.0,chassis_nr=15 \
-drive id=DRIVE56,if=none,file=img/1gb.qcow2,format=qcow2 \
-device virtio-blk-pci,id=vblk56,drive=DRIVE56,bus=pci.15,addr=1.0 \
-drive id=DRIVE57,if=none,file=img/1gb.qcow2,format=qcow2 \
-device virtio-blk-pci,id=vblk57,drive=DRIVE57,bus=pci.15,addr=2.0 \
-drive id=DRIVE58,if=none,file=img/1gb.qcow2,format=qcow2 \
-device virtio-blk-pci,id=vblk58,drive=DRIVE58,bus=pci.15,addr=3.0 \
-drive id=DRIVE59,if=none,file=img/1gb.qcow2,format=qcow2 \
-device virtio-blk-pci,id=vblk59,drive=DRIVE59,bus=pci.15,addr=4.0 \
-drive id=DRIVE60,if=none,file=img/1gb.qcow2,format=qcow2 \
-device virtio-blk-pci,id=vblk60,drive=DRIVE60,bus=pci.15,addr=5.0 \
-drive id=DRIVE61,if=none,file=img/1gb.qcow2,format=qcow2 \
-device virtio-blk-pci,id=vblk61,drive=DRIVE61,bus=pci.15,addr=6.0 \
-drive id=DRIVE62,if=none,file=img/1gb.qcow2,format=qcow2 \
-device virtio-blk-pci,id=vblk62,drive=DRIVE62,bus=pci.15,addr=7.0 \
-drive id=DRIVE63,if=none,file=img/1gb.qcow2,format=qcow2 \
-device virtio-blk-pci,id=vblk63,drive=DRIVE63,bus=pci.15,addr=8.0 \
-device pci-bridge,id=pci.16,bus=pci.2,addr=2.0,chassis_nr=16 \
-drive id=DRIVE64,if=none,file=img/1gb.qcow2,format=qcow2 \
-device virtio-blk-pci,id=vblk64,drive=DRIVE64,bus=pci.16,addr=1.0 \
-drive id=DRIVE65,if=none,file=img/1gb.qcow2,format=qcow2 \
-device virtio-blk-pci,id=vblk65,drive=DRIVE65,bus=pci.16,addr=2.0 \
-drive id=DRIVE66,if=none,file=img/1gb.qcow2,format=qcow2 \
-device virtio-blk-pci,id=vblk66,drive=DRIVE66,bus=pci.16,addr=3.0 \
-drive id=DRIVE67,if=none,file=img/1gb.qcow2,format=qcow2 \
-device virtio-blk-pci,id=vblk67,drive=DRIVE67,bus=pci.16,addr=4.0 \
-drive id=DRIVE68,if=none,file=img/1gb.qcow2,format=qcow2 \
-device virtio-blk-pci,id=vblk68,drive=DRIVE68,bus=pci.16,addr=5.0 \
-drive id=DRIVE69,if=none,file=img/1gb.qcow2,format=qcow2 \
-device virtio-blk-pci,id=vblk69,drive=DRIVE69,bus=pci.16,addr=6.0 \
-drive id=DRIVE70,if=none,file=img/1gb.qcow2,format=qcow2 \
-device virtio-blk-pci,id=vblk70,drive=DRIVE70,bus=pci.16,addr=7.0 \
-drive id=DRIVE71,if=none,file=img/1gb.qcow2,format=qcow2 \
-device virtio-blk-pci,id=vblk71,drive=DRIVE71,bus=pci.16,addr=8.0 \
-device pci-bridge,id=pci.17,bus=pci.2,addr=3.0,chassis_nr=17 \
-drive id=DRIVE72,if=none,file=img/1gb.qcow2,format=qcow2 \
-device virtio-blk-pci,id=vblk72,drive=DRIVE72,bus=pci.17,addr=1.0 \
-drive id=DRIVE73,if=none,file=img/1gb.qcow2,format=qcow2 \
-device virtio-blk-pci,id=vblk73,drive=DRIVE73,bus=pci.17,addr=2.0 \
-drive id=DRIVE74,if=none,file=img/1gb.qcow2,format=qcow2 \
-device virtio-blk-pci,id=vblk74,drive=DRIVE74,bus=pci.17,addr=3.0 \
-drive id=DRIVE75,if=none,file=img/1gb.qcow2,format=qcow2 \
-device virtio-blk-pci,id=vblk75,drive=DRIVE75,bus=pci.17,addr=4.0 \
-drive id=DRIVE76,if=none,file=img/1gb.qcow2,format=qcow2 \
-device virtio-blk-pci,id=vblk76,drive=DRIVE76,bus=pci.17,addr=5.0 \
-drive id=DRIVE77,if=none,file=img/1gb.qcow2,format=qcow2 \
-device virtio-blk-pci,id=vblk77,drive=DRIVE77,bus=pci.17,addr=6.0 \
-drive id=DRIVE78,if=none,file=img/1gb.qcow2,format=qcow2 \
-device virtio-blk-pci,id=vblk78,drive=DRIVE78,bus=pci.17,addr=7.0 \
-drive id=DRIVE79,if=none,file=img/1gb.qcow2,format=qcow2 \
-device virtio-blk-pci,id=vblk79,drive=DRIVE79,bus=pci.17,addr=8.0 \
-device pci-bridge,id=pci.18,bus=pci.2,addr=4.0,chassis_nr=18 \
-drive id=DRIVE80,if=none,file=img/1gb.qcow2,format=qcow2 \
-device virtio-blk-pci,id=vblk80,drive=DRIVE80,bus=pci.18,addr=1.0 \
-drive id=DRIVE81,if=none,file=img/1gb.qcow2,format=qcow2 \
-device virtio-blk-pci,id=vblk81,drive=DRIVE81,bus=pci.18,addr=2.0 \
-drive id=DRIVE82,if=none,file=img/1gb.qcow2,format=qcow2 \
-device virtio-blk-pci,id=vblk82,drive=DRIVE82,bus=pci.18,addr=3.0 \
-drive id=DRIVE83,if=none,file=img/1gb.qcow2,format=qcow2 \
-device virtio-blk-pci,id=vblk83,drive=DRIVE83,bus=pci.18,addr=4.0 \
-drive id=DRIVE84,if=none,file=img/1gb.qcow2,format=qcow2 \
-device virtio-blk-pci,id=vblk84,drive=DRIVE84,bus=pci.18,addr=5.0 \
-drive id=DRIVE85,if=none,file=img/1gb.qcow2,format=qcow2 \
-device virtio-blk-pci,id=vblk85,drive=DRIVE85,bus=pci.18,addr=6.0 \
-drive id=DRIVE86,if=none,file=img/1gb.qcow2,format=qcow2 \
-device virtio-blk-pci,id=vblk86,drive=DRIVE86,bus=pci.18,addr=7.0 \
-drive id=DRIVE87,if=none,file=img/1gb.qcow2,format=qcow2 \
-device virtio-blk-pci,id=vblk87,drive=DRIVE87,bus=pci.18,addr=8.0 \
-device pci-bridge,id=pci.19,bus=pci.2,addr=5.0,chassis_nr=19 \
-drive id=DRIVE88,if=none,file=img/1gb.qcow2,format=qcow2 \
-device virtio-blk-pci,id=vblk88,drive=DRIVE88,bus=pci.19,addr=1.0 \
-drive id=DRIVE89,if=none,file=img/1gb.qcow2,format=qcow2 \
-device virtio-blk-pci,id=vblk89,drive=DRIVE89,bus=pci.19,addr=2.0 \
-drive id=DRIVE90,if=none,file=img/1gb.qcow2,format=qcow2 \
-device virtio-blk-pci,id=vblk90,drive=DRIVE90,bus=pci.19,addr=3.0 \
-drive id=DRIVE91,if=none,file=img/1gb.qcow2,format=qcow2 \
-device virtio-blk-pci,id=vblk91,drive=DRIVE91,bus=pci.19,addr=4.0 \
-drive id=DRIVE92,if=none,file=img/1gb.qcow2,format=qcow2 \
-device virtio-blk-pci,id=vblk92,drive=DRIVE92,bus=pci.19,addr=5.0 \
-drive id=DRIVE93,if=none,file=img/1gb.qcow2,format=qcow2 \
-device virtio-blk-pci,id=vblk93,drive=DRIVE93,bus=pci.19,addr=6.0 \
-drive id=DRIVE94,if=none,file=img/1gb.qcow2,format=qcow2 \
-device virtio-blk-pci,id=vblk94,drive=DRIVE94,bus=pci.19,addr=7.0 \
-drive id=DRIVE95,if=none,file=img/1gb.qcow2,format=qcow2 \
-device virtio-blk-pci,id=vblk95,drive=DRIVE95,bus=pci.19,addr=8.0 \
-device pci-bridge,id=pci.20,bus=pci.2,addr=6.0,chassis_nr=20 \
-drive id=DRIVE96,if=none,file=img/1gb.qcow2,format=qcow2 \
-device virtio-blk-pci,id=vblk96,drive=DRIVE96,bus=pci.20,addr=1.0 \
-drive id=DRIVE97,if=none,file=img/1gb.qcow2,format=qcow2 \
-device virtio-blk-pci,id=vblk97,drive=DRIVE97,bus=pci.20,addr=2.0 \
-drive id=DRIVE98,if=none,file=img/1gb.qcow2,format=qcow2 \
-device virtio-blk-pci,id=vblk98,drive=DRIVE98,bus=pci.20,addr=3.0 \
-drive id=DRIVE99,if=none,file=img/1gb.qcow2,format=qcow2 \
-device virtio-blk-pci,id=vblk99,drive=DRIVE99,bus=pci.20,addr=4.0 \
-drive id=DRIVE100,if=none,file=img/1gb.qcow2,format=qcow2 \
-device virtio-blk-pci,id=vblk100,drive=DRIVE100,bus=pci.20,addr=5.0 \
-drive id=DRIVE101,if=none,file=img/1gb.qcow2,format=qcow2 \
-device virtio-blk-pci,id=vblk101,drive=DRIVE101,bus=pci.20,addr=6.0 \
-drive id=DRIVE102,if=none,file=img/1gb.qcow2,format=qcow2 \
-device virtio-blk-pci,id=vblk102,drive=DRIVE102,bus=pci.20,addr=7.0 \
-drive id=DRIVE103,if=none,file=img/1gb.qcow2,format=qcow2 \
-device virtio-blk-pci,id=vblk103,drive=DRIVE103,bus=pci.20,addr=8.0 \
-device pci-bridge,id=pci.21,bus=pci.2,addr=7.0,chassis_nr=21 \
-drive id=DRIVE104,if=none,file=img/1gb.qcow2,format=qcow2 \
-device virtio-blk-pci,id=vblk104,drive=DRIVE104,bus=pci.21,addr=1.0 \
-drive id=DRIVE105,if=none,file=img/1gb.qcow2,format=qcow2 \
-device virtio-blk-pci,id=vblk105,drive=DRIVE105,bus=pci.21,addr=2.0 \
-drive id=DRIVE106,if=none,file=img/1gb.qcow2,format=qcow2 \
-device virtio-blk-pci,id=vblk106,drive=DRIVE106,bus=pci.21,addr=3.0 \
-drive id=DRIVE107,if=none,file=img/1gb.qcow2,format=qcow2 \
-device virtio-blk-pci,id=vblk107,drive=DRIVE107,bus=pci.21,addr=4.0 \
-drive id=DRIVE108,if=none,file=img/1gb.qcow2,format=qcow2 \
-device virtio-blk-pci,id=vblk108,drive=DRIVE108,bus=pci.21,addr=5.0 \
-drive id=DRIVE109,if=none,file=img/1gb.qcow2,format=qcow2 \
-device virtio-blk-pci,id=vblk109,drive=DRIVE109,bus=pci.21,addr=6.0 \
-drive id=DRIVE110,if=none,file=img/1gb.qcow2,format=qcow2 \
-device virtio-blk-pci,id=vblk110,drive=DRIVE110,bus=pci.21,addr=7.0 \
-drive id=DRIVE111,if=none,file=img/1gb.qcow2,format=qcow2 \
-device virtio-blk-pci,id=vblk111,drive=DRIVE111,bus=pci.21,addr=8.0 \
-device pci-bridge,id=pci.22,bus=pci.3,addr=1.0,chassis_nr=22 \
-drive id=DRIVE112,if=none,file=img/1gb.qcow2,format=qcow2 \
-device virtio-blk-pci,id=vblk112,drive=DRIVE112,bus=pci.22,addr=1.0 \
-drive id=DRIVE113,if=none,file=img/1gb.qcow2,format=qcow2 \
-device virtio-blk-pci,id=vblk113,drive=DRIVE113,bus=pci.22,addr=2.0 \
-drive id=DRIVE114,if=none,file=img/1gb.qcow2,format=qcow2 \
-device virtio-blk-pci,id=vblk114,drive=DRIVE114,bus=pci.22,addr=3.0 \
-drive id=DRIVE115,if=none,file=img/1gb.qcow2,format=qcow2 \
-device virtio-blk-pci,id=vblk115,drive=DRIVE115,bus=pci.22,addr=4.0 \
-drive id=DRIVE116,if=none,file=img/1gb.qcow2,format=qcow2 \
-device virtio-blk-pci,id=vblk116,drive=DRIVE116,bus=pci.22,addr=5.0 \
-drive id=DRIVE117,if=none,file=img/1gb.qcow2,format=qcow2 \
-device virtio-blk-pci,id=vblk117,drive=DRIVE117,bus=pci.22,addr=6.0 \
-drive id=DRIVE118,if=none,file=img/1gb.qcow2,format=qcow2 \
-device virtio-blk-pci,id=vblk118,drive=DRIVE118,bus=pci.22,addr=7.0 \
-drive id=DRIVE119,if=none,file=img/1gb.qcow2,format=qcow2 \
-device virtio-blk-pci,id=vblk119,drive=DRIVE119,bus=pci.22,addr=8.0 \
-device pci-bridge,id=pci.23,bus=pci.3,addr=2.0,chassis_nr=23 \
-drive id=DRIVE120,if=none,file=img/1gb.qcow2,format=qcow2 \
-device virtio-blk-pci,id=vblk120,drive=DRIVE120,bus=pci.23,addr=1.0 \
-drive id=DRIVE121,if=none,file=img/1gb.qcow2,format=qcow2 \
-device virtio-blk-pci,id=vblk121,drive=DRIVE121,bus=pci.23,addr=2.0 \
-drive id=DRIVE122,if=none,file=img/1gb.qcow2,format=qcow2 \
-device virtio-blk-pci,id=vblk122,drive=DRIVE122,bus=pci.23,addr=3.0 \
-drive id=DRIVE123,if=none,file=img/1gb.qcow2,format=qcow2 \
-device virtio-blk-pci,id=vblk123,drive=DRIVE123,bus=pci.23,addr=4.0 \
-drive id=DRIVE124,if=none,file=img/1gb.qcow2,format=qcow2 \
-device virtio-blk-pci,id=vblk124,drive=DRIVE124,bus=pci.23,addr=5.0 \
-drive id=DRIVE125,if=none,file=img/1gb.qcow2,format=qcow2 \
-device virtio-blk-pci,id=vblk125,drive=DRIVE125,bus=pci.23,addr=6.0 \
-drive id=DRIVE126,if=none,file=img/1gb.qcow2,format=qcow2 \
-device virtio-blk-pci,id=vblk126,drive=DRIVE126,bus=pci.23,addr=7.0 \
-drive id=DRIVE127,if=none,file=img/1gb.qcow2,format=qcow2 \
-device virtio-blk-pci,id=vblk127,drive=DRIVE127,bus=pci.23,addr=8.0 \
-device pci-bridge,id=pci.24,bus=pci.3,addr=3.0,chassis_nr=24 \
-drive id=DRIVE128,if=none,file=img/1gb.qcow2,format=qcow2 \
-device virtio-blk-pci,id=vblk128,drive=DRIVE128,bus=pci.24,addr=1.0 \
-drive id=DRIVE129,if=none,file=img/1gb.qcow2,format=qcow2 \
-device virtio-blk-pci,id=vblk129,drive=DRIVE129,bus=pci.24,addr=2.0 \
-drive id=DRIVE130,if=none,file=img/1gb.qcow2,format=qcow2 \
-device virtio-blk-pci,id=vblk130,drive=DRIVE130,bus=pci.24,addr=3.0 \
-drive id=DRIVE131,if=none,file=img/1gb.qcow2,format=qcow2 \
-device virtio-blk-pci,id=vblk131,drive=DRIVE131,bus=pci.24,addr=4.0 \
-drive id=DRIVE132,if=none,file=img/1gb.qcow2,format=qcow2 \
-device virtio-blk-pci,id=vblk132,drive=DRIVE132,bus=pci.24,addr=5.0 \
-drive id=DRIVE133,if=none,file=img/1gb.qcow2,format=qcow2 \
-device virtio-blk-pci,id=vblk133,drive=DRIVE133,bus=pci.24,addr=6.0 \
-drive id=DRIVE134,if=none,file=img/1gb.qcow2,format=qcow2 \
-device virtio-blk-pci,id=vblk134,drive=DRIVE134,bus=pci.24,addr=7.0 \
-drive id=DRIVE135,if=none,file=img/1gb.qcow2,format=qcow2 \
-device virtio-blk-pci,id=vblk135,drive=DRIVE135,bus=pci.24,addr=8.0 \
-device pci-bridge,id=pci.25,bus=pci.3,addr=4.0,chassis_nr=25 \
-drive id=DRIVE136,if=none,file=img/1gb.qcow2,format=qcow2 \
-device virtio-blk-pci,id=vblk136,drive=DRIVE136,bus=pci.25,addr=1.0 \
-drive id=DRIVE137,if=none,file=img/1gb.qcow2,format=qcow2 \
-device virtio-blk-pci,id=vblk137,drive=DRIVE137,bus=pci.25,addr=2.0 \
-drive id=DRIVE138,if=none,file=img/1gb.qcow2,format=qcow2 \
-device virtio-blk-pci,id=vblk138,drive=DRIVE138,bus=pci.25,addr=3.0 \
-drive id=DRIVE139,if=none,file=img/1gb.qcow2,format=qcow2 \
-device virtio-blk-pci,id=vblk139,drive=DRIVE139,bus=pci.25,addr=4.0 \
-drive id=DRIVE140,if=none,file=img/1gb.qcow2,format=qcow2 \
-device virtio-blk-pci,id=vblk140,drive=DRIVE140,bus=pci.25,addr=5.0 \
-drive id=DRIVE141,if=none,file=img/1gb.qcow2,format=qcow2 \
-device virtio-blk-pci,id=vblk141,drive=DRIVE141,bus=pci.25,addr=6.0 \
-drive id=DRIVE142,if=none,file=img/1gb.qcow2,format=qcow2 \
-device virtio-blk-pci,id=vblk142,drive=DRIVE142,bus=pci.25,addr=7.0 \
-drive id=DRIVE143,if=none,file=img/1gb.qcow2,format=qcow2 \
-device virtio-blk-pci,id=vblk143,drive=DRIVE143,bus=pci.25,addr=8.0 \
-device pci-bridge,id=pci.26,bus=pci.3,addr=5.0,chassis_nr=26 \
-drive id=DRIVE144,if=none,file=img/1gb.qcow2,format=qcow2 \
-device virtio-blk-pci,id=vblk144,drive=DRIVE144,bus=pci.26,addr=1.0 \
-drive id=DRIVE145,if=none,file=img/1gb.qcow2,format=qcow2 \
-device virtio-blk-pci,id=vblk145,drive=DRIVE145,bus=pci.26,addr=2.0 \
-drive id=DRIVE146,if=none,file=img/1gb.qcow2,format=qcow2 \
-device virtio-blk-pci,id=vblk146,drive=DRIVE146,bus=pci.26,addr=3.0 \
-drive id=DRIVE147,if=none,file=img/1gb.qcow2,format=qcow2 \
-device virtio-blk-pci,id=vblk147,drive=DRIVE147,bus=pci.26,addr=4.0 \
-drive id=DRIVE148,if=none,file=img/1gb.qcow2,format=qcow2 \
-device virtio-blk-pci,id=vblk148,drive=DRIVE148,bus=pci.26,addr=5.0 \
-drive id=DRIVE149,if=none,file=img/1gb.qcow2,format=qcow2 \
-device virtio-blk-pci,id=vblk149,drive=DRIVE149,bus=pci.26,addr=6.0 -S \
-machine pseries -bios ./slof.bin \
-trace events=qemu_trace_events \
-L /home/aik/t/qemu-ppc64-bios/




-- 
Alexey
