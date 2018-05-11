Received: from eggs.gnu.org ([2001:4830:134:3::10]:53193)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lovemrd@gmail.com>) id 1fH2La-000381-FC
	for qemu-devel@nongnu.org; Fri, 11 May 2018 03:20:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lovemrd@gmail.com>) id 1fH2LY-00015y-2U
	for qemu-devel@nongnu.org; Fri, 11 May 2018 03:20:10 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:46099)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <lovemrd@gmail.com>) id 1fH2LX-00015k-Si
	for qemu-devel@nongnu.org; Fri, 11 May 2018 03:20:08 -0400
Received: by mail-qt0-x243.google.com with SMTP id m16-v6so5865431qtg.13
	for <qemu-devel@nongnu.org>; Fri, 11 May 2018 00:20:07 -0700 (PDT)
MIME-Version: 1.0
From: Zhu Yijun <lovemrd@gmail.com>
Date: Fri, 11 May 2018 15:20:05 +0800
Message-ID: <CAF_Z_jqQDvdvPoQkpvrgmtJSaJxaFbATpc0toJBRjAnO9gHupA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] ping latency issue on passthrough guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kvm@vger.kernel.org, Alex Williamson <alex.williamson@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org

Hi all,

  I booted two sr-iov guests using KVM-VFIO and pinged each other with
no-load one night. I found that most of the latency was little than 0.1ms,
but several icmp_seq greater than 10ms, even up to 1000ms;

  root@test-ping01:~# grep "time=[0-9][0-9]" outputfile
Mon May  7 23:05:12 201864 bytes from 192.168.0.200: icmp_seq=16703 ttl=64
time=123 ms
Mon May  7 23:26:28 201864 bytes from 192.168.0.200: icmp_seq=17979 ttl=64
time=123 ms
Mon May  7 23:45:08 201864 bytes from 192.168.0.200: icmp_seq=19099 ttl=64
time=127 ms
Tue May  8 00:19:21 201864 bytes from 192.168.0.200: icmp_seq=21152 ttl=64
time=132 ms
Tue May  8 00:20:16 201864 bytes from 192.168.0.200: icmp_seq=21207 ttl=64
time=131 ms
Tue May  8 00:20:58 201864 bytes from 192.168.0.200: icmp_seq=21249 ttl=64
time=131 ms
Tue May  8 00:24:36 201864 bytes from 192.168.0.200: icmp_seq=21467 ttl=64
time=131 ms
Tue May  8 03:17:53 201864 bytes from 192.168.0.200: icmp_seq=31864 ttl=64
time=102 ms
Tue May  8 04:51:35 201864 bytes from 192.168.0.200: icmp_seq=37486 ttl=64
time=134 ms
Tue May  8 04:51:39 201864 bytes from 192.168.0.200: icmp_seq=37490 ttl=64
time=134 ms
Tue May  8 04:55:31 201864 bytes from 192.168.0.200: icmp_seq=37722 ttl=64
time=138 ms
Tue May  8 04:59:23 201864 bytes from 192.168.0.200: icmp_seq=37954 ttl=64
time=138 ms
Tue May  8 05:15:05 201864 bytes from 192.168.0.200: icmp_seq=38896 ttl=64
time=76.4 ms
Tue May  8 05:19:05 201864 bytes from 192.168.0.200: icmp_seq=39136 ttl=64
time=146 ms
Tue May  8 07:07:40 201864 bytes from 192.168.0.200: icmp_seq=45651 ttl=64
time=10.7 ms
Tue May  8 07:12:42 201864 bytes from 192.168.0.200: icmp_seq=45953 ttl=64
time=30.7 ms
Tue May  8 07:17:40 201864 bytes from 192.168.0.200: icmp_seq=46251 ttl=64
time=166 ms
Tue May  8 08:03:33 201864 bytes from 192.168.0.200: icmp_seq=49004 ttl=64
time=14.6 ms
Tue May  8 08:13:34 201864 bytes from 192.168.0.200: icmp_seq=49605 ttl=64
time=174 ms
Tue May  8 08:13:36 201864 bytes from 192.168.0.200: icmp_seq=49607 ttl=64
time=174 ms
Tue May  8 08:42:38 201864 bytes from 192.168.0.200: icmp_seq=51349 ttl=64
time=84.0 ms
Tue May  8 08:51:50 201864 bytes from 192.168.0.200: icmp_seq=51901 ttl=64
time=92.0 ms
Tue May  8 09:34:06 201864 bytes from 192.168.0.200: icmp_seq=54437 ttl=64
time=283 ms

   VF used by these two guest from same port(eth0) of intel X710 Ethernet
controller. By contrast, I selected another two VFs and set them to
separate network namespace, this issue did not exits, all the latency
litter than 0.2ms.

   Advised by other guys, I disabled the BIOS C-State, set cpu power to
"performance", add kernel parameter "idle=poll, pcie_aspm=off", but it
makes no sense.

   I think it may be not the hardware issue, but may relate to KVM
