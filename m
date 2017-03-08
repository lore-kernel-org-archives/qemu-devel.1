Received: from eggs.gnu.org ([2001:4830:134:3::10]:38814)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1clRTE-0001he-Pc
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 21:36:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1clRTB-0007kI-Gw
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 21:36:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33398)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1clRTB-0007k0-7h
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 21:36:53 -0500
References: <20170308001637.9838-1-git@kirschju.re>
From: Eric Blake <eblake@redhat.com>
Message-ID: <acb6dafc-ff73-9b59-22c0-aa5e8219e925@redhat.com>
Date: Tue, 7 Mar 2017 20:36:46 -0600
MIME-Version: 1.0
In-Reply-To: <20170308001637.9838-1-git@kirschju.re>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Im5jdvMb5Jm5WMbxfSS6Dc2sKEOGGItrQ"
Subject: Re: [Qemu-devel] [PATCH] X86/HMP: Expose x86 model specific
 registers via human monitor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Julian Kirsch <git@kirschju.re>, qemu-devel@nongnu.org
Cc: Julian Kirsch <mail@kirschju.re>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Im5jdvMb5Jm5WMbxfSS6Dc2sKEOGGItrQ
From: Eric Blake <eblake@redhat.com>
To: Julian Kirsch <git@kirschju.re>, qemu-devel@nongnu.org
Cc: Julian Kirsch <mail@kirschju.re>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Crosthwaite <crosthwaite.peter@gmail.com>,
 Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <acb6dafc-ff73-9b59-22c0-aa5e8219e925@redhat.com>
Subject: Re: [PATCH] X86/HMP: Expose x86 model specific registers via human
 monitor
References: <20170308001637.9838-1-git@kirschju.re>
In-Reply-To: <20170308001637.9838-1-git@kirschju.re>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/07/2017 06:16 PM, Julian Kirsch wrote:
> Provide read/write access to x86 model specific registers (MSRs) by mea=
ns of
> two new HMP commands "msr-list" and "msr-set". The rationale behind thi=
s
> is to improve introspection capabilities for system virtualization mode=
=2E
> For instance, many modern x86-64 operating systems maintain access to i=
nternal
> data structures via the MSR_GSBASE/MSR_KERNELGSBASE MSRs. Giving
> introspection utilities (such as a remotely attached gdb) a way of
> accessing these registers improves analysis results drastically.
>=20
> Signed-off-by: Julian Kirsch <git@kirschju.re>
> ---

I'm just focusing on the QMP interface portion of this.

Is any of this information...

> This patch moves the logic of the rdmsr and wrmsr functions to helper.c=
 and
> replaces their current versions in misc_helper.c with stubs calling the=
 new
> functions. The ordering of MSRs now loosely follows the ordering used i=
n the KVM
> module. As qemu operates on cached values in the CPUX86State struct, th=
e msr-set
> command is implemented in a hackish way: In order to force qemu to flus=
h the new
> values to KVM a call to cpu_synchronize_post_init is triggered, eventua=
lly
> ending up in calling kvm_put_msrs at KVM_PUT_FULL_STATE level. As MSR w=
rites
> could *still* be caught by the code logic in this function, the msr-set=
 function
> reads back the values written to determine whether the write was succes=
sful.
> This way, we don't have to duplicate the logic used in kvm_put_msrs (ha=
s_msr_XXX)
> to x86_cpu_wrmsr.
> There are several things I would like to pooint out about this patch:
>   - The "msr-list" command currently displays MSR values for all virtua=
l cpus.
>     This is somewhat inconsistent with "info registers" just displaying=
 the
>     value of the current default cpu. One might think about just displa=
ying the
>     current value and offer access to other CPU's MSRs by means of swit=
ching
>     between CPUs using the "cpu" monitor command.
>   - The new version of x86_cpu_rdmsr exposes MSRs that are arguably of
>     questionable help for any human / tool using the monitor. However I=
 merely
>     felt a deep urge to reflect the full MSR list from kvm.c when writi=
ng the
>     code.
>   - While the need for msr-list is evident (see commit msg), msr-set co=
uld be
>     used in more obscure cases. For instance, one might offer a way to =
access
>     and configure performance counter MSRs of the guest via the hmp. If=
 this
>     feels too much like an inacceptable hack, I'll happily drop the msr=
-set
>     part.

=2E..useful above the --- as part of the commit message?


> +++ b/qapi-schema.json
> @@ -2365,6 +2365,55 @@
>    'data': {'val': 'int', 'size': 'int', 'filename': 'str'} }
> =20
>  ##
> +# @MsrInfo:
> +#
> +# Information about a MSR
> +#
> +# @cpu_idx: CPU index
> +#
> +# @msr_idx: MSR index
> +#
> +# @value: MSR value
> +#
> +# Since: 2.8.1

You've missed 2.8 by a long shot; you've even missed soft freeze for
2.9.  This should be 2.10.

> +##
> +{ 'struct': 'MsrInfo',
> +  'data': {'cpu_idx': 'int', 'msr_idx': 'uint32', 'value': 'uint64'} }=


Please spell new members with '-' rather than '_', as in 'cpu-idx' (or
even spell it out as 'cpu-index') and 'msr-idx'.

> +
> +##
> +# @msr-list:
> +#
> +# Retrieve model specific registers (MSRs) on x86
> +#
> +# @msr_idx: MSR index to read
> +#
> +# Returns: A list of one MSR value per CPU, or nothing
> +#
> +# Since: 2.8.1

2.10

> +##
> +{ 'command': 'msr-list', 'returns': ['MsrInfo'],
> +  'data': {'msr_idx': 'uint32'} }

'msr-idx' (or even 'msr-index')

> +
> +##
> +# @msr-set:
> +#
> +# Set model specific registers (MSRs) on x86
> +#
> +# @cpu_idx: CPU holding the MSR that should be written
> +#
> +# @msr_idx: MSR index to write
> +#
> +# @value: Value to write
> +#
> +# Returns: Nothing on success

Useless Returns: line.

> +#
> +# Since: 2.8.1

2.10

> +##
> +{ 'command': 'msr-set',
> +  'data': {'cpu_idx': 'uint32', 'msr_idx': 'uint32', 'value': 'uint64'=
} }

again, dash instead of underscore


--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--Im5jdvMb5Jm5WMbxfSS6Dc2sKEOGGItrQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYv24/AAoJEKeha0olJ0NqWk0H/joz74QopZ3dG8h9WFa8C8F+
9gxFWgbNzaTXUSTMCpJAeL76OL6iJJEc28QVyltUBQblP3iN6TN79SGqQwg9WL8U
bTpAQmMSJ9BHJ1pMXViOrvk+TO7eGfAhOfQkW1+wx3RxeQScD2EtT7G92U+22Omz
wW5P8nO6FBqDL0tyogjofpOW5CY9LA7HdJ5tBmbUGKagSEoaDqioldEUYrcvGtDM
dLdrQ3hV7KFPTMUG9Sh0S1TXMLCwNbzyGN1v0GuFx4yHrWvP67tBv8sjtH3ruuYw
0p0AebQX8FDQzHEpWbTP2nOEbGy+KU0iHTn25rBQ/gUPLxUXfkH0Njzap2nnnDo=
=XtO6
-----END PGP SIGNATURE-----

--Im5jdvMb5Jm5WMbxfSS6Dc2sKEOGGItrQ--
