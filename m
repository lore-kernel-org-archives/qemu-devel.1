Received: from eggs.gnu.org ([2001:4830:134:3::10]:33729)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fIhgX-0003H3-QW
	for qemu-devel@nongnu.org; Tue, 15 May 2018 17:40:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fIhgT-0004oO-Sj
	for qemu-devel@nongnu.org; Tue, 15 May 2018 17:40:41 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53576 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fIhgT-0004ny-OY
	for qemu-devel@nongnu.org; Tue, 15 May 2018 17:40:37 -0400
References: <20180515182700.31736-1-peter.maydell@linaro.org>
	<aa1f3380-2a5c-b14b-92c1-2c0f74a07220@amsat.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <df368c37-3258-d2cb-9a4d-942f1b4af743@redhat.com>
Date: Tue, 15 May 2018 16:40:34 -0500
MIME-Version: 1.0
In-Reply-To: <aa1f3380-2a5c-b14b-92c1-2c0f74a07220@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] exec.c: Initialize sa_flags passed to
 sigaction()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, patches@linaro.org

On 05/15/2018 03:53 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> On 05/15/2018 03:27 PM, Peter Maydell wrote:
>> Coverity points out that in the user-only version of cpu_abort() we
>> call sigaction() with a partially initialized struct sigaction
>> (CID 1005351). Correct the omission.
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
>>   exec.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/exec.c b/exec.c
>> index ffa1099547..bd8833fc9d 100644
>> --- a/exec.c
>> +++ b/exec.c
>> @@ -1124,6 +1124,7 @@ void cpu_abort(CPUState *cpu, const char *fmt, .=
..)
>>           struct sigaction act;
>=20
> I'd have used the more generic:
>=20
>             struct sigaction act =3D { };

That's a gcc/clang extension (although we have used it before,=20
particularly to shut up buggy versions of clang); better is:

struct sigaction act =3D { 0 };

if that doesn't trigger the clang bug.

>=20
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>=20
>>           sigfillset(&act.sa_mask);
>>           act.sa_handler =3D SIG_DFL;

The sigfillset() has to be done after initialization, but you could also=20
use:

struct sigaction act =3D {
   .sa_handler =3D SIG_DFL;
};
sigfillset(&act.sa_mask);

as a way to zero-initialize all other fields.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
