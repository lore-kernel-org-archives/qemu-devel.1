Received: from eggs.gnu.org ([2001:4830:134:3::10]:53734)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gHHIw-0000cu-8y
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 19:50:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gHHIs-0007FR-Bu
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 19:50:41 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45896)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gHHIr-0007ES-5s
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 19:50:38 -0400
Received: by mail-wr1-f65.google.com with SMTP id n5-v6so10543379wrw.12
	for <qemu-devel@nongnu.org>; Mon, 29 Oct 2018 16:50:36 -0700 (PDT)
References: <1540365080-6844-1-git-send-email-liq3ea@gmail.com>
	<4d64d42a-8727-81aa-6015-a9db92abca76@redhat.com>
	<6afc1723-633c-34af-d5ff-4dea3fbf6b89@redhat.com>
	<CAKXe6SJQUtBRbOtiy1xtt+griLoxc_JOd3D4oKwR9d3B2GCWyQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <1d47f5d7-e85c-44a0-2499-180eac24965e@redhat.com>
Date: Tue, 30 Oct 2018 00:50:32 +0100
MIME-Version: 1.0
In-Reply-To: <CAKXe6SJQUtBRbOtiy1xtt+griLoxc_JOd3D4oKwR9d3B2GCWyQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] fw_cfg_reboot: ensure reboot_time is
 nonegative
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@gmail.com>
Cc: Laszlo Ersek <lersek@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>

On 25/10/18 3:45, Li Qiang wrote:
> Hello Laszlo and Philippe ,
> 
> Thanks for your review,
> 
> 
> 
> Philippe Mathieu-Daudé <philmd@redhat.com <mailto:philmd@redhat.com>> 于 
> 2018年10月25日周四 上午6:56写道：
> 
>     Hi,
> 
>     On 24/10/18 13:35, Laszlo Ersek wrote:
>      > On 10/24/18 09:11, Li Qiang wrote:
>      >> This can avoid setting a negative value to
>      >> etc/boot-fail-wait.
> 
>     Li Qiang, can you add a qtest for this?
> 
> 
> I will try to write one.
> Is it ok to write it without this patch, as the test will be not passed?

It is OK to add the test after the fix, else the test would fail.
But now your test protect from future regressions.

> 
> Thanks,
> Li Qiang
> 
> 
>      >>
>      >> Signed-off-by: Li Qiang <liq3ea@gmail.com <mailto:liq3ea@gmail.com>>
>      >> ---
>      >>   hw/nvram/fw_cfg.c | 15 ++++++++++-----
>      >>   1 file changed, 10 insertions(+), 5 deletions(-)
>      >>
>      >> diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
>      >> index f4a52d8..276dcb1 100644
>      >> --- a/hw/nvram/fw_cfg.c
>      >> +++ b/hw/nvram/fw_cfg.c
>      >> @@ -199,12 +199,17 @@ static void fw_cfg_reboot(FWCfgState *s)
>      >>               reboot_timeout = strtol(p, &p, 10);
>      >>           }
>      >>       }
>      >> -    /* validate the input */
>      >> -    if (reboot_timeout > 0xffff) {
>      >> -        error_report("reboot timeout is larger than 65535,
>     force it to 65535.");
>      >> -        reboot_timeout = 0xffff;
>      >> +
>      >> +    if (reboot_timeout >= 0) {
>      >> +        /* validate the input */
>      >> +        if (reboot_timeout > 0xffff) {
>      >> +            error_report("reboot timeout is larger than 65535,"
>      >> +                         "force it to 65535.");
>      >> +            reboot_timeout = 0xffff;
>      >> +        }
>      >> +        fw_cfg_add_file(s, "etc/boot-fail-wait",
>      >> +                        g_memdup(&reboot_timeout, 4), 4);
>      >>       }
>      >> -    fw_cfg_add_file(s, "etc/boot-fail-wait",
>     g_memdup(&reboot_timeout, 4), 4);
>      >>   }
>      >>
>      >>   static void fw_cfg_write(FWCfgState *s, uint8_t value)
>      >>
>      >
>      > I don't feel strongly about fixing this issue.
>      >
>      > However, if we decide to fix it, we should start with the bare-bones
>      > strtol() call, visible at the top of the context. I'm not
>     up-to-date on
>      > what's the best QEMU helper function for this, but I seem to
>     remember it
>      > checks for trailing garbage, and perhaps even for range. Maybe we
>     should
> 
>     Are you suggesting qemu_strtoul()? I agree this would be cleaner.
> 
> 
> 
> I reference the 'boot_splash_time' in fw_cfg_bootsplash.
> We can also change there.
> 
>      > even use a different (better) option parsing facility thatn
>      > qemu_opt_get(). Adding Eric and Markus.
>      >
>      > Also, I would suggest forcing negative values (that were explicitly
>      > specified) to some sensible positive default, such as 5 seconds
>     or so.
>      >
>      > Thanks
>      > Laszlo
>      >
> 
