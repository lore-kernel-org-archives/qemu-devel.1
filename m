Received: from eggs.gnu.org ([2001:4830:134:3::10]:36864)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eBhBE-0002V7-CS
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 08:11:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eBhBA-0004te-Cr
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 08:11:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40446)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eBhBA-0004t1-73
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 08:11:04 -0500
References: <20171031112457.10516.8971.stgit@pasha-VirtualBox>
	<20171031112633.10516.44062.stgit@pasha-VirtualBox>
	<92aa3279-66b5-b765-b36b-2acb6413bd47@redhat.com>
	<001301d35484$75071110$5f153330$@ru> <87tvybhewj.fsf@linaro.org>
	<6ef0c3d0-41e5-d3cf-e84d-857ff1b47e48@redhat.com>
	<8760ansgjx.fsf@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b1364337-a113-26cb-54b7-1251b909956a@redhat.com>
Date: Mon, 6 Nov 2017 14:10:50 +0100
MIME-Version: 1.0
In-Reply-To: <8760ansgjx.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: Pavel Dovgalyuk <dovgaluk@ispras.ru>, 'Pavel Dovgalyuk' <Pavel.Dovgaluk@ispras.ru>, qemu-devel@nongnu.org, kwolf@redhat.com, peter.maydell@linaro.org, boost.lists@gmail.com, quintela@redhat.com, jasowang@redhat.com, mst@redhat.com, zuban32s@gmail.com, maria.klimushenkova@ispras.ru, kraxel@redhat.com

On 06/11/2017 14:05, Alex Benn=C3=A9e wrote:
>=20
> Paolo Bonzini <pbonzini@redhat.com> writes:
>=20
>> On 03/11/2017 10:47, Alex Benn=C3=A9e wrote:
>>>   As deadlocks are easy to introduce a new rule is introduced that th=
e
>>>   replay_mutex_lock is taken before any BQL locks. Conversely you can=
not
>>>   release the replay_lock while the BQL is still held.
>>
>> I agree with the former, but the latter is unnecessary.
>=20
> I'm trying to think of occasions where this might cause us problems. Th=
e
> BQL is a event level lock, generally held for HW event serialisation an=
d
> the replay_lock is synchronising batches of those events to the
> advancement of "time".

I would say that the BQL is "just" protecting data that has no other
finer-grain lock.

The replay_lock is (besides protecting record/replay status)
synchronizing events so that threads advance in lockstep, but the BQL is
also protecting things unrelated to recorded events.  For those it makes
sense to take the BQL without the replay lock.  Replacing
unlock_iothread/unlock_replay/lock_iothread with just unlock_replay is
only an optimization.

Paolo

> How about:
>=20
>   As deadlocks are easy to introduce a new rule is introduced that the
>   replay_mutex_lock is taken before any BQL locks. While you would
>   usually unlock in the reverse order this isn't strictly enforced. The
>   important thing is any work to record the state of a given hardware
>   transaction has been completed as once the BQL is released the
>   execution state may move on.
>=20
