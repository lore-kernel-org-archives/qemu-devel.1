Received: from eggs.gnu.org ([2001:4830:134:3::10]:44880)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1eApPL-0005zq-1t
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 23:46:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1eApPC-0000Xc-Tv
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 23:46:07 -0400
Received: from mail-lf0-x22e.google.com ([2a00:1450:4010:c07::22e]:53315)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1eApPC-0000Ww-6y
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 23:45:58 -0400
Received: by mail-lf0-x22e.google.com with SMTP id l23so5144792lfk.10
	for <qemu-devel@nongnu.org>; Fri, 03 Nov 2017 20:45:58 -0700 (PDT)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Fri,  3 Nov 2017 20:45:07 -0700
Message-Id: <1509767121-26925-3-git-send-email-jcmvbkbc@gmail.com>
In-Reply-To: <1509767121-26925-1-git-send-email-jcmvbkbc@gmail.com>
References: <1509767121-26925-1-git-send-email-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH 02/16] target/xtensa: import libisa source
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, Max Filippov <jcmvbkbc@gmail.com>

The canonical way of dealing with Xtensa instructions decoding and
encoding is through the libisa. Libisa is a configuration-independent
library with a stable interface plus generated configuration-specific
xtensa-modules.c file with implementations of decoding and encoding
functions. Libisa is MIT-licensed and originally disributed
xtensa-modules.c files are also MIT-licensed and are available as a
part of xtensa configuration overlay.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 include/hw/xtensa/xtensa-isa.h      |  838 +++++++++++++++++
 target/xtensa/Makefile.objs         |    1 +
 target/xtensa/xtensa-isa-internal.h |  231 +++++
 target/xtensa/xtensa-isa.c          | 1745 +++++++++++++++++++++++++++++++++++
 target/xtensa/xtensa-isa.h          |    1 +
 5 files changed, 2816 insertions(+)
 create mode 100644 include/hw/xtensa/xtensa-isa.h
 create mode 100644 target/xtensa/xtensa-isa-internal.h
 create mode 100644 target/xtensa/xtensa-isa.c
 create mode 100644 target/xtensa/xtensa-isa.h

