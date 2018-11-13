Received: from eggs.gnu.org ([2001:4830:134:3::10]:57130)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liran.alon@oracle.com>) id 1gMMFR-0000e8-AD
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 19:08:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liran.alon@oracle.com>) id 1gMM8N-00041d-7f
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 19:00:51 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:37386)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liran.alon@oracle.com>)
	id 1gMM8G-00040L-QS
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 19:00:43 -0500
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.1 \(3445.4.7\))
From: Liran Alon <liran.alon@oracle.com>
In-Reply-To: <20181112165437.GW3602@redhat.com>
Date: Tue, 13 Nov 2018 02:00:22 +0200
Content-Transfer-Encoding: quoted-printable
Message-Id: <04AB82C1-F0AC-4BDB-A132-D39A49EA0A9A@oracle.com>
References: <CALMp9eQ5zWxb2N9fyYz=WcQshwk0L6qQ4D6L6+p_dzMo4H=txA@mail.gmail.com>
	<20181102034649.43559-1-liran.alon@oracle.com>
	<12c26c34-8dd1-a442-7826-86b93ff978f8@redhat.com>
	<20181102165409.GF21191@redhat.com>
	<f58da4e8-aa40-2659-8db6-42c2b47f5b2f@redhat.com>
	<20181112161829.GU3602@redhat.com> <20181112165053.GF2293@work-vm>
	<20181112165437.GW3602@redhat.com>
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
To: =?utf-8?B?IkRhbmllbCBQLiBCZXJyYW5nw6ki?= <berrange@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, jmattson@google.com, ehabkost@redhat.com, kvm@vger.kernel.org, mtosatti@redhat.com, qemu-devel@nongnu.org, rth@twiddle.net



> On 12 Nov 2018, at 18:54, Daniel P. Berrang=C3=A9 =
<berrange@redhat.com> wrote:
>=20
> On Mon, Nov 12, 2018 at 04:50:54PM +0000, Dr. David Alan Gilbert =
wrote:
>> * Daniel P. Berrang=C3=A9 (berrange@redhat.com) wrote:
>>> On Sun, Nov 04, 2018 at 11:19:57PM +0100, Paolo Bonzini wrote:
>>>> On 02/11/2018 17:54, Daniel P. Berrang=C3=A9 wrote:
>>>>> We have usually followed a rule that new machine types must not
>>>>> affect runability of a VM on a host. IOW new machine types should
>>>>> not introduce dependancies on specific kernels, or hardware =
features
>>>>> such as CPU flags.
>>>>=20
>>>>> Anything that requires a new kernel feature thus ought to be an
>>>>> opt-in config tunable on the CLI, separate from machine type
>>>>> choice.
>>>>=20
>>>> Unless someone tinkered with the module parameters, they could not =
even
>>>> use nested virtualization before 4.20.  So for everyone else, "-cpu
>>>> ...,+vmx" does count as an "opt-in config tunable on the CLI" that
>>>> requires 4.20.
>>>>=20
>>>> For those that did tinker with module parameters, we can =
grandfather in
>>>> the old machine types, so that they can use nested virtualization =
with
>>>> no live migration support.  For those that did not, however, I =
don't
>>>> think it makes sense to say "oh by the way I really want to be able =
to
>>>> migrate this VM" on the command line, or even worse on the monitor.
>>>=20
>>> IIUC, 4.20 is only required from POV of migration state. Is it thus
>>> possible to just register a migration blocker if QEMU is launched
>>> on a host with kernel < 4.20.
>>>=20
>>> Migration has always been busted historically, so those people using
>>> nested VMX already won't be hurt by not having ability to live =
migrate
>>> their VM, but could otherwise continue using them without being =
forced
>>> to upgrade their kernel to fix a feature they're not even using.
>>=20
>> Yes, although I am a bit worried we might have a population of users
>> that:
>>   a) Have enabled nesting
>>   b) Run VMs with vmx enabled
>=20
>=20
>>   c) Don't normally actually run nested guests
>>   d) Currently happily migrate.
>=20
> True, and (b) would include anyone using libvirt's  host-model CPU. So =
if
> you enabled nesting, have host-model for all guests, but only use =
nesting
> in one of the guests, you'd be doomed.
>=20
> Is it possible for QEMU to determine if there are nested guests =
running or
> not and conditionally block migration appropriately to ensure safety ?


