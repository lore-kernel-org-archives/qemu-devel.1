Received: from eggs.gnu.org ([2001:4830:134:3::10]:59530)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1diocb-00073A-UM
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 17:16:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1diocY-0000tS-4m
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 17:16:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36084)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1diocX-0000rB-MW
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 17:15:58 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C3AFD80460
	for <qemu-devel@nongnu.org>; Fri, 18 Aug 2017 21:15:56 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Fri, 18 Aug 2017 16:15:40 -0500
Message-Id: <20170818211542.5380-12-eblake@redhat.com>
In-Reply-To: <20170818211542.5380-1-eblake@redhat.com>
References: <20170818211542.5380-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v5 11/13] libqtest: Drop many static inline
 qtest_ wrappers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com

None of the tests were calling the long qtest_*() form, except via
the static inline short forms.  Remove a layer of indirection by
only supporting the short form, and using global_qtest directly in
the .c file.  (Yes, this flies in the face of thread-safety, by
relying on a global instead of passing all state through parameters,
but ease of writing/maintaining tests trumps ivory-tower design, and
our tests aren't really multi-threaded.)

The list of affected functions (by their short name):

qmp_receive
qmp_eventwait
qmp_eventwait_ref
get_irq
irq_intercept_in
irq_intercept_out
outb
outw
outl
inb
inw
inl
writeb
writew
writel
writeq
readb
readw
readl
readq
memread
bufread
memwrite
bufwrite
qmemset
clock_step_next
clock_step
clock_set

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/libqtest.h | 563 ++++++++++---------------------------------------------
 tests/libqtest.c | 173 ++++++++---------
 2 files changed, 190 insertions(+), 546 deletions(-)

diff --git a/tests/libqtest.h b/tests/libqtest.h
index dca62fd8da..431e546193 100644
--- a/tests/libqtest.h
+++ b/tests/libqtest.h
@@ -21,6 +21,15 @@

 typedef struct QTestState QTestState;

+/**
+ * global_qtest:
+ * The current test object.
+ *
+ * Many functions in this file implicitly operate on the current
+ * object; tests that need to alternate between two parallel
+ * connections can do so by switching which test state is current
+ * before issuing commands.
+ */
 extern QTestState *global_qtest;

 /**
@@ -46,7 +55,8 @@ void qtest_start_without_qmp_handshake(const char *extra_args);
  * qtest_quit:
  * @s: #QTestState instance to operate on.
  *
- * Shut down the QEMU process associated to @s.
+ * Shut down the QEMU process associated to @s.  See also qtest_end()
+ * for clearing #global_qtest.
  */
 void qtest_quit(QTestState *s);

@@ -100,31 +110,31 @@ QDict *qtest_qmpv(QTestState *s, const char *fmt, va_list ap);
 void qtest_async_qmpv(QTestState *s, const char *fmt, va_list ap);

 /**
- * qtest_receive:
- * @s: #QTestState instance to operate on.
+ * qmp_receive:
  *
- * Reads a QMP message from QEMU and returns the response.
+ * Reads a QMP message from QEMU, using #global_qtest, and returns the
+ * response.
  */
-QDict *qtest_qmp_receive(QTestState *s);
+QDict *qmp_receive(void);

 /**
- * qtest_qmp_eventwait:
- * @s: #QTestState instance to operate on.
+ * qmp_eventwait:
  * @s: #event event to wait for.
  *
- * Continuously polls for QMP responses until it receives the desired event.
+ * Continuously polls for QMP responses, using #global_qtest, until it
+ * receives the desired event.
  */
-void qtest_qmp_eventwait(QTestState *s, const char *event);
+void qmp_eventwait(const char *event);

 /**
- * qtest_qmp_eventwait_ref:
- * @s: #QTestState instance to operate on.
+ * qmp_eventwait_ref:
  * @s: #event event to wait for.
  *
- * Continuously polls for QMP responses until it receives the desired event.
- * Returns a copy of the event for further investigation.
+ * Continuously polls for QMP responses, using #global_qtest, until it
+ * receives the desired event.  Returns a copy of the event for
+ * further investigation.
  */
-QDict *qtest_qmp_eventwait_ref(QTestState *s, const char *event);
+QDict *qmp_eventwait_ref(const char *event);

 /**
  * qtest_hmp:
@@ -152,185 +162,167 @@ char *qtest_hmp(QTestState *s, const char *fmt, ...);
 char *qtest_hmpv(QTestState *s, const char *fmt, va_list ap);

 /**
- * qtest_get_irq:
- * @s: #QTestState instance to operate on.
+ * get_irq:
  * @num: Interrupt to observe.
  *
- * Returns: The level of the @num interrupt.
+ * Returns: The level of the @num interrupt, using #global_qtest.
  */
-bool qtest_get_irq(QTestState *s, int num);
+bool get_irq(int num);

 /**
- * qtest_irq_intercept_in:
- * @s: #QTestState instance to operate on.
+ * irq_intercept_in:
  * @string: QOM path of a device.
  *
  * Associate qtest irqs with the GPIO-in pins of the device
- * whose path is specified by @string.
+ * whose path is specified by @string, using #global_qtest.
  */
-void qtest_irq_intercept_in(QTestState *s, const char *string);
+void irq_intercept_in(const char *string);

 /**
- * qtest_irq_intercept_out:
- * @s: #QTestState instance to operate on.
+ * irq_intercept_out:
  * @string: QOM path of a device.
  *
  * Associate qtest irqs with the GPIO-out pins of the device
- * whose path is specified by @string.
+ * whose path is specified by @string, using #global_qtest.
  */
-void qtest_irq_intercept_out(QTestState *s, const char *string);
+void irq_intercept_out(const char *string);

 /**
- * qtest_outb:
- * @s: #QTestState instance to operate on.
+ * outb:
  * @addr: I/O port to write to.
  * @value: Value being written.
  *
- * Write an 8-bit value to an I/O port.
+ * Write an 8-bit value to an I/O port, using #global_qtest.
  */
-void qtest_outb(QTestState *s, uint16_t addr, uint8_t value);
+void outb(uint16_t addr, uint8_t value);

 /**
- * qtest_outw:
- * @s: #QTestState instance to operate on.
+ * outw:
  * @addr: I/O port to write to.
  * @value: Value being written.
  *
- * Write a 16-bit value to an I/O port.
+ * Write a 16-bit value to an I/O port, using #global_qtest.
  */
-void qtest_outw(QTestState *s, uint16_t addr, uint16_t value);
+void outw(uint16_t addr, uint16_t value);

 /**
- * qtest_outl:
- * @s: #QTestState instance to operate on.
+ * outl:
  * @addr: I/O port to write to.
  * @value: Value being written.
  *
- * Write a 32-bit value to an I/O port.
+ * Write a 32-bit value to an I/O port, using #global_qtest.
  */
-void qtest_outl(QTestState *s, uint16_t addr, uint32_t value);
+void outl(uint16_t addr, uint32_t value);

 /**
- * qtest_inb:
- * @s: #QTestState instance to operate on.
+ * inb:
  * @addr: I/O port to read from.
  *
- * Returns an 8-bit value from an I/O port.
+ * Returns an 8-bit value from an I/O port, using #global_qtest.
  */
-uint8_t qtest_inb(QTestState *s, uint16_t addr);
+uint8_t inb(uint16_t addr);

 /**
- * qtest_inw:
- * @s: #QTestState instance to operate on.
+ * inw:
  * @addr: I/O port to read from.
  *
- * Returns a 16-bit value from an I/O port.
+ * Returns a 16-bit value from an I/O port, using #global_qtest.
  */
-uint16_t qtest_inw(QTestState *s, uint16_t addr);
+uint16_t inw(uint16_t addr);

 /**
- * qtest_inl:
- * @s: #QTestState instance to operate on.
+ * inl:
  * @addr: I/O port to read from.
  *
- * Returns a 32-bit value from an I/O port.
+ * Returns a 32-bit value from an I/O port, using #global_qtest.
  */
-uint32_t qtest_inl(QTestState *s, uint16_t addr);
+uint32_t inl(uint16_t addr);

 /**
- * qtest_writeb:
- * @s: #QTestState instance to operate on.
+ * writeb:
  * @addr: Guest address to write to.
  * @value: Value being written.
  *
- * Writes an 8-bit value to memory.
+ * Writes an 8-bit value to memory, using #global_qtest.
  */
-void qtest_writeb(QTestState *s, uint64_t addr, uint8_t value);
+void writeb(uint64_t addr, uint8_t value);

 /**
- * qtest_writew:
- * @s: #QTestState instance to operate on.
+ * writew:
  * @addr: Guest address to write to.
  * @value: Value being written.
  *
- * Writes a 16-bit value to memory.
+ * Writes a 16-bit value to memory, using #global_qtest.
  */
-void qtest_writew(QTestState *s, uint64_t addr, uint16_t value);
+void writew(uint64_t addr, uint16_t value);

 /**
- * qtest_writel:
- * @s: #QTestState instance to operate on.
+ * writel:
  * @addr: Guest address to write to.
  * @value: Value being written.
  *
- * Writes a 32-bit value to memory.
+ * Writes a 32-bit value to memory, using #global_qtest.
  */
-void qtest_writel(QTestState *s, uint64_t addr, uint32_t value);
+void writel(uint64_t addr, uint32_t value);

 /**
- * qtest_writeq:
- * @s: #QTestState instance to operate on.
+ * writeq:
  * @addr: Guest address to write to.
  * @value: Value being written.
  *
- * Writes a 64-bit value to memory.
+ * Writes a 64-bit value to memory, using #global_qtest.
  */
-void qtest_writeq(QTestState *s, uint64_t addr, uint64_t value);
+void writeq(uint64_t addr, uint64_t value);

 /**
- * qtest_readb:
- * @s: #QTestState instance to operate on.
+ * readb:
  * @addr: Guest address to read from.
  *
- * Reads an 8-bit value from memory.
+ * Reads an 8-bit value from memory, using #global_qtest.
  *
  * Returns: Value read.
  */
-uint8_t qtest_readb(QTestState *s, uint64_t addr);
+uint8_t readb(uint64_t addr);

 /**
- * qtest_readw:
- * @s: #QTestState instance to operate on.
+ * readw:
  * @addr: Guest address to read from.
  *
- * Reads a 16-bit value from memory.
+ * Reads a 16-bit value from memory, using #global_qtest.
  *
  * Returns: Value read.
  */
-uint16_t qtest_readw(QTestState *s, uint64_t addr);
+uint16_t readw(uint64_t addr);

 /**
- * qtest_readl:
- * @s: #QTestState instance to operate on.
+ * readl:
  * @addr: Guest address to read from.
  *
- * Reads a 32-bit value from memory.
+ * Reads a 32-bit value from memory, using #global_qtest.
  *
  * Returns: Value read.
  */
-uint32_t qtest_readl(QTestState *s, uint64_t addr);
+uint32_t readl(uint64_t addr);

 /**
- * qtest_readq:
- * @s: #QTestState instance to operate on.
+ * readq:
  * @addr: Guest address to read from.
  *
- * Reads a 64-bit value from memory.
+ * Reads a 64-bit value from memory, using #global_qtest.
  *
  * Returns: Value read.
  */
-uint64_t qtest_readq(QTestState *s, uint64_t addr);
+uint64_t readq(uint64_t addr);

 /**
- * qtest_memread:
- * @s: #QTestState instance to operate on.
+ * memread:
  * @addr: Guest address to read from.
  * @data: Pointer to where memory contents will be stored.
  * @size: Number of bytes to read.
  *
- * Read guest memory into a buffer.
+ * Read guest memory into a buffer, using #global_qtest.
  */
-void qtest_memread(QTestState *s, uint64_t addr, void *data, size_t size);
+void memread(uint64_t addr, void *data, size_t size);

 /**
  * rtas_call:
@@ -346,81 +338,76 @@ uint64_t rtas_call(const char *name, uint32_t nargs, uint64_t args,
                    uint32_t nret, uint64_t ret);

 /**
- * qtest_bufread:
- * @s: #QTestState instance to operate on.
+ * bufread:
  * @addr: Guest address to read from.
  * @data: Pointer to where memory contents will be stored.
  * @size: Number of bytes to read.
  *
- * Read guest memory into a buffer and receive using a base64 encoding.
+ * Read guest memory into a buffer and receive using a base64
+ * encoding, using #global_qtest.
  */
-void qtest_bufread(QTestState *s, uint64_t addr, void *data, size_t size);
+void bufread(uint64_t addr, void *data, size_t size);

 /**
- * qtest_memwrite:
- * @s: #QTestState instance to operate on.
+ * memwrite:
  * @addr: Guest address to write to.
  * @data: Pointer to the bytes that will be written to guest memory.
  * @size: Number of bytes to write.
  *
- * Write a buffer to guest memory.
+ * Write a buffer to guest memory, using #global_qtest.
  */
-void qtest_memwrite(QTestState *s, uint64_t addr, const void *data, size_t size);
+void memwrite(uint64_t addr, const void *data, size_t size);

 /**
- * qtest_bufwrite:
- * @s: #QTestState instance to operate on.
+ * bufwrite:
  * @addr: Guest address to write to.
  * @data: Pointer to the bytes that will be written to guest memory.
  * @size: Number of bytes to write.
  *
- * Write a buffer to guest memory and transmit using a base64 encoding.
+ * Write a buffer to guest memory and transmit using a base64
+ * encoding, using #global_qtest.
  */
-void qtest_bufwrite(QTestState *s, uint64_t addr,
-                    const void *data, size_t size);
+void bufwrite(uint64_t addr, const void *data, size_t size);

 /**
- * qtest_memset:
- * @s: #QTestState instance to operate on.
+ * qmemset:
  * @addr: Guest address to write to.
  * @patt: Byte pattern to fill the guest memory region with.
  * @size: Number of bytes to write.
  *
- * Write a pattern to guest memory.
+ * Write a pattern to guest memory, using #global_qtest.
  */
-void qtest_memset(QTestState *s, uint64_t addr, uint8_t patt, size_t size);
+void qmemset(uint64_t addr, uint8_t patt, size_t size);

 /**
- * qtest_clock_step_next:
- * @s: #QTestState instance to operate on.
+ * clock_step_next:
  *
- * Advance the QEMU_CLOCK_VIRTUAL to the next deadline.
+ * Advance the QEMU_CLOCK_VIRTUAL to the next deadline, using #global_qtest.
  *
  * Returns: The current value of the QEMU_CLOCK_VIRTUAL in nanoseconds.
  */
-int64_t qtest_clock_step_next(QTestState *s);
+int64_t clock_step_next(void);

 /**
- * qtest_clock_step:
- * @s: QTestState instance to operate on.
+ * clock_step:
  * @step: Number of nanoseconds to advance the clock by.
  *
- * Advance the QEMU_CLOCK_VIRTUAL by @step nanoseconds.
+ * Advance the QEMU_CLOCK_VIRTUAL by @step nanoseconds, using #global_qtest.
  *
  * Returns: The current value of the QEMU_CLOCK_VIRTUAL in nanoseconds.
  */
-int64_t qtest_clock_step(QTestState *s, int64_t step);
+int64_t clock_step(int64_t step);

 /**
- * qtest_clock_set:
- * @s: QTestState instance to operate on.
+ * clock_set:
  * @val: Nanoseconds value to advance the clock to.
  *
- * Advance the QEMU_CLOCK_VIRTUAL to @val nanoseconds since the VM was launched.
+ * Advance the QEMU_CLOCK_VIRTUAL to @val nanoseconds since the VM was
+ * launched, using #global_qtest.
  *
  * Returns: The current value of the QEMU_CLOCK_VIRTUAL in nanoseconds.
  */
-int64_t qtest_clock_set(QTestState *s, int64_t val);
+int64_t clock_set(int64_t val);

 /**
  * big_endian:
@@ -525,39 +512,6 @@ void qmp_async(const char *fmt, ...);
 void qmp_discard_response(const char *fmt, ...);

 /**
- * qmp_receive:
- *
- * Reads a QMP message from QEMU and returns the response.
- */
-static inline QDict *qmp_receive(void)
-{
-    return qtest_qmp_receive(global_qtest);
-}
-
-/**
- * qmp_eventwait:
- * @s: #event event to wait for.
- *
- * Continuously polls for QMP responses until it receives the desired event.
- */
-static inline void qmp_eventwait(const char *event)
-{
-    return qtest_qmp_eventwait(global_qtest, event);
-}
-
-/**
- * qmp_eventwait_ref:
- * @s: #event event to wait for.
- *
- * Continuously polls for QMP responses until it receives the desired event.
- * Returns a copy of the event for further investigation.
- */
-static inline QDict *qmp_eventwait_ref(const char *event)
-{
-    return qtest_qmp_eventwait_ref(global_qtest, event);
-}
-
-/**
  * hmp:
  * @fmt...: HMP command to send to QEMU
  *
@@ -567,319 +521,6 @@ static inline QDict *qmp_eventwait_ref(const char *event)
  */
 char *hmp(const char *fmt, ...);

-/**
- * get_irq:
- * @num: Interrupt to observe.
- *
- * Returns: The level of the @num interrupt.
- */
-static inline bool get_irq(int num)
-{
-    return qtest_get_irq(global_qtest, num);
-}
-
-/**
- * irq_intercept_in:
- * @string: QOM path of a device.
- *
- * Associate qtest irqs with the GPIO-in pins of the device
- * whose path is specified by @string.
- */
-static inline void irq_intercept_in(const char *string)
-{
-    qtest_irq_intercept_in(global_qtest, string);
-}
-
-/**
- * qtest_irq_intercept_out:
- * @string: QOM path of a device.
- *
- * Associate qtest irqs with the GPIO-out pins of the device
- * whose path is specified by @string.
- */
-static inline void irq_intercept_out(const char *string)
-{
-    qtest_irq_intercept_out(global_qtest, string);
-}
-
-/**
- * outb:
- * @addr: I/O port to write to.
- * @value: Value being written.
- *
- * Write an 8-bit value to an I/O port.
- */
-static inline void outb(uint16_t addr, uint8_t value)
-{
-    qtest_outb(global_qtest, addr, value);
-}
-
-/**
- * outw:
- * @addr: I/O port to write to.
- * @value: Value being written.
- *
- * Write a 16-bit value to an I/O port.
- */
-static inline void outw(uint16_t addr, uint16_t value)
-{
-    qtest_outw(global_qtest, addr, value);
-}
-
-/**
- * outl:
- * @addr: I/O port to write to.
- * @value: Value being written.
- *
- * Write a 32-bit value to an I/O port.
- */
-static inline void outl(uint16_t addr, uint32_t value)
-{
-    qtest_outl(global_qtest, addr, value);
-}
-
-/**
- * inb:
- * @addr: I/O port to read from.
- *
- * Reads an 8-bit value from an I/O port.
- *
- * Returns: Value read.
- */
-static inline uint8_t inb(uint16_t addr)
-{
-    return qtest_inb(global_qtest, addr);
-}
-
-/**
- * inw:
- * @addr: I/O port to read from.
- *
- * Reads a 16-bit value from an I/O port.
- *
- * Returns: Value read.
- */
-static inline uint16_t inw(uint16_t addr)
-{
-    return qtest_inw(global_qtest, addr);
-}
-
-/**
- * inl:
- * @addr: I/O port to read from.
- *
- * Reads a 32-bit value from an I/O port.
- *
- * Returns: Value read.
- */
-static inline uint32_t inl(uint16_t addr)
-{
-    return qtest_inl(global_qtest, addr);
-}
-
-/**
- * writeb:
- * @addr: Guest address to write to.
- * @value: Value being written.
- *
- * Writes an 8-bit value to guest memory.
- */
-static inline void writeb(uint64_t addr, uint8_t value)
-{
-    qtest_writeb(global_qtest, addr, value);
-}
-
-/**
- * writew:
- * @addr: Guest address to write to.
- * @value: Value being written.
- *
- * Writes a 16-bit value to guest memory.
- */
-static inline void writew(uint64_t addr, uint16_t value)
-{
-    qtest_writew(global_qtest, addr, value);
-}
-
-/**
- * writel:
- * @addr: Guest address to write to.
- * @value: Value being written.
- *
- * Writes a 32-bit value to guest memory.
- */
-static inline void writel(uint64_t addr, uint32_t value)
-{
-    qtest_writel(global_qtest, addr, value);
-}
-
-/**
- * writeq:
- * @addr: Guest address to write to.
- * @value: Value being written.
- *
- * Writes a 64-bit value to guest memory.
- */
-static inline void writeq(uint64_t addr, uint64_t value)
-{
-    qtest_writeq(global_qtest, addr, value);
-}
-
-/**
- * readb:
- * @addr: Guest address to read from.
- *
- * Reads an 8-bit value from guest memory.
- *
- * Returns: Value read.
- */
-static inline uint8_t readb(uint64_t addr)
-{
-    return qtest_readb(global_qtest, addr);
-}
-
-/**
- * readw:
- * @addr: Guest address to read from.
- *
- * Reads a 16-bit value from guest memory.
- *
- * Returns: Value read.
- */
-static inline uint16_t readw(uint64_t addr)
-{
-    return qtest_readw(global_qtest, addr);
-}
-
-/**
- * readl:
- * @addr: Guest address to read from.
- *
- * Reads a 32-bit value from guest memory.
- *
- * Returns: Value read.
- */
-static inline uint32_t readl(uint64_t addr)
-{
-    return qtest_readl(global_qtest, addr);
-}
-
-/**
- * readq:
- * @addr: Guest address to read from.
- *
- * Reads a 64-bit value from guest memory.
- *
- * Returns: Value read.
- */
-static inline uint64_t readq(uint64_t addr)
-{
-    return qtest_readq(global_qtest, addr);
-}
-
-/**
- * memread:
- * @addr: Guest address to read from.
- * @data: Pointer to where memory contents will be stored.
- * @size: Number of bytes to read.
- *
- * Read guest memory into a buffer.
- */
-static inline void memread(uint64_t addr, void *data, size_t size)
-{
-    qtest_memread(global_qtest, addr, data, size);
-}
-
-/**
- * bufread:
- * @addr: Guest address to read from.
- * @data: Pointer to where memory contents will be stored.
- * @size: Number of bytes to read.
- *
- * Read guest memory into a buffer, receive using a base64 encoding.
- */
-static inline void bufread(uint64_t addr, void *data, size_t size)
-{
-    qtest_bufread(global_qtest, addr, data, size);
-}
-
-/**
- * memwrite:
- * @addr: Guest address to write to.
- * @data: Pointer to the bytes that will be written to guest memory.
- * @size: Number of bytes to write.
- *
- * Write a buffer to guest memory.
- */
-static inline void memwrite(uint64_t addr, const void *data, size_t size)
-{
-    qtest_memwrite(global_qtest, addr, data, size);
-}
-
-/**
- * bufwrite:
- * @addr: Guest address to write to.
- * @data: Pointer to the bytes that will be written to guest memory.
- * @size: Number of bytes to write.
- *
- * Write a buffer to guest memory, transmit using a base64 encoding.
- */
-static inline void bufwrite(uint64_t addr, const void *data, size_t size)
-{
-    qtest_bufwrite(global_qtest, addr, data, size);
-}
-
-/**
- * qmemset:
- * @addr: Guest address to write to.
- * @patt: Byte pattern to fill the guest memory region with.
- * @size: Number of bytes to write.
- *
- * Write a pattern to guest memory.
- */
-static inline void qmemset(uint64_t addr, uint8_t patt, size_t size)
-{
-    qtest_memset(global_qtest, addr, patt, size);
-}
-
-/**
- * clock_step_next:
- *
- * Advance the QEMU_CLOCK_VIRTUAL to the next deadline.
- *
- * Returns: The current value of the QEMU_CLOCK_VIRTUAL in nanoseconds.
- */
-static inline int64_t clock_step_next(void)
-{
-    return qtest_clock_step_next(global_qtest);
-}
-
-/**
- * clock_step:
- * @step: Number of nanoseconds to advance the clock by.
- *
- * Advance the QEMU_CLOCK_VIRTUAL by @step nanoseconds.
- *
- * Returns: The current value of the QEMU_CLOCK_VIRTUAL in nanoseconds.
- */
-static inline int64_t clock_step(int64_t step)
-{
-    return qtest_clock_step(global_qtest, step);
-}
-
-/**
- * clock_set:
- * @val: Nanoseconds value to advance the clock to.
- *
- * Advance the QEMU_CLOCK_VIRTUAL to @val nanoseconds since the VM was launched.
- *
- * Returns: The current value of the QEMU_CLOCK_VIRTUAL in nanoseconds.
- */
-static inline int64_t clock_set(int64_t val)
-{
-    return qtest_clock_set(global_qtest, val);
-}
-
 QDict *qmp_fd_receive(int fd);
 void qmp_fd_sendv(int fd, const char *fmt, va_list ap);
 void qmp_fd_send(int fd, const char *fmt, ...);
diff --git a/tests/libqtest.c b/tests/libqtest.c
index c4e41261ab..2998b173f0 100644
--- a/tests/libqtest.c
+++ b/tests/libqtest.c
@@ -426,9 +426,9 @@ QDict *qmp_fd_receive(int fd)
     return qmp.response;
 }

