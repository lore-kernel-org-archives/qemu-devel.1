Received: from eggs.gnu.org ([2001:4830:134:3::10]:34788)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dxcT5-0008KV-KH
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 13:19:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dxcT3-0006DP-8q
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 13:19:23 -0400
Received: from mail-pg0-x236.google.com ([2607:f8b0:400e:c05::236]:51169)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dxcT3-0006Ca-30
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 13:19:21 -0400
Received: by mail-pg0-x236.google.com with SMTP id p5so1291901pgn.7
	for <qemu-devel@nongnu.org>; Thu, 28 Sep 2017 10:19:21 -0700 (PDT)
References: <1506524313-20037-1-git-send-email-thuth@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <66d1d3b0-5f46-a682-1f3f-8945168f3aac@linaro.org>
Date: Thu, 28 Sep 2017 10:19:11 -0700
MIME-Version: 1.0
In-Reply-To: <1506524313-20037-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] disas: Always initialize
 read_memory_inner_func properly
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Julian Brown <julian@codesourcery.com>
List-ID: <qemu-devel.nongnu.org>

On 09/27/2017 07:58 AM, Thomas Huth wrote:
> I've recently seen this with valgrind while running the HMP tester:
> 
> ==22373== Conditional jump or move depends on uninitialised value(s)
> ==22373==    at 0x4A41FD: arm_disas_set_info (cpu.c:504)
> ==22373==    by 0x3867A7: monitor_disas (disas.c:390)
> ==22373==    by 0x38E80E: memory_dump (monitor.c:1339)
> ==22373==    by 0x38FA43: handle_hmp_command (monitor.c:3123)
> ==22373==    by 0x38FB9E: qmp_human_monitor_command (monitor.c:613)
> ==22373==    by 0x4E3124: qmp_marshal_human_monitor_command (qmp-marshal.c:1736)
> ==22373==    by 0x769678: do_qmp_dispatch (qmp-dispatch.c:104)
> ==22373==    by 0x769678: qmp_dispatch (qmp-dispatch.c:131)
> ==22373==    by 0x38B734: handle_qmp_command (monitor.c:3853)
> ==22373==    by 0x76ED07: json_message_process_token (json-streamer.c:105)
> ==22373==    by 0x78D40A: json_lexer_feed_char (json-lexer.c:323)
> ==22373==    by 0x78D4CD: json_lexer_feed (json-lexer.c:373)
> ==22373==    by 0x38A08D: monitor_qmp_read (monitor.c:3895)
> 
> And indeed, in monitor_disas, the read_memory_inner_func variable was
> not initialized, but arm_disas_set_info() expects this to be NULL
> or a valid pointer. Let's properly set this to NULL in the
> INIT_DISASSEMBLE_INFO to fix it in all functions that use the
> disassemble_info struct.
> 
> Fixes: f7478a92dd9ee2276bfaa5b7317140d3f9d6a53b ("Fix Thumb-1 BE32 execution")
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  disas.c             | 1 -
>  include/disas/bfd.h | 1 +
>  2 files changed, 1 insertion(+), 1 deletion(-)


Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
