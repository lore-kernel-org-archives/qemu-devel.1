Received: from eggs.gnu.org ([2001:4830:134:3::10]:58187)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eYyYO-0000LU-8l
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 13:23:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eYyYM-0000AN-VT
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 13:23:16 -0500
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:37120)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eYyYM-0000A2-Ow
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 13:23:14 -0500
Received: by mail-ot0-x243.google.com with SMTP id p31so12126237ota.4
	for <qemu-devel@nongnu.org>; Tue, 09 Jan 2018 10:23:14 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180108193124.mjei33w5wopmadmk@kentang.home>
References: <20180108193124.mjei33w5wopmadmk@kentang.home>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Jan 2018 18:22:53 +0000
Message-ID: <CAFEAcA-dOpPiiGA28agziDyi5QKn4ErGgPyG_vL9ixk9iKUv0g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL] qemu-sparc updates
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 8 January 2018 at 19:31, Mark Cave-Ayland
<mark.cave-ayland@ilande.co.uk> wrote:
> Hi Peter,
>
> Here is the first set of SPARC updates for 2.12. Please pull.
>
>
> ATB,
>
> Mark.
>
>
> The following changes since commit 4124ea4f5bd367ca6412fb2dfe7ac4d80e1504d9:
>
>   Merge remote-tracking branch 'remotes/rth/tags/pull-tcg-20171229' into staging (2018-01-08 16:17:04 +0000)
>
> are available in the git repository at:
>
>   https://github.com/mcayland/qemu.git tags/qemu-sparc-signed
>
> for you to fetch changes up to 6a52624720e5abc6a1f067a7e7b8239b428e0c95:
>
>   sun4u_iommu: add trace event for IOMMU translations (2018-01-08 19:07:55 +0000)
>
> ----------------------------------------------------------------
> qemu-sparc update
>
> ----------------------------------------------------------------

Hi. This seems to crash in 'make check'. One of the crashes has a
memory corruption splat:

TEST: tests/device-introspect-test... (pid=20423)
  /sparc64/device/introspect/list:                                     OK
  /sparc64/device/introspect/list-fields:                              OK
  /sparc64/device/introspect/none:                                     OK
  /sparc64/device/introspect/abstract:                                 OK
  /sparc64/device/introspect/concrete:
*** Error in `sparc64-softmmu/qemu-system-spar
c64': corrupted double-linked list (not small): 0x0000010033b823a0 ***
======= Backtrace: =========
/lib64/libc.so.6(+0xb0b94)[0x3fff90ce0b94]
/lib64/libc.so.6(+0xb5b18)[0x3fff90ce5b18]
/lib64/libc.so.6(__libc_calloc-0x14b664)[0x3fff90ce9934]
/lib64/libglib-2.0.so.0(g_malloc0-0x100d54)[0x3fff97a634d4]
sparc64-softmmu/qemu-system-sparc64[0x1030a9bc]
sparc64-softmmu/qemu-system-sparc64[0x103062c8]
sparc64-softmmu/qemu-system-sparc64[0x103062a0]

Running it under valgrind with
QTEST_QEMU_BINARY='valgrind sparc64-softmmu/qemu-system-sparc64'
./tests/device-introspect-test -p /sparc64/device/introspect/concrete

gives this write-after-free:

==1931== Invalid write of size 8
==1931==    at 0x55EA51: pci_host_bus_register (pci.c:331)
==1931==    by 0x55ECBD: pci_bus_init (pci.c:393)
==1931==    by 0x55EE18: pci_bus_new (pci.c:424)
==1931==    by 0x55EEE2: pci_register_bus (pci.c:447)
==1931==    by 0x55D14F: pci_pbm_init (apb.c:464)
==1931==    by 0x69179B: object_init_with_type (object.c:353)
==1931==    by 0x6919D0: object_initialize_with_type (object.c:384)
==1931==    by 0x691E3B: object_new_with_type (object.c:492)
==1931==    by 0x691E78: object_new (object.c:502)
==1931==    by 0x479A3C: qmp_device_list_properties (qmp.c:537)
==1931==    by 0x455479: qdev_device_help (qdev-monitor.c:279)
==1931==    by 0x456C9E: qmp_device_add (qdev-monitor.c:802)
==1931==  Address 0x2ca7af08 is 1,528 bytes inside a block of size 3,312 free'd
==1931==    at 0x4C2EDEB: free (in
/usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==1931==    by 0x691DC6: object_finalize (object.c:480)
==1931==    by 0x692CBD: object_unref (object.c:911)
==1931==    by 0x479B91: qmp_device_list_properties (qmp.c:572)
==1931==    by 0x469EA0: qmp_marshal_device_list_properties (qmp-marshal.c:1393)
==1931==    by 0x7A25D2: do_qmp_dispatch (qmp-dispatch.c:104)
==1931==    by 0x7A2703: qmp_dispatch (qmp-dispatch.c:131)
==1931==    by 0x39E36D: handle_qmp_command (monitor.c:3839)
==1931==    by 0x7AA357: json_message_process_token (json-streamer.c:105)
==1931==    by 0x7D70CB: json_lexer_feed_char (json-lexer.c:323)
==1931==    by 0x7D7213: json_lexer_feed (json-lexer.c:373)
==1931==    by 0x7AA3FE: json_message_parser_feed (json-streamer.c:124)
==1931==  Block was alloc'd at
==1931==    at 0x4C2DB8F: malloc (in
/usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==1931==    by 0x1C004718: g_malloc (in
/lib/x86_64-linux-gnu/libglib-2.0.so.0.4800.2)
==1931==    by 0x691E1C: object_new_with_type (object.c:491)
==1931==    by 0x691E78: object_new (object.c:502)
==1931==    by 0x479A3C: qmp_device_list_properties (qmp.c:537)
==1931==    by 0x469EA0: qmp_marshal_device_list_properties (qmp-marshal.c:1393)
==1931==    by 0x7A25D2: do_qmp_dispatch (qmp-dispatch.c:104)
==1931==    by 0x7A2703: qmp_dispatch (qmp-dispatch.c:131)
==1931==    by 0x39E36D: handle_qmp_command (monitor.c:3839)
==1931==    by 0x7AA357: json_message_process_token (json-streamer.c:105)
==1931==    by 0x7D70CB: json_lexer_feed_char (json-lexer.c:323)
==1931==    by 0x7D7213: json_lexer_feed (json-lexer.c:373)



thanks
-- PMM
