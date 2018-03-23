Received: from eggs.gnu.org ([2001:4830:134:3::10]:35488)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ezUgE-0003oV-2W
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 17:56:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ezUg9-0007Fu-Fk
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 17:56:58 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53634 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ezUg9-0007FR-At
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 17:56:53 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D2AD1722DD
	for <qemu-devel@nongnu.org>; Fri, 23 Mar 2018 21:56:42 +0000 (UTC)
References: <20180323103239.32414-1-marcandre.lureau@redhat.com>
	<20180323153537.GS32362@xz-mi>
	<CAMxuvax=SPeOui3mGcmK8HAo7EqDbpUSZ8Fq3mVHCrLztmBCLA@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <15aaea55-9ebd-8a16-c25e-c9bc709fcabc@redhat.com>
Date: Fri, 23 Mar 2018 16:56:34 -0500
MIME-Version: 1.0
In-Reply-To: <CAMxuvax=SPeOui3mGcmK8HAo7EqDbpUSZ8Fq3mVHCrLztmBCLA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] monitor: fix expected qmp_capabilities
 error description regression
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Peter Xu <peterx@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>

On 03/23/2018 10:50 AM, Marc-Andr=C3=A9 Lureau wrote:

>> If we are going to remove below chunk, how about do it in prettier
>> way instead of hacking around the error again?  Like:
>>
>> diff --git a/monitor.c b/monitor.c
>> index 77f4c41cfa..849fa23bf9 100644
>> --- a/monitor.c
>> +++ b/monitor.c
>> @@ -1203,8 +1203,14 @@ static bool qmp_cmd_oob_check(Monitor *mon, QDi=
ct *req, Error **errp)
>>
>>       cmd =3D qmp_find_command(mon->qmp.commands, command);
>>       if (!cmd) {
>> -        error_set(errp, ERROR_CLASS_COMMAND_NOT_FOUND,
>> -                  "The command %s has not been found", command);
>> +        if (mon->qmp.commands =3D=3D &qmp_cap_negotiation_commands) {
>> +            error_set(errp, ERROR_CLASS_COMMAND_NOT_FOUND,
>> +                      "Expecting capabilities negotiation "
>> +                      "with 'qmp_capabilities'");
>> +        } else {
>> +            error_set(errp, ERROR_CLASS_COMMAND_NOT_FOUND,
>> +                      "The command %s has not been found", command);
>> +        }
>>           return false;
>>       }
>>
>> What do you think?

Yes, that looks nicer.

>>
>=20
> Works for me (fwiw, I'll probably need the replace "hack" again,
> because in the RFC series I am about to send, the code is factored out
> / generalized in qmp-dispatch), but that works in the meantime, please
> send a patch.

There have been quite a few patch ideas across multiple threads related=20
to OOB fallout.  Hopefully I can keep straight which patches are=20
intended for 2.12 (anything that fixes a bug, like this one, is a good=20
candidate, and it would be nice if we can undo the temporary reversion=20
of exposing OOB if we can solve all the issues that iotests exposed).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
