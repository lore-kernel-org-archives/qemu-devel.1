Received: from eggs.gnu.org ([209.51.188.92]:60638)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hLZzE-00072a-3k
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 17:08:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hLZzD-0004tD-5o
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 17:08:24 -0400
References: <cover.1556650594.git.alistair.francis@wdc.com>
	<6bfa446eb7c351b5d867eb4158198231af724b11.1556650594.git.alistair.francis@wdc.com>
	<d4dd0758-64af-e249-1f1b-b52af014b404@vivier.eu>
	<CAKmqyKNx2r93-ASC0dAZJvu_36dV69sRj92-m6G9zXqLdc2sag@mail.gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <3253f092-d227-b56a-3e15-febf6646e5f9@vivier.eu>
Date: Tue, 30 Apr 2019 23:07:56 +0200
MIME-Version: 1.0
In-Reply-To: <CAKmqyKNx2r93-ASC0dAZJvu_36dV69sRj92-m6G9zXqLdc2sag@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1 5/5] linux-user/elfload: Fix GCC 9 build
 warnings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair23@gmail.com>
Cc: Alistair Francis <Alistair.Francis@wdc.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "kraxel@redhat.com" <kraxel@redhat.com>, "berrange@redhat.com" <berrange@redhat.com>, "riku.voipio@iki.fi" <riku.voipio@iki.fi>, "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>

Le 30/04/2019 à 23:01, Alistair Francis a écrit :
> On Tue, Apr 30, 2019 at 1:36 PM Laurent Vivier <laurent@vivier.eu> wrote:
>>
>> Le 30/04/2019 à 22:09, Alistair Francis a écrit :
>>> Fix this warning when building with GCC9 on Fedora 30:
>>> In function ‘strncpy’,
>>>     inlined from ‘fill_psinfo’ at /home/alistair/qemu/linux-user/elfload.c:3208:12,
>>>     inlined from ‘fill_note_info’ at /home/alistair/qemu/linux-user/elfload.c:3390:5,
>>>     inlined from ‘elf_core_dump’ at /home/alistair/qemu/linux-user/elfload.c:3539:9:
>>> /usr/include/bits/string_fortified.h:106:10: error: ‘__builtin_strncpy’ specified bound 16 equals destination size [-Werror=stringop-truncation]
>>>   106 |   return __builtin___strncpy_chk (__dest, __src, __len, __bos (__dest));
>>>       |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>
>>> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
>>> ---
>>>  linux-user/elfload.c | 4 ++--
>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
>>> index c1a26021f8..cbb7fc10fa 100644
>>> --- a/linux-user/elfload.c
>>> +++ b/linux-user/elfload.c
>>> @@ -3206,7 +3206,7 @@ static int fill_psinfo(struct target_elf_prpsinfo *psinfo, const TaskState *ts)
>>
>>        /*
>>         * Using strncpy here is fine: at max-length,
>>>       * this field is not NUL-terminated.
>>>       */>      (void) strncpy(psinfo->pr_fname, base_filename,
>>> -                   sizeof(psinfo->pr_fname));
>>> +                   sizeof(psinfo->pr_fname) - 1);
>>
>> Read the comment above :)
> 
> GCC can't read the comment though. The only other option I can think
> of is using a pragma, which I avoided using unless I had to. Would you
> prefer a pragma here? Or do you have a better solution?
> 

perhaps:

memcpy(psinfo->pr_fname, base_filename, MIN(strlen(base_filename) + 1, sizeof(psinfo->pr_fname));

?

Thanks,
Laurent
