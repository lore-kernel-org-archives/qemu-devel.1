Received: from eggs.gnu.org ([209.51.188.92]:51641)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1glrlE-0006uD-JM
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 03:50:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1glrl8-0005js-U4
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 03:50:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41198)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1glrl8-0005iu-Ga
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 03:50:14 -0500
References: <000601d4b222$323d0900$96b71b00$@ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <bf5401c8-20b3-6774-fd9e-56ffe25e7431@redhat.com>
Date: Tue, 22 Jan 2019 09:49:58 +0100
MIME-Version: 1.0
In-Reply-To: <000601d4b222$323d0900$96b71b00$@ru>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Bottom halves VS timers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <dovgaluk@ispras.ru>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, stefanha@redhat.com, famz@redhat.com, kwolf@redhat.com

On 22/01/19 08:15, Pavel Dovgalyuk wrote:
> Scheduling new BH does not create a signal for the vCPU to suspend the
> execution and process the main loop events (in record/replay we
> synchronize these two threads).

I think the bug is that in rr mode it should do so and cause a cpu_exit.
 If replace these bottom halves with timers, other bottom halves from
the block layer may have the same issue; if you replace _all_ bottom
halves with timers you have performance issues because bottom halves try
very hard to avoid locks.

Unfortunately this is getting really ugly...  Basically, rr is
reintroducing all the complications with iothread_requesting_mutex that
were removed with mtTCG.

Paolo

> Therefore vCPU may execute 10000000 instruction until BH processing and
> the guest
> software may get a timeout.
>=20
