Received: from eggs.gnu.org ([2001:4830:134:3::10]:44281)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1elgWF-0002Ly-CF
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 14:45:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1elgWC-0002f8-9M
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 14:45:35 -0500
References: <20180107122336.29333-1-richiejp@f-m.fm>
	<fd5f5f12-e081-6f19-54af-3b560139bb78@redhat.com>
	<5cf19623-72ac-fb8b-2054-a60d42419ec6@redhat.com>
	<20180111130427.GG8326@redhat.com>
	<20180213105024.GC5083@localhost.localdomain>
	<20180213143001.GA2354@rkaganb.sw.ru> <20180213143615.GN573@redhat.com>
	<20180213144521.GI5083@localhost.localdomain>
	<20180213144838.GO573@redhat.com>
	<1ac12a06-4031-f35c-da18-8c1cbbf7921d@redhat.com>
From: "Denis V. Lunev" <den@virtuozzo.com>
Message-ID: <bb0b226b-b276-79dc-378b-c32ae5716d93@virtuozzo.com>
Date: Tue, 13 Feb 2018 22:45:23 +0300
MIME-Version: 1.0
In-Reply-To: <1ac12a06-4031-f35c-da18-8c1cbbf7921d@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 1/2] Add save-snapshot,
 load-snapshot and delete-snapshot to QAPI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Cc: Richard Palethorpe <richiejp@f-m.fm>, Qemu-block <qemu-block@nongnu.org>, quintela@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org, Denis Plotnikov <dplotnikov@virtuozzo.com>, Roman Kagan <rkagan@virtuozzo.com>, Max Reitz <mreitz@redhat.com>, rpalethorpe@suse.com, dgilbert@redhat.com

On 02/13/2018 07:46 PM, Eric Blake wrote:
> On 02/13/2018 08:48 AM, Daniel P. Berrang=C3=A9 wrote:
>>>> No, that's policy decision that doesn't matter from QMP pov. If the
>>>> mgmt
>>>> app wants the snapshot to be wrt to the initial time, it can simply
>>>> invoke the "stop" QMP command before doing the live migration and
>>>> "cont" afterwards.
>>>
>>> That would be non-live. I think Roman means a live snapshot that saves
>>> the state at the beginning of the operation. Basically the difference
>>> between blockdev-backup (state at the beginning) and blockdev-mirror
>>> (state at the end), except for a whole VM.
>>
>> That doesn't seem practical unless you can instantaneously write out
>> the entire guest RAM to disk without blocking, or can somehow snapshot
>> the RAM so you can write out a consistent view of the original RAM,
>> while the guest continues to dirty RAM pages.
>
> One idea for that is via fork()'s copy-on-write semantics; the parent
> continues processing the guest, while the child writes out RAM pages.
> Pages touched by the guest in the parent are now cleanly copied by the
> OS so that the child can take all the time it wants, but still writes
> out the state of the guest at the time of the fork().=C2=A0 It may be
> possible to use userfaultfd to achieve the same effects without a fork().
>
this would be problematic as we for sure will face memory problems.
Guest stalls are IMHO much less problematic (as they are expected
by end-user) then memory shortage.

Anyway, this is discussable.

Den