-QDict *qtest_qmp_receive(QTestState *s)
+QDict *qmp_receive(void)
 {
-    return qmp_fd_receive(s->qmp_fd);
+    return qmp_fd_receive(global_qtest->qmp_fd);
 }

 /**
@@ -498,7 +498,7 @@ QDict *qtest_qmpv(QTestState *s, const char *fmt, va_list ap)
     qtest_async_qmpv(s, fmt, ap);

     /* Receive reply */
-    return qtest_qmp_receive(s);
+    return qmp_fd_receive(s->qmp_fd);
 }

 QDict *qmp_fd(int fd, const char *fmt, ...)
@@ -541,12 +541,12 @@ void qtest_async_qmp(QTestState *s, const char *fmt, ...)
     va_end(ap);
 }

-QDict *qtest_qmp_eventwait_ref(QTestState *s, const char *event)
+QDict *qmp_eventwait_ref(const char *event)
 {
     QDict *response;

     for (;;) {
-        response = qtest_qmp_receive(s);
+        response = qmp_receive();
         if ((qdict_haskey(response, "event")) &&
             (strcmp(qdict_get_str(response, "event"), event) == 0)) {
             return response;
@@ -555,11 +555,11 @@ QDict *qtest_qmp_eventwait_ref(QTestState *s, const char *event)
     }
 }

-void qtest_qmp_eventwait(QTestState *s, const char *event)
+void qmp_eventwait(const char *event)
 {
     QDict *response;

-    response = qtest_qmp_eventwait_ref(s, event);
+    response = qmp_eventwait_ref(event);
     QDECREF(response);
 }

@@ -577,7 +577,7 @@ char *qtest_hmpv(QTestState *s, const char *fmt, va_list ap)
     while (ret == NULL && qdict_get_try_str(resp, "event")) {
         /* Ignore asynchronous QMP events */
         QDECREF(resp);
-        resp = qtest_qmp_receive(s);
+        resp = qmp_fd_receive(s->qmp_fd);
         ret = g_strdup(qdict_get_try_str(resp, "return"));
     }
     g_assert(ret);
@@ -606,83 +606,83 @@ const char *qtest_get_arch(void)
     return end + strlen("/qemu-system-");
 }

