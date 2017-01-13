Received: from eggs.gnu.org ([2001:4830:134:3::10]:46301)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cS2BN-00027p-K8
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 08:46:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cS2BM-00048d-QI
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 08:46:17 -0500
Received: from mail-vk0-x231.google.com ([2607:f8b0:400c:c05::231]:34012)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cS2BM-00048E-8W
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 08:46:16 -0500
Received: by mail-vk0-x231.google.com with SMTP id r136so33489848vke.1
	for <qemu-devel@nongnu.org>; Fri, 13 Jan 2017 05:46:16 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <24cb80e0-93bb-d4fb-0ba9-9f99397ec121@weilnetz.de>
References: <1484295285-8809-1-git-send-email-kraxel@redhat.com>
	<24cb80e0-93bb-d4fb-0ba9-9f99397ec121@weilnetz.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 13 Jan 2017 13:45:54 +0000
Message-ID: <CAFEAcA-zJucSaL+euDS=7e3W3ROgJ1MN2Pe8N+gA9YiAWhVK_w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH] sdl2: fix build failure on windows
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Weil <sw@weilnetz.de>
Cc: Gerd Hoffmann <kraxel@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Samuel Thibault <samuel.thibault@gnu.org>

On 13 January 2017 at 08:27, Stefan Weil <sw@weilnetz.de> wrote:
> Am 13.01.2017 um 09:14 schrieb Gerd Hoffmann:
>> Cc: Stefan Weil <sw@weilnetz.de>
>> Cc: Samuel Thibault <samuel.thibault@gnu.org>
>> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>> ---
>>  ui/sdl2.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/ui/sdl2.c b/ui/sdl2.c
>> index 9a79b17..91fb111 100644
>> --- a/ui/sdl2.c
>> +++ b/ui/sdl2.c
>> @@ -817,9 +817,15 @@ void sdl_display_init(DisplayState *ds, int full_screen, int no_frame)
>>          sdl2_console[i].dcl.con = con;
>>          register_displaychangelistener(&sdl2_console[i].dcl);
>>
>> +#if defined(SDL_VIDEO_DRIVER_WINDOWS) || defined(SDL_VIDEO_DRIVER_X11)
>>          if (SDL_GetWindowWMInfo(sdl2_console[i].real_window, &info)) {
>> +#if defined(SDL_VIDEO_DRIVER_WINDOWS)
>> +            qemu_console_set_window_id(con, (uintptr_t)info.info.win.window);
>> +#elif defined(SDL_VIDEO_DRIVER_X11)
>>              qemu_console_set_window_id(con, info.info.x11.window);
>> +#endif
>>          }
>> +#endif
>>      }
>>
>>      /* Load a 32x32x4 image. White pixels are transparent. */
>
>
> Thanks.
>
> Reviewed-by: Stefan Weil <sw@weilnetz.de>

Thanks; applied to master as a buildfix.

-- PMM
