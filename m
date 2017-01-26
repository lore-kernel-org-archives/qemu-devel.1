Received: from eggs.gnu.org ([2001:4830:134:3::10]:47483)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cWf49-0006Cw-21
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 03:05:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cWf45-0003lu-3L
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 03:05:57 -0500
Received: from indium.canonical.com ([91.189.90.7]:49104)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cWf44-0003lT-TT
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 03:05:53 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cWf42-0005nI-GK
	for <qemu-devel@nongnu.org>; Thu, 26 Jan 2017 08:05:50 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 534082E81DB
	for <qemu-devel@nongnu.org>; Thu, 26 Jan 2017 08:05:50 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Jan 2017 07:50:52 -0000
From: Thomas Huth <1261450@bugs.launchpad.net>
Reply-To: Bug 1261450 <1261450@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20131216170051.8689.69478.malonedeb@gac.canonical.com>
Message-Id: <20170126075053.27223.82880.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1261450] Re: libvirtd reload and hooks problem
 routed-net
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Closing, since this is not a QEMU bug.

** Changed in: qemu
       Status: New =3D> Invalid

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1261450

Title:
  libvirtd reload and hooks problem routed-net

Status in QEMU:
  Invalid

Bug description:
  if we do a reload of libvirt, some iptables rules, which are created thro=
ugh /etc/libvirt/hooks/qemu are not working anymore.
  Every time a other (one or two,thee) vm is affected. =


  =

  our qemu file:

  #!/bin/bash

  =

  do_net() {
          local status=3D$2
          local ip=3D$3
          local in=3D$4
          local out=3D$5

          if [[ ! $status || ! $ip || ! $in || ! $out ]]; then
                  echo "Not all parameters were passed!"
                  exit 1
          fi

          if [ "$status" =3D "stopped" -o "$status" =3D "reconnect" ]; then
                  ip route del $ip via 191.255.255.1 dev $out
                  ip neigh del proxy $ip dev $in
                  iptables -D FORWARD -i $in -o $out -s 0.0.0.0/0 -d $ip/32=
 -j ACCEPT
                  iptables -D FORWARD -i $out -o $in -s $ip/32 -d 0.0.0.0/0=
 -j ACCEPT
          fi

          if [ "$status" =3D "start" -o "$status" =3D "reconnect" ]; then
                  ip route add $ip via 191.255.255.1 dev $out
                  ip neigh add proxy $ip dev $in
                  iptables -I FORWARD 4 -i $in -o $out -s 0.0.0.0/0 -d $ip/=
32 -j ACCEPT
                  iptables -I FORWARD 4 -i $out -o $in -s $ip/32 -d 0.0.0.0=
/0 -j ACCEPT
                  fi
  }

  CONF=3D//etc/libvirt/hooks/vms/*
  for file in $CONF
  do
          guest_ipaddr=3D""
          guest_name=3D""
          type=3D""
          destination=3D"0.0.0.0/0"

    while read line;    do
      eval $line
    done < $file
          guest_ipaddrnet=3D$guest_ipaddr"/32"
        for dest in ${destination}
        do
                  if [ "${1}" =3D "${guest_name}" ]; then
                          echo "SRC-IP=3D"$guest_ipaddr " " $guest_ipaddrne=
t " VM=3D"$guest_name " Dest=3D"$dest
                          if [ "${2}" =3D "stopped" ]; then
                                          ip route del $guest_ipaddr via 19=
1.255.255.1 dev virbr1
                                         ip neigh del proxy $guest_ipaddr d=
ev bond0
                                 iptables -D FORWARD -i bond0 -o virbr1 -s =
$dest -d $guest_ipaddrnet -j ACCEPT
                                 iptables -D FORWARD -i virbr1 -o bond0 -s =
$guest_ipaddrnet -d $dest -j ACCEPT
                          fi
                          if [ "${2}" =3D "start" ]; then
                                   ip route add $guest_ipaddr via 191.255.2=
55.1 dev virbr1
                                   ip neigh add proxy $guest_ipaddr dev bon=
d0
                                   iptables -I FORWARD 4 -i bond0 -o virbr1=
 -s $dest -d $guest_ipaddrnet -j ACCEPT
                                   iptables -I FORWARD 4 -i virbr1 -o bond0=
 -s $guest_ipaddrnet -d $dest -j ACCEPT
                          fi
                          if [ "${2}" =3D "reconnect" ]; then
                                         ip route del $guest_ipaddr via 191=
.255.255.1 dev virbr1
                                         ip neigh del proxy $guest_ipaddr d=
ev bond0
                                 iptables -D FORWARD -i bond0 -o virbr1 -s =
$dest -d $guest_ipaddrnet -j ACCEPT
                                 iptables -D FORWARD -i virbr1 -o bond0 -s =
$guest_ipaddrnet -d $dest -j ACCEPT
                                 sleep 1
                                   ip route add $guest_ipaddr via 191.255.2=
55.1 dev virbr1
                                   ip neigh add proxy $guest_ipaddr dev bon=
d0
                                 iptables -I FORWARD 4 -i bond0 -o virbr1 -=
s $dest -d $guest_ipaddrnet -j ACCEPT
                                 iptables -I FORWARD 4 -i virbr1 -o bond0 -=
s $guest_ipaddrnet -d $dest -j ACCEPT
                          fi
                  fi
          done
  done

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1261450/+subscriptions
