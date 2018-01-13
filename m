Received: from eggs.gnu.org ([2001:4830:134:3::10]:48978)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1eaPQS-0002xO-VQ
	for qemu-devel@nongnu.org; Sat, 13 Jan 2018 12:17:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1eaPQP-00076c-QF
	for qemu-devel@nongnu.org; Sat, 13 Jan 2018 12:17:00 -0500
Received: from mail.uni-paderborn.de ([131.234.142.9]:35084)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kbastian@mail.uni-paderborn.de>)
	id 1eaPQP-00072K-FX
	for qemu-devel@nongnu.org; Sat, 13 Jan 2018 12:16:57 -0500
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Message-ID: <3b39502a-5c54-c4ca-38af-6ac4c04fb22b@mail.uni-paderborn.de>
Date: Sat, 13 Jan 2018 18:14:25 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC 01/23] scripts: Add decodetree.py
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>

Hi Richard,

+# Field examples:
+#
+#   %disp   0:s16          -- sextract(i, 0, 16)
+#   %imm9   16:6 10:3      -- extract(i, 16, 6) << 3 | extract(i, 10, 3)

startindex:endindex for unnamed_field is more intuitive. As any ISA
manual would specify those.

+#
+# It is recommended, but not required, that all field_ref and args_ref
+# appear at the end of the line, not interleaving with fixedbit_elf or
+# field_elt.

This seems not very intuitive to me. Why specify the field_refs at the
end and fill the space they occupy with '.'? I'd prefer interleaving the
reference to make it more readable (which doesn't work so far)


+# Pattern examples:
+#
+#   addl_r   010000 ..... ..... .... 0000000 ..... @opr
+#   addl_i   010000 ..... ..... .... 0000000 ..... @opi

We should note in the documentation where the LSB is. Got that the wrong
way in the first time I implemented RISC-V .

+def str_indent(c):
+    """Return a string with C spaces"""
+    r = ''
+    for i in range(0, c):
+        r += ' '
+    return r

return ' ' * c

+def popcount(b):
+    b = (b & 0x55555555) + ((b >> 1) & 0x55555555)
+    b = (b & 0x33333333) + ((b >> 2) & 0x33333333)
+    b = (b & 0x0f0f0f0f) + ((b >> 4) & 0x0f0f0f0f)
+    b = (b + (b >> 8)) & 0x00ff00ff
+    b = (b + (b >> 16)) & 0xffff
+    return b

We really don't need to look for efficiency here?
return bin(b).count('1')

+def parse_arguments(lineno, name, toks):
+    """Parse one argument set from TOKS at LINENO"""
+    global arguments
+    global re_ident
+
+    flds = []

arg_fields is a better name. Likewise for other places containing flds.
Such that one knows where this fields belongs to.

+        elif name[0] == '&':
+            parse_arguments(lineno, name[1:], toks)
+        elif name[0] == '@':
+            parse_generic(lineno, True, name[1:], toks)
+        else:
+            parse_generic(lineno, False, name, toks)
+        toks = []

Why do we have a generic function for pat and fields? Rather make it two
parse functions and split subparsings that they share into generic
functions, instead of doing the distinction in parse_generic().

+        for p in pats:
+            pnames.append(p.name)
+        #pdb.set_trace()

Guess you forgot that ;)

+    long_opts = [ 'decode=', 'translate=', 'header=', 'output=' ]
+    try:
+        (opts, args) = getopt.getopt(sys.argv[1:], 'h:o:', long_opts)
+    except getopt.GetoptError as err:
+        error(0, err)
+    for o, a in opts:
+        if o in ('-h', '--header'):
+            h_file = a
+        elif o in ('-o', '--output'):
+            c_file = a
+        elif o == '--decode':
+            decode_function = a
+        elif o == '--translate':
+            translate_prefix = a
+        else:
+            assert False, 'unhandled option'

Please use argsparse

On a more general note. Do you really need to invent your own
description format + parser? Why not reuse an existing markup language?
Can you give me a rationale?

That said, your description language looks very readable, even though
I'm not a big fan of symbol prefixes ;).

Thanks for improving my original approach.

Cheers,
Bastian
