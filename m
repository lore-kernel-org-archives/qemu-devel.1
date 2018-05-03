Received: from eggs.gnu.org ([2001:4830:134:3::10]:46836)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fEBRh-0006AS-05
	for qemu-devel@nongnu.org; Thu, 03 May 2018 06:26:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fEBRg-0007Ce-5D
	for qemu-devel@nongnu.org; Thu, 03 May 2018 06:26:40 -0400
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:40016)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fEBRg-0007CN-0n
	for qemu-devel@nongnu.org; Thu, 03 May 2018 06:26:40 -0400
Received: by mail-ot0-x242.google.com with SMTP id n1-v6so20033023otf.7
	for <qemu-devel@nongnu.org>; Thu, 03 May 2018 03:26:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <874ljp9h2z.fsf@linaro.org>
References: <1524153386-3550-1-git-send-email-abdallah.bouassida@lauterbach.com>
	<1524153386-3550-4-git-send-email-abdallah.bouassida@lauterbach.com>
	<874ljp9h2z.fsf@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 3 May 2018 11:26:18 +0100
Message-ID: <CAFEAcA8QoZdiCxRic9Ztekyi-e5hGwUSPUrbUmW_d2B9vJgYEg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 3/3] target/arm: Add the XML dynamic
 generation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Abdallah Bouassida <abdallah.bouassida@lauterbach.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Khaled Jmal <khaled.jmal@lauterbach.com>

On 3 May 2018 at 11:19, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
>
> Abdallah Bouassida <abdallah.bouassida@lauterbach.com> writes:
>
>> Generate an XML description for the cp-regs.
>> Register these regs with the gdb_register_coprocessor().
>> Add arm_gdb_get_sysreg() to use it as a callback to read those regs.
>> Add a dummy arm_gdb_set_sysreg().
>>
>> Signed-off-by: Abdallah Bouassida <abdallah.bouassida@lauterbach.com>
>> ---
>>  gdbstub.c            | 10 +++++++
>>  include/qom/cpu.h    |  5 +++-
>>  target/arm/cpu.c     |  1 +
>>  target/arm/cpu.h     | 26 ++++++++++++++++++
>>  target/arm/gdbstub.c | 76 +++++++++++++++++++++++++++++++++++++++++++++=
+++++++
>>  target/arm/helper.c  | 26 ++++++++++++++++++
>>  6 files changed, 143 insertions(+), 1 deletion(-)
>>
>> diff --git a/gdbstub.c b/gdbstub.c
>> index a76b2fa..4b56a43 100644
>> --- a/gdbstub.c
>> +++ b/gdbstub.c
>> @@ -674,6 +674,16 @@ static const char *get_feature_xml(const char *p, c=
onst char **newp,
>>          }
>>          return target_xml;
>>      }
>> +    if (cc->gdb_get_dynamic_xml) {
>> +        CPUState *cpu =3D first_cpu;
>> +        char *xmlname =3D g_strndup(p, len);
>> +        const char *xml =3D cc->gdb_get_dynamic_xml(cpu, xmlname);
>
> Last time I asked:
>
> "although I'm confused as to why you need to g_strdup the string. You
> already have p and its not like gdb_get_dynamic_xml couldn't dup the
> string if it needed to (which it doesn't seem to)."

...and the answer is still the same: p is not NUL terminated.

thanks
-- PMM
