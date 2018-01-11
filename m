Received: from eggs.gnu.org ([2001:4830:134:3::10]:47597)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1eZYCx-0001Xi-7C
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 03:27:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1eZYCt-0002jb-2V
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 03:27:31 -0500
Received: from mail.ispras.ru ([83.149.199.45]:42032)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1eZYCs-0002iZ-M1
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 03:27:26 -0500
From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Date: Thu, 11 Jan 2018 11:27:27 +0300
Message-ID: <20180111082727.27295.94934.stgit@pasha-VirtualBox>
In-Reply-To: <20180111082452.27295.85707.stgit@pasha-VirtualBox>
References: <20180111082452.27295.85707.stgit@pasha-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC PATCH v3 27/30] scripts/replay-dump.py: replay
 log dumper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, boost.lists@gmail.com, quintela@redhat.com, jasowang@redhat.com, mst@redhat.com, zuban32s@gmail.com, maria.klimushenkova@ispras.ru, dovgaluk@ispras.ru, kraxel@redhat.com, pavel.dovgaluk@ispras.ru, pbonzini@redhat.com, alex.bennee@linaro.org

From: Alex Benn=C3=A9e <alex.bennee@linaro.org>

This script is a debugging tool for looking through the contents of a
replay log file. It is incomplete but should fail gracefully at events
it doesn't understand.

It currently understands two different log formats as the audio
record/replay support was merged during since MTTCG. It was written to
help debug what has caused the BQL changes to break replay support.

Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

---
v2
  - yet another update to the log format
---
 scripts/replay-dump.py |  308 ++++++++++++++++++++++++++++++++++++++++++=
++++++
 1 file changed, 308 insertions(+)
 create mode 100755 scripts/replay-dump.py

