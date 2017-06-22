Received: from eggs.gnu.org ([2001:4830:134:3::10]:37806)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbutsykin@virtuozzo.com>) id 1dO2a3-0000El-6y
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 09:55:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbutsykin@virtuozzo.com>) id 1dO2Zy-0005Wu-8l
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 09:55:31 -0400
References: <20170613121639.17853-1-pbutsykin@virtuozzo.com>
	<20170613121639.17853-2-pbutsykin@virtuozzo.com>
	<b5367763-781e-0fdc-b9e7-fa6ee44ce66b@redhat.com>
From: Pavel Butsykin <pbutsykin@virtuozzo.com>
Message-ID: <e0966061-964c-95c5-20b2-904d651609dc@virtuozzo.com>
Date: Thu, 22 Jun 2017 16:54:12 +0300
MIME-Version: 1.0
In-Reply-To: <b5367763-781e-0fdc-b9e7-fa6ee44ce66b@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/4] qemu-img: add --shrink flag for
 resize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, eblake@redhat.com, armbru@redhat.com, den@openvz.org

On 22.06.2017 01:17, Max Reitz wrote:
> On 2017-06-13 14:16, Pavel Butsykin wrote:
>> The flag as additional precaution of data loss. Perhaps in the future the
>> operation shrink without this flag will be banned, but while we need to
>> maintain compatibility.
>>
>> Signed-off-by: Pavel Butsykin <pbutsykin@virtuozzo.com>
>> ---
>>   qemu-img-cmds.hx       |  4 ++--
>>   qemu-img.c             | 15 +++++++++++++++
>>   qemu-img.texi          |  5 ++++-
>>   tests/qemu-iotests/102 |  4 ++--
>>   4 files changed, 23 insertions(+), 5 deletions(-)
>>
>> diff --git a/qemu-img-cmds.hx b/qemu-img-cmds.hx
>> index a39fcdba71..3b2eab9d20 100644
>> --- a/qemu-img-cmds.hx
>> +++ b/qemu-img-cmds.hx
>> @@ -76,9 +76,9 @@ STEXI
>>   ETEXI
>>   
>>   DEF("resize", img_resize,
>> -    "resize [--object objectdef] [--image-opts] [-q] filename [+ | -]size")
>> +    "resize [--object objectdef] [--image-opts] [-q] [--shrink] filename [+ | -]size")
>>   STEXI
>> -@item resize [--object @var{objectdef}] [--image-opts] [-q] @var{filename} [+ | -]@var{size}
>> +@item resize [--object @var{objectdef}] [--image-opts] [-q] [--shrink] @var{filename} [+ | -]@var{size}
>>   ETEXI
>>   
>>   DEF("amend", img_amend,
>> diff --git a/qemu-img.c b/qemu-img.c
>> index 0ad698d7f1..bfe5f61b0b 100644
>> --- a/qemu-img.c
>> +++ b/qemu-img.c
>> @@ -61,6 +61,7 @@ enum {
>>       OPTION_FLUSH_INTERVAL = 261,
>>       OPTION_NO_DRAIN = 262,
>>       OPTION_TARGET_IMAGE_OPTS = 263,
>> +    OPTION_SHRINK = 264,
>>   };
>>   
>>   typedef enum OutputFormat {
>> @@ -3452,6 +3453,7 @@ static int img_resize(int argc, char **argv)
>>           },
>>       };
>>       bool image_opts = false;
>> +    bool shrink = false;
>>   
>>       /* Remove size from argv manually so that negative numbers are not treated
>>        * as options by getopt. */
>> @@ -3469,6 +3471,7 @@ static int img_resize(int argc, char **argv)
>>               {"help", no_argument, 0, 'h'},
>>               {"object", required_argument, 0, OPTION_OBJECT},
>>               {"image-opts", no_argument, 0, OPTION_IMAGE_OPTS},
>> +            {"shrink", no_argument, 0, OPTION_SHRINK},
>>               {0, 0, 0, 0}
>>           };
>>           c = getopt_long(argc, argv, ":f:hq",
>> @@ -3503,6 +3506,9 @@ static int img_resize(int argc, char **argv)
>>           case OPTION_IMAGE_OPTS:
>>               image_opts = true;
>>               break;
>> +        case OPTION_SHRINK:
>> +            shrink = true;
>> +            break;
>>           }
>>       }
>>       if (optind != argc - 1) {
>> @@ -3562,6 +3568,15 @@ static int img_resize(int argc, char **argv)
>>           goto out;
>>       }
>>   
>> +    if (total_size < blk_getlength(blk) && !shrink) {
>> +        qprintf(quiet, "Warning: shrinking of the image can lead to data loss. "
> 
> I think this should always be printed to stderr, even if quiet is true;
> especially considering we (or at least I) plan to make it mandatory.
>

OK.

>> +                       "Before performing shrink operation you must make sure "
> 
> *Before performaing a shrink operation

s/performaing/performing/

> Also, I'd rather use the imperative: "Before ... operation, make sure
> that the..."
> 
> (English isn't my native language either, but as far as I remember
> "must" is generally used for external influences. But it's not like a
> force of nature is forcing you to confirm there's no important data; you
> can just ignore this advice and see all of your non-backed-up childhood
> pictures go to /dev/null.)
>

Yes, It should be just a recommendation.

(As you might have already guessed, English isn't my native language too
:) I'm glad you are understanding. Really thanks for helping to improve
the text.)

>> +                       "that the shrink part of image doesn't contain important"
> 
> Hmm... I don't think "shrink part" really works.
> 
> Maybe the following would work better:
> 
>    Warning: Shrinking an image will delete all data beyond the shrunken
>    image's end. Before performing such an operation, make sure there is
>    no important data there.
> 
>> +                       " data.\n");
>> +        qprintf(quiet,
>> +                "If you don't want to see this message use --shrink option.\n");
> 
> You should make a note that --shrink may (and I hope it will) become
> necessary in the future, like:
> 
>    Using the --shrink option will suppress this message. Note that future
>    versions of qemu-img may refuse to shrink images without this option!
>

