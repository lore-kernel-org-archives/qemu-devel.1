Received: from eggs.gnu.org ([2001:4830:134:3::10]:59438)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gXFm9-0005uk-W1
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 20:26:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gXFm8-0005QU-Or
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 20:26:53 -0500
References: <20181212220410.569069-1-eblake@redhat.com>
	<CAMRbyyuZ81fyHYTQSHPXhjYoLFz6nzsxc30PNJdWRkqm=14RRA@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <526c4d1c-9ad5-e8dc-d2ba-c043a76749ab@redhat.com>
Date: Wed, 12 Dec 2018 19:26:27 -0600
MIME-Version: 1.0
In-Reply-To: <CAMRbyyuZ81fyHYTQSHPXhjYoLFz6nzsxc30PNJdWRkqm=14RRA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH RFC] qemu-io: Prefer stderr
 for error messages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nir Soffer <nsoffer@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, qemu-block <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>

On 12/12/18 5:52 PM, Nir Soffer wrote:
> On Thu, Dec 13, 2018 at 12:13 AM Eric Blake <eblake@redhat.com> wrote:
>>
>> When a qemu-io command fails, it's best if the failure message
>> goes to stderr rather than stdout.
> 
> This makes sense, but it will break users like this:
> 
> https://github.com/oVirt/vdsm/blob/a2836b1d58ffaa0f48cc9c814b6002161a81f044/tests/storage/qemuio.py#L45
> 
> We need a way to detect qemu-io verification failures, maybe a special
> exit code?
> 
> 0 - verification succeeded
> 1 - verification failed
> 2 - other error (e.g no such file)
> 
> Or, if qemu-io had a way to read data and write it to stdout, we could
> compare the data and avoid the need for special exit code.
> 

>> @@ -723,8 +725,8 @@ static int read_f(BlockBackend *blk, int argc, char **argv)
>>           print_cvtnum_err(count, argv[optind]);
>>           return count;
>>       } else if (count > BDRV_REQUEST_MAX_BYTES) {
>> -        printf("length cannot exceed %" PRIu64 ", given %s\n",
>> -               (uint64_t)BDRV_REQUEST_MAX_BYTES, argv[optind]);
>> +        fprintf(stderr, "length cannot exceed %" PRIu64 ", given %s\n",
>> +                (uint64_t)BDRV_REQUEST_MAX_BYTES, argv[optind]);
>>           return -EINVAL;
>>       }
>>
>> @@ -738,19 +740,22 @@ static int read_f(BlockBackend *blk, int argc, char **argv)
>>       }
>>
>>       if ((pattern_count < 0) || (pattern_count + pattern_offset > count))  {
>> -        printf("pattern verification range exceeds end of read data\n");
>> +        fprintf(stderr,
>> +                "pattern verification range exceeds end of read data\n");
>>           return -EINVAL;

Note that 'read -P ...' can fail for both pattern verification failure, 
and for other reasons, both before and after this patch. The only thing 
this patch is doing is changing where the failure messages are output. 
Or is your complaint that your existing code is already catering to 
older qemu that had 0 exit status, and parsing stdout for a specific 
string rather than trusting exit status, and now stdout won't have that 
specific string?  qemu-io is not quite as worried about backwards 
compatibility as qemu-img or qemu proper, but at least knowing what 
might break might help us design something more user-friendly.

Can you redirect qemu-io to output both stdout and stderr to the same 
file, if you have to parse the answers to learn if verification has failed?

And your idea of having distinguished error codes for verification fail 
vs. overall failure makes some sense, but it would require some major 
rework (right now, returning -errno codes does not really tell the 
caller what exit status to report).

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