Only if kernel supports KVM_CAP_NESTED_STATE.
See my reply to Dave in this thread.

-Liran

>=20
>=20
> Regards,
> Daniel
> --=20
> |: =
https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__berrange.com&d=3DDw=
IDaQ&c=3DRoP1YumCXCgaWHvlZYR8PZh8Bv7qIrMUB65eapI_JnE&r=3DJk6Q8nNzkQ6LJ6g42=
qARkg6ryIDGQr-yKXPNGZbpTx0&m=3DeMOrT-7t7-tfRtTw2da9c1YTU0_tOFfkVIhj9mWv-Pc=
&s=3DDIzWfmRGWO1b6hzL9NRbIt41fiFcnPt0MC8917u4Qv0&e=3D      -o-    =
https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__www.flickr.com_phot=
os_dberrange&d=3DDwIDaQ&c=3DRoP1YumCXCgaWHvlZYR8PZh8Bv7qIrMUB65eapI_JnE&r=3D=
Jk6Q8nNzkQ6LJ6g42qARkg6ryIDGQr-yKXPNGZbpTx0&m=3DeMOrT-7t7-tfRtTw2da9c1YTU0=
_tOFfkVIhj9mWv-Pc&s=3DCjA-joyt2Y9t5B4YzIiupfY8EEO58m4vbmnd45adzFI&e=3D =
:|
> |: =
https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__libvirt.org&d=3DDwI=
DaQ&c=3DRoP1YumCXCgaWHvlZYR8PZh8Bv7qIrMUB65eapI_JnE&r=3DJk6Q8nNzkQ6LJ6g42q=
ARkg6ryIDGQr-yKXPNGZbpTx0&m=3DeMOrT-7t7-tfRtTw2da9c1YTU0_tOFfkVIhj9mWv-Pc&=
s=3DtD05tikOHMJhh_EeZ2Esoxb0oku3MPFmj-S2YHdUGm0&e=3D         -o-         =
   =
https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__fstop138.berrange.c=
om&d=3DDwIDaQ&c=3DRoP1YumCXCgaWHvlZYR8PZh8Bv7qIrMUB65eapI_JnE&r=3DJk6Q8nNz=
kQ6LJ6g42qARkg6ryIDGQr-yKXPNGZbpTx0&m=3DeMOrT-7t7-tfRtTw2da9c1YTU0_tOFfkVI=
hj9mWv-Pc&s=3DYAh1WAoXQKEB6hkMmG6ZnJQETOFnq6eqQLmJokME80A&e=3D :|
> |: =
https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__entangle-2Dphoto.or=
g&d=3DDwIDaQ&c=3DRoP1YumCXCgaWHvlZYR8PZh8Bv7qIrMUB65eapI_JnE&r=3DJk6Q8nNzk=
Q6LJ6g42qARkg6ryIDGQr-yKXPNGZbpTx0&m=3DeMOrT-7t7-tfRtTw2da9c1YTU0_tOFfkVIh=
j9mWv-Pc&s=3D90Mm1Qb-SHe8P63xwGp6gzMU1I5DEW6YX0ttG6TL_7g&e=3D    -o-    =
https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__www.instagram.com_d=
berrange&d=3DDwIDaQ&c=3DRoP1YumCXCgaWHvlZYR8PZh8Bv7qIrMUB65eapI_JnE&r=3DJk=
6Q8nNzkQ6LJ6g42qARkg6ryIDGQr-yKXPNGZbpTx0&m=3DeMOrT-7t7-tfRtTw2da9c1YTU0_t=
OFfkVIhj9mWv-Pc&s=3Dl4NrrDdRzPClvYQdxQdfIW0geHPWcukeyOGX8QapwYA&e=3D :|
