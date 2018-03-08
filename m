Received: from eggs.gnu.org ([2001:4830:134:3::10]:52715)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1eu3wR-0001hi-VC
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 17:23:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1eu3wM-0004ZA-Vl
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 17:23:15 -0500
Received: from mail-sn1nam02on0061.outbound.protection.outlook.com
	([104.47.36.61]:2913
	helo=NAM02-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1eu3wM-0004Xb-L8
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 17:23:10 -0500
References: <20180308124901.83533-1-brijesh.singh@amd.com>
	<20180308124901.83533-9-brijesh.singh@amd.com>
	<20180308164910.GF4718@redhat.com>
From: Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <e39191c3-9c83-8c44-f1d2-9fa7a2f7695d@amd.com>
Date: Thu, 8 Mar 2018 16:22:52 -0600
MIME-Version: 1.0
In-Reply-To: <20180308164910.GF4718@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v12 08/28] target/i386: add Secure
 Encrypted Virtulization (SEV) object
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>
Cc: brijesh.singh@amd.com, qemu-devel@nongnu.org, Alistair Francis <alistair.francis@xilinx.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>, Eduardo Habkost <ehabkost@redhat.com>, Eric Blake <eblake@redhat.com>, kvm@vger.kernel.org, Marcel Apfelbaum <marcel@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>, Thomas Lendacky <Thomas.Lendacky@amd.com>, Borislav Petkov <bp@suse.de>, Alexander Graf <agraf@suse.de>, Bruce Rogers <brogers@suse.com>, Richard Henderson <rth@twiddle.net>



On 3/8/18 10:49 AM, Daniel P. Berrang=C3=A9 wrote:
> On Thu, Mar 08, 2018 at 06:48:41AM -0600, Brijesh Singh wrote:
>> Add a new memory encryption object 'sev-guest'. The object will be used
>> to create enrypted VMs on AMD EPYC CPU. The object provides the properti=
es
>> to pass guest owner's public Diffie-hellman key, guest policy and sessio=
n
>> information required to create the memory encryption context within the
>> SEV firmware.
>>
>> e.g to launch SEV guest
>>  # $QEMU \
>>     -object sev-guest,id=3Dsev0 \
>>     -machine ....,memory-encryption=3Dsev0
>>
>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>> Cc: Richard Henderson <rth@twiddle.net>
>> Cc: Eduardo Habkost <ehabkost@redhat.com>
>> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
>
>> diff --git a/qemu-options.hx b/qemu-options.hx
>> index 4c280142c52c..6113bce08a8c 100644
>> --- a/qemu-options.hx
>> +++ b/qemu-options.hx
>> @@ -4353,6 +4353,50 @@ contents of @code{iv.b64} to the second secret
>>           data=3D$SECRET,iv=3D$(<iv.b64)
>>  @end example
>> =20
>> +@item -object sev-guest,id=3D@var{id},cbitpos=3D@var{cbitpos},reduced-p=
hys-bits=3D@var{val},[sev-device=3D@var{string},policy=3D@var{policy},handl=
e=3D@var{handle},dh-cert-file=3D@var{file},session-file=3D@var{file}]
>> +
>> +Create a Secure Encrypted Virtualization (SEV) guest object, which can =
be used
>> +to provide the guest memory encryption support on AMD processors.
>> +
>> +When memory encryption is enabled, one of the physical address bit (aka=
 the
>> +C-bit) is utilized to mark if a memory page is protected. The @option{c=
bitpos}
>> +is used to provide the C-bit position. The C-bit position is Host famil=
y dependent
>> +hence user must provide this value. On EPYC, the value should be 47.
>> +
>> +When memory encryption is enabled, we loose certain bits in physical ad=
dress space.
>> +The @option{reduced-phys-bits} is used to provide the number of bits we=
 loose in
>> +physical address space. Similar to C-bit, the value is Host family depe=
ndent.
>> +On EPYC, the value should be 5.
> Is it valid to specify a different value for either of these properties ?
> eg what happens if I pass cbitpos=3D45 instead of 47 on an EPYC host ?

On EPYC, passing anything other than 47 will trigger error during SEV
guest initialization. The value of Cbit position is host dependent, the
value is readonly and can be obtained through the host CPUID.=C2=A0 The
cbitpos must be same between guest and host. Please note that the pte's
in guest page table will need to use the cbitpos=C2=A0 information to mark
the pages as encrypted. If cbit position given to the guest is different
from the host then guest will fail to execute.

>
> In particular I thinking about possible migration scenario, where EPYC
> uses 47 by default but some $NEXT AMD CPU uses 48 by default. In that
> case we might want to use '47' on both CPUs if we need ability to live
> migrate between different host CPU generations. Would that be valid ?

We will not be able to migrate SEV guests if cbit position does not
match between the source and destination hosts. Since during migration,
the destination guest is launched with same QEMU cli as source hence
cbitpos check in QEMU will catch it and fail the new launch. Optionally,
user can call query-sev-capabilities on both source and destination to
see if cbitpos is compatible before attempting to migrate the guest.

> On the flip side, if the value really it strictly tied to the host
> CPU family and no deviation is permitted, could the kernel not just
> pick the right value automatically avoiding the config option ?
>

I think doing so will be an issue for the migration. Consider your above
use case, a SEV guest is running on EPYC with cbitpos=3D47 and if we
migrate to some $NEXT AMD CPU which uses need to use cbitpos=3D48 and we
will fail to resume the guest on destination after migrating.

>
> Regards,
> Daniel
