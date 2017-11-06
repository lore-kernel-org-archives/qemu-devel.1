Received: from eggs.gnu.org ([2001:4830:134:3::10]:34973)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eBh6J-0000fz-Gl
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 08:06:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eBh6D-0002W2-KD
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 08:06:03 -0500
Received: from mail-wr0-x234.google.com ([2a00:1450:400c:c0c::234]:55379)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1eBh6D-0002VS-CU
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 08:05:57 -0500
Received: by mail-wr0-x234.google.com with SMTP id l8so8491883wre.12
	for <qemu-devel@nongnu.org>; Mon, 06 Nov 2017 05:05:57 -0800 (PST)
References: <20171031112457.10516.8971.stgit@pasha-VirtualBox>
	<20171031112633.10516.44062.stgit@pasha-VirtualBox>
	<92aa3279-66b5-b765-b36b-2acb6413bd47@redhat.com>
	<001301d35484$75071110$5f153330$@ru> <87tvybhewj.fsf@linaro.org>
	<6ef0c3d0-41e5-d3cf-e84d-857ff1b47e48@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <6ef0c3d0-41e5-d3cf-e84d-857ff1b47e48@redhat.com>
Date: Mon, 06 Nov 2017 13:05:54 +0000
Message-ID: <8760ansgjx.fsf@linaro.org>
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

> On 03/11/2017 10:47, Alex Benn=C3=A9e wrote:
>>   As deadlocks are easy to introduce a new rule is introduced that the
>>   replay_mutex_lock is taken before any BQL locks. Conversely you cannot
>>   release the replay_lock while the BQL is still held.
>
> I agree with the former, but the latter is unnecessary.

I'm trying to think of occasions where this might cause us problems. The
BQL is a event level lock, generally held for HW event serialisation and
the replay_lock is synchronising batches of those events to the
advancement of "time". How about:

  As deadlocks are easy to introduce a new rule is introduced that the
  replay_mutex_lock is taken before any BQL locks. While you would
  usually unlock in the reverse order this isn't strictly enforced. The
  important thing is any work to record the state of a given hardware
  transaction has been completed as once the BQL is released the
  execution state may move on.

--=20
Alex Benn=C3=A9e
