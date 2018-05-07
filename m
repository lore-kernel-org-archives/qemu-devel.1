Received: from eggs.gnu.org ([2001:4830:134:3::10]:53079)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <walling@linux.ibm.com>) id 1fFh3T-0007c7-T8
	for qemu-devel@nongnu.org; Mon, 07 May 2018 10:23:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <walling@linux.ibm.com>) id 1fFh3Q-0008He-MO
	for qemu-devel@nongnu.org; Mon, 07 May 2018 10:23:55 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41174
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <walling@linux.ibm.com>)
	id 1fFh3Q-0008D0-Fh
	for qemu-devel@nongnu.org; Mon, 07 May 2018 10:23:52 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w47EK58b071971
	for <qemu-devel@nongnu.org>; Mon, 7 May 2018 10:23:47 -0400
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2htqcpkk6m-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 07 May 2018 10:23:47 -0400
Received: from localhost
	by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <walling@linux.ibm.com>;
	Mon, 7 May 2018 10:23:46 -0400
References: <1525445354-16233-1-git-send-email-walling@linux.ibm.com>
	<7e9e9dfd-795b-47f2-453a-59bf65f28229@redhat.com>
	<7274b001-02f2-6584-ea0a-c3d0f96d46b8@linux.ibm.com>
	<89dc884d-97af-4922-bd69-1cb7308399d8@redhat.com>
From: Collin Walling <walling@linux.ibm.com>
Date: Mon, 7 May 2018 10:23:43 -0400
MIME-Version: 1.0
In-Reply-To: <89dc884d-97af-4922-bd69-1cb7308399d8@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Message-Id: <724592be-f5ac-7a40-8c26-5d2dd200ef82@linux.ibm.com>
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
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org

On 05/04/2018 02:19 PM, Eric Blake wrote:
> On 05/04/2018 01:02 PM, Collin Walling wrote:
>=20
>>> So rather than trying to reconstruct a string, you could reuse what y=
ou already have.=C2=A0 This is a shorter patch that I think accomplishes =
the same goal:
>>>
>>> diff --git i/monitor.c w/monitor.c
>>> index 39f8ee17ba7..38736b3a20d 100644
>>> --- i/monitor.c
>>> +++ w/monitor.c
>>> @@ -3371,6 +3371,7 @@ static void handle_hmp_command(Monitor *mon, co=
nst char *cmdline)
>>> =C2=A0=C2=A0{
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 QDict *qdict;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const mon_cmd_t *cmd;
>>> +=C2=A0=C2=A0=C2=A0 const char *cmd_start =3D cmdline;
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 trace_handle_hmp_command(mon, cmdline)=
;
>>>
>>> @@ -3381,8 +3382,11 @@ static void handle_hmp_command(Monitor *mon, c=
onst char *cmdline)
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qdict =3D monitor_parse_arguments(mon,=
 &cmdline, cmd);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!qdict) {
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 monitor_printf(mon, "Try =
\"help %s\" for more information\n",
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cmd->name=
);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 while (cmdline > cmd_star=
t && qemu_isspace(cmdline[-1])) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 c=
mdline--;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 monitor_printf(mon, "Try =
\"help %.*s\" for more information\n",
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (int)(cmd=
line - cmd_start), cmd_start);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>
>>>
>>>
>>
>> Very interesting... you managed to reuse what was in cmdline without p=
rinting anything extraneous that
>> the user might have provided... nicely done!
>>
>> Your print statement is intriguing to me... I'm not entirely sure how =
it works.
>=20
> The format specifiers in printf are %[flags][width][.precision]format. =
So I'm requesting a precision-limited string print (which says the maximu=
m number of characters to print, rather than the usual semantics of print=
ing until the trailing NUL is found), and the precision of .* (instead of=
 a more typical .1 or similar) says that the precision will be an int arg=
ument to printf rather than inline (the width argument can also be passed=
 via *).=C2=A0 The cast to int is annoyingly part of the specification (s=
ubtracting two pointers within a string results in a ptrdiff_t, but on 64=
-bit platforms, ptrdiff_t and int are not equally handled through vararg =
functions).=C2=A0 And that exact style of printf() magic was already in u=
se in monitor_parse_command() that your patch attempt was touching (see w=
here cmdp_start is used).=C2=A0 And if you really want weird, 'man 3 prin=
tf' states that "%.*s" is equivalent to "%2$.*1$s" (the $ syntax is for c=
ases cases where you need to consume printf arguments
> out-of-order, often when dealing with translated strings).
>=20

Very cool! Thank you for clearing that up for me. I must've glanced over =
the usage in monitor_parse_command().

>>
>> How would you like to move forward with this patch?
>=20
> I'm more than happy to let you post a v2 of the patch, incorporating th=
e ideas you just learned from me.=C2=A0 (Or, if you do nothing, then in a=
 week or so, I'll probably notice the patch is still sitting unapplied in=
 my local repository and submit it myself - but then I wouldn't be helpin=
g the qemu community grow...)
>=20

Much appreciated. I'll post v2 as a reply to this email chain (since it's=
 very small and I don't expect much discussion to follow)
with your suggested changes.


--=20
Respectfully,
- Collin Walling
