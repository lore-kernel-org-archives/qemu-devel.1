Received: from eggs.gnu.org ([2001:4830:134:3::10]:54129)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eBkNS-0004GF-AV
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 11:35:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eBkNO-0001U2-G5
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 11:35:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33374)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eBkNO-0001Sl-9g
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 11:35:54 -0500
References: <20171031112457.10516.8971.stgit@pasha-VirtualBox>
	<20171031112633.10516.44062.stgit@pasha-VirtualBox>
	<92aa3279-66b5-b765-b36b-2acb6413bd47@redhat.com>
	<001301d35484$75071110$5f153330$@ru> <87tvybhewj.fsf@linaro.org>
	<6ef0c3d0-41e5-d3cf-e84d-857ff1b47e48@redhat.com>
	<8760ansgjx.fsf@linaro.org>
	<b1364337-a113-26cb-54b7-1251b909956a@redhat.com>
	<87zi7zqshq.fsf@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a380275b-b7e8-1aba-535d-500a22acfd44@redhat.com>
Date: Mon, 6 Nov 2017 17:35:43 +0100
MIME-Version: 1.0
In-Reply-To: <87zi7zqshq.fsf@linaro.org>
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

On 06/11/2017 17:30, Alex Benn=C3=A9e wrote:
>   Previously the synchronisation of the main thread and the vCPU thread
>   was ensured by the holding of the BQL. However the trend has been to
>   reduce the time the BQL was held across the system including under TC=
G
>   system emulation. As it is important that batches of events are kept
>   in sequence (e.g. expiring timers and checkpoints in the main thread
>   while instruction checkpoints are written by the vCPU thread) we need
>   another lock to keep things in lock-step. This role is now handled by
>   the replay_mutex_lock. It used to be held only for each event being
>   written but now it is held for a whole execution period. This results
>   in a deterministic ping-pong between the two main threads.

I would remove the last two sentences (which might belong in a commit
message, but not in documentation).

>   As the BQL is now a finer grained lock than the replay_lock it is
>   almost certainly a bug taking the replay_mutex_lock while the BQL is
>   held. This is enforced by an assert. While the unlocks are usually in
>   the reverse order it is not necessary and therefor you can drop the
>   replay_lock while holding the BQL rather than doing any more
>   unlock/unlock/lock sequences.

As the BQL is now a finer grained lock than the replay_lock it is almost
certainly a bug, and a source of deadlocks, to take the
replay_mutex_lock while the BQL is held.  This is enforced by an assert.
 While the unlocks are usually in the reverse order, this is not
necessary; you can drop the replay_lock while holding the BQL, without
doing a more complicated unlock_iothread/replay_unlock/lock_iothread
sequence.

Paolo
