Received: from eggs.gnu.org ([2001:4830:134:3::10]:46281)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cytcU-00018y-4E
	for qemu-devel@nongnu.org; Fri, 14 Apr 2017 01:18:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cytcT-0002y0-1M
	for qemu-devel@nongnu.org; Fri, 14 Apr 2017 01:18:06 -0400
References: <1491959850-30756-1-git-send-email-cota@braap.org>
	<1491959850-30756-10-git-send-email-cota@braap.org>
	<2ede0852-6888-8bcb-ac5a-363478841bc7@redhat.com>
	<20170413014646.GA1474@flamenco>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <df0a4da6-4f3e-3b44-ebbc-988017e29246@redhat.com>
Date: Fri, 14 Apr 2017 13:17:47 +0800
MIME-Version: 1.0
In-Reply-To: <20170413014646.GA1474@flamenco>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 09/10] target/i386: optimize indirect
 branches with TCG's jr op
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Claudio Fontana <claudio.fontana@huawei.com>, Andrzej Zaborowski <balrogg@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>, Alexander Graf <agraf@suse.de>, Stefan Weil <sw@weilnetz.de>, qemu-arm@nongnu.org, alex.bennee@linaro.org, Pranith Kumar <bobby.prani+qemu@gmail.com>


> Any other instructions I should look into? Perhaps lret/lret im?

Possibly (for completeness), but they are extremely rare in 32- and
64-bit code.

You also didn't cover any of syscall/sysret and sysenter/sysexit in your
patch, which would be on a relatively slow path but not _that_ slow.
But that probably should be a separate patch, moving the env->eip
assignment from seg_helper.c to translate.c and using the resulting TCGv
as the argument for jr.

Paolo

> Anyway, nbench does not improve much with the above. The reason seems t=
o be
> that it's full of direct jumps (visible with -d in_asm). Also tried sof=
tmmu
> to see whether these jumps are in-page or not: peak improvement is ~8%,=
 so
> I guess most of them are in-page. See http://imgur.com/EKRrYUz
>=20
> I'm running new tests on a server with no other users and which has
> frequency scaling disabled. This should help get less noisy numbers,
> since I'm having trouble replicating my own results :> (I used my deskt=
op
> machine until now). Will post these numbers tomorrow (running overnight
> SPECint both train and set sizes).
>=20
> Thanks,
>=20
> 		Emilio
>=20
