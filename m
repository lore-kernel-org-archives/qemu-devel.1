Received: from eggs.gnu.org ([2001:4830:134:3::10]:60500)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d6ex7-0005hR-Pa
	for qemu-devel@nongnu.org; Fri, 05 May 2017 11:15:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d6ex2-0006dR-An
	for qemu-devel@nongnu.org; Fri, 05 May 2017 11:15:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39030)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1d6ex2-0006dD-4R
	for qemu-devel@nongnu.org; Fri, 05 May 2017 11:15:24 -0400
References: <20170505103822.20641-1-alex.bennee@linaro.org>
	<20170505103822.20641-4-alex.bennee@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8b648c73-ecfc-7a13-fc98-be349dcfceac@redhat.com>
Date: Fri, 5 May 2017 17:15:19 +0200
MIME-Version: 1.0
In-Reply-To: <20170505103822.20641-4-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH v1 3/9] cpus: only take BQL for
 sleeping threads
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, boost.lists@gmail.com, pavel.dovgaluk@ispras.ru
Cc: cota@braap.org, qemu-devel@nongnu.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>



On 05/05/2017 12:38, Alex Benn=C3=A9e wrote:
> =20
>      while (qemu_tcg_should_sleep(cpu)) {
> +        qemu_mutex_lock_iothread();
>          stop_tcg_kick_timer();
>          qemu_cond_wait(cpu->halt_cond, &qemu_global_mutex);
> +        qemu_mutex_unlock_iothread();
>      }

This is racy.  You need to recheck the condition under the lock, or to
switch from QemuCond to QemuEvent (then you still need to check the
condition twice, the second between qemu_event_reset and qemu_event_wait)=
.

Paolo
