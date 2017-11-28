Received: from eggs.gnu.org ([2001:4830:134:3::10]:37606)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1eJgYG-0000iw-Dt
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 09:07:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1eJgYC-0002uI-Ax
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 09:07:56 -0500
Received: from mail-vk0-f67.google.com ([209.85.213.67]:43557)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <lprosek@redhat.com>) id 1eJgYC-0002u3-73
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 09:07:52 -0500
Received: by mail-vk0-f67.google.com with SMTP id u84so59558vke.10
	for <qemu-devel@nongnu.org>; Tue, 28 Nov 2017 06:07:52 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <151127332036.6888.3168353085464706816.stgit@Misha-PC.lan02.inno>
References: <151127322955.6888.16198535123422076171.stgit@Misha-PC.lan02.inno>
	<151127332036.6888.3168353085464706816.stgit@Misha-PC.lan02.inno>
From: Ladi Prosek <lprosek@redhat.com>
Date: Tue, 28 Nov 2017 15:07:51 +0100
Message-ID: <CABdb737gR=_KhqLDb0Fv2Q63CB4GFrki3igTDMErCA8y+Gmq5w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 15/45] windbg: sized data buffer
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
> Defined useful sized data buffer. It contains pointer to data and size of this data. Also, defined some macros for init and free.
>
> Signed-off-by: Mihail Abakumov <mikhail.abakumov@ispras.ru>
> Signed-off-by: Pavel Dovgalyuk <dovgaluk@ispras.ru>
> Signed-off-by: Dmitriy Koltunov <koltunov@ispras.ru>
> ---
>  include/exec/windbgstub-utils.h |   16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/include/exec/windbgstub-utils.h b/include/exec/windbgstub-utils.h
> index 6ce870beb1..b729cd604e 100755
> --- a/include/exec/windbgstub-utils.h
> +++ b/include/exec/windbgstub-utils.h
> @@ -67,6 +67,22 @@ typedef struct PacketData {
>      uint16_t extra_size;
>  } PacketData;
>
> +typedef struct SizedBuf {
> +    uint8_t *data;
> +    size_t size;
> +} SizedBuf;
> +
> +#define SBUF_INIT(buf, mem_ptr, len) do { \
> +    buf.data = mem_ptr;                   \
> +    buf.size = len;                       \
> +} while (false)
> +#define SBUF_MALLOC(buf, size) SBUF_INIT(buf, g_malloc0(size), size)
> +#define SBUF_FREE(buf) do { \
> +    g_free(buf.data);       \
> +    buf.data = NULL;        \
> +    buf.size = 0;           \
> +} while (false)
> +

I don't think that this is necessary. These macros are used for ~240
byte data structures and the points where they are allocated and freed
are super close together.

I'd just put them on the stack in the callers of kd_gen_exception_sc()
and kd_gen_load_symbols_sc() (only one caller each) and remove this
patch.

>  InitedAddr *windbg_get_KPCR(void);
>  InitedAddr *windbg_get_version(void);
>
>
