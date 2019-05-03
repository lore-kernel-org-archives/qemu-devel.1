Received: from eggs.gnu.org ([209.51.188.92]:45869)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hMay1-0005bn-LU
	for qemu-devel@nongnu.org; Fri, 03 May 2019 12:23:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hMaxy-0007RK-Ta
	for qemu-devel@nongnu.org; Fri, 03 May 2019 12:23:21 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54534)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hMaxy-0007Pr-DW
	for qemu-devel@nongnu.org; Fri, 03 May 2019 12:23:18 -0400
Received: by mail-wm1-f67.google.com with SMTP id b10so7799647wmj.4
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 09:23:18 -0700 (PDT)
References: <20190503002206.9751-1-driver1998@foxmail.com>
	<20190503003618.10089-1-driver1998@foxmail.com>
	<aa0dce0b-1be0-7247-8f81-c4f265ba0009@redhat.com>
	<CAFEAcA9a8oQHe+cbSotO+BR2-iqgKOBV5Pg4n1aOBY7_tnvqFg@mail.gmail.com>
	<CAJ+F1CL+2YGHMZteU74y9a61rW6fXLDxcb4KGzPBEAL6878Ujg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <a6456256-cda6-0604-6602-2102d47ac006@redhat.com>
Date: Fri, 3 May 2019 18:23:15 +0200
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CL+2YGHMZteU74y9a61rW6fXLDxcb4KGzPBEAL6878Ujg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 1/4] QEMU_PACKED: Remove gcc_struct
 attribute in Windows non x86 targets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, qemu trival <qemu-trivial@nongnu.org>, Stefan Weil <sw@weilnetz.de>, QEMU Developers <qemu-devel@nongnu.org>, Cao Jiaxi <driver1998@foxmail.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>

On 5/3/19 5:56 PM, Marc-André Lureau wrote:
> Hi
> 
> Le ven. 3 mai 2019 à 17:23, Peter Maydell <peter.maydell@linaro.org> a
> écrit :
> 
>> On Fri, 3 May 2019 at 06:07, Thomas Huth <thuth@redhat.com> wrote:
>>>
>>> On 03/05/2019 02.36, Cao Jiaxi wrote:
>>>> gcc_struct is for x86 only, and it generates an warning on ARM64
>> Clang/MinGW targets.
>>>>
>>>> Signed-off-by: Cao Jiaxi <driver1998@foxmail.com>
>>>> ---
>>>>  contrib/libvhost-user/libvhost-user.h | 2 +-
>>>>  include/qemu/compiler.h               | 2 +-
>>>>  scripts/cocci-macro-file.h            | 7 ++++++-
>>>>  slirp/src/util.h                      | 2 +-
>>>>  4 files changed, 9 insertions(+), 4 deletions(-)
>>
>>>> diff --git a/slirp/src/util.h b/slirp/src/util.h
>>>> index 01f1e0e068..278828fe3f 100644
>>>> --- a/slirp/src/util.h
>>>> +++ b/slirp/src/util.h
>>>> @@ -43,7 +43,7 @@
>>>>  #include <netinet/in.h>
>>>>  #endif
>>>>
>>>> -#if defined(_WIN32)
>>>> +#if defined(_WIN32) && (defined(__x86_64__) || defined(__i386__))
>>>>  # define SLIRP_PACKED __attribute__((gcc_struct, packed))
>>>>  #else
>>>>  # define SLIRP_PACKED __attribute__((packed))
>>>>
>>>
>>> The slirp code is currently on its way into a separate module, so you
>>> might need to provide that hunk to the libslirp folks again... I'm
>>> putting the slirp maintainers on CC:, maybe they can pick it up from
>> here.
>>
>> Yes, the slirp module has now landed in master, so this patch
>> definitely needs to be split into two. I've kept in my
>> target-arm.next tree the parts which are applicable to
>> the QEMU repo itself (ie everything except the slirp/ change),
>> so we just need a new patch for the slirp submodule part.
>>
>> Marc-André, Samuel -- what's the process for submitting and
>> getting reviewed changes to the slirp submodule now it's a
>> separate project ?
>>
> 
> It's hosted on gitlab.freedesktop.org, with some CI. It's fine to send
> patches on qemu devel, as long as Samuel or I are in CC. But in the long
> term, I think gitlab MR will be favoured (after a while using it, I think
> gitlab is better than ML for patches & bug tracking tbh)

Except when working offline (or with poor intermittent link).
