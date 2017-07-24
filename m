Received: from eggs.gnu.org ([2001:4830:134:3::10]:48065)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <a175818323@gmail.com>) id 1dZXpc-0006A0-Vo
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 03:31:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <a175818323@gmail.com>) id 1dZXpb-0002WR-SK
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 03:31:08 -0400
Received: from mail-io0-x235.google.com ([2607:f8b0:4001:c06::235]:37720)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <a175818323@gmail.com>)
	id 1dZXpb-0002WE-MG
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 03:31:07 -0400
Received: by mail-io0-x235.google.com with SMTP id c74so39807163iod.4
	for <qemu-devel@nongnu.org>; Mon, 24 Jul 2017 00:31:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAMxP3BQ+2nPjoEcB4w3gb5=CykUQUuWsjzi8N5XHLgPphbm=wQ@mail.gmail.com>
References: <CAMxP3BQ+2nPjoEcB4w3gb5=CykUQUuWsjzi8N5XHLgPphbm=wQ@mail.gmail.com>
From: Bob Chen <a175818323@gmail.com>
Date: Mon, 24 Jul 2017 15:31:06 +0800
Message-ID: <CAMxP3BSDEwHFLrfXP72hpaVhSsLoVtZ9S_uSZYFd-pReeqyJYA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Device passthrough] Is there a way to passthrough
 PCIE switch/bridge ?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Details attached...

I was trying to passthrough multiple GPUs into a single VM, the topology
looks like these below.

Without the help of PCIE switches, data traversing between GPUs are
extremely slow. (depends on memcopy by CPU)

So my question is can I passthrough all the switches and PCIE Root, in
order to make the Nvidia p2p feature work?



Host:
[root@localhost ~]# nvidia-smi topo -m
GPU0 GPU1 GPU2 GPU3 GPU4 GPU5 GPU6 GPU7 CPU Affinity
GPU0 X PIX PHB PHB SOC SOC SOC SOC 0-9,20-29
GPU1 PIX X PHB PHB SOC SOC SOC SOC 0-9,20-29
GPU2 PHB PHB X PIX SOC SOC SOC SOC 0-9,20-29
GPU3 PHB PHB PIX X SOC SOC SOC SOC 0-9,20-29
GPU4 SOC SOC SOC SOC X PIX PHB PHB 10-19,30-39
GPU5 SOC SOC SOC SOC PIX X PHB PHB 10-19,30-39
GPU6 SOC SOC SOC SOC PHB PHB X PIX 10-19,30-39
GPU7 SOC SOC SOC SOC PHB PHB PIX X 10-19,30-39


VM:
[root@titan-xp-chenbo-2 ~]# nvidia-smi topo -m
GPU0 GPU1 GPU2 GPU3 GPU4 GPU5 GPU6 GPU7 CPU Affinity
GPU0 X PHB PHB PHB PHB PHB PHB PHB 0-15
GPU1 PHB X PHB PHB PHB PHB PHB PHB 0-15
GPU2 PHB PHB X PHB PHB PHB PHB PHB 0-15
GPU3 PHB PHB PHB X PHB PHB PHB PHB 0-15
GPU4 PHB PHB PHB PHB X PHB PHB PHB 0-15
GPU5 PHB PHB PHB PHB PHB X PHB PHB 0-15
GPU6 PHB PHB PHB PHB PHB PHB X PHB 0-15
GPU7 PHB PHB PHB PHB PHB PHB PHB X 0-15


Legend:

  X   = Self
  SOC  = Connection traversing PCIe as well as the SMP link between CPU
sockets(e.g. QPI)
  PHB  = Connection traversing PCIe as well as a PCIe Host Bridge
(typically the CPU)
  PXB  = Connection traversing multiple PCIe switches (without traversing
the PCIe Host Bridge)
  PIX  = Connection traversing a single PCIe switch
  NV#  = Connection traversing a bonded set of # NVLinks



2017-07-24 14:03 GMT+08:00 Bob Chen <a175818323@gmail.com>:

>
> - Bob
>
