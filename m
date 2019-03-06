Received: from eggs.gnu.org ([209.51.188.92]:47371)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h1Pmt-0008VZ-1G
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 01:12:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h1Pms-0000Nr-DM
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 01:12:19 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20190225183757.27378-1-armbru@redhat.com>
	<20190225183757.27378-7-armbru@redhat.com>
	<87bm2qzfyn.fsf@dusky.pond.sub.org>
	<d610dae9-9c16-9ccc-762a-79cff5ed2be8@redhat.com>
Date: Wed, 06 Mar 2019 07:12:11 +0100
In-Reply-To: <d610dae9-9c16-9ccc-762a-79cff5ed2be8@redhat.com> (Laszlo Ersek's
	message of "Tue, 5 Mar 2019 18:08:11 +0100")
Message-ID: <87lg1s1qh0.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [RFC PATCH 6/6] pc: Support firmware configuration
 with -blockdev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, pkrempa@redhat.com, qemu-block@nongnu.org, mst@redhat.com, mreitz@redhat.com, pbonzini@redhat.com

Laszlo Ersek <lersek@redhat.com> writes:

> On 03/04/19 18:50, Markus Armbruster wrote:
>
>> Alright, we can call object_get_class(dev_obj)->unparent(dev_obj).
>> 
>> Final complication: if I call just that, the device's reference counter
>> goes down to zero in the middle of device_unparent(), and we use after
>> free.  So I bracket he call with object_ref() and object_unref().
>
> I don't think that requiring such a bracketing is necessarily a problem.
> I vaguely remember reviewing a kernel patch 6 or so years ago where the
> patch used the same idea, with those "get" and "put" functions (the bug
> the patch was fixing was that the last reference was "temporarily" lost
> mid-operation).

I don't regard it as problem.  My voodoo coding just wasn't prepared for
it.

> So perhaps this can be addressed, for the general case, by extending the
> documentation of device_unparent(). (The function has no documentation
> at all, at the moment.)

I know just enough to be dangerous here, not enough to write
documentation.

We really need a complete life cycle diagram for devices.  The closest
we have is the section on realization in qdev-core.h, which lets me
divine only a part of the life cycle.  The missing part I struggled with
here is how to go from device state "created, not realized" to
"destroyed".
