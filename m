Received: from eggs.gnu.org ([2001:4830:134:3::10]:36442)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eAafc-0001pS-KK
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 08:01:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eAafX-0000TB-1B
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 08:01:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54512)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1eAafW-0000SF-PU
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 08:01:50 -0400
References: <20171027181740.32165-1-danielhb@linux.vnet.ibm.com>
	<CAJ+F1CJs7WtU+xYfMViYer9vfRAq3SAMQiEjPRRCGnTUBbsgGQ@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <f2457db3-b654-4956-165c-ef0962d9e923@redhat.com>
Date: Fri, 3 Nov 2017 13:01:21 +0100
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CJs7WtU+xYfMViYer9vfRAq3SAMQiEjPRRCGnTUBbsgGQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] scripts/device-crash-test: vmcoreinfo in
 error_whitelist for ppc64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>, Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Cc: QEMU <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

On 03.11.2017 12:49, Marc-Andr=C3=A9 Lureau wrote:
> Hi Daniel
>=20
> On Fri, Oct 27, 2017 at 8:17 PM, Daniel Henrique Barboza
> <danielhb@linux.vnet.ibm.com> wrote:
>> The device vmcoreinfo depends on the fw_cfg device to work, a device
>> that isn't available in most ppc64 machines. This makes device-crash-t=
est
>> spams the following error when running with qemu-system-ppc64:
>>
>> "INFO: log: qemu-system-ppc64: -device vmcoreinfo: vmcoreinfo device
>> requires fw_cfg with DMA"
>>
>> To fix it, this patch adds the following ppc64 machines into the
>> error_whitelist for the vmcoreinfo device:
>>
>> - pseries.*
>> - 40p
>> - bamboo
>> - g3beige
>> - mac99
>> - mpc8544ds
>> - powernv
>> - ppce500
>> - prep
>> - virtex-ml507
>>
>> After this patch, the only ppc64 machine that reports error on the
>> vmcoreinfo device is the 'none' type.
>>
>> Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
>> ---
>>  scripts/device-crash-test | 12 ++++++++++++
>>  1 file changed, 12 insertions(+)
>>
>> diff --git a/scripts/device-crash-test b/scripts/device-crash-test
>> index 043b24a4aa..fb8a43d679 100755
>> --- a/scripts/device-crash-test
>> +++ b/scripts/device-crash-test
>> @@ -163,6 +163,18 @@ ERROR_WHITELIST =3D [
>>      # "spapr-cpu-core needs a pseries machine"
>>      {'machine':'(?!pseries).*', 'device':'.*-spapr-cpu-core', 'expect=
ed':True},
>>
>> +    # vmcoreinfo requires a fw_cfg device and will fail in these ppc6=
4 machines
>> +    {'machine':'pseries.*', 'device':'vmcoreinfo', 'expected':True},
>> +    {'machine':'40p', 'device':'vmcoreinfo', 'expected':True},
>> +    {'machine':'bamboo', 'device':'vmcoreinfo', 'expected':True},
>> +    {'machine':'g3beige', 'device':'vmcoreinfo', 'expected':True},
>> +    {'machine':'mac99', 'device':'vmcoreinfo', 'expected':True},
>> +    {'machine':'mpc8544ds', 'device':'vmcoreinfo', 'expected':True},
>> +    {'machine':'powernv', 'device':'vmcoreinfo', 'expected':True},
>> +    {'machine':'ppce500', 'device':'vmcoreinfo', 'expected':True},
>> +    {'machine':'prep', 'device':'vmcoreinfo', 'expected':True},
>> +    {'machine':'virtex-ml507', 'device':'vmcoreinfo', 'expected':True=
},
>=20
> You could try to make it fit on one line with
> r"(pseries.*|40p|bamboo|...)". Declaring a ppc64_machines before would
> probably help too.
>=20
> Any idea for an alternative vmcoreinfo device approach on ppc64?

It's not only about ppc64 - this problem exists also on most other
targets, e.g.:

$ m68k-softmmu/qemu-system-m68k -M none -device vmcoreinfo
qemu-system-m68k: -device vmcoreinfo: vmcoreinfo device requires fw_cfg
with DMA

So for the device-crash-test script, I think it would make more sense to
add a generic, machine-independent entry for this.

Additionally, I think it's also a bad idea to blindly add this
vmcoreinfo device to all targets! We should only add it to the targets
that actually feature the fw_cfg device with DMA, so we need a proper
CONFIG_xxx switch for this. Marc-Andr=C3=A9 or Daniel, do you have time t=
o
work on such a patch? Otherwise, I can have a look at this, too.

 Thomas
