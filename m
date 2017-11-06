Received: from eggs.gnu.org ([2001:4830:134:3::10]:51994)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eBkIk-0000wF-OY
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 11:31:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eBkIe-0007Ei-No
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 11:31:06 -0500
Received: from mail-wr0-x229.google.com ([2a00:1450:400c:c0c::229]:51473)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1eBkIe-0007DV-EO
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 11:31:00 -0500
Received: by mail-wr0-x229.google.com with SMTP id j15so9153094wre.8
	for <qemu-devel@nongnu.org>; Mon, 06 Nov 2017 08:31:00 -0800 (PST)
References: <20171031112457.10516.8971.stgit@pasha-VirtualBox>
	<20171031112633.10516.44062.stgit@pasha-VirtualBox>
	<92aa3279-66b5-b765-b36b-2acb6413bd47@redhat.com>
	<001301d35484$75071110$5f153330$@ru> <87tvybhewj.fsf@linaro.org>
	<6ef0c3d0-41e5-d3cf-e84d-857ff1b47e48@redhat.com>
	<8760ansgjx.fsf@linaro.org>
	<b1364337-a113-26cb-54b7-1251b909956a@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <b1364337-a113-26cb-54b7-1251b909956a@redhat.com>
Date: Mon, 06 Nov 2017 16:30:57 +0000
Message-ID: <87zi7zqshq.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 17/26] replay: push replay_mutex_lock
 up the call tree
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Pavel Dovgalyuk <dovgaluk@ispras.ru>, 'Pavel Dovgalyuk' <Pavel.Dovgaluk@ispras.ru>, qemu-devel@nongnu.org, kwolf@redhat.com, peter.maydell@linaro.org, boost.lists@gmail.com, quintela@redhat.com, jasowang@redhat.com, mst@redhat.com, zuban32s@gmail.com, maria.klimushenkova@ispras.ru, kraxel@redhat.com


Paolo Bonzini <pbonzini@redhat.com> writes:

> On 06/11/2017 14:05, Alex Benn=C3=A9e wrote:
>>
>> Paolo Bonzini <pbonzini@redhat.com> writes:
>>
>>> On 03/11/2017 10:47, Alex Benn=C3=A9e wrote:
>>>>   As deadlocks are easy to introduce a new rule is introduced that the
>>>>   replay_mutex_lock is taken before any BQL locks. Conversely you cann=
ot
>>>>   release the replay_lock while the BQL is still held.
>>>
>>> I agree with the former, but the latter is unnecessary.
>>
>> I'm trying to think of occasions where this might cause us problems. The
>> BQL is a event level lock, generally held for HW event serialisation and
>> the replay_lock is synchronising batches of those events to the
>> advancement of "time".
>
> I would say that the BQL is "just" protecting data that has no other
> finer-grain lock.
>
> The replay_lock is (besides protecting record/replay status)
> synchronizing events so that threads advance in lockstep, but the BQL is
> also protecting things unrelated to recorded events.  For those it makes
> sense to take the BQL without the replay lock.  Replacing
> unlock_iothread/unlock_replay/lock_iothread with just unlock_replay is
> only an optimization.

OK, let's revise to:

  Locking and thread synchronisation
  ----------------------------------

  Previously the synchronisation of the main thread and the vCPU thread
  was ensured by the holding of the BQL. However the trend has been to
  reduce the time the BQL was held across the system including under TCG
  system emulation. As it is important that batches of events are kept
  in sequence (e.g. expiring timers and checkpoints in the main thread
  while instruction checkpoints are written by the vCPU thread) we need
  another lock to keep things in lock-step. This role is now handled by
  the replay_mutex_lock. It used to be held only for each event being
  written but now it is held for a whole execution period. This results
  in a deterministic ping-pong between the two main threads.

  As the BQL is now a finer grained lock than the replay_lock it is
  almost certainly a bug taking the replay_mutex_lock while the BQL is
  held. This is enforced by an assert. While the unlocks are usually in
  the reverse order it is not necessary and therefor you can drop the
  replay_lock while holding the BQL rather than doing any more
  unlock/unlock/lock sequences.

>
> Paolo
>
>> How about:
>>
>>   As deadlocks are easy to introduce a new rule is introduced that the
>>   replay_mutex_lock is taken before any BQL locks. While you would
>>   usually unlock in the reverse order this isn't strictly enforced. The
>>   important thing is any work to record the state of a given hardware
>>   transaction has been completed as once the BQL is released the
>>   execution state may move on.
>>


--
Alex Benn=C3=A9e
