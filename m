Received: from eggs.gnu.org ([2001:4830:134:3::10]:40113)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cvlbn-0006S9-GJ
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 10:08:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cvlbh-0003uK-Tu
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 10:08:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49144)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cvlbh-0003tD-OM
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 10:08:21 -0400
References: <20170405132503.32125-1-alex.bennee@linaro.org>
	<20170405132503.32125-10-alex.bennee@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3f66fd3e-c66c-c4aa-ed6f-eee1ba34a932@redhat.com>
Date: Wed, 5 Apr 2017 16:08:16 +0200
MIME-Version: 1.0
In-Reply-To: <20170405132503.32125-10-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 09/12] cpus: introduce cpu_update_icount
 helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, dovgaluk@ispras.ru, rth@twiddle.net
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, mttcg@greensocs.com, fred.konrad@greensocs.com, a.rigo@virtualopensystems.com, cota@braap.org, bobby.prani@gmail.com, nikunj@linux.vnet.ibm.com, Peter Crosthwaite <crosthwaite.peter@gmail.com>



On 05/04/2017 15:25, Alex Benn=C3=A9e wrote:
> +{
> +    int64_t executed =3D cpu_get_icount_executed(cpu);
> +    cpu->icount_budget -=3D executed;
> +    atomic_add(&timers_state.qemu_icount, executed);
> +}

Since there's only one writer, it's also okay to do

	atomic_set(&timers_state.qemu_icount,
		   atomic_read(&timers_state.qemu_icount) + executed);

(also not just faster, but also simpler to turn into TCG code if we do
the update in gen_io_start).

Paolo
