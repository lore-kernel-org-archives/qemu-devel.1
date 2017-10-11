Received: from eggs.gnu.org ([2001:4830:134:3::10]:52661)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e2F9H-0005Kk-R1
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 07:26:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e2F9C-0004FO-SU
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 07:26:03 -0400
Received: from indium.canonical.com ([91.189.90.7]:36220)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1e2F9C-0004Ep-Hi
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 07:25:58 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1e2F9A-00020t-Jx
	for <qemu-devel@nongnu.org>; Wed, 11 Oct 2017 11:25:56 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 8E80D2E80C0
	for <qemu-devel@nongnu.org>; Wed, 11 Oct 2017 11:25:56 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Oct 2017 11:17:42 -0000
From: ChristianEhrhardt <1719196@bugs.launchpad.net>
Reply-To: Bug 1719196 <1719196@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <150626680089.6094.17724106932405637799.malonedeb@soybean.canonical.com>
Message-Id: <150772066250.8049.7846070032638227660.malone@wampee.canonical.com>
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

Hi,
I was reading into this after being back from PTO (actually back next monda=
y).
I was wondering as I tested (without openstack) just that last week with Da=
nnf on the Rally).
And indeed it seems to work for me on Artful (which as we all know is =3DOc=
ata in terms of SW stack).

$ cat arm-template.xml =

<domain type=3D'kvm'>
        <os>
                <type arch=3D'aarch64' machine=3D'virt'>hvm</type>
                <loader readonly=3D'yes' type=3D'pflash'>/usr/share/AAVMF/A=
AVMF_CODE.fd</loader>
                <nvram template=3D'/usr/share/AAVMF/AAVMF_CODE.fd'>/tmp/AAV=
MF_CODE.fd</nvram>
                <boot dev=3D'hd'/>
        </os>
        <features>
                <acpi/>
                <apic/>
                <pae/>
        </features>
        <cpu mode=3D'custom' match=3D'exact'>
                <model fallback=3D'allow'>host</model>
        </cpu>
        <devices>
                <interface type=3D'network'>
                        <source network=3D'default'/>
                        <model type=3D'virtio'/>
                </interface>
                <serial type=3D'pty'>
                        <source path=3D'/dev/pts/3'/>
                        <target port=3D'0'/>
                </serial>
        </devices>
</domain>

$ uvt-kvm create --template arm-template.xml --password=3Dubuntu artful-
test4 release=3Dartful arch=3Darm64 label=3Ddaily

The template is created in a way to let as much as possible for libvirt and=
 qemu to fill in defaults. That way if one of them change we do not have to=
 follow and adapt.
Maybe such a thing is happening to you for the more "defined" xml that open=
stack is sending.

>From the hosts point of view all looks normal in journal, you see start and=
 dhcp discover/offer/ack sequence:
Okt 11 10:45:43 seidel kernel: virbr0: port 2(vnet0) entered learning state
Okt 11 10:45:45 seidel kernel: virbr0: port 2(vnet0) entered forwarding sta=
te
Okt 11 10:45:45 seidel kernel: virbr0: topology change detected, propagating
Okt 11 10:46:14 seidel dnsmasq-dhcp[2610]: DHCPDISCOVER(virbr0) 52:54:00:b1=
:db:89
Okt 11 10:46:14 seidel dnsmasq-dhcp[2610]: DHCPOFFER(virbr0) 192.168.122.13=
 52:54:00:b1:db:89
Okt 11 10:46:14 seidel dnsmasq-dhcp[2610]: DHCPDISCOVER(virbr0) 52:54:00:b1=
:db:89
Okt 11 10:46:14 seidel dnsmasq-dhcp[2610]: DHCPOFFER(virbr0) 192.168.122.13=
 52:54:00:b1:db:89
Okt 11 10:46:14 seidel dnsmasq-dhcp[2610]: DHCPREQUEST(virbr0) 192.168.122.=
13 52:54:00:b1:db:89
Okt 11 10:46:14 seidel dnsmasq-dhcp[2610]: DHCPACK(virbr0) 192.168.122.13 5=
2:54:00:b1:db:89 ubuntu

The guest also seems "normal" to me:
$ uvt-kvm ssh artful-test4 -- journalctl -u systemd-networkd
-- Logs begin at Wed 2017-10-11 10:46:03 UTC, end at Wed 2017-10-11 11:02:3=
1 UTC. --
Oct 11 10:46:11 ubuntu systemd[1]: Starting Network Service...
Oct 11 10:46:11 ubuntu systemd-networkd[547]: Enumeration completed
Oct 11 10:46:11 ubuntu systemd[1]: Started Network Service.
Oct 11 10:46:11 ubuntu systemd-networkd[547]: enp1s0: IPv6 successfully ena=
bled
Oct 11 10:46:11 ubuntu systemd-networkd[547]: enp1s0: Gained carrier
Oct 11 10:46:12 ubuntu systemd-networkd[547]: enp1s0: Gained IPv6LL
Oct 11 10:46:14 ubuntu systemd-networkd[547]: enp1s0: DHCPv4 address 192.16=
8.122.13/24 via 192.168.122.1
Oct 11 10:46:14 ubuntu systemd-networkd[547]: Not connected to system bus, =
ignoring transient hostname.
Oct 11 10:46:24 ubuntu systemd-networkd[547]: enp1s0: Configured