-bool qtest_get_irq(QTestState *s, int num)
+bool get_irq(int num)
 {
     /* dummy operation in order to make sure irq is up to date */
-    qtest_inb(s, 0);
+    inb(0);

-    return s->irq_level[num];
+    return global_qtest->irq_level[num];
 }

-static int64_t qtest_clock_rsp(QTestState *s)
+static int64_t qtest_clock_rsp(void)
 {
     gchar **words;
     int64_t clock;
-    words = qtest_rsp(s, 2);
+    words = qtest_rsp(global_qtest, 2);
     clock = g_ascii_strtoll(words[1], NULL, 0);
     g_strfreev(words);
     return clock;
 }

-int64_t qtest_clock_step_next(QTestState *s)
+int64_t clock_step_next(void)
 {
-    qtest_sendf(s, "clock_step\n");
-    return qtest_clock_rsp(s);
+    qtest_sendf(global_qtest, "clock_step\n");
+    return qtest_clock_rsp();
 }

-int64_t qtest_clock_step(QTestState *s, int64_t step)
+int64_t clock_step(int64_t step)
 {
-    qtest_sendf(s, "clock_step %"PRIi64"\n", step);
-    return qtest_clock_rsp(s);
+    qtest_sendf(global_qtest, "clock_step %"PRIi64"\n", step);
+    return qtest_clock_rsp();
 }

