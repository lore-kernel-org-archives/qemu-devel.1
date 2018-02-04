Received: from eggs.gnu.org ([2001:4830:134:3::10]:43818)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <geoff@hostfission.com>) id 1eiEdQ-0000Vb-CI
	for qemu-devel@nongnu.org; Sun, 04 Feb 2018 02:22:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <geoff@hostfission.com>) id 1eiEdM-0007QS-U1
	for qemu-devel@nongnu.org; Sun, 04 Feb 2018 02:22:44 -0500
Received: from mail1.hostfission.com ([139.99.139.48]:50160)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <geoff@hostfission.com>) id 1eiEdM-0007Q3-9h
	for qemu-devel@nongnu.org; Sun, 04 Feb 2018 02:22:40 -0500
Received: from www1.hostfission.com (www1.hostfission.com [139.99.139.52])
	by mail1.hostfission.com (Postfix) with ESMTP id 98C6043CFB
	for <qemu-devel@nongnu.org>; Sun,  4 Feb 2018 18:22:35 +1100 (AEDT)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Sun, 04 Feb 2018 18:22:35 +1100
From: geoff@hostfission.com
Message-ID: <0e5059023b368ddc411a8da9aeab2af4@hostfission.com>
Subject: [Qemu-devel] Linux Guest Memory Performance
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hi All,

I am having some very strange issues with Qemu and memory copy 
performance. It seems that when performing buffer -> buffer copies of 
8MB or lower the performance is horrid.

Test program:

#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <stdint.h>

static inline uint64_t nanotime()
{
   struct timespec time;
   clock_gettime(CLOCK_MONOTONIC_RAW, &time);
   return ((uint64_t)time.tv_sec * 1e9) + time.tv_nsec;
}

int main(int argc, char * argv[])
{
   const int s = atoi(argv[1]);
   int size = s * 1024 * 1024;
   char * buffer1 = malloc(size);
   char * buffer2 = malloc(size);

   uint64_t t = nanotime();
   for(int i = 0; i < 1000; ++i)
     memcpy(buffer1, buffer2, size);
   printf("%2u MB = %f ms\n", s, ((float)(nanotime() - t) / 1000.0f)
       / 1000000.0f);

   free(buffer1);
   free(buffer2);
   return 0;
}

Compiled with: gcc main.c -O3

Native Output:

#  for I in `seq 1 32`; do ./a.out $I; done
  1 MB = 0.026123 ms
  2 MB = 0.048406 ms
  3 MB = 0.073877 ms
  4 MB = 0.096974 ms
  5 MB = 0.115063 ms
  6 MB = 0.139025 ms
  7 MB = 0.163888 ms
  8 MB = 0.187360 ms
  9 MB = 0.203941 ms
10 MB = 0.227855 ms
11 MB = 0.251903 ms
12 MB = 0.279699 ms
13 MB = 0.296424 ms
14 MB = 0.315042 ms
15 MB = 0.340979 ms
16 MB = 0.358750 ms
17 MB = 0.382865 ms
18 MB = 0.403458 ms
19 MB = 0.426864 ms
20 MB = 0.448165 ms
21 MB = 0.473857 ms
22 MB = 0.493515 ms
23 MB = 0.520299 ms
24 MB = 0.538550 ms
25 MB = 0.566735 ms
26 MB = 0.588072 ms
27 MB = 0.612500 ms
28 MB = 0.633682 ms
29 MB = 0.659352 ms
30 MB = 0.690467 ms
31 MB = 0.698611 ms
32 MB = 0.721284 ms

Guest Output:

# for I in `seq 1 32`; do ./a.out $I; done
  1 MB = 0.026120 ms
  2 MB = 0.049053 ms
  3 MB = 0.081695 ms
  4 MB = 0.126873 ms
  5 MB = 0.161380 ms
  6 MB = 0.316972 ms
  7 MB = 0.492851 ms
  8 MB = 0.673696 ms
  9 MB = 0.221208 ms
