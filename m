Received: from eggs.gnu.org ([2001:4830:134:3::10]:54890)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1frh4j-00088h-G9
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 06:06:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1frh4i-0000g6-DO
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 06:06:17 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43502 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1frh4i-0000g2-8I
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 06:06:16 -0400
References: <20180816011903.39816-1-andrew@andrewoates.com>
	<b45d87b9-38ac-427a-8622-ac9c49350511@redhat.com>
	<CAAVLcG6m_x2p4r9dqD6B2qG-Z_G_iTh5rAubS44PRM2-Mqnpkw@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f3c28dc7-a16e-1451-5bb6-090c6e13cf84@redhat.com>
Date: Mon, 20 Aug 2018 12:06:13 +0200
MIME-Version: 1.0
In-Reply-To: <CAAVLcG6m_x2p4r9dqD6B2qG-Z_G_iTh5rAubS44PRM2-Mqnpkw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] target-i386: fix segment limit check in
 ljmp
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Oates <andrew@andrewoates.com>
Cc: rth@twiddle.net, ehabkost@redhat.com, qemu-devel@nongnu.org, Andrew Oates <aoates@google.com>

On 17/08/2018 20:04, Andrew Oates wrote:
>>> [1] this is an invalid configuration (in protected mode the L bit is
>>> reserved and should be set to zero), but qemu doesn't enforce that.
>
> Is there a central place to do that sort of validation?=C2=A0 We could =
do it
> in load_segment_ra, but that doesn't feel quite right.=C2=A0 Otherwise =
it's
> whack-a-mole to check validity at every place a code segment is
> referenced---but maybe that's ok, there probably aren't too many of the=
m.
>=20
> WDYT?

To find them you have to look for the calls to cpu_x86_load_seg_cache.

However, the L bit is simply ignored in the descriptor cache outside
64-bit mode (at least that's what you can guess from the Intel manual's
26.3 CHECKING AND LOADING GUEST STATE, which is as close as you can get
to an official explanation of the descriptor cache), so you'd have to
take that into account too and do the check in the callers of
cpu_x86_load_seg_cache.

And in fact, the wording is a bit wishy-washy in both the Intel and AMD
manuals, for example AMD says of bit 21 that

	Generally, software should clear all reserved bits to 0, so they
	can be defined in future revisions to the AMD64 architecture.

so I am not 100% sure that the processor will actually raise an
exception if L is 1.

Thanks,

Paolo
