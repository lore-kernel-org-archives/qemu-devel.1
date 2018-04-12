Received: from eggs.gnu.org ([2001:4830:134:3::10]:53129)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f6YxH-0008Hk-3x
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 05:55:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f6YxG-0004ft-8A
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 05:55:47 -0400
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:45575)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f6YxG-0004fV-3g
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 05:55:46 -0400
Received: by mail-ot0-x244.google.com with SMTP id v6-v6so5303747otj.12
	for <qemu-devel@nongnu.org>; Thu, 12 Apr 2018 02:55:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87h8orcg3a.fsf@linaro.org>
References: <1521034084-17344-1-git-send-email-abdallah.bouassida@lauterbach.com>
	<1521034084-17344-4-git-send-email-abdallah.bouassida@lauterbach.com>
	<87h8orcg3a.fsf@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Apr 2018 10:55:24 +0100
Message-ID: <CAFEAcA-VyVH+6bbtsDcm5idR-hVD7dVaBvpdqA-0qBQ8k9-uxQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v5 3/3] target/arm: Add the XML
 dynamic generation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Abdallah Bouassida <abdallah.bouassida@lauterbach.com>, QEMU Developers <qemu-devel@nongnu.org>, Khaled Jmal <khaled.jmal@lauterbach.com>, qemu-arm <qemu-arm@nongnu.org>

On 4 April 2018 at 13:26, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
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
>>  gdbstub.c            | 10 ++++++++
>>  include/qom/cpu.h    |  5 +++-
>>  target/arm/cpu.c     |  1 +
>>  target/arm/cpu.h     | 26 +++++++++++++++++++
>>  target/arm/gdbstub.c | 71 +++++++++++++++++++++++++++++++++++++++++++++=
+++++++
>>  target/arm/helper.c  | 27 ++++++++++++++++++++
>>  6 files changed, 139 insertions(+), 1 deletion(-)
>>
>> diff --git a/gdbstub.c b/gdbstub.c
>> index f1d5148..09065bc 100644
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
>> +
>> +        free(xmlname);
>
> g_free for a g_strndup'ed string please - although I'm confused as to
> why you need to g_strdup the string. You already have p and its not like
> gdb_get_dynamic_xml couldn't dup the string if it needed to (which it
> doesn't seem to).

This is strndup, not strdup. p is not a NUL-terminated string,
so we're creating one to hand to the hook function rather than
requiring it to deal with a non-terminated string.

thanks
-- PMM
