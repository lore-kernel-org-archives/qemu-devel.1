Received: from eggs.gnu.org ([2001:4830:134:3::10]:55917)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fqC9U-0005RN-2j
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 02:53:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fqC9Q-0004vN-It
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 02:52:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53864)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fqC9Q-0004vC-D4
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 02:52:56 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180815141945.10457-1-armbru@redhat.com>
	<20180815141945.10457-2-armbru@redhat.com>
	<95680fcb-9c9a-cc9a-3a15-ec208046a20a@amsat.org>
Date: Thu, 16 Aug 2018 08:52:53 +0200
In-Reply-To: <95680fcb-9c9a-cc9a-3a15-ec208046a20a@amsat.org> ("Philippe
	=?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Wed,
	15 Aug 2018 11:44:44 -0300")
Message-ID: <87tvnueray.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/1] libqtest: Improve error reporting for
 bad read from QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, lvivier@redhat.com, pbonzini@redhat.com, thuth@redhat.com

Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:

> On 08/15/2018 11:19 AM, Markus Armbruster wrote:
>> When read() from the qtest socket or the QMP socket fails or EOFs, we
>> report "Broken pipe" and exit(1).  This commonly happens when QEMU
>> crashes.  It also happens when QEMU refuses to run because the test
>> passed it bad arguments.  Sadly, we neglect to report either.
>>=20
>> Improve this by calling abort() instead of exit(1), so kill_qemu()
>> runs, and reports how QEMU died.  This improves error reporting to
>> something like
>>=20
>>     /x86_64/device/introspect/list: Broken pipe
>>     tests/libqtest.c:129: kill_qemu() detected QEMU death from signal 6 =
(Aborted) (dumped core)
>>=20
>> Three exit() remain in libqtest.c:
>>=20
>> * In qmp_response(), when we can't parse a QMP reply read from the QMP
>>   socket.  Change to abort() for consistency.
>>=20
>> * In qtest_qemu_binary(), when QTEST_QEMU_BINARY isn't in the
>>   environment.  This can only happen before we start QEMU.  Leave
>>   alone.
>>=20
>> * In qtest_init_without_qmp_handshake(), when the fork()ed child fails
>>   to execlp().  Leave alone.
>>=20
>> exit() elsewhere are unlikely due to QEMU dying on us.  If that should
>> turn out to be wrong, we can move kill_qemu() from the abrt handler to
>
> "abort handler"?

The variable is called @abrt_hooks, like SIGABRT[*].  But you're right,
I should either use the English word spelled correctly, or use the
identifier spelled correctly.  I think I'll use the identifier.

>> atexit() or something.
>>=20
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Thanks!


[*] The ancients sacrificed the occasional vowel to the God of Spartan
Linkers and ASR-33 Teletypes.
