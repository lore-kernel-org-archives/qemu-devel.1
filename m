Received: from eggs.gnu.org ([2001:4830:134:3::10]:42682)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1d5bH2-0002T1-Sh
	for qemu-devel@nongnu.org; Tue, 02 May 2017 13:07:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1d5bGy-0008BR-1L
	for qemu-devel@nongnu.org; Tue, 02 May 2017 13:07:40 -0400
Received: from mail-eopbgr20104.outbound.protection.outlook.com
	([40.107.2.104]:29728
	helo=EUR02-VE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <den@virtuozzo.com>) id 1d5bGw-00088m-CR
	for qemu-devel@nongnu.org; Tue, 02 May 2017 13:07:35 -0400
References: <1493732857-10721-1-git-send-email-den@openvz.org>
	<87bmrbgvzf.fsf@dusky.pond.sub.org>
	<e90d1680-6212-862e-bd3b-fdc415ec1890@openvz.org>
	<877f1zcjcf.fsf@dusky.pond.sub.org> <20170502163629.GA5640@work-vm>
	<20170502164838.GL16624@redhat.com>
From: "Denis V. Lunev" <den@openvz.org>
Message-ID: <1dda0b40-e473-638e-7a89-891f578d3186@openvz.org>
Date: Tue, 2 May 2017 20:07:26 +0300
MIME-Version: 1.0
In-Reply-To: <20170502164838.GL16624@redhat.com>
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
To: "Daniel P. Berrange" <berrange@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org

On 05/02/2017 07:48 PM, Daniel P. Berrange wrote:
> On Tue, May 02, 2017 at 05:36:30PM +0100, Dr. David Alan Gilbert wrote:=

>> * Markus Armbruster (armbru@redhat.com) wrote:
>>> "Denis V. Lunev" <den@openvz.org> writes:
>>>
>>>> On 05/02/2017 05:43 PM, Markus Armbruster wrote:
>>>>> "Denis V. Lunev" <den@openvz.org> writes:
>>>>>
>>>>>> Right now QMP and HMP monitors read 1 byte at a time from the sock=
et, which
>>>>>> is very inefficient. With 100+ VMs on the host this easily reasult=
s in
>>>>>> a lot of unnecessary system calls and CPU usage in the system.
>>>>>>
>>>>>> This patch changes the amount of data to read to 4096 bytes, which=
 matches
>>>>>> buffer size on the channel level. Fortunately, monitor protocol is=

>>>>>> synchronous right now thus we should not face side effects in real=
ity.
>>>>> Can you explain briefly why this relies on "synchronous"?  I've spe=
nt
>>>>> all of two seconds on the question myself...
>>>> Each command is processed in sequence as it appears in the
>>>> channel. The answer to the command is sent and only after that
>>>> next command is processed.
>>> Yes, that's how QMP works.
>>>
>>>> Theoretically tith asynchronous processing we can have some side
>>>> effects due to changed buffer size.
>>> What kind of side effects do you have in mind?
>>>
>>> It's quite possible that this obviously inefficient way to read had s=
ome
>>> deep reason back when it was created.  Hmm, git-blame is our friend:
>>>
>>> commit c62313bbdc48f72e93fa8196f2fff96ba35e4e9d
>>> Author: Jan Kiszka <jan.kiszka@siemens.com>
>>> Date:   Fri Dec 4 14:05:29 2009 +0100
>>>
>>>     monitor: Accept input only byte-wise
>>>    =20
>>>     This allows to suspend command interpretation and execution
>>>     synchronously, e.g. during migration.
>>>    =20
>>>     Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>>     Signed-off-by: Anthony Liguori <aliguori@us.ibm.com>
>> I don't think I understand why that's a problem; if we read more bytes=
,
>> we're not going to interpret them and execute them until after the pre=
vious
>> command returns are we?
> Actually it sees we might do, due to the way the "migrate" command work=
s
> in HMP when you don't give the '-d' flag.
>
> Most monitors commands will block the caller until they are finished,
> but "migrate" is different. The hmp_migrate() method will return
> immediately, but we call monitor_suspend() to block processing of
> further commands. If another command has already been read off
> the wire though (due to "monitor_read" having a buffer that contains
> multiple commands), we would in fact start processing this command
> despite having suspended the monitor.
>
> This is only a problem, however, if the client app has issued "migrate"=

> followed by another command, at the same time without waiting for the
> respond to "migrate". So in practice the only way you'd hit the bug
> is probably if you just cut+paste a big chunk of commands into the
> monitor at once without waiting for completion and one of the commands
> was "migrate" without "-d".
>
> Still, I think we would need to figure out a proper fix for this before=

> we could increase the buffer size.
>
> Regards,
> Daniel

There is one thing, which simplifies things a lot.
- suspend_cnt can be increased only from 2 places:
  1) monitor_event(), which is called for real HMP monitor only

  2) monitor_suspend(), which can increment suspend_cnt
      only if mon->rs !=3D NULL, which also means that the
      monitor is specifically configured HMP monitor.

So, we can improve the patch (for now) with the following
tweak:

static int monitor_can_read(void *opaque)
{
    Monitor *mon =3D opaque;
  =20
    if (monitor_is_qmp(mon))
        return 4096;  =20
    return (mon->suspend_cnt =3D=3D 0) ? 1 : 0;
}

This will solve my case completely and does not break any
backward compatibility.

Den