hypervisor or guest kernel. As a result, I reported here, any advice and
suggestions will be greatly appreciated.

   The test enviroment as below:

   CPU model: Intel(R) Xeon(R) CPU E5-2680 v4 @ 2.40GHz
   HostOS: debian_9.3, kernel_version: 4.9.0-3
   QEMU 2.8.1
   libvirt 2.4.0
   NIC: intel X710
   GuestOS: debian_9.1
   xml:
   <domain type='kvm'>
  <name>ping_test01</name>
  <uuid>98132486-7f49-45bf-a6d7-6ceaf71ff4be</uuid>
  <maxMemory slots='64' unit='KiB'>134217728</maxMemory>
  <memory unit='KiB'>4194304</memory>
  <currentMemory unit='KiB'>4194304</currentMemory>
  <blkiotune>
    <device>
      <path>/dev/sdb</path>
      <read_iops_sec>1000</read_iops_sec>
      <write_iops_sec>1000</write_iops_sec>
      <read_bytes_sec>104857600</read_bytes_sec>
      <write_bytes_sec>104857600</write_bytes_sec>
    </device>
  </blkiotune>
  <vcpu placement='static' cpuset='5-31,33-55' current='2'>64</vcpu>
  <cputune>
    <vcpupin vcpu='0' cpuset='9'/>
    <vcpupin vcpu='1' cpuset='37'/>
  </cputune>
  <resource>
    <partition>/machine</partition>
  </resource>
  <sysinfo type='smbios'>
    <system>
      <entry name='manufacturer'>OpenStack Foundation</entry>
      <entry name='product'>OpenStack Nova</entry>
      <entry name='version'>2013.2.2</entry>
    </system>
  </sysinfo>
  <os>
    <type arch='x86_64' machine='pc-i440fx-2.8'>hvm</type>
    <boot dev='hd'/>
    <smbios mode='sysinfo'/>
  </os>
  <features>
    <acpi/>
    <apic/>
  </features>
  <cpu mode='custom' match='exact'>
    <model fallback='forbid'>Broadwell</model>
    <vendor>Intel</vendor>
    <feature policy='require' name='vme'/>
    <feature policy='require' name='ds'/>
    <feature policy='require' name='acpi'/>
    <feature policy='require' name='ss'/>
    <feature policy='require' name='ht'/>
    <feature policy='require' name='tm'/>
    <feature policy='require' name='pbe'/>
    <feature policy='require' name='dtes64'/>
    <feature policy='require' name='ds_cpl'/>
    <feature policy='require' name='vmx'/>
    <feature policy='require' name='smx'/>
    <feature policy='require' name='est'/>
    <feature policy='require' name='tm2'/>
    <feature policy='require' name='xtpr'/>
    <feature policy='require' name='pdcm'/>
    <feature policy='require' name='dca'/>
    <feature policy='require' name='osxsave'/>
    <feature policy='require' name='f16c'/>
    <feature policy='require' name='rdrand'/>
    <feature policy='require' name='arat'/>
    <feature policy='require' name='tsc_adjust'/>
    <feature policy='require' name='xsaveopt'/>
    <feature policy='require' name='pdpe1gb'/>
    <feature policy='require' name='abm'/>
    <numa>
      <cell id='0' cpus='0-63' memory='4194304' unit='KiB'/>
    </numa>
  </cpu>
  <clock offset='utc'>
    <timer name='pit' tickpolicy='delay'/>
    <timer name='rtc' tickpolicy='catchup'/>
  </clock>
  <on_poweroff>destroy</on_poweroff>
  <on_reboot>restart</on_reboot>
  <on_crash>destroy</on_crash>
  <devices>
    <emulator>/usr/bin/kvm</emulator>
    <disk type='file' device='disk'>
      <driver name='qemu' type='raw' cache='none'/>
      <source file='/images/debian_8.6_pub_dhcp_sr_i4_0428155812.dsk'/>
      <target dev='vda' bus='virtio'/>
      <address type='pci' domain='0x0000' bus='0x00' slot='0x04'
function='0x0'/>
    </disk>
    <controller type='usb' index='0' model='piix3-uhci'>
      <address type='pci' domain='0x0000' bus='0x00' slot='0x01'
function='0x2'/>
    </controller>
    <controller type='pci' index='0' model='pci-root'/>
    <controller type='virtio-serial' index='0'>
      <address type='pci' domain='0x0000' bus='0x00' slot='0x03'
function='0x0'/>
    </controller>
    <interface type='hostdev' managed='yes'>
      <mac address='52:54:00:0f:3b:b3'/>
      <driver name='vfio'/>
      <source>
        <address type='pci' domain='0x0000' bus='0x06' slot='0x03'
function='0x4'/>
      </source>
      <address type='pci' domain='0x0000' bus='0x00' slot='0x05'
function='0x0'/>
    </interface>
    <serial type='file'>
      <source path='/tmp/vm_console.log'/>
      <target port='0'/>
    </serial>
    <serial type='pty'>
      <target port='1'/>
    </serial>
    <console type='file'>
      <source path='/tmp/zyj_console.log'/>
      <target type='serial' port='0'/>
    </console>
    <input type='tablet' bus='usb'>
      <address type='usb' bus='0' port='1'/>
    </input>
    <input type='mouse' bus='ps2'/>
    <input type='keyboard' bus='ps2'/>
    <graphics type='vnc' port='-1' autoport='yes' listen='10.194.8.178'
keymap='en-us'>
      <listen type='address' address='10.194.8.178'/>
    </graphics>
    <video>
      <model type='cirrus' vram='16384' heads='1' primary='yes'/>
      <address type='pci' domain='0x0000' bus='0x00' slot='0x02'
function='0x0'/>
    </video>
    <memballoon model='virtio'>
      <address type='pci' domain='0x0000' bus='0x00' slot='0x06'
function='0x0'/>
    </memballoon>
  </devices>
  <seclabel type='none' model='none'/>
  <seclabel type='dynamic' model='dac' relabel='yes'/>
</domain>


  Thanks!

Zhu Yijun
