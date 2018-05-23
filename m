Received: from eggs.gnu.org ([2001:4830:134:3::10]:41404)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ciro.santilli@gmail.com>) id 1fLW9K-0007YV-UW
	for qemu-devel@nongnu.org; Wed, 23 May 2018 11:58:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ciro.santilli@gmail.com>) id 1fLW9J-00023e-SW
	for qemu-devel@nongnu.org; Wed, 23 May 2018 11:58:03 -0400
Received: from mail-it0-x233.google.com ([2607:f8b0:4001:c0b::233]:55617)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ciro.santilli@gmail.com>)
	id 1fLW9J-00023W-Mr
	for qemu-devel@nongnu.org; Wed, 23 May 2018 11:58:01 -0400
Received: by mail-it0-x233.google.com with SMTP id 144-v6so5020249iti.5
	for <qemu-devel@nongnu.org>; Wed, 23 May 2018 08:58:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <000301d3f299$e1e20340$a5a609c0$@ru>
References: <20180523064941.26016.74274.stgit@pasha-VirtualBox>
	<CAFXrp_fOpwvT0qOZO+L+5LJJvGsj3bXp_GxhbLt-mZN9cN2nPg@mail.gmail.com>
	<000301d3f299$e1e20340$a5a609c0$@ru>
From: Ciro Santilli <ciro.santilli@gmail.com>
Date: Wed, 23 May 2018 16:57:40 +0100
Message-ID: <CAFXrp_foEgBeKhZGFmRhXYaK4skDF4y4_M_4HEDR0ucAT20oaQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 00/19] reverse debugging
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <dovgaluk@ispras.ru>
Cc: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, QEMU Developers <qemu-devel@nongnu.org>

On Wed, May 23, 2018 at 2:28 PM, Pavel Dovgalyuk <dovgaluk@ispras.ru> wrote:
>> From: Ciro Santilli [mailto:ciro.santilli@gmail.com]
>> On Wed, May 23, 2018 at 7:49 AM, Pavel Dovgalyuk
>> <Pavel.Dovgaluk@ispras.ru> wrote:
>> > GDB remote protocol supports reverse debugging of the targets.
>> > It includes 'reverse step' and 'reverse continue' operations.
>> > The first one finds the previous step of the execution,
>> > and the second one is intended to stop at the last breakpoint that
>> > would happen when the program is executed normally.
>> >
>> > Reverse debugging is possible in the replay mode, when at least
>> > one snapshot was created at the record or replay phase.
>> > QEMU can use these snapshots for travelling back in time with GDB.
>> >
>> > Running the execution in replay mode allows using GDB reverse debugging
>> > commands:
>> >  - reverse-stepi (or rsi): Steps one instruction to the past.
>> >    QEMU loads on of the prior snapshots and proceeds to the desired
>> >    instruction forward. When that step is reaches, execution stops.
>> >  - reverse-continue (or rc): Runs execution "backwards".
>> >    QEMU tries to find breakpoint or watchpoint by loaded prior snapshot
>> >    and replaying the execution. Then QEMU loads snapshots again and
>> >    replays to the latest breakpoint. When there are no breakpoints in
>> >    the examined section of the execution, QEMU finds one more snapshot
>> >    and tries again. After the first snapshot is processed, execution
>> >    stops at this snapshot.
>> >
>> > The set of patches include the following modifications:
>> >  - gdbstub update for reverse debugging support
>> >  - functions that automatically perform reverse step and reverse
>> >    continue operations
>> >  - hmp/qmp commands for manipulating the replay process
>> >  - improvement of the snapshotting for saving the execution step
>> >    in the snapshot parameters
>> >  - other record/replay fixes
>> >
>> > The patches are available in the repository:
>> > https://github.com/ispras/qemu/tree/rr-180428
>> >
>>
>> This branch appears to contain one month old commits, is it the correct one?
>
> Right.
> There were no significant changes except the fix which was already queued by Paolo.
> As soon as it is upstreamed, I'll update the branch.
>

OK.

At the current branch 6b23df0d0ca0e5e999cd12af2b18b2a95faeb421 still
observe the same behaviour as mentioned at:
https://lists.gnu.org/archive/html/qemu-devel/2018-04/msg04669.html

If I try to savevm during the debug replay to speedup up reverse
execution, QEMU hangs.

Have you managed to reproduce that? Or is this not an intended use
case, i.e. only savevm during record is supported?

Am I correct to understand that being able to do savevms in the middle
of a long execution is the critical feature that this adds? Otherwise
we are essentially replaying from the initial snapshot every time, so
we might as well just restart a new replay, is that true?

> Pavel Dovgalyuk
>
