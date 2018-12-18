Received: from eggs.gnu.org ([2001:4830:134:3::10]:56954)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gZCOB-0001Sp-MB
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 05:14:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gZCO7-0002ri-FR
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 05:14:11 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37746)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gZCO7-0002r6-7f
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 05:14:07 -0500
Received: by mail-wm1-f66.google.com with SMTP id g67so2140618wmd.2
	for <qemu-devel@nongnu.org>; Tue, 18 Dec 2018 02:14:07 -0800 (PST)
References: <20181217224807-mutt-send-email-mst@kernel.org>
	<20181217231145-mutt-send-email-mst@kernel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <e932f9c2-2466-9063-d441-6de9076ac525@redhat.com>
Date: Tue, 18 Dec 2018 11:14:04 +0100
MIME-Version: 1.0
In-Reply-To: <20181217231145-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] sheepdog build warning
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, peter.maydell@linaro.org, qemu-block@nongnu.org, meyering@redhat.com, Jeff Cody <jcody@redhat.com>, Liu Yuan <namei.unix@gmail.com>, MORITA Kazutaka <morita.kazutaka@lab.ntt.co.jp>

Hi Michael,

On 12/18/18 5:16 AM, Michael S. Tsirkin wrote:
> On Mon, Dec 17, 2018 at 11:03:11PM -0500, Michael S. Tsirkin wrote:
>> mingw32 build on fedora fails with this warning:
>>
>> /scm/qemu/block/sheepdog.c: In function 'find_vdi_name':
>> /scm/qemu/block/sheepdog.c:1239:5: error: 'strncpy' specified bound 256 equals destination size [-Werror=stringop-truncation]
>>      strncpy(buf + SD_MAX_VDI_LEN, tag, SD_MAX_VDI_TAG_LEN);
>>      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> cc1: all warnings being treated as errors
>> make: *** [/scm/qemu/rules.mak:69: block/sheepdog.o] Error 1
>> make: *** Waiting for unfinished jobs....
>>
>>
>> Reading the code one sees it's working as intended:
>>
>>
>> static int find_vdi_name(BDRVSheepdogState *s, const char *filename,
>>                          uint32_t snapid, const char *tag, uint32_t *vid,
>>                          bool lock, Error **errp)
>> {
>>     int ret, fd;
>>     SheepdogVdiReq hdr;
>>     SheepdogVdiRsp *rsp = (SheepdogVdiRsp *)&hdr;
>>     unsigned int wlen, rlen = 0;
>>     char buf[SD_MAX_VDI_LEN + SD_MAX_VDI_TAG_LEN];
>>
>>     fd = connect_to_sdog(s, errp);
>>     if (fd < 0) {
>>         return fd;
>>     }
>>
>>     /* This pair of strncpy calls ensures that the buffer is zero-filled,
>>      * which is desirable since we'll soon be sending those bytes, and
>>      * don't want the send_req to read uninitialized data.
>>      */
>>     strncpy(buf, filename, SD_MAX_VDI_LEN);
>>     strncpy(buf + SD_MAX_VDI_LEN, tag, SD_MAX_VDI_TAG_LEN);
>>
>>
>> .....
>>
>> }
>>
>>
>>
>> so this seems to be the case of GCC developers deciding that
>> strncpy is simply a bad API and a correct use of it should be
>> warned against.
>>
>> I propose either
>>
>> 1. simply adding
>>
>> #pragma GCC diagnostic ignored "-Wstringop-truncation"
>>
>> in osdep.
>>
>> 2. adding an inline wrapper with said pragma in there.
>>
>> 3. -Wno-stringop-truncation is the makefile
>>
>> Thoughts?
>>
>> -- 
> 
> 
> So here's approach 2. However I note that a newer gcc 8.2.1
> does not give this warning. Maybe detect at configure time
> and suppress (option 3)?

I prepared patches yesterday to fix this issue, I'll send to the list
soon. I used another approach, replacing strncpy() by strpadcpy(pad=0).

> diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
> index 3bf48bcdec..64d8258529 100644
> --- a/include/qemu/osdep.h
> +++ b/include/qemu/osdep.h
> @@ -134,6 +134,22 @@ extern int daemon(int, int);
>  #define assert(x)  g_assert(x)
>  #endif
>  
> +/*
> + * GCC 8.0 declared war on strncpy. Admittedly it's a tricky interface
> + * with unintuitive semantics, but we use it widely.
> + */
> +#if defined(__GNUC__) && __GNUC__ >= 8
> +static inline void qemu_strncpy(char *to, const char *from, int n)
> +{
> +#pragma GCC diagnostic push
> +#pragma GCC diagnostic ignored "-Wstringop-truncation"
> +    strncpy(to, from, n);
> +#pragma GCC diagnostic pop
> +}
> +
> +#define strncpy qemu_strncpy
> +#endif
> +
>  /*
>   * According to waitpid man page:
>   * WCOREDUMP
> 