diff --git a/scripts/replay-dump.py b/scripts/replay-dump.py
new file mode 100755
index 0000000..203bb31
--- /dev/null
+++ b/scripts/replay-dump.py
@@ -0,0 +1,308 @@
+#!/usr/bin/env python
+# -*- coding: utf-8 -*-
+#
+# Dump the contents of a recorded execution stream
+#
+#  Copyright (c) 2017 Alex Benn=C3=A9e <alex.bennee@linaro.org>
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
+# License along with this library; if not, see <http://www.gnu.org/licen=
ses/>.
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
+        self.event =3D -1
+        self.event_count =3D 0
+        self.already_read =3D False
+        self.current_checkpoint =3D 0
+        self.checkpoint =3D 0
+
+    def set_event(self, ev):
+        self.event =3D ev
+        self.event_count +=3D 1
+
+    def get_event(self):
+        self.already_read =3D False
+        return self.event
+
+    def reuse_event(self, ev):
+        self.event =3D ev
+        self.already_read =3D True
+
+    def set_checkpoint(self):
+        self.checkpoint =3D self.event - self.checkpoint_start
+
+    def get_checkpoint(self):
+        return self.checkpoint
+
+replay_state =3D ReplayState()
+
+# Simple read functions that mirror replay-internal.c
+# The file-stream is big-endian and manually written out a byte at a tim=
e.
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
+Decoder =3D namedtuple("Decoder", "eid name fn")
+
+def call_decode(table, index, dumpfile):
+    "Search decode table for next step"
+    decoder =3D next((d for d in table if d.eid =3D=3D index), None)
+    if not decoder:
+        print "Could not decode index: %d" % (index)
+        print "Entry is: %s" % (decoder)
+        print "Decode Table is:\n%s" % (table)
+        return False
+    else:
+        return decoder.fn(decoder.eid, decoder.name, dumpfile)
+
+# Print event
+def print_event(eid, name, string=3DNone, event_count=3DNone):
+    "Print event with count"
+    if not event_count:
+        event_count =3D replay_state.event_count
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
+    step_id =3D read_qword(dumpfile)
+    print "  %s(%d) @ %d" % (name, eid, step_id)
+    return True
+
+async_decode_table =3D [ Decoder(0, "REPLAY_ASYNC_EVENT_BH", swallow_asy=
nc_qword),
+                       Decoder(1, "REPLAY_ASYNC_INPUT", decode_unimp),
+                       Decoder(2, "REPLAY_ASYNC_INPUT_SYNC", decode_unim=
p),
+                       Decoder(3, "REPLAY_ASYNC_CHAR_READ", decode_unimp=
),
+                       Decoder(4, "REPLAY_ASYNC_EVENT_BLOCK", decode_uni=
mp),
+                       Decoder(5, "REPLAY_ASYNC_EVENT_NET", decode_unimp=
),
+]
+# See replay_read_events/replay_read_event
+def decode_async(eid, name, dumpfile):
+    """Decode an ASYNC event"""
+
+    print_event(eid, name)
+
+    async_event_kind =3D read_byte(dumpfile)
+    async_event_checkpoint =3D read_byte(dumpfile)
+
+    if async_event_checkpoint !=3D replay_state.current_checkpoint:
+        print "  mismatch between checkpoint %d and async data %d" % (
+            replay_state.current_checkpoint, async_event_checkpoint)
+        return True
+
+    return call_decode(async_decode_table, async_event_kind, dumpfile)
+
+
+def decode_instruction(eid, name, dumpfile):
+    ins_diff =3D read_dword(dumpfile)
+    print_event(eid, name, "0x%x" % (ins_diff))
+    return True
+
+def decode_audio_out(eid, name, dumpfile):
+    audio_data =3D read_dword(dumpfile)
+    print_event(eid, name, "%d" % (audio_data))
+    return True
+
+def decode_checkpoint(eid, name, dumpfile):
+    """Decode a checkpoint.
+
+    Checkpoints contain a series of async events with their own specific=
 data.
+    """
+    replay_state.set_checkpoint()
+    # save event count as we peek ahead
+    event_number =3D replay_state.event_count
+    next_event =3D read_event(dumpfile)
+
+    # if the next event is EVENT_ASYNC there are a bunch of
+    # async events to read, otherwise we are done
+    if next_event !=3D 3:
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
+    clock_data =3D read_qword(dumpfile)
+    print_event(eid, name, "0x%x" % (clock_data))
+    return True
+
+
+# pre-MTTCG merge
+v5_event_table =3D [Decoder(0, "EVENT_INSTRUCTION", decode_instruction),
+                  Decoder(1, "EVENT_INTERRUPT", decode_interrupt),
+                  Decoder(2, "EVENT_EXCEPTION", decode_unimp),
+                  Decoder(3, "EVENT_ASYNC", decode_async),
+                  Decoder(4, "EVENT_SHUTDOWN", decode_unimp),
+                  Decoder(5, "EVENT_CHAR_WRITE", decode_unimp),
+                  Decoder(6, "EVENT_CHAR_READ_ALL", decode_unimp),
+                  Decoder(7, "EVENT_CHAR_READ_ALL_ERROR", decode_unimp),
+                  Decoder(8, "EVENT_CLOCK_HOST", decode_clock),
+                  Decoder(9, "EVENT_CLOCK_VIRTUAL_RT", decode_clock),
+                  Decoder(10, "EVENT_CP_CLOCK_WARP_START", decode_checkp=
oint),
+                  Decoder(11, "EVENT_CP_CLOCK_WARP_ACCOUNT", decode_chec=
kpoint),
+                  Decoder(12, "EVENT_CP_RESET_REQUESTED", decode_checkpo=
int),
+                  Decoder(13, "EVENT_CP_SUSPEND_REQUESTED", decode_check=
point),
+                  Decoder(14, "EVENT_CP_CLOCK_VIRTUAL", decode_checkpoin=
t),
+                  Decoder(15, "EVENT_CP_CLOCK_HOST", decode_checkpoint),
+                  Decoder(16, "EVENT_CP_CLOCK_VIRTUAL_RT", decode_checkp=
oint),
+                  Decoder(17, "EVENT_CP_INIT", decode_checkpoint_init),
+                  Decoder(18, "EVENT_CP_RESET", decode_checkpoint),
+]
+
+# post-MTTCG merge, AUDIO support added
+v6_event_table =3D [Decoder(0, "EVENT_INSTRUCTION", decode_instruction),
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
+                  Decoder(12, "EVENT_CP_CLOCK_WARP_START", decode_checkp=
oint),
+                  Decoder(13, "EVENT_CP_CLOCK_WARP_ACCOUNT", decode_chec=
kpoint),
+                  Decoder(14, "EVENT_CP_RESET_REQUESTED", decode_checkpo=
int),
+                  Decoder(15, "EVENT_CP_SUSPEND_REQUESTED", decode_check=
point),
+                  Decoder(16, "EVENT_CP_CLOCK_VIRTUAL", decode_checkpoin=
t),
+                  Decoder(17, "EVENT_CP_CLOCK_HOST", decode_checkpoint),
+                  Decoder(18, "EVENT_CP_CLOCK_VIRTUAL_RT", decode_checkp=
oint),
+                  Decoder(19, "EVENT_CP_INIT", decode_checkpoint_init),
+                  Decoder(20, "EVENT_CP_RESET", decode_checkpoint),
+]
+
+# Shutdown cause added
+v7_event_table =3D [Decoder(0, "EVENT_INSTRUCTION", decode_instruction),
+                  Decoder(1, "EVENT_INTERRUPT", decode_interrupt),
+                  Decoder(2, "EVENT_EXCEPTION", decode_unimp),
+                  Decoder(3, "EVENT_ASYNC", decode_async),
+                  Decoder(4, "EVENT_SHUTDOWN", decode_unimp),
+                  Decoder(5, "EVENT_SHUTDOWN_HOST_ERR", decode_unimp),
+                  Decoder(6, "EVENT_SHUTDOWN_HOST_QMP", decode_unimp),
+                  Decoder(7, "EVENT_SHUTDOWN_HOST_SIGNAL", decode_unimp)=
,
+                  Decoder(8, "EVENT_SHUTDOWN_HOST_UI", decode_unimp),
+                  Decoder(9, "EVENT_SHUTDOWN_GUEST_SHUTDOWN", decode_uni=
mp),
+                  Decoder(10, "EVENT_SHUTDOWN_GUEST_RESET", decode_unimp=
),
+                  Decoder(11, "EVENT_SHUTDOWN_GUEST_PANIC", decode_unimp=
),
+                  Decoder(12, "EVENT_SHUTDOWN___MAX", decode_unimp),
+                  Decoder(13, "EVENT_CHAR_WRITE", decode_unimp),
+                  Decoder(14, "EVENT_CHAR_READ_ALL", decode_unimp),
+                  Decoder(15, "EVENT_CHAR_READ_ALL_ERROR", decode_unimp)=
,
+                  Decoder(16, "EVENT_AUDIO_OUT", decode_audio_out),
+                  Decoder(17, "EVENT_AUDIO_IN", decode_unimp),
+                  Decoder(18, "EVENT_CLOCK_HOST", decode_clock),
+                  Decoder(19, "EVENT_CLOCK_VIRTUAL_RT", decode_clock),
+                  Decoder(20, "EVENT_CP_CLOCK_WARP_START", decode_checkp=
oint),
+                  Decoder(21, "EVENT_CP_CLOCK_WARP_ACCOUNT", decode_chec=
kpoint),
+                  Decoder(22, "EVENT_CP_RESET_REQUESTED", decode_checkpo=
int),
+                  Decoder(23, "EVENT_CP_SUSPEND_REQUESTED", decode_check=
point),
+                  Decoder(24, "EVENT_CP_CLOCK_VIRTUAL", decode_checkpoin=
t),
+                  Decoder(25, "EVENT_CP_CLOCK_HOST", decode_checkpoint),
+                  Decoder(26, "EVENT_CP_CLOCK_VIRTUAL_RT", decode_checkp=
oint),
+                  Decoder(27, "EVENT_CP_INIT", decode_checkpoint_init),
+                  Decoder(28, "EVENT_CP_RESET", decode_checkpoint),
+]
+
+def parse_arguments():
+    "Grab arguments for script"
+    parser =3D argparse.ArgumentParser()
+    parser.add_argument("-f", "--file", help=3D'record/replay dump to re=
ad from',
+                        required=3DTrue)
+    return parser.parse_args()
+
+def decode_file(filename):
+    "Decode a record/replay dump"
+    dumpfile =3D open(filename, "rb")
+
+    # read and throwaway the header
+    version =3D read_dword(dumpfile)
+    junk =3D read_qword(dumpfile)
+
+    print "HEADER: version 0x%x" % (version)
+
+    if version =3D=3D 0xe02007:
+        event_decode_table =3D v7_event_table
+        replay_state.checkpoint_start =3D 12
+    elif version =3D=3D 0xe02006:
+        event_decode_table =3D v6_event_table
+        replay_state.checkpoint_start =3D 12
+    else:
+        event_decode_table =3D v5_event_table
+        replay_state.checkpoint_start =3D 10
+
+    try:
+        decode_ok =3D True
+        while decode_ok:
+            event =3D read_event(dumpfile)
+            decode_ok =3D call_decode(event_decode_table, event, dumpfil=
e)
+    finally:
+        dumpfile.close()
+
+if __name__ =3D=3D "__main__":
+    args =3D parse_arguments()
+    decode_file(args.file)
