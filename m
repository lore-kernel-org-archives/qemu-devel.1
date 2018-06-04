Received: from eggs.gnu.org ([2001:4830:134:3::10]:50211)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fPqLs-0008Ja-HQ
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 10:20:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fPqLo-0008Rz-Gf
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 10:20:52 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:33360)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fPqLo-0008Rb-CE
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 10:20:48 -0400
Received: by mail-qk0-x244.google.com with SMTP id h7-v6so17895100qkm.0
	for <qemu-devel@nongnu.org>; Mon, 04 Jun 2018 07:20:48 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170724182751.18261-1-f4bug@amsat.org>
	<20170724182751.18261-27-f4bug@amsat.org>
	<cc23ddee-ad10-74ef-874c-6ed1ef485d2e@vivier.eu>
	<811e6e16-d9d7-3b96-7d43-f9d7b6ace063@amsat.org>
	<d93b02bd-6776-497a-2dc0-aed009be380b@vivier.eu>
	<cb4c699f-897e-146e-6435-bfb0597aee75@vivier.eu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <e973502f-6c20-d303-d758-c3f1c1e6036c@amsat.org>
Date: Mon, 4 Jun 2018 11:20:42 -0300
MIME-Version: 1.0
In-Reply-To: <cb4c699f-897e-146e-6435-bfb0597aee75@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for 2.10 26/35] linux-user: use is_error()
 to avoid warnings and make the code clearer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org

On 06/03/2018 08:33 PM, Laurent Vivier wrote:
> Le 29/05/2018 à 17:19, Laurent Vivier a écrit :
>> Le 29/05/2018 à 16:25, Philippe Mathieu-Daudé a écrit :
>>> Hi Laurent,
>>
>> Hi Philippe,
>>
>>> On 07/24/2017 04:16 PM, Laurent Vivier wrote:
>>>> Le 24/07/2017 à 20:27, Philippe Mathieu-Daudé a écrit :
>>>>> linux-user/flatload.c:740:9: warning: Loss of sign in implicit conversion
>>>>>     if (res > (unsigned long)-4096)
>>>>>         ^~~
>>>>>
>>>>> Reported-by: Clang Static Analyzer
>>>>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>>>>
>>>> Reviewed-by: Laurent Vivier <laurent@vivier.eu>
>>>>
>>>>> ---
>>>>>  linux-user/flatload.c | 15 +++++++++------
>>>>>  1 file changed, 9 insertions(+), 6 deletions(-)
>>>>>
>>>>> diff --git a/linux-user/flatload.c b/linux-user/flatload.c
>>>>> index a35a560904..10c529910f 100644
>>>>> --- a/linux-user/flatload.c
>>>>> +++ b/linux-user/flatload.c
>>>>> @@ -224,8 +224,9 @@ static int decompress_exec(
>>>>>  		ret = bprm->file->f_op->read(bprm->file, buf, LBUFSIZE, &fpos);
>>>>>  		if (ret <= 0)
>>>>>  			break;
>>>>> -		if (ret >= (unsigned long) -4096)
>>>>> +                if (is_error(ret)) {
>>>>>  			break;
>>>>> +                }
>>>>>  		len -= ret;
>>>>>  
>>>>>  		strm.next_in = buf;
>>>>> @@ -283,8 +284,7 @@ calc_reloc(abi_ulong r, struct lib_info *p, int curid, int internalp)
>>>>>                      "in same module (%d != %d)\n",
>>>>>                      (unsigned) r, curid, id);
>>>>>              goto failed;
>>>>> -        } else if ( ! p[id].loaded &&
>>>>> -                    load_flat_shared_library(id, p) > (unsigned long) -4096) {
>>>>> +        } else if (!p[id].loaded && is_error(load_flat_shared_library(id, p))) {
>>>>>              fprintf(stderr, "BINFMT_FLAT: failed to load library %d\n", id);
>>>>>              goto failed;
>>>>>          }
>>>>> @@ -523,9 +523,10 @@ static int load_flat_file(struct linux_binprm * bprm,
>>>>>                  fpos = 0;
>>>>>                  result = bprm->file->f_op->read(bprm->file,
>>>>>                                  (char *) textpos, text_len, &fpos);
>>>>> -                if (result < (unsigned long) -4096)
>>>>> +                if (!is_error(result)) {
>>>>>                          result = decompress_exec(bprm, text_len, (char *) datapos,
>>>>>                                           data_len + (relocs * sizeof(unsigned long)), 0);
>>>>> +                }
>>>>>          }
>>>>>          else
>>>>>  #endif
>>>>> @@ -693,8 +694,9 @@ static int load_flat_shared_library(int id, struct lib_info *libs)
>>>>>  
>>>>>  	res = prepare_binprm(&bprm);
>>>>>  
>>>>> -	if (res <= (unsigned long)-4096)
>>>>> +        if (!is_error(res)) {
>>>>>  		res = load_flat_file(&bprm, libs, id, NULL);
>>>>> +        }
>>>>>  	if (bprm.file) {
>>>>>  		allow_write_access(bprm.file);
>>>>>  		fput(bprm.file);
>>>>> @@ -737,8 +739,9 @@ int load_flt_binary(struct linux_binprm *bprm, struct image_info *info)
>>>>>  
>>>>>  
>>>>>      res = load_flat_file(bprm, libinfo, 0, &stack_len);
>>>>> -    if (res > (unsigned long)-4096)
>>>>> +    if (is_error(res)) {
>>>>>              return res;
>>>>> +    }
>>>>>  
>>>>>      /* Update data segment pointers for all libraries */
>>>>>      for (i=0; i<MAX_SHARED_LIBS; i++) {
>>>>>
>>>
>>> Can you take this via your linux-user tree?
>>>
>>
>> Applied, thanks.
> 
> Unapplied, it needs a rebase:

No rebase required, it just need the previous patch applied too :)
But I didn't think of explicit it :/
Can you take both of them directly or do you prefer I RESEND?

> 
> qemu/linux-user/flatload.c: In function 'load_flt_binary':
> qemu/linux-user/flatload.c:742:9: error: implicit declaration of
> function 'is_error'; did you mean 'g_error'?
> [-Werror=implicit-function-declaration]
>      if (is_error(res)) {
>          ^~~~~~~~
>          g_error
> qemu/linux-user/flatload.c:742:9: error: nested extern declaration of
> 'is_error' [-Werror=nested-externs]
> 
> Thanks,
> Laurent
> 
> 
> 
