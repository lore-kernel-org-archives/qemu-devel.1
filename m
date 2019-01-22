Received: from eggs.gnu.org ([209.51.188.92]:59077)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1glqH7-0006We-Et
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 02:15:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1glqH6-0001vX-2K
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 02:15:09 -0500
Received: from mail.ispras.ru ([83.149.199.45]:53728)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1glqH5-0001s7-N4
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 02:15:08 -0500
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
Date: Tue, 22 Jan 2019 10:15:03 +0300
Message-ID: <000601d4b222$323d0900$96b71b00$@ru>
MIME-Version: 1.0
Content-Language: ru
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] Bottom halves VS timers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, peter.maydell@linaro.org, stefanha@redhat.com, famz@redhat.com, kwolf@redhat.com

Hi!

 

I recently debugged record/replay for some platform which uses PIO access for IDE.

Handlers for these operations are called through BHs.

Scheduling new BH does not create a signal for the vCPU to suspend the execution and

process the main loop events (in record/replay we synchronize these two threads).

Therefore vCPU may execute 10000000 instruction until BH processing and the guest

software may get a timeout.

 

I thought about replacing BH to the timers with period=0. This solution has the following
properties:

1.       Avoid code duplication (BH and timers do virtually the same operations)

2.       Timers affect the vCPU - adding new virtual timer suspends the execution to process the
callback

3.       Timers are deterministic in record/replay mode (virtual ones of course). We have similar
deterministic concept for BHs, but selecting between virtual and realtime should be more familiar
for other developers.

4.       Timers require a little bit more code, but this could be solved with better interfaces

 

What do you think about this?

Did I miss anything?

 

Pavel Dovgalyuk

 
