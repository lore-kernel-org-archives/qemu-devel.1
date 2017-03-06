Received: from eggs.gnu.org ([2001:4830:134:3::10]:54685)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cksbB-00039T-Ck
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 08:22:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cksb6-0006Ov-FZ
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 08:22:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46416)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cksb6-0006OV-9d
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 08:22:44 -0500
References: <20170302195337.31558-1-alex.bennee@linaro.org>
	<20170302195337.31558-7-alex.bennee@linaro.org>
	<2ff07353-5044-277a-4c39-48f86756443e@redhat.com>
	<87o9xeitrq.fsf@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <015f2aa4-0590-1d81-3aba-c179b7a238ea@redhat.com>
Date: Mon, 6 Mar 2017 14:22:38 +0100
MIME-Version: 1.0
In-Reply-To: <87o9xeitrq.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 06/11] sparc/sparc64: grab BQL before
 calling cpu_check_irqs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: peter.maydell@linaro.org, rth@twiddle.net, qemu-devel@nongnu.org, mttcg@greensocs.com, fred.konrad@greensocs.com, a.rigo@virtualopensystems.com, cota@braap.org, bobby.prani@gmail.com, nikunj@linux.vnet.ibm.com, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>



On 06/03/2017 11:28, Alex Benn=C3=A9e wrote:
>> This can be called from gdbstub, so you need to put the lock/unlock
>> around helper_wrpsr's call to cpu_put_psr instead.  Also please add a
>> comment /* Called with BQL held.  */ around cpu_put_psr.
>=20
> OK will do. I have to say its hard to see the gdbstub being under the
> BQL. Is this a feature of the packet handling being done in the main IO
> thread?

Yes.

It's probably nigh time to have stronger debug facilities for locks,
including changing our lock policy comments to optional assertions.

I'm even thinking of doing something like C++'s std::unique_lock, for
example

    // Takes a lock and unlocks it when the scope is left.
    // c++: std::lock_guard<std::mutex> sl(some_lock);
    QEMU_SCOPED_MUTEX(QemuMutex, some_lock) sl;


    // The lock is also unlocked correctly when the scope is left.
    // c++: std::unique_lock<std::mutex> sl(some_lock);
    QEMU_SCOPED_MUTEX(QemuMutex, some_lock) sl;
    ...
    for (;;) {
        qemu_scoped_mutex_unlock(&sl);
        if (foo) {
            break;
        }
        ...
        qemu_scoped_mutex_lock(&sl);
    }

    // The lock is taken later.
    // c++: std::unique_lock<std::mutex> sl(some_lock, std::defer_lock);
    QEMU_SCOPED_MUTEX_DEFER(QemuMutex, some_lock) sl;
    ...
    if (x) {
        qemu_scoped_mutex_lock(&sl);
    }

Paolo
