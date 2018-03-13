Received: from eggs.gnu.org ([2001:4830:134:3::10]:57881)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1evdcu-0002jx-9z
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 02:41:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1evdct-0003iu-6E
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 02:41:36 -0400
References: <20180227020550.GA5602@localhost>
	<29318663-84ef-f603-8ba2-6f1fe0fe3387@redhat.com>
	<000d9a00-7d66-f8e4-0760-04a7e246ed75@redhat.com>
	<20180313021359.GH12302@localhost.localdomain>
From: John Snow <jsnow@redhat.com>
Message-ID: <c5c3f58a-3a78-99b2-3e51-b7ebeeff30a8@redhat.com>
Date: Tue, 13 Mar 2018 02:41:13 -0400
MIME-Version: 1.0
In-Reply-To: <20180313021359.GH12302@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 resend] block/mirror: change the
 semantic of 'force' of block-job-cancel
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Liang Li <liliangleo@didichuxing.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org, Liang Li <liliang.opensource@gmail.com>, Markus Armbruster <armbru@redhat.com>, Huaitong Han <huanhuaitong@didichuxing.com>, Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>



On 03/12/2018 10:13 PM, Jeff Cody wrote:
> On Fri, Mar 02, 2018 at 11:20:55AM -0500, John Snow wrote:
>>
>>
>> On 03/02/2018 10:39 AM, Eric Blake wrote:
>>> On 02/26/2018 08:05 PM, Liang Li wrote:
>>>> When doing drive mirror to a low speed shared storage, if there was =
heavy
>>>> BLK IO write workload in VM after the 'ready' event, drive mirror
>>>> block job
>>>> can't be canceled immediately, it would keep running until the heavy
>>>> BLK IO
>>>> workload stopped in the VM.
>>>>
>>>> Libvirt depends on the current block-job-cancel semantics, which is =
that
>>>> when used without a flag after the 'ready' event, the command blocks
>>>> until data is in sync.=C2=A0 However, these semantics are awkward in=
 other
>>>> situations, for example, people may use drive mirror for realtime
>>>> backups while still wanting to use block live migration.=C2=A0 Libvi=
rt cannot
>>>> start a block live migration while another drive mirror is in progre=
ss,
>>>> but the user would rather abandon the backup attempt as broken and
>>>> proceed with the live migration than be stuck waiting for the curren=
t
>>>> drive mirror backup to finish.
>>>>
>>>> The drive-mirror command already includes a 'force' flag, which libv=
irt
>>>> does not use, although it documented the flag as only being useful t=
o
>>>> quit a job which is paused.=C2=A0 However, since quitting a paused j=
ob has
>>>> the same effect as abandoning a backup in a non-paused job (namely, =
the
>>>> destination file is not in sync, and the command completes immediate=
ly),
>>>> we can just improve the documentation to make the force flag obvious=
ly
>>>> useful.
>>>
>>> How does this interact with John's ongoing work to redo block job
>>> semantics:
>>> https://lists.gnu.org/archive/html/qemu-devel/2018-02/msg06167.html
>>>
>>>>
>>>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>>>> Cc: Jeff Cody <jcody@redhat.com>
>>>> Cc: Kevin Wolf <kwolf@redhat.com>
>>>> Cc: Max Reitz <mreitz@redhat.com>
>>>> Cc: Eric Blake <eblake@redhat.com>
>>>> Cc: John Snow <jsnow@redhat.com>
>>>> Reported-by: Huaitong Han <huanhuaitong@didichuxing.com>
>>>> Signed-off-by: Huaitong Han <huanhuaitong@didichuxing.com>
>>>> Signed-off-by: Liang Li <liliangleo@didichuxing.com>
>>>> ---
>>>
>>> But in isolation, the patch looks reasonable to me.
>>>
>>> Reviewed-by: Eric Blake <eblake@redhat.com>
>>>
>>
>> In fairness, this patch hit the list before mine did, so...
>>
>> I think it'll be OK to accommodate -- I think. It just changes the
>> nature of how fast the cancellation happens in mirror, which shouldn't
>> muck around with the general flow of job management in general. I thin=
k.
>>
>> Famous last words.
>>
>=20
> I think Kevin's pulled your series in through his branch, and this patc=
h
> conflicts with it.  Do we want to try to rebase this patch on top of yo=
ur
> series?
>=20

Hey,

Try the "review-reap" branch on my github.

https://github.com/jnsnow/qemu.git

Should just be a matter of extending the "force" flag to the user_cancel
interface and passing the bools through.

--js
