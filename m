Received: from eggs.gnu.org ([2001:4830:134:3::10]:47867)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <geoff@hostfission.com>) id 1e6HAU-0006Ao-3E
	for qemu-devel@nongnu.org; Sun, 22 Oct 2017 10:23:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <geoff@hostfission.com>) id 1e6HAP-00040x-5Y
	for qemu-devel@nongnu.org; Sun, 22 Oct 2017 10:23:58 -0400
Received: from mail1.hostfission.com ([139.99.139.48]:41008)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <geoff@hostfission.com>) id 1e6HAO-0003z7-Qj
	for qemu-devel@nongnu.org; Sun, 22 Oct 2017 10:23:53 -0400
Received: from www1.hostfission.com (www1.hostfission.com [139.99.139.52])
	by mail1.hostfission.com (Postfix) with ESMTP id E93DE422A1
	for <qemu-devel@nongnu.org>; Sun, 22 Oct 2017 21:47:57 +1100 (AEDT)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Sun, 22 Oct 2017 21:47:57 +1100
From: geoff@hostfission.com
Message-ID: <088c92d5c3be0715c46f20e8b0ba0a0f@hostfission.com>
Subject: [Qemu-devel] PCI Passthrough + AMD + NPT
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

I have started to dig into why ntp seems to slow down graphics 
performance on
AMD systems using PCI passthrough and figured I would report what I have 
so far
discovered. I have noted the primary point of failure seems to be 
specifically
with PhysX. This is why people only see a slow down in certain games, 
not
everything uses PhysX.

Using FluidMark[1] the problem is immediately obvious, showing extremely 
low
FPS on light/medium workloads with ntp enabled, and extreme fluididy and 
high
FPS with ntp disabled.

Switching nVidia to use CPU makes no difference to the performance when 
ntp
is enabled, which seems to indicate that PhysX is falling back to CPU 
due to
a failure of some kind to initialize.

With ntp turned off, and nVidia set to use the CPU for PhysX I see an
identical performance drop off in FluidMark as I see when ntp is 
enabled, this
would seem to confirm this suspicion.

Since other features such as APIC is only available if ntp is enabled, 
it
could be something down stream of ntp that is getting disabled as a
consequence of turning off ntp. It might be interesting to see if we can 
get
some diagnostics information out of PhysX to see what if any error or 
debugging
information it might provide when it falls back to CPU.

1: 
http://www.geeks3d.com/20130308/fluidmark-1-5-1-physx-benchmark-fluid-sph-simulation-opengl-download/

Kind Regards,
Geoffrey McRae
