Received: from eggs.gnu.org ([209.51.188.92]:59331)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h2Xrq-0000NF-Jc
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 04:02:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h2Xrp-0002xg-SN
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 04:02:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54424)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1h2Xrp-0002u3-LO
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 04:02:05 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 41B7F81F12
	for <qemu-devel@nongnu.org>; Sat,  9 Mar 2019 09:02:04 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20190205134926.8312-1-marcandre.lureau@redhat.com>
	<9b037d46-8e73-e5ee-49f2-0c79f06e758f@redhat.com>
Date: Sat, 09 Mar 2019 10:01:58 +0100
In-Reply-To: <9b037d46-8e73-e5ee-49f2-0c79f06e758f@redhat.com> (John Snow's
	message of "Fri, 8 Mar 2019 17:50:18 -0500")
Message-ID: <8736nw775l.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] qmp-shell: fix nested json regression
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, kchamart@redhat.com, ehabkost@redhat.com, Cleber Rosa <crosa@redhat.com>

John Snow <jsnow@redhat.com> writes:

> On 2/5/19 8:49 AM, Marc-Andr=C3=A9 Lureau wrote:
>> Commit fcfab7541 ("qmp-shell: learn to send commands with quoted
>> arguments") introduces the usage of Python 'shlex' to handle quoted
>> arguments, but it accidentally broke generation of nested JSON
>> structs.
>>=20
>> shlex drops quotes, which breaks parsing of the nested struct.
>>=20
>> cmd=3D'blockdev-create job-id=3D"job0 foo" options=3D{"driver":"qcow2","=
size":16384,"file":{"driver":"file","filename":"foo.qcow2"}}'
>>=20
>> shlex.split(cmd)
>> ['blockdev-create',
>>  'job-id=3Djob0 foo',
>>  'options=3D{driver:qcow2,size:16384,file:{driver:file,filename:foo.qcow=
2}}']
>>=20
>> Replace with a regexp to split while respecting quoted strings and prese=
rving quotes:
>>=20
>> re.findall(r'''(?:[^\s"']|"(?:\\.|[^"])*"|'(?:\\.|[^'])*')+''', cmd)
>> ['blockdev-create',
>>  'job-id=3D"job0 foo"',
>>  'options=3D{"driver":"qcow2","size":16384,"file":{"driver":"file","file=
name":"foo.qcow2"}}']
>>=20
>> Fixes: fcfab7541 ("qmp-shell: learn to send commands with quoted argumen=
ts")
>> Reported-by: Kashyap Chamarthy <kchamart@redhat.com>
>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> Hi, did this get misplaced? Would be nice to have back for 4.0 release.

Eduardo, Cleber, I think this one's for you.
