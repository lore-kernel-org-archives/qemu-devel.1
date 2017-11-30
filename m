Received: from eggs.gnu.org ([2001:4830:134:3::10]:35184)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <doug16k@gmail.com>) id 1eKIo0-0005FS-Ms
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 01:58:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <doug16k@gmail.com>) id 1eKInz-0005vI-N5
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 01:58:44 -0500
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:36740)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <doug16k@gmail.com>) id 1eKInz-0005ux-IP
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 01:58:43 -0500
Received: by mail-qk0-x241.google.com with SMTP id t187so7649380qkh.3
	for <qemu-devel@nongnu.org>; Wed, 29 Nov 2017 22:58:43 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <87vahwavnr.fsf@dusky.pond.sub.org>
References: <20171127041038.22819-1-doug16k@gmail.com>
	<87vahwavnr.fsf@dusky.pond.sub.org>
From: Doug Gale <doug16k@gmail.com>
Date: Thu, 30 Nov 2017 01:58:41 -0500
Message-ID: <CAEfK_476ncrE_nireFHO5ErQe-Uq87a9z73hsvdpnZw-T_=GyQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] gdbstub: add tracing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@gmail.com>

On Mon, Nov 27, 2017 at 5:00 AM, Markus Armbruster <armbru@redhat.com> wrote:
> Drive-by question...
>
> Doug Gale <doug16k@gmail.com> writes:
>
>> Signed-off-by: Doug Gale <doug16k@gmail.com>
>> ---
>>  gdbstub.c    | 100 ++++++++++++++++++++++++++++++++++++++---------------------
>>  trace-events |  21 +++++++++++++
>>  2 files changed, 86 insertions(+), 35 deletions(-)
>>
>> diff --git a/gdbstub.c b/gdbstub.c
>> index 2a94030d3b..a75f319bd0 100644
>> --- a/gdbstub.c
>> +++ b/gdbstub.c
>> @@ -21,6 +21,7 @@
>>  #include "qemu/error-report.h"
>>  #include "qemu/cutils.h"
>>  #include "cpu.h"
>> +#include "trace-root.h"
>>  #ifdef CONFIG_USER_ONLY
>>  #include "qemu.h"
>>  #else
>> @@ -287,21 +288,6 @@ static int gdb_signal_to_target (int sig)
>>          return -1;
>>  }
>>
>> -/* #define DEBUG_GDB */
>> -
>> -#ifdef DEBUG_GDB
>> -# define DEBUG_GDB_GATE 1
>> -#else
>> -# define DEBUG_GDB_GATE 0
>> -#endif
>> -
>> -#define gdb_debug(fmt, ...) do { \
>> -    if (DEBUG_GDB_GATE) { \
>> -        fprintf(stderr, "%s: " fmt, __func__, ## __VA_ARGS__); \
>> -    } \
>> -} while (0)
>> -
>> -
>>  typedef struct GDBRegisterState {
>>      int base_reg;
>>      int num_regs;
>> @@ -538,12 +524,47 @@ static void hextomem(uint8_t *mem, const char *buf, int len)
>>      }
>>  }
>>
>> +static void hexdump(const char *buf, int len,
>> +                    void (*trace_fn)(size_t ofs, char const *text))
>> +{
>> +    char line_buffer[3 * 16 + 4 + 16 + 1];
>> +
>> +    for (size_t i = 0; i < len || (i & 0xF); ++i) {
>> +        size_t byte_ofs = i & 15;
>> +
>> +        if (byte_ofs == 0) {
>> +            memset(line_buffer, ' ', 3 * 16 + 4 + 16);
>> +            line_buffer[3 * 16 + 4 + 16] = 0;
>> +        }
>> +
>> +        size_t col_group = (i >> 2) & 3;
>> +        size_t hex_col = byte_ofs * 3 + col_group;
>> +        size_t txt_col = 3 * 16 + 4 + byte_ofs;
>> +
>> +        if (i < len) {
>> +            char value = buf[i];
>> +
>> +            line_buffer[hex_col + 0] = tohex((value >> 4) & 0xF);
>> +            line_buffer[hex_col + 1] = tohex((value >> 0) & 0xF);
>> +            line_buffer[txt_col + 0] = (value >= ' ' && value < 127)
>> +                    ? value
>> +                    : '.';
>> +        }
>> +
>> +        if (byte_ofs == 0xF)
>> +            trace_fn(i & -16, line_buffer);
>> +    }
>> +}
>
> Could existing qemu_hexdump() serve?
>
>> +
>>  /* return -1 if error, 0 if OK */
>> -static int put_packet_binary(GDBState *s, const char *buf, int len)
>> +static int put_packet_binary(GDBState *s, const char *buf, int len, bool dump)
>>  {
>>      int csum, i;
>>      uint8_t *p;
>>
>> +    if (TRACE_GDBSTUB_IO_BINARYREPLY_ENABLED && dump)
>> +        hexdump(buf, len, trace_gdbstub_io_binaryreply);
>> +
>>      for(;;) {
>>          p = s->last_packet;
>>          *(p++) = '$';
> [...]

It is incorrect to use qemu_hexdump, tracing isn't printf. The whole
point of this patch is to _not_ dump traces to printf. I have already
submitted tracing that used printf, and it was rejected with a request
to use trace_ infrastructure.

It might be a better idea to refactor qemu_hexdump to use this
algorithm and use a trace_fn callback which dumps lines to printf for
qemu_hexdump case. qemu_hexdump hammers printf with a couple of
characters at a time of output and uses several loops, this algorithm
generates whole lines and more efficiently does one I/O per line. This
algorithm also breaks the hex into groups of four bytes to make it
easy to visually find a given byte.

I opted not to do that refactor of qemu_hexdump to reduce the scope of
my patch. Should I do that and resubmit?
