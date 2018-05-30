Received: from eggs.gnu.org ([2001:4830:134:3::10]:44263)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pavel.dovgaluk@gmail.com>) id 1fO0n3-0001TS-NC
	for qemu-devel@nongnu.org; Wed, 30 May 2018 09:05:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pavel.dovgaluk@gmail.com>) id 1fO0mz-0000ql-5B
	for qemu-devel@nongnu.org; Wed, 30 May 2018 09:05:21 -0400
Received: from mail.ispras.ru ([83.149.199.45]:51832)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pavel.dovgaluk@gmail.com>) id 1fO0my-0000Ys-MQ
	for qemu-devel@nongnu.org; Wed, 30 May 2018 09:05:17 -0400
Received: from [127.0.1.1] (unknown [85.142.117.226])
	by mail.ispras.ru (Postfix) with ESMTPSA id 40D64540184
	for <qemu-devel@nongnu.org>; Wed, 30 May 2018 16:05:14 +0300 (MSK)
From: Pavel Dovgalyuk <pavel.dovgaluk@gmail.com>
Date: Wed, 30 May 2018 16:05:14 +0300
Message-ID: <152768551387.13955.7085403440722380428.stgit@pasha-ThinkPad-T60>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [RFC PATCH v1 0/2] QEMU binary instrumentation
 prototype
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following series implements dynamic binary instrumentation upon QEMU.

It is based on the following prior sources:
 - KVM Forum 2017 talk "Instrumenting, Introspection, and Debugging with QEMU"
   https://www.linux-kvm.org/images/3/3d/Introspect.pdf
 - Discussion on Lluis Vilanova instrumentation patch series
   https://lists.gnu.org/archive/html/qemu-devel/2017-09/msg03357.html

There are many implementations of the instrumentation for QEMU.
We have our own attempt on github: https://github.com/ispras/qemu/tree/plugins
But this series differ from that approach and it is intended
to provide a stable interface for adding and extending the QEMU binary
analysis functions.

We propose adding new instrumentation API for QEMU which will include
the following parts:
 - some translator modifications to enable instrumenting the instructions
   (and memory operations in the next version of the patches)
 - dynamic binary instrumentation part (a sample which is currently submitted
   in this RFC series)
 - subsystem for dynamically loaded plugins that interact with this API
   (not ready yet)

The aim of the instrumentation is implementing different runtime
tracers that can track the executed instructions, memory and
hardware operations. The implementation should not incur too much
overhead to make memory tracing as efficient as it is possible
for this heavy task.

The plugins should not have too many dependencies from the QEMU
core. They should be built as a separate projects using just
a couple of the headers.

For the current patches the plugins should provide the following
callbacks:
 - "needs" callback to check whether the specific instruction
   should be instrumented by this plugin
 - "run" callback which called before executing the instuction

Our instrumentation subsystem exploits TCG helper mechanism to embed
callbacks into the translation blocks. These callbacks may be inserted
before the specific instructions.

The aim of submission of this series at that early stage is to get
the feedback which will guide the development process. We are faced
the following questions:
 - Is the double parsing of the instruction opcode ok? (syscall sample)
   Or we should construct a method for passing analysis-specific parameters from
   the instrumenting stage to the execution one?
 - Does every plugins should have its own callback embedded into the TB
   (which will cause TB extra growth in case of multiple plugins),
   or the instrumentation layer's callback should invoke the plugins
   that wanted to instrument that specific instruction?
 - How the plugins should function? Will they work as a binary dynamic
   libraries or a script on some interpreted language?

---

Pavel Dovgalyuk (2):
      tcg: add headers for non-target helpers
      tcg: add instrumenting module


 accel/tcg/Makefile.objs            |    1 
 accel/tcg/instrument/Makefile.objs |    1 
 accel/tcg/instrument/helper.h      |    1 
 accel/tcg/instrument/instrument.c  |   82 ++++++++++++++++++++++++++++++++++++
 accel/tcg/instrument/instrument.h  |   11 +++++
 accel/tcg/translate-all.c          |    2 +
 accel/tcg/translator.c             |    5 ++
 include/exec/helper-register.h     |   53 +++++++++++++++++++++++
 tcg/tcg.c                          |   12 +++++
 tcg/tcg.h                          |    3 +
 10 files changed, 171 insertions(+)
 create mode 100644 accel/tcg/instrument/Makefile.objs
 create mode 100644 accel/tcg/instrument/helper.h
 create mode 100644 accel/tcg/instrument/instrument.c
 create mode 100644 accel/tcg/instrument/instrument.h
 create mode 100644 include/exec/helper-register.h

--
Pavel Dovgalyuk
