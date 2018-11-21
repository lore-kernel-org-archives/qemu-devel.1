Received: from eggs.gnu.org ([2001:4830:134:3::10]:39398)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1gPOpP-0000QW-AX
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 04:29:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1gPOpK-0004vv-DR
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 04:29:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36850)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1gPOpK-0004uo-8P
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 04:29:42 -0500
Date: Wed, 21 Nov 2018 14:59:34 +0530 (IST)
From: P J P <ppandit@redhat.com>
In-Reply-To: <af8e80fd-4249-2eb3-3646-4bbaa65acd40@redhat.com>
Message-ID: <nycvar.YSQ.7.76.1811211445380.4176@xnncv>
References: <20181106115351.9422-1-ppandit@redhat.com>
	<CAFEAcA880MNu+_C1ySic7ASsQNMth1FCGSjHJg_N7Ud+s4G_PA@mail.gmail.com>
	<af8e80fd-4249-2eb3-3646-4bbaa65acd40@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH] lsi53c895a: check script ram address value
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Qemu Developers <qemu-devel@nongnu.org>, Fam Zheng <famz@redhat.com>

  Hello Petr, Paolo,

+-- On Tue, 6 Nov 2018, Paolo Bonzini wrote --+
| On 06/11/2018 13:03, Peter Maydell wrote:
| > When can this masking have any effect? These functions are
| > the read and write ops for lsi_ram_ops, which we register with
| >     memory_region_init_io(&s->ram_io, OBJECT(s), &lsi_ram_ops, s,
| >                           "lsi-ram", 0x2000);
| > which specifies a memory region size of 0x2000. So the input
| > addr must be in the 0..0x1fff range already -- or have I missed
| > something ?
| > 
| > It would probably be helpful (for readers and static analysers)
| > to assert() that addr is < 0x2000, though.
| 
| Indeed, there are cases where the address is used blindly in a memcpy
| with size>1, but this is not one of them.

True, the lsi r/w mmio ops are initialized to be within MemoryRegion size of 
0x2000. IIUC memory_region_access_valid() does not seem to check that given 
'addr' is within mr->size limit. ie 'addr > 0x01FFF' may lead to oob access 
in doing

   val = s->script_ram[addr >> 2];

Hope I'm not misreading. Thank you.
--
Prasad J Pandit / Red Hat Product Security Team
47AF CE69 3A90 54AA 9045 1053 DD13 3D32 FE5B 041F
