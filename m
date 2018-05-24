Received: from eggs.gnu.org ([2001:4830:134:3::10]:59715)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fLuVE-0006fW-Ui
	for qemu-devel@nongnu.org; Thu, 24 May 2018 13:58:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fLuVA-0006Ms-0e
	for qemu-devel@nongnu.org; Thu, 24 May 2018 13:58:17 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38268 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fLuV9-0006MY-SE
	for qemu-devel@nongnu.org; Thu, 24 May 2018 13:58:11 -0400
References: <1527178151-181781-1-git-send-email-mst@redhat.com>
	<bf33951f-d205-ec9c-4ceb-7703deea97f7@redhat.com>
	<20180524203055-mutt-send-email-mst@kernel.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <02e22133-8358-99c6-784e-52ac39b7b273@redhat.com>
Date: Thu, 24 May 2018 19:58:06 +0200
MIME-Version: 1.0
In-Reply-To: <20180524203055-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 2/1] libqtest: add more exit status
 checks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Markus Armbruster <armbru@redhat.com>

On 24.05.2018 19:33, Michael S. Tsirkin wrote:
> On Thu, May 24, 2018 at 07:26:16PM +0200, Thomas Huth wrote:
>> On 24.05.2018 18:11, Michael S. Tsirkin wrote:
>>> Add more checks on how did QEMU exit.
>>>
>>> Legal ways to exit right now:
>>> - exit(0) or return from main
>>> - kill(SIGTERM) - sent by testing infrastructure
>>>
>>> Anything else is illegal.
>> [...]
>>> -        if (pid =3D=3D s->qemu_pid && WIFSIGNALED(wstatus)) {
>>> +        /* waitpid returns child PID on success */
>>> +        assert(pid =3D=3D s->qemu_pid);
>>> +
>>> +        /* If exited on signal - check the reason: core dump is neve=
r OK */
>>> +        if (WIFSIGNALED(wstatus)) {
>>>              assert(!WCOREDUMP(wstatus));
>>>          }
>>> +        /* If exited normally - check exit status */
>>> +        if (WIFEXITED(wstatus)) {
>>> +            assert(!WEXITSTATUS(wstatus));
>>> +        }
>>> +        /* Valid ways to exit: right now only return from main or ex=
it */
>>> +        assert(WIFEXITED(wstatus));
>>>      }
>>>  }
>>
>> It's strange that you always get WIFEXITED(wstatus) =3D=3D true here, =
even
>> if QEMU has been terminated by SIGTERM? I assume that's due to the fac=
t
>> that QEMU intercepts SIGTERM and terminates via exit() instead?
>=20
> Right now, yes. This can of course change, so it's not
> a good idea hard-coding this assumption to deep
> in the code, imho.
>=20
>> So I
>> think you could simply replace the last three asserts with:
>>
>> 	assert(WIFEXITED(wstatus) && !WEXITSTATUS(wstatus));
>>
>>  Thomas
>=20
> I could but they would be harder to debug.
>=20
> If I see
> 	"assertion failed: !WCOREDUMP(wstatus)"
> then that is very readable.
>=20
> If I just see
> 	"assertion failed: WIFEXITED(wstatus) && !WEXITSTATUS(wstatus)"
> then I just know something went wrong.

Then simply use:

	assert(WIFEXITED(wstatus));
	assert(!WEXITSTATUS(wstatus));

If QEMU exited due to a signal, you'll see the first assert, and if it
returned a non-zero exit code, you'll see the second assert. That's all
you really need to know here, I think.

I don't think that you gain anything by checking WCOREDUMP() here. And
according to the man-page of waitpid:

 This macro is not specified in POSIX.1-2001 and is not
 available on some UNIX implementations (e.g., AIX, SunOS).
 Only use this enclosed in #ifdef WCOREDUMP ... #endif.

So if you insist on using that macro, you might need to add some #ifdef
code around it, I think.

 Thomas
