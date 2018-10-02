Received: from eggs.gnu.org ([2001:4830:134:3::10]:43770)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1g7GVm-0001sZ-LY
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 04:58:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1g7GVj-000394-EU
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 04:58:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38200)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1g7GVj-00038f-6l
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 04:58:31 -0400
References: <CAFEAcA-T7-PcKLwPr0VO0wrwW3x+w2WbdEjTjN2YfWOmZXyfUg@mail.gmail.com>
	<87lg7hlend.fsf@linaro.org>
	<CAFEAcA8ZW_rDyUg0G+agmBfNc8dNVc7r1pdu-Tyb6cvLXdvzHw@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <021f3f1e-e767-8d84-0189-fbfa7ca5f143@redhat.com>
Date: Tue, 2 Oct 2018 10:58:26 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8ZW_rDyUg0G+agmBfNc8dNVc7r1pdu-Tyb6cvLXdvzHw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] racing between pause_all_vcpus() and
 qemu_cpu_stop()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>, "Emilio G. Cota" <cota@braap.org>

On 02/10/2018 10:01, Peter Maydell wrote:
> On 1 October 2018 at 19:12, Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>> I would have thought the reset code should be scheduled via safe async
>> work to run in the vCPU context. Why should the main loop get involved
>> at all here?
> The reset code is much older than the safe-async support for
> running things in the vCPU context... Also, does the safe
> async support work with KVM/HAX/Hypervisor.Framework? The
> reset code has to handle all those, not just TCG.
>=20
> Plus, which vCPU thread would you use? We're resetting
> the entire system, so privileging an arbitrary vCPU
> thread to do that doesn't seem any less odd than using
> the main loop thread.

I think there's two parts in this.

First, the reset code should indeed use run_on_cpu (it need not be safe
i.e. stop-the-world; just run it in the vCPU thread).  It certainly
doesn't do this right now.

Second, when run_on_cpu's callback runs we should make sure that
cpu_can_run() is false.  I think that's already the case, but it's worth
asserting.

Paolo
