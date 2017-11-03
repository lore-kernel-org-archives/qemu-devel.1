Received: from eggs.gnu.org ([2001:4830:134:3::10]:33261)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eAYa6-00049Y-1J
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 05:48:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eAYa2-0002eh-U9
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 05:48:06 -0400
Received: from mail-wr0-x229.google.com ([2a00:1450:400c:c0c::229]:56175)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1eAYa2-0002eL-N0
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 05:48:02 -0400
Received: by mail-wr0-x229.google.com with SMTP id l8so1956612wre.12
	for <qemu-devel@nongnu.org>; Fri, 03 Nov 2017 02:48:02 -0700 (PDT)
References: <20171031112457.10516.8971.stgit@pasha-VirtualBox>
	<20171031112633.10516.44062.stgit@pasha-VirtualBox>
	<92aa3279-66b5-b765-b36b-2acb6413bd47@redhat.com>
	<001301d35484$75071110$5f153330$@ru>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <001301d35484$75071110$5f153330$@ru>
Date: Fri, 03 Nov 2017 09:47:56 +0000
Message-ID: <87tvybhewj.fsf@linaro.org>
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
To: Pavel Dovgalyuk <dovgaluk@ispras.ru>
Cc: 'Paolo Bonzini' <pbonzini@redhat.com>, 'Pavel Dovgalyuk' <Pavel.Dovgaluk@ispras.ru>, qemu-devel@nongnu.org, kwolf@redhat.com, peter.maydell@linaro.org, boost.lists@gmail.com, quintela@redhat.com, jasowang@redhat.com, mst@redhat.com, zuban32s@gmail.com, maria.klimushenkova@ispras.ru, kraxel@redhat.com


Pavel Dovgalyuk <dovgaluk@ispras.ru> writes:

>> From: Paolo Bonzini [mailto:pbonzini@redhat.com]
>> On 31/10/2017 12:26, Pavel Dovgalyuk wrote:
>> > +    /* We need to drop the replay_lock so any vCPU threads woken up
>> > +     * can finish their replay tasks
>> > +     */
>> > +    if (replay_mode !=3D REPLAY_MODE_NONE) {
>> > +        g_assert(replay_mutex_locked());
>> > +        qemu_mutex_unlock_iothread();
>> > +        replay_mutex_unlock();
>> > +        qemu_mutex_lock_iothread();
>> > +    }
>>
>> The assert+unlock+lock here is unnecessary; just do
>>
>>     if (replay_mode !=3D REPLAY_MODE_NONE) {
>>         replay_mutex_unlock();
>>     }
>>
>> which according to a previous suggestion can become just
>>
>>     replay_mutex_unlock();
>
> We can't remove qemu_mutex_unlock_iothread(), because there is an assert
> inside replay_mutex_unlock(), which checks that iothread is unlocked.

I'm certainly open to reviewing the locking order rules if it is easier
another way around. I'm just conscious that it's easy to deadlock if we
don't pay attention. This is what I wrote in replay.txt:

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

  As deadlocks are easy to introduce a new rule is introduced that the
  replay_mutex_lock is taken before any BQL locks. Conversely you cannot
  release the replay_lock while the BQL is still held.

>
>>
>> >      while (!all_vcpus_paused()) {
>> >          qemu_cond_wait(&qemu_pause_cond, &qemu_global_mutex);
>> >          CPU_FOREACH(cpu) {
>> >              qemu_cpu_kick(cpu);
>> >          }
>> >      }
>> > +
>> > +    if (replay_mode !=3D REPLAY_MODE_NONE) {
>> > +        qemu_mutex_unlock_iothread();
>> > +        replay_mutex_lock();
>> > +        qemu_mutex_lock_iothread();
>> > +    }
>>
>
> Pavel Dovgalyuk


--
Alex Benn=C3=A9e
