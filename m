Received: from eggs.gnu.org ([2001:4830:134:3::10]:52454)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cv1MX-0001Oi-DF
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 08:45:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cv1MQ-00012F-Fg
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 08:45:37 -0400
Received: from mail-wr0-x233.google.com ([2a00:1450:400c:c0c::233]:35096)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cv1MQ-00011p-4F
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 08:45:30 -0400
Received: by mail-wr0-x233.google.com with SMTP id k6so162838502wre.2
	for <qemu-devel@nongnu.org>; Mon, 03 Apr 2017 05:45:29 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon,  3 Apr 2017 13:45:18 +0100
Message-Id: <20170403124524.10824-4-alex.bennee@linaro.org>
In-Reply-To: <20170403124524.10824-1-alex.bennee@linaro.org>
References: <20170403124524.10824-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH v1 3/9] scripts/replay-dump.py: replay log
 dumper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: dovgaluk@ispras.ru, rth@twiddle.net, pbonzini@redhat.com
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, mttcg@listserver.greensocs.com, fred.konrad@greensocs.com, a.rigo@virtualopensystems.com, cota@braap.org, bobby.prani@gmail.com, nikunj@linux.vnet.ibm.com, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

This script is a debugging tool for looking through the contents of a
replay log file. It is incomplete but should fail gracefully at events
it doesn't understand.

It currently understands two different log formats as the audio
record/replay support was merged during since MTTCG. It was written to
help debug what has caused the BQL changes to break replay support.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 scripts/replay-dump.py | 272 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 272 insertions(+)
 create mode 100755 scripts/replay-dump.py

