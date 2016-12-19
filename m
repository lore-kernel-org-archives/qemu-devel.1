Received: from eggs.gnu.org ([2001:4830:134:3::10]:32811)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <holger@fam-schranz.de>) id 1cIttJ-0003lA-VD
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 04:05:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <holger@fam-schranz.de>) id 1cIttF-0005O9-UR
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 04:05:53 -0500
Received: from smtp3.goneo.de ([85.220.129.37]:59884)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <holger@fam-schranz.de>)
	id 1cIttF-0005NB-Kk
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 04:05:49 -0500
From: Holger Schranz <holger@fam-schranz.de>
Message-ID: <c532ac07-fd54-eedb-b3f0-548aeacf0a04@fam-schranz.de>
Date: Mon, 19 Dec 2016 10:05:04 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] Strange/wrong behavior with iSCSI Tape devices in QEMU
 2.8.0-rc4
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mueller-ralf@t-online.de

# Strange/wrong behavior in QEMU 2.8.0-rc4

After update from QEMU 2.6.2 to 2.8.0-rc4 the tape devices
and the corresponding medium changer are no longer available
in the VM quest system.

The tape devices and the media changer are declared in the
xml-file for libvirt. Both, tape drives and medium changer
are avalilable via iSCSI.

In a first rough investigation the login in iSCSI runs well
but in QEMU, it seems the devices doesn't reported to the VM-Quest.

------------------

Best regards

Holger

=====================================================================

XML-Declration:

.
.
.

<!-- SCSI 2 -->
     <controller type='scsi' model='virtio-scsi' index='1'>
       <alias name='scsi1'/>
     </controller>

<!-- 2 x LTO5 -->
     <hostdev mode='subsystem' type='scsi' managed='no' rawio='yes'>
       <source protocol='iscsi' 
name='iqn.2008-09.net.fsc:server.LT260_61003/4'>
       <host name='etcsvms2.abg.fsc.net' port='3260'/>
       </source>
       <address type='drive' controller='1' bus='0' target='2' unit='1'/>
     </hostdev>

     <hostdev mode='subsystem' type='scsi' managed='no' rawio='yes'>
       <source protocol='iscsi' 
name='iqn.2008-09.net.fsc:server.LT260_61003/5'>
       <host name='etcsvms2.abg.fsc.net' port='3260'/>
       </source>
       <address type='drive' controller='1' bus='0' target='2' unit='2'/>
     </hostdev>

<!-- Virtual media changer Fujitsu LT260 -->
     <hostdev mode='subsystem' type='scsi' managed='no' rawio='yes'>
       <source protocol='iscsi' 
name='iqn.2008-09.net.fsc:server.LT260_61003/6'>
       <host name='etcsvms2.abg.fsc.net' port='3260'/>
       </source>
       <address type='drive' controller='1' bus='0' target='2' unit='3'/>
     </hostdev>

<!-- 2 x LTO6 (via PLP(LAN-attached library)) -->
     <hostdev mode='subsystem' type='scsi' managed='no' rawio='yes'>
       <source protocol='iscsi' 
name='iqn.2008-09.net.fsc:server.LT60_61005/3'>
       <host name='etcsvms2.abg.fsc.net' port='3260'/>
       </source>
       <address type='drive' controller='1' bus='0' target='2' unit='4'/>
     </hostdev>

     <hostdev mode='subsystem' type='scsi' managed='no' rawio='yes'>
       <source protocol='iscsi' 
name='iqn.2008-09.net.fsc:server.LT60_61005/4'>
       <host name='etcsvms2.abg.fsc.net' port='3260'/>
       </source>
       <address type='drive' controller='1' bus='0' target='2' unit='5'/>
     </hostdev>
.
.
.

===============================================================================

correct behavior/Result inside the VM-Quest together with QEMU/KVM 2.6.2 
/ 2.7.0
--
(VCSTCS82:A)IUP1:~ # lsscsi -g
[0:2:0:0]    disk    FTS      PRAID EP420i     4.25  /dev/sda /dev/sg0
[3:0:0:0]    cd/dvd  QEMU     QEMU DVD-ROM     2.5+  /dev/sr0 /dev/sg1
[8:0:2:1]    tape    HP       Ultrium 5-SCSI   0001  /dev/st3 /dev/sg6
[8:0:2:2]    tape    HP       Ultrium 5-SCSI   0001  /dev/st2 /dev/sg5
[8:0:2:3]    mediumx FUJITSU  ETERNUS LT260    6.20  - /dev/sg4
[8:0:2:4]    tape    HP       Ultrium 6-SCSI   23AB  /dev/st1 /dev/sg3
[8:0:2:5]    tape    HP       Ultrium 6-SCSI   23AB  /dev/st0 /dev/sg2
[11:0:0:0]   disk    FUJITSU  ETERNUS_DXL      0000  /dev/sdb /dev/sg7
[11:0:0:2]   disk    FUJITSU  ETERNUS_DXL      0000  /dev/sdh /dev/sg13
[11:0:0:3]   disk    FUJITSU  ETERNUS_DXL      0000  /dev/sdg /dev/sg12
[11:0:0:4]   disk    FUJITSU  ETERNUS_DXL      0000  /dev/sdf /dev/sg11
[11:0:0:5]   disk    FUJITSU  ETERNUS_DXL      0000  /dev/sde /dev/sg10
[11:0:0:6]   disk    FUJITSU  ETERNUS_DXL      0000  /dev/sdd /dev/sg9
[11:0:0:7]   disk    FUJITSU  ETERNUS_DXL      0000  /dev/sdc /dev/sg8
[11:0:0:15]  disk    FUJITSU  ETERNUS_DXL      0000  /dev/sdi /dev/sg14
(VCSTCS82:A)IUP1:~ #



Wrong behavior/Result inside the VM-Quest together with QEMU/KVM 2.8.0-RC4
--
(VCSTCS82:A)IUP1:~ # lsscsi -g
[0:2:0:0]    disk    FTS      PRAID EP420i     4.25  /dev/sda /dev/sg0
[3:0:0:0]    cd/dvd  QEMU     QEMU DVD-ROM     2.5+  /dev/sr0 /dev/sg1
[11:0:1:0]   disk    FUJITSU  ETERNUS_DXL      0000  /dev/sdj /dev/sg10
[11:0:1:2]   disk    FUJITSU  ETERNUS_DXL      0000  /dev/sdp /dev/sg16
[11:0:1:3]   disk    FUJITSU  ETERNUS_DXL      0000  /dev/sdo /dev/sg15
[11:0:1:4]   disk    FUJITSU  ETERNUS_DXL      0000  /dev/sdn /dev/sg14
[11:0:1:5]   disk    FUJITSU  ETERNUS_DXL      0000  /dev/sdm /dev/sg13
[11:0:1:6]   disk    FUJITSU  ETERNUS_DXL      0000  /dev/sdl /dev/sg12
[11:0:1:7]   disk    FUJITSU  ETERNUS_DXL      0000  /dev/sdk /dev/sg11
[11:0:1:15]  disk    FUJITSU  ETERNUS_DXL      0000  /dev/sdq /dev/sg17
(VCSTCS82:A)IUP1:~ #