The biggest and obviously most important difference is in the networking th=
at is used:
    <interface type=3D'network'>
      <mac address=3D'52:54:00:b1:db:89'/>
      <source network=3D'default' bridge=3D'virbr0'/>
      <target dev=3D'vnet0'/>
      <model type=3D'virtio'/>
      <alias name=3D'net0'/>
      <address type=3D'pci' domain=3D'0x0000' bus=3D'0x01' slot=3D'0x00' fu=
nction=3D'0x0'/>
    </interface>

While openstack generates a type=3D"bridge" network where the bridge is not=
 managed by libvirt (compared to the default net I use).
Never the less both setups create a bridge and tap the guest on it.
So this should functionally be equivalent other than the bridge setup right?


I tried to make a bridge type config matching to what I had before but clos=
e to yours:
    <interface type=3D'bridge'>
      <mac address=3D'52:54:00:b1:db:89'/>
      <source bridge=3D'virbr0'/>
      <target dev=3D'vnet0'/>   =

      <model type=3D'virtio'/>
      <alias name=3D'net0'/>                =

      <address type=3D'virtio-mmio'/>
    </interface>

But this again works:
ubuntu@artful-test4:~$ journalctl -u systemd-networkd --no-pager
-- Logs begin at Wed 2017-10-11 11:12:10 UTC, end at Wed 2017-10-11 11:13:0=
0 UTC. --
Oct 11 11:12:17 artful-test4 systemd[1]: Starting Network Service...
Oct 11 11:12:17 artful-test4 systemd-networkd[604]: Enumeration completed
Oct 11 11:12:17 artful-test4 systemd[1]: Started Network Service.
Oct 11 11:12:17 artful-test4 systemd-networkd[604]: enp1s0: IPv6 successful=
ly enabled
Oct 11 11:12:17 artful-test4 systemd-networkd[604]: enp1s0: Gained carrier
Oct 11 11:12:18 artful-test4 systemd-networkd[604]: enp1s0: Gained IPv6LL
Oct 11 11:12:20 artful-test4 systemd-networkd[604]: enp1s0: DHCPv4 address =
192.168.122.14/24 via 192.168.122.1
Oct 11 11:12:20 artful-test4 systemd-networkd[604]: Not connected to system=
 bus, ignoring transient hostname.
Oct 11 11:12:30 artful-test4 systemd-networkd[604]: enp1s0: Configured

Dumping the XML to check if it might have rewritten a lot shows me that my =
config is good:
    <interface type=3D'bridge'>
      <mac address=3D'52:54:00:b1:db:89'/>
      <source bridge=3D'virbr0'/>
      <target dev=3D'vnet0'/>
      <model type=3D'virtio'/>
      <alias name=3D'net0'/>
      <address type=3D'virtio-mmio'/>
    </interface>

So TL;DR a config almost the same as yours works.
Yet the difference is that livbirt has set up 'virbr0' in my case and I'd a=
ssume openstack did create qbrb5d335fc-46 on its own.

As next step I'd recommend iterating your config around different bridge sc=
enarios to find what breaks it.
Then if reasonable try to exclude openstack from the equation as I shown ab=
ove (or not if you think the fix needs to be in openstack).

I hope this helped to get closer to the root casue, but I thought that a
working example on the new Ocata stack might be the best start with.

Note this was done on:
libvirt-daemon-system          3.6.0-1ubuntu4
qemu-kvm                       1:2.10+dfsg-0ubuntu1

** Also affects: qemu (Ubuntu)
   Importance: Undecided
       Status: New

** Also affects: libvirt (Ubuntu)
   Importance: Undecided
       Status: New

** Changed in: libvirt (Ubuntu)
       Status: New =3D> Incomplete

** Changed in: qemu (Ubuntu)
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1719196

Title:
  [arm64 ocata] newly created instances are unable to raise network
  interfaces

Status in libvirt:
  New
Status in QEMU:
  New
Status in libvirt package in Ubuntu:
  Incomplete
Status in qemu package in Ubuntu:
  Incomplete

Bug description:
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

  =

  [  OK  ] Started Initial cloud-init job (pre-networking).
  [  OK  ] Reached target Network (Pre).
  [  OK  ] Started AppArmor initialization.
           Starting Raise network interfaces...
  [FAILED] Failed to start Raise network interfaces.
  See 'systemctl status networking.service' for details.
           Starting Initial cloud-init job (metadata service crawler)...
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


  =

  ----------------


  I have checked all services in neutron and made sure that they are
  running and restarted in neutron-gateway

  =

   [ + ]  neutron-dhcp-agent
   [ + ]  neutron-l3-agent
   [ + ]  neutron-lbaasv2-agent
   [ + ]  neutron-metadata-agent
   [ + ]  neutron-metering-agent
   [ + ]  neutron-openvswitch-agent
   [ + ]  neutron-ovs-cleanup

  and have also restarted and checked the nova-compute logs for their
  neutron counterparts.

  =

   [ + ]  neutron-openvswitch-agent
   [ + ]  neutron-ovs-cleanup


   There are some warnings/errors in the neutron-gateway logs which I
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


  =

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

  =

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

  =

  Should neutron-openvswitch be assigned to the 'nova' availability zone? =


  I have also attached the ovs-vsctl show from a nova-compute host and
  the neutron-gateway host to ensure that the open v switch routes are
  correct.

  =

  I can supply more logs if required.

To manage notifications about this bug go to:
https://bugs.launchpad.net/libvirt/+bug/1719196/+subscriptions
