Received: from eggs.gnu.org ([2001:4830:134:3::10]:51970)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cZaop-00050u-5F
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 05:10:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cZaoo-0002Ub-6W
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 05:10:15 -0500
Received: from mail-wj0-x235.google.com ([2a00:1450:400c:c01::235]:34567)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cZaoo-0002Ta-09
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 05:10:14 -0500
Received: by mail-wj0-x235.google.com with SMTP id uo9so223848wjc.1
	for <qemu-devel@nongnu.org>; Fri, 03 Feb 2017 02:10:13 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170201150553.9381-9-alex.bennee@linaro.org>
References: <20170201150553.9381-1-alex.bennee@linaro.org>
	<20170201150553.9381-9-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Feb 2017 10:09:52 +0000
Message-ID: <CAFEAcA95nduxcHy=Rxszqe3ONaO2pV69NesxJSWDLRLqujA23Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v9 08/25] tcg: drop global lock during TCG
 code execution
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: MTTCG Devel <mttcg@listserver.greensocs.com>, QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?B?S09OUkFEIEZyw6lkw6lyaWM=?= <fred.konrad@greensocs.com>, Alvise Rigo <a.rigo@virtualopensystems.com>, "Emilio G. Cota" <cota@braap.org>, Pranith Kumar <bobby.prani@gmail.com>, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, Mark Burton <mark.burton@greensocs.com>, Paolo Bonzini <pbonzini@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>, Fedorov Sergey <serge.fdrv@gmail.com>, Richard Henderson <rth@twiddle.net>, Bamvor Zhang Jian <bamvor.zhangjian@linaro.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, "open list:ARM cores" <qemu-arm@nongnu.org>, "open list:PowerPC" <qemu-ppc@nongnu.org>

On 1 February 2017 at 15:05, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
> From: Jan Kiszka <jan.kiszka@siemens.com>
>
> This finally allows TCG to benefit from the iothread introduction: Drop
> the global mutex while running pure TCG CPU code. Reacquire the lock
> when entering MMIO or PIO emulation, or when leaving the TCG loop.
>
> We have to revert a few optimization for the current TCG threading
> model, namely kicking the TCG thread in qemu_mutex_lock_iothread and not
> kicking it in qemu_cpu_kick. We also need to disable RAM block
> reordering until we have a more efficient locking mechanism at hand.
>
> Still, a Linux x86 UP guest and my Musicpal ARM model boot fine here.
> These numbers demonstrate where we gain something:
>
> 20338 jan       20   0  331m  75m 6904 R   99  0.9   0:50.95 qemu-system-=
arm
> 20337 jan       20   0  331m  75m 6904 S   20  0.9   0:26.50 qemu-system-=
arm
>
> The guest CPU was fully loaded, but the iothread could still run mostly
> independent on a second core. Without the patch we don't get beyond
>
> 32206 jan       20   0  330m  73m 7036 R   82  0.9   1:06.00 qemu-system-=
arm
> 32204 jan       20   0  330m  73m 7036 S   21  0.9   0:17.03 qemu-system-=
arm
>
> We don't benefit significantly, though, when the guest is not fully
> loading a host CPU.
>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> Message-Id: <1439220437-23957-10-git-send-email-fred.konrad@greensocs.com=
>
> [FK: Rebase, fix qemu_devices_reset deadlock, rm address_space_* mutex]
> Signed-off-by: KONRAD Frederic <fred.konrad@greensocs.com>
> [EGC: fixed iothread lock for cpu-exec IRQ handling]
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> [AJB: -smp single-threaded fix, clean commit msg, BQL fixes]
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Reviewed-by: Richard Henderson <rth@twiddle.net>
> Reviewed-by: Pranith Kumar <bobby.prani@gmail.com>

target/arm changes:
Acked-by: Peter Maydell <peter.maydell@linaro.org>

-- PMM
