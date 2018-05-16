Received: from eggs.gnu.org ([2001:4830:134:3::10]:35955)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <suhang16@mails.ucas.ac.cn>) id 1fIq1J-0007aO-VQ
	for qemu-devel@nongnu.org; Wed, 16 May 2018 02:34:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <suhang16@mails.ucas.ac.cn>) id 1fIq1F-00070i-2m
	for qemu-devel@nongnu.org; Wed, 16 May 2018 02:34:41 -0400
Received: from smtp23.cstnet.cn ([159.226.251.23]:57907 helo=cstnet.cn)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <suhang16@mails.ucas.ac.cn>) id 1fIq1E-0006xd-D7
	for qemu-devel@nongnu.org; Wed, 16 May 2018 02:34:36 -0400
From: Su Hang <suhang16@mails.ucas.ac.cn>
Date: Wed, 16 May 2018 14:34:25 +0800
Message-Id: <1526452467-18798-1-git-send-email-suhang16@mails.ucas.ac.cn>
Subject: [Qemu-devel] [PATCH v9 0/2] Implement Hex file loader and add test
 case
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: stefanha@gmail.com, qemu.ml@steffen-goertz.de, jusual@mail.ru, jim@groklearning.com, joel@jms.id.au, darcysail@gmail.com
Cc: qemu-devel@nongnu.org

These series of patchs implement Intel Hexadecimal File loader and
add QTest testcase to verify the correctness of Loader.

v1:
--  Basic version.

v2:
--  Replace `do{}while(cond);` block with `for(;;)` block.

v3:
--  Add two new files information in MAINTAINERS.

v4:
--  Correct the 'test.hex' path in hexloader-test.c.

v5:
--  Split huge parse_hex_blob() function into four small function;
--  Add check for memory bounds;
--  Check validation for Record type;
--  Replace function ctoh() with glib function g_ascii_xdigit_value();
--  Remove check for '.hex' suffix;
--  Remove unnecessary type cast;
--  Remove duplicate zero-initialization;
--  Correct typos;

v6:
--  Call Intel HEX loader after load_uimage_as();
--  Remove use of KERNEL_LOAD_ADDR;
--  Change (hwaddr) type argument to (hwaddr *) type;
--  Use new struct HexParser to contain all arguments needed by
        handle_record_type();
--  Enable discontiguous data records (again);
--  Remove unnecessary memory clean: bin_buf and HexLine line;
--  Correct typo;
--  Remove unnecessary check for hex file size;
--  Add entry point handle for START_SEG_ADDR_RECORD and
        START_LINEAR_ADDR_RECORD record type;
--  Use hwaddr * type to store entry point;

v7:
--  Remove unnecessary code style changes;
--  Replace `bool` with `size_t` for function `parse_record` return type;
--  Replace `int` with `size_t` for struct `HexParser` member field
        `total_size` type;
--  Replace `int` with `size_t` for function `handle_record_type` return type;
--  Return an error when encountered unimplemented data type
        `START_SEG_ADDR_RECORD`;
--  Add check for `START_LINEAR_ADDR_RECORD` data type:
        byte_count == 4 and address == 0;
--  Rename struct `HexParser` member field `addr` to `start_addr`;
--  Replace `int` with `size_t` for function `parse_hex_blob` return type;
--  Stop incrementing `record_index` when encountered whitespace;
--  Replace
    `if ((record_index >> 1) - LEN_EXCEPT_DATA != parser.line.byte_count)`
    with
    `if ((LEN_EXCEPT_DATA + parser.line.byte_count) * 2 != record_index)`
--  Remove unused field `max_sz`;
--  Replace `int` with `size_t` for local variable `total_size`
        in function `parse_hex_blob`
--  Rename function `load_image_targphys_hex_as` argument `addr` to `entry`;

v8:
--  Discard change in code logic: Stop attempting load 32-bit kernel after
        failed to load 64-bit kernel image;
--  Rename function name `load_image_targphys_hex_as` to `load_targphys_hex_as`
        in comment;
--  Correct grammatical errors in comments;
--  Drop non-exist argument description in comment;
--  Drop macro function `rom_add_hex_blob_as`, replace it with
        `rom_add_blob_fixed_as`, because they are equivalent;

v9:
--  Modify 'configure' file and test data file path in 'hexloader-test.c' to
        support 'hexloader-test.c' out-of-tree builds and run;

Su Hang (2):
  Implement .hex file loader
  Add QTest testcase for the Intel Hexadecimal Object File Loader.

 MAINTAINERS                          |   6 +
 configure                            |   4 +
 hw/arm/boot.c                        |   7 +-
 hw/core/loader.c                     | 246 +++++++++++++++++++++++++++++++++++
 include/hw/loader.h                  |  12 ++
 tests/Makefile.include               |   2 +
 tests/hex-loader-check-data/test.hex |  12 ++
 tests/hexloader-test.c               |  56 ++++++++
 8 files changed, 344 insertions(+), 1 deletion(-)
 create mode 100644 tests/hex-loader-check-data/test.hex
 create mode 100644 tests/hexloader-test.c

--
2.7.4
