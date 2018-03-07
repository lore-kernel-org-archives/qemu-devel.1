Received: from eggs.gnu.org ([2001:4830:134:3::10]:40089)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1etetu-0003SF-5E
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 14:38:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1etetq-0004YO-3B
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 14:38:58 -0500
Received: from mail-co1nam03on0042.outbound.protection.outlook.com
	([104.47.40.42]:18560
	helo=NAM03-CO1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1etetp-0004Xr-NY
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 14:38:54 -0500
References: <20180307165038.88640-1-brijesh.singh@amd.com>
	<20180307165038.88640-22-brijesh.singh@amd.com>
	<20180307172703.GH3089@work-vm>
	<6b8bf293-4a3c-5832-8617-a2b957f97a83@amd.com>
	<20180307182409.GI3089@work-vm>
From: Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <7b76c3ca-dc35-8bea-2513-7b4da262c91d@amd.com>
Date: Wed, 7 Mar 2018 13:38:45 -0600
MIME-Version: 1.0
In-Reply-To: <20180307182409.GI3089@work-vm>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v11 21/28] sev/i386: add debug encrypt and
 decrypt commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: brijesh.singh@amd.com, qemu-devel@nongnu.org, Alistair Francis <alistair.francis@xilinx.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, "Daniel P . Berrange" <berrange@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>, Eduardo Habkost <ehabkost@redhat.com>, Eric Blake <eblake@redhat.com>, kvm@vger.kernel.org, Marcel Apfelbaum <marcel@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>, Thomas Lendacky <Thomas.Lendacky@amd.com>, Borislav Petkov <bp@suse.de>, Alexander Graf <agraf@suse.de>, Bruce Rogers <brogers@suse.com>, Richard Henderson <rth@twiddle.net>



On 3/7/18 12:24 PM, Dr. David Alan Gilbert wrote:
> * Brijesh Singh (brijesh.singh@amd.com) wrote:
>>
>> On 03/07/2018 11:27 AM, Dr. David Alan Gilbert wrote:
>>
>> [...]
>>
>>>> +{
>>>> +    SEVState *s =3D (SEVState *)handle;
>>>> +
>>>> +    /* If policy does not allow debug then no need to register ops */
>>>> +    if (s->policy & SEV_POLICY_NODBG) {
>>>> +        return;
>>>> +    }
>>> So what happens if someone tries to use a gdb or monitor command when
>>> policy didn't allow debug?  Does it end up with an obvious error
>>> somehow?
>>>
>> In those cases caller will get encrypted bytes, leading to unintelligibl=
e
>> data. It can sometime translate into  obvious errors e.g caller tries to
>> walk guest pagtable and it gets garbage and will have trouble dumping th=
e
>> pgtables etc. Many times qemu calls ldphys_* functions to access the dat=
a it
>> may get tricky to report the errors.
> So would it make sense to have something like:
>
> sev_mem_cant_read(uint8_t *dst, const uint8_t *src, uint32_t len, MemTxAt=
trs attrs)
> {
>     error_report("SEV Guest policy does not allow debug access");
>
>     return -EPERM;
> }

In very early patches we had something similar but I was not sure=C2=A0 if
that was right thing. Any debug accesses were=C2=A0 printing ton of message=
s
and also in some case caller actually wants to dump the memory content
(e.g x /10gx 0x000).. what we should return in those cases ? In my
approach was if debug was not enabled then simply don't decrypt the
memory and provide the raw data.

There was some discussion to have very high level security policy which
may have attribute like debug=3Don|off, if debug is disabled then QEMU
monitor can display messages like debug not allowed to better inform user.


> void
> sev_set_debug_ops(void *handle, MemoryRegion *mr)
> {
>     SEVState *s =3D (SEVState *)handle;
>
>     /* If policy does not allow debug then no need to register ops */
>     if (s->policy & SEV_POLICY_NODBG) {
>         sev_ops.read =3D sev_mem_cant_read;
>         sev_ops.write =3D sev_mem_cant_write;
>     } else {
>         sev_ops.read =3D sev_mem_read;
>         sev_ops.write =3D sev_mem_write;
>     }
>
> Dave
>
>> -Brijesh
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
