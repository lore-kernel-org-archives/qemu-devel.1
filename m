Received: from eggs.gnu.org ([2001:4830:134:3::10]:58488)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1cjvHl-0004zk-S3
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 17:02:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1cjvHi-0000bU-Q1
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 17:02:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33922)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1cjvHi-0000bF-HI
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 17:02:46 -0500
References: <20170303135150.12145-1-stefanha@redhat.com>
	<CAMRbyysV54S0Sn42WuYFKfNSTMzQxk1yf1PSdrYXSUhiVr9Jjg@mail.gmail.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <f8913ef5-b949-c330-1737-9382e31dcc48@redhat.com>
Date: Fri, 3 Mar 2017 17:02:44 -0500
MIME-Version: 1.0
In-Reply-To: <CAMRbyysV54S0Sn42WuYFKfNSTMzQxk1yf1PSdrYXSUhiVr9Jjg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC 0/4] qemu-img: add max-size subcommand
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nir Soffer <nsoffer@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Maor Lipchuk <mlipchuk@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Alberto Garcia <berto@igalia.com>



On 03/03/2017 04:38 PM, Nir Soffer wrote:
> On Fri, Mar 3, 2017 at 3:51 PM, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>>
>> RFCv1:
>>  * Publishing patch series with just raw support, no qcow2 yet.  Please review
>>    the command-line interface and let me know if you are happy with this
>>    approach.
>>
>> Users and management tools sometimes need to know the size required for a new
>> disk image so that an LVM volume, SAN LUN, etc can be allocated ahead of time.
>> Image formats like qcow2 have non-trivial metadata that makes it hard to
>> estimate the exact size without knowledge of file format internals.
>>
>> This patch series introduces a new qemu-img subcommand that calculates the
>> required size for both image creation and conversion scenarios.
>>
>> The conversion scenario is:
>>
>>   $ qemu-img max-size -f raw -O qcow2 input.img
>>   107374184448
> 
> Isn't this the minimal size required to convert input.img?
> 

It's an upper bound for the property being measured, which is current
allocation size, not maximum potential size after growth.

>>
>> Here an existing image file is taken and the output includes the space required
>> for data from the input image file.
>>
>> The creation scenario is:
>>
>>   $ qemu-img max-size -O qcow2 --size 5G
>>   196688
> 
> Again, this is the minimal size.
> 
> So maybe use min-size?
> 
> Or:
> 
>     qemu-img measure -f raw -O qcow2 input.img
> 
> Works nicely with other verbs like create, convert, check.
> 

Measure what? This is strictly less descriptive even if "max-size" isn't
a verb.

> Now about the return value, do we want to return both the minimum size
> and the maximum size?
> 
> For ovirt use case, we currently calculate the maximum size by multiplying
> by 1.1. We use this when doing automatic extending of ovirt thin provisioned
> disk. We start with 1G lv, and extend it each time it becomes full, stopping
> when we reach virtual size * 1.1. Using more accurate calculation instead
> can be nicer.
> 
> So we can retrun:
> 
> {
>     "min-size": 196688,
>     "max-size": 5905580032
> }
> 
> Anyway thanks for working on this!
> 

It sounds like you want something different from what was intuited by
Maor Lipchuck. There are two things to estimate:

(A) An estimate of the possible size of an image after conversion to a
different format, and
(B) An estimate of the possible size after full allocation.

I got the sense that Maor was asking for (A), but perhaps I am wrong
about that. However, both are "maximums" in different senses.

--js

>>
>> Stefan Hajnoczi (4):
>>   block: add bdrv_max_size() API
>>   raw-format: add bdrv_max_size() support
>>   qemu-img: add max-size subcommand
>>   iotests: add test 178 for qemu-img max-size
>>
>>  include/block/block.h      |   2 +
>>  include/block/block_int.h  |   2 +
>>  block.c                    |  37 +++++++++
>>  block/raw-format.c         |  16 ++++
>>  qemu-img.c                 | 196 +++++++++++++++++++++++++++++++++++++++++++++
>>  qemu-img-cmds.hx           |   6 ++
>>  tests/qemu-iotests/178     |  75 +++++++++++++++++
>>  tests/qemu-iotests/178.out |  25 ++++++
>>  tests/qemu-iotests/group   |   1 +
>>  9 files changed, 360 insertions(+)
>>  create mode 100755 tests/qemu-iotests/178
>>  create mode 100644 tests/qemu-iotests/178.out
>>
>> --
>> 2.9.3
>>
