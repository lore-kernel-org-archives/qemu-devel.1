Received: from eggs.gnu.org ([209.51.188.92]:45815)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gwVeN-0004Dg-06
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 12:27:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gwVeK-00018R-FG
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 12:27:14 -0500
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:40883)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gwVeI-00017U-HF
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 12:27:11 -0500
Received: by mail-pf1-x441.google.com with SMTP id h1so12218482pfo.7
	for <qemu-devel@nongnu.org>; Wed, 20 Feb 2019 09:27:10 -0800 (PST)
References: <20190130004811.27372-1-cota@braap.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <70297ac5-defa-0d7b-b4da-44303b328ce2@linaro.org>
Date: Wed, 20 Feb 2019 09:27:06 -0800
MIME-Version: 1.0
In-Reply-To: <20190130004811.27372-1-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6 00/73] per-CPU locks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Alistair Francis <alistair23@gmail.com>, Andrzej Zaborowski <balrogg@gmail.com>, Anthony Green <green@moxielogic.com>, Artyom Tarasenko <atar4qemu@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Christian Borntraeger <borntraeger@de.ibm.com>, Chris Wulff <crwulff@gmail.com>, Cornelia Huck <cohuck@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, David Hildenbrand <david@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, Fabien Chouteau <chouteau@adacore.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, James Hogan <jhogan@kernel.org>, Laurent Vivier <laurent@vivier.eu>, Marek Vasut <marex@denx.de>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Max Filippov <jcmvbkbc@gmail.com>, Michael Walle <michael@walle.cc>, Palmer Dabbelt <palmer@sifive.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, Sagar Karandikar <sagark@eecs.berkeley.edu>, Stafford Horne <shorne@gmail.com>

On 1/29/19 4:46 PM, Emilio G. Cota wrote:
> v5: https://lists.gnu.org/archive/html/qemu-devel/2018-12/msg02979.html
> 
> For context, the goal of this series is to substitute the BQL for the
> per-CPU locks in many places, notably the execution loop in cpus.c.
> This leads to better scalability for MTTCG, since CPUs don't have
> to acquire a contended global lock (the BQL) every time they
> stop executing code.
> 
> See the last commit for some performance numbers.
> 
> After this series, the remaining obstacles to achieving KVM-like
> scalability in MTTCG are: (1) interrupt handling, which
> in some targets requires the BQL, and (2) frequent execution of
> "async safe" work.
> That said, some targets scale great on MTTCG even before this
> series -- for instance, when running a parallel compilation job
> in an x86_64 guest, scalability is comparable to what we get with
> KVM.
> 
> This series is very long. If you only have time to look at a few patches,
> I suggest the following, which do most of the heavy lifting and
> have not yet been reviewed:
> 
> - Patch 7: cpu: make per-CPU locks an alias of the BQL in TCG rr mode
> - Patch 70: cpu: protect CPU state with cpu->lock instead of the BQL
> 
> I've tested all patches with `make check-qtest -j' for all targets.
> The series is checkpatch-clean (just some warnings about __COVERITY__).
> 
> You can fetch the series from:
>   https://github.com/cota/qemu/tree/cpu-lock-v6

Thanks for the patience.  Both Alex and I have now completed review, and I
think this is ready for merge.

There are some patch conflicts with master, so if you can fix those and post a
v7, we'll get it merged right away.


r~