diff --git a/scripts/replay-dump.py b/scripts/replay-dump.py
new file mode 100755
index 0000000000..fdd178aba0
--- /dev/null
+++ b/scripts/replay-dump.py
@@ -0,0 +1,272 @@
+#!/usr/bin/env python
+# -*- coding: utf-8 -*-
+#
+# Dump the contents of a recorded execution stream
+#
+#  Copyright (c) 2017 Alex Bennée <alex.bennee@linaro.org>
+#
+# This library is free software; you can redistribute it and/or
+# modify it under the terms of the GNU Lesser General Public
+# License as published by the Free Software Foundation; either
+# version 2 of the License, or (at your option) any later version.
+#
+# This library is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+# Lesser General Public License for more details.
+#
+# You should have received a copy of the GNU Lesser General Public
+# License along with this library; if not, see <http://www.gnu.org/licenses/>.
+
+import argparse
+import struct
+from collections import namedtuple
+
+# This mirrors some of the global replay state which some of the
+# stream loading refers to. Some decoders may read the next event so
+# we need handle that case. Calling reuse_event will ensure the next
+# event is read from the cache rather than advancing the file.
+
+class ReplayState(object):
+    def __init__(self):
+        self.event = -1
+        self.event_count = 0
+        self.already_read = False
+        self.current_checkpoint = 0
+        self.checkpoint = 0
+
+    def set_event(self, ev):
+        self.event = ev
+        self.event_count += 1
+
+    def get_event(self):
+        self.already_read = False
+        return self.event
+
+    def reuse_event(self, ev):
+        self.event = ev
+        self.already_read = True
+
+    def set_checkpoint(self):
+        self.checkpoint = self.event - self.checkpoint_start
+
+    def get_checkpoint(self):
+        return self.checkpoint
+
+replay_state = ReplayState()
+
+# Simple read functions that mirror replay-internal.c
+# The file-stream is big-endian and manually written out a byte at a time.
+
+def read_byte(fin):
+    "Read a single byte"
+    return struct.unpack('>B', fin.read(1))[0]
+
+def read_event(fin):
+    "Read a single byte event, but save some state"
+    if replay_state.already_read:
+        return replay_state.get_event()
+    else:
+        replay_state.set_event(read_byte(fin))
+        return replay_state.event
+
+def read_word(fin):
+    "Read a 16 bit word"
+    return struct.unpack('>H', fin.read(2))[0]
+
+def read_dword(fin):
+    "Read a 32 bit word"
+    return struct.unpack('>I', fin.read(4))[0]
+
+def read_qword(fin):
+    "Read a 64 bit word"
+    return struct.unpack('>Q', fin.read(8))[0]
+
+# Generic decoder structure
+Decoder = namedtuple("Decoder", "eid name fn")
+
+def call_decode(table, index, dumpfile):
+    "Search decode table for next step"
+    decoder = next((d for d in table if d.eid == index), None)
+    if not decoder:
+        print "Could not decode index: %d" % (index)
+        print "Entry is: %s" % (decoder)
+        print "Decode Table is:\n%s" % (table)
+        return False
+    else:
+        return decoder.fn(decoder.eid, decoder.name, dumpfile)
+
+# Print event
+def print_event(eid, name, string=None, event_count=None):
+    "Print event with count"
+    if not event_count:
+        event_count = replay_state.event_count
+
+    if string:
+        print "%d:%s(%d) %s" % (event_count, name, eid, string)
+    else:
+        print "%d:%s(%d)" % (event_count, name, eid)
+
+
+# Decoders for each event type
+
+def decode_unimp(eid, name, _unused_dumpfile):
+    "Unimplimented decoder, will trigger exit"
+    print "%s not handled - will now stop" % (name)
+    return False
+
+# Checkpoint decoder
+def swallow_async_qword(eid, name, dumpfile):
+    "Swallow a qword of data without looking at it"
+    step_id = read_qword(dumpfile)
+    print "  %s(%d) @ %d" % (name, eid, step_id)
+    return True
+
+async_decode_table = [ Decoder(0, "REPLAY_ASYNC_EVENT_BH", swallow_async_qword),
+                       Decoder(1, "REPLAY_ASYNC_INPUT", decode_unimp),
+                       Decoder(2, "REPLAY_ASYNC_INPUT_SYNC", decode_unimp),
+                       Decoder(3, "REPLAY_ASYNC_CHAR_READ", decode_unimp),
+                       Decoder(4, "REPLAY_ASYNC_EVENT_BLOCK", decode_unimp),
+                       Decoder(5, "REPLAY_ASYNC_EVENT_NET", decode_unimp),
+]
+# See replay_read_events/replay_read_event
+def decode_async(eid, name, dumpfile):
+    """Decode an ASYNC event"""
+
+    print_event(eid, name)
+
+    async_event_kind = read_byte(dumpfile)
+    async_event_checkpoint = read_byte(dumpfile)
+
+    if async_event_checkpoint != replay_state.current_checkpoint:
+        print "  mismatch between checkpoint %d and async data %d" % (
+            replay_state.current_checkpoint, async_event_checkpoint)
+        return True
+
+    return call_decode(async_decode_table, async_event_kind, dumpfile)
+
+
+def decode_instruction(eid, name, dumpfile):
+    ins_diff = read_dword(dumpfile)
+    print_event(eid, name, "0x%x" % (ins_diff))
+    return True
+
+def decode_audio_out(eid, name, dumpfile):
+    audio_data = read_dword(dumpfile)
+    print_event(eid, name, "%d" % (audio_data))
+    return True
+
+def decode_checkpoint(eid, name, dumpfile):
+    """Decode a checkpoint.
+
+    Checkpoints contain a series of async events with their own specific data.
+    """
+    replay_state.set_checkpoint()
+    # save event count as we peek ahead
+    event_number = replay_state.event_count
+    next_event = read_event(dumpfile)
+
+    # if the next event is EVENT_ASYNC there are a bunch of
+    # async events to read, otherwise we are done
+    if next_event != 3:
+        print_event(eid, name, "no additional data", event_number)
+    else:
+        print_event(eid, name, "more data follows", event_number)
+
+    replay_state.reuse_event(next_event)
+    return True
+
+def decode_checkpoint_init(eid, name, dumpfile):
+    print_event(eid, name)
+    return True
+
+def decode_interrupt(eid, name, dumpfile):
+    print_event(eid, name)
+    return True
+
+def decode_clock(eid, name, dumpfile):
+    clock_data = read_qword(dumpfile)
+    print_event(eid, name, "0x%x" % (clock_data))
+    return True
+
+
+# pre-MTTCG merge
+v5_event_table = [Decoder(0, "EVENT_INSTRUCTION", decode_instruction),
+                  Decoder(1, "EVENT_INTERRUPT", decode_interrupt),
+                  Decoder(2, "EVENT_EXCEPTION", decode_unimp),
+                  Decoder(3, "EVENT_ASYNC", decode_async),
+                  Decoder(4, "EVENT_SHUTDOWN", decode_unimp),
+                  Decoder(5, "EVENT_CHAR_WRITE", decode_unimp),
+                  Decoder(6, "EVENT_CHAR_READ_ALL", decode_unimp),
+                  Decoder(7, "EVENT_CHAR_READ_ALL_ERROR", decode_unimp),
+                  Decoder(8, "EVENT_CLOCK_HOST", decode_clock),
+                  Decoder(9, "EVENT_CLOCK_VIRTUAL_RT", decode_clock),
+                  Decoder(10, "EVENT_CP_CLOCK_WARP_START", decode_checkpoint),
+                  Decoder(11, "EVENT_CP_CLOCK_WARP_ACCOUNT", decode_checkpoint),
+                  Decoder(12, "EVENT_CP_RESET_REQUESTED", decode_checkpoint),
+                  Decoder(13, "EVENT_CP_SUSPEND_REQUESTED", decode_checkpoint),
+                  Decoder(14, "EVENT_CP_CLOCK_VIRTUAL", decode_checkpoint),
+                  Decoder(15, "EVENT_CP_CLOCK_HOST", decode_checkpoint),
+                  Decoder(16, "EVENT_CP_CLOCK_VIRTUAL_RT", decode_checkpoint),
+                  Decoder(17, "EVENT_CP_INIT", decode_checkpoint_init),
+                  Decoder(18, "EVENT_CP_RESET", decode_checkpoint),
+]
+
+# post-MTTCG merge, AUDIO support added
+v6_event_table = [Decoder(0, "EVENT_INSTRUCTION", decode_instruction),
+                  Decoder(1, "EVENT_INTERRUPT", decode_interrupt),
+                  Decoder(2, "EVENT_EXCEPTION", decode_unimp),
+                  Decoder(3, "EVENT_ASYNC", decode_async),
+                  Decoder(4, "EVENT_SHUTDOWN", decode_unimp),
+                  Decoder(5, "EVENT_CHAR_WRITE", decode_unimp),
+                  Decoder(6, "EVENT_CHAR_READ_ALL", decode_unimp),
+                  Decoder(7, "EVENT_CHAR_READ_ALL_ERROR", decode_unimp),
+                  Decoder(8, "EVENT_AUDIO_OUT", decode_audio_out),
+                  Decoder(9, "EVENT_AUDIO_IN", decode_unimp),
+                  Decoder(10, "EVENT_CLOCK_HOST", decode_clock),
+                  Decoder(11, "EVENT_CLOCK_VIRTUAL_RT", decode_clock),
+                  Decoder(12, "EVENT_CP_CLOCK_WARP_START", decode_checkpoint),
+                  Decoder(13, "EVENT_CP_CLOCK_WARP_ACCOUNT", decode_checkpoint),
+                  Decoder(14, "EVENT_CP_RESET_REQUESTED", decode_checkpoint),
+                  Decoder(15, "EVENT_CP_SUSPEND_REQUESTED", decode_checkpoint),
+                  Decoder(16, "EVENT_CP_CLOCK_VIRTUAL", decode_checkpoint),
+                  Decoder(17, "EVENT_CP_CLOCK_HOST", decode_checkpoint),
+                  Decoder(18, "EVENT_CP_CLOCK_VIRTUAL_RT", decode_checkpoint),
+                  Decoder(19, "EVENT_CP_INIT", decode_checkpoint_init),
+                  Decoder(20, "EVENT_CP_RESET", decode_checkpoint),
+]
+
+def parse_arguments():
+    "Grab arguments for script"
+    parser = argparse.ArgumentParser()
+    parser.add_argument("-f", "--file", help='record/replay dump to read from',
+                        required=True)
+    return parser.parse_args()
+
+def decode_file(filename):
+    "Decode a record/replay dump"
+    dumpfile = open(filename, "rb")
+
+    # read and throwaway the header
+    version = read_dword(dumpfile)
+    junk = read_qword(dumpfile)
+
+    print "HEADER: version 0x%x" % (version)
+    if version == 0xe02006:
+        event_decode_table = v6_event_table
+        replay_state.checkpoint_start = 12
+    else:
+        event_decode_table = v5_event_table
+        replay_state.checkpoint_start = 10
+
+    try:
+        decode_ok = True
+        while decode_ok:
+            event = read_event(dumpfile)
+            decode_ok = call_decode(event_decode_table, event, dumpfile)
+    finally:
+        dumpfile.close()
+
+if __name__ == "__main__":
+    args = parse_arguments()
+    decode_file(args.file)
-- 
2.11.0
