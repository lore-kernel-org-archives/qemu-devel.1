Received: from eggs.gnu.org ([2001:4830:134:3::10]:46084)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hdegoede@redhat.com>) id 1cnMoH-0008CJ-5d
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 06:02:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hdegoede@redhat.com>) id 1cnMoC-00016a-7f
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 06:02:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52580)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <hdegoede@redhat.com>) id 1cnMoB-00015i-VA
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 06:02:32 -0400
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 14D0C8553E
	for <qemu-devel@nongnu.org>; Mon, 13 Mar 2017 10:02:32 +0000 (UTC)
References: <20170220095055.4234-1-fziglio@redhat.com>
	<cf298d66-cc10-0cf5-b5d1-b36c20fb05f7@redhat.com>
	<1376895221.1392101.1489397950418.JavaMail.zimbra@redhat.com>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <33196ff6-be65-9a08-75da-feeffb9c080a@redhat.com>
Date: Mon, 13 Mar 2017 11:02:28 +0100
MIME-Version: 1.0
In-Reply-To: <1376895221.1392101.1489397950418.JavaMail.zimbra@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] egl-helpers: Support newer MESA versions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Frediano Ziglio <fziglio@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, David Airlie <airlied@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <mlureau@redhat.com>, qemu-devel@nongnu.org, Cole Robinson <crobinso@redhat.com>

Hi,

On 13-03-17 10:39, Frediano Ziglio wrote:
>>
>> <resend with some more people added to the Cc>
>>
>> Hi,
>>
>> On 20-02-17 10:50, Frediano Ziglio wrote:
>>> According to
>>> https://www.khronos.org/registry/EGL/extensions/MESA/EGL_MESA_platform_gbm.txt
>>> if MESA_platform_gbm is supported display should be initialized
>>> from a GBM handle using eglGetPlatformDisplayEXT.
>>>
>>> Signed-off-by: Frediano Ziglio <fziglio@redhat.com>
>>> ---
>>> This should fix
>>> http://www.spinics.net/linux/fedora/libvir/msg142837.html
>>>
>>> Tested on Fedora rawhide.
>>> ---
>>>  ui/egl-helpers.c | 4 ++++
>>>  1 file changed, 4 insertions(+)
>>>
>>> diff --git a/ui/egl-helpers.c b/ui/egl-helpers.c
>>> index cd24568..964c5a5 100644
>>> --- a/ui/egl-helpers.c
>>> +++ b/ui/egl-helpers.c
>>> @@ -219,7 +219,11 @@ int qemu_egl_init_dpy(EGLNativeDisplayType dpy, bool
>>> gles, bool debug)
>>>      }
>>>
>>>      egl_dbg("eglGetDisplay (dpy %p) ...\n", dpy);
>>> +#ifdef EGL_MESA_platform_gbm
>>> +    qemu_egl_display = eglGetPlatformDisplayEXT(EGL_PLATFORM_GBM_MESA,
>>> dpy, NULL);
>>> +#else
>>>      qemu_egl_display = eglGetDisplay(dpy);
>>> +#endif
>>>      if (qemu_egl_display == EGL_NO_DISPLAY) {
>>>          error_report("egl: eglGetDisplay failed");
>>>          return -1;
>>>
>>
>> That fix is incomplete, you need some magic to work properly on older libGL
>> versions.
>>
>> Attached is a (compile tested only) proper patch. I do not have a qemu git
>> clone
>> handy atm, so this is not a git format-patch patch, it is against the Fedora
>> Rawhide
>> srpm. I've a test build with these patches here:
>>
>> https://fedorapeople.org/~jwrdegoede/qemu-glvnd/
>>
>> I was planning on doing a git clone qemu and send a proper patch after I got
>> some
>> testing feedback. Feel free to use this as a base for a v2 of your patch.
>>
>> Regards,
>>
>> Hans
>>
>
> Wouldn't be easier to call the "old" eglGetDisplay if eglGetPlatformDisplayEXT
> returns EGL_NO_DISPLAY ? Kind of

With libEGL you (unfortunately) cannot assume that the lib your building
against is the lib you will run against.

>
>      egl_dbg("eglGetDisplay (dpy %p) ...\n", dpy);
> -    qemu_egl_display = eglGetDisplay(dpy);
> +#ifdef EGL_MESA_platform_gbm
> +    qemu_egl_display = eglGetPlatformDisplayEXT(EGL_PLATFORM_GBM_MESA, dpy, NULL);

So this may very well lead to a runtime unresolved symbol error. IOW you really
need to do the special magic dance I'm afraid.

> +#else
> +    qemu_egl_display = EGL_NO_DISPLAY;
> +#endif
> +    if (qemu_egl_display == EGL_NO_DISPLAY)
> +        qemu_egl_display = eglGetDisplay(dpy);
>      if (qemu_egl_display == EGL_NO_DISPLAY) {
>          error_report("egl: eglGetDisplay failed");
>          return -1;
>
> Your patch should not even compile on older system which does not define
> EGL_PLATFORM_GBM_MESA.

True, so I guess my patch needs an #ifdef around the new qemu_egl_get_display()
function and then on the actual call site #ifdef #else #endif like your patch,
but instead of directly calling eglGetPlatformDisplayEXT call qemu_egl_get_display.

> I tested my patch and works on both rawhide and FC25 (with very recent Mesa version)

mesa is not the problem, it is say running qemu on ARM and using some binary
driver libEGL.so which is the problem, without the dance that will result in
a runtime dynamic linker error and qemu aborting.

Regards,

Hans
