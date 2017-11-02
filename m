Received: from eggs.gnu.org ([2001:4830:134:3::10]:60251)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eAO1L-0003mD-RW
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 18:31:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eAO1H-0004UB-PO
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 18:31:31 -0400
Received: from indium.canonical.com ([91.189.90.7]:48020)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eAO1H-0004TG-Fp
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 18:31:27 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eAO1F-0004Pa-4q
	for <qemu-devel@nongnu.org>; Thu, 02 Nov 2017 22:31:25 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 16F4B2E80AD
	for <qemu-devel@nongnu.org>; Thu,  2 Nov 2017 22:31:25 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Nov 2017 22:16:32 -0000
From: Launchpad Bug Tracker <1719196@bugs.launchpad.net>
Reply-To: Bug 1719196 <1719196@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <150626680089.6094.17724106932405637799.malonedeb@soybean.canonical.com>
Message-Id: <150966099591.14704.15579565353459258178.malone@ackee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1719196] Re: [arm64 ocata] newly created
 instances are unable to raise network interfaces
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

This bug was fixed in the package qemu - 1:2.8+dfsg-3ubuntu2.7

---------------
qemu (1:2.8+dfsg-3ubuntu2.7) zesty; urgency=3Dmedium

  * d/p/ubuntu/virtio-Fix-no-interrupt-when-not-creating-msi-contro.patch:
    on Arm fix no interrupt when not creating msi controller. That fixes
    broken networking if running with virtio-mmio only (LP: #1719196).

 -- Christian Ehrhardt <christian.ehrhardt@canonical.com>  Wed, 18 Oct
2017 16:17:34 +0200

** Changed in: qemu (Ubuntu Zesty)
       Status: Fix Committed =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1719196

Title:
  [arm64 ocata] newly created instances are unable to raise network
  interfaces

Status in Ubuntu Cloud Archive:
  Fix Released
Status in Ubuntu Cloud Archive ocata series:
  Fix Committed
Status in libvirt:
  New
Status in QEMU:
  Fix Released
Status in libvirt package in Ubuntu:
  Invalid
Status in qemu package in Ubuntu:
  Fix Released
Status in qemu source package in Zesty:
  Fix Released

Bug description:
  [Impact]

   * A change in qemu 2.8 (83d768b virtio: set ISR on dataplane =

     notifications) broke virtio handling on platforms without a =

     controller. Those encounter flaky networking due to missed IRQs

   * Fix is a backport of the upstream fix b4b9862b: virtio: Fix no =

     interrupt when not creating msi controller

  [Test Case]

   * On Arm with Zesty (or Ocata) run a guest without PCI based devices

   * Example in e.g. c#23

   * Without the fix the networking does not work reliably (as it losses =

     IRQs), with the fix it works fine.

  [Regression Potential]

   * Changing the IRQ handling of virtio could affect virtio in general.
     But when reviwing the patch you'll see that it is small and actually =

     only changes to enable IRQ on one more place. That could cause more =

     IRQs than needed in the worst case, but those are usually not =

     breaking but only slowing things down. Also this fix is upstream =

     quite a while, increasing confidence.

  [Other Info]
   =

   * There is currently 1720397 in flight in the SRU queue, so acceptance =

     of this upload has to wait until that completes.

  ---

  arm64 Ocata ,

  I'm testing to see I can get Ocata running on arm64 and using the
  openstack-base bundle to deploy it.  I have added the bundle to the
  log file attached to this bug.

  When I create a new instance via nova, the VM comes up and runs,
  however fails to raise its eth0 interface. This occurs on both
  internal and external networks.

  ubuntu@openstackaw:~$ nova list
  +--------------------------------------+---------+--------+------------+-=
------------+--------------------+
  | ID                                   | Name    | Status | Task State | =
Power State | Networks           |
  +--------------------------------------+---------+--------+------------+-=
------------+--------------------+
  | dcaf6d51-f81e-4cbd-ac77-0c5d21bde57c | sfeole1 | ACTIVE | -          | =
Running     | internal=3D10.5.5.3  |
  | aa0b8aee-5650-41f4-8fa0-aeccdc763425 | sfeole2 | ACTIVE | -          | =
Running     | internal=3D10.5.5.13 |
  +--------------------------------------+---------+--------+------------+-=
------------+--------------------+
  ubuntu@openstackaw:~$ nova show aa0b8aee-5650-41f4-8fa0-aeccdc763425
  +--------------------------------------+---------------------------------=
-------------------------+
  | Property                             | Value                           =
                         |
  +--------------------------------------+---------------------------------=
-------------------------+
  | OS-DCF:diskConfig                    | MANUAL                          =
                         |
  | OS-EXT-AZ:availability_zone          | nova                            =
                         |
  | OS-EXT-SRV-ATTR:host                 | awrep3                          =
                         |
  | OS-EXT-SRV-ATTR:hypervisor_hostname  | awrep3.maas                     =
                         |
  | OS-EXT-SRV-ATTR:instance_name        | instance-00000003               =
                         |
  | OS-EXT-STS:power_state               | 1                               =
                         |
  | OS-EXT-STS:task_state                | -                               =
                         |
  | OS-EXT-STS:vm_state                  | active                          =
                         |
  | OS-SRV-USG:launched_at               | 2017-09-24T14:23:08.000000      =
                         |
  | OS-SRV-USG:terminated_at             | -                               =
                         |
  | accessIPv4                           |                                 =
                         |
  | accessIPv6                           |                                 =
                         |
  | config_drive                         |                                 =
                         |
  | created                              | 2017-09-24T14:22:41Z            =
                         |
  | flavor                               | m1.small (717660ae-0440-4b19-a76=
2-ffeb32a0575c)          |
  | hostId                               | 5612a00671c47255d2ebd6737a64ec9b=
d3a5866d1233ecf3e988b025 |
  | id                                   | aa0b8aee-5650-41f4-8fa0-aeccdc76=
3425                     |
  | image                                | zestynosplash (e88fd1bd-f040-44d=
8-9e7c-c462ccf4b945)     |
  | internal network                     | 10.5.5.13                       =
                         |
  | key_name                             | mykey                           =
                         |
  | metadata                             | {}                              =
                         |
  | name                                 | sfeole2                         =
                         |
  | os-extended-volumes:volumes_attached | []                              =
                         |
  | progress                             | 0                               =
                         |
  | security_groups                      | default                         =
                         |
  | status                               | ACTIVE                          =
                         |
  | tenant_id                            | 9f7a21c1ad264fec81abc09f3960ad1d=
                         |
  | updated                              | 2017-09-24T14:23:09Z            =
                         |
  | user_id                              | e6bb6f5178a248c1b5ae66ed388f9040=
                         |
  +--------------------------------------+---------------------------------=
-------------------------+

  As seen above the instances boot an run.  Full Console output is
  attached to this bug.

  [  OK  ] Started Initial cloud-init job (pre-networking).
  [  OK  ] Reached target Network (Pre).
  [  OK  ] Started AppArmor initialization.
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Starting Raise netw=
ork interfaces...
  [FAILED] Failed to start Raise network interfaces.
  See 'systemctl status networking.service' for details.
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Starting Initial cl=
oud-init job (metadata service crawler)...
  [  OK  ] Reached target Network.
  [  315.051902] cloud-init[881]: Cloud-init v. 0.7.9 running 'init' at Fri=
, 22 Sep 2017 18:29:15 +0000. Up 314.70 seconds.
  [  315.057291] cloud-init[881]: ci-info: +++++++++++++++++++++++++++Net d=
evice info+++++++++++++++++++++++++++
  [  315.060338] cloud-init[881]: ci-info: +--------+------+-----------+---=
--------+-------+-------------------+
  [  315.063308] cloud-init[881]: ci-info: | Device |  Up  |  Address  |   =
 Mask   | Scope |     Hw-Address    |
  [  315.066304] cloud-init[881]: ci-info: +--------+------+-----------+---=
--------+-------+-------------------+
  [  315.069303] cloud-init[881]: ci-info: | eth0:  | True |     .     |   =
  .     |   .   | fa:16:3e:39:4c:48 |
  [  315.072308] cloud-init[881]: ci-info: | eth0:  | True |     .     |   =
  .     |   d   | fa:16:3e:39:4c:48 |
  [  315.075260] cloud-init[881]: ci-info: |  lo:   | True | 127.0.0.1 | 25=
5.0.0.0 |   .   |         .         |
  [  315.078258] cloud-init[881]: ci-info: |  lo:   | True |     .     |   =
  .     |   d   |         .         |
  [  315.081249] cloud-init[881]: ci-info: +--------+------+-----------+---=
--------+-------+-------------------+
  [  315.084240] cloud-init[881]: 2017-09-22 18:29:15,393 - url_helper.py[W=
ARNING]: Calling 'http://169.254.169.254/2009-04-04/meta-data/instance-id' =
failed [0/120s]: request error [HTTPConnectionPool(host=3D'169.254.169.254'=
, port=3D80): Max retries exceeded with url: /2009-04-04/meta-data/instance=
-id (Caused by NewConnectionError('<requests.packages.urllib3.connection.HT=
TPConnection object at 0xffffb10794e0>: Failed to establish a new connectio=
n: [Errno 101] Network is unreachable',))]

  ----------------

  I have checked all services in neutron and made sure that they are
  running and restarted in neutron-gateway

  =C2=A0[ + ]  neutron-dhcp-agent
  =C2=A0[ + ]  neutron-l3-agent
  =C2=A0[ + ]  neutron-lbaasv2-agent
  =C2=A0[ + ]  neutron-metadata-agent
  =C2=A0[ + ]  neutron-metering-agent
  =C2=A0[ + ]  neutron-openvswitch-agent
  =C2=A0[ + ]  neutron-ovs-cleanup

  and have also restarted and checked the nova-compute logs for their
  neutron counterparts.

  =C2=A0[ + ]  neutron-openvswitch-agent
  =C2=A0[ + ]  neutron-ovs-cleanup

  =C2=A0There are some warnings/errors in the neutron-gateway logs which I
  have attached the full tarball in a separate attachment to this bug:

  2017-09-24 14:39:33.152 10322 INFO ryu.base.app_manager [-] instantiating=
 app ryu.controller.ofp_handler of OFPHandler
  2017-09-24 14:39:33.153 10322 INFO ryu.base.app_manager [-] instantiating=
 app ryu.app.ofctl.service of OfctlService
  2017-09-24 14:39:39.577 10322 ERROR neutron.agent.ovsdb.impl_vsctl [req-2=
f084ae8-13dc-47dc-b351-24c8f3c57067 - - - - -] Unable to execute ['ovs-vsct=
l', '--timeout=3D10', '--oneline', '--format=3Djson', '--', '--id=3D@manage=
r', 'create', 'Manager', 'target=3D"ptcp:6640:127.0.0.1"', '--', 'add', 'Op=
en_vSwitch', '.', 'manager_options', '@manager']. Exception: Exit code: 1; =
Stdin: ; Stdout: ; Stderr: ovs-vsctl: transaction error: {"details":"Transa=
ction causes multiple rows in \"Manager\" table to have identical values (\=
"ptcp:6640:127.0.0.1\") for index on column \"target\".  First row, with UU=
ID e02a5f7f-bfd2-4a1d-ae3c-0321db4bd3fb, existed in the database before thi=
s transaction and was not modified by the transaction.  Second row, with UU=
ID 6e9aba3a-471a-4976-bffd-b7131bbe5377, was inserted by this transaction."=
,"error":"constraint violation"}

  These warnings/errors also occur on the nova-compute hosts in
  /var/log/neutron/

  2017-09-22 18:54:52.130 387556 INFO ryu.base.app_manager [-] instantiatin=
g app ryu.app.ofctl.service of OfctlService
  2017-09-22 18:54:56.124 387556 ERROR neutron.agent.ovsdb.impl_vsctl [req-=
e291c2f9-a123-422c-be7c-fadaeb5decfa - - - - -] Unable to execute ['ovs-vsc=
tl', '--timeout=3D10', '--oneline', '--format=3Djson', '--', '--id=3D@manag=
er', 'create', 'Manager', 'target=3D"ptcp:6640:127.0.0.1"', '--', 'add', 'O=
pen_vSwitch', '.', 'manager_options', '@manager']. Exception: Exit code: 1;=
 Stdin: ; Stdout: ; Stderr: ovs-vsctl: transaction error: {"details":"Trans=
action causes multiple rows in \"Manager\" table to have identical values (=
\"ptcp:6640:127.0.0.1\") for index on column \"target\".  First row, with U=
UID 9f27ddee-9881-4cbc-9777-2f42fee735e9, was inserted by this transaction.=
  Second row, with UUID ccf0e097-09d5-449c-b353-6b69781dc3f7, existed in th=
e database before this transaction and was not modified by the transaction.=
","error":"constraint violation"}

  I'm not sure if the above error could be pertaining to the failure, I
  have also attached those logs to this bug as well...

  .
  (neutron) agent-list
  +--------------------------------------+----------------------+--------+-=
------------------+-------+----------------+---------------------------+
  | id                                   | agent_type           | host   | =
availability_zone | alive | admin_state_up | binary                    |
  +--------------------------------------+----------------------+--------+-=
------------------+-------+----------------+---------------------------+
  | 0cca03fb-abb2-4704-8b0b-e7d3e117d882 | DHCP agent           | awrep1 | =
nova              | :-)   | True           | neutron-dhcp-agent        |
  | 14a5fd52-fbc3-450c-96d5-4e9a65776dad | L3 agent             | awrep1 | =
nova              | :-)   | True           | neutron-l3-agent          |
  | 2ebc7238-5e61-41f8-bc60-df14ec6b226b | Loadbalancerv2 agent | awrep1 | =
                  | :-)   | True           | neutron-lbaasv2-agent     |
  | 4f6275be-fc8b-4994-bdac-13a4b76f6a83 | Metering agent       | awrep1 | =
                  | :-)   | True           | neutron-metering-agent    |
  | 86ecc6b0-c100-4298-b861-40c17516cc08 | Open vSwitch agent   | awrep1 | =
                  | :-)   | True           | neutron-openvswitch-agent |
  | 947ad3ab-650b-4b96-a520-00441ecb33e7 | Open vSwitch agent   | awrep4 | =
                  | :-)   | True           | neutron-openvswitch-agent |
  | 996b0692-7d19-4641-bec3-e057f4a856f6 | Open vSwitch agent   | awrep3 | =
                  | :-)   | True           | neutron-openvswitch-agent |
  | ab6b1065-0b98-4cf3-9f46-6bddba0c5e75 | Metadata agent       | awrep1 | =
                  | :-)   | True           | neutron-metadata-agent    |
  | fe24f622-b77c-4eed-ae22-18e4195cf763 | Open vSwitch agent   | awrep2 | =
                  | :-)   | True           | neutron-openvswitch-agent |
  +--------------------------------------+----------------------+--------+-=
------------------+-------+----------------+---------------------------+

  Should neutron-openvswitch be assigned to the 'nova' availability
  zone?

  I have also attached the ovs-vsctl show from a nova-compute host and
  the neutron-gateway host to ensure that the open v switch routes are
  correct.

  I can supply more logs if required.

To manage notifications about this bug go to:
https://bugs.launchpad.net/cloud-archive/+bug/1719196/+subscriptions
