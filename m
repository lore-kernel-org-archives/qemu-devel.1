Received: from eggs.gnu.org ([2001:4830:134:3::10]:60644)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1fovQx-0001dk-VF
	for qemu-devel@nongnu.org; Sun, 12 Aug 2018 14:49:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1fovQt-0000T7-1y
	for qemu-devel@nongnu.org; Sun, 12 Aug 2018 14:49:48 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35902 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1fovQs-0000Sj-SG
	for qemu-devel@nongnu.org; Sun, 12 Aug 2018 14:49:42 -0400
References: <1533625449-14989-1-git-send-email-jing2.liu@linux.intel.com>
	<893d9264-7908-4e2c-ae1d-7e46eed6e6a0@redhat.com>
	<e06b10e0-d0b6-d190-6673-f97199bebb72@redhat.com>
	<efc99631-454d-4377-8551-0594fc763c94@gmail.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <7d37b9ad-9a69-99fd-1940-b0e5fe87efe5@redhat.com>
Date: Sun, 12 Aug 2018 16:34:11 +0200
MIME-Version: 1.0
In-Reply-To: <efc99631-454d-4377-8551-0594fc763c94@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] hw/pci: add pci capability to pci-pci
 bridge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Jing Liu <jing2.liu@linux.intel.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, anthony.xu@intel.com, mst@redhat.com

On 08/12/18 09:11, Marcel Apfelbaum wrote:
> On 08/07/2018 06:59 PM, Laszlo Ersek wrote:

>> First, under the label "shpc_error", we call pci_bridge_exitfn(), which
>> seems to clean up everything (checking individually for each thing to
>> clean up). Given this, I wonder why we introduced the "slotid_error" and
>> "msi_error" labels at all. Cascading teardown on the error path, and
>> invkoing a function that checks everything individually and then tears
>> it all down, are usually mutually exclusive.
> 
> I think is possible you miss-interpreted pci_bridge_dev_exitfn
> with pci_bridge_exitfn. The first one is the "catch all", the second
> one that is used in the error path is for the bridge specific cleanup.

Ah, you are correct, I totally mistook the call to pci_bridge_exitfn()
for pci_bridge_dev_exitfn(). I do see the difference now, so it's clear
that the error path in pci_bridge_dev_realize() is of the "cascading"
kind, and not of the "call a catch-all function" kind.

That gives this patch a clear pattern to follow.

Thank you!
Laszlo
