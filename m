Received: from eggs.gnu.org ([2001:4830:134:3::10]:41470)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dkA7w-0001nH-9S
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 10:25:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dkA7r-0007LH-Bl
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 10:25:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52842)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dkA7r-0007FZ-2R
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 10:25:51 -0400
References: <20170822132255.23945-1-marcandre.lureau@redhat.com>
	<20170822132255.23945-52-marcandre.lureau@redhat.com>
	<20170822162400.51f07d89.cohuck@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <d1574f35-ebe5-8ede-180a-e584834e9d9a@redhat.com>
Date: Tue, 22 Aug 2017 16:25:42 +0200
MIME-Version: 1.0
In-Reply-To: <20170822162400.51f07d89.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 51/54] qapi: make s390 commands depend
 on TARGET_S390X
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On 22.08.2017 16:24, Cornelia Huck wrote:
> On Tue, 22 Aug 2017 15:22:52 +0200
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> wrote:
>=20
>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> ---
>>  qapi-schema.json                        | 10 +++++++---
>>  include/sysemu/arch_init.h              |  6 ------
>>  monitor.c                               | 14 --------------
>>  qmp.c                                   | 14 --------------
>>  stubs/arch-query-cpu-model-baseline.c   | 12 ------------
>>  stubs/arch-query-cpu-model-comparison.c | 12 ------------
>>  target/s390x/cpu_models.c               |  4 ++--
>>  stubs/Makefile.objs                     |  2 --
>>  8 files changed, 9 insertions(+), 65 deletions(-)
>>  delete mode 100644 stubs/arch-query-cpu-model-baseline.c
>>  delete mode 100644 stubs/arch-query-cpu-model-comparison.c
>>
>> diff --git a/qapi-schema.json b/qapi-schema.json
>> index 58574b3044..d4e1552ddc 100644
>> --- a/qapi-schema.json
>> +++ b/qapi-schema.json
>> @@ -3577,7 +3577,8 @@
>>  #
>>  ##
>>  { 'command': 'dump-skeys',
>> -  'data': { 'filename': 'str' } }
>> +  'data': { 'filename': 'str' },
>> +  'if': ['defined(NEED_CPU_H)', 'defined(TARGET_S390X)']}
>=20
> I agree with making this s390x specific...
>> =20
>>  ##
>>  # @netdev_add:
>> @@ -4621,7 +4622,9 @@
>>  ##
>>  { 'command': 'query-cpu-model-comparison',
>>    'data': { 'modela': 'CpuModelInfo', 'modelb': 'CpuModelInfo' },
>> -  'returns': 'CpuModelCompareInfo' }
>> +  'returns': 'CpuModelCompareInfo',
>> +  'if': ['defined(NEED_CPU_H)', 'defined(TARGET_S390X)']}
>> +
>> =20
>>  ##
>>  # @CpuModelBaselineInfo:
>> @@ -4673,7 +4676,8 @@
>>  { 'command': 'query-cpu-model-baseline',
>>    'data': { 'modela': 'CpuModelInfo',
>>              'modelb': 'CpuModelInfo' },
>> -  'returns': 'CpuModelBaselineInfo' }
>> +  'returns': 'CpuModelBaselineInfo',
>> +  'if': ['defined(NEED_CPU_H)', 'defined(TARGET_S390X)']}
>=20
> ...but I'm not sure about the cpu model stuff. Wasn't the idea to move
> to this model for all architectures later? (Given that we have stubs
> for architectures not implementing this, instead of ifdeffing it in
> monitor.c)
>=20

+1, not architecture specific (in contrast to skey), simply not
supported _yet_ on other architectures.


--=20

Thanks,

David
