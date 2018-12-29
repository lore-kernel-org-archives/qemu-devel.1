Received: from eggs.gnu.org ([208.118.235.92]:60002)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gdNQC-0002iB-AY
	for qemu-devel@nongnu.org; Sat, 29 Dec 2018 17:49:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gdNBa-0008Kn-FL
	for qemu-devel@nongnu.org; Sat, 29 Dec 2018 17:34:31 -0500
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:35728)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gdNBY-0008HF-MR
	for qemu-devel@nongnu.org; Sat, 29 Dec 2018 17:34:26 -0500
Received: by mail-pg1-x544.google.com with SMTP id s198so11416570pgs.2
	for <qemu-devel@nongnu.org>; Sat, 29 Dec 2018 14:34:23 -0800 (PST)
References: <20181228173356.15359-1-philmd@redhat.com>
	<20181228173356.15359-6-philmd@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <9fef1205-7c5b-9a91-e722-de41ebb34b9c@linaro.org>
Date: Sun, 30 Dec 2018 09:34:13 +1100
MIME-Version: 1.0
In-Reply-To: <20181228173356.15359-6-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4 5/5] migration: Use strnlen() for
 fixed-size string
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Juan Quintela <quintela@redhat.com>, David Hildenbrand <david@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

On 12/29/18 4:33 AM, Philippe Mathieu-Daudé wrote:
> GCC 8 introduced the -Wstringop-overflow, which detect buffer overflow
> by string-modifying functions declared in <string.h>, such strncpy(),
> used in global_state_store_running().
> 
> GCC indeed found an incorrect use of strlen(), because this array
> is loaded by VMSTATE_BUFFER(runstate, GlobalState) then parsed
> using qapi_enum_parse which does not get the buffer length.
> 
> Use strnlen() which returns sizeof(s->runstate) if the array is not
> NUL-terminated, assert the size is within range, and enforce the array
> to be NUL-terminated to avoid an overflow in qapi_enum_parse().
> 
> This fixes:
> 
>     CC      migration/global_state.o
>   qemu/migration/global_state.c: In function 'global_state_pre_save':
>   qemu/migration/global_state.c:109:15: error: 'strlen' argument 1 declared attribute 'nonstring' [-Werror=stringop-overflow=]
>        s->size = strlen((char *)s->runstate) + 1;
>                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>   qemu/migration/global_state.c:24:13: note: argument 'runstate' declared here
>        uint8_t runstate[100] QEMU_NONSTRING;
>                ^~~~~~~~
>   cc1: all warnings being treated as errors
>   make: *** [qemu/rules.mak:69: migration/global_state.o] Error 1
> 
> Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  migration/global_state.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
