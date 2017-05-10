Received: from eggs.gnu.org ([2001:4830:134:3::10]:52560)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1d8U3p-00081E-L8
	for qemu-devel@nongnu.org; Wed, 10 May 2017 12:01:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1d8U3m-0006f9-BG
	for qemu-devel@nongnu.org; Wed, 10 May 2017 12:01:57 -0400
Received: from mail-db5eur01on0107.outbound.protection.outlook.com
	([104.47.2.107]:10078
	helo=EUR01-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <den@virtuozzo.com>) id 1d8U3l-0006eB-GO
	for qemu-devel@nongnu.org; Wed, 10 May 2017 12:01:54 -0400
References: <1493732857-10721-1-git-send-email-den@openvz.org>
	<87bmrbgvzf.fsf@dusky.pond.sub.org>
	<e90d1680-6212-862e-bd3b-fdc415ec1890@openvz.org>
	<877f1zcjcf.fsf@dusky.pond.sub.org> <20170502163629.GA5640@work-vm>
	<20170502164838.GL16624@redhat.com>
	<1dda0b40-e473-638e-7a89-891f578d3186@openvz.org>
	<87shkm2n62.fsf@dusky.pond.sub.org>
	<819458e5-bc6f-cb1b-ae81-50805ff78d39@openvz.org>
	<87fugcu2pj.fsf@dusky.pond.sub.org>
From: "Denis V. Lunev" <den@openvz.org>
Message-ID: <624ca2f7-6729-f421-78bf-dea9c697b422@openvz.org>
Date: Wed, 10 May 2017 18:01:45 +0200
MIME-Version: 1.0
In-Reply-To: <87fugcu2pj.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/1] monitor: increase amount of data for
 monitor to read
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org

On 05/10/2017 05:54 PM, Markus Armbruster wrote:
> "Denis V. Lunev" <den@openvz.org> writes:
>
>> On 05/03/2017 02:29 PM, Markus Armbruster wrote:
>>> "Denis V. Lunev" <den@openvz.org> writes:
>>>
>>>> On 05/02/2017 07:48 PM, Daniel P. Berrange wrote:
>>>>> On Tue, May 02, 2017 at 05:36:30PM +0100, Dr. David Alan Gilbert wr=
ote:
>>>>>> * Markus Armbruster (armbru@redhat.com) wrote:
>>>>>>> "Denis V. Lunev" <den@openvz.org> writes:
>>>>>>>
>>>>>>>> On 05/02/2017 05:43 PM, Markus Armbruster wrote:
>>>>>>>>> "Denis V. Lunev" <den@openvz.org> writes:
>>>>>>>>>
>>>>>>>>>> Right now QMP and HMP monitors read 1 byte at a time from the =
socket, which
>>>>>>>>>> is very inefficient. With 100+ VMs on the host this easily rea=
sults in
>>>>>>>>>> a lot of unnecessary system calls and CPU usage in the system.=

>>>>>>>>>>
>>>>>>>>>> This patch changes the amount of data to read to 4096 bytes, w=
hich matches
>>>>>>>>>> buffer size on the channel level. Fortunately, monitor protoco=
l is
>>>>>>>>>> synchronous right now thus we should not face side effects in =
reality.
>>>>>>>>> Can you explain briefly why this relies on "synchronous"?  I've=
 spent
>>>>>>>>> all of two seconds on the question myself...
>>>>>>>> Each command is processed in sequence as it appears in the
>>>>>>>> channel. The answer to the command is sent and only after that
>>>>>>>> next command is processed.
>>>>>>> Yes, that's how QMP works.
>>>>>>>
>>>>>>>> Theoretically tith asynchronous processing we can have some side=

>>>>>>>> effects due to changed buffer size.
>>>>>>> What kind of side effects do you have in mind?
>>>>>>>
>>>>>>> It's quite possible that this obviously inefficient way to read h=
ad some
>>>>>>> deep reason back when it was created.  Hmm, git-blame is our frie=
nd:
>>>>>>>
>>>>>>> commit c62313bbdc48f72e93fa8196f2fff96ba35e4e9d
>>>>>>> Author: Jan Kiszka <jan.kiszka@siemens.com>
>>>>>>> Date:   Fri Dec 4 14:05:29 2009 +0100
>>>>>>>
>>>>>>>     monitor: Accept input only byte-wise
>>>>>>>    =20
>>>>>>>     This allows to suspend command interpretation and execution
>>>>>>>     synchronously, e.g. during migration.
>>>>>>>    =20
>>>>>>>     Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>>>>>>     Signed-off-by: Anthony Liguori <aliguori@us.ibm.com>
>>>>>> I don't think I understand why that's a problem; if we read more b=
ytes,
>>>>>> we're not going to interpret them and execute them until after the=
 previous
