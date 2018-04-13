Received: from eggs.gnu.org ([2001:4830:134:3::10]:37123)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1f6q44-0007Xt-T0
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 00:11:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1f6q41-0008Sg-O7
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 00:11:56 -0400
References: <1523372486-13190-1-git-send-email-walling@linux.ibm.com>
	<1523372486-13190-3-git-send-email-walling@linux.ibm.com>
	<107962d1-87b5-2574-92a3-a6625757f9e7@redhat.com>
	<445a3858-d399-ef49-6426-3de9a95509dd@linux.ibm.com>
	<125df9c3-b133-6882-7d92-1ffc9e4c040f@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <7be1f156-2044-317f-ce8f-d79588497a57@redhat.com>
Date: Fri, 13 Apr 2018 06:11:33 +0200
MIME-Version: 1.0
In-Reply-To: <125df9c3-b133-6882-7d92-1ffc9e4c040f@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/4] pc-bios/s390-ccw: fix loadparm
 initialization and int conversion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Farhan Ali <alifm@linux.ibm.com>, Collin Walling <walling@linux.ibm.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, cohuck@redhat.com, borntraeger@de.ibm.com
Cc: frankja@linux.ibm.com, gor@linux.ibm.com

On 12.04.2018 23:04, Farhan Ali wrote:
>=20
>=20
> On 04/12/2018 04:57 PM, Collin Walling wrote:
>> On 04/12/2018 02:57 PM, Thomas Huth wrote:
>>> On 10.04.2018 17:01, Collin Walling wrote:
>>>> Rename the loadparm char array in main.c to loadparm_str and
>>>> increase the size by one byte to account for a null termination
>>>> when converting the loadparm string to an int via atoui. Also
>>>> allow the boot menu to be enabled when loadparm is set to an
>>>> empty string or a series of spaces.
>>>>
>>>> Signed-off-by: Collin Walling <walling@linux.ibm.com>
>>>> Reported-by: Vasily Gorbik <gor@linux.ibm.com>
>>>> ---
>>>> =C2=A0 hw/s390x/ipl.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0 2 ++
>>>> =C2=A0 pc-bios/s390-ccw/main.c | 14 +++++++-------
>>>> =C2=A0 2 files changed, 9 insertions(+), 7 deletions(-)
>>>>
>>>> diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
>>>> index fdeaec3..23b5b54 100644
>>>> --- a/hw/s390x/ipl.c
>>>> +++ b/hw/s390x/ipl.c
>>>> @@ -352,6 +352,8 @@ int s390_ipl_set_loadparm(uint8_t *loadparm)
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 loadparm[i] =3D ascii2ebcdic[(uint8_t) lp[i]];
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> =C2=A0 +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 memset(loadparm +=
 i, 0x40, 8 - i); /* fill with EBCDIC
>>>> spaces */
>>>> +
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_free(lp);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
>>>> index 9d9f8cf..26f9adf 100644
>>>> --- a/pc-bios/s390-ccw/main.c
>>>> +++ b/pc-bios/s390-ccw/main.c
>>>> @@ -15,11 +15,11 @@
>>>> =C2=A0 char stack[PAGE_SIZE * 8] __attribute__((__aligned__(PAGE_SIZ=
E)));
>>>> =C2=A0 static SubChannelId blk_schid =3D { .one =3D 1 };
>>>> =C2=A0 IplParameterBlock iplb __attribute__((__aligned__(PAGE_SIZE))=
);
>>>> -static char loadparm[8] =3D { 0, 0, 0, 0, 0, 0, 0, 0 };
>>>> +static char loadparm_str[9] =3D { 0, 0, 0, 0, 0, 0, 0, 0, 0 };
>>>> =C2=A0 QemuIplParameters qipl;
>>>> =C2=A0 =C2=A0 #define LOADPARM_PROMPT "PROMPT=C2=A0 "
>>>> -#define LOADPARM_EMPTY=C2=A0 "........"
>>>> +#define LOADPARM_EMPTY=C2=A0 "=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 "
>>>
>>> Sorry for my ignorance, but why was the old string containing dots?
>>>
>>> =C2=A0 Thomas
>>>
>>
>> No need for apologies :)
>>
>> If -machine loadparm is *not* present on the command line, then the
>> loadparm in the sclp
>> will be a series of nulls. For whatever reason, that gets translated
>> into a series of dots.
>>
>=20
> It's because of the ebc2asc table we use for conversion, which results
> in the dots when converting from ebcdic_to_ascii.

Ah, great, thanks to both of you for the explanation, that was the part
that I was missing. I was only looking at the tables in
include/hw/s390x/ebcdic.h (since I thought that the dots were already
created on the QEMU side), and did not expect that the pc-bios could
create them.

The patch now makes sense to me:

Reviewed-by: Thomas Huth <thuth@redhat.com>