diff --git a/include/hw/xtensa/xtensa-isa.h b/include/hw/xtensa/xtensa-isa.h
new file mode 100644
index 000000000000..353f82ba251e
--- /dev/null
+++ b/include/hw/xtensa/xtensa-isa.h
@@ -0,0 +1,838 @@
+/* Interface definition for configurable Xtensa ISA support.
+ *
+ * Copyright (c) 2001-2013 Tensilica Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining
+ * a copy of this software and associated documentation files (the
+ * "Software"), to deal in the Software without restriction, including
+ * without limitation the rights to use, copy, modify, merge, publish,
+ * distribute, sublicense, and/or sell copies of the Software, and to
+ * permit persons to whom the Software is furnished to do so, subject to
+ * the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included
+ * in all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+ * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
+ * IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
+ * CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
+ * TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
+ * SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+#ifndef XTENSA_LIBISA_H
+#define XTENSA_LIBISA_H
+
+#include <stdint.h>
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+/*
+ * Version number: This is intended to help support code that works with
+ * versions of this library from multiple Xtensa releases.
+ */
+
+#define XTENSA_ISA_VERSION 7000
+
+/*
+ * This file defines the interface to the Xtensa ISA library. This
+ * library contains most of the ISA-specific information for a
+ * particular Xtensa processor. For example, the set of valid
+ * instructions, their opcode encodings and operand fields are all
+ * included here.
+ *
+ * This interface basically defines a number of abstract data types.
+ *
+ * . an instruction buffer - for holding the raw instruction bits
+ * . ISA info - information about the ISA as a whole
+ * . instruction formats - instruction size and slot structure
+ * . opcodes - information about individual instructions
+ * . operands - information about register and immediate instruction operands
+ * . stateOperands - information about processor state instruction operands
+ * . interfaceOperands - information about interface instruction operands
+ * . register files - register file information
+ * . processor states - internal processor state information
+ * . system registers - "special registers" and "user registers"
+ * . interfaces - TIE interfaces that are external to the processor
+ * . functional units - TIE shared functions
+ *
+ * The interface defines a set of functions to access each data type.
+ * With the exception of the instruction buffer, the internal
+ * representations of the data structures are hidden. All accesses must
+ * be made through the functions defined here.
+ */
+
+typedef struct xtensa_isa_opaque { int unused; } *xtensa_isa;
+
+
+/*
+ * Most of the Xtensa ISA entities (e.g., opcodes, regfiles, etc.) are
+ * represented here using sequential integers beginning with 0. The
+ * specific values are only fixed for a particular instantiation of an
+ * xtensa_isa structure, so these values should only be used
+ * internally.
+ */
+
+typedef int xtensa_opcode;
+typedef int xtensa_format;
+typedef int xtensa_regfile;
+typedef int xtensa_state;
+typedef int xtensa_sysreg;
+typedef int xtensa_interface;
+typedef int xtensa_funcUnit;
+
+
+/* Define a unique value for undefined items. */
+
+#define XTENSA_UNDEFINED -1
+
+
+/*
+ * Overview of using this interface to decode/encode instructions:
+ *
+ * Each Xtensa instruction is associated with a particular instruction
+ * format, where the format defines a fixed number of slots for
+ * operations. The formats for the core Xtensa ISA have only one slot,
+ * but FLIX instructions may have multiple slots. Within each slot,
+ * there is a single opcode and some number of associated operands.
+ *
+ * The encoding and decoding functions operate on instruction buffers,
+ * not on the raw bytes of the instructions. The same instruction
+ * buffer data structure is used for both entire instructions and
+ * individual slots in those instructions -- the contents of a slot need
+ * to be extracted from or inserted into the buffer for the instruction
+ * as a whole.
+ *
+ * Decoding an instruction involves first finding the format, which
+ * identifies the number of slots, and then decoding each slot
+ * separately. A slot is decoded by finding the opcode and then using
+ * the opcode to determine how many operands there are. For example:
+ *
+ * xtensa_insnbuf_from_chars
+ * xtensa_format_decode
+ * for each slot {
+ *   xtensa_format_get_slot
+ *   xtensa_opcode_decode
+ *   for each operand {
+ *     xtensa_operand_get_field
+ *     xtensa_operand_decode
+ *   }
+ * }
+ *
+ * Encoding an instruction is roughly the same procedure in reverse:
+ *
+ * xtensa_format_encode
+ * for each slot {
+ *   xtensa_opcode_encode
+ *   for each operand {
+ *     xtensa_operand_encode
+ *     xtensa_operand_set_field
+ *   }
+ *   xtensa_format_set_slot
+ * }
+ * xtensa_insnbuf_to_chars
+ */
+
+
+/* Error handling. */
+
+/*
+ * Error codes. The code for the most recent error condition can be
+ * retrieved with the "errno" function. For any result other than
+ * xtensa_isa_ok, an error message containing additional information
+ * about the problem can be retrieved using the "error_msg" function.
+ * The error messages are stored in an internal buffer, which should
+ * not be freed and may be overwritten by subsequent operations.
+ */
+
+typedef enum xtensa_isa_status_enum {
+    xtensa_isa_ok = 0,
+    xtensa_isa_bad_format,
+    xtensa_isa_bad_slot,
+    xtensa_isa_bad_opcode,
+    xtensa_isa_bad_operand,
+    xtensa_isa_bad_field,
+    xtensa_isa_bad_iclass,
+    xtensa_isa_bad_regfile,
+    xtensa_isa_bad_sysreg,
+    xtensa_isa_bad_state,
+    xtensa_isa_bad_interface,
+    xtensa_isa_bad_funcUnit,
+    xtensa_isa_wrong_slot,
+    xtensa_isa_no_field,
+    xtensa_isa_out_of_memory,
+    xtensa_isa_buffer_overflow,
+    xtensa_isa_internal_error,
+    xtensa_isa_bad_value
+} xtensa_isa_status;
+
+xtensa_isa_status xtensa_isa_errno(xtensa_isa isa);
+
+char *xtensa_isa_error_msg(xtensa_isa isa);
+
+
+
+/* Instruction buffers. */
+
+typedef uint32_t xtensa_insnbuf_word;
+typedef xtensa_insnbuf_word *xtensa_insnbuf;
+
+
+/* Get the size in "insnbuf_words" of the xtensa_insnbuf array. */
+
+int xtensa_insnbuf_size(xtensa_isa isa);
+
+
+/* Allocate an xtensa_insnbuf of the right size. */
+
+xtensa_insnbuf xtensa_insnbuf_alloc(xtensa_isa isa);
+
+
+/* Release an xtensa_insnbuf. */
+
+void xtensa_insnbuf_free(xtensa_isa isa, xtensa_insnbuf buf);
+
+
+/*
+ * Conversion between raw memory (char arrays) and our internal
+ * instruction representation. This is complicated by the Xtensa ISA's
+ * variable instruction lengths. When converting to chars, the buffer
+ * must contain a valid instruction so we know how many bytes to copy;
+ * thus, the "to_chars" function returns the number of bytes copied or
+ * XTENSA_UNDEFINED on error. The "from_chars" function first reads the
+ * minimal number of bytes required to decode the instruction length and
+ * then proceeds to copy the entire instruction into the buffer; if the
+ * memory does not contain a valid instruction, it copies the maximum
+ * number of bytes required for the longest Xtensa instruction. The
+ * "num_chars" argument may be used to limit the number of bytes that
+ * can be read or written. Otherwise, if "num_chars" is zero, the
+ * functions may read or write past the end of the code.
+ */
+
+int xtensa_insnbuf_to_chars(xtensa_isa isa, const xtensa_insnbuf insn,
+                            unsigned char *cp, int num_chars);
+
+void xtensa_insnbuf_from_chars(xtensa_isa isa, xtensa_insnbuf insn,
+                               const unsigned char *cp, int num_chars);
+
+
+
+/* ISA information. */
+
+/* Initialize the ISA information. */
+
+xtensa_isa xtensa_isa_init(void *xtensa_modules, xtensa_isa_status *errno_p,
+                           char **error_msg_p);
+
+
+/* Deallocate an xtensa_isa structure. */
+
+void xtensa_isa_free(xtensa_isa isa);
+
+
+/* Get the maximum instruction size in bytes. */
+
+int xtensa_isa_maxlength(xtensa_isa isa);
+
+
+/*
+ * Decode the length in bytes of an instruction in raw memory (not an
+ * insnbuf). This function reads only the minimal number of bytes
+ * required to decode the instruction length. Returns
+ * XTENSA_UNDEFINED on error.
+ */
+
+int xtensa_isa_length_from_chars(xtensa_isa isa, const unsigned char *cp);
+
+
+/*
+ * Get the number of stages in the processor's pipeline. The pipeline
+ * stage values returned by other functions in this library will range
+ * from 0 to N-1, where N is the value returned by this function.
+ * Note that the stage numbers used here may not correspond to the
+ * actual processor hardware, e.g., the hardware may have additional
+ * stages before stage 0. Returns XTENSA_UNDEFINED on error.
+ */
+
+int xtensa_isa_num_pipe_stages(xtensa_isa isa);
+
+
+/* Get the number of various entities that are defined for this processor. */
+
+int xtensa_isa_num_formats(xtensa_isa isa);
+
+int xtensa_isa_num_opcodes(xtensa_isa isa);
+
+int xtensa_isa_num_regfiles(xtensa_isa isa);
+
+int xtensa_isa_num_states(xtensa_isa isa);
+
+int xtensa_isa_num_sysregs(xtensa_isa isa);
+
+int xtensa_isa_num_interfaces(xtensa_isa isa);
+
+int xtensa_isa_num_funcUnits(xtensa_isa isa);
+
+
+
+/* Instruction formats. */
+
+/* Get the name of a format. Returns null on error. */
+
+const char *xtensa_format_name(xtensa_isa isa, xtensa_format fmt);
+
+
+/*
+ * Given a format name, return the format number. Returns
+ * XTENSA_UNDEFINED if the name is not a valid format.
+ */
+
+xtensa_format xtensa_format_lookup(xtensa_isa isa, const char *fmtname);
+
+
+/*
+ * Decode the instruction format from a binary instruction buffer.
+ * Returns XTENSA_UNDEFINED if the format is not recognized.
+ */
+
+xtensa_format xtensa_format_decode(xtensa_isa isa, const xtensa_insnbuf insn);
+
+
+/*
+ * Set the instruction format field(s) in a binary instruction buffer.
+ * All the other fields are set to zero. Returns non-zero on error.
+ */
+
+int xtensa_format_encode(xtensa_isa isa, xtensa_format fmt,
+                         xtensa_insnbuf insn);
+
+
+/*
+ * Find the length (in bytes) of an instruction. Returns
+ * XTENSA_UNDEFINED on error.
+ */
+
+int xtensa_format_length(xtensa_isa isa, xtensa_format fmt);
+
+
+/*
+ * Get the number of slots in an instruction. Returns XTENSA_UNDEFINED
+ * on error.
+ */
+
+int xtensa_format_num_slots(xtensa_isa isa, xtensa_format fmt);
+
+
+/*
+ * Get the opcode for a no-op in a particular slot.
+ * Returns XTENSA_UNDEFINED on error.
+ */
+
+xtensa_opcode xtensa_format_slot_nop_opcode(xtensa_isa isa, xtensa_format fmt,
+                                            int slot);
+
+
+/*
+ * Get the bits for a specified slot out of an insnbuf for the
+ * instruction as a whole and put them into an insnbuf for that one
+ * slot, and do the opposite to set a slot. Return non-zero on error.
+ */
+
+int xtensa_format_get_slot(xtensa_isa isa, xtensa_format fmt, int slot,
+                           const xtensa_insnbuf insn, xtensa_insnbuf slotbuf);
+
+int xtensa_format_set_slot(xtensa_isa isa, xtensa_format fmt, int slot,
+                           xtensa_insnbuf insn, const xtensa_insnbuf slotbuf);
+
+
+
+/* Opcode information. */
+
+/*
+ * Translate a mnemonic name to an opcode. Returns XTENSA_UNDEFINED if
+ * the name is not a valid opcode mnemonic.
+ */
+
+xtensa_opcode xtensa_opcode_lookup(xtensa_isa isa, const char *opname);
+
+
+/*
+ * Decode the opcode for one instruction slot from a binary instruction
+ * buffer. Returns the opcode or XTENSA_UNDEFINED if the opcode is
+ * illegal.
+ */
+
+xtensa_opcode xtensa_opcode_decode(xtensa_isa isa, xtensa_format fmt, int slot,
+                                   const xtensa_insnbuf slotbuf);
+
+
+/*
+ * Set the opcode field(s) for an instruction slot. All other fields
+ * in the slot are set to zero. Returns non-zero if the opcode cannot
+ * be encoded.
+ */
+
+int xtensa_opcode_encode(xtensa_isa isa, xtensa_format fmt, int slot,
+                         xtensa_insnbuf slotbuf, xtensa_opcode opc);
+
+
+/* Get the mnemonic name for an opcode. Returns null on error. */
+
+const char *xtensa_opcode_name(xtensa_isa isa, xtensa_opcode opc);
+
+
+/* Check various properties of opcodes. These functions return 0 if
+ * the condition is false, 1 if the condition is true, and
+ * XTENSA_UNDEFINED on error. The instructions are classified as
+ * follows:
+ *
+ * branch: conditional branch; may fall through to next instruction (B*)
+ * jump: unconditional branch (J, JX, RET*, RF*)
+ * loop: zero-overhead loop (LOOP*)
+ * call: unconditional call; control returns to next instruction (CALL*)
+ *
+ * For the opcodes that affect control flow in some way, the branch
+ * target may be specified by an immediate operand or it may be an
+ * address stored in a register. You can distinguish these by
+ * checking if the instruction has a PC-relative immediate
+ * operand.
+ */
+
+int xtensa_opcode_is_branch(xtensa_isa isa, xtensa_opcode opc);
+
+int xtensa_opcode_is_jump(xtensa_isa isa, xtensa_opcode opc);
+
+int xtensa_opcode_is_loop(xtensa_isa isa, xtensa_opcode opc);
+
+int xtensa_opcode_is_call(xtensa_isa isa, xtensa_opcode opc);
+
+
+/*
+ * Find the number of ordinary operands, state operands, and interface
+ * operands for an instruction. These return XTENSA_UNDEFINED on
+ * error.
+ */
+
+int xtensa_opcode_num_operands(xtensa_isa isa, xtensa_opcode opc);
+
+int xtensa_opcode_num_stateOperands(xtensa_isa isa, xtensa_opcode opc);
+
+int xtensa_opcode_num_interfaceOperands(xtensa_isa isa, xtensa_opcode opc);
+
+
+/*
+ * Get functional unit usage requirements for an opcode. Each "use"
+ * is identified by a <functional unit, pipeline stage> pair. The
+ * "num_funcUnit_uses" function returns the number of these "uses" or
+ * XTENSA_UNDEFINED on error. The "funcUnit_use" function returns
+ * a pointer to a "use" pair or null on error.
+ */
+
+typedef struct xtensa_funcUnit_use_struct {
+    xtensa_funcUnit unit;
+    int stage;
+} xtensa_funcUnit_use;
+
+int xtensa_opcode_num_funcUnit_uses(xtensa_isa isa, xtensa_opcode opc);
+
+xtensa_funcUnit_use *xtensa_opcode_funcUnit_use(xtensa_isa isa,
+                                                xtensa_opcode opc, int u);
+
+
+
+/* Operand information. */
+
+/* Get the name of an operand. Returns null on error. */
+
+const char *xtensa_operand_name(xtensa_isa isa, xtensa_opcode opc, int opnd);
+
+
+/*
+ * Some operands are "invisible", i.e., not explicitly specified in
+ * assembly language. When assembling an instruction, you need not set
+ * the values of invisible operands, since they are either hardwired or
+ * derived from other field values. The values of invisible operands
+ * can be examined in the same way as other operands, but remember that
+ * an invisible operand may get its value from another visible one, so
+ * the entire instruction must be available before examining the
+ * invisible operand values. This function returns 1 if an operand is
+ * visible, 0 if it is invisible, or XTENSA_UNDEFINED on error. Note
+ * that whether an operand is visible is orthogonal to whether it is
+ * "implicit", i.e., whether it is encoded in a field in the
+ * instruction.
+ */
+
+int xtensa_operand_is_visible(xtensa_isa isa, xtensa_opcode opc, int opnd);
+
+
+/*
+ * Check if an operand is an input ('i'), output ('o'), or inout ('m')
+ * operand. Note: The output operand of a conditional assignment
+ * (e.g., movnez) appears here as an inout ('m') even if it is declared
+ * in the TIE code as an output ('o'); this allows the compiler to
+ * properly handle register allocation for conditional assignments.
+ * Returns 0 on error.
+ */
+
+char xtensa_operand_inout(xtensa_isa isa, xtensa_opcode opc, int opnd);
+
+
+/*
+ * Get and set the raw (encoded) value of the field for the specified
+ * operand. The "set" function does not check if the value fits in the
+ * field; that is done by the "encode" function below. Both of these
+ * functions return non-zero on error, e.g., if the field is not defined
+ * for the specified slot.
+ */
+
+int xtensa_operand_get_field(xtensa_isa isa, xtensa_opcode opc, int opnd,
+                             xtensa_format fmt, int slot,
+                             const xtensa_insnbuf slotbuf, uint32_t *valp);
+
+int xtensa_operand_set_field(xtensa_isa isa, xtensa_opcode opc, int opnd,
+                             xtensa_format fmt, int slot,
+                             xtensa_insnbuf slotbuf, uint32_t val);
+
+
+/*
+ * Encode and decode operands. The raw bits in the operand field may
+ * be encoded in a variety of different ways. These functions hide
+ * the details of that encoding. The result values are returned through
+ * the argument pointer. The return value is non-zero on error.
+ */
+
+int xtensa_operand_encode(xtensa_isa isa, xtensa_opcode opc, int opnd,
+                          uint32_t *valp);
+
+int xtensa_operand_decode(xtensa_isa isa, xtensa_opcode opc, int opnd,
+                          uint32_t *valp);
+
+
+/*
+ * An operand may be either a register operand or an immediate of some
+ * sort (e.g., PC-relative or not). The "is_register" function returns
+ * 0 if the operand is an immediate, 1 if it is a register, and
+ * XTENSA_UNDEFINED on error. The "regfile" function returns the
+ * regfile for a register operand, or XTENSA_UNDEFINED on error.
+ */
+
+int xtensa_operand_is_register(xtensa_isa isa, xtensa_opcode opc, int opnd);
+
+xtensa_regfile xtensa_operand_regfile(xtensa_isa isa, xtensa_opcode opc,
+                                      int opnd);
+
+
+/*
+ * Register operands may span multiple consecutive registers, e.g., a
+ * 64-bit data type may occupy two 32-bit registers. Only the first
+ * register is encoded in the operand field. This function specifies
+ * the number of consecutive registers occupied by this operand. For
+ * non-register operands, the return value is undefined. Returns
+ * XTENSA_UNDEFINED on error.
+ */
+
+int xtensa_operand_num_regs(xtensa_isa isa, xtensa_opcode opc, int opnd);
+
+
+/*
+ * Some register operands do not completely identify the register being
+ * accessed. For example, the operand value may be added to an internal
+ * state value. By definition, this implies that the corresponding
+ * regfile is not allocatable. Unknown registers should generally be
+ * treated with worst-case assumptions. The function returns 0 if the
+ * register value is unknown, 1 if known, and XTENSA_UNDEFINED on
+ * error.
+ */
+
+int xtensa_operand_is_known_reg(xtensa_isa isa, xtensa_opcode opc, int opnd);
+
+
+/*
+ * Check if an immediate operand is PC-relative. Returns 0 for register
+ * operands and non-PC-relative immediates, 1 for PC-relative
+ * immediates, and XTENSA_UNDEFINED on error.
+ */
+
+int xtensa_operand_is_PCrelative(xtensa_isa isa, xtensa_opcode opc, int opnd);
+
+
+/*
+ * For PC-relative offset operands, the interpretation of the offset may
+ * vary between opcodes, e.g., is it relative to the current PC or that
+ * of the next instruction?  The following functions are defined to
+ * perform PC-relative relocations and to undo them (as in the
+ * disassembler). The "do_reloc" function takes the desired address
+ * value and the PC of the current instruction and sets the value to the
+ * corresponding PC-relative offset (which can then be encoded and
+ * stored into the operand field). The "undo_reloc" function takes the
+ * unencoded offset value and the current PC and sets the value to the
+ * appropriate address. The return values are non-zero on error. Note
+ * that these functions do not replace the encode/decode functions; the
+ * operands must be encoded/decoded separately and the encode functions
+ * are responsible for detecting invalid operand values.
+ */
+
+int xtensa_operand_do_reloc(xtensa_isa isa, xtensa_opcode opc, int opnd,
+                            uint32_t *valp, uint32_t pc);
+
+int xtensa_operand_undo_reloc(xtensa_isa isa, xtensa_opcode opc, int opnd,
+                              uint32_t *valp, uint32_t pc);
+
+
+
+/* State Operands. */
+
+/*
+ * Get the state accessed by a state operand. Returns XTENSA_UNDEFINED
+ * on error.
+ */
+
+xtensa_state xtensa_stateOperand_state(xtensa_isa isa, xtensa_opcode opc,
+                                       int stOp);
+
+
+/*
+ * Check if a state operand is an input ('i'), output ('o'), or inout
+ * ('m') operand. Returns 0 on error.
+ */
+
+char xtensa_stateOperand_inout(xtensa_isa isa, xtensa_opcode opc, int stOp);
+
+
+
+/* Interface Operands. */
+
+/*
+ * Get the external interface accessed by an interface operand.
+ * Returns XTENSA_UNDEFINED on error.
+ */
+
+xtensa_interface xtensa_interfaceOperand_interface(xtensa_isa isa,
+                                                   xtensa_opcode opc,
+                                                   int ifOp);
+
+
+
+/* Register Files. */
+
+/*
+ * Regfiles include both "real" regfiles and "views", where a view
+ * allows a group of adjacent registers in a real "parent" regfile to be
+ * viewed as a single register. A regfile view has all the same
+ * properties as its parent except for its (long) name, bit width, number
+ * of entries, and default ctype. You can use the parent function to
+ * distinguish these two classes.
+ */
+
+/*
+ * Look up a regfile by either its name or its abbreviated "short name".
+ * Returns XTENSA_UNDEFINED on error. The "lookup_shortname" function
+ * ignores "view" regfiles since they always have the same shortname as
+ * their parents.
+ */
+
+xtensa_regfile xtensa_regfile_lookup(xtensa_isa isa, const char *name);
+
+xtensa_regfile xtensa_regfile_lookup_shortname(xtensa_isa isa,
+                                               const char *shortname);
+
+
+/*
+ * Get the name or abbreviated "short name" of a regfile.
+ * Returns null on error.
+ */
+
+const char *xtensa_regfile_name(xtensa_isa isa, xtensa_regfile rf);
+
+const char *xtensa_regfile_shortname(xtensa_isa isa, xtensa_regfile rf);
+
+
+/*
+ * Get the parent regfile of a "view" regfile. If the regfile is not a
+ * view, the result is the same as the input parameter. Returns
+ * XTENSA_UNDEFINED on error.
+ */
+
+xtensa_regfile xtensa_regfile_view_parent(xtensa_isa isa, xtensa_regfile rf);
+
+
+/*
+ * Get the bit width of a regfile or regfile view.
+ * Returns XTENSA_UNDEFINED on error.
+ */
+
+int xtensa_regfile_num_bits(xtensa_isa isa, xtensa_regfile rf);
+
+
+/*
+ * Get the number of regfile entries. Returns XTENSA_UNDEFINED on
+ * error.
+ */
+
+int xtensa_regfile_num_entries(xtensa_isa isa, xtensa_regfile rf);
+
+
+
+/* Processor States. */
+
+/* Look up a state by name. Returns XTENSA_UNDEFINED on error. */
+
+xtensa_state xtensa_state_lookup(xtensa_isa isa, const char *name);
+
+
+/* Get the name for a processor state. Returns null on error. */
+
+const char *xtensa_state_name(xtensa_isa isa, xtensa_state st);
+
+
+/*
+ * Get the bit width for a processor state.
+ * Returns XTENSA_UNDEFINED on error.
+ */
+
+int xtensa_state_num_bits(xtensa_isa isa, xtensa_state st);
+
+
+/*
+ * Check if a state is exported from the processor core. Returns 0 if
+ * the condition is false, 1 if the condition is true, and
+ * XTENSA_UNDEFINED on error.
+ */
+
+int xtensa_state_is_exported(xtensa_isa isa, xtensa_state st);
+
+
+/*
+ * Check for a "shared_or" state. Returns 0 if the condition is false,
+ * 1 if the condition is true, and XTENSA_UNDEFINED on error.
+ */
+
+int xtensa_state_is_shared_or(xtensa_isa isa, xtensa_state st);
+
+
+
+/* Sysregs ("special registers" and "user registers"). */
+
+/*
+ * Look up a register by its number and whether it is a "user register"
+ * or a "special register". Returns XTENSA_UNDEFINED if the sysreg does
+ * not exist.
+ */
+
+xtensa_sysreg xtensa_sysreg_lookup(xtensa_isa isa, int num, int is_user);
+
+
+/*
+ * Check if there exists a sysreg with a given name.
+ * If not, this function returns XTENSA_UNDEFINED.
+ */
+
+xtensa_sysreg xtensa_sysreg_lookup_name(xtensa_isa isa, const char *name);
+
+
+/* Get the name of a sysreg. Returns null on error. */
+
+const char *xtensa_sysreg_name(xtensa_isa isa, xtensa_sysreg sysreg);
+
+
+/* Get the register number. Returns XTENSA_UNDEFINED on error. */
+
+int xtensa_sysreg_number(xtensa_isa isa, xtensa_sysreg sysreg);
+
+
+/*
+ * Check if a sysreg is a "special register" or a "user register".
+ * Returns 0 for special registers, 1 for user registers and
+ * XTENSA_UNDEFINED on error.
+ */
+
+int xtensa_sysreg_is_user(xtensa_isa isa, xtensa_sysreg sysreg);
+
+
+
+/* Interfaces. */
+
+/*
+ * Find an interface by name. The return value is XTENSA_UNDEFINED if
+ * the specified interface is not found.
+ */
+
+xtensa_interface xtensa_interface_lookup(xtensa_isa isa, const char *ifname);
+
+
+/* Get the name of an interface. Returns null on error. */
+
+const char *xtensa_interface_name(xtensa_isa isa, xtensa_interface intf);
+
+
+/*
+ * Get the bit width for an interface.
+ * Returns XTENSA_UNDEFINED on error.
+ */
+
+int xtensa_interface_num_bits(xtensa_isa isa, xtensa_interface intf);
+
+
+/*
+ * Check if an interface is an input ('i') or output ('o') with respect
+ * to the Xtensa processor core. Returns 0 on error.
+ */
+
+char xtensa_interface_inout(xtensa_isa isa, xtensa_interface intf);
+
+
+/*
+ * Check if accessing an interface has potential side effects.
+ * Currently "data" interfaces have side effects and "control"
+ * interfaces do not. Returns 1 if there are side effects, 0 if not,
+ * and XTENSA_UNDEFINED on error.
+ */
+
+int xtensa_interface_has_side_effect(xtensa_isa isa, xtensa_interface intf);
+
+
+/*
+ * Some interfaces may be related such that accessing one interface
+ * has side effects on a set of related interfaces. The interfaces
+ * are partitioned into equivalence classes of related interfaces, and
+ * each class is assigned a unique identifier number. This function
+ * returns the class identifier for an interface, or XTENSA_UNDEFINED
+ * on error. These identifiers can be compared to determine if two
+ * interfaces are related; the specific values of the identifiers have
+ * no particular meaning otherwise.
+ */
+
+int xtensa_interface_class_id(xtensa_isa isa, xtensa_interface intf);
+
+
+/* Functional Units. */
+
+/*
+ * Find a functional unit by name. The return value is XTENSA_UNDEFINED if
+ * the specified unit is not found.
+ */
+
+xtensa_funcUnit xtensa_funcUnit_lookup(xtensa_isa isa, const char *fname);
+
+
+/* Get the name of a functional unit. Returns null on error. */
+
+const char *xtensa_funcUnit_name(xtensa_isa isa, xtensa_funcUnit fun);
+
+
+/*
+ * Functional units may be replicated. See how many instances of a
+ * particular function unit exist. Returns XTENSA_UNDEFINED on error.
+ */
+
+int xtensa_funcUnit_num_copies(xtensa_isa isa, xtensa_funcUnit fun);
+
+
+#ifdef __cplusplus
+}
+#endif
+#endif /* XTENSA_LIBISA_H */
diff --git a/target/xtensa/Makefile.objs b/target/xtensa/Makefile.objs
index 481de9197385..042970668023 100644
--- a/target/xtensa/Makefile.objs
+++ b/target/xtensa/Makefile.objs
@@ -3,5 +3,6 @@ obj-y += core-dc232b.o
 obj-y += core-dc233c.o
 obj-y += core-fsf.o
 obj-$(CONFIG_SOFTMMU) += monitor.o
