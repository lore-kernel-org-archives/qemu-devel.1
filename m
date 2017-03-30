Received: from eggs.gnu.org ([2001:4830:134:3::10]:32887)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ctbKM-0003R2-OA
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 10:45:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ctbKL-0002Qy-Gf
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 10:45:30 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1490879707-6060-1-git-send-email-armbru@redhat.com>
	<1490879707-6060-5-git-send-email-armbru@redhat.com>
	<eb0d0ff3-7a5a-b052-54d7-f101f8eb53d8@redhat.com>
Date: Thu, 30 Mar 2017 16:45:21 +0200
In-Reply-To: <eb0d0ff3-7a5a-b052-54d7-f101f8eb53d8@redhat.com> (Eric Blake's
	message of "Thu, 30 Mar 2017 09:28:11 -0500")
Message-ID: <87wpb63jsu.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [RFC v2 for-2.9 04/10] block: Document -drive
 problematic code and bugs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, qemu-block@nongnu.org, mitake.hitoshi@lab.ntt.co.jp, jcody@redhat.com, mreitz@redhat.com, pbonzini@redhat.com, namei.unix@gmail.com

Eric Blake <eblake@redhat.com> writes:

> On 03/30/2017 08:15 AM, Markus Armbruster wrote:
>
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
>
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
> Did we get the latest round of comment tweaking in here?  I was
> expecting to see something along the lines of:
>
> "Caution: accessing 'filename' from @options here is safe, but direct
> use of any non-string @options members would be problematic.  When they
> come..."

I haven't updated this patch for review, yet.  One more reason this is
RFC.  Forgot to mention in the cover letter, sorry.

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
>
> Again, wordsmithing might be nice to call out that 'driver' is safe, but
> future additions of other accesses must be careful.

Yes.

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
>
> Again, wordsmithing to mention that bdref_key is safe.

Yes.

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
>
> Ditto.

Yes.

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
>>      if (g_strcmp0(qdict_get_try_str(options, BDRV_OPT_READ_ONLY), "on") &&
>>          !qdict_get_try_bool(options, BDRV_OPT_READ_ONLY, false)) {
>>          flags |= (BDRV_O_RDWR | BDRV_O_ALLOW_RDWR);
>
> Maybe here, the wordsmithing would mention that the extra hoops we jump
> through to cover both types is what makes access safe.

Yes.

>> +++ b/block/nbd.c
>> @@ -278,6 +278,14 @@ static SocketAddress *nbd_config(BDRVNBDState *s, QDict *options, Error **errp)
>>          goto done;
>>      }
>>  
>> +    /*
>> +     * FIXME .numeric, .to, .ipv4 or .ipv6 don't work with -drive
>> +     * server.type=inet.  .to doesn't matter, it's ignored anyway.
>> +     * That's because when @options come from -blockdev or
>> +     * blockdev_add, members are typed according to the QAPI schema,
>> +     * but when they come from -drive, they're all QString.  The
>> +     * visitor expects the former.
>> +     */
>
> This one is fine.
>
>>      iv = qobject_input_visitor_new(crumpled_addr);
>>      visit_type_SocketAddress(iv, NULL, &saddr, &local_err);
>>      if (local_err) {
>> diff --git a/block/nfs.c b/block/nfs.c
>> index 3f43f6e..42407de 100644
>> --- a/block/nfs.c
>> +++ b/block/nfs.c
>> @@ -474,6 +474,13 @@ static NFSServer *nfs_config(QDict *options, Error **errp)
>>          goto out;
>>      }
>>  
>> +    /*
>> +     * Caution: this works only because all scalar members of
>> +     * NFSServer are QString in @crumpled_addr.  The visitor expects
>> +     * @crumpled_addr to be typed according to the QAPI scherma.  It
>> +     * is when @options come from -blockdev or blockdev_add.  But when
>> +     * they come from -drive, they're all QString.
>> +     */
>>      iv = qobject_input_visitor_new(crumpled_addr);
>
> This one is also fine.
>
>>      visit_type_NFSServer(iv, NULL, &server, &local_error);
>>      if (local_error) {
>> diff --git a/block/rbd.c b/block/rbd.c
>> index 498322b..b9a9526 100644
>> --- a/block/rbd.c
>> +++ b/block/rbd.c
>> @@ -384,6 +384,12 @@ static int qemu_rbd_create(const char *filename, QemuOpts *opts, Error **errp)
>>          goto exit;
>>      }
>>  
>> +    /*
>> +     * Caution: direct use of non-string @options members is
>> +     * problematic.  When they come from -blockdev or blockdev_add,
>> +     * members are typed according to the QAPI schema, but when they
>> +     * come from -drive, they're all QString.
>
> Here, wordsmithing may be worth mentioning that we are safe because
> these are all strings.

Yes.

>> +     */
>>      pool       = qdict_get_try_str(options, "pool");
>>      conf       = qdict_get_try_str(options, "conf");
>>      clientname = qdict_get_try_str(options, "user");
>> diff --git a/block/ssh.c b/block/ssh.c
>> index 278e66f..471ba8a 100644
>> --- a/block/ssh.c
>> +++ b/block/ssh.c
>> @@ -601,6 +601,14 @@ static InetSocketAddress *ssh_config(QDict *options, Error **errp)
>>          goto out;
>>      }
>>  
>> +    /*
>> +     * FIXME .numeric, .to, .ipv4 or .ipv6 don't work with -drive.
>> +     * .to doesn't matter, it's ignored anyway.
>> +     * That's because when @options come from -blockdev or
>> +     * blockdev_add, members are typed according to the QAPI schema,
>> +     * but when they come from -drive, they're all QString.  The
>> +     * visitor expects the former.
>> +     */
>>      iv = qobject_input_visitor_new(crumpled_addr);
>
> This one's fine.
>
> The overall idea makes sense, but since this is still RFC, and there may
> still be wordsmithing to do, I'll wait to give R-b until v3.

Thanks!