-int64_t qtest_clock_set(QTestState *s, int64_t val)
+int64_t clock_set(int64_t val)
 {
-    qtest_sendf(s, "clock_set %"PRIi64"\n", val);
-    return qtest_clock_rsp(s);
+    qtest_sendf(global_qtest, "clock_set %"PRIi64"\n", val);
+    return qtest_clock_rsp();
 }

-void qtest_irq_intercept_out(QTestState *s, const char *qom_path)
+void irq_intercept_out(const char *qom_path)
 {
-    qtest_sendf(s, "irq_intercept_out %s\n", qom_path);
-    qtest_rsp(s, 0);
+    qtest_sendf(global_qtest, "irq_intercept_out %s\n", qom_path);
+    qtest_rsp(global_qtest, 0);
 }

-void qtest_irq_intercept_in(QTestState *s, const char *qom_path)
+void irq_intercept_in(const char *qom_path)
 {
-    qtest_sendf(s, "irq_intercept_in %s\n", qom_path);
-    qtest_rsp(s, 0);
+    qtest_sendf(global_qtest, "irq_intercept_in %s\n", qom_path);
+    qtest_rsp(global_qtest, 0);
 }

-static void qtest_out(QTestState *s, const char *cmd, uint16_t addr, uint32_t value)
+static void out(const char *cmd, uint16_t addr, uint32_t value)
 {
-    qtest_sendf(s, "%s 0x%x 0x%x\n", cmd, addr, value);
-    qtest_rsp(s, 0);
+    qtest_sendf(global_qtest, "%s 0x%x 0x%x\n", cmd, addr, value);
+    qtest_rsp(global_qtest, 0);
 }

