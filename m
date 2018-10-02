Received: from eggs.gnu.org ([2001:4830:134:3::10]:49627)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g7KPF-0008MX-4P
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 09:08:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g7KPA-0001nn-GW
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 09:08:03 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:37497)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1g7KPA-0001ng-Bk
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 09:08:00 -0400
Received: by mail-oi1-x241.google.com with SMTP id e17-v6so1427676oib.4
	for <qemu-devel@nongnu.org>; Tue, 02 Oct 2018 06:08:00 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <cover.1537868529.git.manish.jaggi@cavium.com>
References: <cover.1537868529.git.manish.jaggi@cavium.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 2 Oct 2018 14:07:38 +0100
Message-ID: <CAFEAcA-_5MzdykGKja1sJggx2QVOUXT69NF-Ya2sE8RZFu53fA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [RFC] [PATCH 0/3] qemu: arm: Migration between
 machines with different MIDR values
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mjaggi@caviumnetworks.com
Cc: "Jaggi, Manish" <Manish.Jaggi@cavium.com>, "quintela@redhat.com" <quintela@redhat.com>, "dgilbert@redhat.com" <dgilbert@redhat.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Nair,
	Jayachandran" <Jayachandran.Nair@cavium.com>, "Nowicki, Tomasz" <Tomasz.Nowicki@cavium.com>

On 27 September 2018 at 02:13,  <mjaggi@caviumnetworks.com> wrote:
> From: Manish Jaggi <manish.jaggi@cavium.com>
>
> QEMU on arm systems use -machine virt -cpu host option for a VM.
> Migration thus is limited between machines with same cpu.
>
> This is a limitation if migration is desired between cpus which are of same
> family and have only few diferences like bug fixes which have no effect on
> VM operation. They just differ in say MIDR values.
>
> This patchset introduces a command line option -skipinvariant. Invariant
> registers will be skipped from being restored from guests context on migrated
> host.
>
> Mailing list discussion on this topic:
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg560043.html

Hi; thanks for this patch. The issue I see with this patch
is that the KVM/ARM QEMU approach to system registers so far
has been "the kernel knows about these and it is in control".
So we ask the kernel for the list of registers, and just save
and restore those. That would suggest that if there are sysregs
where it's OK in fact to ignore a difference between two constant
register values, it should be the kernel doing the "actually, this
mismatch is OK" behaviour...

For instance, it's probably OK to ignore a MIDR_EL1 difference
that just indicates a minor revision bump; but not to ignore
one that indicates you just tried to migrate a Cortex-A53
over to a Cavium CPU.

thanks
-- PMM