10 MB = 0.256582 ms
11 MB = 0.276354 ms
12 MB = 0.316020 ms
13 MB = 0.327643 ms
14 MB = 0.363536 ms
15 MB = 0.382575 ms
16 MB = 0.401538 ms
17 MB = 0.436602 ms
18 MB = 0.473452 ms
19 MB = 0.491850 ms
20 MB = 0.527252 ms
21 MB = 0.546229 ms
22 MB = 0.561816 ms
23 MB = 0.582428 ms
24 MB = 0.614430 ms
25 MB = 0.660698 ms
26 MB = 0.670087 ms
27 MB = 0.688908 ms
28 MB = 0.714887 ms
29 MB = 0.746829 ms
30 MB = 0.763404 ms
31 MB = 0.780527 ms
32 MB = 0.821888 ms

Note that leading up to 8MB the copy is getting slower, but once the 
copy exceeds 8MB the copy is 3x faster.
Does anyone have any insight as to why this might be?

I am running master @ 11ed801d3df3c6e46b2f1f97dcfbf4ca3a2a2f4f
Host: AMD Thread Ripper 1950x

Guest launch parameters:

/usr/local/bin/qemu-system-x86_64 \
   -nographic \
   -runas geoff \
   -monitor stdio \
   -name guest=Aeryn,debug-threads=on \
   -machine q35,accel=kvm,usb=off,vmport=off,dump-guest-core=off \
   -cpu 
host,hv_time,hv_relaxed,hv_vapic,hv_vendor_id=lakeuv283713,kvm=off \
   -drive 
file=$DIR/ovmf/OVMF_CODE-pure-efi.fd,if=pflash,format=raw,unit=0,readonly=on 
\
   -drive file=$DIR/vars.fd,if=pflash,format=raw,unit=1 \
   -m 8192 \
   -mem-prealloc \
   -mem-path /dev/hugepages/aeryn \
   -realtime mlock=off \
   -smp 32,sockets=1,cores=16,threads=2 \
   -no-user-config \
   -nodefaults \
   -balloon none \
   \
   -global ICH9-LPC.disable_s3=1 \
   -global ICH9-LPC.disable_s4=1 \
   \
   -rtc base=localtime,driftfix=slew \
   -global kvm-pit.lost_tick_policy=discard \
   -no-hpet \
   \
   -boot strict=on \
   \
   -object iothread,id=iothread1 \
   -device virtio-scsi-pci,id=scsi1,iothread=iothread1 \
   -drive  if=none,id=hd0,file=/dev/moya/aeryn-efi,format=raw,aio=threads 
\
   -device scsi-hd,bus=scsi1.0,drive=hd0,bootindex=1 \
   -drive  
if=none,id=hd1,file=/dev/moya/aeryn-rootfs,format=raw,aio=threads \
   -device scsi-hd,bus=scsi1.0,drive=hd1 \
   \
   -netdev 
tap,script=/home/geoff/VM/bin/ovs-ifup,downscript=/home/geoff/VM/bin/ovs-ifdown,ifname=aeryn.10,id=hostnet0 
\
   -device 
virtio-net-pci,netdev=hostnet0,id=net0,mac=52:54:00:06:12:34,bus=pcie.0 
\
   \
   -device intel-hda,id=sound0,bus=pcie.0 \
   -device hda-duplex,id=sound0-codec0,bus=sound0.0,cad=0 \
   \
   -device 
vfio-pci,host=0d:00.0,id=hostdev1,bus=pcie.0,addr=0x09,multifunction=on 
\
   -device vfio-pci,host=0d:00.1,id=hostdev2,bus=pcie.0,addr=0x09.1' \
   \
   -device ivshmem-plain,memdev=ivshmem \
   -object 
memory-backend-file,id=ivshmem,share=on,mem-path=/dev/shm/looking-glass,size=128M 
\
   \
   -msg timestamp=on \
   \
   -object 
input-linux,id=mou1,evdev=/dev/input/by-id/usb-Razer_Razer_DeathAdder_2013-event-mouse 
\
   -object 
input-linux,id=mou2,evdev=/dev/input/by-id/usb-Razer_Razer_DeathAdder_2013-if01-event-kbd 
\
   -object 
input-linux,id=mou3,evdev=/dev/input/by-id/usb-Razer_Razer_DeathAdder_2013-if02-event-kbd 
\
   -object 
input-linux,id=kbd1,evdev=/dev/input/by-id/usb-04d9_daskeyboard-event-kbd,grab_all=on,repeat=on 
\
   -object 
input-linux,id=kbd2,evdev=/dev/input/by-id/usb-04d9_daskeyboard-event-if01


Thanks in advance.