-void qtest_outb(QTestState *s, uint16_t addr, uint8_t value)
+void outb(uint16_t addr, uint8_t value)
 {
-    qtest_out(s, "outb", addr, value);
+    out("outb", addr, value);
 }

-void qtest_outw(QTestState *s, uint16_t addr, uint16_t value)
+void outw(uint16_t addr, uint16_t value)
 {
-    qtest_out(s, "outw", addr, value);
+    out("outw", addr, value);
 }

-void qtest_outl(QTestState *s, uint16_t addr, uint32_t value)
+void outl(uint16_t addr, uint32_t value)
 {
-    qtest_out(s, "outl", addr, value);
+    out("outl", addr, value);
 }

-static uint32_t qtest_in(QTestState *s, const char *cmd, uint16_t addr)
+static uint32_t in(const char *cmd, uint16_t addr)
 {
     gchar **args;
     int ret;
     unsigned long value;

-    qtest_sendf(s, "%s 0x%x\n", cmd, addr);
-    args = qtest_rsp(s, 2);
+    qtest_sendf(global_qtest, "%s 0x%x\n", cmd, addr);
+    args = qtest_rsp(global_qtest, 2);
     ret = qemu_strtoul(args[1], NULL, 0, &value);
     g_assert(!ret && value <= UINT32_MAX);
     g_strfreev(args);
@@ -690,56 +690,57 @@ static uint32_t qtest_in(QTestState *s, const char *cmd, uint16_t addr)
     return value;
 }

