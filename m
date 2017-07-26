Received: from eggs.gnu.org ([2001:4830:134:3::10]:33690)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1daOp3-0003eQ-SZ
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 12:06:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1daOoz-0000bH-Nt
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 12:06:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42350)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1daOoz-0000aw-Hr
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 12:06:01 -0400
References: <20170726150446.20381-1-otubo@redhat.com>
	<7ff46b33-1b47-88ad-83e3-54030c12eaa0@amsat.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <06b166d8-4c5c-aa78-c9c9-4be10b1c1e35@redhat.com>
Date: Wed, 26 Jul 2017 18:05:55 +0200
MIME-Version: 1.0
In-Reply-To: <7ff46b33-1b47-88ad-83e3-54030c12eaa0@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] fix qemu-system-unicore32 crashing when
 calling without -kernel
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Eduardo Otubo <otubo@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Cleber Rosa <crosa@redhat.com>

On 26.07.2017 18:00, Philippe Mathieu-Daud=C3=A9 wrote:
> On 07/26/2017 12:04 PM, Eduardo Otubo wrote:
>> Starting qemu-system-unicore32 without the -kernel parameter results i=
n
>> an assert() returns false and aborts qemu. This patch replaces it with=
 a
>> proper error message followed by exit(1).
>>
>> Signed-off-by: Eduardo Otubo <otubo@redhat.com>
>> ---
>>   hw/unicore32/puv3.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/unicore32/puv3.c b/hw/unicore32/puv3.c
>> index e9d1a60b6f..ff62efb4df 100644
>> --- a/hw/unicore32/puv3.c
>> +++ b/hw/unicore32/puv3.c
>> @@ -92,7 +92,10 @@ static void puv3_load_kernel(const char
>> *kernel_filename)
>>       if (kernel_filename =3D=3D NULL && qtest_enabled()) {
>>           return;
>>       }
>> -    assert(kernel_filename !=3D NULL);
>> +    if (kernel_filename =3D=3D NULL) {
>> +        error_report("kernel parameter cannot be empty");
>> +        exit(1);
>> +    }
>=20
> This seems a temporary kludge for 2.10 but not the correct long-term fi=
x.
>=20
> As commented in another thread [1] where I got a bit discomfited, it'd
> be nice if during the 2.11 schedule the industry provide some help to
> clean/unify the loader.c code, ideally remove all duplicated code not
> arch-specific and use hw/core/loader*.
>=20
> [1] http://lists.nongnu.org/archive/html/qemu-devel/2017-07/msg06760.ht=
ml

Sorry, but this here *is* a machine-specific problem. I fail to see how
this should be related to the hw/core/loader.c code?

 Thomas
