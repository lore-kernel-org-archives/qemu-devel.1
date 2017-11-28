Received: from eggs.gnu.org ([2001:4830:134:3::10]:60794)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1eJgCu-00074e-JJ
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 08:45:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1eJgCo-0002fm-Mn
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 08:45:52 -0500
Received: from mail-vk0-f65.google.com ([209.85.213.65]:43137)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <lprosek@redhat.com>) id 1eJgCo-0002ff-I2
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 08:45:46 -0500
Received: by mail-vk0-f65.google.com with SMTP id u84so12387vke.10
	for <qemu-devel@nongnu.org>; Tue, 28 Nov 2017 05:45:46 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <151127329238.6888.17213631612102603209.stgit@Misha-PC.lan02.inno>
References: <151127322955.6888.16198535123422076171.stgit@Misha-PC.lan02.inno>
	<151127329238.6888.17213631612102603209.stgit@Misha-PC.lan02.inno>
From: Ladi Prosek <lprosek@redhat.com>
Date: Tue, 28 Nov 2017 14:45:45 +0100
Message-ID: <CABdb734PrpdEDWAGWLMBuAY3Hm-9m=i+bvjHUfmz+bJKZn6W-g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 10/45] windbg: structures for parsing
 data stream
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mihail Abakumov <mikhail.abakumov@ispras.ru>
Cc: qemu-devel <qemu-devel@nongnu.org>, sw@weilnetz.de, Pavel Dovgalyuk <dovgaluk@ispras.ru>, Roman Kagan <rkagan@virtuozzo.com>, Paolo Bonzini <pbonzini@redhat.com>, "Denis V. Lunev" <den@openvz.org>

On Tue, Nov 21, 2017 at 3:08 PM, Mihail Abakumov
<mikhail.abakumov@ispras.ru> wrote:
> Added structures for parsing data stream from windbg to packet.
>
> Signed-off-by: Mihail Abakumov <mikhail.abakumov@ispras.ru>
> Signed-off-by: Pavel Dovgalyuk <dovgaluk@ispras.ru>
> Signed-off-by: Dmitriy Koltunov <koltunov@ispras.ru>
> ---
>  include/exec/windbgstub-utils.h |   11 +++++++++++
>  windbgstub.c                    |   30 ++++++++++++++++++++++++++++++
>  2 files changed, 41 insertions(+)
>
> diff --git a/include/exec/windbgstub-utils.h b/include/exec/windbgstub-utils.h
> index 42dbca1e22..2d74fb847a 100755
> --- a/include/exec/windbgstub-utils.h
> +++ b/include/exec/windbgstub-utils.h
> @@ -48,6 +48,17 @@ typedef struct InitedAddr {
>      bool is_init;
>  } InitedAddr;
>
> +typedef struct PacketData {
> +    union {
> +        struct {
> +            DBGKD_MANIPULATE_STATE64 m64;
> +            uint8_t extra[PACKET_MAX_SIZE - sizeof(DBGKD_MANIPULATE_STATE64)];

nit:
  uint8_t extra[0];

The buf field below already defines the size and in a more readable way.

> +        };
> +        uint8_t buf[PACKET_MAX_SIZE];
> +    };
> +    uint16_t extra_size;
> +} PacketData;
> +
>  InitedAddr *windbg_get_KPCR(void);
>  InitedAddr *windbg_get_version(void);
>
> diff --git a/windbgstub.c b/windbgstub.c
> index e9aabd807b..395f244d4f 100755
> --- a/windbgstub.c
> +++ b/windbgstub.c
> @@ -19,6 +19,36 @@
>  #include "sysemu/kvm.h"
>  #include "sysemu/reset.h"
>
> +typedef enum ParsingState {
> +    STATE_LEADER,
> +    STATE_PACKET_TYPE,
> +    STATE_PACKET_BYTE_COUNT,
> +    STATE_PACKET_ID,
> +    STATE_PACKET_CHECKSUM,
> +    STATE_PACKET_DATA,
> +    STATE_TRAILING_BYTE,
> +} ParsingState;
> +
> +typedef enum ParsingResult {
> +    RESULT_NONE,
> +    RESULT_BREAKIN_BYTE,
> +    RESULT_UNKNOWN_PACKET,
> +    RESULT_CONTROL_PACKET,
> +    RESULT_DATA_PACKET,
> +    RESULT_ERROR,
> +} ParsingResult;
> +
> +typedef struct ParsingContext {
> +    /* index in the current buffer,
> +       which depends on the current state */
> +    int index;
> +    ParsingState state;
> +    ParsingResult result;
> +    KD_PACKET packet;
> +    PacketData data;
> +    const char *name;
> +} ParsingContext;
> +
>  typedef struct WindbgState {
>      bool is_loaded;
>
>
