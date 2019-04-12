Received: from eggs.gnu.org ([209.51.188.92]:40462)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hErBr-0005Hw-OM
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 04:05:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hErBp-0000Sh-Sj
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 04:05:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44022)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hErBk-0000PS-DK
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 04:05:34 -0400
References: <20190411235456.12918-1-brijesh.singh@amd.com>
	<74d884dd-3f3f-88d4-9f8b-62b696245fbc@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0db9a2c4-7153-6fb0-a15a-23e28c81669f@redhat.com>
Date: Fri, 12 Apr 2019 10:05:23 +0200
MIME-Version: 1.0
In-Reply-To: <74d884dd-3f3f-88d4-9f8b-62b696245fbc@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] target/i386: sev: add 'sev-max-guests'
 field to 'query-sev-capabilities'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>, "Singh, Brijesh" <brijesh.singh@amd.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>, Erik Skultety <eskultet@redhat.com>, "Lendacky, Thomas" <Thomas.Lendacky@amd.com>

On 12/04/19 09:58, Laszlo Ersek wrote:
> On 04/12/19 01:55, Singh, Brijesh wrote:
>> There are limited numbers of the SEV guests that can be run concurrent=
ly.
>> A management applications may need to know this limit so that it can p=
lace
>> SEV VMs on hosts which have suitable resources available.
>>
>> Currently, this limit is not exposed to the application. Add a new
>> 'sev-max-guest' field in the query-sev-capabilities to provide this
>> information.
>>
>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>> Cc: Markus Armbruster <armbru@redhat.com>
>> Cc: Eric Blake <eblake@redhat.com>
>> Cc: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>> Cc: Laszlo Ersek <lersek@redhat.com>
>> Cc: Erik Skultety <eskultet@redhat.com>
>> Cc: Tom Lendacky <Thomas.Lendacky@amd.com>
>> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
>> ---
>>
>> changes since v1:
>>  - document the new field and add (since 4.1) annotation.
>>
>>  qapi/target.json  | 9 +++++++--
>>  target/i386/sev.c | 9 +++++++--
>>  2 files changed, 14 insertions(+), 4 deletions(-)
>>
>> diff --git a/qapi/target.json b/qapi/target.json
>> index 1d4d54b600..8cd4fc7919 100644
>> --- a/qapi/target.json
>> +++ b/qapi/target.json
>> @@ -177,13 +177,17 @@
>>  # @reduced-phys-bits: Number of physical Address bit reduction when S=
EV is
>>  #                     enabled
>>  #
>> +# @sev-max-guests: maximum number of concurrent SEV guest with SEV-ES=
 disabled
>> +#                  (since 4.1)
>> +#
>>  # Since: 2.12
>>  ##
>>  { 'struct': 'SevCapability',
>>    'data': { 'pdh': 'str',
>>              'cert-chain': 'str',
>>              'cbitpos': 'int',
>> -            'reduced-phys-bits': 'int'},
>> +            'reduced-phys-bits': 'int',
>> +            'sev-max-guests': 'int'},
>>    'if': 'defined(TARGET_I386)' }
>> =20
>>  ##
>> @@ -200,7 +204,8 @@
>>  #
>>  # -> { "execute": "query-sev-capabilities" }
>>  # <- { "return": { "pdh": "8CCDD8DDD", "cert-chain": "888CCCDDDEE",
>> -#                  "cbitpos": 47, "reduced-phys-bits": 5}}
>> +#                  "cbitpos": 47, "reduced-phys-bits": 5,
>> +#                  "sev-max-guests" : 15}}
>=20
> There seems to be a superfluous space character before the colon, but I
> don't think it matters much.
>=20
>>  #
>>  ##
>>  { 'command': 'query-sev-capabilities', 'returns': 'SevCapability',
>> diff --git a/target/i386/sev.c b/target/i386/sev.c
>> index cd77f6b5d4..6829586fbe 100644
>> --- a/target/i386/sev.c
>> +++ b/target/i386/sev.c
>> @@ -488,7 +488,7 @@ sev_get_capabilities(void)
>>      guchar *pdh_data =3D NULL;
>>      guchar *cert_chain_data =3D NULL;
>>      size_t pdh_len =3D 0, cert_chain_len =3D 0;
>> -    uint32_t ebx;
>> +    uint32_t ebx, ecx, edx;
>>      int fd;
>> =20
>>      fd =3D open(DEFAULT_SEV_DEVICE, O_RDWR);
>> @@ -507,7 +507,7 @@ sev_get_capabilities(void)
>>      cap->pdh =3D g_base64_encode(pdh_data, pdh_len);
>>      cap->cert_chain =3D g_base64_encode(cert_chain_data, cert_chain_l=
en);
>> =20
>> -    host_cpuid(0x8000001F, 0, NULL, &ebx, NULL, NULL);
>> +    host_cpuid(0x8000001F, 0, NULL, &ebx, &ecx, &edx);
>>      cap->cbitpos =3D ebx & 0x3f;
>> =20
>>      /*
>> @@ -516,6 +516,11 @@ sev_get_capabilities(void)
>>       */
>>      cap->reduced_phys_bits =3D 1;
>> =20
>> +    /*
>> +     * The maximum number of SEV guests with SEV-ES disabled that can=
 run
>> +     * simultaneously.
>> +     */
>> +    cap->sev_max_guests =3D ecx - edx + 1;
>>  out:
>>      g_free(pdh_data);
>>      g_free(cert_chain_data);
>>
>=20
> Reviewed-by: Laszlo Ersek <lersek@redhat.com>

As mentioned in v1, I don't think a management application should need
to run QEMU in order to figure this out.

Paolo
