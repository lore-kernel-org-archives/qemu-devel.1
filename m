Received: from eggs.gnu.org ([2001:4830:134:3::10]:39531)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1egnoB-0007r7-Cc
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 03:31:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1egno8-0004Mv-9Z
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 03:31:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59758)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1egno8-0004MO-4h
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 03:31:52 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20180130102202.28519-1-armbru@redhat.com>
	<42a506d8-01a4-3ce9-88ef-a734b5014661@amsat.org>
Date: Wed, 31 Jan 2018 09:31:49 +0100
In-Reply-To: <42a506d8-01a4-3ce9-88ef-a734b5014661@amsat.org> ("Philippe
	=?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Tue,
	30 Jan 2018 15:36:29 -0300")
Message-ID: <87r2q65szu.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 00/18] Clean up includes to reduce compile
 time
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org

Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:

> On 01/30/2018 07:21 AM, Markus Armbruster wrote:
>> We have awfully many "touch it, recompile the world" headers.  Right
>> now, I count about fifty that are prerequisites of more than half the
>> objects in my "build everything" tree.
>>=20
>> Some of them are that way by necessity.  Many of them are not.  This
>> series takes care of six I happen to touch, because serve as their
>> maintainer:
>>=20
>>     include/qapi/qmp/qdict.h
>>     include/qapi/qmp/qlist.h
>>     include/qapi/qmp/qnull.h
>>     include/qapi/qmp/qnum.h
>>     include/qapi/qmp/qobject.h
>>     include/qemu/option.h
>>=20
>> Before this series, touching any of these recompiles more than 95% of
>> my objects.  That's more than 4500 compiler runs.  After this series,
>> only 0.3% - 8% of my objects get recompiled.
>
> nice cleanup :)
>
> No more comment than what Eric said (mostly newlines),
> and Zoltan regarding <qemu/osdep.h>, so
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Thanks!

> Is there a way to check if an header got used or not?
> (thinking about a patchew check to not add headers until effectively used=
).

The only one I know is "drop the include and see whether it still
compiles".  Would be nice if the compiler could report superfluous
headers.

For a header, "compiles" means a .c file containing just two includes
(qemu/osdep.h and the header) compiles.  Many of our headers don't.
