Received: from eggs.gnu.org ([2001:4830:134:3::10]:54043)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cfhAO-0006O7-07
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 01:09:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cfhAK-0008Vs-1H
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 01:09:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45484)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1cfhAJ-0008Vn-RW
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 01:09:39 -0500
References: <20170217082704.23270-1-skiver.cloud.yzy@gmail.com>
	<20170217082704.23270-2-skiver.cloud.yzy@gmail.com>
	<5c9a78b3-bd37-d263-b7c2-d7a2db92c0a8@amsat.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <6dccacf7-688c-1009-8c34-7887b70469c7@redhat.com>
Date: Mon, 20 Feb 2017 07:09:35 +0100
MIME-Version: 1.0
In-Reply-To: <5c9a78b3-bd37-d263-b7c2-d7a2db92c0a8@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/2] monitor.c: make mon_get_cpu return
 NULL when there is no CPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Ziyue Yang <skiver.cloud.yzy@gmail.com>
Cc: Ziyue Yang <yzylivezh@hotmail.com>, Pavel Butsykin <pbutsykin@virtuozzo.com>, qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On 19.02.2017 04:55, Philippe Mathieu-Daud=C3=A9 wrote:
> On 02/17/2017 05:27 AM, Ziyue Yang wrote:
>> From: Ziyue Yang <yzylivezh@hotmail.com>
>>
>> Currently mon_get_cpu always dereferences first_cpu without checking
>> whether it's a valid pointer. This commit adds check before
>> dereferencing,
>> and reports "No CPU" info if there isn't any CPU then returns NULL.
>>
>> Signed-off-by: Ziyue Yang <skiver.cloud.yzy@gmail.com>
>=20
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>=20
>> ---
>>  monitor.c | 10 +++++++---
>>  1 file changed, 7 insertions(+), 3 deletions(-)
>>
>> diff --git a/monitor.c b/monitor.c
>> index 3cd72a9bab..6b25cf7a2b 100644
>> --- a/monitor.c
>> +++ b/monitor.c
>> @@ -1026,6 +1026,10 @@ int monitor_set_cpu(int cpu_index)
>>  CPUState *mon_get_cpu(void)
>>  {
>>      if (!cur_mon->mon_cpu) {
>> +        if (!first_cpu) {
>> +            monitor_printf(cur_mon, "No CPU available on this
>> machine\n");
>> +            return NULL;
>> +        }
>>          monitor_set_cpu(first_cpu->cpu_index);
>>      }
>>      cpu_synchronize_state(cur_mon->mon_cpu);
>> @@ -2495,11 +2499,11 @@ static int default_fmt_size =3D 4;
>>  static int is_valid_option(const char *c, const char *typestr)
>>  {
>>      char option[3];
>> -
>> +
>>      option[0] =3D '-';
>>      option[1] =3D *c;
>>      option[2] =3D '\0';
>> -
>> +
>>      typestr =3D strstr(typestr, option);
>>      return (typestr !=3D NULL);
>>  }
>> @@ -2864,7 +2868,7 @@ static QDict *monitor_parse_arguments(Monitor *m=
on,
>>                      p++;
>>                      if(c !=3D *p) {
>>                          if(!is_valid_option(p, typestr)) {
>> -
>> +
>>                              monitor_printf(mon, "%s: unsupported
>> option -%c\n",
>>                                             cmd->name, *p);
>>                              goto fail;

Your patch contains some unnecessary white space changes, please try to
avoid that! (or send a separate "beautification" patch to fix these).

 Thomas
