Received: from eggs.gnu.org ([2001:4830:134:3::10]:35132)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <simon@ruderich.org>) id 1f6AJB-0006Z3-Qv
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 03:36:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <simon@ruderich.org>) id 1f6AJ6-0003dX-U0
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 03:36:45 -0400
Received: from zucker2.schokokeks.org ([178.63.68.90]:50617)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <simon@ruderich.org>) id 1f6AJ6-0003c1-LO
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 03:36:40 -0400
Date: Wed, 11 Apr 2018 09:36:38 +0200
From: Simon Ruderich <simon@ruderich.org>
Message-ID: <20180411073638.GA10940@ruderich.org>
References: <0e59c79ddc01e195ddc59d77d9df2b95bf89b600.1523395243.git.simon@ruderich.org>
	<0a960aa8-2a3f-8667-3d46-cecf8e65e482@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <0a960aa8-2a3f-8667-3d46-cecf8e65e482@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qmp: add pmemload command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org

On Tue, Apr 10, 2018 at 04:33:03PM -0500, Eric Blake wrote:
>> +void qmp_pmemload(int64_t addr, int64_t size, const char *filename,
>> +                  Error **errp)
>> +{
>> +    FILE *f;
>> +    size_t l;
>> +    uint8_t buf[1024];
>> +
>> +    f = fopen(filename, "rb");
>
> Use qemu_fopen() here, so that you can automagically support /dev/fdset/
> magic filenames that work on file descriptors passed via SCM_RIGHTS.

Hello,

I can't find qemu_fopen() in the source. Did you mean
qemu_open()? From reading qemu_close() I guess that I can't use
fdopen() (as there's no qemu_fclose()) but must work with the raw
fd. Or is there an easy way to fdopen? (I prefer the FILE *
interface which is easier to work with.)

But I just copied the code from qmp_pmemsave. Should I change it
as well to use qemu_open()?

>> +++ b/qapi-schema.json
>> @@ -1136,6 +1136,24 @@
>>  { 'command': 'pmemsave',
>>    'data': {'val': 'int', 'size': 'int', 'filename': 'str'} }
>>
>> +##
>> +# @pmemload:
>> +#
>> +# Load a portion of guest physical memory from a file.
>> +#
>> +# @val: the physical address of the guest to start from
>
> Is 'val' really the best name for this, or would 'phys-addr' or similar
> be a more descriptive name?

I copied it from pmemsave to keep the argument names consistent.
Should I change it only for pmemload? Changing it for pmemsave is
problematic as it will break the existing API.

>> +#
>> +# @size: the size of memory region to load
>> +#
>> +# @filename: the file to load the memory from as binary data
>> +#
>> +# Returns: Nothing on success
>> +#
>> +# Since: 2.10
>
> You've missed 2.10 by a long shot.  The earliest this new feature could
> appear is 2.13.

Will change.

> Do you additionally need an offset where to start reading from within
> the file (that is, since you already have the 'size' parameter to avoid
> reading the entire file, and the 'val' parameter to target anywhere in
> physical memory, how do I start reading anywhere from the file)?

I didn't need it for my usage and wanted to keep the patch as
simple as possible. But I see how it can be useful and will add
it to my patch in the next iteration.

Thank you for the review!

Regards
Simon
-- 
+ privacy is necessary
+ using gnupg http://gnupg.org
+ public key id: 0x92FEFDB7E44C32F9