>>>>>> command returns are we?
>>>>> Actually it sees we might do, due to the way the "migrate" command =
works
>>>>> in HMP when you don't give the '-d' flag.
>>>>>
>>>>> Most monitors commands will block the caller until they are finishe=
d,
>>>>> but "migrate" is different. The hmp_migrate() method will return
>>>>> immediately, but we call monitor_suspend() to block processing of
>>>>> further commands. If another command has already been read off
>>>>> the wire though (due to "monitor_read" having a buffer that contain=
s
>>>>> multiple commands), we would in fact start processing this command
>>>>> despite having suspended the monitor.
>>>>>
>>>>> This is only a problem, however, if the client app has issued "migr=
ate"
>>>>> followed by another command, at the same time without waiting for t=
he
>>>>> respond to "migrate". So in practice the only way you'd hit the bug=

>>>>> is probably if you just cut+paste a big chunk of commands into the
>>>>> monitor at once without waiting for completion and one of the comma=
nds
>>>>> was "migrate" without "-d".
>>>>>
>>>>> Still, I think we would need to figure out a proper fix for this be=
fore
>>>>> we could increase the buffer size.
>>>>>
>>>>> Regards,
>>>>> Daniel
>>>> There is one thing, which simplifies things a lot.
>>>> - suspend_cnt can be increased only from 2 places:
>>>>   1) monitor_event(), which is called for real HMP monitor only
>>>>
>>>>   2) monitor_suspend(), which can increment suspend_cnt
>>>>       only if mon->rs !=3D NULL, which also means that the
>>>>       monitor is specifically configured HMP monitor.
>>> I think you're right.  Monitor member suspend_cnt could use a comment=
=2E
>>>
>>> If there are more members that apply only to HMP, we should collect t=
hem
>>> in a MonitorHMP struct, similar to MonitorQMP.
>>>
>> I think that this make sense even if this will be a single member as
>> the readability would be improved.
>>
>>
>>>> So, we can improve the patch (for now) with the following
>>>> tweak:
>>>>
>>>> static int monitor_can_read(void *opaque)
>>>> {
>>>>     Monitor *mon =3D opaque;
>>>>   =20
>>>>     if (monitor_is_qmp(mon))
>>>>         return 4096;  =20
>>>>     return (mon->suspend_cnt =3D=3D 0) ? 1 : 0;
>>>> }
>>> Instead of adding the conditional, I'd split this into two functions,=

>>> one for HMP and one for QMP, just like we split the other two callbac=
ks.
>> good idea
>>
>>>> This will solve my case completely and does not break any
>>>> backward compatibility.
>>> No change for HMP.  Okay.
>>>
>>> For QMP, monitor_qmp_read() feeds whatever it gets to the JSON lexer.=

>>> It currently gets one character at a time, because that's how much
>>> monitor_can_read() returns.  With your change, it gets up to 4KiB.
>>>
>>> The JSON lexer feeds tokens to the JSON streamer one at a time until =
it
>>> has consumed everything it was fed.
>>>
>>> The JSON streamer accumulates tokens, parsing them just enough to kno=
w
>>> when it has a complete expression.  It pushes the expression to the Q=
MP
>>> expression handler immediately.
>>>
>>> The QMP expression handler calls the JSON parser to parse the tokens
>>> into a QObject, then dispatches to QMP command handlers accordingly.
>>>
>>> Everything's synchronous.  When a QMP command handler runs, the calli=
ng
>>> JSON streamer invocation is handling the command's final closing brac=
e,
>>> and so is the calling JSON lexer.  After the QMP command handler
>>> returns, the JSON streamer returns.  The JSON lexer then looks at the=

>>> next character if there are more, else it returns.
>>>
>>> The only difference to before that I can see is that we can read ahea=
d.
>>> That's a feature.
>>>
>>> Looks safe to me.  Opinions?
>> Looks fair to me.
> Care to post a formal patch?  Or did I miss it?
I will. Sorry, we have big holidays in Russia which
were enlarged by my vacation.

I'll try to do that tomorrow.

Den
