Received: from eggs.gnu.org ([2001:4830:134:3::10]:50684)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dRzh2-0002xq-UE
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 07:39:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dRzgy-0003Sh-1J
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 07:39:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57306)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dRzgx-0003S5-OP
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 07:38:59 -0400
References: <20170627161032.5014-1-david@redhat.com>
	<251b8047-7df4-50a5-cce7-b66858c781a1@redhat.com>
	<4c7a78bc-ec7f-9873-0bda-f3c8e76c844b@redhat.com>
	<3373125e-171a-0516-90f0-757d60eba32a@redhat.com>
	<449afc6c-1fbc-9ae9-8450-9c9a9e67f2c8@twiddle.net>
	<266c6260-cc9a-b765-6988-62c7e5777ce1@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <7dbfb58e-0c68-5b69-3d35-5ad79b874530@redhat.com>
Date: Mon, 3 Jul 2017 13:38:56 +0200
MIME-Version: 1.0
In-Reply-To: <266c6260-cc9a-b765-6988-62c7e5777ce1@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1] s390x/cpumodel: allow to enable "idtes"
 feature for TCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org
Cc: agraf@suse.de, Aurelien Jarno <aurelien@aurel32.net>

On 03.07.2017 13:07, Thomas Huth wrote:
> On 30.06.2017 21:22, Richard Henderson wrote:
>> On 06/29/2017 12:05 AM, Thomas Huth wrote:
>>> However, I'm not sure whether you can simply ignore the clearing-by-A=
SCE
>>> stuff in this case. For example, according to the PoP:
>>>
>>> "When the clearing-by-ASCE-option bit (bit 52 of gen-
>>>   eral register R2 is one), the M4 field is ignored."
>>>
>>> And the idte helper function currently always takes the M4 field into
>>> account...
>>
>> I don't see that quote.
>=20
> Which version of the Principles of Operation are you using? I just
> checked, and that sentence seems to be available in version SA22-7832-1=
0
> (but it is not in SA22-7832-09 yet).
>=20
>  Thomas
>=20
>=20

I think that part of the PoP is quite confusing.


"When the local-TLB-clearing facility is not installed [...]
the term =E2=80=9C__specified__ CPU or CPUs=E2=80=9D means all of the CPU=
s in the
configuration."

"When the local-TLB-clearing facility is installed [...]
the term =E2=80=9C__specified__ CPU or CPUs=E2=80=9D means only the CPU
executing the IDTE instruction (the local CPU)."

"When the clearing-by-ASCE-option bit, bit 52 of gen-
eral register R2, is zero [...] in the
__specified__ CPU or CPUs in the configuration are
cleared of (1) all TLB table entries of the designated [...]"

"When the clearing-by-ASCE-option bit is one [...]
but it does clear, from the TLBs in __all__ CPUs in the [...]"


So one could assume, that local-tlb-clearing does not apply to
clearing-by-ASCE-option. However:

"When bit 52 of general register R2, the clearing-by-
ASCE-option bit, is one, the clearing-by-ASCE oper-
ation is specified. [...] The TLBs of the __specified__ CPU or CPUs in
the configuration [...]"


But:

"When the clearing-by-ASCE-option bit (bit 52 of gen-
eral register R2 is one), the M4 field is ignored."

However also "Common Operation" section rather reads like
local-TLB-clearing applies to any mode.

Also the description of local-TLB-clearing is quite general:

"Local-TLB-Clearing Facility
The local-TLB-clearing facility may be available on a
model implementing z/Architecture. The facility may
provide performance improvements for the INVALI-
DATE DAT TABLE ENTRY and INVALIDATE PAGE
TABLE ENTRY instructions by allowing the program
to specify whether TLB clearing should be done in all
CPUs of the configuration or only in the CPU execut-
ing the instruction."


My interpretation:

local-TLB-clearing was introduced after IDTES but before EDAT2 (M4 bit
2). I think "m4 is ignored" should rather mean "M4 bit 2 is ignored".
Especially as this sentence was added later, I assume it is connected to
EDAT2, not local-TLB-clearing.


For now (!SMP) it should really matter. Opinions?


--=20

Thanks,

David
