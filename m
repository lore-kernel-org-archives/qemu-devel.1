Received: from eggs.gnu.org ([2001:4830:134:3::10]:35987)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gJQkZ-0007uS-3M
	for qemu-devel@nongnu.org; Sun, 04 Nov 2018 17:20:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gJQkW-00040j-07
	for qemu-devel@nongnu.org; Sun, 04 Nov 2018 17:20:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:3798)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gJQkV-0003zP-OI
	for qemu-devel@nongnu.org; Sun, 04 Nov 2018 17:20:03 -0500
References: <CALMp9eQ5zWxb2N9fyYz=WcQshwk0L6qQ4D6L6+p_dzMo4H=txA@mail.gmail.com>
	<20181102034649.43559-1-liran.alon@oracle.com>
	<12c26c34-8dd1-a442-7826-86b93ff978f8@redhat.com>
	<20181102165409.GF21191@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f58da4e8-aa40-2659-8db6-42c2b47f5b2f@redhat.com>
Date: Sun, 4 Nov 2018 23:19:57 +0100
MIME-Version: 1.0
In-Reply-To: <20181102165409.GF21191@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [QEMU PATCH v2 0/2]: KVM: i386: Add support for
 save and restore nested state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Cc: Liran Alon <liran.alon@oracle.com>, jmattson@google.com, ehabkost@redhat.com, kvm@vger.kernel.org, mtosatti@redhat.com, qemu-devel@nongnu.org, dgilbert@redhat.com, rth@twiddle.net

On 02/11/2018 17:54, Daniel P. Berrang=C3=A9 wrote:
> We have usually followed a rule that new machine types must not
> affect runability of a VM on a host. IOW new machine types should
> not introduce dependancies on specific kernels, or hardware features
> such as CPU flags.

> Anything that requires a new kernel feature thus ought to be an
> opt-in config tunable on the CLI, separate from machine type
> choice.

Unless someone tinkered with the module parameters, they could not even
use nested virtualization before 4.20.  So for everyone else, "-cpu
...,+vmx" does count as an "opt-in config tunable on the CLI" that
requires 4.20.

For those that did tinker with module parameters, we can grandfather in
the old machine types, so that they can use nested virtualization with
no live migration support.  For those that did not, however, I don't
think it makes sense to say "oh by the way I really want to be able to
migrate this VM" on the command line, or even worse on the monitor.

Paolo

> Alternatively in this case, it could potentially be a
> migration parameter settable via QMP. QEMU on each side could
> advertize whether the migration parameter is available, and
> the mgmt app (which can see both sides of the migration) can
> then decide whether to enable it.