-uint8_t qtest_inb(QTestState *s, uint16_t addr)
+uint8_t inb(uint16_t addr)
 {
-    return qtest_in(s, "inb", addr);
+    return in("inb", addr);
 }

-uint16_t qtest_inw(QTestState *s, uint16_t addr)
+uint16_t inw(uint16_t addr)
 {
-    return qtest_in(s, "inw", addr);
+    return in("inw", addr);
 }

-uint32_t qtest_inl(QTestState *s, uint16_t addr)
+uint32_t inl(uint16_t addr)
 {
-    return qtest_in(s, "inl", addr);
+    return in("inl", addr);
 }

-static void qtest_write(QTestState *s, const char *cmd, uint64_t addr,
+static void qtest_write(const char *cmd, uint64_t addr,
                         uint64_t value)
 {
-    qtest_sendf(s, "%s 0x%" PRIx64 " 0x%" PRIx64 "\n", cmd, addr, value);
-    qtest_rsp(s, 0);
+    qtest_sendf(global_qtest, "%s 0x%" PRIx64 " 0x%" PRIx64 "\n", cmd, addr,
+                value);
+    qtest_rsp(global_qtest, 0);
 }

-void qtest_writeb(QTestState *s, uint64_t addr, uint8_t value)
+void writeb(uint64_t addr, uint8_t value)
 {
-    qtest_write(s, "writeb", addr, value);
+    qtest_write("writeb", addr, value);
 }

-void qtest_writew(QTestState *s, uint64_t addr, uint16_t value)
+void writew(uint64_t addr, uint16_t value)
 {
-    qtest_write(s, "writew", addr, value);
+    qtest_write("writew", addr, value);
 }

-void qtest_writel(QTestState *s, uint64_t addr, uint32_t value)
+void writel(uint64_t addr, uint32_t value)
 {
-    qtest_write(s, "writel", addr, value);
+    qtest_write("writel", addr, value);
 }

-void qtest_writeq(QTestState *s, uint64_t addr, uint64_t value)
+void writeq(uint64_t addr, uint64_t value)
 {
-    qtest_write(s, "writeq", addr, value);
+    qtest_write("writeq", addr, value);
 }

-static uint64_t qtest_read(QTestState *s, const char *cmd, uint64_t addr)
+static uint64_t qtest_read(const char *cmd, uint64_t addr)
 {
     gchar **args;
     int ret;
     uint64_t value;

-    qtest_sendf(s, "%s 0x%" PRIx64 "\n", cmd, addr);
-    args = qtest_rsp(s, 2);
+    qtest_sendf(global_qtest, "%s 0x%" PRIx64 "\n", cmd, addr);
+    args = qtest_rsp(global_qtest, 2);
     ret = qemu_strtou64(args[1], NULL, 0, &value);
     g_assert(!ret);
     g_strfreev(args);
@@ -747,24 +748,24 @@ static uint64_t qtest_read(QTestState *s, const char *cmd, uint64_t addr)
     return value;
 }

-uint8_t qtest_readb(QTestState *s, uint64_t addr)
+uint8_t readb(uint64_t addr)
 {
-    return qtest_read(s, "readb", addr);
+    return qtest_read("readb", addr);
 }

-uint16_t qtest_readw(QTestState *s, uint64_t addr)
+uint16_t readw(uint64_t addr)
 {
-    return qtest_read(s, "readw", addr);
+    return qtest_read("readw", addr);
 }

-uint32_t qtest_readl(QTestState *s, uint64_t addr)
+uint32_t readl(uint64_t addr)
 {
-    return qtest_read(s, "readl", addr);
+    return qtest_read("readl", addr);
 }

-uint64_t qtest_readq(QTestState *s, uint64_t addr)
+uint64_t readq(uint64_t addr)
 {
-    return qtest_read(s, "readq", addr);
+    return qtest_read("readq", addr);
 }

 static int hex2nib(char ch)
@@ -780,7 +781,7 @@ static int hex2nib(char ch)
     }
 }