will fix.

>> +    }
>> +
>>       ret = blk_truncate(blk, total_size, &err);
>>       if (!ret) {
>>           qprintf(quiet, "Image resized.\n");
>> diff --git a/qemu-img.texi b/qemu-img.texi
>> index 5b925ecf41..c2b694cd00 100644
>> --- a/qemu-img.texi
>> +++ b/qemu-img.texi
>> @@ -499,7 +499,7 @@ qemu-img rebase -b base.img diff.qcow2
>>   At this point, @code{modified.img} can be discarded, since
>>   @code{base.img + diff.qcow2} contains the same information.
>>   
>> -@item resize @var{filename} [+ | -]@var{size}
>> +@item resize [--shrink] @var{filename} [+ | -]@var{size}
>>   
>>   Change the disk image as if it had been created with @var{size}.
>>   
>> @@ -507,6 +507,9 @@ Before using this command to shrink a disk image, you MUST use file system and
>>   partitioning tools inside the VM to reduce allocated file systems and partition
>>   sizes accordingly.  Failure to do so will result in data loss!
>>   
>> +If @code{--shrink} is specified, warning about data loss doesn't print for
>> +the shrink operation.
>> +
> 
> Maybe rather:
> 
> @code{--shrink} informs qemu-img that the user is certain about wanting
> to shrink an image and is aware that any data beyond the truncated
> image's end will be lost. Trying to shrink an image without this option
> results in a warning; future versions may make it an error.
>

good.

> The functional changes look good to me; even though I'd rather have it
> an error for qcow2 now (even if that means having to check the image
> format in img_resize(), and being inconsistent because you wouldn't need
> --shrink for raw, but for qcow2 you would). But, well, I'm not going to
> stop this series over that.
>

Why shrink for qcow2 image is dangerous, but for raw is not dangerous? I
think we should provide the same behavior for all formats. When --shrink
option will become necessary, it also should be the same for all image
formats.

> Max
> 
