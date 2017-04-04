Received: from eggs.gnu.org ([2001:4830:134:3::10]:51158)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cvLSr-0007pt-TP
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 06:13:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cvLSo-0005sx-D2
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 06:13:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48340)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cvLSo-0005sB-7a
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 06:13:26 -0400
References: <20170403124524.10824-1-alex.bennee@linaro.org>
	<20170403124524.10824-9-alex.bennee@linaro.org>
	<000101d2ad05$9de02580$d9a07080$@ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <66e3fcfe-6caf-bcbb-cb4e-33d2485c6fb8@redhat.com>
Date: Tue, 4 Apr 2017 12:13:16 +0200
MIME-Version: 1.0
In-Reply-To: <000101d2ad05$9de02580$d9a07080$@ru>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH v1 8/9] cpus: don't credit executed
 instructions before they have run
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <dovgaluk@ispras.ru>, =?UTF-8?Q?'Alex_Benn=c3=a9e'?= <alex.bennee@linaro.org>, rth@twiddle.net
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, mttcg@greensocs.com, fred.konrad@greensocs.com, a.rigo@virtualopensystems.com, cota@braap.org, bobby.prani@gmail.com, nikunj@linux.vnet.ibm.com, 'Peter Crosthwaite' <crosthwaite.peter@gmail.com>



On 04/04/2017 07:37, Pavel Dovgalyuk wrote:
>> -        icount -=3D (cpu->icount_decr.u16.low + cpu->icount_extra);
>> +        /* Take into account what has run */
>> +        icount +=3D cpu_get_icount_executed(cpu);
>>      }
>>      return icount;
> As far, as I understand, this one will return the same value in iothrea=
d
> until vCPU thread finishes cpu_exec?
> This value will not jump forward and backward, but still will not allow
> making execution deterministic.
>=20
> Consider the following scenarios:
>=20
> First:
> vCPU            iothread
> access HW       ----
> ...             access HW in timer
>=20
> Second:
> vCPU            iothread
> ...             access HW in timer
> access HW       ----
>=20
> These scenarios will generate the same order of events in the log.
> Synchronization checkpoint in iothread will try to write already
> executed instructions, but it does not have access to current_cpu
> and the icount value will point to the "past" - it will have less
> instructions than already executed.

The actual access should be covered by a lock, but I think you're right
that the two threads can be nondeterministically off by one instruction,
even if we make gen_io_start update timers_state.qemu_icount atomically.

Paolo
