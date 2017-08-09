Received: from eggs.gnu.org ([2001:4830:134:3::10]:55520)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dfLUA-0000Kj-9h
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 03:32:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dfLU6-0001g0-B8
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 03:32:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41734)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dfLU6-0001dx-5L
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 03:32:54 -0400
References: <743158bc-15e4-46fe-38cb-161397b5b240@linaro.org>
	<3685aed3-735f-ae62-73a9-8f4a5c7cd459@redhat.com>
	<9be585e2-4641-329e-f442-69ae05faadba@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ea6acc7c-09a6-70ed-9ff0-865bd45a47f3@redhat.com>
Date: Wed, 9 Aug 2017 09:26:11 +0200
MIME-Version: 1.0
In-Reply-To: <9be585e2-4641-329e-f442-69ae05faadba@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Qemu and 32 PCIe devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org
Cc: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, Marcel Apfelbaum <marcel@redhat.com>, Drew Jones <drjones@redhat.com>, Christoffer Dall <cdall@linaro.org>, Peter Maydell <peter.maydell@linaro.org>, Gema Gomez-Solano <gema.gomez-solano@linaro.org>, Marc Zygnier <marc.zyngier@arm.com>

On 09/08/2017 03:06, Laszlo Ersek wrote:
>>   20.14%  qemu-system-x86_64                  [.] render_memory_region
>>   17.14%  qemu-system-x86_64                  [.] subpage_register
>>   10.31%  qemu-system-x86_64                  [.] int128_add
>>    7.86%  qemu-system-x86_64                  [.] addrrange_end
>>    7.30%  qemu-system-x86_64                  [.] int128_ge
>>    4.89%  qemu-system-x86_64                  [.] int128_nz
>>    3.94%  qemu-system-x86_64                  [.] phys_page_compact
>>    2.73%  qemu-system-x86_64                  [.] phys_map_node_alloc

Yes, this is the O(n^3) thing.  An optimized build should be faster
because int128 operations will be inlined and become much more efficient.

> With this patch, I only tested the "93 devices" case, as the slowdown
> became visible to the naked eye from the trace messages, as the firmwar=
e
> enabled more and more BARs / command registers (and inversely, the
> speedup was perceivable when the firmware disabled more and more BARs /
> command registers).

This is an interesting observation, and it's expected.  Looking at the
O(n^3) complexity more in detail you have N operations, where the "i"th
operates on "i" DMA address spaces, all of which have at least "i"
memory regions (at least 1 BAR per device).

So the total cost is sum i=3D1..N i^2 =3D N(N+1)(2N+1)/6 =3D O(n^3).
Expressing it as a sum shows why it gets slower as time progresses.

The solution is to note that those "i" address spaces are actually all
the same, so we can get it down to sum i=3D1..N i =3D N(N+1)/2 =3D O(n^2)=
.

Thanks,

Paolo
