Received: from eggs.gnu.org ([2001:4830:134:3::10]:43369)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cosoz-00063r-1r
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 10:25:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cosou-0000ry-5a
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 10:25:37 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:34642)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cosou-0000ru-0D
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 10:25:32 -0400
Received: by mail-qt0-x244.google.com with SMTP id x35so9643172qtc.1
	for <qemu-devel@nongnu.org>; Fri, 17 Mar 2017 07:25:31 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1489738282-28383-1-git-send-email-kraxel@redhat.com>
	<CAJ+F1CLfeZUjUUqiaeXZpUsQBcsX1Cips=HQj=5MMKbD+UxboA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <6a76ca9d-10cf-1de9-7430-5b3eb5e15aa2@amsat.org>
Date: Fri, 17 Mar 2017 11:25:27 -0300
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CLfeZUjUUqiaeXZpUsQBcsX1Cips=HQj=5MMKbD+UxboA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] ui/egl-helpers: fix egl 1.5 display init
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: hdegoede@redhat.com, Frediano Ziglio <fziglio@redhat.com>

On 03/17/2017 05:53 AM, Marc-André Lureau wrote:
> On Fri, Mar 17, 2017 at 12:12 PM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
>> Unfortunaly switching to getPlatformDisplayEXT isn't as easy as
>> implemented by 0ea1523fb6703aa0dcd65e66b59e96fec028e60a.  See the
>> longish comment for the complete story.
>>
>> Cc: Frediano Ziglio <fziglio@redhat.com>
>> Suggested-by: Hans de Goede <hdegoede@redhat.com>
>> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>> ---
>
>
>
> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

>>  ui/egl-helpers.c | 53
>> +++++++++++++++++++++++++++++++++++++++++++++++------
>>  1 file changed, 47 insertions(+), 6 deletions(-)
>>
>> diff --git a/ui/egl-helpers.c b/ui/egl-helpers.c
>> index 584dd1b..48686cf 100644
>> --- a/ui/egl-helpers.c
>> +++ b/ui/egl-helpers.c
>> @@ -192,6 +192,51 @@ EGLSurface qemu_egl_init_surface_x11(EGLContext ectx,
>> Window win)
>>
>>  /* ----------------------------------------------------------------------
>> */
>>
>> +/*
>> + * Taken from glamor_egl.h from the Xorg xserver, which is MIT licensed
>> + *
>> + * Create an EGLDisplay from a native display type. This is a little
>> quirky
>> + * for a few reasons.
>> + *
>> + * 1: GetPlatformDisplayEXT and GetPlatformDisplay are the API you want to
>> + * use, but have different function signatures in the third argument; this
>> + * happens not to matter for us, at the moment, but it means epoxy won't
>> alias
>> + * them together.
>> + *
>> + * 2: epoxy 1.3 and earlier don't understand EGL client extensions, which
>> + * means you can't call "eglGetPlatformDisplayEXT" directly, as the
>> resolver
>> + * will crash.
>> + *
>> + * 3: You can't tell whether you have EGL 1.5 at this point, because
>> + * eglQueryString(EGL_VERSION) is a property of the display, which we
>> don't
>> + * have yet. So you have to query for extensions no matter what.
>> Fortunately
>> + * epoxy_has_egl_extension _does_ let you query for client extensions, so
>> + * we don't have to write our own extension string parsing.
>> + *
>> + * 4. There is no EGL_KHR_platform_base to complement the EXT one, thus
>> one
>> + * needs to know EGL 1.5 is supported in order to use the
>> eglGetPlatformDisplay
>> + * function pointer.
>> + * We can workaround this (circular dependency) by probing for the EGL 1.5
>> + * platform extensions (EGL_KHR_platform_gbm and friends) yet it doesn't
>> seem
>> + * like mesa will be able to adverise these (even though it can do EGL
>> 1.5).
>> + */
>> +static EGLDisplay qemu_egl_get_display(void *native)
>> +{
>> +#ifdef EGL_PLATFORM_GBM_MESA
>> +    /* In practise any EGL 1.5 implementation would support the EXT
>> extension */
>> +    if (epoxy_has_egl_extension(NULL, "EGL_EXT_platform_base")) {
>> +        PFNEGLGETPLATFORMDISPLAYEXTPROC getPlatformDisplayEXT =
>> +            (void *) eglGetProcAddress("eglGetPlatformDisplayEXT");
>> +        if (getPlatformDisplayEXT) {
>> +            return getPlatformDisplayEXT(EGL_PLATFORM_GBM_MESA, native,
>> NULL);
>> +        }
>> +    }
>> +#endif
>> +
>> +    /* fallback */
>> +    return eglGetDisplay(native);
>> +}
>> +
>>  int qemu_egl_init_dpy(EGLNativeDisplayType dpy, bool gles, bool debug)
>>  {
>>      static const EGLint conf_att_gl[] = {
>> @@ -222,12 +267,8 @@ int qemu_egl_init_dpy(EGLNativeDisplayType dpy, bool
>> gles, bool debug)
>>          setenv("LIBGL_DEBUG", "verbose", true);
>>      }
>>
>> -    egl_dbg("eglGetDisplay (dpy %p) ...\n", dpy);
>> -#ifdef EGL_MESA_platform_gbm
>> -    qemu_egl_display = eglGetPlatformDisplayEXT(EGL_PLATFORM_GBM_MESA,
>> dpy, NULL);
>> -#else
>> -    qemu_egl_display = eglGetDisplay(dpy);
>> -#endif
>> +    egl_dbg("qemu_egl_get_display (dpy %p) ...\n", dpy);
>> +    qemu_egl_display = qemu_egl_get_display(dpy);
>>      if (qemu_egl_display == EGL_NO_DISPLAY) {
>>          error_report("egl: eglGetDisplay failed");
>>          return -1;
>> --
>> 1.8.3.1
>>
>>
>> --
> Marc-André Lureau
>
