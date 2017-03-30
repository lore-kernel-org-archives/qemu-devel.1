Received: from eggs.gnu.org ([2001:4830:134:3::10]:50487)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ctTwO-00043k-Em
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 02:52:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ctTwM-0000tN-TX
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 02:52:16 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1490805920-17029-1-git-send-email-armbru@redhat.com>
	<1490805920-17029-5-git-send-email-armbru@redhat.com>
	<5e1790e7-5e12-adc6-a049-ca004682025d@redhat.com>
Date: Thu, 30 Mar 2017 08:52:05 +0200
In-Reply-To: <5e1790e7-5e12-adc6-a049-ca004682025d@redhat.com> (Max Reitz's
	message of "Wed, 29 Mar 2017 21:33:35 +0200")
Message-ID: <87fuhvfe96.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [for-2.9 4/8] block: Document -drive problematic
 code and bugs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, qemu-block@nongnu.org, mitake.hitoshi@lab.ntt.co.jp, jcody@redhat.com, pbonzini@redhat.com, namei.unix@gmail.com

Max Reitz <mreitz@redhat.com> writes:

> On 29.03.2017 18:45, Markus Armbruster wrote:
>> -blockdev and blockdev_add convert their arguments via QObject to
>> BlockdevOptions for qmp_blockdev_add(), which converts them back to
>> QObject, then to a flattened QDict.  The QDict's members are typed
>> according to the QAPI schema.
>> 
>> -drive converts its argument via QemuOpts to a (flat) QDict.  This
>> QDict's members are all QString.
>> 
>> Thus, the QType of a flat QDict member depends on whether it comes
>> from -drive or -blockdev/blockdev_add, except when the QAPI type maps
>> to QString, which is the case for 'str' and enumeration types.
>> 
>> The block layer core extracts generic configuration from the flat
>> QDict, and the block driver extracts driver-specific configuration.
>> 
>> Both commonly do so by converting (parts of) the flat QDict to
>> QemuOpts, which turns all values into strings.  Not exactly elegant,
>> but correct.
>> 
>> However, A few places access the flat QDict directly:
>> 
>> * Most of them access members that are always QString.  Correct.
>> 
>> * bdrv_open_inherit() accesses a boolean, carefully.  Correct.
>> 
>> * nfs_config() uses a QObject input visitor.  Correct only because the
>>   visited type contains nothing but QStrings.
>> 
>> * nbd_config() and ssh_config() use a QObject input visitor, and the
>>   visited types contain non-QStrings: InetSocketAddress members
>>   @numeric, @to, @ipv4, @ipv6.  -drive works as long as you don't try
>>   to use them (they're all optional).  @to is ignored anyway.
>> 
>>   Reproducer:
>>   -drive driver=ssh,server.host=h,server.port=22,server.ipv4,path=p
>>   -drive driver=nbd,server.type=inet,server.data.host=h,server.data.port=22,server.data.ipv4
>>   both fail with "Invalid parameter type for 'data.ipv4', expected: boolean"
>> 
>> Add suitable comments to all these places.  Mark the buggy ones FIXME.
>> 
>> "Fortunately", -drive's driver-specific options are entirely
>> undocumented.
>> 
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  block.c            | 41 +++++++++++++++++++++++++++++++++++++++--
>>  block/file-posix.c |  6 ++++++
>>  block/nbd.c        |  8 ++++++++
>>  block/nfs.c        |  7 +++++++
>>  block/rbd.c        |  6 ++++++
>>  block/ssh.c        |  8 ++++++++
>>  6 files changed, 74 insertions(+), 2 deletions(-)
>
> I have to say I don't like how the comments in block.c are completely
> generic.

I'm afraid they reflect my rather "generic" understanding of block.c.

>> diff --git a/block.c b/block.c
>> index 6e906ec..b3ce23f 100644
>> --- a/block.c
>> +++ b/block.c
>> @@ -1157,6 +1157,12 @@ static int bdrv_open_common(BlockDriverState *bs, BlockBackend *file,
>>      if (file != NULL) {
>>          filename = blk_bs(file)->filename;
>>      } else {
>> +       /*
>> +        * Caution: direct use of non-string @options members is
>> +        * problematic.  When they come from -blockdev or blockdev_add,
>> +        * members are typed according to the QAPI schema, but when
>> +        * they come from -drive, they're all QString.
>> +        */
>>          filename = qdict_get_try_str(options, "filename");
>
> For instance this one: Well, yes, for -drive, this will always be a
> QString. Which is OK, because that's what we're trying to get.
>
> The comment makes this confusing, IMO. If you really want a comment here
> it should at least contain a mention that it's totally fine in practice
> here. Calling the code "problematic" sounds like this could blow up when
> it reality it can't; and I would think it actually is the most sane
> solution given the current state of the whole infrastructure (i.e. how
> -drive and -blockdev work).

Well, if it could blow up, I'd call it wrong, and start the comment with
FIXME :)

Even though qdict_get_try_str() is indeed fine, I propose to have a
comment, because someone with less detailed understanding of how the
configuration machine works (me, until yesterday, and probably again
after next month) could conclude that qdict_get_try_bool() would be just
as fine.

What about:

   /*
    * Caution: while qdict_get_try_str() is fine, getting non-string
    * types would require more care.  When @options come from -blockdev
    * or blockdev_add, its members are typed according to the QAPI
    * schema, but when they come from -drive, they're all QString.
    */

If you don't like this comment either, care to suggest one you do?

> Same for all the other plain qdict_get_try_str() calls (in block.c, at
> least).
>
>>      }
>>  
>> @@ -1324,6 +1330,12 @@ static int bdrv_fill_options(QDict **options, const char *filename,
>>      BlockDriver *drv = NULL;
>>      Error *local_err = NULL;
>>  
>> +    /*
>> +     * Caution: direct use of non-string @options members is
>> +     * problematic.  When they come from -blockdev or blockdev_add,
>> +     * members are typed according to the QAPI schema, but when they
>> +     * come from -drive, they're all QString.
>> +     */
>>      drvname = qdict_get_try_str(*options, "driver");
>>      if (drvname) {
>>          drv = bdrv_find_format(drvname);
>> @@ -1358,6 +1370,7 @@ static int bdrv_fill_options(QDict **options, const char *filename,
>>      }
>>  
>>      /* Find the right block driver */
>> +    /* Direct use of @options members is problematic, see note above */
>>      filename = qdict_get_try_str(*options, "filename");
>>  
>>      if (!drvname && protocol) {
>> @@ -1987,6 +2000,12 @@ int bdrv_open_backing_file(BlockDriverState *bs, QDict *parent_options,
>>      qdict_extract_subqdict(parent_options, &options, bdref_key_dot);
>>      g_free(bdref_key_dot);
>>  
>> +    /*
>> +     * Caution: direct use of non-string @parent_options members is
>> +     * problematic.  When they come from -blockdev or blockdev_add,
>> +     * members are typed according to the QAPI schema, but when they
>> +     * come from -drive, they're all QString.
>> +     */
>>      reference = qdict_get_try_str(parent_options, bdref_key);
>>      if (reference || qdict_haskey(options, "file.filename")) {
>>          backing_filename[0] = '\0';
>> @@ -2059,6 +2078,12 @@ bdrv_open_child_bs(const char *filename, QDict *options, const char *bdref_key,
>>      qdict_extract_subqdict(options, &image_options, bdref_key_dot);
>>      g_free(bdref_key_dot);
>>  
>> +    /*
>> +     * Caution: direct use of non-string @options members is
>> +     * problematic.  When they come from -blockdev or blockdev_add,
>> +     * members are typed according to the QAPI schema, but when they
>> +     * come from -drive, they're all QString.
>> +     */
>>      reference = qdict_get_try_str(options, bdref_key);
>>      if (!filename && !reference && !qdict_size(image_options)) {
>>          if (!allow_none) {
>> @@ -2275,8 +2300,11 @@ static BlockDriverState *bdrv_open_inherit(const char *filename,
>>      }
>>  
>>      /* Set the BDRV_O_RDWR and BDRV_O_ALLOW_RDWR flags.
>> -     * FIXME: we're parsing the QDict to avoid having to create a
>> -     * QemuOpts just for this, but neither option is optimal. */
>> +     * Caution: direct use of non-string @options members is
>> +     * problematic.  When they come from -blockdev or blockdev_add,
>> +     * members are typed according to the QAPI schema, but when they
>> +     * come from -drive, they're all QString.
>> +     */
>
> Now this one should mention that this is the very reason why we are
> attempting parsing the QDict string before getting a boolean value directly.

What about:

        /*
         * Set the BDRV_O_RDWR and BDRV_O_ALLOW_RDWR flags.
         * Caution: getting a boolean member of @options requires care.
         * When @options come from -blockdev or blockdev_add, members
         * are typed according to the QAPI schema, but when they come
         * from -drive, they're all QString.
         */

>>      if (g_strcmp0(qdict_get_try_str(options, BDRV_OPT_READ_ONLY), "on") &&
>>          !qdict_get_try_bool(options, BDRV_OPT_READ_ONLY, false)) {
>>          flags |= (BDRV_O_RDWR | BDRV_O_ALLOW_RDWR);
>> @@ -2298,6 +2326,7 @@ static BlockDriverState *bdrv_open_inherit(const char *filename,
>>      options = qdict_clone_shallow(options);
>>  
>>      /* Find the right image format driver */
>> +    /* Direct use of @options members is problematic, see note above */
>>      drvname = qdict_get_try_str(options, "driver");
>>      if (drvname) {
>>          drv = bdrv_find_format(drvname);
>> @@ -2309,6 +2338,7 @@ static BlockDriverState *bdrv_open_inherit(const char *filename,
>>  
>>      assert(drvname || !(flags & BDRV_O_PROTOCOL));
>>  
>> +    /* Direct use of @options members is problematic, see note above */
>>      backing = qdict_get_try_str(options, "backing");
>>      if (backing && *backing == '\0') {
>>          flags |= BDRV_O_NO_BACKING;
>> @@ -2787,6 +2817,13 @@ int bdrv_reopen_prepare(BDRVReopenState *reopen_state, BlockReopenQueue *queue,
>>          do {
>>              QString *new_obj = qobject_to_qstring(entry->value);
>>              const char *new = qstring_get_str(new_obj);
>> +           /*
>> +            * Caution: direct use of non-string bs->options members is
>> +            * problematic.  When they come from -blockdev or
>> +            * blockdev_add, members are typed according to the QAPI
>> +            * schema, but when they come from -drive, they're all
>> +            * QString.
>> +            */
>>              const char *old = qdict_get_try_str(reopen_state->bs->options,
>>                                                  entry->key);
>>  
>> diff --git a/block/file-posix.c b/block/file-posix.c
>> index 0841a08..738541e 100644
>> --- a/block/file-posix.c
>> +++ b/block/file-posix.c
>> @@ -2193,6 +2193,12 @@ static int hdev_open(BlockDriverState *bs, QDict *options, int flags,
>>      int ret;
>>  
>>  #if defined(__APPLE__) && defined(__MACH__)
>> +    /*
>> +     * Caution: direct use of non-string @options members is
>> +     * problematic.  When they come from -blockdev or blockdev_add,
>> +     * members are typed according to the QAPI schema, but when they
>> +     * come from -drive, they're all QString.
>> +     */
>>      const char *filename = qdict_get_str(options, "filename");
>
> This comment I'm very much OK with, though, because we should not
> retrieve runtime options directly from the QDict.
>
> (Same for the comments in the other block drivers.)
>
> Max
>
>>      char bsd_path[MAXPATHLEN] = "";
>>      bool error_occurred = false;
