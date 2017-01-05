Received: from eggs.gnu.org ([2001:4830:134:3::10]:42722)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cP8c5-00043p-JG
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 09:01:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cP8c1-0006eo-Hv
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 09:01:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43442)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cP8c1-0006ed-CX
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 09:01:49 -0500
References: <cover.1482164622.git.vpalatin@chromium.org>
	<85250fb0450b5b95232b39c82ab310a0632fd23f.1482164622.git.vpalatin@chromium.org>
	<fda5a694-d02f-269e-e155-1822276d74f6@redhat.com>
	<CAP_ceTxAn3tH-P8JjThXXeF7iYv5xFoVOzmjp5h8sHYsYzWTDQ@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <df2938db-dde1-633c-899d-646d62ec4780@redhat.com>
Date: Thu, 5 Jan 2017 15:01:45 +0100
MIME-Version: 1.0
In-Reply-To: <CAP_ceTxAn3tH-P8JjThXXeF7iYv5xFoVOzmjp5h8sHYsYzWTDQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 3/4] Plumb the HAXM-based hardware
 acceleration support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vincent Palatin <vpalatin@chromium.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, Yu Ning <yu.ning@linux.intel.com>, Stefan Weil <sw@weilnetz.de>, "Michael S . Tsirkin" <mst@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>



On 05/01/2017 14:50, Vincent Palatin wrote:
> Sorry I missed it.
> I move it to qemu_cpu_kick() as asked in the Darwin patch.
>=20
>> Apart from the above change, can you check if there are some less
>> heavyeight methods to force an exit?  I can think of QueueUserAPC with
>> an empty pfnAPC here, and SleepEx(0, TRUE) in qemu_hax_cpu_thread_fn
>> before qemu_wait_io_event_common.
>=20
> Actually I don't know a good test case to verify such a change, any adv=
ice ?

Try computing the latency between qemu_cpu_kick and the exit from HAXM.
That is, something like

    int64_t kick_time =3D -1;
    ...

    atomic_set(&kick_time, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL));

before SuspendThread or respectively QueueUserAPC, and

    extern volatile int64_t kick_time;
    ...

    int64_t kicked =3D atomic_xchg(&kick_time, -1);
    if (kicked !=3D -1) {
        printf("%lld\n",
               qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) - kicked);
    }

right after hax_vcpu_run.    As long as the printed values remain
smallish, it's okay.

If you don't get any output, passing "info cpus" repeatedly to the QEMU
monitor will force a kick.

Paolo
