Received: from eggs.gnu.org ([2001:4830:134:3::10]:48105)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <keno@juliacomputing.com>) id 1fOQK6-0005v9-QT
	for qemu-devel@nongnu.org; Thu, 31 May 2018 12:21:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <keno@juliacomputing.com>) id 1fOQK6-0000Ca-1m
	for qemu-devel@nongnu.org; Thu, 31 May 2018 12:21:10 -0400
Received: from mail-pl0-x232.google.com ([2607:f8b0:400e:c01::232]:45250)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <keno@juliacomputing.com>)
	id 1fOQK5-0000Ak-Rt
	for qemu-devel@nongnu.org; Thu, 31 May 2018 12:21:09 -0400
Received: by mail-pl0-x232.google.com with SMTP id c23-v6so2224833plz.12
	for <qemu-devel@nongnu.org>; Thu, 31 May 2018 09:21:09 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180529222558.59230642@bahia.lan>
References: <cover.1527310210.git.keno@alumni.harvard.edu>
	<6205f39b495ee7356478cc53faf5e32289f57182.1527310210.git.keno@alumni.harvard.edu>
	<20180529222558.59230642@bahia.lan>
From: Keno Fischer <keno@juliacomputing.com>
Date: Thu, 31 May 2018 12:20:28 -0400
Message-ID: <CABV8kRwhz_WhkjZzqQXXTTwRL_sLNftHAnw9LjMCbkZMLiU4Tg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 05/13] 9p: darwin: Handle struct dirent
 differences
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Keno Fischer <keno@alumni.harvard.edu>

>> diff --git a/hw/9pfs/9p-synth.c b/hw/9pfs/9p-synth.c
>> index eb68b42..3c0a6d8 100644
>> --- a/hw/9pfs/9p-synth.c
>> +++ b/hw/9pfs/9p-synth.c
>> @@ -221,7 +221,11 @@ static void synth_direntry(V9fsSynthNode *node,
>>  {
>>      strcpy(entry->d_name, node->name);
>>      entry->d_ino = node->attr->inode;
>> +#ifdef CONFIG_DARWIN
>> +    entry->d_seekoff = off + 1;
>
> Hmm... what's that for ? No users in the patchset and the comment
> below seem to indicate this wouldn't be trusted anyway.

d_off isn't available on Darwin, so an appropriate ifdef
is required here anyway. I figured if the offset is available
anyway, I might as well set it, but I can drop
this code path if you would prefer.

>> +        off_t off = v9fs_co_telldir(pdu, fidp);
>
> Please declare local variables at the beginning of the function. Also,
> v9fs_co_telldir() can fail. This requires proper error handling.

Will do.

>> +#else
>> +        off_t off = dent->d_off;
>> +#endif
>
> Please make this a helper and call it in v9fs_do_readdir_with_stat() as well.
>

Will do.
