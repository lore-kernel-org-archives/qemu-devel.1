Received: from eggs.gnu.org ([2001:4830:134:3::10]:52072)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liam.merwick@oracle.com>) id 1gDbQx-0002wT-DT
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 16:31:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liam.merwick@oracle.com>) id 1gDbQu-00057V-3C
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 16:31:47 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:58074)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liam.merwick@oracle.com>)
	id 1gDbQt-00054r-PP
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 16:31:44 -0400
From: Liam Merwick <liam.merwick@oracle.com>
References: <1535739372-24454-1-git-send-email-Liam.Merwick@oracle.com>
	<1535739372-24454-6-git-send-email-Liam.Merwick@oracle.com>
	<371bf85d-8205-69a2-b67b-a41b5fda3a27@redhat.com>
Message-ID: <b53b219d-0e72-e080-e606-807e3ddd3d79@oracle.com>
Date: Fri, 19 Oct 2018 21:31:57 +0100
MIME-Version: 1.0
In-Reply-To: <371bf85d-8205-69a2-b67b-a41b5fda3a27@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 5/8] block: Fix potential Null pointer
 dereferences in vvfat.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org



On 12/10/18 16:14, Max Reitz wrote:
> On 31.08.18 20:16, Liam Merwick wrote:
>> The calls to bdrv_new_open_driver(), find_mapping_for_cluster(),
>> and array_get_next() may return NULL but it isn't always checked for
>> before dereferencing the value returned.
>>
>> Signed-off-by: Liam Merwick <Liam.Merwick@oracle.com>
>> Reviewed-by: Darren Kenny <Darren.Kenny@oracle.com>
>> Reviewed-by: Mark Kanda <Mark.Kanda@oracle.com>
>> ---
>>   block/vvfat.c | 56 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 56 insertions(+)
>>
>> diff --git a/block/vvfat.c b/block/vvfat.c
>> index fc41841a5c3c..0f1f10a2f94b 100644
>> --- a/block/vvfat.c
>> +++ b/block/vvfat.c
>> @@ -448,6 +448,9 @@ static direntry_t *create_long_filename(BDRVVVFATState *s, const char *filename)
>>   
>>       for(i=0;i<number_of_entries;i++) {
>>           entry=array_get_next(&(s->directory));
>> +        if (entry == NULL) {
>> +            continue;
>> +        }
> 
> This is a bug in array_ensure_allocated().  It uses g_realloc() with a
> non-zero size, so that function will never return NULL.  It will rather
> abort().
> 
> Therefore, array_ensure_allocated() cannot fail.  Consequentially,
> array_get_next() cannot fail.
> 


I've reverted this (and the rest of the 'As above' comments below)


>>           entry->attributes=0xf;
>>           entry->reserved[0]=0;
>>           entry->begin=0;
>> @@ -665,6 +668,9 @@ static inline void fat_set(BDRVVVFATState* s,unsigned int cluster,uint32_t value
>>       } else {
>>           int offset = (cluster*3/2);
>>           unsigned char* p = array_get(&(s->fat), offset);
>> +        if (p == NULL) {
>> +            return;
>> +        }
> 
> This is only reached if array_get_next() was called before.  Therefore,
> this cannot return NULL.
> 
> However, an assert(array->pointer); in array_get() can't hurt.


Done.

> 
>>           switch (cluster&1) {
>>           case 0:
>>                   p[0] = value&0xff;
>> @@ -730,6 +736,9 @@ static inline direntry_t* create_short_and_long_name(BDRVVVFATState* s,
>>   
>>       if(is_dot) {
>>           entry=array_get_next(&(s->directory));
>> +        if (entry == NULL) {
>> +            return NULL;
>> +        }
> 
> As above.
> 
>>           memset(entry->name, 0x20, sizeof(entry->name));
>>           memcpy(entry->name,filename,strlen(filename));
>>           return entry;
>> @@ -844,6 +853,12 @@ static int read_directory(BDRVVVFATState* s, int mapping_index)
>>           /* create mapping for this file */
>>           if(!is_dot && !is_dotdot && (S_ISDIR(st.st_mode) || st.st_size)) {
>>               s->current_mapping = array_get_next(&(s->mapping));
>> +            if (s->current_mapping == NULL) {
>> +                fprintf(stderr, "Failed to create mapping for file\n");
>> +                g_free(buffer);
>> +                closedir(dir);
>> +                return -2;
>> +            }
> 
> As above.
> 
>>               s->current_mapping->begin=0;
>>               s->current_mapping->end=st.st_size;
>>               /*
>> @@ -941,6 +956,9 @@ static int init_directories(BDRVVVFATState* s,
>>       /* add volume label */
>>       {
>>           direntry_t* entry=array_get_next(&(s->directory));
>> +        if (entry == NULL) {
>> +            return -1;
>> +        }
> 
> As above.
> 
>>           entry->attributes=0x28; /* archive | volume label */
>>           memcpy(entry->name, s->volume_label, sizeof(entry->name));
>>       }
>> @@ -953,6 +971,9 @@ static int init_directories(BDRVVVFATState* s,
>>       s->cluster_count=sector2cluster(s, s->sector_count);
>>   
>>       mapping = array_get_next(&(s->mapping));
>> +    if (mapping == NULL) {
>> +        return -1;
>> +    }
> 
> As above.
> 
>>       mapping->begin = 0;
>>       mapping->dir_index = 0;
>>       mapping->info.dir.parent_mapping_index = -1;
>> @@ -1630,6 +1651,9 @@ static void schedule_rename(BDRVVVFATState* s,
>>           uint32_t cluster, char* new_path)
>>   {
>>       commit_t* commit = array_get_next(&(s->commits));
>> +    if (commit == NULL) {
>> +        return;
>> +    }
> 
> As above.
> 
>>       commit->path = new_path;
>>       commit->param.rename.cluster = cluster;
>>       commit->action = ACTION_RENAME;
>> @@ -1639,6 +1663,9 @@ static void schedule_writeout(BDRVVVFATState* s,
>>           int dir_index, uint32_t modified_offset)
>>   {
>>       commit_t* commit = array_get_next(&(s->commits));
>> +    if (commit == NULL) {
>> +        return;
>> +    }
> 
> As above.
> 
>>       commit->path = NULL;
>>       commit->param.writeout.dir_index = dir_index;
>>       commit->param.writeout.modified_offset = modified_offset;
>> @@ -1649,6 +1676,9 @@ static void schedule_new_file(BDRVVVFATState* s,
>>           char* path, uint32_t first_cluster)
>>   {
>>       commit_t* commit = array_get_next(&(s->commits));
>> +    if (commit == NULL) {
>> +        return;
>> +    }
> 
> As above.
> 
>>       commit->path = path;
>>       commit->param.new_file.first_cluster = first_cluster;
>>       commit->action = ACTION_NEW_FILE;
>> @@ -1657,6 +1687,9 @@ static void schedule_new_file(BDRVVVFATState* s,
>>   static void schedule_mkdir(BDRVVVFATState* s, uint32_t cluster, char* path)
>>   {
>>       commit_t* commit = array_get_next(&(s->commits));
>> +    if (commit == NULL) {
>> +        return;
>> +    }
> 
> 
> As above.
> 
>>       commit->path = path;
>>       commit->param.mkdir.cluster = cluster;
>>       commit->action = ACTION_MKDIR;
>> @@ -2261,6 +2294,9 @@ static mapping_t* insert_mapping(BDRVVVFATState* s,
>>       }
>>       if (index >= s->mapping.next || mapping->begin > begin) {
>>           mapping = array_insert(&(s->mapping), index, 1);
>> +        if (mapping == NULL) {
>> +            return NULL;
>> +        }
> 
> I haven't checked array_insert()'s code for buffer overflows, but just
> like the other functions above, it cannot ever return NULL (unless
> array->item_size were 0, which it never is), because g_realloc() never
> returns NULL.


Reverted


> 
>>           mapping->path = NULL;
>>           adjust_mapping_indices(s, index, +1);
>>       }
>> @@ -2428,6 +2464,9 @@ static int commit_direntries(BDRVVVFATState* s,
>>       direntry_t* direntry = array_get(&(s->directory), dir_index);
>>       uint32_t first_cluster = dir_index == 0 ? 0 : begin_of_direntry(direntry);
>>       mapping_t* mapping = find_mapping_for_cluster(s, first_cluster);
>> +    if (mapping == NULL) {
>> +        return -1;
>> +    }
> 
> This looks like a real issue.  I'm not sufficiently proficient in vvfat
> to know whether this would warrant an assertion (it looks after the root
> directory, which probably just should be there), so I'm OK with just
> returning an error here.
> 
> However, qemu's codestyle forbids mixing statements with declarations,
> so this needs to be moved below all of the declarations that follow still.
>


Fixed


>>       int factor = 0x10 * s->sectors_per_cluster;
>>       int old_cluster_count, new_cluster_count;
>> @@ -2494,6 +2533,9 @@ DLOG(fprintf(stderr, "commit_direntries for %s, parent_mapping_index %d\n", mapp
>>           direntry = array_get(&(s->directory), first_dir_index + i);
>>           if (is_directory(direntry) && !is_dot(direntry)) {
>>               mapping = find_mapping_for_cluster(s, first_cluster);
>> +            if (mapping == NULL) {
>> +                return -1;
>> +            }
> 
> Looks OK.
> 
>>               assert(mapping->mode & MODE_DIRECTORY);
>>               ret = commit_direntries(s, first_dir_index + i,
>>                   array_index(&(s->mapping), mapping));
>> @@ -2522,6 +2564,10 @@ static int commit_one_file(BDRVVVFATState* s,
>>       assert(offset < size);
>>       assert((offset % s->cluster_size) == 0);
>>   
>> +    if (mapping == NULL) {
>> +        return -1;
>> +    }
>> +
> 
> Agreed.
> 
> (What's going on with the return values in this function?)
> 
>>       for (i = s->cluster_size; i < offset; i += s->cluster_size)
>>           c = modified_fat_get(s, c);
>>   
>> @@ -2668,6 +2714,9 @@ static int handle_renames_and_mkdirs(BDRVVVFATState* s)
>>           if (commit->action == ACTION_RENAME) {
>>               mapping_t* mapping = find_mapping_for_cluster(s,
>>                       commit->param.rename.cluster);
>> +            if (mapping == NULL) {
>> +                return -1;
>> +            }
>>               char* old_path = mapping->path;
> 
> Agreed, but needs to be moved below this declaration.

Done

> 
>>   
>>               assert(commit->path);
>> @@ -2692,6 +2741,9 @@ static int handle_renames_and_mkdirs(BDRVVVFATState* s)
>>                           if (is_file(d) || (is_directory(d) && !is_dot(d))) {
>>                               mapping_t* m = find_mapping_for_cluster(s,
>>                                       begin_of_direntry(d));
>> +                            if (m == NULL) {
>> +                                return -3;
>> +                            }
> 
> I wouldn't try to follow the weird style (unless you understand the
> reasoning behind it, which I don't). :-)
> 
> Just return either -1 or -EIO.
> 

I had tried to guess the sequence in the previous version but it was a 
lottery :-)
Will go with -1


>>                               int l = strlen(m->path);
>>                               char* new_path = g_malloc(l + diff + 1);
> 
> And again, needs to be moved below the declarations, although we don't
> want to do the g_malloc() before, of course.
> 


Done

>>   
>> @@ -3193,6 +3245,10 @@ static int enable_write_target(BlockDriverState *bs, Error **errp)
>>   
>>       backing = bdrv_new_open_driver(&vvfat_write_target, NULL, BDRV_O_ALLOW_RDWR,
>>                                      &error_abort);
>> +    if (!backing) {
>> +        ret = -EINVAL;
>> +        goto err;
>> +    }
> 
> This cannot return NULL because we pass &error_abort.  Therefore, qemu
> will abort before this function returns NULL.


I just added an assert instead.

Thanks for the review.

Regards,
Liam

> 
>>       *(void**) backing->opaque = s;
>>   
>>       bdrv_set_backing_hd(s->bs, backing, &error_abort);
>>
> 
> 
