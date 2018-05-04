Received: from eggs.gnu.org ([2001:4830:134:3::10]:43342)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fEfJA-00042i-4y
	for qemu-devel@nongnu.org; Fri, 04 May 2018 14:19:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fEfJ6-0001MA-53
	for qemu-devel@nongnu.org; Fri, 04 May 2018 14:19:52 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54806 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fEfJ5-0001Iz-VA
	for qemu-devel@nongnu.org; Fri, 04 May 2018 14:19:48 -0400
References: <1525445354-16233-1-git-send-email-walling@linux.ibm.com>
	<7e9e9dfd-795b-47f2-453a-59bf65f28229@redhat.com>
	<7274b001-02f2-6584-ea0a-c3d0f96d46b8@linux.ibm.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <89dc884d-97af-4922-bd69-1cb7308399d8@redhat.com>
Date: Fri, 4 May 2018 13:19:37 -0500
MIME-Version: 1.0
In-Reply-To: <7274b001-02f2-6584-ea0a-c3d0f96d46b8@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] monitor: report entirety of hmp command on
 error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Collin Walling <walling@linux.ibm.com>, qemu-devel@nongnu.org

On 05/04/2018 01:02 PM, Collin Walling wrote:

>> So rather than trying to reconstruct a string, you could reuse what yo=
u already have.=C2=A0 This is a shorter patch that I think accomplishes t=
he same goal:
>>
>> diff --git i/monitor.c w/monitor.c
>> index 39f8ee17ba7..38736b3a20d 100644
>> --- i/monitor.c
>> +++ w/monitor.c
>> @@ -3371,6 +3371,7 @@ static void handle_hmp_command(Monitor *mon, con=
st char *cmdline)
>>  =C2=A0{
>>  =C2=A0=C2=A0=C2=A0=C2=A0 QDict *qdict;
>>  =C2=A0=C2=A0=C2=A0=C2=A0 const mon_cmd_t *cmd;
>> +=C2=A0=C2=A0=C2=A0 const char *cmd_start =3D cmdline;
>>
>>  =C2=A0=C2=A0=C2=A0=C2=A0 trace_handle_hmp_command(mon, cmdline);
>>
>> @@ -3381,8 +3382,11 @@ static void handle_hmp_command(Monitor *mon, co=
nst char *cmdline)
>>
>>  =C2=A0=C2=A0=C2=A0=C2=A0 qdict =3D monitor_parse_arguments(mon, &cmdl=
ine, cmd);
>>  =C2=A0=C2=A0=C2=A0=C2=A0 if (!qdict) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 monitor_printf(mon, "Try \=
"help %s\" for more information\n",
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cmd->name=
);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 while (cmdline > cmd_start=
 && qemu_isspace(cmdline[-1])) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cm=
dline--;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 monitor_printf(mon, "Try \=
"help %.*s\" for more information\n",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (int)(cmd=
line - cmd_start), cmd_start);
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>>  =C2=A0=C2=A0=C2=A0=C2=A0 }
>>
>>
>>
>=20
> Very interesting... you managed to reuse what was in cmdline without pr=
inting anything extraneous that
> the user might have provided... nicely done!
>=20
> Your print statement is intriguing to me... I'm not entirely sure how i=
t works.

The format specifiers in printf are %[flags][width][.precision]format.=20
So I'm requesting a precision-limited string print (which says the=20
maximum number of characters to print, rather than the usual semantics=20
of printing until the trailing NUL is found), and the precision of .*=20
(instead of a more typical .1 or similar) says that the precision will=20
be an int argument to printf rather than inline (the width argument can=20
also be passed via *).  The cast to int is annoyingly part of the=20
specification (subtracting two pointers within a string results in a=20
ptrdiff_t, but on 64-bit platforms, ptrdiff_t and int are not equally=20
handled through vararg functions).  And that exact style of printf()=20
magic was already in use in monitor_parse_command() that your patch=20
attempt was touching (see where cmdp_start is used).  And if you really=20
want weird, 'man 3 printf' states that "%.*s" is equivalent to=20
"%2$.*1$s" (the $ syntax is for cases cases where you need to consume=20
printf arguments out-of-order, often when dealing with translated strings=
).

>=20
> How would you like to move forward with this patch?

I'm more than happy to let you post a v2 of the patch, incorporating the=20
ideas you just learned from me.  (Or, if you do nothing, then in a week=20
or so, I'll probably notice the patch is still sitting unapplied in my=20
local repository and submit it myself - but then I wouldn't be helping=20
the qemu community grow...)

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
