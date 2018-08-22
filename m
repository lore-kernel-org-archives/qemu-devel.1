Received: from eggs.gnu.org ([2001:4830:134:3::10]:56403)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1fsVqs-0008H2-JO
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 12:19:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1fsVqp-0005ai-F9
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 12:19:22 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:55990)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1fsVqp-0005a2-2v
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 12:19:19 -0400
Received: by mail-it0-f68.google.com with SMTP id d10-v6so3554404itj.5
	for <qemu-devel@nongnu.org>; Wed, 22 Aug 2018 09:19:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4a0122ad-52eb-d241-709b-76038e65a858@redhat.com>
References: <20180822142956.6859-1-marcandre.lureau@redhat.com>
	<20180822142956.6859-4-marcandre.lureau@redhat.com>
	<20180822154611.GN12750@redhat.com>
	<CAMxuvawr-ooy91ZHTHx+aLYhgpH5gBoAKQz_pvF=kcHzadjLog@mail.gmail.com>
	<4a0122ad-52eb-d241-709b-76038e65a858@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 22 Aug 2018 18:19:16 +0200
Message-ID: <CAMxuvaxEM4DjCq=AKEEg3cTJzoo1PX9N5R6p1_+wvCY=TMtgqQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 3/3] seccomp: set the seccomp filter to
 all threads
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, Paul Moore <pmoore@redhat.com>, Eduardo Otubo <otubo@redhat.com>, qemu-devel <qemu-devel@nongnu.org>

Hi

On Wed, Aug 22, 2018 at 6:07 PM, Eric Blake <eblake@redhat.com> wrote:
> On 08/22/2018 10:58 AM, Marc-Andr=C3=A9 Lureau wrote:
>
>>> At this point you might as well not bother using seccomp at all. The
>>> thread that is confined merely needs to scribble something into the
>>> stack of the unconfined thread and now it can do whatever it wants.
>>
>>
>> Actually, that message is incorrect, it should rather be "not all
>> threads will be filtered" (as described in commit message).
>>
>>> IMHO we need to find a way to get the policy to apply to those other
>>> threads.
>>
>>
>> That's what the patch is about ;)
>
>
> In other words, this patch is patching the gaping security hole that alre=
ady
> exists, but...
>
>>>> +++ b/qemu-options.hx
>>>> @@ -3864,6 +3864,8 @@ Disable set*uid|gid system calls
>>>>   Disable *fork and execve
>>>>   @item resourcecontrol=3D@var{string}
>>>>   Disable process affinity and schedular priority
>>>> +@item tsync=3D@var{bool}
>>>> +Apply seccomp filter to all threads (default is auto, and will warn i=
f
>>>> fail)
>>>
>>>
>>> IMHO this should never exist, as setting "tsync" to anything other
>>> than "yes", is akin to just running without any sandbox.
>>
>>
>> Then we should just fail -sandbox on those systems.
>
>
> ...leaving the backdoor open.  Yes, we should instead fix things to hard
> fail when -sandbox cannot fully protect the process, rather than adding a
> tsync=3Doff backdoor to permit execution in spite of the insecurity.

Ok, -sandbox will now require libseccomp 2.2.0 (not available in
Debian oldstable - so it will fail at configure time) and kernel >=3D
3.17 (error during start). If that sounds ok, I'll update the series.
