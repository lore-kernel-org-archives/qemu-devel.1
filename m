Received: from eggs.gnu.org ([2001:4830:134:3::10]:53246)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1d6NtA-0004bp-5K
	for qemu-devel@nongnu.org; Thu, 04 May 2017 17:02:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1d6Nt8-00029R-Sl
	for qemu-devel@nongnu.org; Thu, 04 May 2017 17:02:16 -0400
References: <20170504193044.16303-1-jsnow@redhat.com>
	<d4850849-597b-ed09-ea43-b09621c0f5f0@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <e070fda5-61d5-3324-e45f-85e7020670a3@redhat.com>
Date: Thu, 4 May 2017 17:02:06 -0400
MIME-Version: 1.0
In-Reply-To: <d4850849-597b-ed09-ea43-b09621c0f5f0@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] qemu-img: Check for backing image if
 specified during create
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



On 05/04/2017 03:58 PM, Eric Blake wrote:
> On 05/04/2017 02:30 PM, John Snow wrote:
>> Or, rather, force the open of a backing image if one was specified
>> for creation. Using a similar -unsafe option as rebase, allow qemu-img
>> to ignore the backing file validation if possible.
>>
>> It may not always be possible, as in the existing case of if a filesize
> 
> s/of if/when/
> 

That makes sense!

>> for the new image was not specified.
>>
>> This is accomplished by shifting around the conditionals in
>> bdrv_img_create, such that a backing file is always opened unless we
>> provide BDRV_O_NO_BACKING. qemu-img is adjusted to pass this new flag
>> when -u is provided to create.
>>
>> Sorry for the heinous looking diffstat, but it's mostly whitespace.
>>
> 
> Indeed, reviewing under 'git diff -b' proved fruitful.
> 
>> Inspired by: https://bugzilla.redhat.com/show_bug.cgi?id=1213786
>>
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> ---
>>  block.c                    | 75 +++++++++++++++++++++++-----------------------
>>  qemu-img-cmds.hx           |  4 +--
> 
> Conflicts with the documentation patch for [-b backing_file] (already on
> PULL request:
> https://lists.gnu.org/archive/html/qemu-devel/2017-04/msg05816.html
> 
> so you'll have to rebase, but it shouldn't be too difficult.
> 

OK, not a problem.

>>  qemu-img.c                 | 15 ++++++----
>>  tests/qemu-iotests/082     |  4 +--
>>  tests/qemu-iotests/082.out |  4 +--
>>  5 files changed, 54 insertions(+), 48 deletions(-)
>>
>> diff --git a/block.c b/block.c
>> index 5db266b..da28052 100644
>> --- a/block.c
>> +++ b/block.c
>> @@ -4280,38 +4280,38 @@ void bdrv_img_create(const char *filename, const char *fmt,
>>      // The size for the image must always be specified, with one exception:
>>      // If we are using a backing file, we can obtain the size from there
>>      size = qemu_opt_get_size(opts, BLOCK_OPT_SIZE, 0);
>> -    if (size == -1) {
> 
> Wait. How does this even work?  qemu_opt_get_size() returns an unsigned
> value, either what was specified by the option, or else the default
> parameter (which  we passed as 0), so how can size ever be -1?  It might
> make sense if we had called:
> 
> size = qemu_opt_get_size(opts, BLOCK_OPT_SIZE, -1);
> 
> with the intent of allowing an explicit size of 0.  But I'm lost as to
> how this code ever worked pre-patch...
> 
> 
>> +
>> +        if (size == -1) {
> 
> ...which therefore carries over to the state of things post-patch.
> 
> /me goes and reads code
> 
> What?
> if (desc && desc->def_value_str) {
>   parse_option_size(name, desc->def_value_str, &ret, &error_abort);
>   return ret;
> 
> Oh - so THAT's how: qemu_opt_get_size_helper() ignores the 'defval'
> input and instead returns a DIFFERENT default associated with the
> QemuOpts. UGLY.  But not your fault.
> 

It's certainly not ideal.

>> +++ b/qemu-img.c
>> @@ -145,9 +145,10 @@ static void QEMU_NORETURN help(void)
>>             "  'snapshot_id_or_name' is deprecated, use 'snapshot_param'\n"
>>             "    instead\n"
>>             "  '-c' indicates that target image must be compressed (qcow format only)\n"
>> -           "  '-u' enables unsafe rebasing. It is assumed that old and new backing file\n"
>> -           "       match exactly. The image doesn't need a working backing file before\n"
>> -           "       rebasing in this case (useful for renaming the backing file)\n"
>> +           "  '-u' allows unsafe backing chains. For rebasing, it is assumed that old and new \n"
>> +           "       backing file match exactly. The image doesn't need a working backing file \n"
>> +           "       before rebasing in this case (useful for renaming the backing file)\n"
>> +           "       For image creation, allow creating without attempting to open the file.\n"
> 
> maybe s/to open the file/to open the backing file/
> 

Yeah, this is a little messy, so I am relying on feedback on the
documentation.

>> +++ b/tests/qemu-iotests/082
>> @@ -85,8 +85,8 @@ run_qemu_img create -f $IMGFMT -o cluster_size=4k -o help "$TEST_IMG" $size
>>  run_qemu_img create -f $IMGFMT -o cluster_size=4k -o \? "$TEST_IMG" $size
>>  
>>  # Looks like a help option, but is part of the backing file name
>> -run_qemu_img create -f $IMGFMT -o backing_file="$TEST_IMG",,help "$TEST_IMG" $size
>> -run_qemu_img create -f $IMGFMT -o backing_file="$TEST_IMG",,\? "$TEST_IMG" $size
>> +run_qemu_img create -f $IMGFMT -u -o backing_file="$TEST_IMG",,help "$TEST_IMG" $size
>> +run_qemu_img create -f $IMGFMT -u -o backing_file="$TEST_IMG",,\? "$TEST_IMG" $size
> 
> Nice test of the new usage.
> > I like where it's headed.  It will need a v2 to rebase and fix the
> things I pointed out, but I'm looking forward to it.
> 

Sure. Only concern I have is I am not actually sure if passing
BDRV_O_NO_BACKING through has any other effect -- I don't THINK it does,
but there's a lot of things I think sometimes.

Thanks,
--js
