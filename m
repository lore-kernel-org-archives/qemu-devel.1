Received: from eggs.gnu.org ([2001:4830:134:3::10]:56971)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dXUVj-0004Fl-1o
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 11:34:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dXUVh-0000Tv-Ug
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 11:34:07 -0400
References: <20170718003422.4497-1-jsnow@redhat.com>
	<20170718003422.4497-3-jsnow@redhat.com>
	<c04b638b-1f22-91ce-5297-1bb713f7f1e6@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <e5627ad4-89bc-a25e-3d14-12abc82f4e64@redhat.com>
Date: Tue, 18 Jul 2017 11:33:56 -0400
MIME-Version: 1.0
In-Reply-To: <c04b638b-1f22-91ce-5297-1bb713f7f1e6@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 2/2] qemu-img: Check for backing image
 if specified during create
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com



On 07/18/2017 08:51 AM, Eric Blake wrote:
> On 07/17/2017 07:34 PM, John Snow wrote:
>> Or, rather, force the open of a backing image if one was specified
>> for creation. Using a similar -unsafe option as rebase, allow qemu-img
>> to ignore the backing file validation if possible.
>>
>> It may not always be possible, as in the existing case when a filesize
>> for the new image was not specified.
>>
>> This is accomplished by shifting around the conditionals in
>> bdrv_img_create, such that a backing file is always opened unless we
>> provide BDRV_O_NO_BACKING. qemu-img is adjusted to pass this new flag
>> when -u is provided to create.
>>
>> Sorry for the heinous looking diffstat, but it's mostly whitespace.
> 
> This sentence is not quite as applicable as it was on earlier versions,
> as you now have added logic for determining which level (warning vs.
> error) to print.
> 
>>
>> Inspired by: https://bugzilla.redhat.com/show_bug.cgi?id=1213786
>>
>> Reviewed-by: Eric Blake <eblake@redhat.com>
> 
> Really? It seems like you've changed since v4.
> 

Duh. I missed this because the patchset grew to two patches, same with
revising the message. I'm sorry about that.

>> Signed-off-by: John Snow <jsnow@redhat.com>
>> ---
> 
>> +++ b/block.c
>> @@ -4396,55 +4396,65 @@ void bdrv_img_create(const char *filename, const char *fmt,
>>  
>>      backing_fmt = qemu_opt_get(opts, BLOCK_OPT_BACKING_FMT);
>>  
>> -    // The size for the image must always be specified, with one exception:
>> -    // If we are using a backing file, we can obtain the size from there
>> +    /* The size for the image must always be specified, unless we have a backing
>> +     * file and we have not been forbidden from opening it */
> 
> Worth adding a trailing '.' to the sentence?
> 

Sure, why not?

>>      size = qemu_opt_get_size(opts, BLOCK_OPT_SIZE, 0);
> 
> On v4, we talked about making this use qemu_opt_get_size(, -1) to make
> it less confusing about how qemu_opt_get_size() refers back to a
> caller-provided default embedded in QemuOpt (rather than the parameter).>

I actually got scared away from this because of the get_size signature,
is it safe to pass -1 here?

>> +        if (!bs && size != -1) {
>> +            /* Couldn't open BS, but we have a size, so it's nonfatal */
>> +            error_reportf_err(local_err,
>> +                              "Warning: could not verify backing image. "
>> +                              "This may become an error in future versions.\n");
> 
> Patchew rightly complained here about the trailing newline. Also, we
> have the new warning* functions merged in, this should probably be using
> those (see commit 3dc6f869, for example)
> 

I tried omitting it, but the printing looked wrong, and the test would
mash input against the tail of the sentence.

>> +            local_err = NULL;
>> +        } else if (!bs) {
>> +            /* Couldn't open bs, do not have size */
>> +            error_append_hint(&local_err,
>> +                              "Could not open backing image to determine size.\n");
>> +            goto out;
>> +        } else {
>> +            if (size == -1) {
>> +                /* Opened BS, have no size */
>> +                size = bdrv_getlength(bs);
>> +                if (size < 0) {
>> +                    error_setg_errno(errp, -size, "Could not get size of '%s'",
>> +                                     backing_file);
> 
> These look correct.
> 
>> +++ b/tests/qemu-iotests/111.out
>> @@ -1,3 +1,4 @@
>>  QA output created by 111
>>  qemu-img: TEST_DIR/t.IMGFMT: Could not open 'TEST_DIR/t.IMGFMT.inexistent': No such file or directory
>> +Could not open backing image to determine size.
> 
> Nice demonstration of the hint at work.
> 
> The rest of the patch looks fine to me.  We'll need a couple of tweaks,
> but between you, Kevin, and myself, I think we can coordinate getting
> something ready for a pull request today.
> 