+obj-y += xtensa-isa.o
 obj-y += translate.o op_helper.o helper.o cpu.o
 obj-y += gdbstub.o
diff --git a/target/xtensa/xtensa-isa-internal.h b/target/xtensa/xtensa-isa-internal.h
new file mode 100644
index 000000000000..c29295ff9687
--- /dev/null
+++ b/target/xtensa/xtensa-isa-internal.h
@@ -0,0 +1,231 @@
+/* Internal definitions for the Xtensa ISA library.
+ *
+ * Copyright (c) 2004-2011 Tensilica Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining
+ * a copy of this software and associated documentation files (the
+ * "Software"), to deal in the Software without restriction, including
+ * without limitation the rights to use, copy, modify, merge, publish,
+ * distribute, sublicense, and/or sell copies of the Software, and to
+ * permit persons to whom the Software is furnished to do so, subject to
+ * the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included
+ * in all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+ * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
+ * IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
+ * CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
+ * TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
+ * SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+#ifndef XTENSA_ISA_INTERNAL_H
+#define XTENSA_ISA_INTERNAL_H
+
+#ifndef uint32
+#define uint32 uint32_t
+#endif
+
+/* Flags. */
+
+#define XTENSA_OPERAND_IS_REGISTER      0x00000001
+#define XTENSA_OPERAND_IS_PCRELATIVE    0x00000002
+#define XTENSA_OPERAND_IS_INVISIBLE     0x00000004
+#define XTENSA_OPERAND_IS_UNKNOWN       0x00000008
+
+#define XTENSA_OPCODE_IS_BRANCH         0x00000001
+#define XTENSA_OPCODE_IS_JUMP           0x00000002
+#define XTENSA_OPCODE_IS_LOOP           0x00000004
+#define XTENSA_OPCODE_IS_CALL           0x00000008
+
+#define XTENSA_STATE_IS_EXPORTED        0x00000001
+#define XTENSA_STATE_IS_SHARED_OR       0x00000002
+
+#define XTENSA_INTERFACE_HAS_SIDE_EFFECT 0x00000001
+
+/* Function pointer typedefs */
+typedef void (*xtensa_format_encode_fn)(xtensa_insnbuf);
+typedef void (*xtensa_get_slot_fn)(const xtensa_insnbuf, xtensa_insnbuf);
+typedef void (*xtensa_set_slot_fn)(xtensa_insnbuf, const xtensa_insnbuf);
+typedef int (*xtensa_opcode_decode_fn)(const xtensa_insnbuf);
+typedef uint32_t (*xtensa_get_field_fn)(const xtensa_insnbuf);
+typedef void (*xtensa_set_field_fn)(xtensa_insnbuf, uint32_t);
+typedef int (*xtensa_immed_decode_fn)(uint32_t *);
+typedef int (*xtensa_immed_encode_fn)(uint32_t *);
+typedef int (*xtensa_do_reloc_fn)(uint32_t *, uint32_t);
+typedef int (*xtensa_undo_reloc_fn)(uint32_t *, uint32_t);
+typedef void (*xtensa_opcode_encode_fn)(xtensa_insnbuf);
+typedef int (*xtensa_format_decode_fn)(const xtensa_insnbuf);
+typedef int (*xtensa_length_decode_fn)(const unsigned char *);
+
+typedef struct xtensa_format_internal_struct {
+    const char *name;           /* Instruction format name. */
+    int length;                 /* Instruction length in bytes. */
+    xtensa_format_encode_fn encode_fn;
+    int num_slots;
+    int *slot_id;               /* Array[num_slots] of slot IDs. */
+} xtensa_format_internal;
+
+typedef struct xtensa_slot_internal_struct {
+    const char *name;                   /* Not necessarily unique. */
+    const char *format;
+    int position;
+    xtensa_get_slot_fn get_fn;
+    xtensa_set_slot_fn set_fn;
+    xtensa_get_field_fn *get_field_fns; /* Array[field_id]. */
+    xtensa_set_field_fn *set_field_fns; /* Array[field_id]. */
+    xtensa_opcode_decode_fn opcode_decode_fn;
+    const char *nop_name;
+} xtensa_slot_internal;
+
+typedef struct xtensa_operand_internal_struct {
+    const char *name;
+    int field_id;
+    xtensa_regfile regfile;             /* Register file. */
+    int num_regs;                       /* Usually 1; 2 for reg pairs, etc. */
+    uint32_t flags;                     /* See XTENSA_OPERAND_* flags. */
+    xtensa_immed_encode_fn encode;      /* Encode the operand value. */
+    xtensa_immed_decode_fn decode;      /* Decode the value from the field. */
+    xtensa_do_reloc_fn do_reloc;        /* Perform a PC-relative reloc. */
+    xtensa_undo_reloc_fn undo_reloc;    /* Undo a PC-relative relocation. */
+} xtensa_operand_internal;
+
+typedef struct xtensa_arg_internal_struct {
+    union {
+        int operand_id;         /* For normal operands. */
+        xtensa_state state;     /* For stateOperands. */
+    } u;
+    char inout;                 /* Direction: 'i', 'o', or 'm'. */
+} xtensa_arg_internal;
+
+typedef struct xtensa_iclass_internal_struct {
+    int num_operands;           /* Size of "operands" array. */
+    xtensa_arg_internal *operands;          /* Array[num_operands]. */
+
+    int num_stateOperands;      /* Size of "stateOperands" array. */
+    xtensa_arg_internal *stateOperands;     /* Array[num_stateOperands]. */
+
+    int num_interfaceOperands;  /* Size of "interfaceOperands". */
+    xtensa_interface *interfaceOperands;    /* Array[num_interfaceOperands]. */
+} xtensa_iclass_internal;
+
+typedef struct xtensa_opcode_internal_struct {
+    const char *name;           /* Opcode mnemonic. */
+    int iclass_id;              /* Iclass for this opcode. */
+    uint32_t flags;             /* See XTENSA_OPCODE_* flags. */
+    xtensa_opcode_encode_fn *encode_fns;    /* Array[slot_id]. */
+    int num_funcUnit_uses;      /* Number of funcUnit_use entries. */
+    xtensa_funcUnit_use *funcUnit_uses;     /* Array[num_funcUnit_uses]. */
+} xtensa_opcode_internal;
+
+typedef struct xtensa_regfile_internal_struct {
+    const char *name;           /* Full name of the regfile. */
+    const char *shortname;      /* Abbreviated name. */
+    xtensa_regfile parent;      /* View parent (or identity). */
+    int num_bits;               /* Width of the registers. */
+    int num_entries;            /* Number of registers. */
+} xtensa_regfile_internal;
+
+typedef struct xtensa_interface_internal_struct {
+    const char *name;           /* Interface name. */
+    int num_bits;               /* Width of the interface. */
+    uint32_t flags;             /* See XTENSA_INTERFACE_* flags. */
+    int class_id;               /* Class of related interfaces. */
+    char inout;                 /* "i" or "o". */
+} xtensa_interface_internal;
+
+typedef struct xtensa_funcUnit_internal_struct {
+    const char *name;           /* Functional unit name. */
+    int num_copies;             /* Number of instances. */
+} xtensa_funcUnit_internal;
+
+typedef struct xtensa_state_internal_struct {
+    const char *name;           /* State name. */
+    int num_bits;               /* Number of state bits. */
+    uint32_t flags;             /* See XTENSA_STATE_* flags. */
+} xtensa_state_internal;
+
+typedef struct xtensa_sysreg_internal_struct {
+    const char *name;           /* Register name. */
+    int number;                 /* Register number. */
+    int is_user;                /* Non-zero if a "user register". */
+} xtensa_sysreg_internal;
+
+typedef struct xtensa_lookup_entry_struct {
+    const char *key;
+    union {
+        xtensa_opcode opcode;   /* Internal opcode number. */
+        xtensa_sysreg sysreg;   /* Internal sysreg number. */
+        xtensa_state state;     /* Internal state number. */
+        xtensa_interface intf;  /* Internal interface number. */
+        xtensa_funcUnit fun;    /* Internal funcUnit number. */
+    } u;
+} xtensa_lookup_entry;
+
+typedef struct xtensa_isa_internal_struct {
+    int is_big_endian;          /* Endianness. */
+    int insn_size;              /* Maximum length in bytes. */
+    int insnbuf_size;           /* Number of insnbuf_words. */
+
+    int num_formats;
+    xtensa_format_internal *formats;
+    xtensa_format_decode_fn format_decode_fn;
+    xtensa_length_decode_fn length_decode_fn;
+
+    int num_slots;
+    xtensa_slot_internal *slots;
+
+    int num_fields;
+
+    int num_operands;
+    xtensa_operand_internal *operands;
+
+    int num_iclasses;
+    xtensa_iclass_internal *iclasses;
+
+    int num_opcodes;
+    xtensa_opcode_internal *opcodes;
+    xtensa_lookup_entry *opname_lookup_table;
+
+    int num_regfiles;
+    xtensa_regfile_internal *regfiles;
+
+    int num_states;
+    xtensa_state_internal *states;
+    xtensa_lookup_entry *state_lookup_table;
+
+    int num_sysregs;
+    xtensa_sysreg_internal *sysregs;
+    xtensa_lookup_entry *sysreg_lookup_table;
+
+    /*
+     * The current Xtensa ISA only supports 256 of each kind of sysreg so
+     * we can get away with implementing lookups with tables indexed by
+     * the register numbers. If we ever allow larger sysreg numbers, this
+     * may have to be reimplemented. The first entry in the following
+     * arrays corresponds to "special" registers and the second to "user"
+     * registers.
+     */
+    int max_sysreg_num[2];
+    xtensa_sysreg *sysreg_table[2];
+
+    int num_interfaces;
+    xtensa_interface_internal *interfaces;
+    xtensa_lookup_entry *interface_lookup_table;
+
+    int num_funcUnits;
+    xtensa_funcUnit_internal *funcUnits;
+    xtensa_lookup_entry *funcUnit_lookup_table;
+
+    int num_stages;             /* Number of pipe stages. */
+} xtensa_isa_internal;
+
+int xtensa_isa_name_compare(const void *, const void *);
+
+extern xtensa_isa_status xtisa_errno;
+extern char xtisa_error_msg[];
+
+#endif /* !XTENSA_ISA_INTERNAL_H */
diff --git a/target/xtensa/xtensa-isa.c b/target/xtensa/xtensa-isa.c
new file mode 100644
index 000000000000..e0076a694fe9
--- /dev/null
+++ b/target/xtensa/xtensa-isa.c
@@ -0,0 +1,1745 @@
+/* Configurable Xtensa ISA support.
+ *
+ * Copyright (c) 2001-2011 Tensilica Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining
+ * a copy of this software and associated documentation files (the
+ * "Software"), to deal in the Software without restriction, including
+ * without limitation the rights to use, copy, modify, merge, publish,
+ * distribute, sublicense, and/or sell copies of the Software, and to
+ * permit persons to whom the Software is furnished to do so, subject to
+ * the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included
+ * in all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+ * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
+ * IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
+ * CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
+ * TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
+ * SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include "xtensa-isa.h"
+#include "xtensa-isa-internal.h"
+
+xtensa_isa_status xtisa_errno;
+char xtisa_error_msg[1024];
+
+
+xtensa_isa_status xtensa_isa_errno(xtensa_isa isa __attribute__ ((unused)))
+{
+    return xtisa_errno;
+}
+
+
+char *xtensa_isa_error_msg(xtensa_isa isa __attribute__ ((unused)))
+{
+    return xtisa_error_msg;
+}
+
+
+#define CHECK_ALLOC(MEM, ERRVAL) \
+    do { \
+        if ((MEM) == 0) { \
+            xtisa_errno = xtensa_isa_out_of_memory; \
+            strcpy(xtisa_error_msg, "out of memory"); \
+            return ERRVAL; \
+        } \
+    } while (0)
+
+#define CHECK_ALLOC_FOR_INIT(MEM, ERRVAL, ERRNO_P, ERROR_MSG_P) \
+    do { \
+        if ((MEM) == 0) { \
+            xtisa_errno = xtensa_isa_out_of_memory; \
+            strcpy(xtisa_error_msg, "out of memory"); \
+            if (ERRNO_P) { \
+                *(ERRNO_P) = xtisa_errno; \
+            } \
+            if (ERROR_MSG_P) { \
+                *(ERROR_MSG_P) = xtisa_error_msg; \
+            } \
+            return ERRVAL; \
+        } \
+    } while (0)
+
+
+/* Instruction buffers. */
+
+int xtensa_insnbuf_size(xtensa_isa isa)
+{
+    xtensa_isa_internal *intisa = (xtensa_isa_internal *)isa;
+    return intisa->insnbuf_size;
+}
+
+
+xtensa_insnbuf xtensa_insnbuf_alloc(xtensa_isa isa)
+{
+    xtensa_insnbuf result = (xtensa_insnbuf)
+        malloc(xtensa_insnbuf_size(isa) * sizeof(xtensa_insnbuf_word));
+
+    CHECK_ALLOC(result, 0);
+    return result;
+}
+
+
+void xtensa_insnbuf_free(xtensa_isa isa __attribute__ ((unused)),
+                         xtensa_insnbuf buf)
+{
+    free(buf);
+}
+
+
+/*
+ * Given <byte_index>, the index of a byte in a xtensa_insnbuf, our
+ * internal representation of a xtensa instruction word, return the index of
+ * its word and the bit index of its low order byte in the xtensa_insnbuf.
+ */
+
+static inline int byte_to_word_index(int byte_index)
+{
+    return byte_index / sizeof(xtensa_insnbuf_word);
+}
+
+
+static inline int byte_to_bit_index(int byte_index)
+{
+    return (byte_index & 0x3) * 8;
+}
+
+
+/*
+ * Copy an instruction in the 32-bit words pointed at by "insn" to
+ * characters pointed at by "cp". This is more complicated than you
+ * might think because we want 16-bit instructions in bytes 2 & 3 for
+ * big-endian configurations. This function allows us to specify
+ * which byte in "insn" to start with and which way to increment,
+ * allowing trivial implementation for both big- and little-endian
+ * configurations....and it seems to make pretty good code for
+ * both.
+ */
+
+int xtensa_insnbuf_to_chars(xtensa_isa isa,
+                            const xtensa_insnbuf insn,
+                            unsigned char *cp,
+                            int num_chars)
+{
+    xtensa_isa_internal *intisa = (xtensa_isa_internal *)isa;
+    int insn_size = xtensa_isa_maxlength(isa);
+    int fence_post, start, increment, i, byte_count;
+    xtensa_format fmt;
+
+    if (num_chars == 0) {
+        num_chars = insn_size;
+    }
+
+    if (intisa->is_big_endian) {
+        start = insn_size - 1;
+        increment = -1;
+    } else {
+        start = 0;
+        increment = 1;
+    }
+
+    /*
+     * Find the instruction format. Do nothing if the buffer does not contain
+     * a valid instruction since we need to know how many bytes to copy.
+     */
+    fmt = xtensa_format_decode(isa, insn);
+    if (fmt == XTENSA_UNDEFINED) {
+        return XTENSA_UNDEFINED;
+    }
+
+    byte_count = xtensa_format_length(isa, fmt);
+    if (byte_count == XTENSA_UNDEFINED) {
+        return XTENSA_UNDEFINED;
+    }
+
+    if (byte_count > num_chars) {
+        xtisa_errno = xtensa_isa_buffer_overflow;
+        strcpy(xtisa_error_msg, "output buffer too small for instruction");
+        return XTENSA_UNDEFINED;
+    }
+
+    fence_post = start + (byte_count * increment);
+
+    for (i = start; i != fence_post; i += increment, ++cp) {
+        int word_inx = byte_to_word_index(i);
+        int bit_inx = byte_to_bit_index(i);
+
+        *cp = (insn[word_inx] >> bit_inx) & 0xff;
+    }
+
+    return byte_count;
+}
+
+
+/*
+ * Inward conversion from byte stream to xtensa_insnbuf. See
+ * xtensa_insnbuf_to_chars for a discussion of why this is complicated
+ * by endianness.
+ */
+
+void xtensa_insnbuf_from_chars(xtensa_isa isa,
+                               xtensa_insnbuf insn,
+                               const unsigned char *cp,
+                               int num_chars)
+{
+    xtensa_isa_internal *intisa = (xtensa_isa_internal *)isa;
+    int max_size, insn_size, fence_post, start, increment, i;
+
+    max_size = xtensa_isa_maxlength(isa);
+
+    /* Decode the instruction length so we know how many bytes to read. */
+    insn_size = (intisa->length_decode_fn)(cp);
+    if (insn_size == XTENSA_UNDEFINED) {
+        /*
+         * This should never happen when the byte stream contains a
+         * valid instruction. Just read the maximum number of bytes....
+         */
+        insn_size = max_size;
+    }
+
+    if (num_chars == 0 || num_chars > insn_size) {
+        num_chars = insn_size;
+    }
+
+    if (intisa->is_big_endian) {
+        start = max_size - 1;
+        increment = -1;
+    } else {
+        start = 0;
+        increment = 1;
+    }
+
+    fence_post = start + (num_chars * increment);
+    memset(insn, 0, xtensa_insnbuf_size(isa) * sizeof(xtensa_insnbuf_word));
+
+    for (i = start; i != fence_post; i += increment, ++cp) {
+        int word_inx = byte_to_word_index(i);
+        int bit_inx = byte_to_bit_index(i);
+
+        insn[word_inx] |= (*cp & 0xff) << bit_inx;
+    }
+}
+
+
+/* ISA information. */
+
+xtensa_isa xtensa_isa_init(void *xtensa_modules, xtensa_isa_status *errno_p,
+                           char **error_msg_p)
+{
+    xtensa_isa_internal *isa = xtensa_modules;
+    int n, is_user;
+
+    /* Set up the opcode name lookup table. */
+    isa->opname_lookup_table =
+        malloc(isa->num_opcodes * sizeof(xtensa_lookup_entry));
+    CHECK_ALLOC_FOR_INIT(isa->opname_lookup_table, NULL, errno_p, error_msg_p);
+    for (n = 0; n < isa->num_opcodes; n++) {
+        isa->opname_lookup_table[n].key = isa->opcodes[n].name;
+        isa->opname_lookup_table[n].u.opcode = n;
+    }
+    qsort(isa->opname_lookup_table, isa->num_opcodes,
+          sizeof(xtensa_lookup_entry), xtensa_isa_name_compare);
+
+    /* Set up the state name lookup table. */
+    isa->state_lookup_table =
+        malloc(isa->num_states * sizeof(xtensa_lookup_entry));
+    CHECK_ALLOC_FOR_INIT(isa->state_lookup_table, NULL, errno_p, error_msg_p);
+    for (n = 0; n < isa->num_states; n++) {
+        isa->state_lookup_table[n].key = isa->states[n].name;
+        isa->state_lookup_table[n].u.state = n;
+    }
+    qsort(isa->state_lookup_table, isa->num_states,
+          sizeof(xtensa_lookup_entry), xtensa_isa_name_compare);
+
+    /* Set up the sysreg name lookup table. */
+    isa->sysreg_lookup_table =
+        malloc(isa->num_sysregs * sizeof(xtensa_lookup_entry));
+    CHECK_ALLOC_FOR_INIT(isa->sysreg_lookup_table, NULL, errno_p, error_msg_p);
+    for (n = 0; n < isa->num_sysregs; n++) {
+        isa->sysreg_lookup_table[n].key = isa->sysregs[n].name;
+        isa->sysreg_lookup_table[n].u.sysreg = n;
+    }
+    qsort(isa->sysreg_lookup_table, isa->num_sysregs,
+          sizeof(xtensa_lookup_entry), xtensa_isa_name_compare);
+
+    /* Set up the user & system sysreg number tables. */
+    for (is_user = 0; is_user < 2; is_user++) {
+        isa->sysreg_table[is_user] =
+            malloc((isa->max_sysreg_num[is_user] + 1) * sizeof(xtensa_sysreg));
+        CHECK_ALLOC_FOR_INIT(isa->sysreg_table[is_user], NULL,
+                             errno_p, error_msg_p);
+
+        for (n = 0; n <= isa->max_sysreg_num[is_user]; n++) {
+            isa->sysreg_table[is_user][n] = XTENSA_UNDEFINED;
+        }
+    }
+    for (n = 0; n < isa->num_sysregs; n++) {
+        xtensa_sysreg_internal *sreg = &isa->sysregs[n];
+        is_user = sreg->is_user;
+
+        if (sreg->number >= 0) {
+            isa->sysreg_table[is_user][sreg->number] = n;
+        }
+    }
+
+    /* Set up the interface lookup table. */
+    isa->interface_lookup_table =
+        malloc(isa->num_interfaces * sizeof(xtensa_lookup_entry));
+    CHECK_ALLOC_FOR_INIT(isa->interface_lookup_table, NULL, errno_p,
+                         error_msg_p);
+    for (n = 0; n < isa->num_interfaces; n++) {
+        isa->interface_lookup_table[n].key = isa->interfaces[n].name;
+        isa->interface_lookup_table[n].u.intf = n;
+    }
+    qsort(isa->interface_lookup_table, isa->num_interfaces,
+          sizeof(xtensa_lookup_entry), xtensa_isa_name_compare);
+
+    /* Set up the funcUnit lookup table. */
+    isa->funcUnit_lookup_table =
+        malloc(isa->num_funcUnits * sizeof(xtensa_lookup_entry));
+    CHECK_ALLOC_FOR_INIT(isa->funcUnit_lookup_table, NULL, errno_p,
+                         error_msg_p);
+    for (n = 0; n < isa->num_funcUnits; n++) {
+        isa->funcUnit_lookup_table[n].key = isa->funcUnits[n].name;
+        isa->funcUnit_lookup_table[n].u.fun = n;
+    }
+    qsort(isa->funcUnit_lookup_table, isa->num_funcUnits,
+          sizeof(xtensa_lookup_entry), xtensa_isa_name_compare);
+
+    isa->insnbuf_size = ((isa->insn_size + sizeof(xtensa_insnbuf_word) - 1) /
+                         sizeof(xtensa_insnbuf_word));
+    isa->num_stages = XTENSA_UNDEFINED;
+
+    return (xtensa_isa)isa;
+}
+
+
+void xtensa_isa_free(xtensa_isa isa)
+{
+    xtensa_isa_internal *intisa = (xtensa_isa_internal *)isa;
+    int n;
+
+    /*
+     * With this version of the code, the xtensa_isa structure is not
+     * dynamically allocated, so this function is not essential. Free
+     * the memory allocated by xtensa_isa_init and restore the xtensa_isa
+     * structure to its initial state.
+     */
+
+    if (intisa->opname_lookup_table) {
+        free(intisa->opname_lookup_table);
+        intisa->opname_lookup_table = 0;
+    }
+
+    if (intisa->state_lookup_table) {
+        free(intisa->state_lookup_table);
+        intisa->state_lookup_table = 0;
+    }
+
+    if (intisa->sysreg_lookup_table) {
+        free(intisa->sysreg_lookup_table);
+        intisa->sysreg_lookup_table = 0;
+    }
+    for (n = 0; n < 2; n++) {
+        if (intisa->sysreg_table[n]) {
+            free(intisa->sysreg_table[n]);
+            intisa->sysreg_table[n] = 0;
+        }
+    }
+
+    if (intisa->interface_lookup_table) {
+        free(intisa->interface_lookup_table);
+        intisa->interface_lookup_table = 0;
+    }
+
+    if (intisa->funcUnit_lookup_table) {
+        free(intisa->funcUnit_lookup_table);
+        intisa->funcUnit_lookup_table = 0;
+    }
+}
+
+
+int xtensa_isa_name_compare(const void *v1, const void *v2)
+{
+    xtensa_lookup_entry *e1 = (xtensa_lookup_entry *)v1;
+    xtensa_lookup_entry *e2 = (xtensa_lookup_entry *)v2;
+
+    return strcasecmp(e1->key, e2->key);
+}
+
+
+int xtensa_isa_maxlength(xtensa_isa isa)
+{
+    xtensa_isa_internal *intisa = (xtensa_isa_internal *)isa;
+    return intisa->insn_size;
+}
+
+
+int xtensa_isa_length_from_chars(xtensa_isa isa, const unsigned char *cp)
+{
+    xtensa_isa_internal *intisa = (xtensa_isa_internal *)isa;
+    return (intisa->length_decode_fn)(cp);
+}
+
+
+int xtensa_isa_num_pipe_stages(xtensa_isa isa)
+{
+    xtensa_opcode opcode;
+    xtensa_funcUnit_use *use;
+    int num_opcodes, num_uses;
+    int i, stage, max_stage;
+    xtensa_isa_internal *intisa = (xtensa_isa_internal *)isa;
+
+    /* Only compute the value once. */
+    if (intisa->num_stages != XTENSA_UNDEFINED) {
+        return intisa->num_stages;
+    }
+
+    max_stage = -1;
+
+    num_opcodes = xtensa_isa_num_opcodes(isa);
+    for (opcode = 0; opcode < num_opcodes; opcode++) {
+        num_uses = xtensa_opcode_num_funcUnit_uses(isa, opcode);
+        for (i = 0; i < num_uses; i++) {
+            use = xtensa_opcode_funcUnit_use(isa, opcode, i);
+            stage = use->stage;
+            if (stage > max_stage) {
+                max_stage = stage;
+            }
+        }
+    }
+
+    intisa->num_stages = max_stage + 1;
+    return intisa->num_states;
+}
+
+
+int xtensa_isa_num_formats(xtensa_isa isa)
+{
+    xtensa_isa_internal *intisa = (xtensa_isa_internal *)isa;
+    return intisa->num_formats;
+}
+
+
+int xtensa_isa_num_opcodes(xtensa_isa isa)
+{
+    xtensa_isa_internal *intisa = (xtensa_isa_internal *)isa;
+    return intisa->num_opcodes;
+}
+
+
+int xtensa_isa_num_regfiles(xtensa_isa isa)
+{
+    xtensa_isa_internal *intisa = (xtensa_isa_internal *)isa;
+    return intisa->num_regfiles;
+}
+
+
+int xtensa_isa_num_states(xtensa_isa isa)
+{
+    xtensa_isa_internal *intisa = (xtensa_isa_internal *)isa;
+    return intisa->num_states;
+}
+
+
+int xtensa_isa_num_sysregs(xtensa_isa isa)
+{
+    xtensa_isa_internal *intisa = (xtensa_isa_internal *)isa;
+    return intisa->num_sysregs;
+}
+
+
+int xtensa_isa_num_interfaces(xtensa_isa isa)
+{
+    xtensa_isa_internal *intisa = (xtensa_isa_internal *)isa;
+    return intisa->num_interfaces;
+}
+
+
+int xtensa_isa_num_funcUnits(xtensa_isa isa)
+{
+    xtensa_isa_internal *intisa = (xtensa_isa_internal *)isa;
+    return intisa->num_funcUnits;
+}
+
+
+/* Instruction formats. */
+
+
+#define CHECK_FORMAT(INTISA, FMT, ERRVAL) \
+    do { \
+        if ((FMT) < 0 || (FMT) >= (INTISA)->num_formats) { \
+            xtisa_errno = xtensa_isa_bad_format; \
+            strcpy(xtisa_error_msg, "invalid format specifier"); \
+            return ERRVAL; \
+        } \
+    } while (0)
+
+
+#define CHECK_SLOT(INTISA, FMT, SLOT, ERRVAL) \
+    do { \
+        if ((SLOT) < 0 || (SLOT) >= (INTISA)->formats[FMT].num_slots) { \
+            xtisa_errno = xtensa_isa_bad_slot; \
+            strcpy(xtisa_error_msg, "invalid slot specifier"); \
+            return ERRVAL; \
+        } \
+    } while (0)
+
+
+const char *xtensa_format_name(xtensa_isa isa, xtensa_format fmt)
+{
+    xtensa_isa_internal *intisa = (xtensa_isa_internal *)isa;
+
+    CHECK_FORMAT(intisa, fmt, NULL);
+    return intisa->formats[fmt].name;
+}
+
+
+xtensa_format xtensa_format_lookup(xtensa_isa isa, const char *fmtname)
+{
+    xtensa_isa_internal *intisa = (xtensa_isa_internal *)isa;
+    int fmt;
+
+    if (!fmtname || !*fmtname) {
+        xtisa_errno = xtensa_isa_bad_format;
+        strcpy(xtisa_error_msg, "invalid format name");
+        return XTENSA_UNDEFINED;
+    }
+
+    for (fmt = 0; fmt < intisa->num_formats; fmt++) {
+        if (strcasecmp(fmtname, intisa->formats[fmt].name) == 0) {
+            return fmt;
+        }
+    }
+
+    xtisa_errno = xtensa_isa_bad_format;
+    sprintf(xtisa_error_msg, "format \"%s\" not recognized", fmtname);
+    return XTENSA_UNDEFINED;
+}
+
+
+xtensa_format xtensa_format_decode(xtensa_isa isa, const xtensa_insnbuf insn)
+{
+    xtensa_isa_internal *intisa = (xtensa_isa_internal *)isa;
+    xtensa_format fmt;
+
+    fmt = (intisa->format_decode_fn)(insn);
+    if (fmt != XTENSA_UNDEFINED) {
+        return fmt;
+    }
+
+    xtisa_errno = xtensa_isa_bad_format;
+    strcpy(xtisa_error_msg, "cannot decode instruction format");
+    return XTENSA_UNDEFINED;
+}
+
+
+int xtensa_format_encode(xtensa_isa isa, xtensa_format fmt,
+                         xtensa_insnbuf insn)
+{
+    xtensa_isa_internal *intisa = (xtensa_isa_internal *)isa;
+
+    CHECK_FORMAT(intisa, fmt, -1);
+    (*intisa->formats[fmt].encode_fn)(insn);
+    return 0;
+}
+
+
+int xtensa_format_length(xtensa_isa isa, xtensa_format fmt)
+{
+    xtensa_isa_internal *intisa = (xtensa_isa_internal *)isa;
+
+    CHECK_FORMAT(intisa, fmt, XTENSA_UNDEFINED);
+    return intisa->formats[fmt].length;
+}
+
+
+int xtensa_format_num_slots(xtensa_isa isa, xtensa_format fmt)
+{
+    xtensa_isa_internal *intisa = (xtensa_isa_internal *)isa;
+
+    CHECK_FORMAT(intisa, fmt, XTENSA_UNDEFINED);
+    return intisa->formats[fmt].num_slots;
+}
+
+
+xtensa_opcode xtensa_format_slot_nop_opcode(xtensa_isa isa, xtensa_format fmt,
+                                            int slot)
+{
+    xtensa_isa_internal *intisa = (xtensa_isa_internal *)isa;
+    int slot_id;
+
+    CHECK_FORMAT(intisa, fmt, XTENSA_UNDEFINED);
+    CHECK_SLOT(intisa, fmt, slot, XTENSA_UNDEFINED);
+
+    slot_id = intisa->formats[fmt].slot_id[slot];
+    return xtensa_opcode_lookup(isa, intisa->slots[slot_id].nop_name);
+}
+
+
+int xtensa_format_get_slot(xtensa_isa isa, xtensa_format fmt, int slot,
+                           const xtensa_insnbuf insn, xtensa_insnbuf slotbuf)
+{
+    xtensa_isa_internal *intisa = (xtensa_isa_internal *)isa;
+    int slot_id;
+
+    CHECK_FORMAT(intisa, fmt, -1);
+    CHECK_SLOT(intisa, fmt, slot, -1);
+
+    slot_id = intisa->formats[fmt].slot_id[slot];
+    (*intisa->slots[slot_id].get_fn)(insn, slotbuf);
+    return 0;
+}
+
+
+int xtensa_format_set_slot(xtensa_isa isa, xtensa_format fmt, int slot,
+                           xtensa_insnbuf insn, const xtensa_insnbuf slotbuf)
+{
+    xtensa_isa_internal *intisa = (xtensa_isa_internal *)isa;
+    int slot_id;
+
+    CHECK_FORMAT(intisa, fmt, -1);
+    CHECK_SLOT(intisa, fmt, slot, -1);
+
+    slot_id = intisa->formats[fmt].slot_id[slot];
+    (*intisa->slots[slot_id].set_fn)(insn, slotbuf);
+    return 0;
+}
+
+
+/* Opcode information. */
+
+
+#define CHECK_OPCODE(INTISA, OPC, ERRVAL) \
+    do { \
+        if ((OPC) < 0 || (OPC) >= (INTISA)->num_opcodes) { \
+            xtisa_errno = xtensa_isa_bad_opcode; \
+            strcpy(xtisa_error_msg, "invalid opcode specifier"); \
+            return ERRVAL; \
+        } \
+    } while (0)
+
+
+xtensa_opcode xtensa_opcode_lookup(xtensa_isa isa, const char *opname)
+{
+    xtensa_isa_internal *intisa = (xtensa_isa_internal *)isa;
+    xtensa_lookup_entry entry, *result = 0;
+
+    if (!opname || !*opname) {
+        xtisa_errno = xtensa_isa_bad_opcode;
+        strcpy(xtisa_error_msg, "invalid opcode name");
+        return XTENSA_UNDEFINED;
+    }
+
+    if (intisa->num_opcodes != 0) {
+        entry.key = opname;
+        result = bsearch(&entry, intisa->opname_lookup_table,
+                         intisa->num_opcodes, sizeof(xtensa_lookup_entry),
+                         xtensa_isa_name_compare);
+    }
+
+    if (!result) {
+        xtisa_errno = xtensa_isa_bad_opcode;
+        sprintf(xtisa_error_msg, "opcode \"%s\" not recognized", opname);
+        return XTENSA_UNDEFINED;
+    }
+
+    return result->u.opcode;
+}
+
+
+xtensa_opcode xtensa_opcode_decode(xtensa_isa isa, xtensa_format fmt, int slot,
+                                   const xtensa_insnbuf slotbuf)
+{
+    xtensa_isa_internal *intisa = (xtensa_isa_internal *)isa;
+    int slot_id;
+    xtensa_opcode opc;
+
+    CHECK_FORMAT(intisa, fmt, XTENSA_UNDEFINED);
+    CHECK_SLOT(intisa, fmt, slot, XTENSA_UNDEFINED);
+
+    slot_id = intisa->formats[fmt].slot_id[slot];
+
+    opc = (intisa->slots[slot_id].opcode_decode_fn) (slotbuf);
+    if (opc != XTENSA_UNDEFINED) {
+        return opc;
+    }
+
+    xtisa_errno = xtensa_isa_bad_opcode;
+    strcpy(xtisa_error_msg, "cannot decode opcode");
+    return XTENSA_UNDEFINED;
+}
+
+
+int xtensa_opcode_encode(xtensa_isa isa, xtensa_format fmt, int slot,
+                         xtensa_insnbuf slotbuf, xtensa_opcode opc)
+{
+    xtensa_isa_internal *intisa = (xtensa_isa_internal *)isa;
+    int slot_id;
+    xtensa_opcode_encode_fn encode_fn;
+
+    CHECK_FORMAT(intisa, fmt, -1);
+    CHECK_SLOT(intisa, fmt, slot, -1);
+    CHECK_OPCODE(intisa, opc, -1);
+
+    slot_id = intisa->formats[fmt].slot_id[slot];
+    encode_fn = intisa->opcodes[opc].encode_fns[slot_id];
+    if (!encode_fn) {
+        xtisa_errno = xtensa_isa_wrong_slot;
+        sprintf(xtisa_error_msg,
+                "opcode \"%s\" is not allowed in slot %d of format \"%s\"",
+                intisa->opcodes[opc].name, slot, intisa->formats[fmt].name);
+        return -1;
+    }
+    (*encode_fn)(slotbuf);
+    return 0;
+}
+
+
+const char *xtensa_opcode_name(xtensa_isa isa, xtensa_opcode opc)
+{
+    xtensa_isa_internal *intisa = (xtensa_isa_internal *)isa;
+
+    CHECK_OPCODE(intisa, opc, NULL);
+    return intisa->opcodes[opc].name;
+}
+
+
+int xtensa_opcode_is_branch(xtensa_isa isa, xtensa_opcode opc)
+{
+    xtensa_isa_internal *intisa = (xtensa_isa_internal *)isa;
+
+    CHECK_OPCODE(intisa, opc, XTENSA_UNDEFINED);
+    if ((intisa->opcodes[opc].flags & XTENSA_OPCODE_IS_BRANCH) != 0) {
+        return 1;
+    }
+    return 0;
+}
+
+
+int xtensa_opcode_is_jump(xtensa_isa isa, xtensa_opcode opc)
+{
+    xtensa_isa_internal *intisa = (xtensa_isa_internal *)isa;
+
+    CHECK_OPCODE(intisa, opc, XTENSA_UNDEFINED);
+    if ((intisa->opcodes[opc].flags & XTENSA_OPCODE_IS_JUMP) != 0) {
+        return 1;
+    }
+    return 0;
+}
+
+
+int xtensa_opcode_is_loop(xtensa_isa isa, xtensa_opcode opc)
+{
+    xtensa_isa_internal *intisa = (xtensa_isa_internal *)isa;
+
+    CHECK_OPCODE(intisa, opc, XTENSA_UNDEFINED);
+    if ((intisa->opcodes[opc].flags & XTENSA_OPCODE_IS_LOOP) != 0) {
+        return 1;
+    }
+    return 0;
+}
+
+
+int xtensa_opcode_is_call(xtensa_isa isa, xtensa_opcode opc)
+{
+    xtensa_isa_internal *intisa = (xtensa_isa_internal *)isa;
+
+    CHECK_OPCODE(intisa, opc, XTENSA_UNDEFINED);
+    if ((intisa->opcodes[opc].flags & XTENSA_OPCODE_IS_CALL) != 0) {
+        return 1;
+    }
+    return 0;
+}
+
+
+int xtensa_opcode_num_operands(xtensa_isa isa, xtensa_opcode opc)
+{
+    xtensa_isa_internal *intisa = (xtensa_isa_internal *)isa;
+    int iclass_id;
+
+    CHECK_OPCODE(intisa, opc, XTENSA_UNDEFINED);
+    iclass_id = intisa->opcodes[opc].iclass_id;
+    return intisa->iclasses[iclass_id].num_operands;
+}
+
+
+int xtensa_opcode_num_stateOperands(xtensa_isa isa, xtensa_opcode opc)
+{
+    xtensa_isa_internal *intisa = (xtensa_isa_internal *)isa;
+    int iclass_id;
+
+    CHECK_OPCODE(intisa, opc, XTENSA_UNDEFINED);
+    iclass_id = intisa->opcodes[opc].iclass_id;
+    return intisa->iclasses[iclass_id].num_stateOperands;
+}
+
+
+int xtensa_opcode_num_interfaceOperands(xtensa_isa isa, xtensa_opcode opc)
+{
+    xtensa_isa_internal *intisa = (xtensa_isa_internal *)isa;
+    int iclass_id;
+
+    CHECK_OPCODE(intisa, opc, XTENSA_UNDEFINED);
+    iclass_id = intisa->opcodes[opc].iclass_id;
+    return intisa->iclasses[iclass_id].num_interfaceOperands;
+}
+
+
+int xtensa_opcode_num_funcUnit_uses(xtensa_isa isa, xtensa_opcode opc)
+{
+    xtensa_isa_internal *intisa = (xtensa_isa_internal *)isa;
+
+    CHECK_OPCODE(intisa, opc, XTENSA_UNDEFINED);
+    return intisa->opcodes[opc].num_funcUnit_uses;
+}
+
+
+xtensa_funcUnit_use *xtensa_opcode_funcUnit_use(xtensa_isa isa,
+                                                xtensa_opcode opc, int u)
+{
+    xtensa_isa_internal *intisa = (xtensa_isa_internal *)isa;
+
+    CHECK_OPCODE(intisa, opc, NULL);
+    if (u < 0 || u >= intisa->opcodes[opc].num_funcUnit_uses) {
+        xtisa_errno = xtensa_isa_bad_funcUnit;
+        sprintf(xtisa_error_msg, "invalid functional unit use number (%d); "
+                "opcode \"%s\" has %d", u, intisa->opcodes[opc].name,
+                intisa->opcodes[opc].num_funcUnit_uses);
+        return NULL;
+    }
+    return &intisa->opcodes[opc].funcUnit_uses[u];
+}
+
+
+/* Operand information. */
+
+
+#define CHECK_OPERAND(INTISA, OPC, ICLASS, OPND, ERRVAL) \
+    do { \
+        if ((OPND) < 0 || (OPND) >= (ICLASS)->num_operands) { \
+            xtisa_errno = xtensa_isa_bad_operand; \
+            sprintf(xtisa_error_msg, "invalid operand number (%d); " \
+                    "opcode \"%s\" has %d operands", (OPND), \
+                    (INTISA)->opcodes[(OPC)].name, (ICLASS)->num_operands); \
+            return ERRVAL; \
+        } \
+    } while (0)
+
+
+static xtensa_operand_internal *get_operand(xtensa_isa_internal *intisa,
+                                            xtensa_opcode opc, int opnd)
+{
+    xtensa_iclass_internal *iclass;
+    int iclass_id, operand_id;
+
+    CHECK_OPCODE(intisa, opc, NULL);
+    iclass_id = intisa->opcodes[opc].iclass_id;
+    iclass = &intisa->iclasses[iclass_id];
+    CHECK_OPERAND(intisa, opc, iclass, opnd, NULL);
+    operand_id = iclass->operands[opnd].u.operand_id;
+    return &intisa->operands[operand_id];
+}
+
+
+const char *xtensa_operand_name(xtensa_isa isa, xtensa_opcode opc, int opnd)
+{
+    xtensa_isa_internal *intisa = (xtensa_isa_internal *)isa;
+    xtensa_operand_internal *intop;
+
+    intop = get_operand(intisa, opc, opnd);
+    if (!intop) {
+        return NULL;
+    }
+    return intop->name;
+}
+
+
+int xtensa_operand_is_visible(xtensa_isa isa, xtensa_opcode opc, int opnd)
+{
+    xtensa_isa_internal *intisa = (xtensa_isa_internal *)isa;
+    xtensa_iclass_internal *iclass;
+    int iclass_id, operand_id;
+    xtensa_operand_internal *intop;
+
+    CHECK_OPCODE(intisa, opc, XTENSA_UNDEFINED);
+    iclass_id = intisa->opcodes[opc].iclass_id;
+    iclass = &intisa->iclasses[iclass_id];
+    CHECK_OPERAND(intisa, opc, iclass, opnd, XTENSA_UNDEFINED);
+
+    /* Special case for "sout" operands. */
+    if (iclass->operands[opnd].inout == 's') {
+        return 0;
+    }
+
+    operand_id = iclass->operands[opnd].u.operand_id;
+    intop = &intisa->operands[operand_id];
+
+    if ((intop->flags & XTENSA_OPERAND_IS_INVISIBLE) == 0) {
+        return 1;
+    }
+    return 0;
+}
+
+
+char xtensa_operand_inout(xtensa_isa isa, xtensa_opcode opc, int opnd)
+{
+    xtensa_isa_internal *intisa = (xtensa_isa_internal *)isa;
+    xtensa_iclass_internal *iclass;
+    int iclass_id;
+    char inout;
+
+    CHECK_OPCODE(intisa, opc, 0);
+    iclass_id = intisa->opcodes[opc].iclass_id;
+    iclass = &intisa->iclasses[iclass_id];
+    CHECK_OPERAND(intisa, opc, iclass, opnd, 0);
+    inout = iclass->operands[opnd].inout;
+
+    /* Special case for "sout" and "_sin" operands. */
+    if (inout == 's') {
+        return 'o';
+    }
+    if (inout == 't') {
+        return 'i';
+    }
+    return inout;
+}
+
+
+int xtensa_operand_get_field(xtensa_isa isa, xtensa_opcode opc, int opnd,
+                             xtensa_format fmt, int slot,
+                             const xtensa_insnbuf slotbuf, uint32_t *valp)
+{
+    xtensa_isa_internal *intisa = (xtensa_isa_internal *)isa;
+    xtensa_operand_internal *intop;
+    int slot_id;
+    xtensa_get_field_fn get_fn;
+
+    intop = get_operand(intisa, opc, opnd);
+    if (!intop) {
+        return -1;
+    }
+
+    CHECK_FORMAT(intisa, fmt, -1);
+    CHECK_SLOT(intisa, fmt, slot, -1);
+
+    slot_id = intisa->formats[fmt].slot_id[slot];
+    if (intop->field_id == XTENSA_UNDEFINED) {
+        xtisa_errno = xtensa_isa_no_field;
+        strcpy(xtisa_error_msg, "implicit operand has no field");
+        return -1;
+    }
+    get_fn = intisa->slots[slot_id].get_field_fns[intop->field_id];
+    if (!get_fn) {
+        xtisa_errno = xtensa_isa_wrong_slot;
+        sprintf(xtisa_error_msg,
+                "operand \"%s\" does not exist in slot %d of format \"%s\"",
+                intop->name, slot, intisa->formats[fmt].name);
+        return -1;
+    }
+    *valp = (*get_fn)(slotbuf);
+    return 0;
+}
+
+
+int xtensa_operand_set_field(xtensa_isa isa, xtensa_opcode opc, int opnd,
+                             xtensa_format fmt, int slot,
+                             xtensa_insnbuf slotbuf, uint32_t val)
+{
+    xtensa_isa_internal *intisa = (xtensa_isa_internal *)isa;
+    xtensa_operand_internal *intop;
+    int slot_id;
+    xtensa_set_field_fn set_fn;
+
+    intop = get_operand(intisa, opc, opnd);
+    if (!intop) {
+        return -1;
+    }
+
+    CHECK_FORMAT(intisa, fmt, -1);
+    CHECK_SLOT(intisa, fmt, slot, -1);
+
+    slot_id = intisa->formats[fmt].slot_id[slot];
+    if (intop->field_id == XTENSA_UNDEFINED) {
+        xtisa_errno = xtensa_isa_no_field;
+        strcpy(xtisa_error_msg, "implicit operand has no field");
+        return -1;
+    }
+    set_fn = intisa->slots[slot_id].set_field_fns[intop->field_id];
+    if (!set_fn) {
+        xtisa_errno = xtensa_isa_wrong_slot;
+        sprintf(xtisa_error_msg,
+                "operand \"%s\" does not exist in slot %d of format \"%s\"",
+                intop->name, slot, intisa->formats[fmt].name);
+        return -1;
+    }
+    (*set_fn)(slotbuf, val);
+    return 0;
+}
+
+
+int xtensa_operand_encode(xtensa_isa isa, xtensa_opcode opc, int opnd,
+                          uint32_t *valp)
+{
+    xtensa_isa_internal *intisa = (xtensa_isa_internal *)isa;
+    xtensa_operand_internal *intop;
+    uint32_t test_val, orig_val;
+
+    intop = get_operand(intisa, opc, opnd);
+    if (!intop) {
+        return -1;
+    }
+
+    if (!intop->encode) {
+        /*
+         * This is a default operand for a field. How can we tell if the
+         * value fits in the field?  Write the value into the field,
+         * read it back, and then make sure we get the same value.
+         */
+        static xtensa_insnbuf tmpbuf;
+        int slot_id;
+
+        if (!tmpbuf) {
+            tmpbuf = xtensa_insnbuf_alloc(isa);
+            CHECK_ALLOC(tmpbuf, -1);
+        }
+
+        /*
+         * A default operand is always associated with a field,
+         * but check just to be sure....
+         */
+        if (intop->field_id == XTENSA_UNDEFINED) {
+            xtisa_errno = xtensa_isa_internal_error;
+            strcpy(xtisa_error_msg, "operand has no field");
+            return -1;
+        }
+
+        /* Find some slot that includes the field. */
+        for (slot_id = 0; slot_id < intisa->num_slots; slot_id++) {
+            xtensa_get_field_fn get_fn =
+                intisa->slots[slot_id].get_field_fns[intop->field_id];
+            xtensa_set_field_fn set_fn =
+                intisa->slots[slot_id].set_field_fns[intop->field_id];
+
+            if (get_fn && set_fn) {
+                (*set_fn)(tmpbuf, *valp);
+                return (*get_fn)(tmpbuf) != *valp;
+            }
+        }
+
+        /* Couldn't find any slot containing the field.... */
+        xtisa_errno = xtensa_isa_no_field;
+        strcpy(xtisa_error_msg, "field does not exist in any slot");
+        return -1;
+    }
+
+    /*
+     * Encode the value. In some cases, the encoding function may detect
+     * errors, but most of the time the only way to determine if the value
+     * was successfully encoded is to decode it and check if it matches
+     * the original value.
+     */
+    orig_val = *valp;
+    if ((*intop->encode)(valp) ||
+        (test_val = *valp, (*intop->decode)(&test_val)) ||
+        test_val != orig_val) {
+        xtisa_errno = xtensa_isa_bad_value;
+        sprintf(xtisa_error_msg, "cannot encode operand value 0x%08x", *valp);
+        return -1;
+    }
+
+    return 0;
+}
+
+
+int xtensa_operand_decode(xtensa_isa isa, xtensa_opcode opc, int opnd,
+                          uint32_t *valp)
+{
+    xtensa_isa_internal *intisa = (xtensa_isa_internal *)isa;
+    xtensa_operand_internal *intop;
+
+    intop = get_operand(intisa, opc, opnd);
+    if (!intop) {
+        return -1;
+    }
+
+    /* Use identity function for "default" operands. */
+    if (!intop->decode) {
+        return 0;
+    }
+
+    if ((*intop->decode)(valp)) {
+        xtisa_errno = xtensa_isa_bad_value;
+        sprintf(xtisa_error_msg, "cannot decode operand value 0x%08x", *valp);
+        return -1;
+    }
+    return 0;
+}
+
+
+int xtensa_operand_is_register(xtensa_isa isa, xtensa_opcode opc, int opnd)
+{
+    xtensa_isa_internal *intisa = (xtensa_isa_internal *)isa;
+    xtensa_operand_internal *intop;
+
+    intop = get_operand(intisa, opc, opnd);
+    if (!intop) {
+        return XTENSA_UNDEFINED;
+    }
+
+    if ((intop->flags & XTENSA_OPERAND_IS_REGISTER) != 0) {
+        return 1;
+    }
+    return 0;
+}
+
+
+xtensa_regfile xtensa_operand_regfile(xtensa_isa isa, xtensa_opcode opc,
+                                      int opnd)
+{
+    xtensa_isa_internal *intisa = (xtensa_isa_internal *)isa;
+    xtensa_operand_internal *intop;
+
+    intop = get_operand(intisa, opc, opnd);
+    if (!intop) {
+        return XTENSA_UNDEFINED;
+    }
+
+    return intop->regfile;
+}
+
+
+int xtensa_operand_num_regs(xtensa_isa isa, xtensa_opcode opc, int opnd)
+{
+    xtensa_isa_internal *intisa = (xtensa_isa_internal *)isa;
+    xtensa_operand_internal *intop;
+
+    intop = get_operand(intisa, opc, opnd);
+    if (!intop) {
+        return XTENSA_UNDEFINED;
+    }
+
+    return intop->num_regs;
+}
+
+
+int xtensa_operand_is_known_reg(xtensa_isa isa, xtensa_opcode opc, int opnd)
+{
+    xtensa_isa_internal *intisa = (xtensa_isa_internal *)isa;
+    xtensa_operand_internal *intop;
+
+    intop = get_operand(intisa, opc, opnd);
+    if (!intop) {
+        return XTENSA_UNDEFINED;
+    }
+
+    if ((intop->flags & XTENSA_OPERAND_IS_UNKNOWN) == 0) {
+        return 1;
+    }
+    return 0;
+}
+
+
+int xtensa_operand_is_PCrelative(xtensa_isa isa, xtensa_opcode opc, int opnd)
+{
+    xtensa_isa_internal *intisa = (xtensa_isa_internal *)isa;
+    xtensa_operand_internal *intop;
+
+    intop = get_operand(intisa, opc, opnd);
+    if (!intop) {
+        return XTENSA_UNDEFINED;
+    }
+
+    if ((intop->flags & XTENSA_OPERAND_IS_PCRELATIVE) != 0) {
+        return 1;
+    }
+    return 0;
+}
+
+
+int xtensa_operand_do_reloc(xtensa_isa isa, xtensa_opcode opc, int opnd,
+                            uint32_t *valp, uint32_t pc)
+{
+    xtensa_isa_internal *intisa = (xtensa_isa_internal *)isa;
+    xtensa_operand_internal *intop;
+
+    intop = get_operand(intisa, opc, opnd);
+    if (!intop) {
+        return -1;
+    }
+
+    if ((intop->flags & XTENSA_OPERAND_IS_PCRELATIVE) == 0) {
+        return 0;
+    }
+
+    if (!intop->do_reloc) {
+        xtisa_errno = xtensa_isa_internal_error;
+        strcpy(xtisa_error_msg, "operand missing do_reloc function");
+        return -1;
+    }
+
+    if ((*intop->do_reloc)(valp, pc)) {
+        xtisa_errno = xtensa_isa_bad_value;
+        sprintf(xtisa_error_msg,
+                "do_reloc failed for value 0x%08x at PC 0x%08x", *valp, pc);
+        return -1;
+    }
+
+    return 0;
+}
+
+
+int xtensa_operand_undo_reloc(xtensa_isa isa, xtensa_opcode opc, int opnd,
+                              uint32_t *valp, uint32_t pc)
+{
+    xtensa_isa_internal *intisa = (xtensa_isa_internal *)isa;
+    xtensa_operand_internal *intop;
+
+    intop = get_operand(intisa, opc, opnd);
+    if (!intop) {
+        return -1;
+    }
+
+    if ((intop->flags & XTENSA_OPERAND_IS_PCRELATIVE) == 0) {
+        return 0;
+    }
+
+    if (!intop->undo_reloc) {
+        xtisa_errno = xtensa_isa_internal_error;
+        strcpy(xtisa_error_msg, "operand missing undo_reloc function");
+        return -1;
+    }
+
+    if ((*intop->undo_reloc)(valp, pc)) {
+        xtisa_errno = xtensa_isa_bad_value;
+        sprintf(xtisa_error_msg,
+                "undo_reloc failed for value 0x%08x at PC 0x%08x", *valp, pc);
+        return -1;
+    }
+
+    return 0;
+}
+
+
+/* State Operands. */
+
+
+#define CHECK_STATE_OPERAND(INTISA, OPC, ICLASS, STOP, ERRVAL) \
+    do { \
+        if ((STOP) < 0 || (STOP) >= (ICLASS)->num_stateOperands) { \
+            xtisa_errno = xtensa_isa_bad_operand; \
+            sprintf(xtisa_error_msg, "invalid state operand number (%d); " \
+                    "opcode \"%s\" has %d state operands", (STOP), \
+                    (INTISA)->opcodes[(OPC)].name, \
+                    (ICLASS)->num_stateOperands); \
+            return ERRVAL; \
+        } \
+    } while (0)
+
+
+xtensa_state xtensa_stateOperand_state(xtensa_isa isa, xtensa_opcode opc,
+                                       int stOp)
+{
+    xtensa_isa_internal *intisa = (xtensa_isa_internal *)isa;
+    xtensa_iclass_internal *iclass;
+    int iclass_id;
+
+    CHECK_OPCODE(intisa, opc, XTENSA_UNDEFINED);
+    iclass_id = intisa->opcodes[opc].iclass_id;
+    iclass = &intisa->iclasses[iclass_id];
+    CHECK_STATE_OPERAND(intisa, opc, iclass, stOp, XTENSA_UNDEFINED);
+    return iclass->stateOperands[stOp].u.state;
+}
+
+
+char xtensa_stateOperand_inout(xtensa_isa isa, xtensa_opcode opc, int stOp)
+{
+    xtensa_isa_internal *intisa = (xtensa_isa_internal *)isa;
+    xtensa_iclass_internal *iclass;
+    int iclass_id;
+
+    CHECK_OPCODE(intisa, opc, 0);
+    iclass_id = intisa->opcodes[opc].iclass_id;
+    iclass = &intisa->iclasses[iclass_id];
+    CHECK_STATE_OPERAND(intisa, opc, iclass, stOp, 0);
+    return iclass->stateOperands[stOp].inout;
+}
+
+
+/* Interface Operands. */
+
+
+#define CHECK_INTERFACE_OPERAND(INTISA, OPC, ICLASS, IFOP, ERRVAL) \
+    do { \
+        if ((IFOP) < 0 || (IFOP) >= (ICLASS)->num_interfaceOperands) { \
+            xtisa_errno = xtensa_isa_bad_operand; \
+            sprintf(xtisa_error_msg, \
+                    "invalid interface operand number (%d); " \
+                    "opcode \"%s\" has %d interface operands", (IFOP), \
+                    (INTISA)->opcodes[(OPC)].name, \
+                    (ICLASS)->num_interfaceOperands); \
+            return ERRVAL; \
+        } \
+    } while (0)
+
+
+xtensa_interface xtensa_interfaceOperand_interface(xtensa_isa isa,
+                                                   xtensa_opcode opc,
+                                                   int ifOp)
+{
+    xtensa_isa_internal *intisa = (xtensa_isa_internal *)isa;
+    xtensa_iclass_internal *iclass;
+    int iclass_id;
+
+    CHECK_OPCODE(intisa, opc, XTENSA_UNDEFINED);
+    iclass_id = intisa->opcodes[opc].iclass_id;
+    iclass = &intisa->iclasses[iclass_id];
+    CHECK_INTERFACE_OPERAND(intisa, opc, iclass, ifOp, XTENSA_UNDEFINED);
+    return iclass->interfaceOperands[ifOp];
+}
+
+
+/* Register Files. */
+
+
+#define CHECK_REGFILE(INTISA, RF, ERRVAL) \
+    do { \
+        if ((RF) < 0 || (RF) >= (INTISA)->num_regfiles) { \
+            xtisa_errno = xtensa_isa_bad_regfile; \
+            strcpy(xtisa_error_msg, "invalid regfile specifier"); \
+            return ERRVAL; \
+        } \
+    } while (0)
+
+
+xtensa_regfile xtensa_regfile_lookup(xtensa_isa isa, const char *name)
+{
+    xtensa_isa_internal *intisa = (xtensa_isa_internal *)isa;
+    int n;
+
+    if (!name || !*name) {
+        xtisa_errno = xtensa_isa_bad_regfile;
+        strcpy(xtisa_error_msg, "invalid regfile name");
+        return XTENSA_UNDEFINED;
+    }
+
+    /* The expected number of regfiles is small; use a linear search. */
+    for (n = 0; n < intisa->num_regfiles; n++) {
+        if (!strcmp(intisa->regfiles[n].name, name)) {
+            return n;
+        }
+    }
+
+    xtisa_errno = xtensa_isa_bad_regfile;
+    sprintf(xtisa_error_msg, "regfile \"%s\" not recognized", name);
+    return XTENSA_UNDEFINED;
+}
+
+
+xtensa_regfile xtensa_regfile_lookup_shortname(xtensa_isa isa,
+                                               const char *shortname)
+{
+    xtensa_isa_internal *intisa = (xtensa_isa_internal *)isa;
+    int n;
+
+    if (!shortname || !*shortname) {
+        xtisa_errno = xtensa_isa_bad_regfile;
+        strcpy(xtisa_error_msg, "invalid regfile shortname");
+        return XTENSA_UNDEFINED;
+    }
+
+    /* The expected number of regfiles is small; use a linear search. */
+    for (n = 0; n < intisa->num_regfiles; n++) {
+        /*
+         * Ignore regfile views since they always have the same shortnames
+         * as their parents.
+         */
+        if (intisa->regfiles[n].parent != n) {
+            continue;
+        }
+        if (!strcmp(intisa->regfiles[n].shortname, shortname)) {
+            return n;
+        }
+    }
+
+    xtisa_errno = xtensa_isa_bad_regfile;
+    sprintf(xtisa_error_msg, "regfile shortname \"%s\" not recognized",
+            shortname);
+    return XTENSA_UNDEFINED;
+}
+
+
+const char *xtensa_regfile_name(xtensa_isa isa, xtensa_regfile rf)
+{
+    xtensa_isa_internal *intisa = (xtensa_isa_internal *)isa;
+
+    CHECK_REGFILE(intisa, rf, NULL);
+    return intisa->regfiles[rf].name;
+}
+
+
+const char *xtensa_regfile_shortname(xtensa_isa isa, xtensa_regfile rf)
+{
+    xtensa_isa_internal *intisa = (xtensa_isa_internal *)isa;
+
+    CHECK_REGFILE(intisa, rf, NULL);
+    return intisa->regfiles[rf].shortname;
+}
+
+
+xtensa_regfile xtensa_regfile_view_parent(xtensa_isa isa, xtensa_regfile rf)
+{
+    xtensa_isa_internal *intisa = (xtensa_isa_internal *)isa;
+
+    CHECK_REGFILE(intisa, rf, XTENSA_UNDEFINED);
+    return intisa->regfiles[rf].parent;
+}
+
+
+int xtensa_regfile_num_bits(xtensa_isa isa, xtensa_regfile rf)
+{
+    xtensa_isa_internal *intisa = (xtensa_isa_internal *)isa;
+
+    CHECK_REGFILE(intisa, rf, XTENSA_UNDEFINED);
+    return intisa->regfiles[rf].num_bits;
+}
+
+
+int xtensa_regfile_num_entries(xtensa_isa isa, xtensa_regfile rf)
+{
+    xtensa_isa_internal *intisa = (xtensa_isa_internal *)isa;
+
+    CHECK_REGFILE(intisa, rf, XTENSA_UNDEFINED);
+    return intisa->regfiles[rf].num_entries;
+}
+
+
+/* Processor States. */
+
+
+#define CHECK_STATE(INTISA, ST, ERRVAL) \
+    do { \
+        if ((ST) < 0 || (ST) >= (INTISA)->num_states) { \
+            xtisa_errno = xtensa_isa_bad_state; \
+            strcpy(xtisa_error_msg, "invalid state specifier"); \
+            return ERRVAL; \
+        } \
+    } while (0)
+
+
+xtensa_state xtensa_state_lookup(xtensa_isa isa, const char *name)
+{
+    xtensa_isa_internal *intisa = (xtensa_isa_internal *)isa;
+    xtensa_lookup_entry entry, *result = 0;
+
+    if (!name || !*name) {
+        xtisa_errno = xtensa_isa_bad_state;
+        strcpy(xtisa_error_msg, "invalid state name");
+        return XTENSA_UNDEFINED;
+    }
+
+    if (intisa->num_states != 0) {
+        entry.key = name;
+        result = bsearch(&entry, intisa->state_lookup_table,
+                         intisa->num_states, sizeof(xtensa_lookup_entry),
+                         xtensa_isa_name_compare);
+    }
+
+    if (!result) {
+        xtisa_errno = xtensa_isa_bad_state;
+        sprintf(xtisa_error_msg, "state \"%s\" not recognized", name);
+        return XTENSA_UNDEFINED;
+    }
+
+    return result->u.state;
+}
+
+
+const char *xtensa_state_name(xtensa_isa isa, xtensa_state st)
+{
+    xtensa_isa_internal *intisa = (xtensa_isa_internal *)isa;
+
+    CHECK_STATE(intisa, st, NULL);
+    return intisa->states[st].name;
+}
+
+
+int xtensa_state_num_bits(xtensa_isa isa, xtensa_state st)
+{
+    xtensa_isa_internal *intisa = (xtensa_isa_internal *)isa;
+
+    CHECK_STATE(intisa, st, XTENSA_UNDEFINED);
+    return intisa->states[st].num_bits;
+}
+
+
+int xtensa_state_is_exported(xtensa_isa isa, xtensa_state st)
+{
+    xtensa_isa_internal *intisa = (xtensa_isa_internal *)isa;
+
+    CHECK_STATE(intisa, st, XTENSA_UNDEFINED);
+    if ((intisa->states[st].flags & XTENSA_STATE_IS_EXPORTED) != 0) {
+        return 1;
+    }
+    return 0;
+}
+
+
+int xtensa_state_is_shared_or(xtensa_isa isa, xtensa_state st)
+{
+    xtensa_isa_internal *intisa = (xtensa_isa_internal *)isa;
+
+    CHECK_STATE(intisa, st, XTENSA_UNDEFINED);
+    if ((intisa->states[st].flags & XTENSA_STATE_IS_SHARED_OR) != 0) {
+        return 1;
+    }
+    return 0;
+}
+
+
+/* Sysregs. */
+
+
+#define CHECK_SYSREG(INTISA, SYSREG, ERRVAL) \
+    do { \
+        if ((SYSREG) < 0 || (SYSREG) >= (INTISA)->num_sysregs) { \
+            xtisa_errno = xtensa_isa_bad_sysreg; \
+            strcpy(xtisa_error_msg, "invalid sysreg specifier"); \
+            return ERRVAL; \
+        } \
+    } while (0)
+
+
+xtensa_sysreg xtensa_sysreg_lookup(xtensa_isa isa, int num, int is_user)
+{
+    xtensa_isa_internal *intisa = (xtensa_isa_internal *)isa;
+
+    if (is_user != 0) {
+        is_user = 1;
+    }
+
+    if (num < 0 || num > intisa->max_sysreg_num[is_user] ||
+        intisa->sysreg_table[is_user][num] == XTENSA_UNDEFINED) {
+        xtisa_errno = xtensa_isa_bad_sysreg;
+        strcpy(xtisa_error_msg, "sysreg not recognized");
+        return XTENSA_UNDEFINED;
+    }
+
+    return intisa->sysreg_table[is_user][num];
+}
+
+
+xtensa_sysreg xtensa_sysreg_lookup_name(xtensa_isa isa, const char *name)
+{
+    xtensa_isa_internal *intisa = (xtensa_isa_internal *)isa;
+    xtensa_lookup_entry entry, *result = 0;
+
+    if (!name || !*name) {
+        xtisa_errno = xtensa_isa_bad_sysreg;
+        strcpy(xtisa_error_msg, "invalid sysreg name");
+        return XTENSA_UNDEFINED;
+    }
+
+    if (intisa->num_sysregs != 0) {
+        entry.key = name;
+        result = bsearch(&entry, intisa->sysreg_lookup_table,
+                         intisa->num_sysregs, sizeof(xtensa_lookup_entry),
+                         xtensa_isa_name_compare);
+    }
+
+    if (!result) {
+        xtisa_errno = xtensa_isa_bad_sysreg;
+        sprintf(xtisa_error_msg, "sysreg \"%s\" not recognized", name);
+        return XTENSA_UNDEFINED;
+    }
+
+    return result->u.sysreg;
+}
+
+
+const char *xtensa_sysreg_name(xtensa_isa isa, xtensa_sysreg sysreg)
+{
+    xtensa_isa_internal *intisa = (xtensa_isa_internal *)isa;
+
+    CHECK_SYSREG(intisa, sysreg, NULL);
+    return intisa->sysregs[sysreg].name;
+}
+
+
+int xtensa_sysreg_number(xtensa_isa isa, xtensa_sysreg sysreg)
+{
+    xtensa_isa_internal *intisa = (xtensa_isa_internal *)isa;
+
+    CHECK_SYSREG(intisa, sysreg, XTENSA_UNDEFINED);
+    return intisa->sysregs[sysreg].number;
+}
+
+
+int xtensa_sysreg_is_user(xtensa_isa isa, xtensa_sysreg sysreg)
+{
+    xtensa_isa_internal *intisa = (xtensa_isa_internal *)isa;
+
+    CHECK_SYSREG(intisa, sysreg, XTENSA_UNDEFINED);
+    if (intisa->sysregs[sysreg].is_user) {
+        return 1;
+    }
+    return 0;
+}
+
+
+/* Interfaces. */
+
+
+#define CHECK_INTERFACE(INTISA, INTF, ERRVAL) \
+    do { \
+        if ((INTF) < 0 || (INTF) >= (INTISA)->num_interfaces) { \
+            xtisa_errno = xtensa_isa_bad_interface; \
+            strcpy(xtisa_error_msg, "invalid interface specifier"); \
+            return ERRVAL; \
+        } \
+    } while (0)
+
+
+xtensa_interface xtensa_interface_lookup(xtensa_isa isa, const char *ifname)
+{
+    xtensa_isa_internal *intisa = (xtensa_isa_internal *)isa;
+    xtensa_lookup_entry entry, *result = 0;
+
+    if (!ifname || !*ifname) {
+        xtisa_errno = xtensa_isa_bad_interface;
+        strcpy(xtisa_error_msg, "invalid interface name");
+        return XTENSA_UNDEFINED;
+    }
+
+    if (intisa->num_interfaces != 0) {
+        entry.key = ifname;
+        result = bsearch(&entry, intisa->interface_lookup_table,
+                         intisa->num_interfaces, sizeof(xtensa_lookup_entry),
+                         xtensa_isa_name_compare);
+    }
+
+    if (!result) {
+        xtisa_errno = xtensa_isa_bad_interface;
+        sprintf(xtisa_error_msg, "interface \"%s\" not recognized", ifname);
+        return XTENSA_UNDEFINED;
+    }
+
+    return result->u.intf;
+}
+
+
+const char *xtensa_interface_name(xtensa_isa isa, xtensa_interface intf)
+{
+    xtensa_isa_internal *intisa = (xtensa_isa_internal *)isa;
+
+    CHECK_INTERFACE(intisa, intf, NULL);
+    return intisa->interfaces[intf].name;
+}
+
+
+int xtensa_interface_num_bits(xtensa_isa isa, xtensa_interface intf)
+{
+    xtensa_isa_internal *intisa = (xtensa_isa_internal *)isa;
+
+    CHECK_INTERFACE(intisa, intf, XTENSA_UNDEFINED);
+    return intisa->interfaces[intf].num_bits;
+}
+
+
+char xtensa_interface_inout(xtensa_isa isa, xtensa_interface intf)
+{
+    xtensa_isa_internal *intisa = (xtensa_isa_internal *)isa;
+
+    CHECK_INTERFACE(intisa, intf, 0);
+    return intisa->interfaces[intf].inout;
+}
+
+
+int xtensa_interface_has_side_effect(xtensa_isa isa, xtensa_interface intf)
+{
+    xtensa_isa_internal *intisa = (xtensa_isa_internal *)isa;
+
+    CHECK_INTERFACE(intisa, intf, XTENSA_UNDEFINED);
+    if ((intisa->interfaces[intf].flags &
+         XTENSA_INTERFACE_HAS_SIDE_EFFECT) != 0) {
+        return 1;
+    }
+    return 0;
+}
+
+
+int xtensa_interface_class_id(xtensa_isa isa, xtensa_interface intf)
+{
+    xtensa_isa_internal *intisa = (xtensa_isa_internal *)isa;
+
+    CHECK_INTERFACE(intisa, intf, XTENSA_UNDEFINED);
+    return intisa->interfaces[intf].class_id;
+}
+
+
+/* Functional Units. */
+
+
+#define CHECK_FUNCUNIT(INTISA, FUN, ERRVAL) \
+    do { \
+        if ((FUN) < 0 || (FUN) >= (INTISA)->num_funcUnits) { \
+            xtisa_errno = xtensa_isa_bad_funcUnit; \
+            strcpy(xtisa_error_msg, "invalid functional unit specifier"); \
+            return ERRVAL; \
+        } \
+    } while (0)
+
+
+xtensa_funcUnit xtensa_funcUnit_lookup(xtensa_isa isa, const char *fname)
+{
+    xtensa_isa_internal *intisa = (xtensa_isa_internal *)isa;
+    xtensa_lookup_entry entry, *result = 0;
+
+    if (!fname || !*fname) {
+        xtisa_errno = xtensa_isa_bad_funcUnit;
+        strcpy(xtisa_error_msg, "invalid functional unit name");
+        return XTENSA_UNDEFINED;
+    }
+
+    if (intisa->num_funcUnits != 0) {
+        entry.key = fname;
+        result = bsearch(&entry, intisa->funcUnit_lookup_table,
+                         intisa->num_funcUnits, sizeof(xtensa_lookup_entry),
+                         xtensa_isa_name_compare);
+    }
+
+    if (!result) {
+        xtisa_errno = xtensa_isa_bad_funcUnit;
+        sprintf(xtisa_error_msg,
+                "functional unit \"%s\" not recognized", fname);
+        return XTENSA_UNDEFINED;
+    }
+
+    return result->u.fun;
+}
+
+
+const char *xtensa_funcUnit_name(xtensa_isa isa, xtensa_funcUnit fun)
+{
+    xtensa_isa_internal *intisa = (xtensa_isa_internal *)isa;
+
+    CHECK_FUNCUNIT(intisa, fun, NULL);
+    return intisa->funcUnits[fun].name;
+}
+
+
+int xtensa_funcUnit_num_copies(xtensa_isa isa, xtensa_funcUnit fun)
+{
+    xtensa_isa_internal *intisa = (xtensa_isa_internal *)isa;
+
+    CHECK_FUNCUNIT(intisa, fun, XTENSA_UNDEFINED);
+    return intisa->funcUnits[fun].num_copies;
+}
diff --git a/target/xtensa/xtensa-isa.h b/target/xtensa/xtensa-isa.h
new file mode 100644
index 000000000000..d06614c187c1
--- /dev/null
+++ b/target/xtensa/xtensa-isa.h
@@ -0,0 +1 @@
+#include <hw/xtensa/xtensa-isa.h>
-- 
2.1.4
