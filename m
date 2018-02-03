Received: from eggs.gnu.org ([2001:4830:134:3::10]:52135)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ehsc1-0004VC-G0
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 02:51:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ehsby-0003qe-C5
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 02:51:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54784)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ehsby-0003qU-46
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 02:51:46 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20180202183731.29990-1-armbru@redhat.com>
	<20180202183731.29990-13-armbru@redhat.com>
	<56dc5bfa-a28b-f088-c9b2-5253f9c31bcf@amsat.org>
Date: Sat, 03 Feb 2018 08:51:42 +0100
In-Reply-To: <56dc5bfa-a28b-f088-c9b2-5253f9c31bcf@amsat.org> ("Philippe
	=?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Fri, 2 Feb 2018 17:24:03
	-0300")
Message-ID: <87wozucxyp.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v7 12/15] hw/timer: Replace fprintf(stderr,
 "*\n" with error_report()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org, alistair.francis@xilinx.com

Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:

> On 02/02/2018 03:37 PM, Markus Armbruster wrote:
>> From: Alistair Francis <alistair.francis@xilinx.com>
>>=20
>> Replace a large number of the fprintf(stderr, "*\n" calls with
>> error_report(). The functions were renamed with these commands and then
>> compiler issues where manually fixed.
>>=20
>> find ./* -type f -exec sed -i \
>>     'N;N;N;N;N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|err=
or_report("\1"\2);|Ig}' \
>>     {} +
>> find ./* -type f -exec sed -i \
>>     'N;N;N;N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error=
_report("\1"\2);|Ig}' \
>>     {} +
>> find ./* -type f -exec sed -i \
>>     'N;N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_rep=
ort("\1"\2);|Ig}' \
>>     {} +
>> find ./* -type f -exec sed -i \
>>     'N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_repor=
t("\1"\2);|Ig}' \
>>     {} +
>> find ./* -type f -exec sed -i \
>>     'N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report(=
"\1"\2);|Ig}' \
>>     {} +
>> find ./* -type f -exec sed -i \
>>     'N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\=
1"\2);|Ig}' \
>>     {} +
>> find ./* -type f -exec sed -i \
>>     'N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"=
\2);|Ig}' \
>>     {} +
>> find ./* -type f -exec sed -i \
>>     'N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2=
);|Ig}' \
>>     {} +
>> find ./* -type f -exec sed -i \
>>     'N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);=
|Ig}' \
>>     {} +
>> find ./* -type f -exec sed -i \
>>     'N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|I=
g}' \
>>     {} +
>> find ./* -type f -exec sed -i \
>>     'N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}=
' \
>>     {} +
>>=20
>> Some lines where then manually tweaked to pass checkpatch.
>>=20
>> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
>>=20
>> Conversions that aren't followed by exit() dropped, because they might
>> be inappropriate.
>>=20
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  hw/timer/xilinx_timer.c | 10 +++++-----
>>  1 file changed, 5 insertions(+), 5 deletions(-)
>>=20
>> diff --git a/hw/timer/xilinx_timer.c b/hw/timer/xilinx_timer.c
>> index 59439c05be..2d658b5791 100644
>> --- a/hw/timer/xilinx_timer.c
>> +++ b/hw/timer/xilinx_timer.c
>> @@ -127,7 +127,7 @@ timer_read(void *opaque, hwaddr addr, unsigned int s=
ize)
>>              break;
>>=20=20
>>      }
>> -    D(fprintf(stderr, "%s timer=3D%d %x=3D%x\n", __func__, timer, addr =
* 4, r));
>> +    D(error_report("%s timer=3D%d %x=3D%x", __func__, timer, addr * 4, =
r));
>
> Not sure what we gain here, since those aren't error messages but trace
> event.
> Can you drop this patch from your series? I'll convert to tracepoints
> and send a patch for this file.

Done.  Thanks!
