Received: from eggs.gnu.org ([2001:4830:134:3::10]:40831)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1dQAgi-0000Ps-Gd
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 06:59:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1dQAgd-0005qa-NC
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 06:59:12 -0400
References: <20170622112648.24815-1-lvivier@redhat.com>
	<caa25331-5005-78e8-fba2-19bf67116d92@redhat.com>
	<20170623092124.GG12089@umbus>
	<c0a0667e-8c60-a8e7-a041-caddac8c8b88@redhat.com>
	<20170628014231.GA791@pacoca>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <d9632cc5-f2de-1118-8942-9a9be3835ab7@redhat.com>
Date: Wed, 28 Jun 2017 12:59:03 +0200
MIME-Version: 1.0
In-Reply-To: <20170628014231.GA791@pacoca>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH] target/ppc/cpu-models: set
 POWER9_v1.0 as POWER9 DD1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: joserz@linux.vnet.ibm.com
Cc: David Gibson <david@gibson.dropbear.id.au>, Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On 28/06/2017 03:42, joserz@linux.vnet.ibm.com wrote:
> On Fri, Jun 23, 2017 at 04:10:55PM +0200, Laurent Vivier wrote:
>> On 23/06/2017 11:21, David Gibson wrote:
>>> On Thu, Jun 22, 2017 at 01:31:24PM +0200, Thomas Huth wrote:
>>>> On 22.06.2017 13:26, Laurent Vivier wrote:
>>>>> CPU_POWERPC_POWER9_DD1 is 0x004E0100, so this is the POWER9 v1.0.
>>>>>
>>>>> When we run qemu on a POWER9 DD1 host, we must use either
>>>>> "-cpu host" or "-cpu POWER9", but in the latter case it fails with
>>>>>
>>>>>     Unable to find sPAPR CPU Core definition
>>>>>
>>>>> because POWER9 DD1 doesn't appear in the list of known CPUs.
>>>>>
>>>>> This patch fixes this by defining POWER9_v1.0 with POWER9 DD1
>>>>> PVR instead of CPU_POWERPC_POWER9_BASE.
>>>>>
>>>>> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
>>>>> ---
>>>>>  target/ppc/cpu-models.c | 2 +-
>>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/target/ppc/cpu-models.c b/target/ppc/cpu-models.c
>>>>> index 4d3e635..a22363c 100644
>>>>> --- a/target/ppc/cpu-models.c
>>>>> +++ b/target/ppc/cpu-models.c
>>>>> @@ -1144,7 +1144,7 @@
>>>>>      POWERPC_DEF("970_v2.2",      CPU_POWERPC_970_v22,             =
   970,
>>>>>                  "PowerPC 970 v2.2")
>>>>> =20
>>>>> -    POWERPC_DEF("POWER9_v1.0",   CPU_POWERPC_POWER9_BASE,         =
   POWER9,
>>>>> +    POWERPC_DEF("POWER9_v1.0",   CPU_POWERPC_POWER9_DD1,          =
   POWER9,
>>>>>                  "POWER9 v1.0")
>>>>> =20
>>>>>      POWERPC_DEF("970fx_v1.0",    CPU_POWERPC_970FX_v10,           =
   970,
>>>>>
>>>>
>>>> I think this also makes sense for running in TCG mode to get a valid
>>>> real PVR there.
>>>
>>> I'm not so convinced.
>>>
>>> IIUC, this will make TCG default (for now) to a DD1 POWER9.  That's a=
)
>>> probably not what anyone wants - who'd select a buggy prototype and b=
)
>>> not accurate - TCG does not implement DD1's bugs.
>>
>> According to the POWER8 user manual (I didn't fine the POWER9 one):
>>
>> "3.6.3.1 Processor Version Register (PVR)
>>
>> The processor revision level (PVR[16:31]) starts at x=E2=80=980100=E2=80=
=99, indicating
>> revision =E2=80=981.0=E2=80=99. As revisions are made, bits [29:31] wi=
ll indicate minor
>> revisions. Similarly, bits [20:23] indicate major changes."
>>
>> POWER9 DD1 PVR is 0x004E0100, so this is really version 1.0 of the POW=
ER9.
>>
>> Perhaps we can define POWER9_v1.0 as CPU_POWERPC_POWER9_DD1, and
>> introduce a POWER9_v0.0 set to CPU_POWERPC_POWER9_BASE and define it a=
s
>> the default one?
>=20
> I like the suggestion to set a v0.0 to CPU_POWERPC_POWER9_BASE. But, I
> think we could have only that option, removing the
> CPU_POWERPC_POWER9_DD1 entry. Then, we add the v2.0 (when ready) as the=
 CPU
> emulated by TCG.
>=20
> To TCG, DD1 wouldn't be listed because it cannot be emulated today.
>=20
> What do you think?

We need the POWER9 DD1 in the list to be able to start QEMU on DD1 host
with "-cpu POWER9" (it works with "-cpu host"). The real question is to
what we should set the default CPU when it is not provided on the CLI.

I agree that using POWER9 DD1 to boot a kernel with TCG will confuse the
kernel.

we could set POWER9 DD1 PVR to define the "POWER9_v1.0", and add a
"POWER9_tcg" (?) set to CPU_POWERPC_POWER9_BASE to use with tcg until we
have the PVR of a public release of POWER9?

Thanks,
Laurent
