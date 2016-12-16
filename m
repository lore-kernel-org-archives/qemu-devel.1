Received: from eggs.gnu.org ([2001:4830:134:3::10]:58642)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cHsvQ-00078v-40
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 08:51:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cHsvP-0003fZ-5L
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 08:51:52 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <090c4fe2-7ed6-e993-5fe8-df4dda79d85e@redhat.com>
References: <20161130011851.24696-1-mreitz@redhat.com>
	<20161130011851.24696-8-mreitz@redhat.com>
	<w51lgvhdu4d.fsf@maestria.local.igalia.com>
	<090c4fe2-7ed6-e993-5fe8-df4dda79d85e@redhat.com>
Date: Fri, 16 Dec 2016 14:51:41 +0100
Message-ID: <w51bmwc56du.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 07/25] block:
 bdrv_get_full_backing_filename's ret. val.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>

On Fri 16 Dec 2016 02:26:29 PM CET, Max Reitz wrote:

>>>  int bdrv_open_backing_file(BlockDriverState *bs, QDict *parent_options,
>>>                             const char *bdref_key, Error **errp)
>>>  {
>>> -    char *backing_filename = g_malloc0(PATH_MAX);
>>> +    char *backing_filename = NULL;
>>>      char *bdref_key_dot;
>>>      const char *reference = NULL;
>>>      int ret = 0;
>>> @@ -1511,7 +1505,7 @@ int bdrv_open_backing_file(BlockDriverState *bs, QDict *parent_options,
>>>  
>>>      reference = qdict_get_try_str(parent_options, bdref_key);
>>>      if (reference || qdict_haskey(options, "file.filename")) {
>>> -        backing_filename[0] = '\0';
>>> +        backing_filename = NULL;
>> 
>> You're making it NULL, but it's NULL already.
>
> Yes, so I hope the compiler can optimize it away. :-)
>
> I initialized it to NULL here to make it more clear that under the
> given condition we do not have a backing filename (so that it's clear
> from a single look at this if-else block what exactly happens in each
> case without having to know the state of variables beforehand).

Ok, I suspected that. Even if we keep it, I think it wouldn't be bad to
leave a comment saying that it's there on purpose and it's not being set
twice accidentally.

Otherwise whoever reads that code in the future might think that it's a
sign of a merge that wasn't carefully reviewed.

But I won't oppose if you prefer to leave it like that.

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