-void qtest_memread(QTestState *s, uint64_t addr, void *data, size_t size)
+void memread(uint64_t addr, void *data, size_t size)
 {
     uint8_t *ptr = data;
     gchar **args;
@@ -790,8 +791,8 @@ void qtest_memread(QTestState *s, uint64_t addr, void *data, size_t size)
         return;
     }

-    qtest_sendf(s, "read 0x%" PRIx64 " 0x%zx\n", addr, size);
-    args = qtest_rsp(s, 2);
+    qtest_sendf(global_qtest, "read 0x%" PRIx64 " 0x%zx\n", addr, size);
+    args = qtest_rsp(global_qtest, 2);

     for (i = 0; i < size; i++) {
         ptr[i] = hex2nib(args[1][2 + (i * 2)]) << 4;
@@ -834,25 +835,25 @@ void qtest_add_data_func(const char *str, const void *data,
     g_free(path);
 }

-void qtest_bufwrite(QTestState *s, uint64_t addr, const void *data, size_t size)
+void bufwrite(uint64_t addr, const void *data, size_t size)
 {
     gchar *bdata;

     bdata = g_base64_encode(data, size);
-    qtest_sendf(s, "b64write 0x%" PRIx64 " 0x%zx ", addr, size);
-    socket_send(s->fd, bdata, -1);
-    socket_send(s->fd, "\n", 1);
-    qtest_rsp(s, 0);
+    qtest_sendf(global_qtest, "b64write 0x%" PRIx64 " 0x%zx ", addr, size);
+    socket_send(global_qtest->fd, bdata, -1);
+    socket_send(global_qtest->fd, "\n", 1);
+    qtest_rsp(global_qtest, 0);
     g_free(bdata);
 }

-void qtest_bufread(QTestState *s, uint64_t addr, void *data, size_t size)
+void bufread(uint64_t addr, void *data, size_t size)
 {
     gchar **args;
     size_t len;

-    qtest_sendf(s, "b64read 0x%" PRIx64 " 0x%zx\n", addr, size);
-    args = qtest_rsp(s, 2);
+    qtest_sendf(global_qtest, "b64read 0x%" PRIx64 " 0x%zx\n", addr, size);
+    args = qtest_rsp(global_qtest, 2);

     g_base64_decode_inplace(args[1], &len);
     if (size != len) {
@@ -865,7 +866,7 @@ void qtest_bufread(QTestState *s, uint64_t addr, void *data, size_t size)
     g_strfreev(args);
 }

-void qtest_memwrite(QTestState *s, uint64_t addr, const void *data, size_t size)
+void memwrite(uint64_t addr, const void *data, size_t size)
 {
     const uint8_t *ptr = data;
     size_t i;
@@ -881,15 +882,17 @@ void qtest_memwrite(QTestState *s, uint64_t addr, const void *data, size_t size)
         sprintf(&enc[i * 2], "%02x", ptr[i]);
     }

-    qtest_sendf(s, "write 0x%" PRIx64 " 0x%zx 0x%s\n", addr, size, enc);
-    qtest_rsp(s, 0);
+    qtest_sendf(global_qtest, "write 0x%" PRIx64 " 0x%zx 0x%s\n", addr, size,
+                enc);
+    qtest_rsp(global_qtest, 0);
     g_free(enc);
 }

-void qtest_memset(QTestState *s, uint64_t addr, uint8_t pattern, size_t size)
+void qmemset(uint64_t addr, uint8_t pattern, size_t size)
 {
-    qtest_sendf(s, "memset 0x%" PRIx64 " 0x%zx 0x%02x\n", addr, size, pattern);
-    qtest_rsp(s, 0);
+    qtest_sendf(global_qtest, "memset 0x%" PRIx64 " 0x%zx 0x%02x\n", addr, size,
+                pattern);
+    qtest_rsp(global_qtest, 0);
 }

 QDict *qmp(const char *fmt, ...)
-- 
2.13.5
